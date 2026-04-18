Return-Path: <netdev+bounces-279473-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GD0sJGAY42n/BwEAu9opvQ
	(envelope-from <netdev+bounces-279473-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 07:36:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBED8420089
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 07:36:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84C29305D6C4
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 05:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1126A346A15;
	Sat, 18 Apr 2026 05:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wj2AV8xO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB2633B97B
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 05:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490467; cv=none; b=cXarU+GMhezxSF88cQ6Tz3NAzEZxWcT3GpatYEQwAprxyV6H1Tf6RRwcfgc5e/fWU+kIpRCYbaPBGwdLs9H13rIL68RETyM+RHpPxjpROO1/UdWdc7yJ8lwqDENWEVnufa6c5ZmLdOrKLfv0oEksI62bG4fKTxQKWF4oOkQab2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490467; c=relaxed/simple;
	bh=C6Hn3L10r5uhLd2QzSnPaJi2BVQnAFECz4DQWvB6GuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAGhzJJKkvCvfZ15X/mc1eIz2KqTYYw3sw3GCIb1qWtYKIOZpc18JR/XdzbbXPwPRGLNAWKycFO6ykS8YD9dUwvplc3+52TO9F0vK+Loaz2mKxs8kTM/lBGKWsNmP9xQtLqgn5ZmHcWNJBRkIzFMTdjQKhQADj/V2Ue8KXIqBEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wj2AV8xO; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad9f316d68so5933265ad.2
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 22:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776490465; x=1777095265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aTLB8mgGvaT9B2aXVBnKEZE3IH4dRJ493bKxw7Qh57M=;
        b=Wj2AV8xOZwiGNnzUlzPLyXKgzP7N5Lfs66P+JzI0V1unT/jWACx2l8I18X+upPDTF/
         cKF16UalLUvU3o35mime47e2bYL5/QUkS2Pi4SUOvWvv1tbDCgmHAU/duNEdK5xTgK7n
         itYXRxEQUE+9OcLEZFoE95JHkdyuamtrs3JlB8a1Yky2in1r4l4rjlX0hiZXgt6h3VoP
         3cjdBQxQlQvNbUZDNJTTuj70J2fev3u3rFbz/wCjyCxWb6wG2gun7i1M/Q151jtS3c9p
         r2k2R8DO9unv0ME3keb4GAyB9CiczzEO4K30yPTt9ZNC1UWv28+a6Qj+25r9NicYLigw
         cyIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776490465; x=1777095265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aTLB8mgGvaT9B2aXVBnKEZE3IH4dRJ493bKxw7Qh57M=;
        b=pjvKY7aKR0ieVwAqUNLDjNcDQ9uHKE9rLSn/NHg9tLcm3VQ/pkKmnB015keV1V4LVE
         bjgKgcNrotZt3jVPsWyqEAtBNZNdS0501PAUeZLwLZcXvuCG/Gsy/WkaJndOFIE0HdIz
         sV2FM4/9j3qNLq0w+aRrhSDq+5/7dIDXDIm2o728gR0Sx50YEspDRDI5My/iH0XezF8c
         2dpIwrPgmv99wbwTgsXTT+IDgWKvlKts6Mpolaf3fH717KqeBOtxYJg3t1gercwt+yK/
         XE1ma+eT0NBC5DV1T1D0oHsXLr+kXcyzrC+DGdRwBrXW2V+KEXlwaAXv1bt9CyiD9Q2v
         bJWw==
X-Forwarded-Encrypted: i=1; AFNElJ/dCYUtCTpF3I0WoMnIJW4AxxXw8DjZW03r8vTlp9biFkwAhUdw7o3J/2bZWQYTWb1nQd0irDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNBCJNsK7fC+CpBkH6/hlXI4FLVzEfMDwvc/vdO1FkbmHWR7U9
	zSXCTFLccIi6PWBvCWHs9Cd7Q0VPS7sph/lQL0EVZZx34OSe7z4w4rv6
X-Gm-Gg: AeBDiesiuSr0ckCA45JiYY/DbvzY+Bs25VYOe6I3o0tklHe42N4wOFI2AeZFM7nJ/0y
	hjdVx539uKztcAUmh/flnqW/UQpKExj/o9DvKCNjDwDQMvHE3qq6pfovcD6AcSuJgVPGJ2eVs35
	7b3JBDnZm6JFja+pHNazHYkPpqOKkcQ1QeVSXIuZh4iUq6Vs0k04cx8YSBbO7OLbqsjdDQ9uBAu
	4gXpuDnk+gaH7HWtBAg0C0gxRizt1QXZZIPeQkGhyWJEvdVv7sLs8YxXGAZ42c6Hmnf7z8bX5Pd
	CJ8oOHRC/IPfPgcBD+RuH7e2KwZGXIlpIQXc/Yi+Tcc8ZwyXDlt5y9msyDwCZg8o4jgoaQ+4f4h
	cikwIwFwRayZxyhdarAJby5dwZh2tnV0lgXc2wXKbJKxR0TBvjaEJHMF9j+NuSABP1zkB99iSYV
	4k1/mh5OZh0BZkN7bGrH2vkzoYWwauc/dcuXcAeFBYR3rTsPcadKJML03sI7H3Z3EvMteg
X-Received: by 2002:a17:902:cf4a:b0:2b0:4b3a:9b4d with SMTP id d9443c01a7336-2b5f9f1c862mr62346035ad.20.1776490465079;
        Fri, 17 Apr 2026 22:34:25 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3bfsm46251885ad.7.2026.04.17.22.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 22:34:24 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH 1/2] Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
