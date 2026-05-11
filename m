Return-Path: <netdev+bounces-286753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPZAGvILAmrpnQEAu9opvQ
	(envelope-from <netdev+bounces-286753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:03:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD5D512F33
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 728C930243A3
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 17:01:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E9243E4B9;
	Mon, 11 May 2026 17:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LldmztCI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53C9438FF1
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 17:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778518873; cv=none; b=hl4LF+lojH5PsgIt1B+nx3+jI6esaWpX9Pcq3EYxM+/GJSZ893Sn9CuiUKf8ILi/BtXEVNU79Iu+ktpgURr+7/27No9gkw1Hs1fsmrIbTSZKHw0NRDdpFgqsewRHnImMwuba1OAQSqAlhiQtczRPI3EKHkIjArMF2DbVc2keJNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778518873; c=relaxed/simple;
	bh=iUUlpAucA/dZnek3XV6McEL9wHLXl5lrA2H26lKle70=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HFh7+8L+NoycDKxLtZJIr2PB+JrNpBvVnZng8UtSqQSYclEmJVULb4Zr3M7sfnEQVIUJ2Nhf75Hhv0QZsfvAndAawBv9aJGpva79uZSgL/pQncjnumlEtTDXesWQH1OvAKNIlcZSLsjOXU57T8oJmrKcSe2BwoHjmTYcmNpvuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LldmztCI; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-65c477a3278so4573427d50.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 10:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778518871; x=1779123671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fSFIFik1v36Q4UudkAaCYemmrKRYJBnkinCt0aw47nU=;
        b=LldmztCI6pAOLWUa9kIiz+d3VakIUT+qHrb8cqTit4HuVSdzXwle30fTWN3hw6gR7P
         Gyr+C1FrtPFNSydITGVon6quW1gP/TM2E8KHLffZy8NMI4KhnBtn8ipdiLuPkidp9yH7
         MdhQmW2aEmA76TC7nDxclfgXOAcAT/SMfKfQ8gEFO7UgLp98Mx9XnDyEfiWHOSlmKmx6
         AGxEZN+gQzeGkMGZSnyVECGiueRUZed3pgahW5OqwAP2LNw2du95K7JJcYHDKaBkxIUy
         tOSL2JMTvrVpDUNWHv3ndXe9Q3Oj/J9Nq+1MpaedyyyA4nAgwg6qivF872xS+dQy6pr2
         PuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778518871; x=1779123671;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fSFIFik1v36Q4UudkAaCYemmrKRYJBnkinCt0aw47nU=;
        b=UI8RKKy7l4SDm6188Mcn0OFF+PIDFAxrRTWVq/8lv+AGRAjO29raCw/NS5qFZc062f
         5O0UkO6ZZGoFfW2lr5BU29e3rhCxOCKgntrgBT64dVGOkUsWHTmvvHB7IiXOcAHeu2w4
         yGYgFUgoL0NFbA0XORX/nixreTcEiY434F9LKiQjCNXmTvDfa0L6FN2rtr5eswJUUZqm
         xp8dzZ3SOaqs7nDG1UZiRSFIWxwoD8o0myP2nWLozXG3bxsNdJ7IORgDzT8MScFmVh3v
         2W2ltUzaGyNpdlSPBPgnIkLMv2CwRxk9wVabGRvJEJG2zgCcSQI+wjQShaeQjNtpeht9
         kogg==
X-Gm-Message-State: AOJu0Yy3J1hvqYMu3kbzbb5V5uvZCS5y25GKUW8ewT22ThfoXyCxmzQK
	u4aJmhTyO95KnpckxJmTawoHS3aujQDQoYo76emNhnGVHcT7g9yydQcYAFXWqQ==
X-Gm-Gg: Acq92OG3S/M+wLUZbY+ERP36Pu5oX/wd+9AAr4CjQ/Dz2HOqj9mIfZ2Q/m7lvqX6ZLy
	0MUZERb+3CLaOXgg527r5dwXmDqaiTWxYFpPxp4E91nGR/UsUZct8uUTSXoKe8M8qrfCekGJZvP
	gS8EddqS52Dsx12/2f2dIACzwOFi0tW6bXrZsLCzF9UNg7IFLYcU/92yE1BmcIZ5ZHSXUnSKXBj
	l3Mlg5WgAebL9Q7kfK2hpIbRhb6E6EBfVFT7kG6/gWJJSjxeuTNGRQ8AHwmiu2m4UA3392rRwYP
	rhbqsIwCht/jZf72v1g7HQ3VNik/6LDvFEoNwjr9mkaHS+h67Bk5AslymwzWCl/Md9WVIx6fgA9
	7z4IaYlYXASp6ySN0AudHpoASbRykRXXrTBDyFzOpBdrVX3YoQ/jPVVgPDZwQcq8aXR+wTzYlfr
	gBshReBj17WKj4sLRLXSUiiVT3/hbXdjMA2UqwEPtXL2lMTLjxohORzIxhkE/kJ80GaEtoE8QQP
	yVQqcyb+2UWeBE=
X-Received: by 2002:a05:690e:42cf:b0:654:5d65:9fe1 with SMTP id 956f58d0204a3-65c79ad7682mr17440383d50.8.1778518870017;
        Mon, 11 May 2026 10:01:10 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96baa3a6sm5563191d50.13.2026.05.11.10.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 10:01:09 -0700 (PDT)
Date: Mon, 11 May 2026 13:01:08 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1d153b0dc9762@gmail.com>
In-Reply-To: <20260508-nsim-psp-crypto-v1-2-4b50ed09b794@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-2-4b50ed09b794@gmail.com>
Subject: Re: [PATCH net-next 2/6] netdevsim: psp: remove unnecessary UDP
 checksum computation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2DD5D512F33
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286753-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Daniel Zahka wrote:
> The PSP spec requires the implementations accept 0 checksum in psp-udp
> header. Let's take advantage of that to trim netdevsim's psp code
> down. psp_dev_encapsulate() already sets uh->check to 0.
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>
> ---
>  drivers/net/netdevsim/psp.c | 32 --------------------------------
>  1 file changed, 32 deletions(-)
> 
> diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
> index 5073bda60883..75740e2a731f 100644
> --- a/drivers/net/netdevsim/psp.c
> +++ b/drivers/net/netdevsim/psp.c
> @@ -1,8 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  
> -#include <linux/ip.h>
>  #include <linux/skbuff.h>
> -#include <net/ip6_checksum.h>
>  #include <net/psp.h>
>  #include <net/sock.h>
>  
> @@ -81,36 +79,6 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
>  			      skb->len - skb_inner_transport_offset(skb));
>  		u64_stats_update_end(&ns->psp.syncp);
>  	} else {
> -		struct ipv6hdr *ip6h __maybe_unused;
> -		struct iphdr *iph;
> -		struct udphdr *uh;
> -		__wsum csum;
> -
> -		/* Do not decapsulate. Receive the skb with the udp and psp
> -		 * headers still there as if this is a normal udp packet.
> -		 * psp_dev_encapsulate() sets udp checksum to 0, so we need to
> -		 * provide a valid checksum here, so the skb isn't dropped.
> -		 */

Perhaps this was here as IPv6 does not allow zero checksums except for
tunneling in specific cases (RFC 6936)?

It seems benign enough to keep the code. Do you have a specific reason
to remove it, beyond reducing LoC?

