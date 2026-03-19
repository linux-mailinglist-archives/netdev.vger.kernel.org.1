Return-Path: <netdev+bounces-269622-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEIMEaVJvGknwgIAu9opvQ
	(envelope-from <netdev+bounces-269622-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:08:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B272D184D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AB5231446F8
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FCE33DEF7;
	Thu, 19 Mar 2026 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFdhzQDI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57032307AF4
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773947107; cv=none; b=P4av5fJ4zWG0e0w/tCtOS3yTQFqVhgjm7lX1HnMXKYF8keWTzjoxibkC9ktkV649tQY76jIAUoc63Ulpb3G/NYJ3cGNLr7isUbqvPOr4G/W5/uAunoL1e0eg6dazS7XToCJh7O9Zw9yDr3xELD2XQdfILqxFsPauoC7/i0Jbxkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773947107; c=relaxed/simple;
	bh=LJt274V3ht8U3WHbvziiK44X1c37AgSUuKyPU84HBIk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eaeRsQfk2hmaC2p74pFX0A12jqCfVgLQ8G90ZUTHb3L0eO+fFK38oZDX+Bvqp8TIVtNV9ZyQOdDJHiENhSbOjuZxQIjTQBWFvJ44XXmXp041+Brx7QpqfnUrx2AzroqZbo4AGRQcJv4q3z274wTOCxA8tbZk94q2p7bkWB+og+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFdhzQDI; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56b65ef9441so1020918e0c.1
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 12:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773947105; x=1774551905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jr7WUgqLKbTlxBWlZ7mC0hG01SzLzNGqWw7Ddk7e0kM=;
        b=RFdhzQDI9fA0JQHQFus39ZHB19TIFglMmr8CxVE1ywpfddQtFiSeyg3ca/EtBsEACV
         DdXnLD9wFafVn8tSKZYpG4M4xX0yrKnKqFly0Re0Jmh+wq/AzwEPsSF22Avh0HsQxwcj
         uy8B5mU21e8IjJni/blBxI4rYLbckt6073607WKM/3NEuvHFYEM7bCVJHOKS3vs1+peN
         N39P7FY8W+lE7iK1nKRpfnoU/SjhLyQjst/Pt9XxboIffTIKMk561vZ6+f9PF2JyShqK
         XhoEGu6TmKyTraslKq+IUVqZTuoXQyT7CYNy57g6LZt0TigHnq+30eaogZCPLeBz9OvY
         Hktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773947105; x=1774551905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr7WUgqLKbTlxBWlZ7mC0hG01SzLzNGqWw7Ddk7e0kM=;
        b=AdAsH0XfgNfmrX1+cUKjnXfUXizo4H3RudnluYT4Ghyz3/BKF/Dw15mzgYCb7jDux/
         Gzu13uMlakVqIMd2MPbviqfSeKflX14oVInKz3d7ei29PkXa1T+ZHIg+kqycjDqbAM12
         RBtFEYYfy1XOVpHZB+jc+LerGTl6IeUlXgU0rNv6mfy4lgivKOmHECSc3K/SrjdvoO0k
         rk7rRGOvdcjdjpljJ3TApPnb/JRiME0n0S0YVNs2qBVTw9EBJ+AK4r0JE7ytNBHsGr5T
         l9BJaz+TmxoRGqgMXtXKfKRDVvpuqSSb0485QxSyTIcGEnd8C7KbzaeJGCYI95XsJMcJ
         NV6w==
X-Forwarded-Encrypted: i=1; AJvYcCUB+zisU0i8KyHVZybhIr+GaegIYOYqWWB/jZ8QuGSvbECRGXW9Unxf3CYTQNS2SAQ6tUJ5ZF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxctqK8EnE43j1cz8RonnGmr9ISSh6wvR5peW7zku8a67KEod8
	sPVwqGGXpPvUPWMdKAEF7fbWkYo3Q7JCApfw6eveBxirTreVQdjdQTbJ
X-Gm-Gg: ATEYQzzjULJD++8lY5IIFJF1oOUjsB39nYuOkHao5thKzliQIF4xvHqrxR3n3CniMJa
	WLAN38Wb8aKlq4Pzq6a7cBAaAv1JnREi0anNgg47zzyxkICuy7XsqtjbwBxJTzrracQeNle3VS0
	gpdiSt57/udW9tDnUnKpbMfX39A/gQrhWGJr/hUBg22xbQoDe4yKngsi1wIHMDC6+U1yowl1L6W
	eZjTKOixR/tXt2I3VmktWVMGM1Ee8pbVVWVEZcQwY4Z3tUY6/66f4x2IrWrzMbpLUUyutvpK88g
	7YUGoYBFikX/crgB1FuD1m6zLDDJCKfWVtxqNQhrz+m4paPDkA1lDwpkVAe0BEihAC2wsoFBq1N
	nPMHEmC7OzEBtyYeYyd9CmrmsLbwj9/pNq6RzV2EqhaGjqEZmaYYu8O8oKCv8ks1ov42L7g9GtQ
	URPWr7kuPssRpE9d4FeupHegS90xmzBx3whUO/GzK/XWKzmWk6HEONImS5fWJyQcRNauWaXiSrg
	FeTxmEIBgMU6KAWTA==
X-Received: by 2002:a05:6122:4890:b0:56b:7f53:9ab2 with SMTP id 71dfb90a1353d-56cde3fb2eemr176455e0c.10.1773947105220;
        Thu, 19 Mar 2026 12:05:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56cddcf1554sm341064e0c.17.2026.03.19.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 12:05:04 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-03-19
Date: Thu, 19 Mar 2026 15:04:55 -0400
Message-ID: <20260319190455.135302-1-luiz.dentz@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-269622-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.962];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D3B272D184D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 7ab4a7c5d969642782b8a5b608da0dd02aa9f229:

  MPTCP: fix lock class name family in pm_nl_create_listen_socket (2026-03-19 09:37:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-19

for you to fetch changes up to 761fb8ec8778f0caf2bba5a41e3cff1ea86974f3:

  Bluetooth: L2CAP: Fix regressions caused by reusing ident (2026-03-19 14:44:25 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_ll: Fix firmware leak on error path
 - hci_sync: annotate data-races around hdev->req_status
 - L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb
 - L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
 - L2CAP: Fix regressions caused by reusing ident
 - L2CAP: Fix stack-out-of-bounds read in l2cap_ecred_conn_req
 - MGMT: Fix dangling pointer on mgmt_add_adv_patterns_monitor_complete
 - SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold

----------------------------------------------------------------
Anas Iqbal (1):
      Bluetooth: hci_ll: Fix firmware leak on error path

Cen Zhang (1):
      Bluetooth: hci_sync: annotate data-races around hdev->req_status

Helen Koike (1):
      Bluetooth: L2CAP: Fix null-ptr-deref on l2cap_sock_ready_cb

Hyunwoo Kim (2):
      Bluetooth: L2CAP: Validate PDU length before reading SDU length in l2cap_ecred_data_rcv()
      Bluetooth: SCO: Fix use-after-free in sco_recv_frame() due to missing sock_hold

Luiz Augusto von Dentz (2):
      Bluetooth: MGMT: Fix dangling pointer on mgmt_add_adv_patterns_monitor_complete
      Bluetooth: L2CAP: Fix regressions caused by reusing ident

Minseo Park (1):
      Bluetooth: L2CAP: Fix stack-out-of-bounds read in l2cap_ecred_conn_req

 drivers/bluetooth/hci_ll.c    |  2 ++
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/hci_conn.c      |  2 +-
 net/bluetooth/hci_core.c      |  2 +-
 net/bluetooth/hci_sync.c      | 20 ++++++++++----------
 net/bluetooth/l2cap_core.c    | 40 ++++++++++++++++++++++++++++++++++------
 net/bluetooth/l2cap_sock.c    |  3 +++
 net/bluetooth/mgmt.c          |  2 +-
 net/bluetooth/sco.c           | 10 +++++++---
 9 files changed, 60 insertions(+), 22 deletions(-)

