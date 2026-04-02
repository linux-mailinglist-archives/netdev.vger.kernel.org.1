Return-Path: <netdev+bounces-274365-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA83KMf0zWlLjgYAu9opvQ
	(envelope-from <netdev+bounces-274365-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 06:47:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D93C383BD7
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 06:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A226030241AD
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 04:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE3B299943;
	Thu,  2 Apr 2026 04:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oi9Uw6vT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182D34DCD7
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775105221; cv=none; b=QcZlfh5H6QWxt68hyPNo/KhyyM/FxZ4wd4i0Hh9RN45W4ZggryM9bzRy9Vz+xLO2sMVESCUceUh98GuUqr17FEYIxWFgSKGSj7pqIC5UNQ8iRH1YsXOhTSAmJZLoo7+bCL2x+XxuT5EFqfNa97vjao2ySW9c+DD9F/Zj1D2COdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775105221; c=relaxed/simple;
	bh=jV5CWtutJqLa16q3x6lGkU+AgLFtOqIMJk0X4qmwhUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1gOpuFkHPMMH5tOFsvMfOktcfYWlAXTvAZvNNQKLCk9Sp15L7WA7XpHIeNVFtnRXxM2yY6xlp4rvAH/GyUnxKWGugSySF103xK7floZ4C7wyoH6OoVuu2NleqZdF3tPOfNt+DPpvQQMBakTd8Ec8L/AdDlP1YhE7aWL5Nkdtzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oi9Uw6vT; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2c87871133dso658237eec.0
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 21:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775105218; x=1775710018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNPRt9AdqdMzFCaTU2ZjYAQXhCSBuqIya6uWjrlqzLU=;
        b=Oi9Uw6vT6nwb1v3cEktRNaeh6XRB92tS+IqfprMCPwfX6mmha847COPNCpps3iLD34
         YvnCa5HQlINOSvAM206vJi4D23qSNwbLAGBDIRqRGZYPHsUeqij+ogAeGWNMTGDKaJgM
         KOUlsKhrW1YKBsNJCZohYlSNlXEsBNyETWdGWkd8d0TuS6ypF8l8/FUppXZou0wubHMu
         k4PwCnLviJtrYvQBBuLe7XSJ9+4tJN7H29s/QplrgQGfKWotkanHN0C4Uh1JcNLaMPgA
         mwrgeMJI2GGS9lu8/pc4Jcz5Or79bOrGGBlZoUh7i+loKvdxoTJ81V2D/hdrpGZI7g3y
         FfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775105218; x=1775710018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNPRt9AdqdMzFCaTU2ZjYAQXhCSBuqIya6uWjrlqzLU=;
        b=RAgWbnNMfmfeQrERE6EGLSyZc6yO2614UZL8LykEPDlYKd/5CpKIfPH4Tc+yT2OZo0
         G/16v+phsznaFcDs2J2ivO2A+l1eXSO02NU82JkHZwY9XtKCJWNDhRQbhgBg02PG97ef
         2qWGh+EA7PfsmSmIrmDM2/UnXqLNXhw4xsonWMykAFLREoH18eNBGGmyA2+mskhKKnIP
         PIFK9a0LEMkqzdBBASCztCY1nK9PgBGkcoUzkAGjpjuE8/f5sk7jMHAyORNgsqO2BIW4
         gx/cLyEADKATmpg1nJq/Gkd5Ex98gudjulD/f6+6n54cB9lXv9OZ9+RD3tRY9Q86xzYE
         2G/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWB38g1oz+sVn4PxE+c2zxX7iVICMl29gzTwhsDpNFasCy/3Z4LthpWSARrrvjp3zhH47wpsaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6rOt6c1UY/iS9fPytQ9qyc2uJmj1Bx0ZcM7FhvgUXwOtk02e
	VTKyKwsu3bnVT80Qre19NcPadni7cUozpEJrcrdImTgI6NzZPr0dGBtK
X-Gm-Gg: ATEYQzwnqjK1FAcPWrHDH5zVDYJUfxsaAPUWnkDGe3UlbDru89dLp0QCnMwxzTre+ZL
	j61bB0ULZtn9YnL1Z4htWqMbBivcE/udQ257mWzPO2QSROGFdW7ni2FFiNItq2H2xz6TSTsN2Bs
	9+PbyJFgHnY9lhjfLTNpLSelwBbnwvJyauLpjUvRPpHOGMqeiR1iWnWb5yNFKhWg1WuHk2RQ4Z4
	5+Hz/H/EhWtgsstlR2E8T9gVyeCcSEZSNNgJyr/4MSDoYNWDG3Qr1yHV1jcLl/8jmn+mZ6d3z0L
	ZFyODPFeBBW/kZJbhQiHeJG2vExsBiCHi+MA60zHftbeKLh4Bgr5ZXs9VLEcYH1FqjUWnAgme/r
	Y1UBOHZOZhGK2658bO0qyOsVZEWi0FlmAg4BcF/8gnhcoQeR/XZzuJ/T3RckO8XQVgHQ8vBkrXF
	a97EcfbLIVq6KVbd1whCNwLfgJkH9oD3EtwI70SjY5GSlkatb9Zk1IIAZbz+QR
X-Received: by 2002:a05:7300:724b:b0:2c5:30ed:5e99 with SMTP id 5a478bee46e88-2ca8dbde026mr1140306eec.14.1775105217820;
        Wed, 01 Apr 2026 21:46:57 -0700 (PDT)
Received: from elmini.. (c-98-42-127-152.hsd1.ca.comcast.net. [98.42.127.152])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm1554832eec.0.2026.04.01.21.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 21:46:57 -0700 (PDT)
From: Laurence Rowe <laurencerowe@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Laurence Rowe <laurencerowe@gmail.com>
Subject: [PATCH] vsock: avoid timeout for non-blocking accept() with empty backlog
Date: Wed,  1 Apr 2026 21:46:37 -0700
Message-ID: <20260402044637.73531-1-laurencerowe@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274365-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurencerowe@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D93C383BD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A common pattern in epoll network servers is to eagerly accept all
pending connections from the non-blocking listening socket after
epoll_wait indicates the socket is ready by calling accept in a loop
until EAGAIN is returned indicating that the backlog is empty.

Scheduling a timeout for a non-blocking accept with an empty backlog
meant AF_VSOCK sockets used by epoll network servers incurred hundreds
of microseconds of additional latency per accept loop compared to
AF_INET or AF_UNIX sockets.

Signed-off-by: Laurence Rowe <laurencerowe@gmail.com>
---

This fixes the observed issue for me:

1. With loopback vsock on the host running Linux v6.19.10 built with
config-6.17.0-19-generic from Ubuntu 24.04 and make olddefconfig.

2. With Firecracker guests with current torvalds/master, v6.19.10, and
amazonlinux/microvm-kernel-6.1.166-24.303.amzn2023 used in Firecracker
CI and examples. (Firecracker guest vsocks are unix sockets on the host
side so this fix works there with just a fixed guest kernel.)

I struggled to build a generic 6.1.166 kernel that worked as a
Firecracker guest but the patch applies (conflict due to change of
`flags` to `arg->flags` in surrounding context) so I believe it should
work for generic v6.1.166 kernel.

Alternatively a minimal version of this fix is to just wrap the
`schedule_timeout` in an `if (timeout != 0)` but that leaves an
unnecessary additional `lock_sock` call.

There are ftrace's and reproduction tools at:
https://github.com/lrowe/linux-vsock-accept-timeout-investigation
---
 net/vmw_vsock/af_vsock.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2f7d94d682..483889b6d8 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1850,11 +1850,11 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 	 * created upon connection establishment.
 	 */
 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
-	prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 
 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
-	       listener->sk_err == 0) {
+	       listener->sk_err == 0 && timeout != 0) {
 		release_sock(listener);
+		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 		timeout = schedule_timeout(timeout);
 		finish_wait(sk_sleep(listener), &wait);
 		lock_sock(listener);
@@ -1862,17 +1862,15 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		if (signal_pending(current)) {
 			err = sock_intr_errno(timeout);
 			goto out;
-		} else if (timeout == 0) {
-			err = -EAGAIN;
-			goto out;
 		}
-
-		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 	}
-	finish_wait(sk_sleep(listener), &wait);
 
-	if (listener->sk_err)
+	if (listener->sk_err) {
 		err = -listener->sk_err;
+	} else if (timeout == 0 && connected == NULL) {
+		err = -EAGAIN;
+		goto out;
+	}
 
 	if (connected) {
 		sk_acceptq_removed(listener);
-- 
2.43.0


