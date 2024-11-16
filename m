Return-Path: <netdev+bounces-145606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8E49D00C6
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 21:23:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77F701F22C0E
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 20:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77EA219004A;
	Sat, 16 Nov 2024 20:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="lmoYsacE"
X-Original-To: netdev@vger.kernel.org
Received: from forward101a.mail.yandex.net (forward101a.mail.yandex.net [178.154.239.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405D228FF;
	Sat, 16 Nov 2024 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731788618; cv=none; b=t+27V6cO2BL+Ztx/4uqHD8y41rFBQSnNi2cako2wL8aAn+4zZezja6TxBYbw9uPGVeczt2T0urSyPAtvRWPh2YcgdWpJCx+Q3jUqbQVWkv6jZUiBMxB1YUIcQiuZ6/8c3T0/PIIjP6hDU10B9ydnsDMtoAfzHPj6HFpSWZMAsMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731788618; c=relaxed/simple;
	bh=Xwt1wgD3GpJFJvVO6W3Kf69DFMrYWLJzBt+Q+zwdm+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GcloqygU2PFy9vQHKKPlVtEIx40TQr974h5neSMAniztWwMjDrrxdy6/T5FBhqTydF9HNJDKjGkt3L3766Igur+l8Rzym8mXLwObfIA7wi4OteZ/gW0Uw7Zi3yGyQ3WSqt1atlrPIiWeyH5TF7lAUtZKgTWAds2zHtecV5rJqPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=lmoYsacE; arc=none smtp.client-ip=178.154.239.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net [IPv6:2a02:6b8:c1d:3e83:0:640:307a:0])
	by forward101a.mail.yandex.net (Yandex) with ESMTPS id E5A9860039;
	Sat, 16 Nov 2024 23:23:24 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id LNVPeYOOouQ0-0ivAiGht;
	Sat, 16 Nov 2024 23:23:23 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731788603; bh=O31CYpoIo+My2OpOnR9CiaJUHu/xs78IoYQDtcJ0LqQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=lmoYsacE+Sy+VMXQJRteDwFsxIILrj5k8mhabMMexsWuSGk5t3RvuTQaG+FGVmCf5
	 t6iDNm4u2wRuUHbTCJ/7i2o0Tbe+evaMcaIztP7pnLFFjzH37D93PRfW+nn11MacSG
	 FTZSdAUWuIqj35xxvfQwNcfkI6oRSABIH/ljeY7A=
Authentication-Results: mail-nwsmtp-smtp-production-main-68.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	netdev@vger.kernel.org
Subject: [PATCH net] scm: fix negative fds with SO_PASSPIDFD
Date: Sat, 16 Nov 2024 23:23:05 +0300
Message-ID: <20241116202306.937322-1-stsp2@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pidfd_prepare() can return negative values as an error codes.
But scm_pidfd_recv() didn't check for that condition.
As the result, it is possible to create the race that leads to
the negative fds. The race happens if the peer process sends
something to SO_PASSPIDFD-enabled recipient, and quickly exits.
pidfd_prepare() has this code:

    if (!pid || !pid_has_task(pid, thread ? PIDTYPE_PID : PIDTYPE_TGID))
            return -EINVAL;

So if you exit quickly enough, you can hit that EINVAL.
Getting the fd=-22 is very weird, if not exploitable.

This patch adds the missing check and sets MSG_CTRUNC on error.
Recipient can now detect an error by checking this flag.

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>
CC: Christian Brauner <brauner@kernel.org>
CC: Kees Cook <kees@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 include/net/scm.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/net/scm.h b/include/net/scm.h
index 0d35c7c77a74..3ccf8546c506 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -155,6 +155,10 @@ static __inline__ void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm
 		return;
 
 	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
+	if (pidfd < 0) {
+		msg->msg_flags |= MSG_CTRUNC;
+		return;
+	}
 
 	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
 		if (pidfd_file) {
-- 
2.47.0


