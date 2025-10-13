Return-Path: <netdev+bounces-228688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EB5BD2461
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 11:24:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C4193BEA56
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 09:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DEF12FD7B3;
	Mon, 13 Oct 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cvaMVf8N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222E22FD1B6;
	Mon, 13 Oct 2025 09:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760347412; cv=none; b=sE42F5Pef7+Od4L6IvFMRrsTDkuIHk7SqmGxI67SPRDi7oxlmbPcmQiXVCvW3qgyYS/HE2vLuOJ0IU7cXAik9gLYO5sBwOer1w66DkF//NtpVcJH2b51b4BDuFu6vOr2WYd0TP9eQjVIfoz4995kcGFWxsj0mD9YjofjuROAuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760347412; c=relaxed/simple;
	bh=/36+Ikatw9hbWAnqgZkVSbwFjnpdePCvnaZYml0SVtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8PA5DAPMzq9f2XmseaDvQdpxI2m5cxEAkgxfefR/2HVIfUPBXYBZqhqKjprRZkoEE1HGcKVbJaxDfk4oE1UH/5QZCaukOeBAfoP8/slxsZz8GHQK9ZrvFryi/drD6mdvt0C8uQUugZVn1HarC5mIsImZhXCXka9Xgz6prpJAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cvaMVf8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC31C116D0;
	Mon, 13 Oct 2025 09:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760347411;
	bh=/36+Ikatw9hbWAnqgZkVSbwFjnpdePCvnaZYml0SVtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cvaMVf8NTF8dbJhLetqkNmIr52n68E+TIXLBMejQF61vZQWebA8eYF6/DjcHVOuqs
	 WRGJJYJXD/y1dDWtGOzvklOLEDpox7Z+spfqENVDdskgL+XkbHfG9Q0xFFMQFOE+7V
	 0U6GJwOag2tt9sgUFelUBA9hD+U9EP2I+cipUdXB03xIC6I9Sz71lRaPz9/w84uyIk
	 w94+YnjK6TqrQypvlQW8iHeh979L+u7CQe7+Kwlue/j6hf0Zz/mw9ZjK5ydEm9H4y1
	 BD99+4hxl0TptJgjm478qSWzdbCe7Il1hvJPtoD7O+I9h+/PGEueK7Twllce8AdcNp
	 LXB2XQlASSF1Q==
Date: Mon, 13 Oct 2025 10:23:26 +0100
From: Simon Horman <horms@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH] Octeontx2-af: Fix missing error code in cgx_probe()
Message-ID: <aOzFDncvwZAMhZeA@horms.kernel.org>
References: <20251010204239.94237-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010204239.94237-1-harshit.m.mogalapalli@oracle.com>

On Fri, Oct 10, 2025 at 01:42:39PM -0700, Harshit Mogalapalli wrote:
> When CGX fails mapping to NIX, set the error code to -ENODEV, currently
> err is zero and that is treated as success path.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/all/aLAdlCg2_Yv7Y-3h@stanley.mountain/
> Fixes: d280233fc866 ("Octeontx2-af: Fix NIX X2P calibration failures")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> This is based on static analysis with smatch and only compile tested.

Thanks,

I agree that Smatch is onto something here.

Reviewed-by: Simon Horman <horms@kernel.org>

