Return-Path: <netdev+bounces-303322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JfzyMpEJRGpIngoAu9opvQ
	(envelope-from <netdev+bounces-303322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:23:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 433896E72BD
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:23:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=VTcsxf6X;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303322-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-303322-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 971F63087934
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 860463E2769;
	Tue, 30 Jun 2026 18:21:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5949E3E0C42
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:21:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782843692; cv=none; b=i0dSZ5J+RVtmqzVg+Yyw52ekps73pd+uYfUadPFXLZ3JnCRu1PEP47FKC/c8P323Kx+f4NvdQ7XDbMu/3tHKq2/2481ukXUpZKarGVRvfPlOi/X6PZ5vttPhqWXYxFdlzNJXzObd9Ptkk9gmUUQ8oaWxslipCKHuxLN+pabmff4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782843692; c=relaxed/simple;
	bh=rWSZVAqALeY1C5LwMzsQlO2eTEezaMWFPPqdpHgdVPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EMbOcxIYUnXPvaChfZSDWZSZNjmw2doL8jw4TzNEdHhiwq4pOgt5YPGBRPniJpWTjTZSZb/vDuvU+/DAkMP3ezJfRuRgOFPCHTrBgKS5t4MmIkNDbnT3FSW1LcrpWwiPgH8aJBCNnsOSvDx+RnrSE8HCXfyppJtBmZbh8MuG8Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTcsxf6X; arc=none smtp.client-ip=74.125.227.130
Received: by mail-pj2-f2.google.com with SMTP id 98e67ed59e1d1-37fee6f0ef8so807940a91.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782843691; x=1783448491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qUv7QMu3lUEjKawxFm1uUlu9RaCdNz07gUEJx9rtqXk=;
        b=VTcsxf6XiQzJrLj0HyZLcsMsCkcc35kw7U8K3KUt6AtYEjSpl6IqRKBV18f6Q1QKxA
         EKOzpZYTmlvr13tPpZStaoOv/qjvor+TylWMnDnRdGKeiFprbQWUASTnauWRbKNfKK7x
         r61OBpqPFyWfXPM/mBt2x7kQP9TndxaY5ZPr10AEvXLnUVOaCHCOEsTxoMOANAgkBAKi
         18lZB5WB6GiYnIgXN1a6dqX8CdC1ycGbl1C9yR+vzbqdI8OJ9Cja0ZgSUQYSt0sLBm93
         53zL1byTuEBlFVEaCUIvUlomy4Bb9H0U8ZqlShp1FrWclqQ/c/nnfxOcDDyr+rjFeBg0
         mP9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782843691; x=1783448491;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUv7QMu3lUEjKawxFm1uUlu9RaCdNz07gUEJx9rtqXk=;
        b=Opq8eyOLCHK9zXp1TGLyBCobkq2Czw5PBtP8y63VYbpqAKd0PuYm0kRLwszEXUMVXm
         CRSb4rggTGxJvcp8btTBw3wSse1zLkwkVrNTMRZ8sN5yeSADVnT8ZpmAY5PfN3ZxrL4s
         aOMSli12VyuV0za3QGxc66TXDLDtaGB420HCnPZ9amk0xtgHfhC9tc9i5SfrTPS/uzw6
         N8+cvXyUkHjy0/KDQ90+A7jBRStel52Lyw7pfimFgu0bHBJh0gMn86j9HIFv2Aszrgnh
         KzwJ+9VQJnevD0yraGi00h+uWrzqaRC3MPfvunrfbEHMtvdtQWKGIQuTS56ZxtaM9ZcC
         ZaxA==
X-Gm-Message-State: AOJu0YxzRcawXza366n73NRgLnK26uvAXVl17HgBjWMAauDq4iZtd3DL
	/1187pHaLTsVmvzE1HqM0i5QF8nWuQLTuNpLB80Qdyzmu2WJXW/YvEfPGvBSga5l
X-Gm-Gg: AfdE7cmLPcKI6c3EOHLrt+XpkQ3Hpud6ZVlM8ynXht94gudcq/kVVhqEkjjGWvqWU5T
	jv+XJshoGfbD9dfNv82F7UWjPwaLo+EUdXZYSCGIkmjRkjJGgH82NJMmnfULjdVwB9Bya0gjIhr
	dAqtaCLM+/Wijjihz7scdVxp43LyFbvmDrLmEhEXfCRR1UpHTQDw2xJoyyz6uWuf1l9cFb7o+Co
	OsRHMxfv8tVswIARmPMGFheqDykorKNUWknvG/opdHUQ+p089YhGDEFwodPhh7JiatrD5tf5bO0
	Po9wp9o11KCXS9iHKQS8Ldj15jLGSTs5a8jWawldnBXw70BFsEnqwsa3Bo4liFcDcdd5cKaiLHU
	LzcUU5Shn/qKhDX758kMYbjpq7I+G1tjSiAYluz8e1CvJbzCVXBnyv9UwYCM4Opmc9d0RaDpHyH
	zIBfWymFSTGwMkC/4T
X-Received: by 2002:a17:90a:d40c:b0:37c:6130:7a5b with SMTP id 98e67ed59e1d1-380526e5bbdmr3641524a91.8.1782843690734;
        Tue, 30 Jun 2026 11:21:30 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38095ea9ef3sm353431a91.17.2026.06.30.11.21.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:21:30 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next 0/6] net: hold instance lock around NETDEV_DOWN and NETDEV_GOING_DOWN
Date: Tue, 30 Jun 2026 11:21:23 -0700
Message-ID: <20260630182129.1601784-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303322-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fomichev.me:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 433896E72BD

NETDEV_UP and NETDEV_REGISTER already run under the per-device
instance lock. The teardown side does not. Make it symmetric so
ops-locked drivers can rely on the lock being held in both
directions.

Stanislav Fomichev (6):
  net: hold instance lock around NETDEV_DOWN/GOING_DOWN
  net: dsa: hold instance lock on close-on-shutdown paths
  net: mtk_eth_soc: hold instance lock around DMA-device-swap close
  net: rtnetlink: take instance lock inside rtnl_configure_link
  net: require instance lock for NETDEV_DOWN/GOING_DOWN notifiers
  net: document NETDEV_UNREGISTER unlocked rationale

 Documentation/networking/netdevices.rst     | 10 ++++++++++
 drivers/net/ethernet/mediatek/mtk_eth_soc.c |  5 +++++
 net/core/dev.c                              |  5 +++++
 net/core/lock_debug.c                       |  4 ++--
 net/core/rtnetlink.c                        | 17 ++++++++++-------
 net/dsa/dsa.c                               | 20 +++++++++++++++++---
 net/dsa/user.c                              | 19 +++++++++++++++++--
 7 files changed, 66 insertions(+), 14 deletions(-)

-- 
2.53.0-Meta