Date: Sat, 18 Apr 2026 14:34:00 +0900
Message-ID: <20260418053401.128483-2-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260418053401.128483-1-suunj1331@gmail.com>
References: <20260418053401.128483-1-suunj1331@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,holtmann.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,brighamcampbell.com,linuxfoundation.org,lists.linux.dev,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279473-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[suunj1331@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBED8420089
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

iso_sock_connect() copies the destination address into
iso_pi(sk)->dst under lock_sock, then releases the lock and reads
it back with bacmp() to decide between the CIS and BIS connect
paths:

    lock_sock(sk);
    bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
    iso_pi(sk)->dst_type = sa->iso_bdaddr_type;
    release_sock(sk);

    if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))  // <- no lock held

This read after release_sock() races with any concurrent write to
iso_pi(sk)->dst on the same socket.

Fix by performing the bacmp() inside the lock_sock critical section
and caching the result in a local variable.

This patch addresses only the bacmp() race in iso_sock_connect();
other unprotected iso_pi(sk) accesses are fixed separately in the
next patch.

KCSAN report:

BUG: KCSAN: data-race in memcmp+0x39/0xb0

race at unknown origin, with read to 0xffff8f96ea66dde3 of 1 bytes by task 549 on cpu 1:
 memcmp+0x39/0xb0
 iso_sock_connect+0x275/0xb40
 __sys_connect_file+0xbd/0xe0
 __sys_connect+0xe0/0x110
 __x64_sys_connect+0x40/0x50
 x64_sys_call+0xcad/0x1c60
 do_syscall_64+0x133/0x590
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0x00 -> 0xee

Reported by Kernel Concurrency Sanitizer on:
CPU: 1 UID: 0 PID: 549 Comm: iso_race_combin Not tainted 7.0.0-08391-g1d51b370a0f8 #40 PREEMPT(lazy)

Fixes: ccf74f2390d6 ("Bluetooth: Add BTPROTO_ISO socket type")
Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
---
 net/bluetooth/iso.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e2736b7..14963ba68597 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1169,6 +1169,7 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	struct sockaddr_iso *sa = (struct sockaddr_iso *)addr;
 	struct sock *sk = sock->sk;
 	int err;
+	bool bcast;
 
 	BT_DBG("sk %p", sk);
 
@@ -1191,9 +1192,11 @@ static int iso_sock_connect(struct socket *sock, struct sockaddr_unsized *addr,
 	bacpy(&iso_pi(sk)->dst, &sa->iso_bdaddr);
 	iso_pi(sk)->dst_type = sa->iso_bdaddr_type;
 
+	bcast = !bacmp(&iso_pi(sk)->dst, BDADDR_ANY);
+
 	release_sock(sk);
 
-	if (bacmp(&iso_pi(sk)->dst, BDADDR_ANY))
+	if (!bcast)
 		err = iso_connect_cis(sk);
 	else
 		err = iso_connect_bis(sk);
-- 
2.52.0


