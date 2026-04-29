Return-Path: <netdev+bounces-282223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Qy9vLzNx8WmggwEAu9opvQ
	(envelope-from <netdev+bounces-282223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:47:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E198148E69F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 04:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F12703019902
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 02:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52433155C87;
	Wed, 29 Apr 2026 02:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/HG0eBr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE353A59
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 02:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777430832; cv=none; b=AqJq8XIfgtR5H4hlYQfI7u2EpITufMFz/3ysdWSxoqC04wKaeAb5ZMi+x/1+0wKDRkJXOx4ZlIaAY5yf0MUsm/Ph6T0yx+k6oasXI/Bf36fQucuuqjkF6byjEfvBj1NOwJ3nBJxUJkhr1zY0LY6FVaQNC/QuVyhtKApK9i74CvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777430832; c=relaxed/simple;
	bh=HfyvwMn0Tr+GmANRux3aIBGwpaeR+9xDdWcebuT/Hl8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=cY6eYlGhGBOP+6/Uohs/FbD2FT4W/I0bZwDCji0gr4ti4EDENWM1ZNPB//VjzasvnG0rTCj3wVwrbvk5v/oMmDC+TVW1CSYjgBw2sscdy2jlj78EBBsNCoe6X2a1SXFKJZnzI0VE6e4t6HfRtzjisfkbnHtXZQAMLKEHv8KwEDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j/HG0eBr; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-651bf695701so10961756d50.2
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 19:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777430830; x=1778035630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0dlbLZOudHRYK14qr5+Lfe6cWBdePDW+ool+pbNASqU=;
        b=j/HG0eBrsW2Dr4fVYlIUiPOF3JDysSqhE9O/sBFc+i+p/Q0LE48RaRl/uHsKv2V6DK
         xemYXjkUBFNNLtYZKqUtmTufekaa4QrsU1kRJ02+x3SVXQt+Bhc/6M/I3ABfcbHiRFrn
         rw7cCUtQgGpUNTYJY/B4nl9Bp29YGbWNzXJgYwwhHE5NogHCcjIJUeuG72OianoibWrZ
         ipyr4JLAHHAK8Kf+lBsnIoYbSHWeoHfV3S8TlWPRU1g4sWhOa3hdEV58zb+cV/lPj0Ai
         Id+K5KGCiGnlNJ0i4dM5mzXG7HmoDbAUgx5X/Qzv6O1GTFwIOdyfrGmcA2na8NfHZkr4
         IB2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777430830; x=1778035630;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0dlbLZOudHRYK14qr5+Lfe6cWBdePDW+ool+pbNASqU=;
        b=XqGCpomB+CM4arzacnsKJBIOTYnE9TwvY+x9k0iJtyHwUepWDkaHeqAtvLVmoURYpO
         3HUqS37XQCq8SrMZhU1J8TnECEKzyfu9ahbg/VJzhoKLxcd8qtXMc5DXWCa9hJKv2hr/
         yhp5rnjLzmh0LcSPZHzDy3Y7MgENFuRWY9qUWoSK6UUiln/iiShLUliOgEOC2DAeaV0f
         YXX1g+fLDho5FmXIo2BPReRIUtfXqhaGvgj0ClBM5qmS0XhSP04ru9lG69XenAsaepTh
         rdXO+1us9QNAMvKY6AvDiBQUM7WhXqrPJg+LtuXMOK6PFD70y9o4lOvsmsGqAkV2Ya6V
         b3mQ==
X-Gm-Message-State: AOJu0YzHW5CbgdbzTG7mluCvBmuru05XfJ2cXv75SArwrb4s4lHCZB42
	GA1r1hjq+fMQ37oRbAP68LlvuvE/QNUR/h9+0zDTI2wg5qpTHx601dXc
X-Gm-Gg: AeBDieup+uN0EuGMyN2Q56BhQM+tpyeKkEAGcwI8DJFUWoPnSCWnzuprx+bFkpFtuKq
	FI3yjDDGEqlvCJPlDikPSBNkYxYn0twM+5GYJXAhhs2oFskdqrQ26BDRxKsYTzgRWi0j020byUC
	Y2gNdcuPEzn/lnRj7rmhQk7e71VxLFxcn4hvJXGn/Rsr6Pf66DxVL7TAxVueZlChYopEi4AejUf
	JO7IWVFwSi1I+xd1h+HAJNA5HIwR7LY2VcijC766y/RnJ+pKMRQ9+LLanMXSoGIBexGRYPJkar5
	5f9WowzKuO9xRQaDFi64Na9DTCAf98/o5Q6bTIGUteniQaZv6c6F6YyxAik8FLKcpTg5iiyMIXU
	QPBafEkva1jeoUSD/+FsJ0MmTgigtxrNogZpJjRMdQycQbf2XmuqKE3FfUoQ5Dh7AFcL9gcccmJ
	LOY5/LnHmsefNPKpg7wjY4q2zxeTj2618MrwqLmaxzDfZw6fwzmMuhveFmBjXK2wbuRiCy3u5Ch
	6EEtmgtaPxfK/5mwHkGr+CDqg==
X-Received: by 2002:a05:690e:12c3:b0:650:3952:3d2a with SMTP id 956f58d0204a3-65beed4aa60mr5261366d50.8.1777430829908;
        Tue, 28 Apr 2026 19:47:09 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff4fb88esm695402d50.5.2026.04.28.19.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 19:47:09 -0700 (PDT)
Date: Tue, 28 Apr 2026 22:47:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 daniel.zahka@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.342aa6073ecf5@gmail.com>
In-Reply-To: <20260428205352.1247325-2-kuba@kernel.org>
References: <20260428205352.1247325-1-kuba@kernel.org>
 <20260428205352.1247325-2-kuba@kernel.org>
Subject: Re: [PATCH net-next 1/3] psp: validate protocol before mutating skb
 in psp_dev_encapsulate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: E198148E69F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282223-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.998];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Jakub Kicinski wrote:
