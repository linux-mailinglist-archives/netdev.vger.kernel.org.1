Return-Path: <netdev+bounces-307750-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GAdvCEmDV2oVUgAAu9opvQ
	(envelope-from <netdev+bounces-307750-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:55:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1380275E60C
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 14:55:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=0sec.ai header.s=google header.b=geGSBEMV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307750-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307750-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41744301E813
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72489478E50;
	Wed, 15 Jul 2026 12:46:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875483E639F
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 12:46:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119604; cv=none; b=XHKczkD+xDTNUMFmgC6DWTFA2s1ajiaqQ6rh2oScQeY8QZZSnCcTzeniK+8u0nEeK1Jy4FPUZIb6b/OY3nsn+KYA2hg5FTphwDbisvmdq7O7FAIv8DgclPEwK5ikiwtoeTR5tnMaMCZPiXSXaCVoV+WrwsIDFoQNCoEpcwxxVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119604; c=relaxed/simple;
	bh=MZBr5WxEHZ2y0pV8ggGK3k1uymGa6RNkY5bjprO9bjE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fUysb2Ao6HyopO+zt+msH1OqFRUpr7M2+vrj/uX30ZpRa3/CImDzCpY4SDJwB4+GCjjGOjjFSEcFcFO5buxU/Fi6agO6pQXvs/mk2IoPfIXaGjHFuQLunUzUHhbHQpuuIgy3CBrHbvNeRnxCaLcX+hbjJQJeLqpm8++hcSoVxP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=0sec.ai; spf=pass smtp.mailfrom=0sec.ai; dkim=temperror (0-bit key) header.d=0sec.ai header.i=@0sec.ai header.b=geGSBEMV; arc=none smtp.client-ip=209.85.128.44
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c19bad03so48267875e9.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 05:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0sec.ai; s=google; t=1784119594; x=1784724394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MZBr5WxEHZ2y0pV8ggGK3k1uymGa6RNkY5bjprO9bjE=;
        b=geGSBEMV04zHY92wLISbC4kUhq5apmlcT7YHQtsgwXRFhpDP0+CefDTmRiS/c/Dved
         jFE9PU4Vqcj4hwnt3WXTh8eT5eudnckKDXMAqZwM7UPaGWmvWIhbfKNjK4ARHzu00VhJ
         YMiFZgtX+AHT73Gyvt6HGm8U5Fwwd5bt4o8mrsF9Q++vPD7cp2k9MKu/O2FsA+OTtxdX
         IymacceUVgf/25eCFPICdUpi22DbYQNvLuTd7SQMre9ljx/lCJlG1Xj2ERTnen+268aB
         GKaj6OKKhdph7nYGPPf6CHHyH8nYoNtOkFGj1SLFV22VMSc48Ug1BZZ95WFTfv0TT+GR
         /evA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784119594; x=1784724394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MZBr5WxEHZ2y0pV8ggGK3k1uymGa6RNkY5bjprO9bjE=;
        b=mQ/3sV6TmtA1M8SdMKDz+o5OBUWU8+28dFF0dd86z3cif6V4XpzPRN/PXDmtD9xNL0
         mt3iEZe79ogl1ClvKjLROHVcITUrTLTTiVoCguX+Oql5X836pcGgrYQykoX6dY4SWBZ6
         nQjy9wszBBXWPrgrgmiw21HVpWfaT8P7a8fzCIOF7gOfRZ9+G8JVC4AX3Gd9XEKWTm4Y
         FXepI7kOJmeyTWzysFkd9RKZs7XMvix/0gyPlBtV87e5iZ0KV3RNoW1MT9VuFW8d2IxC
         0XStx5KYlyT5V/9G/vV+sxLQJYAaUnNFxywRZaSRhfJ6EkBfLOheCcGz2xY1/AHOS+KB
         BL5g==
X-Forwarded-Encrypted: i=1; AHgh+RpH/HCQmCSursnaJ00c+NzZV+/kfmTsiKhI4oPu4Osx7H1XdpJeBXr42livICKFmXoknTBKqbA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymmh3p9tRl+ybQoXzdEfBXrP8H3LKwByvzvyEh5Mizux1qQEsq
	IdKuu2gYvdPbjhPfIxCVeEzIKKavcFARKpGV+CICQYsls2c5eCRofoCtltpwpFyettVW
X-Gm-Gg: AfdE7ckYP0h/anmr0mdsv945MJW7Odysr3B53rtDJvyBm2DV8cLhNifWDmeKWh2iTsK
	/44al4aEAU4BpX5OUdKtoxufaNNutfdk1IF7ggZXhM3MLxxLiWn4B9LlwozWTnVDq/KM3bMoIcg
	zcK+MDQwkraKVItOMEsbZUd6rK2Bj99w/n37NkDYxRljMZL4sL2YduOiWFuWTpj6vCIT7KCjMO5
	8m7i5laioBmPw05kg7M0dG1IEQuWhmOmKSoy8Gj8tdLgqtTcbIzBccrwbA92cYC90ME9ZCMC6xI
	E9AvJysaBigWnVAUp/NwrdoIEQkCOvTXkCiu9vNDUkPlQiXyzAvVLJ5aQo9W1GE9rNf6DTd+vQ8
	MG54Gpv4eZUhSwOKdBAwKjrEnsSB60bO6yPIZLgTEKBf7YiVlUv58eq8MjKgIgCIgGlzHVRmqGU
	2JgcnHwRwoCf+8PaZB85cwb+5m17IbWnAlJ7g+CL90rmX+HXAFEtFX2e6FMwszcbjsRfGtfoIeH
	8wvVBZ4vt3owPYwTTq+nwO2EfOTu/ZlVt2pPaVEUMYqDw==
X-Received: by 2002:a05:600c:42c8:b0:490:d354:bcf4 with SMTP id 5b1f17b1804b1-4953c28b5edmr18893235e9.27.1784119593604;
        Wed, 15 Jul 2026 05:46:33 -0700 (PDT)
Received: from PeakBook-Mini.tail8e484.ts.net ([178.197.218.188])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4950a2f635dsm157035235e9.12.2026.07.15.05.46.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 15 Jul 2026 05:46:33 -0700 (PDT)
From: Doruk Tan Ozturk <doruk@0sec.ai>
To: fmancera@suse.de
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	sd@queasysnail.net,
	linville@tuxdriver.com,
	mschiffer@universe-factory.net,
	maoyixie.tju@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vxlan: require CAP_NET_ADMIN in the device netns for changelink
Date: Wed, 15 Jul 2026 14:46:30 +0200
Message-ID: <20260715124630.41929-1-doruk@0sec.ai>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [3.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[0sec.ai:s=google];
	FAKE_REPLY(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:sd@queasysnail.net,m:linville@tuxdriver.com,m:mschiffer@universe-factory.net,m:maoyixie.tju@gmail.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:maoyixietju@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307750-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,queasysnail.net,tuxdriver.com,universe-factory.net,gmail.com,vger.kernel.org];
	DMARC_NA(0.00)[0sec.ai];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[doruk@0sec.ai,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[0sec.ai:-];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,0sec.ai:from_mime,0sec.ai:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1380275E60C
X-Rspamd-Action: no action

> It should be:
> Fixes: 8bcdc4f3a20b ("vxlan: add changelink support")

Thanks, agreed. I'll fix both tags in v2 (geneve too, 5b861f6baa3a).

Doruk

