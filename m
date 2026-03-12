Return-Path: <netdev+bounces-267197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H2dGtwds2mDSAAAu9opvQ
	(envelope-from <netdev+bounces-267197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:11:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B1B2788F6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 21:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E977300EA85
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 20:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C60DC401A1D;
	Thu, 12 Mar 2026 20:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjVY3MBO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F2401A2D
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 20:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346027; cv=none; b=b5xrA2sPd5eNkutQ1UFuENMKIWfVbo353nersLJGwAuV+Uau6ABIiv2x7Ynq1o3Cc8Qjz0zd1Vpj1Fg4likskYyCLdwWHUMH6it7PPU9KCvI0K5HC7bi0bxDizaohc+Lu5ALVKI4MlOurt4fkJ3/BVguhMp41lgFxI/TW65Mb9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346027; c=relaxed/simple;
	bh=9LTfdfEyjL4iMdSHB+Kvse1ywfY0yqyvL/BRU9og3zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QtbMdi1DUzgxgMsd8mi4d9Z/qllVujJSx0Pew3rIaUoJc+W4QLVn45/ffF+hqkzzRAyI8d8g+0OE+RR35LQyS5Xi0DytrW6jW6jnBvYX5H0dRn2WbzaJhBfNEIJEL2NFPQuw99nrDP7B2cOqWAsaIw42Y50i/eM0u9Pq526NOUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjVY3MBO; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79495b1aaa7so15404577b3.1
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 13:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773346025; x=1773950825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3HJ0No0Nr2joHFlv9JslreD/RzRYlwKb5xVL/UtKQ0=;
        b=HjVY3MBOsPDlN34tbspbzg1rKSxiOgkfBMf+uQNZ5Y0ltkdMewG9ERmgRr/r+SdKOu
         IdqHewxNrKpIm9CW7RCnUaKNRRNr2fTgmPTAjsi9Hr3jpdo9a7LyAEj9K1GcYSw6oWis
         oGZzbFabF1Yl8KFeYe6sBoz0bqaJXZXj86svU8TqnTYU/PupprK6R3UjBig0yVIwSp7h
         yQqCd1stNtEatYZIYa5wjS0kcpY2rtc5LE9IJ82k6X7VYmxojMcBsA75VoVLAydffUen
         u9LLTZyKAPZwRuZNboSWcYLertWQA7bhy8iBvl/Alf4/j9JsvazKBgzHFPluIRpVsSS/
         x71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773346025; x=1773950825;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R3HJ0No0Nr2joHFlv9JslreD/RzRYlwKb5xVL/UtKQ0=;
        b=fGWSg7AJ/1RRVjyUr4nl6dZYESLDKOfBBNO2EiiypvluZC9qlAktye3S6yYL05aDUD
         tWU0xwq7nMQwdVB+Hy9zt1GBRnFYpRDtJkDiEf8HpF3VLmB/0yWADa4+qzU9U3gYosTg
         F7F9d7byqi6STRZ1jBrYR6pzhh7oWdYTu7hkM6/PcT0Fj0JB6EKWIVQgYhDSjfNmSd+t
         M0DqogBNuOsndUTQohcyUleEcG4pA84ffSYb+1b5FOdNBxjS1CxfJYoxU+svKmqI1G1D
         yqkL//idH3psBe1vi5pgwYZxMLAorSUGP5S+BWAYeUcY6CiqWDTUHcsLo/7b6lUfxdsn
         QCFg==
X-Forwarded-Encrypted: i=1; AJvYcCXXcYQ4YZOT82t1UCxOh4w/1gbsM2TOEV03NxgEPBJGlSBckIhbos+ZEezC+QoB865dLuljK34=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXCHaNUXzPZShFPQYSn5CMocccMfbFjzE+rhjGwNUc7Jd8sMnK
	IL+Shg5NjMsxeWC+VSfbaF0Qu+4GNedK5di8GV2vnF0LfkQuKSQxkPG5
X-Gm-Gg: ATEYQzxqz0RM1Qg2jjHzsZvXMeDi/eem1BrdJlIdBZFvkfxvHM89WOa3+gFr9MVaFzX
	K7dXFcdnGF/vMdLKYQVE7/AncRLuVrouxkkVXAvmFayUJuGM/5dHIDk9A50xLhi72A3kKWo/8/h
	d3AM96yVT/eWlASXfRFSacP4euTmeXUhJWnUp891rfne4oxAwxXTu3v+U4yoI/tP0THiQLl5Gkg
	Smo2OfvByQ7JpvYm0MyJIV9mtwYbn7sbWsn3ua1rvXBh8LP0txK0pmh6/2aN70Oe6EsGCqi9UoO
	xWURofSCehDWB07chB7AedaLQHF1v6EqmwDEPkCKeh2kEs3Gf9a2Q3BShkQe/5QNv0mmRIuJwD0
	oJ5s8Y8y/0CAtGClSWa0ra6V5XE2c9I6bvCtRDezxwhYEGChL3cHR2wrZJkgV4L4BXj8Nofs1iu
	okF87LLaUB9h6VUcBSMSz6k0h/PEGMyUhef/7a4ykaytAQEEn6se5cSJcgjGpbkf9JyzOirfFxC
	KEH56hrG/nNDWDVzw==
X-Received: by 2002:a05:690c:d88:b0:796:2fde:5dfe with SMTP id 00721157ae682-79a1c18d08amr10225327b3.38.1773346025526;
        Thu, 12 Mar 2026 13:07:05 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917f1d2f6sm35609007b3.42.2026.03.12.13.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 13:07:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-03-12
Date: Thu, 12 Mar 2026 16:06:54 -0400
Message-ID: <20260312200655.1215688-1-luiz.dentz@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267197-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2B1B2788F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit c38b8f5f791ecce13ab77e2257f8fd2444ba80f6:

  net: prevent NULL deref in ip[6]tunnel_xmit() (2026-03-12 16:03:41 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-03-12

for you to fetch changes up to 99b2c531e0e797119ae1b9195a8764ee98b00e65:

  Bluetooth: qca: fix ROM version reading on WCN3998 chips (2026-03-12 15:29:29 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - hci_sync: Fix hci_le_create_conn_sync
 - MGMT: Fix list corruption and UAF in command complete handlers
 - L2CAP: Disconnect if received packet's SDU exceeds IMTU
 - L2CAP: Disconnect if sum of payload sizes exceed SDU
 - L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ
 - L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
 - L2CAP: Validate L2CAP_INFO_RSP payload length before access
 - L2CAP: Fix use-after-free in l2cap_unregister_user
 - ISO: Fix defer tests being unstable
 - HIDP: Fix possible UAF
 - SMP: make SM/PER/KDU/BI-04-C happy
 - qca: fix ROM version reading on WCN3998 chips

----------------------------------------------------------------
Christian Eggers (3):
      Bluetooth: LE L2CAP: Disconnect if received packet's SDU exceeds IMTU
      Bluetooth: LE L2CAP: Disconnect if sum of payload sizes exceed SDU
      Bluetooth: SMP: make SM/PER/KDU/BI-04-C happy

Dmitry Baryshkov (1):
      Bluetooth: qca: fix ROM version reading on WCN3998 chips

Luiz Augusto von Dentz (3):
      Bluetooth: ISO: Fix defer tests being unstable
      Bluetooth: HIDP: Fix possible UAF
      Bluetooth: L2CAP: Fix accepting multiple L2CAP_ECRED_CONN_REQ

Lukas Johannes Möller (2):
      Bluetooth: L2CAP: Fix type confusion in l2cap_ecred_reconf_rsp()
      Bluetooth: L2CAP: Validate L2CAP_INFO_RSP payload length before access

Michael Grzeschik (1):
      Bluetooth: hci_sync: Fix hci_le_create_conn_sync

Shaurya Rane (1):
      Bluetooth: L2CAP: Fix use-after-free in l2cap_unregister_user

Wang Tao (1):
      Bluetooth: MGMT: Fix list corruption and UAF in command complete handlers

 drivers/bluetooth/btqca.c  |  2 ++
 net/bluetooth/hci_conn.c   |  4 ++--
 net/bluetooth/hci_sync.c   |  2 +-
 net/bluetooth/hidp/core.c  | 16 +++++++++++++--
 net/bluetooth/l2cap_core.c | 51 ++++++++++++++++++++++++++++------------------
 net/bluetooth/mgmt.c       |  7 ++-----
 net/bluetooth/smp.c        |  2 +-
 7 files changed, 53 insertions(+), 31 deletions(-)

