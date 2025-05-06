Return-Path: <netdev+bounces-188407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24549AACAF4
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA573BE508
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEBA284B33;
	Tue,  6 May 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOh09UDx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AD7284B26;
	Tue,  6 May 2025 16:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746548905; cv=none; b=D8gdVdkjMeJwSycPsB6Vt9jSHJg8ivg6alVr2igGg/8RBEauR8hvcQxkxUfCtP6IK1Qvn94HpWDCs710in2X+In3ndz2PBoa09TjoK1XT7XXfHplnN13YOSjW/8n0U+c32lLUJZXWfcE1JgmUWUI3EQHP9L7Jpr2s32xtgiTpi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746548905; c=relaxed/simple;
	bh=Jw6PhVIaG/rP64FTIP6ykuYxpI06mAJ2bnrjXXquetM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFQ2OsnLjF/4N/Dx5bWCETjSt6JGsWKWtbr/cyoK2dCJjq6Cq8Qvb3E3Flqg+ZQ0gT4lGbyBjHp03IVQ1GlH+3KK4F4t8+Htwtg90vkeZBdfSo8LF/ANMKi/X7iaVFMNq0Tf5r2iPtXVa2R5Pfm5+9rdNYFx/bx9DL5z9HBYNFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOh09UDx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9A0C4CEE4;
	Tue,  6 May 2025 16:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746548904;
	bh=Jw6PhVIaG/rP64FTIP6ykuYxpI06mAJ2bnrjXXquetM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOh09UDxVTUUSmXUxXrfH5xqWHtPf5Y2tVIFmDfxIiMVX3/eZNzpaFViif2T1QEbf
	 8loQEUMRmBkkPrL1mCuFr6MHNPzARMZfIZ3CjiI9cabrvm/kXb/1IPtpomd8uqHSaW
	 wksCtzVl22V7bjoThvMV2F2YvIxlrtNxnWHlzJTH2TwgPUuz6Y9O1VyOQwjVHRXcNs
	 85xq13eaLW8mzIDznkLdLoUa9H5jMso3rM8Ic3BLVME9CADmkwpmceIYhH0AfEuYXV
	 PaFni1Ef9Xw/KiXGkxY0sGE226iTbf+6DaOcdVs/l3nCkLAuP+R+aJF7R90Xjm3aNL
	 c097lJS14x6ow==
Date: Tue, 6 May 2025 17:28:20 +0100
From: Simon Horman <horms@kernel.org>
To: Siddarth G <siddarthsgml@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] fddi/skfp: fix null pointer dereference in smt.c
Message-ID: <20250506162820.GV3339421@horms.kernel.org>
References: <20250505091025.27368-1-siddarthsgml@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505091025.27368-1-siddarthsgml@gmail.com>

On Mon, May 05, 2025 at 02:40:25PM +0530, Siddarth G wrote:
> In smt_string_swap(), when a closing bracket ']' is encountered
> before any opening bracket '[' open_paren would be NULL,
> and assigning it to format would lead to a null pointer being
> dereferenced in the format++ statement.
> 
> Add a check to verify open_paren is non-NULL before assigning
> it to format
> 
> Fixes: CID 100271 (Coverity Scan)

* If there is a public link for the issue, then I think
  it would be appropriate to include it in a "closes: "
  tag.

  Else, I think it would be best to simply state something like
  "This issue was reported by Coverity Scan."

* The Fixes: tag should (only) refer to the commit that
  introduced the bug. In this case it looks like the bug goes
  all the way back to the beginning of git history.
  If so the tag should cite the very first commit.

  Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

* Please don't leave a space between the Fixes tag and Signed-off-by tag.
  (Or between any other tags.)

* Assuming this is a but, please target it at the net tree like this:

  Subject: [PATCH net v2] ...

  Patches for net should have a Fixes tag.

  Otherwise the patch should be targeted at the net-next tree.
  And there should not be a Fixes tag.

* If you post a v2, please observe the 24 hour rule

  https://docs.kernel.org/process/maintainer-netdev.html

> 
> Signed-off-by: Siddarth G <siddarthsgml@gmail.com>

Please consider expanding G out to the name it is short for
(assuming that is the case) both in the Signed-off-by line and From address.

Thanks.

> ---
>  drivers/net/fddi/skfp/smt.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/fddi/skfp/smt.c b/drivers/net/fddi/skfp/smt.c
> index dd15af4e98c2..174f279b89ac 100644
> --- a/drivers/net/fddi/skfp/smt.c
> +++ b/drivers/net/fddi/skfp/smt.c
> @@ -1857,7 +1857,8 @@ static void smt_string_swap(char *data, const char *format, int len)
>  			open_paren = format ;
>  			break ;
>  		case ']' :
> -			format = open_paren ;
> +			if (open_paren)
> +				format = open_paren ;
>  			break ;
>  		case '1' :
>  		case '2' :
> -- 
> 2.43.0

-- 
pw-bot: changes-requested

