Return-Path: <netdev+bounces-15107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66DD1745B1E
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 13:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8E2280D88
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 11:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0784ADDDB;
	Mon,  3 Jul 2023 11:31:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BD88F73
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 11:31:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD31CC433C7;
	Mon,  3 Jul 2023 11:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688383879;
	bh=4dMz6AICQADVRRk6AU4c36ys4TXGNzy34CAOZWE5z1o=;
	h=From:To:Cc:Subject:Date:From;
	b=JGYuRaq5gZfzOX8EqTv+gxLLWUN2XdBFw6I4bM65b02eU9FLNa05+EkPbuIM/w/0L
	 KKTu7s2hACooo45t5NDtM88Rdku73L7/D/1UNqwCFiT456JhYx2FO6FLHa2zAdQXk4
	 kBYM+1lb9c7KI7X8CAO+I/L6fuxTwIv5D8kBj4byiLVWnJR/Y+9kCcCt/CZSdG19TK
	 6u0MLr5Qpf3fIrA27gXgGb+rRYtyqDcI2T4SQ7j6UslQf0KizBMVMnA9OEbppJPDLf
	 SHVBr8s4T3LmNTyYyYLytU73cOIVLW9itW3Pxduydln2eOH0/4tsmDNlAFniXdwStT
	 DMbLYPeHBgZ9g==
From: Arnd Bergmann <arnd@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Chris Lu <chris.lu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Jing Cai <jing.cai@mediatek.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Manish Mandlik <mmandlik@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Brian Gix <brian.gix@intel.com>,
	Pauli Virtanen <pav@iki.fi>,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>,
	linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: coredump: fix building with coredump disabled
Date: Mon,  3 Jul 2023 13:30:48 +0200
Message-Id: <20230703113112.380663-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The btmtk driver uses an IS_ENABLED() check to conditionally compile
the coredump support, but this fails to build because the hdev->dump
member is in an #ifdef:

drivers/bluetooth/btmtk.c: In function 'btmtk_process_coredump':
drivers/bluetooth/btmtk.c:386:30: error: 'struct hci_dev' has no member named 'dump'
  386 |   schedule_delayed_work(&hdev->dump.dump_timeout,
      |                              ^~

The struct member doesn't really make a huge difference in the total size,
so just remove the #ifdef around it to avoid adding similar checks
around each user.

Fixes: 872f8c253cb9e ("Bluetooth: btusb: mediatek: add MediaTek devcoredump support")
Fixes: 9695ef876fd12 ("Bluetooth: Add support for hci devcoredump")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/net/bluetooth/hci_core.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c0ca3f869c923..491ab83ccafc9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -593,9 +593,7 @@ struct hci_dev {
 	const char		*fw_info;
 	struct dentry		*debugfs;
 
-#ifdef CONFIG_DEV_COREDUMP
 	struct hci_devcoredump	dump;
-#endif
 
 	struct device		dev;
 
-- 
2.39.2


