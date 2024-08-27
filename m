Return-Path: <netdev+bounces-122460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919F4961675
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B50B28562A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 18:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4163E1D2F7C;
	Tue, 27 Aug 2024 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sIADUbl8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174301CCB4A;
	Tue, 27 Aug 2024 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724782105; cv=none; b=pp6ZAWLwZHtIhuWWkjeZmgVxza1ilQtXppaXrJmweaddzN7uF7d1dV9c+AIQshaVWFFFJjIEqqN7wugwxb+ScAjbhBLjgXCeKOkknJnPtmG1+AZcaAacS87zMYoTluFMj99MDeyjrOySOHMTCvFqqEJ9Qn15sQQIrK6tqHxDBSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724782105; c=relaxed/simple;
	bh=Z8c1CnaT9dzcVhpBg3mnFtwCxJaP/wVOMa8sLjoNL4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRWqvQAFCUmJSbuxdgzPd7dY8e6Pv1sro7fgZ+wmfDCqDJT4pdxHa/Io0rH5Nqj/u8n4Bh+nN37QZSjOq4bFzuDEDFFy0Dd1eKrPpctGGOOcJKqITVTkGXlmGW5/kVmw3xzWsmcfYzkxfmJ+ZlV1bigbG2n06HxTdYcloTfUX04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sIADUbl8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0C0C4AF16;
	Tue, 27 Aug 2024 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724782103;
	bh=Z8c1CnaT9dzcVhpBg3mnFtwCxJaP/wVOMa8sLjoNL4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sIADUbl8KhYtLkuaVhUIhn0m4G03JR7F6ckJQ0fmvOyvfiaQ13Ka7EKM/pW4eFeug
	 VTg+jlk2Dj85rIsLb3SHE1Eo+ECvSDYPEUnLltEExqUr7btu0oY6VfF2Z0VN3rujEW
	 l1Tx1Hl6tLHfs5OgPXtx6UzWYNP6Y8dCQftV7smoGe4OVj6J6u3GrrZWFNgvZnYJTf
	 gKjF0zmSXbIz+p9wYBUq5/EilyrmEj4c7BVPMHruRZ0k/PaEr6AZaBwlLkBHzPx5gz
	 tQqPP8b87nauL5zTVkhvtnfjy7RJuO94xjD08jgzvMe9i1UAJz+XJamIXbp99IpMoz
	 OrAOvX7aomtbg==
Date: Tue, 27 Aug 2024 19:08:19 +0100
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RESEND 1/3] net: hisilicon: hip04: fix OF node
 leak in probe()
Message-ID: <20240827180819.GT1368797@kernel.org>
References: <20240827144421.52852-1-krzysztof.kozlowski@linaro.org>
 <20240827144421.52852-2-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827144421.52852-2-krzysztof.kozlowski@linaro.org>

On Tue, Aug 27, 2024 at 04:44:19PM +0200, Krzysztof Kozlowski wrote:
> Driver is leaking OF node reference from
> of_parse_phandle_with_fixed_args() in probe().
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Simon Horman <horms@kernel.org>


