Return-Path: <netdev+bounces-96146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A71ED8C47E3
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 21:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4BFFB20DA4
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0EF79B7E;
	Mon, 13 May 2024 19:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6drc2CP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0058E58AD0;
	Mon, 13 May 2024 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715630105; cv=none; b=C22AdbHS3ogD7dByMf4CTwjJcPv3c5QjtaZo4OXUyJ5F5xKo3C0wvOv06c0K5r2R+V1GfZ0WzXADWEYZm59E67PRiy15/4hnIeFXk/5A+WJSRAawhR/HAaI67L4mleYlDSgt94Ky0zrC+DJKjNaMR73jmRpez+U5IsaQV52quXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715630105; c=relaxed/simple;
	bh=IkLUVPUe2JxomMky8U3xB6zxLV0N3W5/jahjh5ZToDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZUZulGvkwtCQK5MtnaBwE+ngCvZJbH2SSdB4rEmbBXiKBQw+/bLLa6IM0kQUTevf+qFXpvsky99YUAPhWiYffZkqqywLPdY418pLkVHXx/9/6mFdlgvvLZp2qIiOloGZ9cuXhCA3kWdL5tu7KYrxOPul7WUiKXXGvLEhrZJ+2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6drc2CP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AA4C113CC;
	Mon, 13 May 2024 19:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715630104;
	bh=IkLUVPUe2JxomMky8U3xB6zxLV0N3W5/jahjh5ZToDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G6drc2CPVlXHQEcRZcWx9PgtVbyu4N5CHZdMzBpZunFtAQ84ug4h0snqrOjQ1/uUt
	 cfiHVwVsVrX4hA6KWoCU2KASNpH1d8GF/3wFnxsQDY92zjyVSvYszwTWfz2xveLKig
	 gMRtUs+AE7jyFbMonxAJ/Xgps5FLccP39DCbB6sVGbw+XOjlGLV+zA7iumyXMcL2Cb
	 54PgvNPFkDJAerKoU+kwcbuofuEzQFuX45hey1i9SujHD4du05+zMoFBpVSB4IS3hm
	 TVYnSNxoSDqSA1MjfKZHrxgxmjXakVqbXo2Aiaod6Dvt104GoTVd/tNZ15IWv2FjIi
	 KMsEDp5P7Z42g==
Date: Mon, 13 May 2024 20:54:59 +0100
From: Simon Horman <horms@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	richardcochran@gmail.com, andrew@lunn.ch, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
Message-ID: <20240513195459.GX2787@kernel.org>
References: <20240513015127.961360-1-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513015127.961360-1-wei.fang@nxp.com>

On Mon, May 13, 2024 at 09:51:26AM +0800, Wei Fang wrote:
> The assignment of pps_enable is protected by tmreg_lock, but the read
> operation of pps_enable is not. So the Coverity tool reports a lock
> evasion warning which may cause data race to occur when running in a
> multithread environment. Although this issue is almost impossible to
> occur, we'd better fix it, at least it seems more logically reasonable,
> and it also prevents Coverity from continuing to issue warnings.
> 
> Fixes: 278d24047891 ("net: fec: ptp: Enable PPS output based on ptp clock")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Simon Horman <horms@kernel.org>


