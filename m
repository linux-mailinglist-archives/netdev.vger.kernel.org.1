Return-Path: <netdev+bounces-272131-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGasGs9exWlM9wQAu9opvQ
	(envelope-from <netdev+bounces-272131-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:29:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE9D338638
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 17:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F2654305B665
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D38C401485;
	Thu, 26 Mar 2026 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFEuLlDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 815453BFE24
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 16:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774542320; cv=none; b=QmMK53+3eoP4uAGHXeEIJi7vW32QtA0yFM+9fUWn3raeYiKXdk/zJUQXd1igowDRUbz5mU4VhiXr2pHa/90VOX7Yib4i/T9YlkZvQSkipiCt9iVX96qP5oIl7cjlOVHbEkP3f64qJxEwlCSSReMujdrtVLm4q0O9D9GVxMwKFqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774542320; c=relaxed/simple;
	bh=VWZT9ERgK7gJqphC8GoSZLKrh7DUq8FCawjcEwvjBu0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=txmMZH/u/YqFRi6ia8N/6LTSLq44n6SY5WlTl0DmvNwBYfvWf+QJXlkxUqA18m159nCfQIxHY9WP2Ae7Pmf6gzm9H6uZIrZUmToAGPrKOucLmDzU7s1zOvpBJnv5BuHj49ct7PvtTl7AqDQF/IiFwYTyfoPWSTAFpPvb7f1qcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFEuLlDY; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-79ac5de41d8so11946697b3.3
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774542317; x=1775147117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQ+dnIdkTMUfClaOEhsfhfSTdn6XkHf1UrfOW0f1rdo=;
        b=cFEuLlDYiqOY9JEQ6/zyK8ZSOh1kJeIuv2z7QFb5Jx59pw6SQtvWZRGV0imOCB0uiv
         UVzWI1+UR5sKSaCdrq6vDSQko1IulVC66ntAL8w/vcCXpLDkO0T4JvvEMwoH10WByQ5F
         9bpOWAfmAC24AB3b1T59Rh0dNR1xJw77hZhK8FlqO0yY5dLKCBGjMf3JLZveqBnAJA+W
         uHF1LCjN2qlWl3nmD7GfSNn/LyQFbzN7pjPT+S4UcNrBH27p+CEKsas6a1Hui7YsuBig
         z/VkZV6FDX4XZJ3OGTQ4rEd1Qw+1bOzkO6H6a5JLaYKjrCpDMhQSktGDE/EqxPLRbx2i
         sKuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774542317; x=1775147117;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tQ+dnIdkTMUfClaOEhsfhfSTdn6XkHf1UrfOW0f1rdo=;
        b=egErEyuOrys5f+dLaATYuhkBWrdi1DNUTx5BdDlCCYMV91rlhkaPDt1XWQ+tcPR2mu
         HcO7tliTJgQ3j1iKf67IcA9sSAaZVyqtoHTDQrRVJWJP5VjoIwI07byqYqEhPVknrD3I
         zM+pPuEwVxrfdh5LbCzWcmh/9FgiBYP1d3N8rXMW3tQ/9MDkaMiUIyTOJ0kJvwwM+WnM
         f85mHRazGbCYTcwAGVbv261OV9tXHKrcu+LFW/JAv8YJJzvFDCguapnGMhxQdOm4S+MS
         zQ0etzpICnMyLAjc35ERlSuXsUdBgmc+XsLow1gMfbY/TotrJYNVv7xml5NfVR1FanIJ
         cFaA==
X-Forwarded-Encrypted: i=1; AJvYcCXL85fj3gQNndQXkaJhCHUYmJ0wQg0Lc1Skr1rWN+wvt5TEoCOJEr/OeH9rntXd3EWvfAHdT1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzANUCZdV0B4GLihDqZT+iMNAHqRx9Dclzdb9D72Hzlyhip7z/M
	DYNuQ2//JtQLQWB+fGmYhp4aI2qkkUOArL1irdMPuKlwF7vb7m0+VepU
X-Gm-Gg: ATEYQzzNAqo2XkZWUQQ2fRaacZnB1SUB1EKQjVfwcHnECt5HzTdrZO/yvMjpfDCK+H5
	sUiuu3MH4i+yMrzZVfFsv4n4ACXNNktYore4UIvcOp9ETyyoaVpHH/csLUZBYwhkF/78q6Hfqc2
	asMeazt05E2yRb5O/UVJZ4ijjXx5IJfiSVCUtYA7lbqcSikO0dnKrZUJdV57YJAN9ZNQqpVoI7A
	9hfPx2QvZQL8hN1yqgdxuP1aQUelneSg9S0ZRN0WTwWsTYI11yGp3vPAhRKNTjufW6xEsoEURtg
	ymQwH0OxeodeVObZ0fHj7lhMVftK18hxvr8v0i4N8HAWtYDi8NDz4ZTzEGrCzHNMmfFdeEkwdjl
	dYB1nDhv9cmRwTL7p41eq6FEMHA/PfVy8iQZIXL95RfRe/kPaTLkvp4Cih7c/mWpIevxaKjElOz
	erdg2SLL9/aMmorhfP7P4D8zTCyYD/aGw1vYFbXY+ZNU1PgranEgGUdRG4lYrIW/vJ03EDquz3d
	7b2
X-Received: by 2002:a05:690c:f09:b0:79a:d2ba:3c28 with SMTP id 00721157ae682-79ad2ba4245mr68382447b3.43.1774542317200;
        Thu, 26 Mar 2026 09:25:17 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-79b1e45254bsm14981827b3.48.2026.03.26.09.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 09:25:16 -0700 (PDT)
Date: Thu, 26 Mar 2026 12:25:13 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Guoyu Su <yss2813483011xxl@gmail.com>, 
 edumazet@google.com, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 pabeni@redhat.com
Cc: willemdebruijn.kernel@gmail.com, 
 netdev@vger.kernel.org, 
 horms@kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, 
 syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com, 
 Guoyu Su <yss2813483011xxl@gmail.com>
Message-ID: <willemdebruijn.kernel.19f0cde3c6457@gmail.com>
In-Reply-To: <20260326121813.457049-1-yss2813483011xxl@gmail.com>
References: <willemdebruijn.kernel.1a9f35039caab@gmail.com>
 <20260326121813.457049-1-yss2813483011xxl@gmail.com>
Subject: Re: [PATCH net v6] net: use skb_header_pointer() for TCPv4 GSO
 frag_off
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272131-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,googlegroups.com,syzkaller.appspotmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,google.com,davemloft.net,kernel.org,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1543a7d954d9c6d00407];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: 0CE9D338638
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Guoyu Su wrote:
> Syzbot reported a KMSAN uninit-value warning in gso_features_check()
> called from netif_skb_features() [1].
> 
> gso_features_check() reads iph->frag_off to decide whether to clear
> mangleid_features. Accessing the IPv4 header via ip_hdr()/inner_ip_hdr()
> can rely on skb header offsets that are not always safe for direct
> dereference on packets injected from PF_PACKET paths.
> 
> Use skb_header_pointer() for the TCPv4 frag_off check so the header read
> is robust whether data is already linear or needs copying.
> 
> This also removes the SKB_GSO_DODGY special casing: skb_header_pointer()
> already fast-paths linear data, so a separate direct-access path is not
> needed.

