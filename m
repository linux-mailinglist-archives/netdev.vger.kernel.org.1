Return-Path: <netdev+bounces-145627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CD29D028F
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 10:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8931F22C11
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CA17DA95;
	Sun, 17 Nov 2024 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ir1ZVYdM"
X-Original-To: netdev@vger.kernel.org
Received: from forward103a.mail.yandex.net (forward103a.mail.yandex.net [178.154.239.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5ABCA92D;
	Sun, 17 Nov 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731834807; cv=none; b=dAfQnvIfAsiMl+JHXpYvayaCzSUqYosgLDdlMkogd4IQsuKVlT+jEpoQVbSF5/70/+mfZEUZEe6Zd+KonvXwb37k5WF4hQGLYEEHE0SeETFymaRUsItPCI/tH9Sx689jE2bhVQxioK57C+9y70/a2IVuSjEDk0ixLypYVnSsk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731834807; c=relaxed/simple;
	bh=2c1W1d4e5/4696+4NHa6kBSNKiMEN/sjVfNe6VWNybc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dgp0No0COBP/kpLDjHKj9GFzuG10fHyhe1iJST7oGzblm/kwdLJkEKv1uRb+CmkdTjO5bhEPhYWrVqeQ26hEv73bzQLJo8EEUpIaxD9DuzT6ow1TuuQrzaFC1XnbO69Rb6nRn2hhpR+TNX+QVkyxhtrRzRd9Og03jHrCixbyemg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ir1ZVYdM; arc=none smtp.client-ip=178.154.239.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26bf:0:640:efa0:0])
	by forward103a.mail.yandex.net (Yandex) with ESMTPS id 9D5B960E3F;
	Sun, 17 Nov 2024 12:13:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id JDLZaLUOlqM0-gdcQxc5x;
	Sun, 17 Nov 2024 12:13:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731834800; bh=66bFHsBEIwpNWx6CltlQsai/ASLsgDTEF/m4U3tBE3o=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ir1ZVYdMcqUyZoodwururKXreLe5pNVc/8elfmY0Lq6hcRlqfw8AeD0I+IiRqoqPe
	 2iyT9HCvXGonDiP3Gvcqgi04vCWIs21jTsDjtJ4qQmFL94lXSny7YssG9Vs/GHLLCZ
	 1itW1B0bypssjIb1Li+5fDrVqlWI3r+Br9Vuen9M=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Stas Sergeev <stsp2@yandex.ru>
To: linux-kernel@vger.kernel.org
Cc: Stas Sergeev <stsp2@yandex.ru>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	netdev@vger.kernel.org
Subject: [PATCH net v2] scm: fix negative fds with SO_PASSPIDFD
Date: Sun, 17 Nov 2024 12:13:13 +0300
Message-ID: <20241117091313.10251-1-stsp2@yandex.ru>
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

Changes in v2: add Fixes tag

Signed-off-by: Stas Sergeev <stsp2@yandex.ru>

Fixes: 5e2ff6704a2 ("scm: add SO_PASSPIDFD and SCM_PIDFD")

CC: Alexander Mikhalitsyn <alexander@mihalicyn.com>
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


