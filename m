Return-Path: <netdev+bounces-132563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 690CF99220F
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 00:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA30280F98
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 22:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E2618BB90;
	Sun,  6 Oct 2024 22:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gw.red-soft.ru (red-soft.ru [188.246.186.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6829E17279E;
	Sun,  6 Oct 2024 22:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.246.186.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728252750; cv=none; b=nY47COvX6zz+W/jpYOmldxGbhd8a7XpA1TZp7bwz5ckEiFqlZZQUEss/FlU+NbCaWUiVuUUDkq9r7HPmty5GtlIzjgJ1vriqhCB10Iz15c9UYpWXw0uyxXBQGctrVzsePCn7EXyM1p1sLtWC2qKN03d0M8oMzMGy8m+SbzaWTJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728252750; c=relaxed/simple;
	bh=YgZjDQuFFmd+mrRfj33FB3Xsxz15EvLmGWSrDvMU2Ps=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U+qbYkd2CEDc5va9UeBOT5z67y/iO/dtPKJe5Mh22u67ZqdqoAEGfOfVhQa7UG4O8YQVU483XvXo11wqK0rdSP0sWw6vHnMIOiMdNmQeZ4H8THFdCcjRn+GB3MoggnYPPVwuZynFRRDZTDvjLcHsSMKBwkWkRKh2QqO+erHK/x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=red-soft.ru; spf=pass smtp.mailfrom=red-soft.ru; arc=none smtp.client-ip=188.246.186.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=red-soft.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=red-soft.ru
Received: from localhost.biz (unknown [10.81.100.48])
	by gw.red-soft.ru (Postfix) with ESMTPA id 212753E1AB8;
	Mon,  7 Oct 2024 01:12:24 +0300 (MSK)
From: Artem Chernyshev <artem.chernyshev@red-soft.ru>
To: "David S . Miller" <davem@davemloft.net>
Cc: Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net] pktgen: Avoid out-of-range in get_imix_entries
Date: Mon,  7 Oct 2024 01:12:20 +0300
Message-ID: <20241006221221.3744995-1-artem.chernyshev@red-soft.ru>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-KLMS-Rule-ID: 1
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Lua-Profiles: 188241 [Oct 06 2024]
X-KLMS-AntiSpam-Version: 6.1.0.4
X-KLMS-AntiSpam-Envelope-From: artem.chernyshev@red-soft.ru
X-KLMS-AntiSpam-Rate: 0
X-KLMS-AntiSpam-Status: not_detected
X-KLMS-AntiSpam-Method: none
X-KLMS-AntiSpam-Auth: dkim=none
X-KLMS-AntiSpam-Info: LuaCore: 39 0.3.39 e168d0b3ce73b485ab2648dd465313add1404cce, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;red-soft.ru:7.1.1;localhost.biz:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KLMS-AntiSpam-Interceptor-Info: scan successful
X-KLMS-AntiPhishing: Clean, bases: 2024/10/06 21:52:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/10/06 20:00:00 #26711832
X-KLMS-AntiVirus-Status: Clean, skipped

In get_imit_enries() pkt_dev->n_imix_entries = MAX_IMIX_ENTRIES 
leads to oob for pkt_dev->imix_entries array.
```
UBSAN: array-index-out-of-bounds in net/core/pktgen.c:874:24
index 20 is out of range for type 'imix_pkt [20]'
CPU: 2 PID: 1210 Comm: bash Not tainted 6.10.0-rc1 #121
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
Call Trace:
<TASK>
dump_stack_lvl lib/dump_stack.c:117
__ubsan_handle_out_of_bounds lib/ubsan.c:429
get_imix_entries net/core/pktgen.c:874
pktgen_if_write net/core/pktgen.c:1063
pde_write fs/proc/inode.c:334
proc_reg_write fs/proc/inode.c:346
vfs_write fs/read_write.c:593
ksys_write fs/read_write.c:644
do_syscall_64 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe arch/x86/entry/entry_64.S:130
RIP: 0033:0x7f148408b240
```

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 52a62f8603f9 ("pktgen: Parse internet mix (imix) input")
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
---
 net/core/pktgen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index 34f68ef74b8f..97cf5c797a22 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -881,7 +881,7 @@ static ssize_t get_imix_entries(const char __user *buffer,
 		i++;
 		pkt_dev->n_imix_entries++;
 
-		if (pkt_dev->n_imix_entries > MAX_IMIX_ENTRIES)
+		if (pkt_dev->n_imix_entries >= MAX_IMIX_ENTRIES)
 			return -E2BIG;
 	} while (c == ' ');
 
-- 
2.44.0


