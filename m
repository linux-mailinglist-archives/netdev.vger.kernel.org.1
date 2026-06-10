Return-Path: <netdev+bounces-297636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K05UOxBIKWogTgMAu9opvQ
	(envelope-from <netdev+bounces-297636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:18:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C07668A83
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 13:18:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=snu.ac.kr header.s=google header.b=IKIgc2CD;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297636-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297636-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=snu.ac.kr;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ECABE3022192
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 11:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D824028C5;
	Wed, 10 Jun 2026 11:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB750402B8D
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 11:10:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781089844; cv=none; b=NOTY1/DNi6YEOWj2DAeD54Tzu7zFgkXgnlf5l+xd7WNzq3s8Pm4GGUFbl2Q4l79MV5hKksChoyTqHyAU9RWIxvbp+qPqUKQHWqW6FwC+IRssWXZlKkO/OWQ5u30aCHcA/DnVEmSxQVBZdgbUAvA49fV8Tkzl4/UA8lPyZWwOnwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781089844; c=relaxed/simple;
	bh=IowJH3Ai15vd2i0QocI9I2pvMk78RS360DKTeHFE3iM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t4WR2ro2+cv8K7MOTKj/nm3ZG2IOh7jRYDd4xae1cd368wKzCtODQkCftTZt2yeIXjYReyfYJKNAb2MfG9X0LIofGaxG8nCAi5wq8PF+DyXJEZ7vCY6FJHHmRd0mALKhOaeWmBYqEZmG23651wfaXr9g6GVDkvMdQsaLs1E0fmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=IKIgc2CD; arc=none smtp.client-ip=209.85.214.180
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf36a6905cso47216795ad.3
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 04:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1781089836; x=1781694636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QE2zAl5iHSsLSc+ACr0vKQa3vwAsWhkMa5L1rNcRA0g=;
        b=IKIgc2CDWPTLa5ICphDr4jWWK9ZT993Js+fe9Mh4Fww5H3iv0gmunT6yknfNPLDWjp
         WA4rwHh6QFJBMYRbGjOCHkHa+YrvqsEZMtApibjOGs+ZqdPzk8c8Q8ayVFqmgVNA/TkP
         GS+WaoSoKqZ6XP8H0GVq1NMW5BpUlmdNf387E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781089836; x=1781694636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QE2zAl5iHSsLSc+ACr0vKQa3vwAsWhkMa5L1rNcRA0g=;
        b=jKMgH/EcSgyXRG2Kmef35zSHaMKEAsSd5nQ7aUqr9RdSM7avdh4OQzSaIoK0vGdcxh
         mgBBWLDh+q0HS4UuLvU66gq6Nw8bBseJfKmopP8dEDmiSFO+jRvTQC1Gr9OT/0yXB6T4
         7H57X/Ul1sdKUqRdpfFhXpvlVjl9qLxarngzawCvk2h9GwqL5w/XVS63kZv/KBbFD2sJ
         e0vLLnqdg3Kw+TGOTAbThAZ4OLaaURH4U4TYhop+sAo7cN+LCRyJssn83RYPAbMVbWjE
         gZAi7AX3YiIIeZBPQLD+CJJ/0HHfxHb8bcQNs4VffFEMEpr1/XIzCtZb/lMm39h0IasL
         XTxw==
X-Forwarded-Encrypted: i=1; AFNElJ8BD6ecsfvohKWUzBwmWClW1fUMEarRgLz+eT5nHT2DsdwwpMF6XbTekqIHmAtTUyRcFU7weHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2KWlDEVEea9J7PEP1Y49zGbm7O4zt0ekojQ0VC0xnAoqLHOnt
	7JwYas0Tbvd4vqIQpa7rmVSEW7+nCMMQgqA4Kyf80e7AXeLZ7rndXGjXrFW6tz7Yv4w=
X-Gm-Gg: Acq92OFOtLzWM6PYXe3zHUpN1oyMdl3bMKWM5M2L9qeNvBkwtaVkT/IT5edidXKVAQd
	ub1u/LLuEJgKS2Ba+VwWEGpgZGfgTMmoc0AxsjP1WqU5Yb/O8rhrVjJFlTKLRVApmLD6BpQeSPO
	WX72bhxI6CzLAVXRV9XrB5nxZnYHPLBs2kNDKaPeVaI6Nfz16e9lG7JF0+R60O84Fa4YLtQHkKV
	CTtuB11/2BAuNJCXuYyTjXfYHJlflmykhtyVqJrBntAdNhuexUQuiz5OGJ7twz+ShqwXXFOJMRa
	kmtudkmDzUpN2mEkb6HJhUdpYorZWUHDKXjKdsq+KtpoaTuTfc/NJe2Xkry6g01Q1EZR8eItouw
	offJrp2R7Z/F2blp7ZnUSIlbbTRsdzQ3pf81dpz5WFt60ObhP11v+TSt/g07w778q5j0paop4Th
	mjBBYYox/NMKtBIS1wRpIJ30u1Nj+ID8/MKS56U1MnB0wIYorQxpMNk6Jfqut3yG+s1no=
X-Received: by 2002:a17:902:ef50:b0:2bf:23c3:34ba with SMTP id d9443c01a7336-2c2a1c99a9bmr84516775ad.28.1781089835907;
        Wed, 10 Jun 2026 04:10:35 -0700 (PDT)
Received: from nunu.. (nunu.snu.ac.kr. [147.46.112.82])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d318sm259459655ad.15.2026.06.10.04.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 04:10:34 -0700 (PDT)
From: Jaeyoung Chung <jjy600901@snu.ac.kr>
To: Krzysztof Halasa <khc@pm.waw.pl>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jaeyoung Chung <jjy600901@snu.ac.kr>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sangyun Kim <sangyun.kim@snu.ac.kr>,
	Kyungwook Boo <bookyungwook@gmail.com>
Subject: net: wan: hd64572: KASAN null-ptr-deref in sca_intr() on early IRQ
Date: Wed, 10 Jun 2026 20:10:27 +0900
Message-Id: <20260610111027.654829-1-jjy600901@snu.ac.kr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[snu.ac.kr,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-297636-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[jjy600901@snu.ac.kr,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:khc@pm.waw.pl,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jjy600901@snu.ac.kr,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sangyun.kim@snu.ac.kr,m:bookyungwook@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jjy600901@snu.ac.kr,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,snu.ac.kr:dkim,snu.ac.kr:email,snu.ac.kr:mid,snu.ac.kr:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E9C07668A83

Hi,

The interrupt handler sca_intr() in drivers/net/wan/hd64572.c is
registered by both pc300too and pci200syn before they initialize
port->card. If an interrupt arrives before port->card is initialized,
sca_intr() dereferences a NULL port->card, causing a kernel panic.

The probe path, in pc300too.c (pc300_pci_init_one()):

    request_irq(pdev->irq, sca_intr, IRQF_SHARED, "pc300", card); /* register handler */
    ...
    port->card = card;                                            /* initialize port->card */

pci200syn.c (pci200_pci_init_one()) has the same ordering:

    request_irq(pdev->irq, sca_intr, IRQF_SHARED, "pci200syn", card); /* register handler */
    ...
    port->card = card;                                               /* initialize port->card */

The handler sca_intr() in hd64572.c dereferences port->card through
disable_intr().

If the device raises an interrupt before port->card is initialized, the
handler dereferences the NULL port->card, triggering a KASAN
null-ptr-deref.

Suggested fix: assign port->card before request_irq() in both probes, so
the pointer is valid before the handler can run.

Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
Reported-by: Kyungwook Boo <bookyungwook@gmail.com>

Thanks,
Jaeyoung Chung

