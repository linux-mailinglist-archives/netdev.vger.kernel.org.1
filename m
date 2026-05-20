Return-Path: <netdev+bounces-290104-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHZmFxgfDmpd6QUAu9opvQ
	(envelope-from <netdev+bounces-290104-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:52:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BDEF059A3CC
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 22:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A476130F782D
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 20:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B1376A02;
	Wed, 20 May 2026 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qJqZcM3e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0765E3769EC
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779310209; cv=none; b=c6JElUqFb5TPrregTGlNeDSc4yEhJPBIvdbBGJRR5Fyo36l/LG0UgD3qYMR4MsQKEynnONrRVok4cN2lfZciX02K/F97cdPOv1MmGfViUTnZuCIaQ3LGsPqHFC3x9aJhTujzHVfQKH1/JSZK2AD8n++A8NbFdEy7uyCt43qzneg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779310209; c=relaxed/simple;
	bh=xY4morXltX4RqPtRrcw5r7QGtep1CcSEbYEzsn8H7jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k/ztVp6Em7zre/G60JAQqKi9YMAmhwScrGBJe7fMt2/e2pJ78vlSowUOGmmvgROomeQHBhE9HZpbrtr4Iy+e43EwNX/BPoYbAESCgxu1vHyGei0Q3fIvCA5XJHyHItqF1XRPdvoDck2F+DpBXu5VTsHVmRv5L8VbeS24Z883afs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qJqZcM3e; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-575212eb419so3782277e0c.1
        for <netdev@vger.kernel.org>; Wed, 20 May 2026 13:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779310207; x=1779915007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XhvkCKsqDmZR9B7mEF0SJvWzY0KRdobltrP9UrFhvDk=;
        b=qJqZcM3ef+WY3ruDAi3+0mKWXBuOYXjLYy2eduqOmX/6L4fkF0X0F9ehyUMmc1oAgR
         x8tUPQ8UPXWj7WeyYPXBzQDqb0r7TGKLOPD6t/zVkR2FihbZAh5IYyhWIRZyBw6PCHd7
         Whrk1gD03wZeQ8aLEOcsHZdLy9FCD4Qwh0YceLKYwdPqqUZvN70apvc+4AeIddCK9tKo
         lqOlmyj8OqC4uXzveJrev/Mw7mZbYwk6YYwLgxwjqh4eYmS7trxiLzrPMzlPdpKoZYN6
         Wbi5IR2lwGJCY1wqPpHJtoArO74RiMYEwcv/x/qyoj23V8WtZ9/7ckGT4GteS/JGUeXO
         2lDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779310207; x=1779915007;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhvkCKsqDmZR9B7mEF0SJvWzY0KRdobltrP9UrFhvDk=;
        b=AoYZLk/0ech383CagS4VexZ6XFNgEPn9k38OERhAOk7zhBrStQ6jBJ6uYFrSFxtFSh
         uM/ZgvafCsMx7B3HDLWzYUV2q2uibHqwCT3cYH84U5UMG/Jbn1nCrNR4eHuQGyJ1Ulro
         jaW+6S862zMalCS4zX95v2tDmY7hZznmy+didOnTrPVtu3I4N+CUE+T2efml0kE5owVW
         8TV8UfVb71R8SVE0aSU+WBtZ4A7khhXRXTR9SR03W85pzwmGkWY+bpHjsgb4BtMLVaf2
         nlQXH49jS8P0p3uw6S9yNIItOY/IGzzUwFEAmc/yJ+8a2lceSDdGGi/cHU4DCaPZVgg0
         9SuQ==
X-Forwarded-Encrypted: i=1; AFNElJ96PBBNnOiHxBEc2f6EjwhLDV+0MHU4I5K+5GeUIBTAklLHcrX751Kqet65Da6tpo6T8ADIxB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9zUKzqWKFGgPNiDBXo1jdqhsudB9YHIrKLt2CtujvnWV2z6GX
	AE1/XLb2ueMFIWi8KzLIIUirDaGs3T07G5GcViA9AHr1OOM0aFE7nZCN
X-Gm-Gg: Acq92OFfb7OyJ0mdwzdTRHBDz7uq2MKB9RYNqQxYOQjDwNg/YYoHp6US+LXlbUUMJwO
	5spVT5Yyi3CJCz8TxmSDmh2DWnen5ytccWOF0Wlk4NNBsJSU2vZhjzbCcKGQCiAGlXrGAeQk8my
	sum4dY4kD1ZvaWHvlCtDypp+bDSe5DR4McbPzVWYox5gOme2prgv3D+rXECbTmU6yuQud91B1sR
	+CWFlaaSitBYekm6ncR7pXFchwPUxKJJlQ7coO+PyJR19HOL5nTv3dvwDFaWJqVhb7MEXI4EAEg
	wolDWm4YIWchEI0iEBcYtLoMI4ELRRaUm76s4eF2wHr9v9pJSbMZu0UEn7mcO7t17Bkvyv36lYE
	imanrZy+v4AFbnj8VooJ1imY05QjlKkvT+ir7tCLymHGZl4UxbWljNw7Y8JZrjxDB8XUzK9HP/c
	11Grx3pRVQLYa9DIlswOp1mMaqAdcAgTj4HF2EMJ0dQZSzdm2pS4VOIzAFkAyCPIJRhWZGo3IHK
	3l1BkIkQIIcGuNqB4FWLyZXxZyu
X-Received: by 2002:a05:6122:6587:b0:575:9f5:ac57 with SMTP id 71dfb90a1353d-58411e72bcbmr31363e0c.4.1779310206904;
        Wed, 20 May 2026 13:50:06 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5760f58feacsm13392295e0c.1.2026.05.20.13.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 13:50:06 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-05-20
Date: Wed, 20 May 2026 16:49:58 -0400
Message-ID: <20260520204959.2902497-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290104-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BDEF059A3CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 375ba7484132662a4a8c7547d088fb6275c00282:

  Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-20

for you to fetch changes up to ab1513597c6cf17cd1ad2a21e3b045421b48e022:

  Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: Fix not setting mask for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE
 - L2CAP: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()
 - ISO: drop ISO_END frames received without prior ISO_START
 - MGMT: validate Add Extended Advertising Data length
 - bnep: Fix UAF read of dev->name
 - btmtk: fix urb->setup_packet leak in error paths
 - btintel_pcie: Fix incorrect MAC access programming
 - hci_uart: fix UAFs and race conditions in close and init paths

----------------------------------------------------------------
David Carlier (1):
      Bluetooth: ISO: drop ISO_END frames received without prior ISO_START

Jann Horn (1):
      Bluetooth: bnep: Fix UAF read of dev->name

Jiajia Liu (1):
      Bluetooth: btmtk: fix urb->setup_packet leak in error paths

Kiran K (1):
      Bluetooth: btintel_pcie: Fix incorrect MAC access programming

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix not setting mask for HCI_EVT_LE_ALL_REMOTE_FEATURES_COMPLETE

Michael Bommarito (1):
      Bluetooth: MGMT: validate Add Extended Advertising Data length

Mingyu Wang (1):
      Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths

Safa Karakuş (1):
      Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del()

 drivers/bluetooth/btintel_pcie.c | 20 +++++-----------
 drivers/bluetooth/btintel_pcie.h |  3 ---
 drivers/bluetooth/btmtk.c        |  2 ++
 drivers/bluetooth/hci_ldisc.c    | 48 ++++++++++++++++++++++++++++++-------
 net/bluetooth/af_bluetooth.c     | 10 ++++++++
 net/bluetooth/bnep/core.c        |  2 +-
 net/bluetooth/hci_sync.c         |  6 ++---
 net/bluetooth/iso.c              | 14 ++++++++++-
 net/bluetooth/l2cap_sock.c       | 51 ++++++++++++++++++++++++++++++++++------
 net/bluetooth/mgmt.c             |  6 +++++
 net/bluetooth/rfcomm/sock.c      |  9 ++++++-
 net/bluetooth/sco.c              |  9 ++++++-
 12 files changed, 141 insertions(+), 39 deletions(-)

