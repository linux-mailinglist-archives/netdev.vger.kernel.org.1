Return-Path: <netdev+bounces-292396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mE3EBSQgF2rw5AcAu9opvQ
	(envelope-from <netdev+bounces-292396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:47:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6FD5E7FAC
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 18:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1EECE3004DB2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF0043E49D;
	Wed, 27 May 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C2BVTj38"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF9442849C
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900446; cv=none; b=InM5cIOOBXvoxEXFgyLihBmFG4sJDM/DATabK19U3qViuJWhJRHjywIojSmteIeXqNtJ7+LXb564KAdeUJXdKIm4INYfOcwMMUlMm7QVgD6mwqCx1U70c/VKFyJwgFS6fx5vpXNtGIIDtTwFspTTBX+LJkWaL0LNN3ihW5R7o/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900446; c=relaxed/simple;
	bh=KEbE4svTZCJ4CMTmlkD9K4WwWErEOzbI84sk2/lrjzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBlhDIhrGtA1nASwqmiPhiu4/YCjZe0jJdM6E6+eluF92vuk5fQ4bEMBORTRjJ7VAX1kvZBCJp5x07D6ijjSLvujDLJJthuNHVZ5q74biUmKCO2kRriFa4MspiHuamqs0k8YgWCrrx3KM+sC19NCsPrRD/dU8UIBm/H39mMjSgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C2BVTj38; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48984d29fe3so125616815e9.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779900441; x=1780505241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hA7zOJ0F5K4FLOOlGz2R0ApuT58tsO1PFrJ0v9TqhY=;
        b=C2BVTj38pA7hzmoa2IbHAVdv/sEzF6qPTulBAEVWU1qxy3CUjV8wfrpTkuqPuEUWS+
         emUKcGoxmpLYQ5sBlxbPFglclcFgRaojP9WQP9rudLR+cFP00txDvXn25pbst5aCJc2d
         uCh4a62y+9J5pBApFYji1i+YP2B5xFoFAHUH8SePjj+5vDyhrlxSqzMDCktVjeJ1li+m
         rY8YPFMpYJOSJhYxmZOKwK8BbxMUs619j1L0uzDnZFXKBTACQVv2851ujJ1donSLouMg
         A1htKa8BYvPR4W/ApbW9L9CWEK6LroEqMS7wIERxg7cYwkcnUHUdzglPfaDQUo2urhmk
         l4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900441; x=1780505241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1hA7zOJ0F5K4FLOOlGz2R0ApuT58tsO1PFrJ0v9TqhY=;
        b=SyZXZMRiF61aznW2Mb2HaXveRwhp/1mwOn6B7+nIQMVq2xosqJP2ULmolbOdqVGwcD
         rhA8nbLtEgPlxX1I3M8xBYz1hO3tNEZ7vRSXlHYOonZ1uXTFGY8pE8tGdyDYrhcnQl/v
         tkBsD4a5EJ/wknO099qA52K+h5CDALplG/6sHWViVVhbifqNA8isaISElLaXSi3JTCTq
         MT7/xfmepPR4RNqCvJzqLiNjbB73X6trj07i78w96inI2zGxw4tyrtL8idcLzGY6JYdn
         gy4KPEWIu25Ky0wW/9X/+1tfejxnoTI52aa7i1D22mtylYHWklTCH/XEftcbAwzZU3wS
         HFgg==
X-Forwarded-Encrypted: i=1; AFNElJ828v2/lKCo3WXnEntSqtf6xlXQVvAAgWAJ/PP8/TUEbW2rr7h3QBaV2gvVChg39Ow7E66RlHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZ7cXrHj3a6bwdSmEMIpbCtfYRhqeRt0282KGCN6Ie0uyTHQk
	jtzwFYzJLtc0IAcVFn66lPAmEq77MUJw6tzNagSEp9GS6cDlNVsNNaVZ
X-Gm-Gg: Acq92OHT/3CbPrRRu6hCY0Z6MiOqGM1rUJ+wEQD/Yu09SexH1o0S9178r0AqHzGVgZE
	BKdh2e+oFzyDIfn3k1GpZSymPcN7Qz6GAJ3vDrtD8pnaqPV22IvOZ1nirdmLrADCeZokGaKu2wm
	fxIr8x/h3HwwMw7YEHz4bpe52Cp0/Ea385rpFvoRDKVVfOsxpOjhOuSovl/2ESgWu2XrYCxEBRt
	2EqB9BeH4zg0bOziGeu803sXtBFVTkMroUvhHiqLJseCzkmhEgtKG9+t5WI6JcHnzf0HbT/N+oS
	7hQmD7WWWR4VOryGftgUlhqfwbVM4di22F5gjk6k9bGRavsS4pYOnm2439oYBuYuwGWZO8MfDiL
	b23fsYFWdJ2eNEvyt4C5sOuNaV/zWuDqemoHR9x2IenO/GiEqoKsP4ILlfbrAjdVg+8inBTvU2r
	E3zEYyI5/kO3ieJU3f4K+TneprG1DqXOqlLWpzM7Jz03LRBJl7YoDZIrI=
X-Received: by 2002:a05:600c:4ecc:b0:485:30d4:6b9e with SMTP id 5b1f17b1804b1-490426cd8a4mr372502495e9.21.1779900440938;
        Wed, 27 May 2026 09:47:20 -0700 (PDT)
Received: from localhost.localdomain ([87.236.194.191])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb558a47sm7591732f8f.15.2026.05.27.09.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:47:19 -0700 (PDT)
From: Petr Wozniak <petr.wozniak@gmail.com>
To: sd@queasysnail.net
Cc: Petr Wozniak <petr.wozniak@gmail.com>,
	netdev@vger.kernel.org,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net
Subject: Re: [PATCH net-next] xfrm: fix xfrm_dev_offload_ok() returning true for software SAs
Date: Wed, 27 May 2026 18:47:17 +0200
Message-ID: <20260527164717.23624-1-petr.wozniak@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260527140948.78243-1-petr.wozniak@gmail.com>
References: <20260527140948.78243-1-petr.wozniak@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292396-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,secunet.com,gondor.apana.org.au,davemloft.net];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrwozniak@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1A6FD5E7FAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-27, Sabrina Dubroca wrote:
> Incorrectly? IPsec in SW with GSO is a valid setup. I think you're
> breaking that with your patch.

Fair point — SW IPsec with GSO is intentional and the patch is too broad.

The actual observable bug on this platform (MT7988A, EIP-197 async crypto):

  xfrm_dev_offload_ok() → true (SW SA, dev == NULL)
  → esp4_gso_encap() marks the skb
  → validate_xmit_xfrm() → esp_xmit() → async crypto → -EINPROGRESS
  → validate_xmit_xfrm() returns NULL

On bridge interfaces (noqueue qdisc), __dev_queue_xmit() takes the
direct branch, initialises rc = -ENOMEM and never overwrites it
when skb is NULL → ENOMEM on every packet.

On real netdevs with a qdisc, sch_direct_xmit() handles NULL
gracefully and async completion via xfrm_dev_resume() delivers
the packet correctly.

Where would you suggest the actual fix should go — in the
bridge/noqueue path, or in validate_xmit_xfrm() / sch_direct_xmit()?

Petr

