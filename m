Return-Path: <netdev+bounces-288160-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC91JnKIBmr0kQIAu9opvQ
	(envelope-from <netdev+bounces-288160-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:44:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E6548D09
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 04:44:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F1D0305748B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 02:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363833C2779;
	Fri, 15 May 2026 02:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2m2i4bv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A223C0604
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 02:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778812945; cv=none; b=OTE5q/UwGRR09f1FiyN66efvCIKXfM64sLKkvIKloRCGbR3IwtT9+ZgTO3GeK+JJ1AxesfoOYZ1BpaVsF/Qx14nVqjSXnhykRYQ4R4We15kKWraI9LiIIa9S5sB1Y9LKmMS2uvVeclGU3tcgbFfQheU3e+/womLivVpo2VpTzcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778812945; c=relaxed/simple;
	bh=s84cgZU+PxOHkFtUEmCMt5cz6GMpjzxhGUeHp5kdZHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jkZbvbe6uBQh2ALkRvoPHWMmYJxn4OdCpk0i16MEFCmB2Rfm8vB1giy70PfU0/pwI9xxoBSPudGvaRy+DmqvgJZD9QKP1RY+yQAL34/Y0aa16W9D4McpklnVjCMlgGUjJbi1AE1/OYRoQIXp2+MYkrasxth8hkLe9bDmreaZNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2m2i4bv; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-30246cfd41aso3006772eec.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 19:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778812943; x=1779417743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8rLW09dDhgcqjvD8OY2KOZGl5mvXel79GUCzEbR1uwA=;
        b=n2m2i4bvX66bDIjR34Ue2gm9m78aBax4qkKlKqWNdPk7BQ6vJGv+wt7GbZGXLlflW5
         n8Eab0nblFoc6FvrkeFC35CpCZm8Ccf4n+Xabc7pNFxtegFk6uHuv/vUCQmTp7znP0Pu
         EjQSTLsq9055ojgmHtn3jDsvazgabo+lcQJG0vkR2g0/iIDVARmTQmgiRag4wXBmloQi
         zB4CASi75DQ0kz2bxDnEaKnlRWq72AWZsl+oSfOaMgJbDl6XKr+PZzo6MqGehx5C77d5
         sNnoO4LN+6KFX1OVGmB/iRMgPRpL4pe+3zAS/VoDerDPmGzYttcbqjcbTblKT73J9mHn
         LDLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778812943; x=1779417743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8rLW09dDhgcqjvD8OY2KOZGl5mvXel79GUCzEbR1uwA=;
        b=StAg7wIsNqjWBRSPuPpvrGnqtpTxhuYSK3DM9npWkBLFOeUHXQyx/V0T5BlJD8FcNV
         eZEq0u+E4gwpmlQnQH8+ave8doxajtibDcCHg8LzTWnUakENhSZ/xZECBf+JoloKvLWH
         DqF4zA8OyUKgW5pH2TlTSgPOqDFyZrJuY39p9vd7XPU3x60dKm/U19L/uZTG+x7hW4pJ
         9vERg3E7pk+ZlSQ2SliuQLO6f6OLOMAuIr/kdWij/pSLzzVjcKSBgGOMhOIJFb8NSFpK
         qmwYp//IY9WT0dFxfoa+egThT3fcpXuBEYDJVV6xImc5hVjjgaagQjBkXSP+ctDkEjPQ
         JIpg==
X-Forwarded-Encrypted: i=1; AFNElJ8p6bLr1ooYkA9+q+bBM/FjeLT3KtnfAjGlGw6lUb/Gj951m/XatNwj0v/E0NQNfPkwyt4GTyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YygrMC2DRdFFgQcXpDxltqNTl5r6++XxL0poqXRYuU67aeIOTUI
	clmRpNirMt6fSsNP9ifZrxCSQGBnx0ZMCTdeAz2NHQ1m6eyS7n/rDkpF
X-Gm-Gg: Acq92OFpD5l6AE3WHoCYeHBEtIKTmJ/XK3CgSgqRqvCycA6bdkGxvMEKzcDoTm9X1bS
	4SP+xYdbmoi804TuHlpCmpDxgje7rNakTDu47yj6nnrmmfC40WNWKjbF9c47CRrgbdMhhJw2Cq1
	jVZ0udMrZwANtugEXbrJJaNvvA2APkXAnXe8d+SD8UBHcbQaCvEwM4HV9Rf0IkFh7C8RlWB2Q+i
	VThr2jpso1Wi5i6WnwoFXQLBkO5NOtyRCC7Faf8+f3jw5+Eia+iOFNf9Stgq+brKJQhW+XwO/K+
	GWCT9hIgG35zAWYhlAcfe2uczQzvyPcaitASKrz212BZv49EiSBXzZQ7g5J+iwZf1mNtjGNDNC+
	+zPEuqPkLXO8RHIed8Fl0M08iMPaJR/hq5jU2JVa0XsAsOKEqJwJrgT5TURIf/g+GhTMqsEN1cB
	FbjGPHgbRqaPrubz+pNi8ZIkjrqRSQHPtCCrdSAhUN7go6
X-Received: by 2002:a05:7300:dc97:b0:2de:c5ca:c1f3 with SMTP id 5a478bee46e88-3039818a6damr1107563eec.4.1778812942627;
        Thu, 14 May 2026 19:42:22 -0700 (PDT)
Received: from localhost.localdomain ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30296dcb6f6sm6288605eec.17.2026.05.14.19.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 19:42:22 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: paul@paul-moore.com
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	lyutoon@gmail.com,
	horms@kernel.org,
	huw@codeweavers.com,
	casey@schaufler-ca.com,
	linux-security-module@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net 3/4] netlabel: validate CALIPSO option against skb tail in netlbl_skbuff_getattr
Date: Fri, 15 May 2026 10:42:16 +0800
Message-ID: <20260515024216.203957-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAHC9VhR52b2FbD-aiMFsaXwwRrUGTLSdRFzWcVAZjUm-K3qgkw@mail.gmail.com>
References: <CAHC9VhR52b2FbD-aiMFsaXwwRrUGTLSdRFzWcVAZjUm-K3qgkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F14E6548D09
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com,codeweavers.com,schaufler-ca.com];
	TAGGED_FROM(0.00)[bounces-288160-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Agreed, -EINVAL is right.  The bytes passed parse-time
validation, so hitting either bounds check at consume time means
they were mutated after parse.  Treating such a packet as "no
label" via netlbl_unlabel_getattr() drops it into the wrong
default.  v2 returns -EINVAL on both checks.

Will also drop the Smack mention from the commit message (Casey
flagged that separately).

Qi

