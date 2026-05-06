Return-Path: <netdev+bounces-285027-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AABSHKOo+2myewMAu9opvQ
	(envelope-from <netdev+bounces-285027-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:46:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D004E0548
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 22:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD7DE300FB10
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 20:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E910318B9C;
	Wed,  6 May 2026 20:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwfdChS9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40A6361DBC
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778100363; cv=none; b=iX0uWR0wavShx7CfW1M3EcBjmd70+N+oOW1zp2pkn2GjSLPfjRn+sK44Fxs0nq1ATPriOS6BJCnQ7BOOr8h6bPM/3lCG6KRBGUGbn/T9xrhvyl4k8040ShkoyUD0EswYpESbxW0BgpGSKv/p3tvjHrWoouw+Z1klty9opWuNOyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778100363; c=relaxed/simple;
	bh=6gBZ/hJmLLjnbYlzfhgRmDgIBrzs6c5ad/i7CBsGmyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pvHQ5PU/ischd38Ur6HXcfBqRzIx4NWfq//WTMyo8apZksvYLT8kuTBM9Uee4QBYrzORn4vQDr2yEsvvIffriNvnJq/aInfjTOUyjz++upsQ6eVoE2Si6V8LcZMrr5cPP90rFB9TQTuCYgOVnmSPz3I22W86pAM3mZiIKxHRyNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwfdChS9; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-575267e3398so118850e0c.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 13:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778100361; x=1778705161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g392jgB+6lnAAk+nEefn10QGzGcNLgIsVxIMykrWjPA=;
        b=JwfdChS9St9D429uUrvo3onHYG2iOOWId1G7BR7D58nBeFMz4hYHo9tTHZECFljox4
         t1sORm/RUe2VmM0tDoKItDUwczU+L+/fgueR37pxWSy0DdFQZOCSu7T7g+U8X5sQFOKM
         lUph9T7SMFufrKEkee/JSxWGEn+LfRh9rNCHf+ZR+iIbZ1p4lIDbQq5RZDgostlCM3j3
         ykIdkXgIvd6U5nX854ryQSgz4RPKn0u+QbJVkMkYSZtb8BbuH7ZkXi9RlRTU9NYe7akf
         AT5l3xtpFrPHcqh7BKaahOdABN7UDnMbJR2A2JwJSXgdBj5rz4MwUEs3pbMmDnE7NcRo
         7L8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778100361; x=1778705161;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g392jgB+6lnAAk+nEefn10QGzGcNLgIsVxIMykrWjPA=;
        b=Uc65uZh4CQPKNf+Wj2wm6uqTqX+aTcI5zMy4XdAMhgKxXbd8g/UmPxJtn3fMQTgywI
         jezAbJa4ATpb6LazwDQVaVX3wNbT4bWWEyV7iIrp+b1f3TSkJwpvEmtC0ML8Wbu51ey8
         j3K4un1GAiSV8mbEsoeG2F0ggkodiWBUMA2tac+/c45wZUqpK9V9G/7BZRAK8VxOw8Bm
         3Bo+S7T3xp1QXjkG21o/JNa43x3VQzzMfTP6rwTScFMZiE0Wi9oXrFUiXCugy6Bg7BWj
         2rq+ViNJ5/pwuQGbaaKRk+p/dGdjVV3xobJuvhyfYkMXAg+LUY5JekBTyyZ8Iz3lA8zd
         FrYg==
X-Forwarded-Encrypted: i=1; AFNElJ+McTx7xP/ESX4JI0L3gPQP9wAKro5QlT1d9fukPxgaWNhtjIE6LkeQvaBnK00EPH5kw46Tj2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPVfqtrTGKgedaRX9Ck7y070ZZwg/0Gu5Q7xtgNUuCNW8pWvmm
	WIfWfi+hGS9rcn6RO2yyfwThuW9JPzK7RD9nRSbEF9z0OdLVw2kSzBDG
X-Gm-Gg: AeBDieuIYe/wKBSKMUFZmo2Enm8/m3bLBDjduSWE9S4bnGEbZ3YEVtDISm0TwHUHJNC
	xbZ1JFTlNRi24co4ofi0MFpOQh+xNCYdwIAUJXUuVN913K2hbS+HdTayT5tr8mYwYSpp2rxZPnt
	a7Gw2N/EtGqmmYXIUaM1PhRGI+I7j9oY1rhWF7ogdoYwxYonxIRM5eyjmkFg9Ll1U4hB/W76YwO
	JN0HZeI6jjfwWnHk/8WFFxCVlz9Z+RDxqTALBurRm9OALEbzUYS0an/+yqB2CEZB8wcb0+qzafr
	0JU5vBotNlceB9DIKpq/docLSiD6rJS5IRl1TjPoVKg/9Mdh07L1RrjcUeQa30g4uzfEvqnTY38
	VGtYUBGQsrHS3lDg0zuWOMRr5be1d9c/WRd4+jH3fqq7adwc7B2+UIo4xDIqu0WKGsJwQbKKJan
	xXy0ZdttFJIwAVBmoff1cbvLcFVV5Ur/dI2cE668rry3YJAIho2+DBDHu7a3j1ZPWGUaLfz6Xbl
	u2j+SGLYVfjuWRdW8XOWQIW4Unn
X-Received: by 2002:a05:6122:3a0f:b0:56a:fcbf:8aa4 with SMTP id 71dfb90a1353d-575595d06c3mr3478778e0c.2.1778100360812;
        Wed, 06 May 2026 13:46:00 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-574a6dc1e08sm10962969e0c.13.2026.05.06.13.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 13:46:00 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-05-06
Date: Wed,  6 May 2026 16:45:53 -0400
Message-ID: <20260506204553.58686-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66D004E0548
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-285027-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

The following changes since commit b89e0100a5f6885f9748bbacc3f4e3bcff654e4c:

  Merge tag 'wireless-2026-05-06' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless (2026-05-06 07:29:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-06

for you to fetch changes up to c5d415596cb6fbdf6334b06cc87a1a5a268d8725:

  Bluetooth: HIDP: serialise l2cap_unregister_user via hidp_session_sem (2026-05-06 16:27:53 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_conn: fix potential UAF in create_big_sync
 - hci_event: fix memset typo
 - hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt
 - L2CAP: fix MPS check in l2cap_ecred_reconf_req
 - L2CAP: defer conn param update to avoid conn->lock/hdev->lock inversion
 - L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
 - L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
 - L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()
 - RFCOMM: pull credit byte with skb_pull_data()
 - SCO: fix sleeping under spinlock in sco_conn_ready
 - SCO: hold sk properly in sco_conn_ready
 - ISO: Fix data-race on dst in iso_sock_connect()
 - ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths
 - bnep: fix incorrect length parsing in bnep_rx_frame() extension handling
 - hci_uart: Fix NULL deref in recv callbacks when priv is uninitialized
 - virtio_bt: clamp rx length before skb_put
 - virtio_bt: validate rx pkt_type header length
 - HIDP: serialise l2cap_unregister_user via hidp_session_sem
 - btintel_pcie: treat boot stage bit 12 as warning
 - btmtk: validate WMT event SKB length before struct access

----------------------------------------------------------------
Aurelien DESBRIERES (1):
      Bluetooth: hci_uart: Fix NULL deref in recv callbacks when priv is uninitialized

David Carlier (1):
      Bluetooth: hci_conn: fix potential UAF in create_big_sync

Dudu Lu (2):
      Bluetooth: bnep: fix incorrect length parsing in bnep_rx_frame() extension handling
      Bluetooth: l2cap: fix MPS check in l2cap_ecred_reconf_req

Jann Horn (1):
      Bluetooth: hci_event: fix memset typo

Luiz Augusto von Dentz (1):
      Bluetooth: hci_event: Fix OOB read and infinite loop in hci_le_create_big_complete_evt

Michael Bommarito (3):
      Bluetooth: virtio_bt: clamp rx length before skb_put
      Bluetooth: virtio_bt: validate rx pkt_type header length
      Bluetooth: HIDP: serialise l2cap_unregister_user via hidp_session_sem

Mikhail Gavrilov (1):
      Bluetooth: l2cap: defer conn param update to avoid conn->lock/hdev->lock inversion

Pauli Virtanen (2):
      Bluetooth: SCO: fix sleeping under spinlock in sco_conn_ready
      Bluetooth: SCO: hold sk properly in sco_conn_ready

Pengpeng Hou (1):
      Bluetooth: RFCOMM: pull credit byte with skb_pull_data()

Sai Teja Aluvala (1):
      Bluetooth: btintel_pcie: treat boot stage bit 12 as warning

SeungJu Cheon (2):
      Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
      Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event paths

Siwei Zhang (3):
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_state_change_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
      Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_new_connection_cb()

Tristan Madani (1):
      Bluetooth: btmtk: validate WMT event SKB length before struct access

 drivers/bluetooth/btintel_pcie.c |  13 +++-
 drivers/bluetooth/btintel_pcie.h |   2 +-
 drivers/bluetooth/btmtk.c        |  15 ++++-
 drivers/bluetooth/hci_ath.c      |   3 +
 drivers/bluetooth/hci_bcsp.c     |   3 +
 drivers/bluetooth/hci_h4.c       |   3 +
 drivers/bluetooth/hci_h5.c       |   3 +
 drivers/bluetooth/virtio_bt.c    |  39 +++++++++---
 include/net/bluetooth/hci_core.h |   2 +-
 net/bluetooth/bnep/core.c        |  13 +++-
 net/bluetooth/hci_conn.c         | 124 ++++++++++++++++++++++++++++++++-------
 net/bluetooth/hci_event.c        |  29 ++++++++-
 net/bluetooth/hidp/core.c        |  27 ++++++++-
 net/bluetooth/iso.c              |  56 ++++++++++--------
 net/bluetooth/l2cap_core.c       |  14 +----
 net/bluetooth/l2cap_sock.c       |   9 +++
 net/bluetooth/rfcomm/core.c      |   7 ++-
 net/bluetooth/sco.c              |  60 ++++++++++++-------
 18 files changed, 320 insertions(+), 102 deletions(-)

