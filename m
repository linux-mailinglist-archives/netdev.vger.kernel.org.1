Return-Path: <netdev+bounces-254890-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNRLHoCue2lOHwIAu9opvQ
	(envelope-from <netdev+bounces-254890-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:01:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDA0B3C2D
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 20:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 829BF3018087
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 19:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972C27C866;
	Thu, 29 Jan 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0rrEUOB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C0E231836
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769713275; cv=none; b=I5gzhWcCFb9DLEUVOKEQmY0ieuU+Jg1MxGRCwvI49B57s4UWuwhpmP44yNiD6u46xxKqQcR7QMhnnQ1xj4Z8JLNc1wbhZluikjDJmPNDw+yxqKfshG/gzDs5Mxxl4O8rIqI1NyWjsCAlhPtns0vFI7TP2vCJdWvdZhdXR1XHvCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769713275; c=relaxed/simple;
	bh=gqW+WVI2Kp/xMgrwDeQ2bnm9GwNPKLCMEWzZdskcbW0=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XA507aRlt2R1am0OBBTvmYkvZePP+CAJnCfNfm+RolMqww2FMHz2HR2ostRKM1MrMQVpEQoj6ysePiOZEPVIY/WVO1jpcAsVYa3YNzff9D2xNUOBEGWP40hUbwJuLZP936aN0SgVfattViIrexPfp0q4lJsOTaj3qPEBXWPnias=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0rrEUOB; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64969550a1aso1320547d50.1
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 11:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769713273; x=1770318073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mgZ//+9y+pDJAv1RT5LZCmtMscENf3Latwgk1t3stpY=;
        b=F0rrEUOBcPiP9P2LH86wanjmTS9GZdsdQWFAu8SLS/fMtPDx4nOT5yppyPk3VEwfMB
         4OWF/ycovIUjLNrkqembgQKtXJ8fnfw9Gp8/NSD3xaeRZUwnOiInfbnzMY+DgGGHSFM5
         UgN5aGdrmD8uHg8VgRCeB4a8oLGsenPU9yaKLeH7twYDT16wEljDAfp6gSV3/4XH2T+Y
         7oxeKAnAy7JKGMsyC3KYQ1AIDlELQOvphAFeOgCr7n2ATxvulZvpRGbTJoGhOB5Q9/Jb
         4tHqmprQfjPWUkdNB5lH4diI4G47oZ8BouL5A06eR2ZT29i7EWpZDaRSQaY97MjQ97qs
         nPMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769713273; x=1770318073;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mgZ//+9y+pDJAv1RT5LZCmtMscENf3Latwgk1t3stpY=;
        b=stIiwOC9rFhzZ/7AKXPJXn9uJlxagifXzBIbxs8RebbtLNOZsPxICVQenpziHHg0fx
         ficuhMUaGcSNzRW4sY7Jwq9cHDmqCTONpTKRxKK5M4B/0zqhVzByGhzZsQhBRHzosKtU
         6KW4iIWcvfXxVQqgWhti4o2cLeg91Sd5uncQNDTSCU8fg+k8+OmaJvSjo/vRf0z6L4f1
         +TZk1+83MZ7t4+6gL0llZFrqA1c0WSj489SSyGOlD4nLDS36o8IwEo1ciyjk4rferthR
         oNur63C8l0e8mrQAqCIGiSuPyU98PQVS8Ou4ic9s7nvcebJuMUn8UJ7jeYoiJVDvpyby
         Evxw==
X-Forwarded-Encrypted: i=1; AJvYcCWCRRiWnJdoTtr4yrPTV4PZdT5HKxocPNJrqtAEyRqH27tFH2fKfMKPVF+valj6i/cK/SP1avg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrOi67EveGNE1CBLoq20k1WF5n1YU41F09TEKWv41WmmzguQzS
	eEPXGDdXO1lto7hnvfZoCRDxaTkoRxPMZuNiejrzKM7KK3rtGSY4f0CuKoTE6A==
X-Gm-Gg: AZuq6aI8QTTuglVdS9MX8w9EvJnyIgstppP2JBb3tEwba1aDwEKRyBnrFp8aJcISGGG
	o/b6PwXOdoE5ILuilWhU5n+slUQ7NflAJfU+uAIJKhcloBVY7cdDfm1I69TkFWmt3KgNGz9Avvo
	P0hubuGHG3aLcaMT5H3iIs5SThB5ZaxEwSm/EAiZDCDiAY41VPALGNcRj42ceycfVXiu+DjZl66
	5lEH/zYADeFmLo5DEJJ6SEW8LG6yZv1jmXy3Ak2jvDBCf4yl3keTMkZ0/cO1JPVTQnKVSCWLRFs
	j7ZI/I3UREWWHfrfNrhEe5ErAQlt6ZHen2mbQ1FU9j8Pr1uCsmpBtvq0lMWJgK/wFO0v1ILbUKh
	WLN6VxyuO/kRcFYcVEuGeibi5mNTo3nmxACmX/gSnp/3RoLCduWqRa/kbVezwJZcVt0U9xhsfJS
	/leUd0uXI1WGIhJz8dt/ECzfqkOHUIzu1Hx+t56ps8NTQw3gSf70eYR2I9HhY=
X-Received: by 2002:a53:c841:0:b0:63f:9d50:fdfe with SMTP id 956f58d0204a3-649a851f835mr261371d50.56.1769713273174;
        Thu, 29 Jan 2026 11:01:13 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 956f58d0204a3-649960639e2sm2772415d50.1.2026.01.29.11.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 11:01:12 -0800 (PST)
Date: Thu, 29 Jan 2026 14:01:11 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Justin Iurman <justin.iurman@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Tom Herbert <tom@herbertland.com>, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 netdev@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2b9253fe1797@gmail.com>
In-Reply-To: <60fb02d8-77ca-457b-be24-33a3cc7b344b@gmail.com>
References: <20260126194826.236075-1-tom@herbertland.com>
 <20260126194826.236075-3-tom@herbertland.com>
 <willemdebruijn.kernel.235a1f46c52f8@gmail.com>
 <60fb02d8-77ca-457b-be24-33a3cc7b344b@gmail.com>
Subject: Re: [PATCH net-next v5 2/7] ipv6: Cleanup IPv6 TLV definitions
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254890-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,herbertland.com,davemloft.net,kernel.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,herbertland.com:email]
X-Rspamd-Queue-Id: 1CDA0B3C2D
X-Rspamd-Action: no action

