Return-Path: <netdev+bounces-286110-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJA9IsHU/mmcwwAAu9opvQ
	(envelope-from <netdev+bounces-286110-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 08:31:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E6A8F4FE40B
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 08:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 15C453011119
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1072723A564;
	Sat,  9 May 2026 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1JAuIJUU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC3411C695;
	Sat,  9 May 2026 06:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778308286; cv=none; b=Apx+/qdMBvyMHmbOJJ3iEqXCBgPIVrKyjZb+vzmjhx+R7T18oW5BjcfxCt044h5XX2dCcgomfFnE2kg4n/vGgnG+q3YKPd53kNC6wjUR1+3vdJUisjMo/+hRe5p3oydmXsxZwzacetsKcomXuzXbcLL9ppR0/YiqAE56Y5F8GN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778308286; c=relaxed/simple;
	bh=FW++obpN25kmBeWx95IYJPsxpjaLgydhNsAb/7LaDOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uCKsHs8i4074z14cK6dAIeKihy8y6ByiPvCaPl/fZEokDIpLyE3gyHp3iMt/k/LwQ+9tA5sReJosVc+rkB5BSWShMu/15xzzEqglO/FoaPiH1Zrbim4MRntdv1/oiDN5qY4XSil1nfbwt4lrScHsJUTIMqGDQgaw/bZmRzGSjb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1JAuIJUU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DC3C2BCB2;
	Sat,  9 May 2026 06:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778308285;
	bh=FW++obpN25kmBeWx95IYJPsxpjaLgydhNsAb/7LaDOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=1JAuIJUUEI7gcKkgX00XXNRpFoJEDyDj20KiUN9goKtaOXyeC273KlvQeQxRUMnJ+
	 zwdi9t3dpyE/aOb0qqC3wps9q5yQfmFvzhoAHBWXXcjU93c80jxxaZHkakUTDDiD+8
	 1dQpOyarMSzZm+Hx87i9WCx3ajHRd0dUdJAdO8H8=
Date: Sat, 9 May 2026 08:30:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Feng zhou <zhoufeng.zf@bytedance.com>
Cc: imv4bel@gmail.com, h3xrabbit@gmail.com, steffen.klassert@secunet.com,
	benh@debian.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com
Subject: Re: [PATCH v5.15.205] ipv4: set SKBFL_SHARED_FRAG in the right skb
 field
Message-ID: <2026050925-nucleus-elope-b60d@gregkh>
References: <20260509053751.45007-1-zhoufeng.zf@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509053751.45007-1-zhoufeng.zf@bytedance.com>
X-Rspamd-Queue-Id: E6A8F4FE40B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286110-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,secunet.com,debian.org,vger.kernel.org,bytedance.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,bytedance.com:email]
X-Rspamd-Action: no action

On Sat, May 09, 2026 at 01:37:51PM +0800, Feng zhou wrote:
> From: Feng Zhou <zhoufeng.zf@bytedance.com>
> 
> commit ab8b995323e5237041472d07e5055f5f7dcdf15b
> ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> backported the shared frag marking to ip_append_page(), but it writes
> SKBFL_SHARED_FRAG to skb_shinfo(skb)->tx_flags.
> 
> SKBFL_SHARED_FRAG is a skb_shared_info::flags bit, so storing it in
> skb_shinfo(skb)->tx_flags does not mark the skb as carrying shared
> frags for later consumers.
> 
> Set the bit in skb_shinfo(skb)->flags instead. This makes the
> backport actually tag spliced UDP pages as shared and restores the
> protection intended for the ESP-in-UDP path.
> 
> Fixes: ab8b995323e5237041472d07e5055f5f7dcdf15b ("xfrm: esp: avoid in-place decrypt on shared skb frags")
> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
> ---
>  net/ipv4/ip_output.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> index 68509e1f89b5b..5d8f8a5901bc6 100644
> --- a/net/ipv4/ip_output.c
> +++ b/net/ipv4/ip_output.c
> @@ -1443,7 +1443,7 @@ ssize_t	ip_append_page(struct sock *sk, struct flowi4 *fl4, struct page *page,
>  			goto error;
>  		}
>  
> -		skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
> +		skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
>  
>  		if (skb->ip_summed == CHECKSUM_NONE) {
>  			__wsum csum;
> -- 
> 2.39.5

This is already fixed, why send it again?

confused,

greg k-h

