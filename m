Return-Path: <netdev+bounces-259582-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UK33D4Npl2muyAIAu9opvQ
	(envelope-from <netdev+bounces-259582-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:50:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DF81622CA
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D99D300D758
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7193D2FD7DA;
	Thu, 19 Feb 2026 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce5UiX/r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BB2FC01B
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771530623; cv=none; b=Hd/TbedegDHt1WxRULCODWvcZvuTHHBkZOA2maFV4Fe3w/FBdceRHOGTIJvR8KSiNBxhKw3XjQ1HV3+NKCE40ak2LfpzgUkJD7sS5x4VwipcswkAw9UPZN243QrJQCdQ0V6SFKBGfN5guB3oX5OjW5n5cjBudZBvaDbz0nuVSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771530623; c=relaxed/simple;
	bh=5Gw5nAbTft2x9TcdWgtrRybtFUONCCJiImuuk4GOmvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hU/rmj8GHXULvifxOIVDwRQubJM1+EDy28PueYHH2KyoRn0OsqDfW6RyOzz/r0nVZWdezV/JFTLWAXtkbuuGBBhCx6r4r66sziEOX8K2strMvA+LT7ky+vDRe7NJD9N7e3kyjqOkTvcvBDNf5hU4OopdVgu3VkkjvuuofNU9Tk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce5UiX/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF4FC4CEF7;
	Thu, 19 Feb 2026 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771530622;
	bh=5Gw5nAbTft2x9TcdWgtrRybtFUONCCJiImuuk4GOmvM=;
	h=From:To:Cc:Subject:Date:From;
	b=ce5UiX/rJoWfjYn+nuo9RUgxoc+ccu/ZuxP093c0zo3tfpCBJzqCaDbtiHrgyBoOX
	 oQ1fSKgVfZRfKGvZs9MWzE2yDGaOB2UA1T2xiXGEIfcOvsXRTwM14g3AXDAUqAfEUP
	 pjXXNDKDFFeOLrQBkh0GFiQafUssNI1YrBMgpPRq/xbedYIvGu2qDf+yXJaEK0hoeu
	 wrb3vBTXVZP1CWG9nWB9QYd5zSVxHWg0E8DWJF6hmUfrW8ctHlyCtFrv5MEs0TWJHv
	 EOcBBUf79fk4QB2jClgTltawdauZWTlB6GFtFOxcLokmeNWvY29YpoJxCBfkMPX5VC
	 7h5TuAzAFtV5g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	leitao@debian.org
Subject: [PATCH net] netconsole: avoid OOB reads, msg is not nul-terminated
Date: Thu, 19 Feb 2026 11:50:21 -0800
Message-ID: <20260219195021.2099699-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259582-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 10DF81622CA
X-Rspamd-Action: no action

msg passed to netconsole from the console subsystem is not guaranteed
to be nul-terminated. Before recent
commit 7eab73b18630 ("netconsole: convert to NBCON console infrastructure")
the message would be placed in printk_shared_pbufs, a static global
buffer, so KASAN had harder time catching OOB accesses. Now we see:

    printk: console [netcon_ext0] enabled
    BUG: KASAN: slab-out-of-bounds in string+0x1f7/0x240
    Read of size 1 at addr ffff88813b6d4c00 by task pr/netcon_ext0/594

    CPU: 65 UID: 0 PID: 594 Comm: pr/netcon_ext0 Not tainted 6.19.0-11754-g4246fd6547c9
    Call Trace:
     kasan_report+0xe4/0x120
     string+0x1f7/0x240
     vsnprintf+0x655/0xba0
     scnprintf+0xba/0x120
     netconsole_write+0x3fe/0xa10
     nbcon_emit_next_record+0x46e/0x860
     nbcon_kthread_func+0x623/0x750

    Allocated by task 1:
     nbcon_alloc+0x1ea/0x450
     register_console+0x26b/0xe10
     init_netconsole+0xbb0/0xda0

    The buggy address belongs to the object at ffff88813b6d4000
                which belongs to the cache kmalloc-4k of size 4096
    The buggy address is located 0 bytes to the right of
                allocated 3072-byte region [ffff88813b6d4000, ffff88813b6d4c00)

Fixes: c62c0a17f9b7 ("netconsole: Append kernel version to message")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: leitao@debian.org
---
 drivers/net/netconsole.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index d144787b2947..1b6a4135ec08 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -1679,7 +1679,8 @@ static void send_msg_no_fragmentation(struct netconsole_target *nt,
 	if (release_len) {
 		release = init_utsname()->release;
 
-		scnprintf(nt->buf, MAX_PRINT_CHUNK, "%s,%s", release, msg);
+		scnprintf(nt->buf, MAX_PRINT_CHUNK, "%s,%.*s", release,
+			  msg_len, msg);
 		msg_len += release_len;
 	} else {
 		memcpy(nt->buf, msg, msg_len);
-- 
2.53.0


