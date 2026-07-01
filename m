Return-Path: <netdev+bounces-303484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aZyWAvG1RGpfzQoAu9opvQ
	(envelope-from <netdev+bounces-303484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:38:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED31E6EA46A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 08:38:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gkLUrhiR;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303484-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303484-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F4105300B089
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 06:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402003ACEFF;
	Wed,  1 Jul 2026 06:38:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56837646B
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 06:38:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887914; cv=none; b=LlHa35yDjONYqFlGdUtu/BLkn6dyyMbWZNiBGKcWf/OlNfiaEGNZeu9dHOGLxxQcuf2mQ9UKOS16DR5LqU//8/JKW7q/TdzuzVZIxarjSKIo7Pd8bCK0oOiecwD/O16BnTGZrqHn+i1RY9/hLY32zF8amvtF6l9Mx5KbpkE/qY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887914; c=relaxed/simple;
	bh=Z7Et1qcltuhegTb6nldX/afTXnjxUFZVMUb5RDeyIrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZoJF3U2UF7cHVhlPyr/lV/78TBkm5uroBpqwqoUJ1hFdCGiig5d2xWDe0iGRWUYuYEbt0tpF7V30oEBZtbXqhIZ8zWMDsfDhn4tTN7dvc7TkhuLYl7F85lygyLHTHMYiDRvMMrT0dd3Uzh31QL6JxOA3PueTKcBhHnj0Gu3wJv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gkLUrhiR; arc=none smtp.client-ip=74.125.82.178
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so585891eec.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782887912; x=1783492712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2LwB1NkOwDwoZvgqDuV2zTe52TJOeOo2nEEjVYmEQD0=;
        b=gkLUrhiRzUuLU5j21LZmpEKuCG3JRcEwjaQ5S6Dq2U3P8X0fb3guqT57KnpJVMbEJp
         9OltiV1EzjTeMTYV7KBf3JWNFsXdlhdY8YuA6DcusdXGjpfH6FN9rZ9Kh0/NIEfeMiTy
         aBOT3/zwH2R9NOxFlqlBWnjFU9lzllkjSNyyYxe0xZVt5e76liEteGp0yd3xN+X8xTyV
         mRkgLQi+h2cr1kD7vCs676J3vrBdBXbwmavNpiSovwcAdkvn+MYRUVGAS3yiDtvNaVN8
         QUjlCIHM84l2RbrsI6okyzmwGWl2uyS+ltNKvnGuLDGGKXYIt4yEA9ljucPEPoCXGYn6
         Si6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782887912; x=1783492712;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2LwB1NkOwDwoZvgqDuV2zTe52TJOeOo2nEEjVYmEQD0=;
        b=rWjTBNuJEKO/7nlHms0PiTFTn1k+GnGw1kRIwrx2p4ps5UaYpONtUUGz7sUOPS3nV9
         0qZtoYOl5QRU06HjKlUlFvY6I0Vy3P6BD57+TUDh1TWFgTDv3E+EFS35LFz96bLc9+Sn
         nalktXYBxWEIJxMNHHexFaprA4GyUmoXBl6W9Fa+Z+zxB/llImQ+ypW9rz8+Cxh4KvNu
         jl5TC7XlprPoh2XK2peYnmgP5sK9Zd6hBonP0tSa8JjBmsTOc6mNMZ07UPmzREDrgZIU
         qvTDrrgJyfOekWC3SBq8ma/A+mP/StphuHjmp153qH+dpQqZzUI/67CADxMJuWedoYzr
         jrxw==
X-Forwarded-Encrypted: i=1; AHgh+Rrm2gvN1BrtrbmrHqz9V6GJbdXW5HplDfsEkzhnt9YW5g9MCDnLwvVIJqnhKNIuSyf4GIqDvgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8FfXSY62Lhqk8mAgcrCU7dg0hniiWI8I6xTsx9ez62SVdPm5q
	9L2dffbp8klQxFyUqykw0PropPCcQuEE8FX9h8T2aAx1STyPooVQVhr2
X-Gm-Gg: AfdE7cne26EVd8FjyIg9B6MqCPkT/I3+7fJuMkudbHw3XlrCdc271/q6Ejus37t6aw3
	bT+hxpmdhfDZf9qv0HYFQZt6hj/MfTuzcvjdazdeNBZyPXFyEjXjTGGvqO6FSfaZPhRm87PT85q
	3DsX5FynA0fb+4Vo9lfk9+cwiDZv1Sg8jI6N2so7NdBzqmILm/RlWD/uu35a62xe6smuuGFHtcd
	oKBrXKsWaFV2DDo04iABwLQP5Ur3HThJREo0YofOZuzS2bQBH38ev4VUW/ck33u1YEtauieaMAu
	XjykKlY1QGH5gMVq743iVyemNXqJ0kajZuzK3lcfeovHrujQc4I1gBbvXiJISlsmdpXNBI+kmml
	dhTdxOBCxBAEmPjvciTSzJV7+Iw99hNpRHXppXv4WKbrxNF2fFqISc+1irzgLhukc8ba93/bZ+1
	1C5zQhTZnmhdcupzfMzjOnkC0=
X-Received: by 2002:a05:7300:d50b:b0:30c:1865:d9e0 with SMTP id 5a478bee46e88-30eff07d7fdmr475848eec.16.1782887911791;
        Tue, 30 Jun 2026 23:38:31 -0700 (PDT)
Received: from nbai25050028.. ([2403:8600:2090:6f:c5d7:7505:b0e9:be5e])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ef2688b6esm7159725eec.30.2026.06.30.23.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:38:31 -0700 (PDT)
From: Aniket Negi <aniket.negi03@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aniket.negi@airoha.com
Subject: Re: [PATCH] net: airoha: fix MIB stats collection to be lossless
Date: Wed,  1 Jul 2026 12:08:23 +0530
Message-ID: <20260701063823.239783-1-aniket.negi03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <akPQ7P1Dqb00oWa3@lore-desk>
References: <akPQ7P1Dqb00oWa3@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303484-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:lorenzo@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-arm-kernel@lists.infradead.org,m:linux-mediatek@lists.infradead.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:aniket.negi@airoha.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aniketnegi03@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED31E6EA46A

Hi Lorenzo,

Thank you for the detailed review and suggestions!

> > +	/* TX - 64-bit H+L registers: hw accumulates the total, read directly. =
> */
> >  	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_H(port->id));
> > -	dev->stats.tx_ok_pkts += ((u64)val << 32);
> > -	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
> > -	dev->stats.tx_ok_pkts += val;
> > +	dev->stats.tx_ok_pkts = (u64)val << 32;
> 
> I guess it is more readable to store REG_FE_GDM_TX_OK_PKT_CNT_L() read in v=
> al
> here. Something like:
> 
> 	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L(port->id));
> 	dev->stats.tx_ok_pkts += val;
> 
> This apply even to occurrence below
Agreed. I'll store CNT_L read in val first to improve readability.