Does not belong in the commit message. It's a diff vs the previous
version.
 
> [1] https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
> 
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.1a9f35039caab@gmail.com/
> Fixes: cbc53e08a793 ("GSO: Add GSO type for fixed IPv4 ID")
> Reported-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=1543a7d954d9c6d00407
> Tested-by: syzbot+1543a7d954d9c6d00407@syzkaller.appspotmail.com
> Signed-off-by: Guoyu Su <yss2813483011xxl@gmail.com>
> ---
> v6:
>  - Use skb_header_pointer() for both DODGY and non-DODGY TCPv4 GSO
>    packets in gso_features_check().
>  - Drop the SKB_GSO_DODGY special-casing for IPv4 header access.
> 
> v5: https://lore.kernel.org/netdev/20260320141459.9691-1-yss2813483011xxl@gmail.com/
> v4: https://lore.kernel.org/netdev/20260319005421.14908-1-yss2813483011xxl@gmail.com/
> v3: https://lore.kernel.org/netdev/20260312104351.185370-1-yss2813483011xxl@gmail.com/
> v2: https://lore.kernel.org/netdev/20260308083319.1255118-1-yss2813483011xxl@gmail.com/
> v1: https://lore.kernel.org/netdev/20260307162905.3697050-1-yss2813483011xxl@gmail.com/
> 
>  net/core/dev.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 14a83f2035b9..8a15ca67cfed 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3805,10 +3805,16 @@ static netdev_features_t gso_features_check(const struct sk_buff *skb,
>  	 * segmentation-offloads.rst).
>  	 */
>  	if (skb_shinfo(skb)->gso_type & SKB_GSO_TCPV4) {
> -		struct iphdr *iph = skb->encapsulation ?
> -				    inner_ip_hdr(skb) : ip_hdr(skb);
> +		const struct iphdr *iph;
> +		struct iphdr _iph;
>  
> -		if (!(iph->frag_off & htons(IP_DF)))

minor: no whitespace in the middle of the variable definition block.
> +		int nhoff = skb->encapsulation ?
> +			    skb_inner_network_offset(skb) :
> +			    skb_network_offset(skb);
> +
> +		iph = skb_header_pointer(skb, nhoff, sizeof(_iph), &_iph);
> +
> +		if (!iph || !(iph->frag_off & htons(IP_DF)))
>  			features &= ~dev->mangleid_features;
>  	}
>  
> -- 
> 2.34.1
> 



