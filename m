Return-Path: <netdev+bounces-182885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010D5A8A43B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BF51684D0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 16:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8B22185A0;
	Tue, 15 Apr 2025 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yi2BxjzI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1B015F306;
	Tue, 15 Apr 2025 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744734940; cv=none; b=lY2/n8XGqg7s+qiU47rne+VVHlcdKGnyvKHZTz1aaLJEkKxew/aB5MfY80y1sizke4D/5E2pelrbNKNno3dYo7vjJHEyBre9yvtL/62dIjODW66Sk/XvdQK9OJnM/SZepeFe02HzNJyQnX3vt7+4PLy2CCG/XT5upwYuTiROsbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744734940; c=relaxed/simple;
	bh=qQPlLCaHQYe+gqLPm35pHARjmiBk4+PpLo1qXkmjFPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lOMg1ZY2wezGXnEEmDVbl4VHqyZZX4HFVH0xDnSVUqUjr+8OoCxCe8mWwg2s8PXAJO0qdqLSS7Czkt+U/5y4sh37yyUclRmh5HnFYXwVUD241EqhM5nkyGZOK26fZY0txGo1gbs9VZkhC/BXuJelWb7h4BoOvCv2uyTrNKxpcjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yi2BxjzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221B2C4CEEB;
	Tue, 15 Apr 2025 16:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744734940;
	bh=qQPlLCaHQYe+gqLPm35pHARjmiBk4+PpLo1qXkmjFPQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yi2BxjzI5SS9GasqB1mrG7VGqf/qr3KLNsPj6olTEq/xwEyFuBJ/CoHDkRfZLCJKl
	 1wNR0NvBf4CfKpluiko2DxFirtrllqs8Asr7/HLZp/3dCUKp+nTK7MXVjpZmhiRGTA
	 P8NdCQrfk1p/5EZhfWR/zR3r1OPELisyF6ml5geKUA+1VDQiVWsDQBk14UGhn4/oWB
	 oovpgwl2GWP7vKpebsgnTLlXUNdCdHsKL6N7AxtUZ3NEyCdxi+E0w9p1L7OZYhMNv1
	 z01ek110ohyc/yRuFklq1r4sVF+k8Q4AH0lKTb40dQN9n5J3qzSsUx1xocd7ch3iC+
	 I4hGyaRgW5CpA==
Date: Tue, 15 Apr 2025 17:35:36 +0100
From: Simon Horman <horms@kernel.org>
To: Pranav Tyagi <pranav.tyagi03@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, skhan@linuxfoundation.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH net-next] net: ipconfig: replace strncpy with strscpy
Message-ID: <20250415163536.GA395307@horms.kernel.org>
References: <20250412160623.9625-1-pranav.tyagi03@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412160623.9625-1-pranav.tyagi03@gmail.com>

On Sat, Apr 12, 2025 at 09:36:23PM +0530, Pranav Tyagi wrote:
> Replace the deprecated strncpy() with strscpy() as the destination
> buffer is NUL-terminated and does not require any
> trailing NUL-padding.
> 
> Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>

Thanks,

I agree that strscpy() is the correct choice here for
the reasons you give above.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  net/ipv4/ipconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
> index c56b6fe6f0d7..eb9b32214e60 100644
> --- a/net/ipv4/ipconfig.c
> +++ b/net/ipv4/ipconfig.c
> @@ -1690,7 +1690,7 @@ static int __init ic_proto_name(char *name)
>  			*v = 0;
>  			if (kstrtou8(client_id, 0, dhcp_client_identifier))
>  				pr_debug("DHCP: Invalid client identifier type\n");
> -			strncpy(dhcp_client_identifier + 1, v + 1, 251);
> +			strscpy(dhcp_client_identifier + 1, v + 1, 251);

As an aside, I'm curious to know why the length is 251
rather than 252 (sizeof(dhcp_client_identifier) -1).
But that isn't strictly related to this patch.

>  			*v = ',';
>  		}
>  		return 1;
> -- 
> 2.49.0
> 

