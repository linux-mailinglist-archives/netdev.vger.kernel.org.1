Return-Path: <netdev+bounces-295952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lKYPL3UkI2qAjQEAu9opvQ
	(envelope-from <netdev+bounces-295952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:33:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B509864AF79
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 21:33:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cs.unc.edu header.s=google header.b=eCcGzrJ4;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295952-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295952-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=cs.unc.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8D868300BD7F
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 19:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691444071F9;
	Fri,  5 Jun 2026 19:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF783BED1F
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 19:19:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687191; cv=none; b=qXtGpAw36hHwPf8htDSy/xhBDd1lNQxshKtSS+ZKFpQzFbed9G0PJZvaLeAS5IJ9/FtTiULxM71ytjRrNaxwEFtRp/CMiv/iqIQC1mNf4puTYfD8lXFlqss+F/7rYimfFO0INX18JC2dx2zCdKGfywyvjE1UNFhMHtO4KTvSbkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687191; c=relaxed/simple;
	bh=lQyeoEHvPDcTd8UBfI28l1PrKOeUuXwWGO6rNePL3aM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HZGsZIyUdMMTyhiQsbuutEm2h7bszMptEPogRz/EelUPQaawEigBa6fqdgNQI3VcY/ZEqJ6Qp9dYISXWQ4EyvE4Oor2SCWHx0gt7JY80PKW76FlCAccfrhXVSnPgfx4gdfHLpQCdKmJZ/kwVRxtuhqitdI60Y8CfC6I6nl4dhoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu; spf=pass smtp.mailfrom=cs.unc.edu; dkim=pass (2048-bit key) header.d=cs.unc.edu header.i=@cs.unc.edu header.b=eCcGzrJ4; arc=none smtp.client-ip=209.85.216.49
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-36bc065c298so271561a91.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 12:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1780687184; x=1781291984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B0vJH8NNd0RF41K/4FCBtez2ytaf4nIFe3x4aSA4G5w=;
        b=eCcGzrJ4DDhZBO/s4Ntwd+hvBl/td6H2K4Kz8xGIIvcHauLoogijSjsyweD7TG1jZK
         A2RmBx2Xkz8DtAhduy5k2tPwehKJki2ZV1RfRiYlEEVWG3lYihK/rxbHmjRoCWYr0UPD
         Syj9Qv0wW2Sy9yKSfEQ3F0NQMg3esKIhBp2GmmgTgInWW/9dBiG9155fivTKff9bn9y5
         AtYVksSDXPWAowQNxjP0Yd1Un6Onp4O10g1C6liujsxCho+Hf7VJVpgmJxr0KzFmHEfN
         TPcKdaOZ68pVbgbeQpH/LIkUSr2UFKuUQEa/EvwIXE+bCB5fVkE3Jpe1Y5IuMCU26pXC
         0O2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780687184; x=1781291984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0vJH8NNd0RF41K/4FCBtez2ytaf4nIFe3x4aSA4G5w=;
        b=rYOTDJskO3I5nZ/C2oASD9yihETzWPYBuQ8JVUg87cx76arOgDMe8J+XJusUodznbl
         ZQRYcbAPsv7qYXGv7YL1zvgbwiKyaaD2ztHwH/wkEVa1+B/Ui79zyhR7zNCmLG/94x/7
         RPNfU5rLmlcgtL+b0FqSQjkoWMfvfk1mLbwisz5EjvyRE7RKksn8XVb030Em6ycPfgeT
         b0L0tdqK/BmmDr7i7ymZw5CyReJTTfHMfoyQSkpx9kLCFIRipcksIyznAyh4dzAHFPhW
         fa0VBgEDDsHPACR07oRvvmfwO7rRWjyV7rMaJ+chKXeKi8J1DlKZCEtHftkUbqZ+XThg
         R/yw==
X-Forwarded-Encrypted: i=1; AFNElJ9ObIv+Xpk7reSWUv4gLcjPaSPLZFnn1GEwc0FxoEoyUuHYm2ACS6ndoPG3ghdUBRCGRxHhyVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXy9y4xVlIIsCqsrTc3s5EeHcsOIE7R2sEcr6Y3wzgOpVUq915
	JgjrJMWDiQKg700o8Ee2QTft+kCw560UUOz7zdDhGOuETT/X2sCkpFKdt936lM8Qwg==
X-Gm-Gg: Acq92OFGcsnwYCC89KVjZYn/2G4qczUFs7xcNps3hAzcPL5wBwxJonwFH9YzxNDtW9J
	WwqpIHp2yxoL82+XNkcdok4qRmwttlo3bEFSQfZWqFY4Tgd6DfOIDluM2tlT9odiL3ve3kbfB0X
	ihWmYLNzvJ58aCLNIHJHVN1LJ7zunnN7si6dE09s4pYjPO2gjrtWHU3VB5qoXNyoJBf2hkyZUSa
	A1YU123ZFTOQTNrWj2fI7m5BztrSOJiEGQ6Pec+eMmCK8rGbhWADH7/IVJSVDVkjk4351dJaMpD
	IXsIVOk67fFGxzUKHmH0/aZvYQMHRHfE6lZhjkAWBdUZP2bfBWCHXWTNpev6GbXVjvtfzmq88jK
	KSzsupznAdm0xSVLUiDorj83PW+W2SbVyGiMOxv6/nzbcbfV7PTxNiVhy5e6Ce0YOFHJOvE2GRx
	NiqyviPWqgRk1XoemeG72AHsRF6fwgkf564piag3PiLUUqD807w1Of5NfJxhrgmA==
X-Received: by 2002:a17:90b:3dcf:b0:36b:3ecd:88d7 with SMTP id 98e67ed59e1d1-370ef0f50ffmr2677491a91.2.1780687183832;
        Fri, 05 Jun 2026 12:19:43 -0700 (PDT)
Received: from localhost.localdomain ([106.51.195.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842820e8e6asm9757737b3a.0.2026.06.05.12.19.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 05 Jun 2026 12:19:43 -0700 (PDT)
From: Divya Mankani <divyakm@cs.unc.edu>
X-Google-Original-From: Divya Mankani <divyakm@unc.edu>
To: kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,
	Divya Mankani <divyakm@unc.edu>
Subject: [PATCH] vsock/virtio: fix memory leak in virtio_transport_recv_listen
Date: Sat,  6 Jun 2026 00:49:22 +0530
Message-ID: <20260605191922.12720-1-divyakm@unc.edu>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cs.unc.edu,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[cs.unc.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295952-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[divyakm@cs.unc.edu,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[divyakm@cs.unc.edu,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:virtualization@lists.linux.dev,m:kvm@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com,m:divyakm@unc.edu,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cs.unc.edu:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,1b2c9c4a0f8708082678];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unc.edu:mid,unc.edu:email,syzkaller.appspot.com:url,vger.kernel.org:from_smtp,cs.unc.edu:from_mime,cs.unc.edu:dkim,appspotmail.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B509864AF79

Syzbot reported a memory leak inside virtio_transport_recv_listen
caused by a race condition when the parent listener socket shuts down
while an incoming packet is being enqueued.

Fix this by locking the parent socket and verifying its shutdown
state under the lock before executing vsock_enqueue_accept().

Fixes: a478546a782a ("vsock/virtio: add support for listen sockets")
Reported-by: syzbot+1b2c9c4a0f8708082678@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1b2c9c4a0f8708082678
Signed-off-by: Divya Mankani <divyakm@unc.edu>
---
 net/vmw_vsock/virtio_transport_common.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 3b294164b..8006a13bb 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1571,15 +1571,20 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	vsock_addr_init(&vchild->remote_addr, le64_to_cpu(hdr->src_cid),
 			le32_to_cpu(hdr->src_port));
 
-	ret = vsock_assign_transport(vchild, vsk);
-	/* Transport assigned (looking at remote_addr) must be the same
-	 * where we received the request.
+	/* Lock the parent listener socket to synchronize with a potential
+	 * simultaneous shutdown thread running __vsock_release().
 	 */
-	if (ret || vchild->transport != &t->transport) {
+	lock_sock(sk);
+
+	/* Check if the listener socket was shut down while we were
+	 * creating and configuring the child socket.
+	 */
+	if (sk->sk_shutdown == SHUTDOWN_MASK) {
+		release_sock(sk);
 		release_sock(child);
 		virtio_transport_reset_no_sock(t, skb, sock_net(sk));
 		sock_put(child);
-		return ret;
+		return -ESHUTDOWN;
 	}
 
 	sk_acceptq_added(sk);
@@ -1590,6 +1595,8 @@ virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 	vsock_enqueue_accept(sk, child);
 	virtio_transport_send_response(vchild, skb);
 
+	/* Safely release both locked objects */
+	release_sock(sk);
 	release_sock(child);
 
 	sk->sk_data_ready(sk);
-- 
2.50.1 (Apple Git-155)