> Code checkers / AI scans will complain that we have already modified
> the packet by the time we realize that protocol is not IP.
> 
> Move the skb->protocol check to before skb_push()/memmove() so that
> the skb is not left in a corrupted state when the function returns
> false for an unsupported protocol. psp_dev_rcv() follows similar
> pattern.
> 
> Today this path is unreachable because both in-tree callers (mlx5 and
> netdevsim) only reach psp_dev_encapsulate() from TCP socket TX paths
> where skb->protocol is always ETH_P_IP or ETH_P_IPV6, and both drop
> the skb on a false return, anyway.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
>  net/psp/psp_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/psp/psp_main.c b/net/psp/psp_main.c
> index 9508b6c38003..652ec8a9c8a4 100644
> --- a/net/psp/psp_main.c
> +++ b/net/psp/psp_main.c
> @@ -228,6 +228,10 @@ bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
>  	u32 ethr_len = skb_mac_header_len(skb);
>  	u32 bufflen = ethr_len + network_len;
>  
> +	if (skb->protocol != htons(ETH_P_IP) &&
> +	    skb->protocol != htons(ETH_P_IPV6))
> +		return false;
> +
>  	if (skb_cow_head(skb, PSP_ENCAP_HLEN))
>  		return false;
>  
> @@ -243,11 +247,9 @@ bool psp_dev_encapsulate(struct net *net, struct sk_buff *skb, __be32 spi,
>  		ip_hdr(skb)->check = 0;
>  		ip_hdr(skb)->check =
>  			ip_fast_csum((u8 *)ip_hdr(skb), ip_hdr(skb)->ihl);
> -	} else if (skb->protocol == htons(ETH_P_IPV6)) {
> +	} else {
>  		ipv6_hdr(skb)->nexthdr = IPPROTO_UDP;
>  		be16_add_cpu(&ipv6_hdr(skb)->payload_len, PSP_ENCAP_HLEN);
> -	} else {
> -		return false;
>  	}
>  
>  	skb_set_inner_ipproto(skb, IPPROTO_TCP);
> -- 
> 2.54.0
> 



