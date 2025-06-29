Return-Path: <netdev+bounces-202302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082DEAED164
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 873673A9C28
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6151EA7FF;
	Sun, 29 Jun 2025 21:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GPjj6FW9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87346245029
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233525; cv=none; b=NGNM1yJAhCocA5ZBrhDS0qS12PN1q9EXmUK/RZKJuQlF6KulY3wk3ykyCjG9ll53+mfoB4YYjF6bKzPPhPolx0o9MPl8jpin/Y7ZOQNotekbrDcB8pxUSIPFvg9LmE+l/vbk+YieKii2sJ4oQbkFWZUnHoatskwtffBjaiievXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233525; c=relaxed/simple;
	bh=UsMulxUXfXc+mVSRj66gJP12dihbtpyStx6D4VTt0YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sMmLOC35PV+aQVo06myHlESAaQTe8AjHYfZ4OXrAniCOamHK4n5qMPOQsphakS2cuJho9yo98Qrzyrl/W2e8/Fl+W1NxM4U4OtAU+VLMNdcHGRwGqyVFOUNUEayqmzbkolh9668ITWgdzEr5VyfQWY2x+81EA2i8LczUE2xWh7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GPjj6FW9; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 5B9563F2C4
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233517;
	bh=gE/SBo0jtAJ3S3J1SQz/ldeuJLsn+kPIOiU+zq4e5hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=GPjj6FW9tHrXeK3HwbJxOx5NDlNJA5dG9rKKfBMOZBD7YV8hLnBYz4mZlO2CYnlwZ
	 HMNyf15MJFalEcPZrIRPfK1IxniSxnbL2le5VjAS+59we+1Vz9kGznwO9WEDmjvmdu
	 yfMhaSO2vnvkAJjoEGL9hj7aUk6aJx74fj+1Qc+I8CXMEemPI7R5MgoRhzQ2HOHABN
	 f2Pw0FzXIlngMSig3RJIZkdJ4Ik2IHhNtNeEH5WkqAcnApXKOZWQkHT0pXMqE4l8gD
	 pBaFOHma54x8Fi7dlaDSXdboBH0bHFH8wh74YS8d1aVsK/Y6g8vwPGLePfFriBOi5R
	 ZN0Ggm0i3as7Q==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-606f507ede7so3711379a12.0
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233513; x=1751838313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gE/SBo0jtAJ3S3J1SQz/ldeuJLsn+kPIOiU+zq4e5hI=;
        b=jabaB8FTDRl65fovtcgf2WVtHCsh4D5ONn8/xqgC8Zn09pBtuMCo7Zzh7B+30UZKax
         t4vUSHd7DhRh505vi9oyZUMS8E3yPON7/E1CqiOaqzsRRROGKUkJOE0SysbaxOev9NJW
         PiCpC4iNDndvMvhH1HTH1NdrbBZtzwL6lNtmhmgeuIkh5oB1vN5/qkMAuSBanA1KanRw
         ePdNSvnkhjDkM3SeBjzMRy1ggR3tMYry174SJJoskijPUQL30LdGPpx4BTdWaARXOxQJ
         iv+YQC9Qq+MQsrr6etZv7tpJ3lnPF8xPwstAJhxtcxjF2ueXHtG3BavlKPwhLOjLzYni
         gkLA==
X-Forwarded-Encrypted: i=1; AJvYcCXQW08EzFnZJE9C+jxI++rRe8RgwU7VsML+Nx5cqzhzz/btMM2VF4ZjYGkcczpkK8PjYoMKFyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGgTkpCDBQdpe8zntFNQvz5NvR+FW5P5FMsqQrqzhzHNF9Nwa5
	jVF9cpwQ3bwofW+Pe2ZNjtam4cv+BdtOOoUN725gYdM/NHMt62JVrPxZwWpUkrDRvghCnWxcjOX
	H7hsc9eKPUDxLqR2pIKn+ZffQ4ptZxGpy9RYdaTxkNuJB1ihcRW5SpquO7H/EfZxTB7nDzGxmcg
	==
X-Gm-Gg: ASbGncsIfsEecLzwQqEDOG6gf+3OE81m7+lewn4Gnji+AQX/kLGiy/8tvn4Z3RKIE8f
	/PkjJEFZ/HwMMjB2yB3eNrZbxWzbiON4l44TLBnslMVvy3fGuu/SysCn9lH4rBLBzNaEgUNIBKZ
	XRroCO+3+vaXhqH56dLB0cR6HOD7Oih2gDH7EtF0f0+N5fHWm43X8ptR/QI8jNyRbAKwjPmrNYp
	b9iEanovoJ07x5sWIiB+B+9N8d317mjaj71mjpHQxJZoyGBHkp0pCD37xw7aPi9pJoJBLaaG4ty
	NJfVlr1WCuZ6NoEqDzgUwlpUjVUS7oKQjukGffZnqJEGwoWTvA==
X-Received: by 2002:a05:6402:90a:b0:5fd:c426:9d17 with SMTP id 4fb4d7f45d1cf-60c88e750a8mr9082144a12.34.1751233512830;
        Sun, 29 Jun 2025 14:45:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmhOkFUd0s3cRSSvV50wOIhAEwTNb1KausZupuU/kQ9vYIV4alre59EPicBcrvLzCaJw2cyw==
X-Received: by 2002:a05:6402:90a:b0:5fd:c426:9d17 with SMTP id 4fb4d7f45d1cf-60c88e750a8mr9082128a12.34.1751233512402;
        Sun, 29 Jun 2025 14:45:12 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828e1a96sm4712037a12.19.2025.06.29.14.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:45:11 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@google.com
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [RESEND PATCH net-next 5/6] af_unix: enable handing out pidfds for reaped tasks in SCM_PIDFD
Date: Sun, 29 Jun 2025 23:44:42 +0200
Message-ID: <20250629214449.14462-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250629214449.14462-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now everything is ready to pass PIDFD_STALE to pidfd_prepare().
This will allow opening pidfd for reaped tasks.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 include/net/scm.h | 1 +
 net/core/scm.c    | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index d1ae0704f230..1960c2b4f0b1 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -8,6 +8,7 @@
 #include <linux/file.h>
 #include <linux/security.h>
 #include <linux/pid.h>
+#include <uapi/linux/pidfd.h>
 #include <linux/pidfs.h>
 #include <linux/nsproxy.h>
 #include <linux/sched/signal.h>
diff --git a/net/core/scm.c b/net/core/scm.c
index 0e71d5a249a1..022d5035d146 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -464,7 +464,7 @@ static void scm_pidfd_recv(struct msghdr *msg, struct scm_cookie *scm)
 	if (!scm->pid)
 		return;
 
-	pidfd = pidfd_prepare(scm->pid, 0, &pidfd_file);
+	pidfd = pidfd_prepare(scm->pid, PIDFD_STALE, &pidfd_file);
 
 	if (put_cmsg(msg, SOL_SOCKET, SCM_PIDFD, sizeof(int), &pidfd)) {
 		if (pidfd_file) {
-- 
2.43.0


