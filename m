Return-Path: <netdev+bounces-286801-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKxQCdYnAmrFoQEAu9opvQ
	(envelope-from <netdev+bounces-286801-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:02:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2802B514D04
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 21:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6E693016B10
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 19:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB94C900F;
	Mon, 11 May 2026 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BByl0tDg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD84C901F
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778526099; cv=none; b=LVaV0B3JPdMUxOOwI/C1/GIMhlaTuEePQcTiDVJrfIU8sEXl+RBT2YbHBTwERoZCC94MiLHOLB5U9DI6JhWOXodfniueNkgYUJoBW636hCtWt9zyk+VXQhd6IenThPO17xhQzy5mwE3JOgtQIE5sxjNjVPQMKbob2CU7gqitl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778526099; c=relaxed/simple;
	bh=smi0QfFjJ/pXy+wPRSayNlNgmogl1aS96tF3z1WFN6c=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=HMBcJvKnayHuwppa3Kd4G7MUgpSlQ2MeLUcGlw92T6uX5arBX/ohGKP66AXmBsAhV8WeKPnsaL+4GUarscFV0C7Zck61uYI0zdPANLIH2F0Zqd/IAq+6LvDAI0ltCYuZBTwsJadqKv/21HAEY5vQKnHhZzlL+vD+JV8bZ/PzJoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BByl0tDg; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bdc947aaa3so49493377b3.0
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 12:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778526096; x=1779130896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucU2Gm/Nk/kOZTXm8ln7sSpAKy9+jkch9yKABS+orjU=;
        b=BByl0tDgPBUVYu7j2us1Y0Q5aHGWD9Q53G+Vyw0wsEdz8KJL6mavaOGjcs7/6wTBAS
         l0wN8GHOpEje4XzdcytrrhawTxn4E5QBdlih2eC6N+MaFyf7xHUj14eQjCrtqSp0Cxow
         k5gNIifFY7IZ++NQfl6+GC8MKxRJ6GENJQn+vnEsmJuADCM0x1Vnv+OWpgx5iIqux8JH
         FL1RhadBGYNyRAwFqJRMGT/3fnX23SIZMGObdP20LeaUn7Br7Uwp6gvtPyoGfOQHlqBJ
         YCg96k2ZixH+a9BnyRZIgiXO9fP1bP5x4LM4r0mTiMAVpWcWsrGd0eqMJatUeQZvRNcQ
         ptdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778526096; x=1779130896;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucU2Gm/Nk/kOZTXm8ln7sSpAKy9+jkch9yKABS+orjU=;
        b=lU7ukCNqX5K3YGQS70EW7gsNKkiR+cAEHxYFHG+82DL05cDB+6YXjQj/XBLAq2sLep
         VSwqmsozKdYI9bhRL3u9DLc82imXIf8hQtlBnpASnoEnurmriex7bnJwmBG3mR+yprLV
         RSC3BKeQlipMPPJH4B4ygVuaRUy+uUOIE455XrjXNX6AO19acxq4CYrJZOUfaULzyA+o
         NhMXzDSzFEezTUhwOoU6/VEBSjTtfQjudYK/6LxkpuZB/cHmo8cd2l6dUXqXy5IkVwU3
         s+0BjAtILMY9yhgsyFPdVm6APhwF2VP2sHY0UMRCCBEdG9mJMgYEDMeEjAqcvDcMv9tx
         Sj+g==
X-Gm-Message-State: AOJu0YzefToQwsn5Oichydn5jOCIXmXSP2adhgmbtZ2RecGHqucCjX9A
	5X49EEIpJtKDNeCbtwrz+Vzb7cTm+Ida+e/CJXQvLYZJaCUXo2sG5LF9
X-Gm-Gg: Acq92OGi4IUGfr8UtrVlOPPsFsPLFHafn9rT2tnG15whkuEhvEyS1SU6GtNelg8PDxs
	bBap158Gi2z49kvi8NpKwBeKv6rtvAd8NL6Ye32c6P2vEq00H0OlWQY1pGi0pu7730Uv1mXlrG0
	pRIGJLGAmRxCYpfXS+j2dnXHXLMKTNk7lPX5T1QdDcI89HZq83SWQtwLe/sbH7EBmVsCXWC1odC
	37uvrOF28yHpYtjEqW1t85Jhg2zMoP/tMY26zW5mu8UcJp+dFO1U6U44Lmzc1xZdeVV4fJ5V1D3
	MC052U7+n14QS8dXfv+pEQroSP+5eY0PnheaVd7KI8FG6sc6gzkDrtaK9cmvAAQAvXLdT3rwan2
	GRwi3hKejdOj5Uhe5+U1B6inB60zf1lefT/dGvJeG4tipF/9E8qBXOXaz1OtBOJ57rCCmHI2zL9
	LxQsJnahs3XabsTh0A4UqogAUGTA2+/pbGVNicfokwCuyOdsH+/o5RrVpZY5blb9RV6lNxZAFou
	cc6
X-Received: by 2002:a05:690c:a056:b0:79f:3715:1980 with SMTP id 00721157ae682-7bdf5dc19aemr235993897b3.12.1778526096113;
        Mon, 11 May 2026 12:01:36 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bed8946d5dsm72547227b3.14.2026.05.11.12.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 12:01:35 -0700 (PDT)
Date: Mon, 11 May 2026 15:01:34 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.20208e72aa400@gmail.com>
In-Reply-To: <d962b7e2-7506-4ae6-91c1-58b4e712270c@gmail.com>
References: <20260508-nsim-psp-crypto-v1-0-4b50ed09b794@gmail.com>
 <20260508-nsim-psp-crypto-v1-2-4b50ed09b794@gmail.com>
 <willemdebruijn.kernel.1d153b0dc9762@gmail.com>
 <d962b7e2-7506-4ae6-91c1-58b4e712270c@gmail.com>
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
X-Rspamd-Queue-Id: 2802B514D04
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286801-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,lunn.ch,davemloft.net,google.com,redhat.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Daniel Zahka wrote:
> 
> On 5/11/26 1:01 PM, Willem de Bruijn wrote:
> > Daniel Zahka wrote:
> >> The PSP spec requires the implementations accept 0 checksum in psp-udp
> >> header. Let's take advantage of that to trim netdevsim's psp code
> >> down. psp_dev_encapsulate() already sets uh->check to 0.
> >>
> >> Assisted-by: Claude:claude-opus-4.6
> >> Signed-off-by: Daniel Zahka <daniel.zahka@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> >> ---
> >>   drivers/net/netdevsim/psp.c | 32 --------------------------------
> >>   1 file changed, 32 deletions(-)
> >>
> >> diff --git a/drivers/net/netdevsim/psp.c b/drivers/net/netdevsim/psp.c
> >> index 5073bda60883..75740e2a731f 100644
> >> --- a/drivers/net/netdevsim/psp.c
> >> +++ b/drivers/net/netdevsim/psp.c
> >> @@ -1,8 +1,6 @@
> >>   // SPDX-License-Identifier: GPL-2.0
> >>   
> >> -#include <linux/ip.h>
> >>   #include <linux/skbuff.h>
> >> -#include <net/ip6_checksum.h>
> >>   #include <net/psp.h>
> >>   #include <net/sock.h>
> >>   
> >> @@ -81,36 +79,6 @@ nsim_do_psp(struct sk_buff *skb, struct netdevsim *ns,
> >>   			      skb->len - skb_inner_transport_offset(skb));
> >>   		u64_stats_update_end(&ns->psp.syncp);
> >>   	} else {
> >> -		struct ipv6hdr *ip6h __maybe_unused;
> >> -		struct iphdr *iph;
> >> -		struct udphdr *uh;
> >> -		__wsum csum;
> >> -
> >> -		/* Do not decapsulate. Receive the skb with the udp and psp
> >> -		 * headers still there as if this is a normal udp packet.
> >> -		 * psp_dev_encapsulate() sets udp checksum to 0, so we need to
> >> -		 * provide a valid checksum here, so the skb isn't dropped.
> >> -		 */
> > Perhaps this was here as IPv6 does not allow zero checksums except for
> > tunneling in specific cases (RFC 6936)?
> 
> 
> Yes it was originally here for IPv6. It was needed to make a test case 
> pass that ultimately never got upstreamed (yet). The test basically used 
> the psp_dev_ops::set_config() function to turn psp rx off midflow, and 
> then tried to catch packets with a udp socket listening on port 1000. At 
> the time I didn't realize that I could probably make the test work by 
> opting the socket into a setting for RFC 6936 with setsockopt().

Just curious: which setsockopt is this?

> 
> > It seems benign enough to keep the code. Do you have a specific reason
> > to remove it, beyond reducing LoC?
> 
> 
> It was just to reduce LoC for the series :) I can put it back in if you 
> like,

No, fine to remove then

> though as I mentioned, none of the current tests cover that the 
> psp-udp csum is correct.

.. actually based on this, preferable even

