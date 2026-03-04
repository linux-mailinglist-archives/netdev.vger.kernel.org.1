Return-Path: <netdev+bounces-263541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFXtBV6Qp2lKiQAAu9opvQ
	(envelope-from <netdev+bounces-263541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:52:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B060F1F9B3B
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF2D5303EB58
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1D2322C78;
	Wed,  4 Mar 2026 01:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PtsiLxOK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEFE3168EB
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 01:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589147; cv=none; b=l7Tkb4cmPSsgnDw8s0pNjN4MRVrJUU4//3wGj+YqN/XdMKdI2KlPAo4tTCUAxOIveR9wmkKKw5j+1Gjuq32eObgaWX4IPTRjzB7xmnqJBgAumccoSluKk3IkLrWGVLKcWXBn2W35DpXYaoDimlBEqGbspAOPkFk9oBoMipFHAkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589147; c=relaxed/simple;
	bh=rPTY48Iubdpu3NXqy8HT4V9ZO1OkhsoHpesXWdjQcyo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GCV82pEqruWaJDrLkQieL9hd4XUC3e8X1suv03U77hEDNL3gIVqiNV+2SFlJBl6KyC7GkLmttUypkOZ/urCAzJ99mOVFRpO9nXiwFzd1KT+hUvLDEXrXpiwHaxi/hT1L2DAok7/m4iH99Gv/0Sp5td0CWs5Ob8YCodrD6e27HXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PtsiLxOK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ad9516a653so26577245ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 17:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772589146; x=1773193946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIvIgLHoIA/uDprnWtl8reZar/8ysIY1y6EtxkybfUM=;
        b=PtsiLxOKAnZ9tEhClG8ESRh2vTYOUoFW39PAyzPvM5/CjswgMRNrsvDrdLVJj6wx6L
         29HeK2xhCarltxdHnHT9pOVsJxTjtybYhAIWQsLRWeHtDbJj9LrUmp++fcaB5vkoc1B4
         jv39AlhFk/I/pPh4HQjXDSaXzPbwat5sffDD9SreITKtI3O9jigvtCv8/ELdRyqCm7VO
         Tx9w1KVp1oWgaVt5nwQjww9GMlDgvttVYE6csaeT91UQzVLDDz15J9uK7X77AqNOVPTq
         u0BTqnSCi4A2220uY1wQXnnDbaFd6Qk35g8utMutbyc7OnQfSk2WJF3117rKGfsKY/w8
         wo5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772589146; x=1773193946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aIvIgLHoIA/uDprnWtl8reZar/8ysIY1y6EtxkybfUM=;
        b=oBDqfJdLZwEC5e6pBfPniqd/Ndgc23ZhIvVzpKsRW/HBG9pnvVzuow0R7CBdeOo+a1
         Qo13q+FYER4Ach9HMXAUnPP3Gncf3WVnmq4ebs0pyY6CYCTmHEdkOg3BRuNJUA0GV92N
         XX2z3JiC7YQ/S/m7GU3jH415EmwwBusoxCvMuTK/srj4xQcWyTQwbjeGCzUyo8wj7eVA
         Mza11j2SDnePFlL1ZFvXDmqv19p+objBcCnLM8jHbCAEcqr4vu4rT3H+CsnqUF3aOXDW
         4tpGmYAnlLOUM7l9QMihU4fs85rGH4FbthwZlI3DEx4hVVui9+HUJStsKSN1HWbNcp7e
         WIQg==
X-Forwarded-Encrypted: i=1; AJvYcCVpA0fvb1zAFrv6rvj11/RhauIe/BHqhlji3hJpuHK3b6XP7sIwhbd49rk6Ha8BdRLYGhAP5rs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykcp6DIF3dIBAus4OXC6dA61bANSFctbuoHlB7puk28P49anF6
	7wSOpFuePblfsTc55Pi76L1TPMkeA9LdrmWMobhNO8AeT39ECph+/GtZ
X-Gm-Gg: ATEYQzwWru7skM9aYG6vqMMzd7dJAdBqgrJURj9wbdiKurIQ4PWZwLRmpigG3M/K9XJ
	etwjM+CVOvXuVNDY8LbNmfn7visthvnFY0AN1y8j4S6SsFoannQ6cfdPotwY0Te/nU47j57j3ZU
	W8cVG/GgGiJRKtzqnSeoUYAmmphSkB9AKYzAVDJ5daC10U6t+UxRJi2KJ+WeRLbuCnN0E+oQrTF
	pI3aDvIXlbU9NEWNdvBwCovPMwkqy7upY+aZ05znbcHbo/bCGYJAWxRYR0ZHgTsIQoHKPc0R2yL
	ROibtShlHRg4xr9WmHY45kV6o0RqRE6yQGJV8qQ08N8QdDEKVSe90uudoJWBsPH4NMqq66X/5rL
	hBhLEt939dsgovxdKGmbAXx/4ZCCT9TF+gv4H+Tofm3Rg/7OuxLDgxn5gEOHLa1zdl5ZvJuigkZ
	Qkzv9FcOcgYY8MGP3ba4hCM/q8uGyCeghR7lY+tRaaTHYwphZmK2DxpBdT6wiCeNMZCTm6ZdTp7
	rcCkQ9Jutfg
X-Received: by 2002:a17:902:fc8d:b0:2ae:5426:da46 with SMTP id d9443c01a7336-2ae6aa8e99fmr5074385ad.29.1772589145620;
        Tue, 03 Mar 2026 17:52:25 -0800 (PST)
Received: from dpc2500057.. (fsb6a9315e.tkyc502.ap.nuro.jp. [182.169.49.94])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c20d3sm251074665ad.25.2026.03.03.17.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 17:52:25 -0800 (PST)
From: Keita Morisaki <kmta1236@gmail.com>
To: jakub@cloudflare.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kmta1236@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	linux-kernel@vger.kernel.org,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next v2] tcp: shrink per-packet memset in __tcp_transmit_skb()
Date: Wed,  4 Mar 2026 10:52:15 +0900
Message-Id: <20260304015215.755299-1-kmta1236@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <87bjh5drmk.fsf@cloudflare.com>
References: <87bjh5drmk.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B060F1F9B3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-263541-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kmta1236@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

> Loosely related, noticed while reviewing - tcp_out_options.hash_size
> looks unused:
>
>  * MD5 - always 16
>  * AO - uses tcp_ao_maclen()

Great catch. I will follow up.

> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

Thank you for the review, Jakub.

