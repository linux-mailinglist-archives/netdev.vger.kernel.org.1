Return-Path: <netdev+bounces-288063-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LS0JmQGBmrFdwIAu9opvQ
	(envelope-from <netdev+bounces-288063-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:29:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B77545531
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 19:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CA8430C3919
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 17:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D1C38A72A;
	Thu, 14 May 2026 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOB51kRW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF7B344D8C
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779432; cv=none; b=nKMSWrSqP+kGYndMenp0A0Mq2Yy5kf98qASKquW85ko0DwcUgMFqRren9biNX/58Zp8JYXHIewZU+dVar9A01otgqIZhumMGbuHni2bVD4Hy2PorD+0PSviCfImKaPkoMLBq1OThE+zBVdO5LLrDA4Zp0TQnlB1JySWGpJCB33U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779432; c=relaxed/simple;
	bh=UxCBYGY3s2MIDYx54tYdfNvb9kBnDW1Yy02G6slmgsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sXv0IGrwghb00EfhH41O4V/40crlqEUk2JafUb4yE5hciOccjSfnlhC2jUtTqZi4MXdBW/ZKsOawEoaXj0p7NezUjBmTQP6E4D2yC8SCYzB9LzvQD1PcuUoIeH5+qVIxZsegHgAXAY541l4Qbm767+0p3XOOLeDSU7xh6zhkdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cOB51kRW; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-575602688deso2524626e0c.1
        for <netdev@vger.kernel.org>; Thu, 14 May 2026 10:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778779430; x=1779384230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F3HI5Nvh1903Kd6e+7GWP1fzYcWJf2b91PQiVaTWuSs=;
        b=cOB51kRWSYs+ybQ0w1t1OyDgrheghwbOqSZeHsSI5wW6p2YcLLWSAGIiCCg5z7ui5r
         4I+/84IrpjXLUoMdHJOyLmnKgDF7xaEaJ/zfEVg6q8tAAwqiCqRTlEQ52lT96LLoOaQU
         H+FhyihdP2PethICpz3PcRLm68zPrnhEiEHiKJ8cWWrQjEOdRTJ2x+VcVlTmCwl9h50y
         bqHrTf8ElR/c3jmGPwrP7XA/SgVPqnstNKFvccfBbtB0kNur2vHkhOIgQlIG7//8+Kw4
         SOEzrLB9CdrP6wYsuzNlYIpns6tcxV0/rHVZ7dOoRzchlkFkj29UbYPK9sTAsWXA13aH
         hBag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778779430; x=1779384230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F3HI5Nvh1903Kd6e+7GWP1fzYcWJf2b91PQiVaTWuSs=;
        b=oVmQFXTJv408GQFQHjQzzWI0LmaUndkWTxKxrdq9XbAPTAuLO0M5WmwldTl4zC0ynj
         p0sqxuj6AUj859WNf/+wRQKsN+FjZfXwJLJ1satXaU3lgGa7A5QrZ/Ja2VaY2I9xjx25
         wQ66tbZnt+Q5kywEZ2Do2x0gyTS3bGLIVmcZJL43ZIPuTc6jqmDaYx2Hka8kG/I+1blc
         3k4LsypU84eaVTELUK/lPGt9f6RoEcnYUTB9lRKxX4hKi13yz14LtSNPagwqlgsPXuzz
         jKiGmC3KiRI0WOhOfoSr9I7dnJCpTHHfnkV/cdOHsaw3GD0nqSrVhAdTQLC8KhVpZNLP
         mNDA==
X-Forwarded-Encrypted: i=1; AFNElJ81rxgMb5/u80nCWL0WQypzY+4EXxLOWhe5YnUxVFSwpLXHhbcgWg0t8khuk63QOaUqvljG6CY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmMO56RNr7Rs3b5wOGbt4S5igzsYebKkd0fbrS0ByAzlZ4ynnV
	M7CT+yHn+YSxbQx6ofeo23Phql8ouetKbI5amm2Sn5Ae0uwhGb3NOm20
X-Gm-Gg: Acq92OHckjVHOHW9sE/gN0wbGpU2wxOiPwQ6+nRWzAhu1acai34qNi31XM3Olhv0Lxk
	hoZcreOlMe80jMfaWrl28B4ISgM4b4J9SySoEyke3lPRkzWvz5oxgdxvzN2FEvGhUmHY7YJu4SZ
	7rKMLPUSAswGc9LdsE0xUpSLF5sttvrEZEVojUL36jnwctbSXf2zPei8UmBfU8Vz6JT6ZZ7pwG7
	IeGXo47PqM8Cs52ygh3lDTsj7Zg3/DqJJEOVMGs9/OUSTqc+PRtna5t26Urwyrlpjszp52CBZrV
	nea0/c4jCRqNZIkW7f+cMaZLvY+IxfL5uH6LelM0jc5X8HhFhehLQ0LdoZh3S8LsTQGm0P6F45n
	Z41Pv000NF+SAnyt84cdW5kvH0NYz+DgGrb9R3hLuBTu0B0L6RRLyeE63IiByZmwqSax3l+dYvG
	kfm/us7V08gKeugilj+PcBENCR3CRbNo+em605Dhm2jmqMusWtVmYwBNNzRkIjpkIkgvJtPq4ri
	oT3r5ke4H3P/NH9kw==
X-Received: by 2002:a05:6122:e14e:b0:56f:694e:1f10 with SMTP id 71dfb90a1353d-5760bff04e1mr292136e0c.5.1778779430251;
        Thu, 14 May 2026 10:23:50 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-575fa2c3040sm1658483e0c.4.2026.05.14.10.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 10:23:49 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [GIT PULL] bluetooth 2026-05-14
Date: Thu, 14 May 2026 13:23:40 -0400
Message-ID: <20260514172340.1515042-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 16B77545531
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-288063-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The following changes since commit c78bdba7b9666020c0832150a4fc4c0aebc7c6ac:

  net: phy: DP83TC811: add reading of abilities (2026-05-14 15:17:12 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-14

for you to fetch changes up to 375ba7484132662a4a8c7547d088fb6275c00282:

  Bluetooth: hci_qca: Convert timeout from jiffies to ms (2026-05-14 09:58:08 -0400)

----------------------------------------------------------------
bluetooth pull request for net:

 - af_bluetooth: serialize accept_q access
 - L2CAP: ecred_reconfigure: send packed pdu, not stack pointer
 - btmtk: accept too short WMT FUNC_CTRL events
 - hci_qca: Convert timeout from jiffies to ms

----------------------------------------------------------------
Jiexun Wang (1):
      Bluetooth: serialize accept_q access

Michael Bommarito (1):
      Bluetooth: L2CAP: ecred_reconfigure: send packed pdu, not stack pointer

Pauli Virtanen (1):
      Bluetooth: btmtk: accept too short WMT FUNC_CTRL events

Shuai Zhang (1):
      Bluetooth: hci_qca: Convert timeout from jiffies to ms

 drivers/bluetooth/btmtk.c         |  4 +-
 drivers/bluetooth/hci_qca.c       | 33 +++++++--------
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/af_bluetooth.c      | 87 +++++++++++++++++++++++++++++----------
 net/bluetooth/l2cap_core.c        |  2 +-
 5 files changed, 85 insertions(+), 42 deletions(-)

