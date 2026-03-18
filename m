Return-Path: <netdev+bounces-269179-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DNdBH8Gu2kgeQIAu9opvQ
	(envelope-from <netdev+bounces-269179-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:09:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E76A2C25DD
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 21:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F141730234F4
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 20:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5443ED13A;
	Wed, 18 Mar 2026 20:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZMYXdmD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B52D4B40
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864571; cv=none; b=uiSCrticw5EzESsEVth03cfngz1mnhF+WPM26x7Eu3TAfm/De93OGpdx4fHIQRwYl6loRNZyBXdDGpfwO7vnpDxaFTeWYCOjLNXNS1gvdQHjKgbzqNaMnm67YqG7C1EseWcScJx760o5NQKaPptzQQTPzJbcu1h1I+W3OIzoBy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864571; c=relaxed/simple;
	bh=G/CSiwUSEOqLczHCD6ZmlD84NXvI596h7Wx0J+y9n9k=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=J8DSbdc7vBtAmLBPJvYCjEUmv1fwmQ3e1u7lFZjAg7WtjK4Tnc3MVPiNeIip3ouw9XBBQ04p2/i93Lfe0PVjtWbuIGuo8cbvKOPsgN3zOsI0dkdN7VsgMoY5gtYdvccT25tkCqG524m2AvUTjzltxYX+RChYGEPvmKPw/PaQr/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZMYXdmD; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ad79dfb7cso458155d50.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 13:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773864570; x=1774469370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8FFlAehcFfcN+ZVaCQWmsQGGFzkurvOjaypfavq2lg=;
        b=MZMYXdmDVzHZa5p6P7mAka8KD060PRXBRA1yAuCtDEkKGNO3oh17HBS9U1Ym6oboEr
         Fc7buwL31S0vjxP6Vcz0yG2yw8SNf2VykEOqSfB6vHkpzQE6Hzqg1uE1f6GuYc/bcJLD
         WLsNbFssjONpqsSZfrab5oPVlRuQ/XgK3k9FLzmHpRx2OBJ0ZIyn+4VLd3BkApZTHdlM
         ZmGoK+NO5DQXX/ezXG1p6bod9EsghRQkhdup+ZuZce62SQVJAgZisDI/rdO+pRyciahx
         2bgv/OSR5DR/0EGRzx8CJRyXUZOSQX6031uikbsfnt+bxz8X0rGwVG8IOFEdSHqPbkht
         IHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864570; x=1774469370;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o8FFlAehcFfcN+ZVaCQWmsQGGFzkurvOjaypfavq2lg=;
        b=kwoHIJY2eOgA24fTXkqMB5ldbv7ECzQFYbrHeoe+DM5vw3aKVJVIVKXC4LFWvuD3yB
         F1iASuyDDUOl4+7aenK17muyOEeSne1ZJJVH7PQvyL8eW72PFqgxfgLO4ezaOMY+GpBs
         F6aFlfiNViF5gmXfTe8r02o0VmR9cyIfkk3BohjixAKjo0dMhGqA44IWLVPDEDzv/MOe
         l34mJUrRAvXMqYaVYPg8gWAubZxJZFFg3F1G2c3McVCxZTVYVklR3sHbZP+lQ9sEMjwI
         LKKQQJeeqcs3kia9Nzn78G2nWaiRtHHZXShNh65fluZCiyLHOMF3BF5eEAM2n5cuNM//
         g97w==
X-Forwarded-Encrypted: i=1; AJvYcCU/Co3ZPxuDfUyut1UcNr+Nkfy8Cuimlj8nlEz2ED3EbY/CmEUhVdobOJUVtKBDI25ilaCE5SI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRqz6g51QxCIMSfPi8SioLDe3cir/8jdSKNIunIYxI3DvUOvpB
	wVkDbKVsNmrHy1R6m6lN/dfwTkJR2gVXMySGY8+R0X/AvAnnKzsNwYX7
X-Gm-Gg: ATEYQzy+f+7N/LRbWMSY5vp52mme/trp1avq83MjPyZ2p24OsBEyBRYRgmb8Sj+QVNd
	4g07k0JXNuA+CYd9v3Rt+GKXvR0Enp0uMDyUlx4BCGtSGxQE0Jwx93iuh1PEdA6Mf1hg8TX3zl3
	nCUh6NZXWyC3o+7pHO0X15LOp15OkUYKzmuMsM1tXC+igv8jR8cjNEz5i1W+CQQNLmxjV4G8rh9
	WU3ainFDF66tBFs2wa/evrHDHq/6qtPvo3sL/QlujAb4ZbWWnoGW4EN3RHtIGL3lCRkGiepIwpw
	jA3kBjjaa+nI3aDjR5pZJz+3KuDKC2ucq7IHz5tofLWK4az6mW0nA6bq6DSGB/lTBwW/7P1ByaM
	9IdjSAS3ad5jPNImJ2N5BK7B9/dGPe3QXcy481m5j5v+VTxA7T3vL+QwqdNFBMW3ImC8XpYspGH
	GsSPt0+uEzmnVVaGsH9mi+5PLVMk/7ZEf1jZWSHg8bpUcBUOfZhw8Wa30+d2eO2owQze+q3Vv3m
	i9G
X-Received: by 2002:a53:ca02:0:b0:64c:a49b:ed78 with SMTP id 956f58d0204a3-64e915bd965mr3283791d50.38.1773864569681;
        Wed, 18 Mar 2026 13:09:29 -0700 (PDT)
Received: from gmail.com (180.134.85.34.bc.googleusercontent.com. [34.85.134.180])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-64e91bb9344sm2236439d50.12.2026.03.18.13.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:09:29 -0700 (PDT)
Date: Wed, 18 Mar 2026 16:09:28 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Nick Hudson <nhudson@akamai.com>, 
 bpf@vger.kernel.org, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Nick Hudson <nhudson@akamai.com>, 
 Max Tottenham <mtottenh@akamai.com>, 
 Anna Glasgall <aglasgal@akamai.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2e095812836bb@gmail.com>
In-Reply-To: <20260318134242.2725749-6-nhudson@akamai.com>
References: <20260318134242.2725749-1-nhudson@akamai.com>
 <20260318134242.2725749-6-nhudson@akamai.com>
Subject: Re: [PATCH v2 5/5] bpf: clear decap tunnel GSO state in
 skb_adjust_room
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269179-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,akamai.com,linux.dev,iogearbox.net,kernel.org,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.229];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,akamai.com:email]
X-Rspamd-Queue-Id: 9E76A2C25DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Nick Hudson wrote:
> On shrink in bpf_skb_adjust_room(), clear tunnel-specific GSO flags
> according to the decapsulation flags:
> 
> - BPF_F_ADJ_ROOM_DECAP_L4_UDP clears SKB_GSO_UDP_TUNNEL{,_CSUM}
> - BPF_F_ADJ_ROOM_DECAP_L4_GRE clears SKB_GSO_GRE{,_CSUM}
> - BPF_F_ADJ_ROOM_DECAP_IPXIP4 clears SKB_GSO_IPXIP4
> - BPF_F_ADJ_ROOM_DECAP_IPXIP6 clears SKB_GSO_IPXIP6
> 
> When all tunnel-related GSO bits are cleared, also clear
> skb->encapsulation.
> 
> Co-developed-by: Max Tottenham <mtottenh@akamai.com>
> Signed-off-by: Max Tottenham <mtottenh@akamai.com>
> Co-developed-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Anna Glasgall <aglasgal@akamai.com>
> Signed-off-by: Nick Hudson <nhudson@akamai.com>
> ---
>  net/core/filter.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 47aec44a9cd3..35af1199ab97 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3665,6 +3665,37 @@ static int bpf_skb_net_shrink(struct sk_buff *skb, u32 off, u32 len_diff,
>  		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO))
>  			skb_increase_gso_size(shinfo, len_diff);
>  
> +		/* Selective GSO flag clearing based on decap type.
> +		 * Only clear the flags for the tunnel layer being removed.
> +		 */
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_UDP) &&
> +		    (shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +					 SKB_GSO_UDP_TUNNEL_CSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_UDP_TUNNEL |
> +					      SKB_GSO_UDP_TUNNEL_CSUM);
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_L4_GRE) &&
> +		    (shinfo->gso_type & (SKB_GSO_GRE | SKB_GSO_GRE_CSUM)))
> +			shinfo->gso_type &= ~(SKB_GSO_GRE |
> +					      SKB_GSO_GRE_CSUM);
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP4) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP4))
> +			shinfo->gso_type &= ~SKB_GSO_IPXIP4;
> +		if ((flags & BPF_F_ADJ_ROOM_DECAP_IPXIP6) &&
> +		    (shinfo->gso_type & SKB_GSO_IPXIP6))
> +			shinfo->gso_type &= ~SKB_GSO_IPXIP6;
> +
> +		/* Clear encapsulation flag only when no tunnel GSO flags remain */
> +		if (flags & BPF_F_ADJ_ROOM_DECAP_MASK) {
> +			if (!(shinfo->gso_type & (SKB_GSO_UDP_TUNNEL |
> +						  SKB_GSO_UDP_TUNNEL_CSUM |
> +						  SKB_GSO_GRE |
> +						  SKB_GSO_GRE_CSUM |
> +						  SKB_GSO_IPXIP4 |
> +						  SKB_GSO_IPXIP6)))
> +				if (skb->encapsulation)
> +					skb->encapsulation = 0;

Is there any chance that this might clear it while some other tunnel
is still active? From a quick grep on skb->encapsulation the only
possible hit I see is SKB_GSO_ESP.

> +		}
> +
>  		/* Header must be checked, and gso_segs recomputed. */
>  		shinfo->gso_type |= SKB_GSO_DODGY;
>  		shinfo->gso_segs = 0;
> -- 
> 2.34.1
> 



