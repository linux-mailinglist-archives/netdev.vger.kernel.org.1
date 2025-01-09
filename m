Return-Path: <netdev+bounces-156564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE96A07009
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 332401881BBE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3926E215076;
	Thu,  9 Jan 2025 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="q5xxzmzX"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C142D18D;
	Thu,  9 Jan 2025 08:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411482; cv=none; b=ZrXmqc0z5csuahQsqauEg4uq3roIrX8unqmPCUYIl6z3DunVaLjptd6+BjtBeP6BLOPiLSD2n162y1QoIDIUhrAFtnNjmNz195z9rPU3bB6HBoLC2ny/GIH9XxnlWH64/00ToleWpljNgt26R+vMWiVlRTlONBLGipP7iy4ROBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411482; c=relaxed/simple;
	bh=DTG+VLYYNhfibLpiiX3tkfRJwljqTF0DRzk4xCa6v/U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=phNX/4Ft36T57sDMGBeSU4+iEzYex9UHU0FlTgGUaQpFVHozI6TkUU8Wwzhw7bLG8p0xMYio3NVbGrlN9m/wDRaeY/SQyZSDwChJ9cOlOy/rlGX8eU3s66hxRLcKoZZ9iPq1hdQehadhO9jaoFR5AkR62w8tH1zgN8nXWQbMflQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=q5xxzmzX; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc.intra.ispras.ru (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id 6398C518E77F;
	Thu,  9 Jan 2025 08:31:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 6398C518E77F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1736411476;
	bh=5rYLii8uf9KA/6wpvs1+wDjb3U84swAqGpAnDM9YanE=;
	h=From:To:Cc:Subject:Date:From;
	b=q5xxzmzXQvyB8JlP7da2fLnXh0esQ7XjrSIl6SQVMeu8+3Hx2FNCMhMRtQHN1q6N+
	 mdPEawMSwnV7yNXJQjZO9TH2J4cZ8QsT2dzuQQA5j0wX33PAFeTTB4ydXrBbp8ULUe
	 tcWhvp/Yq/6TqtM8j+t6Lr8Es1datqw3AgA4qItM=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Artem Chernyshev <artem.chernyshev@red-soft.ru>,
	Nick Richardson <richardsonnick@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH net v2] pktgen: Avoid out-of-bounds access in get_imix_entries
Date: Thu,  9 Jan 2025 11:30:39 +0300
Message-Id: <20250109083039.14004-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Chernyshev <artem.chernyshev@red-soft.ru>

Passing a sufficient amount of imix entries leads to invalid access to the
pkt_dev->imix_entries array because of the incorrect boundary check.

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

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 52a62f8603f9 ("pktgen: Parse internet mix (imix) input")
Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
[ fp: allow to fill the array completely; minor changelog cleanup ]
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
v2: prepare v2 based on Jakub Kicinski's review for the previous version;
    original authorship saved;
    https://lore.kernel.org/netdev/20241006221221.3744995-1-artem.chernyshev@red-soft.ru/

 net/core/pktgen.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index bab3827d5302..1964ff7ed2c3 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -851,6 +851,9 @@ static ssize_t get_imix_entries(const char __user *buffer,
 		unsigned long weight;
 		unsigned long size;
 
+		if (pkt_dev->n_imix_entries >= MAX_IMIX_ENTRIES)
+			return -E2BIG;
+
 		len = num_arg(&buffer[i], max_digits, &size);
 		if (len < 0)
 			return len;
@@ -880,9 +883,6 @@ static ssize_t get_imix_entries(const char __user *buffer,
 
 		i++;
 		pkt_dev->n_imix_entries++;
-
-		if (pkt_dev->n_imix_entries > MAX_IMIX_ENTRIES)
-			return -E2BIG;
 	} while (c == ' ');
 
 	return i;
-- 
2.39.5