> > +	dev->stats.tx_ok_pkts += airoha_fe_rr(eth, REG_FE_GDM_TX_OK_PKT_CNT_L=
> (port->id));
> > =20
> >  	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_H(port->id));
> > -	dev->stats.tx_ok_bytes += ((u64)val << 32);
> > -	val = airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT_L(port->id));
> > -	dev->stats.tx_ok_bytes += val;
> > +	dev->stats.tx_ok_bytes = (u64)val << 32;
> > +	dev->stats.tx_ok_bytes += airoha_fe_rr(eth, REG_FE_GDM_TX_OK_BYTE_CNT=
> _L(port->id));
> > =20
> > +	/* TX - 32-bit registers: accumulate delta to handle wrap-around. */
> >  	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_DROP_CNT(port->id));
> > -	dev->stats.tx_drops += val;
> > +	dev->stats.tx_drops += (u32)(val - dev->stats.hw_prev_stats.tx_drops);
> > +	dev->stats.hw_prev_stats.tx_drops = val;
> > =20
> >  	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_BC_CNT(port->id));
> > -	dev->stats.tx_broadcast += val;
> > +	dev->stats.tx_broadcast += (u32)(val - dev->stats.hw_prev_stats.tx_br=
> oadcast);
> > +	dev->stats.hw_prev_stats.tx_broadcast = val;
> > =20
> >  	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_MC_CNT(port->id));
> > -	dev->stats.tx_multicast += val;
> > +	dev->stats.tx_multicast += (u32)(val - dev->stats.hw_prev_stats.tx_mu=
> lticast);
> > +	dev->stats.hw_prev_stats.tx_multicast = val;
> > =20
> >  	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_RUNT_CNT(port->id));
> > -	dev->stats.tx_len[i] += val;
> > +	dev->stats.tx_len[i] += (u32)(val - dev->stats.hw_prev_stats.tx_len[i=
> ]);
> > +	dev->stats.hw_prev_stats.tx_len[i] = val;
> > =20
> >  	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_H(port->id));
> > -	dev->stats.tx_len[i] += ((u64)val << 32);
> > -	val = airoha_fe_rr(eth, REG_FE_GDM_TX_ETH_E64_CNT_L(port->id));
> > -	dev->stats.tx_len[i++] += val;
> > +	dev->stats.tx_len[i] += (u64)val << 32;
>  
> Since now we do not reset MIB counters, this is wrong, you can't use "+="

