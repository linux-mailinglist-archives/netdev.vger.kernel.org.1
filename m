Return-Path: <netdev+bounces-302939-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M8N5JS1DQ2rmWAoAu9opvQ
	(envelope-from <netdev+bounces-302939-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:16:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 987F36E034B
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:16:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=qZY0UeMg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302939-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302939-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C24983007AEB
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEDF3A8739;
	Tue, 30 Jun 2026 04:16:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5091A680C
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792999; cv=none; b=bImUNpHFbhBH7e7WuffLak7jz0Sd7DWc0kPby0+cRioodjaEt8Wiy8pK4vxNrs8RG6NLAV6CWm9nX/orhJrHAIkKIdNopgJ58HsKpXpqMyfHoGdUoxOx/XsxOq7nvZxp1t2h/YAjO3GsB3ex2EcxWngTNhiV6Y8xB6AtY4Ef5+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792999; c=relaxed/simple;
	bh=AitMYRNwW7qBx3Fq/JU5flzrp/e2dlczb4UUivAuLi0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t4ONuZ06P+gU+CCNHO+Gg7p7BjeU7XCvDzhO718nr2PyAsnPjHzm3NF1rRnh2bmzvHyimlOu8oBx8Q933TO+jPX/dVbRxu43v+b7JC1qkSgkadz30D1+0jm7z+JgJBW9Jsb9vOGG9IwDbdqXbfgTgwKyW6p2UICZNRU2uVmfALQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qZY0UeMg; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c96bfabc8d4so747550a12.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782792997; x=1783397797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2YAd0MG90KNrR3SvV+dL3YYZp19o+fsHpewV3ORXhyc=;
        b=qZY0UeMgMlDHON2yTZN08yQolgMTzipON1I/46OC/KdRUg4dfNLO9ojqiEYiFKxwb/
         gZmJaotN7gRIgdFJJsGvCQBGaf51beps1zOiDoqvvnYVj/VXXr6PrTRRK8PrIaidOJYK
         rnU0i/jw7WshXOB5TVIzU3U/R+GVRNSkFbaxNo34ko9ZabPOEXYiLC4D0VAZ90ftMk6C
         PaDZosp4PrHiMZZTxpM4O0hvO9tjw7fYRymflitO5VE4vTAh3uxWgpZf6nsSVjABvTfX
         xDWf2NsbEsnU6QRWhiMhFuuy2gvP1vnWlcEZtvsK6Nug6T+VpiicGtz7p42gJtY1a3Ok
         nZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782792997; x=1783397797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2YAd0MG90KNrR3SvV+dL3YYZp19o+fsHpewV3ORXhyc=;
        b=knzYG0sYsUw47P9oal+QKXuKW2RcrwsLQZ903SD4AISbj3Z0VBITZnRJ/NagVu4Bw7
         X/WPe+hNaQk7ERwHWyBBLiMDecwwzvXxfDs+7HCdjFOkczLVM5/OLws1pQ//3VKlbxtp
         xrria9s57LLHadoXnv4oXrFWgsxYhuE2okfAMI77C4GDjd3quVUp9aVMNXyQ/q7cEs+Q
         j1Coex0EGxKaBPLpfdmnDJvDOu3emfB2R6nA+RyjeXW79nSD+m4eVPG1q4kIr0SVvsD0
         Wq+49vry4TOio/B8T02nJLr2ZVfXbitFLNRmoDfhfcOuDwAM0S27hdPuVRnMdg5+bGlR
         PPew==
X-Gm-Message-State: AOJu0Yy9bmZmukBZt7f9tBzSJSJmxQzysBXlfO3Qkbw1FsPi3L367U7A
	5Qu+xBPUoQpqYWyV0Da7YSKQBLr0GTW+sgIqJJTWfQ3DqkyxJydikrrFIAHwfsVD
X-Gm-Gg: AfdE7clkceZWo45vPAa2Saa5gRhc/pbuHGeT5Zo7QXYdht8houhbQ0VXWML7u+W/2ZW
	DGbnY4t7IzuQcwveyoNtQtVAXDr8ycBKB+zvnvuR2dUoNwCTkX/w7OqBjB5Ysu4jQGM+lb0rswe
	fDhl4W8+CHuajEIqSNfSp5epJHFHZznUwu/gxFJQDrtzx2smzucpxDq0nWjWGgWtzheY15RWYMU
	e/6nzvBxUy3U0KXy2N6QwTHvnq77LmdYz6J03uSdAsV8Q9kpfaFLw4kvWQyhb2iiwBsAlf/qw3F
	JVlzEk+Z9pyyorhmsl8oFiLcl3hJmZl7SNfbctwkDIcArcI2ol9mcw9MFqfExCtPPrui1bEBtXb
	ZocDKkE3hhsGBUkYZv5gOh+FQCJfemimUXS00arx6pnEJrKkI9yioZOvQGCaMGo2hG6JhlTNnr4
	uiXLVtiCrJ7aQmirKeSDEsNfCXPXC86lsGkOSZhJA4jZjwEtHnjS9Fp/5fsKr/a/VIzzYajs3nl
	teS8/EeCw==
X-Received: by 2002:a05:6a20:cd95:b0:3bf:6011:550 with SMTP id adf61e73a8af0-3bfc50efbefmr1567725637.24.1782792996980;
        Mon, 29 Jun 2026 21:16:36 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm702659a12.19.2026.06.29.21.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:16:36 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 00/10] net: emac: various cleanups, fixes, and feature additions
Date: Mon, 29 Jun 2026 21:16:24 -0700
Message-ID: <20260630041634.284127-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302939-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 987F36E034B

This series targets the IBM EMAC (Ethernet Media Access Controller)
driver used on PowerPC 4xx SoCs. It removes unused infrastructure,
fixes sparse warnings, replaces legacy helpers, streamlines
synchronization, fixes DMA API usage, and adds BQL support along
with ndo_get_stats64 conversion.

Rosen Penev (10):
  net: emac: remove emac_xaht_base()
  net: emac: fix sparse __iomem warnings in IAHT register access
  net: emac: use DMA-specific and SMP memory barriers
  net: emac: mal: replace of_get_property with of_property_read_u32
  net: emac: mal: replace busy-wait in mal_poll_disable with wait_event
  net: emac: batch stats, eliminate modulo, tighten barrier in RX poll
  net: emac: fix DMA API mapping and unmapping correctness
  net: emac: replace #ifdef CONFIG_PPC_DCR_NATIVE with IS_ENABLED()
  net: emac: add Byte Queue Limits (BQL) support
  net: emac: use ndo_get_stats64 instead of ndo_get_stats

 drivers/net/ethernet/ibm/emac/core.c  | 253 ++++++++++++++++----------
 drivers/net/ethernet/ibm/emac/core.h  |  17 +-
 drivers/net/ethernet/ibm/emac/mal.c   |  37 ++--
 drivers/net/ethernet/ibm/emac/mal.h   |   3 +
 drivers/net/ethernet/ibm/emac/rgmii.c |   2 +-
 drivers/net/ethernet/ibm/emac/tah.c   |   2 +-
 drivers/net/ethernet/ibm/emac/zmii.c  |   4 +-
 7 files changed, 188 insertions(+), 130 deletions(-)

-- 
2.54.0


