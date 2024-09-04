Return-Path: <netdev+bounces-125048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DB7596BBDA
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB6781C20D24
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253F81D88C6;
	Wed,  4 Sep 2024 12:18:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 265241D79B9
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 12:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725452282; cv=none; b=Tc0BC2gMMsi4YqIWPGWA/nxyXhPuLX8HTKk0Lo0vKG4c2yx2fyh9jwEVC6rEkFpP6GLyxaNYo7iZC4Li1hI0lyl9s/vbq70Cro8ASsMA1mclngl71MwihlBFG/vYQ0qubk4wOHZFII/3J+LxHuSAD5+CU77bu6RNvLjEbhsMI/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725452282; c=relaxed/simple;
	bh=Yzd7UcsDmj5BomshsbXtZwnblwWOH7/ztgZSj4rzjko=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=n8ql03ShNQ0P8AvmCrZi7/npR5GSEuxbmNS7IEovvNfgfXUmrhd1sj7zXPfcpESJyedkMWJZkcVC2s24+pnGLpdH0/uctl9nBdYeC5vOq+pW9ro56MdrKN3VGHI6qkkgE6L498EUekv/QGFcRhj9Bd0GQdWQMqStpEkFH72jrCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sloxJ-00074z-S0; Wed, 04 Sep 2024 14:17:49 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sloxI-005RvM-7E; Wed, 04 Sep 2024 14:17:48 +0200
Received: from localhost ([::1] helo=dude02.red.stw.pengutronix.de)
	by dude02.red.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.hauer@pengutronix.de>)
	id 1sloxI-002c07-0Q;
	Wed, 04 Sep 2024 14:17:48 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Wed, 04 Sep 2024 14:17:41 +0200
Subject: [PATCH] net: tls: wait for async completion on last message
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-ktls-wait-async-v1-1-a62892833110@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAORP2GYC/x3M3QpAQBBA4VfRXJtaLMWryMXELBMt7chP8u42l
 9/FOQ8oB2GFJnkg8CEqq4/I0gT6ifzIKEM05Ca3pjYW531RPEl2JL19j4Ys11RmhascxGoL7OT
 6j233vh921m7eYQAAAA==
To: Boris Pismenny <borisp@nvidia.com>, 
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>, 
 kernel@pengutronix.de, Sascha Hauer <s.hauer@pengutronix.de>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725452268; l=1916;
 i=s.hauer@pengutronix.de; s=20230412; h=from:subject:message-id;
 bh=Yzd7UcsDmj5BomshsbXtZwnblwWOH7/ztgZSj4rzjko=;
 b=cOvHuO/TzZbOz5d+f3OFQgHU03gt8IXPB85njXsOGBKqXyi9128TjqlDt9GevSRF8nrQ/NJYz
 iWbn2iW7ZlQCdHb+/gh5hQEk/nTH1b5qSZVOkN9VNoHLv+tXQPZgNPA
X-Developer-Key: i=s.hauer@pengutronix.de; a=ed25519;
 pk=4kuc9ocmECiBJKWxYgqyhtZOHj5AWi7+d0n/UjhkwTg=
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: s.hauer@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

When asynchronous encryption is used KTLS sends out the final data at
proto->close time. This becomes problematic when the task calling
close() receives a signal. In this case it can happen that
tcp_sendmsg_locked() called at close time returns -ERESTARTSYS and the
final data is not sent.

The described situation happens when KTLS is used in conjunction with
io_uring, as io_uring uses task_work_add() to add work to the current
userspace task. A discussion of the problem along with a reproducer can
be found in [1] and [2]

Fix this by waiting for the asynchronous encryption to be completed on
the final message. With this there is no data left to be sent at close
time.

[1] https://lore.kernel.org/all/20231010141932.GD3114228@pengutronix.de/
[2] https://lore.kernel.org/all/20240315100159.3898944-1-s.hauer@pengutronix.de/

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---

A previous attempt to solve this problem can be found here:

https://lore.kernel.org/all/20240410-ktls-defer-close-v1-1-b59e6626b8e4@pengutronix.de/

This patch had KASAN issues when running the tls selftests. This is
a new approach, solving the issue at send time, not at close time. This
patch can now run the tls selftests successfully.
---
 net/tls/tls_sw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 305a412785f50..bbf26cc4f6ee2 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -1201,7 +1201,7 @@ static int tls_sw_sendmsg_locked(struct sock *sk, struct msghdr *msg,
 
 	if (!num_async) {
 		goto send_end;
-	} else if (num_zc) {
+	} else if (num_zc || eor) {
 		int err;
 
 		/* Wait for pending encryptions to get completed */

---
base-commit: 431c1646e1f86b949fa3685efc50b660a364c2b6
change-id: 20240904-ktls-wait-async-0a4e9a513f6f

Best regards,
-- 
Sascha Hauer <s.hauer@pengutronix.de>