You are absolutely right, since MIB counters are no longer cleared, using "+=" for E64 counter would cause double counting each iteration. This was missed in the patch, specifically for the case where runt count(32 bit) and E64 counter (64 bit) need to be combined in the same counter. 

I'll fix this by using separate accumulator fields to "tx_runt_accum/rx_runt_accum" to track the runt deltas, then compute tx_len[i] as tx_len[i]= tx_runt_accum + E64_CNT (H+L).

> >  	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_RUNT_CNT(port->id));
> > -	dev->stats.rx_len[i] += val;
> > +	dev->stats.rx_len[i] += (u32)(val - dev->stats.hw_prev_stats.rx_len[i=
> ]);
> > +	dev->stats.hw_prev_stats.rx_len[i] = val;
> > =20
> >  	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_H(port->id));
> > -	dev->stats.rx_len[i] += ((u64)val << 32);
> > -	val = airoha_fe_rr(eth, REG_FE_GDM_RX_ETH_E64_CNT_L(port->id));
> > -	dev->stats.rx_len[i++] += val;
> > +	dev->stats.rx_len[i] += (u64)val << 32;
> 
> same here.

Acked. The same approach above will be applied to rx_len[i]. 

> > +
> > +	struct {
> > +	/* Previous HW register values for 32-bit counter delta tracking.
> > +	 * Storing the last seen value and accumulating (u32)(curr - prev)
> > +	 * in 64-bit software counter & handles wrap-around transparently
> > +	 * via unsigned arithmetic. These fields are never reported to
> > +	 * userspace.
> > +	 */
> 
> can you please align the comment here?

Will fix the comment alignment.

> 
> > +		u32 tx_drops;
> > +		u32 tx_broadcast;
> > +		u32 tx_multicast;
> > +		u32 tx_len[7];
> > +		u32 rx_drops;
> > +		u32 rx_broadcast;
> > +		u32 rx_multicast;
> > +		u32 rx_errors;
> > +		u32 rx_crc_error;
> > +		u32 rx_over_errors;
> > +		u32 rx_fragment;
> > +		u32 rx_jabber;
> > +		u32 rx_len[7];
> > +	} hw_prev_stats;
> 
> Maybe something like "prev_val32" ?
> 
> Will update the name of struct to hold prev counter from hw_pre_stats to prev_val32.

Good suggestion. However, since the struct hw_prev_stats now contains both u32 (previous register value) and u64 (runt accumulators) fields. I'll rename it to "prev_mib_state" to better reflect its dual purpose of storing previous register values for delta calculation and accumulators for combined counters. 
  
Regards,
Aniket Negi


