Return-Path: <netdev+bounces-274258-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD+FB9KIzWnFegYAu9opvQ
	(envelope-from <netdev+bounces-274258-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:06:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D1B3807A7
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 23:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 75D4A3035AA5
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 20:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B604638837D;
	Wed,  1 Apr 2026 20:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JaupnOby"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5A372B25
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 20:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775077126; cv=none; b=AmpGS5m7vuvo1JpRWubg1Upr9bQKO+Y+69Ch2Y4q9ZviomwCaY16zHwiRRtODTS1fCiDgXPDz5f7r2g/ra2KH0NUsPaP1rKD6vmfkWhk0YShhihGf9JZW6gzGX4KAwBcnHVf8X1bmWtZNc7O+4MOs+hkbcqLIqOureK0tT0RHS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775077126; c=relaxed/simple;
	bh=qVghazcM/ujABQBOn+t4QpGfd/bCMsuw+XiepWqiDfs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nUgizc4fAiFl5X+A8hU7rPJSiN+1h791CNcEQkWiW4jA+XPJZO5X0IoGoJVF5E5gTEVlXsF3EKyws5C6G/y2m2YW4E99YrYSkkZNdkuUUvr9WeR81SeC4tRsrCnuwxeIxFDFmKPAzYWAEglwr4ydc3Qg8oB0aN02SRZDmey12DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JaupnOby; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-604d732cd22so89931137.1
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 13:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775077124; x=1775681924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W9783WPdOIZD13GkEthAh/0zwn654ungnFdFydPCPVw=;
        b=JaupnObyy6h/7ualNVoVSfNlwRnG6p5fVBFNSDUaNke/CKUH6W06KmTuCPASkLmwbq
         UrwgLounig0NNI/NdudCZd9OaES/GfNtox7DpnVUXvRf7P7DrEoE75lYKORk/uq7sAqR
         qKwXq8wcHvp/WB+S4zrRTTUQdw+KxJBbCQ/hblc9NwskmsQ+dt+qzmzocncJrb2jN5pT
         +E/PWcT+vhcnzkw+3QioribPfBVyFhYDG1UptGjT99NL3himTcRQlqbftR/XBQgGgOxx
         cT9HqPc9Lk5jn7/u1YVwy9rPcx1U0m/xYCR1l1Uv4GjoddfwwRlkKHF46mZL9tXPSsHR
         dVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775077124; x=1775681924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9783WPdOIZD13GkEthAh/0zwn654ungnFdFydPCPVw=;
        b=SV7BezZ6HeC/DajDxwLWgxUBLc+gdZ7II1/aAaXrvC1mZn68dtAielb/2lFbTVXIAk
         Ej7Y4uO9RAvl9ws92wdU4FcQBfVyhzNeH5/pSvGrfxKV6+eIJ+ZRQTMi+R3c8IDLP5iI
         VP8Ja3RCrPy8iSgQFrZRordylJ5eAxfaMsGekokvFN/FGZ7xsjRaXY1NA/jRPKn3tYmD
         jDmXwBtnt4b/3EZqjRCHfjHy7qlQpdVKaxX9F7Sg5ZzXlLqbarWLt33RFVMAkI4o/0hJ
         MTmeg6nJW0/mPoOP2aAaJvNT3JA9KjIQfarhrNdBVjrVme2tbaG7K2dstXxgiewSjJzS
         42wQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrOB6xdSK7AJYkhCyythTUeOt7IQBfs4AZf+cINRKwRmpCBvHhOqm4tm2klvXlm6YJwMX9RXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhOx6IAse5/D1K8SRx+fY4mWO58IwlM5358AleYROh8Z1bOCeI
	6g/7/0H5p47itd1+wTbu57dAKN77kSX1SDlAtSPRegeDCIKt518l598OAakKTLCCNF0=
X-Gm-Gg: ATEYQzzW4Wht/P294QiKDoKXXYt0OUERxlsl8IqnOjzWeJyEpaSDP2ljrpmIZb8LwUm
	o/mN+rXjM3GXndrRGEyBMEslP/m6N37PNaWWLl7MufRkSTXF759l15CVWM2TPmIHEcgDd0LXMcZ
	4NyeAXDusBNq+L9llg02jSuhxLDBi1nDvbYzWGerKSkE+dFDFtJilZy9A0pFRBp0X9lIEWzeFhz
	dEqwKUzCdl994O+ujKGdI3tK671uzFepA7tp59aZjIRsM7f3IfdsfS5hWNjL6/97S0BkhBCr0Kg
	e8zBiIK51YgcXAfsoaBud4hLUrM4C+yfXuYKK7cXNyAAUFZGXkS68smNIWKBa/yeqtTWoqbOMdd
	ndPACyXHIRKvCH5Xie6N6GiuCcuILCyUXMTyoGerVXHNVNBA5hn6e2eisaXwce4IHETo9VI7BYp
	RLTmk2jHLU3vagkPi+Z6Yd3BN7aPbAnxJs08ve0L4c5BFjZXZqWGhcfBkJtlgvClB1mYbI95EtX
	IOPrOHZu+UX3miO4mkahPjHtukm
X-Received: by 2002:a05:6102:952:b0:604:f640:301e with SMTP id ada2fe7eead31-60567e96320mr2379277137.12.1775077124275;
        Wed, 01 Apr 2026 13:58:44 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-6058304a726sm1367642137.9.2026.04.01.13.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 13:58:43 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-04-01
Date: Wed,  1 Apr 2026 16:58:34 -0400
Message-ID: <20260401205834.2189162-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-274258-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 95D1B3807A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 48b3cd69265f346f64b93064723492da46206e9b:

  net: stmmac: skip VLAN restore when VLAN hash ops are missing (2026-03-31 19:45:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-04-01

for you to fetch changes up to bc39a094730ce062fa034a529c93147c096cb488:

  Bluetooth: hci_sync: fix stack buffer overflow in hci_le_big_create_sync (2026-04-01 16:48:28 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: Fix UAF in le_read_features_complete
 - hci_sync: call destroy in hci_cmd_sync_run if immediate
 - hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
 - hci_sync: fix leaks when hci_cmd_sync_queue_once fails
 - hci_sync: fix stack buffer overflow in hci_le_big_create_sync
 - hci_conn: fix potential UAF in set_cig_params_sync
 - hci_event: fix potential UAF in hci_le_remote_conn_param_req_evt
 - hci_event: move wake reason storage into validated event handlers
 - SMP: force responder MITM requirements before building the pairing response
 - SMP: derive legacy responder STK authentication from MITM state
 - MGMT: validate LTK enc_size on load
 - MGMT: validate mesh send advertising payload length
 - SCO: fix race conditions in sco_sock_connect()
 - hci_h4: Fix race during initialization

----------------------------------------------------------------
Cen Zhang (1):
      Bluetooth: SCO: fix race conditions in sco_sock_connect()

Jonathan Rissanen (1):
      Bluetooth: hci_h4: Fix race during initialization

Keenan Dong (2):
      Bluetooth: MGMT: validate LTK enc_size on load
      Bluetooth: MGMT: validate mesh send advertising payload length

Luiz Augusto von Dentz (1):
      Bluetooth: hci_sync: Fix UAF in le_read_features_complete

Oleh Konko (3):
      Bluetooth: hci_event: move wake reason storage into validated event handlers
      Bluetooth: SMP: force responder MITM requirements before building the pairing response
      Bluetooth: SMP: derive legacy responder STK authentication from MITM state

Pauli Virtanen (5):
      Bluetooth: hci_sync: call destroy in hci_cmd_sync_run if immediate
      Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
      Bluetooth: hci_sync: fix leaks when hci_cmd_sync_queue_once fails
      Bluetooth: hci_conn: fix potential UAF in set_cig_params_sync
      Bluetooth: hci_event: fix potential UAF in hci_le_remote_conn_param_req_evt

hkbinbin (1):
      Bluetooth: hci_sync: fix stack buffer overflow in hci_le_big_create_sync

 drivers/bluetooth/hci_h4.c |   3 --
 net/bluetooth/hci_conn.c   |   8 ++-
 net/bluetooth/hci_event.c  | 127 ++++++++++++++++++++-------------------------
 net/bluetooth/hci_sync.c   |  88 +++++++++++++++++++++----------
 net/bluetooth/mgmt.c       |  17 ++++--
 net/bluetooth/sco.c        |  26 ++++++++--
 net/bluetooth/smp.c        |  11 ++--
 7 files changed, 165 insertions(+), 115 deletions(-)