Justin Iurman wrote:
> On 1/29/26 06:30, Willem de Bruijn wrote:
> > Tom Herbert wrote:
> >> Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the rest
> >> of the TLV definitions. Label each of the TLV definitions as to whether
> >> they are a Hop-by-Hop option, Destination option, or both.
> >>
> >> Signed-off-by: Tom Herbert <tom@herbertland.com>
> >> ---
> >>   include/uapi/linux/in6.h        | 21 ++++++++++++++-------
> >>   include/uapi/linux/ip6_tunnel.h |  1 -
> >>   2 files changed, 14 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
> >> index 5a47339ef7d7..438283dc5fde 100644
> >> --- a/include/uapi/linux/in6.h
> >> +++ b/include/uapi/linux/in6.h
> >> @@ -140,14 +140,21 @@ struct in6_flowlabel_req {
> >>   
> >>   /*
> >>    *	IPv6 TLV options.
> >> + *
> >> + *	Hop-by-Hop and Destination options share the same number space.
> >> + *	For each option below whether it is a Hop-by-Hop option or
> >> + *	a Destination option is indicated by HBH or DestOpt.
> >>    */
> >> -#define IPV6_TLV_PAD1		0
> >> -#define IPV6_TLV_PADN		1
> >> -#define IPV6_TLV_ROUTERALERT	5
> >> -#define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
> >> -#define IPV6_TLV_IOAM		49	/* RFC 9486 */
> >> -#define IPV6_TLV_JUMBO		194
> >> -#define IPV6_TLV_HAO		201	/* home address option */
> >> +#define IPV6_TLV_PAD1		0	/* HBH or DestOpt */
> >> +#define IPV6_TLV_PADN		1	/* HBH or DestOpt */
> >> +#define IPV6_TLV_TNL_ENCAP_LIMIT 4	/* RFC 2473, DestOpt */
> >> +#define IPV6_TLV_ROUTERALERT	5	/* HBH */
> >> +#define IPV6_TLV_CALIPSO	7	/* RFC 5570, HBH */
> >> +#define IPV6_TLV_IOAM		49	/* RFC 9486, HBH or Destopt
> >> +					 * IOAM sent and rcvd as HBH
> > 
> > Explicit labeling with HBH or Destopt is quite informative.
> > 
> > Does this mean that IPV6_TLV_IOAM should also be accepted in ip6_parse_tlv
> > in the Destopt branch? RFC 9486 indeed did reserve a number.
> 
> Nope, not right now. The only IOAM option currently implemented in the 
> kernel is the Pre-allocated Trace, which uses a Hop-by-Hop option. It 
> wouldn't make sense to have it in a Destination option, although you 
> could (i.e., it's not forbidden, just weird). Actually, the only IOAM 
> option that would make sense to carry in a Destination Option is the 
> Edge-to-Edge (E2E), but it's not implemented in the kernel. Should it be 
> implemented at some point, then yes, you'd have IPV6_TLV_IOAM in the 
> Destopt branch as well.

Sounds great. Thanks for that context.

