Return-Path: <netdev+bounces-274631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFogGpyhzmlZpAYAu9opvQ
	(envelope-from <netdev+bounces-274631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:04:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A74038C509
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 19:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90F7B3064749
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5F128851C;
	Thu,  2 Apr 2026 16:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="VqytO2VQ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wAcoMQeA"
X-Original-To: netdev@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26C43CFF70;
	Thu,  2 Apr 2026 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775148371; cv=none; b=RCwNyu8GJHlRSIoE2mIOQSx4it6UmqvJKMfvwEs2uLJkpfNhqGxNcnLwqgk+OSrxZAYAu2TF5qM03yDNwOBSibM6DmL5+iXqPWOnyUASycxFvRE3b6iqKEInUi9hHdELbX/vc755P4fy5V4XUj9+W4q3O/kNwn1X0CFiuLT7oy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775148371; c=relaxed/simple;
	bh=sB67ueWqBnu1mPBMZhJBmeeNRoaU0BvbTCh73OcR71o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VALE+M3pgOnJdILYD5RwCBYB8RmcWa/SuJZXfMJAPnF+z3Jc0MI+3YNyIKO6fDE+1biz628V4esc9W4n7TmGm7zSsvWvn3Tt1ZXrkqTK49PtHbkdlGOqm/JoDAm58F9w3i+aqbUq5MJNXOtHWrr4dgFjcnvsyF7DsQenM9MizSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=VqytO2VQ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=wAcoMQeA; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fmnmH6JkQzB14l;
	Thu,  2 Apr 2026 18:45:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775148351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Y1IOn6UI1l+FnCu4bYLPIoEoDffaMMvju4NVkgxBWE=;
	b=VqytO2VQ0/Ki8YBMMaG6LGYJTv/5fMucPNuQfco34nYc60+VSiMCsbq9Ta2DxjHjYsBCtu
	X5/pzOlOCsnyOce2gH+VA4CmX11+DJyzA7kIS7wCvZxXw7hyAy6TdcsOGGR+dWEmzlCMLC
	Pch7LHEn8XTkh7DwDGeJe5SBPLDDQK1sTti3GPQCAqJNyGsuDW6x85gHEMCrRS0Jx/dQdk
	xuw0Oh6XHxXOJwA0hYQrV36xXVFegKsGI+mMlnVf/C+fX4HxmX19IeFudLjRXU9XUYW2ES
	lb/JSoaCtSOW487ozP/HXPf1CA61thicbUFDeoIbBU/DDxV81yOWdrCQhI1i4Q==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=wAcoMQeA;
	spf=pass (outgoing_mbo_mout: domain of mashiro.chen@mailbox.org designates 2001:67c:2050:b231:465::2 as permitted sender) smtp.mailfrom=mashiro.chen@mailbox.org
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775148349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2Y1IOn6UI1l+FnCu4bYLPIoEoDffaMMvju4NVkgxBWE=;
	b=wAcoMQeA+mzD94qdHx/bInbTRdjwdifpXj7k6d+PFCNgZNJAw6yGv6WW7oQRtJoRQP9TB8
	5zhh7P+IsC2FMWSBdDotvfunzpmrZz2AzzJfd8eNt0JeFyU4CgB7+hR2ZTtFIVwus9/NYk
	9FjNP+FUjLDxZsUmkteKkrEvCW5wN2GteTGKlRD5bIcoaNjlQkUMkxVn7ISQsqCWYSAxdl
	+K4q9ITspBV+sEVPLdypZP4jPcaviUbxu8iotJqfZVVPWn50muk5dggPnDESrn8Lkv4LlM
	z1PMT/aS8teeme1BTF8Vt3gCuzt6XvBAd8WhLyGkvCINeClSOVrwAScArHdjzg==
To: ajk@comnets.uni-bremen.de,
	netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>,
	syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
Subject: [PATCH net] net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf
Date: Fri,  3 Apr 2026 00:45:25 +0800
Message-ID: <20260402164525.134244-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: ac0aa81cf57e890b0e5
X-MBO-RS-META: x3ydd4ypchmbgoc4jo3e9qb719gyu155
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274631-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,ecdb8c9878a81eb21e54];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 7A74038C509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sixpack_receive_buf() does not properly skip bytes with TTY error flags.
The while loop iterates through the flags buffer but never advances the
data pointer (cp), and passes the original count including error bytes
to sixpack_decode(). This causes sixpack_decode() to process bytes that
should have been skipped due to TTY errors.

Fix this by processing bytes one at a time, advancing cp on each
iteration, and only passing non-error bytes to sixpack_decode().
This matches the pattern used by slip_receive_buf() and
mkiss_receive_buf() for the same purpose.

Reported-by: syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ecdb8c9878a81eb21e54
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/6pack.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 885992951e8a6..c8b2dc5c1becc 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -391,7 +391,6 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
 				const u8 *fp, size_t count)
 {
 	struct sixpack *sp;
-	size_t count1;
 
 	if (!count)
 		return;
@@ -401,16 +400,16 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
 		return;
 
 	/* Read the characters out of the buffer */
-	count1 = count;
-	while (count) {
-		count--;
+	while (count--) {
 		if (fp && *fp++) {
 			if (!test_and_set_bit(SIXPF_ERROR, &sp->flags))
 				sp->dev->stats.rx_errors++;
+			cp++;
 			continue;
 		}
+		sixpack_decode(sp, cp, 1);
+		cp++;
 	}
-	sixpack_decode(sp, cp, count1);
 
 	tty_unthrottle(tty);
 }
-- 
2.53.0


