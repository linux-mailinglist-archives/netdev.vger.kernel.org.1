Return-Path: <netdev+bounces-252549-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMRcAp+jcmkOnwAAu9opvQ
	(envelope-from <netdev+bounces-252549-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:24:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 090B76E245
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 23:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F233300119F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 22:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063723C1FD9;
	Thu, 22 Jan 2026 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0i+Rfmw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZv95pIu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BBA347BC7
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 22:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769120663; cv=none; b=oT7rrTsVSUqv4qheH0cUVWuBl7G9QBLpIsADco7zgDpxXsH4cbfeg9a4q6JZHXPMO+rapLZYW42gR+wqcgeerOm00JFddpE8ip5DwEw6KaVq97dPlP2DWRXWdc/EluzLQwCJwZGJowb/D0/7531Q1EY0Anb19GpaHlxV9vB0z4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769120663; c=relaxed/simple;
	bh=DiPa7Q5SyHrDKDASlXtu3CgQeH2zd1RTCCWE5zGdQAs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=py9pRIjrNOV+ebVFuFmGIhdi/g6FqdBAO0iA/L0wVYDjZgqGBymQ8V+IENeP3Dgwhth4XqKWxc3ut+25yV2YzMX0yEyB8GGo3Jb9XbtzHOBaOde7lqZyLRAb7ntx4xBHajOnVtBO50GPQEP66P+iiu4ZkAx8ropz2OmklAVQ9lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0i+Rfmw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=cZv95pIu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769120656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=omTVczBbVt8ifJW6lKwuidDNjM49gK9rBxPnH3tJLu4=;
	b=S0i+RfmwyDU1zlWy3cI3bVSubaOL9DaREFVZ9M04vvZYRwScemunyOLNNgzs3gG9N7nfZh
	XPuFpM9CZshF1rDqgCNtLSvNmcrmuwawBC/QkM14sBtkvNWfphlWgoESVxytF0StlAXTi7
	g3US3Mg2kkuLT5qym56pjB5WepwrGL4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-uWpVnkHpOVKBTfjCCeqBaA-1; Thu, 22 Jan 2026 17:24:12 -0500
X-MC-Unique: uWpVnkHpOVKBTfjCCeqBaA-1
X-Mimecast-MFC-AGG-ID: uWpVnkHpOVKBTfjCCeqBaA_1769120652
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d5bd981c8so12130485e9.0
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 14:24:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1769120651; x=1769725451; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=omTVczBbVt8ifJW6lKwuidDNjM49gK9rBxPnH3tJLu4=;
        b=cZv95pIufqW40G+y0zYjRxdjJjLZpVVLaH8zY8tw5pMvUsARiY3/jLttc4QFJpftgS
         oSAEyk29QwZpZp27EYtC3/4EcZkwMf8l7O9TJK6HFQKUQBJbGY/QN6sRruWmEDZ+MruN
         rgDZ523gQnslE4f6jY+cLJjjM0rewcULNEAhmWksrWKvqt9mhqRtoK0dj7PqVQ7vahSs
         jtYjkZLCUpsS6T+K+Hum7+F/3QbaB5INq4BX6Yj3p5JOyUZi61p/Yg+RN8xKxznS9eq7
         Y35xZC1HH8cFXiu47nL3pSkOwXd4xTI7jLe5wvyHwuKxvEJ9ChEBlH0VADOlx5LCyN1F
         4VJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769120651; x=1769725451;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=omTVczBbVt8ifJW6lKwuidDNjM49gK9rBxPnH3tJLu4=;
        b=WNVYXzSr1t/5iGGsSq8MzY9stuYr1H7MyFgRkBp8sIoujxWF37I6Pe2xvJLWcRGh3j
         7eafC8vWhqR/UQo+1OXQw7GhX3MyeHkSv6ubQ3p0yNMYi5pbZJTYbBbi4Qd0ceBrPMTs
         aZyIa7F1YM2GKOu3N/X0c8Un0qqeFt08rSUl0kh2ISZsdLngFPv5shO9/D4iArok0qDR
         l3PPEjxQXW5axbtNH9hVGQ89gFX5b78Qlj4QTT8k0yjZWa2nILPVtv4QzsQ/xGm9x6bK
         83sdwOChaOLjE01kOTtAO2rWDJt8HVL30fTLcUHWNovwrA18U8mtMqb/m6T9Dabz4RkA
         9FdA==
X-Gm-Message-State: AOJu0YyDs1hsIV876hk9TRds6DFxLRderrMcWgEVilYIWMW+BD7oj4bG
	qYNrM3E4Ijptc8D1yIcPo1r/wBl7OSw5cCmqM8B6X/5FBqabmj8qE2qgbqdvr++vax09uvTmzPf
	64G7RpaTi9bs/iZDJ31dKAXxnd65c0MWe0CEDHhVBvfx4xLlyEyrDQUgU6w==
X-Gm-Gg: AZuq6aJtpRlsU0IYiwybrcmKFiVXU5XyjzHV8VVMYtRVQwdNnVlFxUq6Qu08jZctdkk
	LujxRRdf9E7vBg7ja4RRrKv78j+Ndn6t1qFBkFbob2Tbt6JGbs8AzlQk6v8bVDGdBq0bv/3ldDW
	YpnYl59iOzGAbNR8hNeDzEOrdBkCcOVUntEanOfWr6muJjH8lgPrD6m23MjOqeE0r7uSJPunaBq
	w17+Ue6YO2i/wdHZssG9Rl2HezCLt9o/157GxI3zlYCmb9wVoxeLnOFNm4jYJ0BB3K0b6cJOjff
	l5Kgqbzl+9ZiAI9z2r4u4q/nNpZWavwJ+s6nZbEeFSDKQTXIeUrddNQgmePnnjnjgLHmrnPBdoI
	PKAS3qeAiMdjMjc1f/VohCDKml9yO3uKoMRtnILFut8XZt0k=
X-Received: by 2002:a05:600c:35d2:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4804c9afd36mr19931375e9.24.1769120651571;
        Thu, 22 Jan 2026 14:24:11 -0800 (PST)
X-Received: by 2002:a05:600c:35d2:b0:475:de14:db1e with SMTP id 5b1f17b1804b1-4804c9afd36mr19931095e9.24.1769120651174;
        Thu, 22 Jan 2026 14:24:11 -0800 (PST)
Received: from localhost (net-37-117-189-93.cust.vodafonedsl.it. [37.117.189.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c02c91sm1795435f8f.9.2026.01.22.14.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 14:24:10 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 =?utf-8?Q?Th=C3=A9o?=
 Lebrun <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 3/8] cadence: macb: Add page pool support
 handle multi-descriptor frame rx
In-Reply-To: <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch>
References: <20260115222531.313002-1-pvalerio@redhat.com>
 <20260115222531.313002-4-pvalerio@redhat.com>
 <4c74c2c4-7a47-45ff-be17-485e0702cc37@lunn.ch>
Date: Thu, 22 Jan 2026 23:24:05 +0100
Message-ID: <87cy315lru.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-252549-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pvalerio@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 090B76E245
X-Rspamd-Action: no action

On 16 Jan 2026 at 06:16:16 PM, Andrew Lunn <andrew@lunn.ch> wrote:

> On Thu, Jan 15, 2026 at 11:25:26PM +0100, Paolo Valerio wrote:
>> Use the page pool allocator for the data buffers and enable skb recycling
>> support, instead of relying on netdev_alloc_skb allocating the entire skb
>> during the refill.
>
> Do you have any benchmark numbers for this change? Often swapping to
> page pool improves the performance of the driver, and i use it as a
> selling point for doing the conversion, independent of XDP.
>

I finally got the chance to get my hands on the board.

On the rpi5 I simply run xdp-bench in skb-mode to drop and collect the
stats.

Page size is 4k and stats include the driver consuming a full page
setting mtu such that rx_buffer_size + overhead exceed half page and the
other way around for 2 fragments.

             |    64     |    128    |
  baseline   |  533,158  |  531,618  |
  pp page    |  530,929  |  529,682  |
  pp 2 frags |  530,781  |  529,116  |

> Thanks
> 	Andrew


