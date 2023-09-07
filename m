Return-Path: <netdev+bounces-32355-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC76796EC9
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 04:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602281C20AFD
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 02:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33525A3F;
	Thu,  7 Sep 2023 02:05:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5ADA29
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 02:05:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 169CAC433C7;
	Thu,  7 Sep 2023 02:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694052330;
	bh=JqUmrXyqneFAoO2KpyWVhA6RC3P1OyuwmhTYDUUs+Uc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t5EP5AzasJKIAV1Eb7/Qoyx0Hdg0N8nhpGjrN8Wrm/dkYC5WInvBKT21KS/j688S2
	 gpSd8HubF+AizQBh7eXeRw+3VIEnuUk8YOemoNc2IxykPHBkCAOmG9RqnimnpTTZJ2
	 4p26Yx9QzKkS5WXEBbwy4cbCvlauKhk9Uzgt4+XpzNbuubfbNGY2F5ikXawsSVuEsd
	 0342TCoNYBVvgKrkDXBmivVQUGm6UMC39ehxA0mMCQtvOH5ytlSaWQrq0Pe2hysRwu
	 6Jt43y7GbS9VyKkhupGb7P8tN8pR3Q73rKrtA2PihHWYb87smHTrerGHBw15xQiCad
	 JaO0ZqFp5s+5Q==
Date: Wed, 6 Sep 2023 19:05:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Dave Watson <davejwatson@fb.com>, Vakul Garg
 <vakul.garg@nxp.com>, Boris Pismenny <borisp@nvidia.com>, John Fastabend
 <john.fastabend@gmail.com>
Subject: Re: [PATCH net 2/5] tls: fix use-after-free with partial reads and
 async decrypt
Message-ID: <20230906190529.6cec0a3d@kernel.org>
In-Reply-To: <aa1a31a25c2d0121e039f34ee58a996ea9a130ad.1694018970.git.sd@queasysnail.net>
References: <cover.1694018970.git.sd@queasysnail.net>
	<aa1a31a25c2d0121e039f34ee58a996ea9a130ad.1694018970.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 Sep 2023 19:08:32 +0200 Sabrina Dubroca wrote:
> @@ -221,7 +222,8 @@ static void tls_decrypt_done(void *data, int err)
> 	/* Free the destination pages if skb was not decrypted inplace */
> 	if (sgout != sgin) {

This check is always true now, right?
Should we replace it with dctx->put_outsg?

> 		/* Skip the first S/G entry as it points to AAD */
>  		for_each_sg(sg_next(sgout), sg, UINT_MAX, pages) {
>  			if (!sg)
>  				break;
> -			put_page(sg_page(sg));
> +			if (dctx->put_outsg)
> +				put_page(sg_page(sg));
>  		}
>  	}
-- 
pw-bot: cr

