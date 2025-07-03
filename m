Return-Path: <netdev+bounces-203940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95252AF834E
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 00:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14CB97A7712
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 22:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A852BF3E2;
	Thu,  3 Jul 2025 22:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="XMXjfvPj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7B82C158A
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581424; cv=none; b=GGcXyVpRWQCiPTjv/bXWZP2D7X0FrRHrLCIrMbs0nua1KhehmNLw5p4qXk08dhS6vV7GOtEsHH9GKv3mMsmbrCgI/Gx1tncuOtBmm+B+qrdS2RXtp1fKUq+wB5TtJk7tHCrinI6SHj5qm6xRWB7hFZ153wW0A/OORiJGYS3f3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581424; c=relaxed/simple;
	bh=q9/jOSjyT1JUfp0m+BaSbGkJjs337jxDbjZaMjfYv1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZKxDZTSxa1B+ZnSo4XOEiGyiBbF2lbmJxXVwF9GUxUDN2uO3NIqZlstlz1HSgp1VIQ68kKyeBbXauplV/uu+MzQ+US3viXJmZ4jjVi4FdJ+c0eUhov6+3LIx8inbY5gfcQxWnxGqrr2TPq1jhvfokWlqpR5iclvFycJVemSIUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=XMXjfvPj; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 56B203F427
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751581420;
	bh=UkV0lOybHc8xNe3mREp2vR+oZ1mEEwdktMK0oaj57as=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=XMXjfvPjObmS9WqpMs/gKoccr1Xa8wQ2OiNkDLjBcot4JgKlpmocFuyNveaSfdZIX
	 wSyiIIaxI28ELKiJ1JT2oFw49cSY5YvPm+deK/DbcC7pj97jGUQk8p762f1UMQ1+z3
	 cQ8z3svjdHivMdkP7OnbmVfRxWYW4hJ6z8vn6Ihj2lLJmEIE5S7w+FsEMDd2Z/xIJ7
	 6xyrQm69q2SAHMMTme9hWDl3WPnh473GZIzbf7un+JLyDgee5l94sltYnL59rYOJcR
	 +C1MzMqVYiVTcmKQ4HEXKJY0c544zJiwhfpkfPmAvu2cpWliqvMnn6ycCqk278a3em
	 Nt6IFgVgWWfAQ==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-60c3a8f370aso218791a12.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 15:23:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751581420; x=1752186220;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UkV0lOybHc8xNe3mREp2vR+oZ1mEEwdktMK0oaj57as=;
        b=L2h1YMpP8x0DyipAdArRCefi9DLDI/iEtSvvMrBIu2bLesv8Q4hewXE9TAWEUsC/2S
         VYiuGsyMmJV+9xAi3yehyJ9bW/qAasuOSxLCQBSQNsQ0ivT7VnRHo8jr5N3y8Wh/ugy7
         /VKLXS1TXT8rJ7PDClxg71yUfEeq13Qn0NWmph4BmrI81RxSWnDAlHXR+jTPlPK5ssJD
         yyFtinGiersScEjNE2DObBUh4YVrfFkgVvYTm+m84kCWYhF9sOw1vgGRgxr0TWvo/RzR
         CwAAneXUIsmStdyVRubli/QqocrPSte3WYIA1cpT6UhqxjeafTfgcxcOdL+0tiiGqlrr
         FzPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdz74yvGx2IqDjLI4sTZEHFK5V9z7tFmMLwhgm7nnvNAaDWQfDsuANy68QH6n5/oUwY99Pnyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSuv/QdJZb9RQfY3ltaCBafS8/PHpGwkhw45qWbQ6GKlSDXpvf
	DJFLDKIrBThfLcN/Hw8W2Gknnjqf5SvNhPqmo1mcHw2VhvLwSOUDDdKaDicgQYg/hjXgdY0e1pD
	3URjJifm+XsG+NoRQJ3O+16UmX7vZ1ICnDluMFpqOheRfx4F8OxD0daBnICtJJzhChvtGfB9SsA
	==
X-Gm-Gg: ASbGnctX+jUlgMIrNLRU9pB10z7D15A+0tnQ7bY3f/f5kHWtDS2a+4ushOpR6X2P64k
	fGJ23HOBjZQqwRptv7t6yXAYcXDAaw7hPzQquI2wtMUVX05QTIBX+nGaJbCLVeTDmOR9CiSlb90
	SsSVxOIIgW+EKNDc94xq/LCZnh+v60I4ar9WYeqKLTqHRWtoaFJ/Ipt+DYA+IlcnB+RFfuVgCiZ
	7moq2M0+TVy197Trrsn2bLAy4P2944QN7ZXuQL1rVuSTUfB1X5LS/Dy80ZSXElQqqKxDiZ7zO8r
	VhPbCfe7GyAjR+4yMiEqv9EUm2lJyY5vElAWvK460OJprSWICA==
X-Received: by 2002:a05:6402:270a:b0:60c:3a86:e117 with SMTP id 4fb4d7f45d1cf-60fd34c4066mr240801a12.34.1751581419863;
        Thu, 03 Jul 2025 15:23:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsVWIT2hLZf7Rsbl4BgW3Ot5vlMbIfx1ED7FUqAWluoYqZrsysedET7VaeNcuYTKnjvoKrHg==
X-Received: by 2002:a05:6402:270a:b0:60c:3a86:e117 with SMTP id 4fb4d7f45d1cf-60fd34c4066mr240774a12.34.1751581419477;
        Thu, 03 Jul 2025 15:23:39 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1fb083sm355164a12.62.2025.07.03.15.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:23:39 -0700 (PDT)
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
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH net-next v3 3/7] af_unix: introduce and use scm_replace_pid() helper
Date: Fri,  4 Jul 2025 00:23:07 +0200
Message-ID: <20250703222314.309967-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250703222314.309967-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Existing logic in __scm_send() related to filling an struct scm_cookie
with a proper struct pid reference is already pretty tricky. Let's
simplify it a bit by introducing a new helper. This helper will be
extended in one of the next patches.

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
v2:
	- don't do get_pid() in __scm_replace_pid() [ as Kuniyuki suggested ]
	- move __scm_replace_pid() from scm.h to scm.c [ as Kuniyuki suggested ]
v3:
	- rename __scm_replace_pid() to scm_replace_pid() [ as Kuniyuki suggested ]
---
 net/core/scm.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/net/core/scm.c b/net/core/scm.c
index 0225bd94170f..045ab5bdac7d 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -145,6 +145,16 @@ void __scm_destroy(struct scm_cookie *scm)
 }
 EXPORT_SYMBOL(__scm_destroy);
 
+static inline int scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
+{
+	/* drop all previous references */
+	scm_destroy_cred(scm);
+
+	scm->pid = pid;
+	scm->creds.pid = pid_vnr(pid);
+	return 0;
+}
+
 int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 {
 	const struct proto_ops *ops = READ_ONCE(sock->ops);
@@ -189,15 +199,21 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
 			if (err)
 				goto error;
 
-			p->creds.pid = creds.pid;
 			if (!p->pid || pid_vnr(p->pid) != creds.pid) {
 				struct pid *pid;
 				err = -ESRCH;
 				pid = find_get_pid(creds.pid);
 				if (!pid)
 					goto error;
-				put_pid(p->pid);
-				p->pid = pid;
+
+				/* pass a struct pid reference from
+				 * find_get_pid() to scm_replace_pid().
+				 */
+				err = scm_replace_pid(p, pid);
+				if (err) {
+					put_pid(pid);
+					goto error;
+				}
 			}
 
 			err = -EINVAL;
-- 
2.43.0


