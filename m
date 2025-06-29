Return-Path: <netdev+bounces-202300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FE4AED15E
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F123189660A
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E45123FC68;
	Sun, 29 Jun 2025 21:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="n5A1C9jZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5933233D64
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233517; cv=none; b=XawVLitYEz1pugLawHbbbx7OYW58CC/yxQqZqBueJJE80Eop8oOWPAxlg5kBbDO1crPtUFN6O84vTq28IQo4vuJCZ6NnXT2TJurtvR1Gc9QKSOq/50ibEr7286XY+5LkFu4Po7y+sc2f3Q5okVJXgQ+VJVeroykC2xwU8VK/DV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233517; c=relaxed/simple;
	bh=VRa2MsmaJdr/14P5DkDEck3hvc0gsQ2yKcWjIECRYOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xgc3PZ+X9PHVIuAE32AamkO5QlnImU9LK+iJoWjc+cLpYDANZJMy62rQBF/qmkLvROZacVKYwfXfcbWcVMIvCz8yBSchkhEHKDb2kgXYoaLDGRIdqkv3ex7xv+0/yHAglzLxSd6HRSKSjdePONj0zM44nRU+QWtIoW2eIrYGy2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=n5A1C9jZ; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 598353F943
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233508;
	bh=JxsSezFVcVddszGhnOOW8/cd5yQH/kkJ8Bo6svEZqIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=n5A1C9jZQ5UoEJvJ5P627/qUdcJgj9kzBOQ5EkhxlvsWXq2PyrczYQlOpy3SfUvLL
	 tZR8os71wQIAmmFbusmRd2PReB9zgGKDHSBWSBumPoaKevlSpxhJFdvnw1RGRaZdtt
	 Fvs0JCKHh/pHjr3GgcxBqwFCQimKZXtizrqup+A9Bl4aLq/dpsYFLZ2Nptcc4FDvys
	 viKhhWkDQRyT7fUZn/Z9xUkFm4DGppwQCSqDhEuZb3SYKUpoQuvZcqzUG/3oiGo3MY
	 NrBnewBSqISeDfJb2cKo1FXicGepx95qAIq51D48fyaJj66ivGDqfXwVTDc7UssIm6
	 d4DPtrC05lSxA==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-60c9d8a169cso1338068a12.0
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:45:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233506; x=1751838306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxsSezFVcVddszGhnOOW8/cd5yQH/kkJ8Bo6svEZqIk=;
        b=NBras/L3Djo0/h3MWjDAWBJqr8lMZe45ZFUMk1tBx2WA5Cm92IzCnJhy0JsVjpVy0/
         9hed9eZHonoWTgxs5JEgXL6TCTr3YOUPXjoqmRVHorL1UG3OrdMKwo50WowofzOGdKXF
         FFvCfT9HXv0wkk4u10Qg/a4R+vYwMFmAHvnFpSBlbn0MYaJ2/hN0O2no5V+yzP7UaDDU
         Mc9lsC7D2iCd78IS5a9YsU85nIufsf601YCvBJUc+DNQJYjRiFm7OOkfmJ/EVb5F8dG6
         Zki0gyOShCVc/9W/0TUZEKvWYFRQ0dEH60nmG5zLV/xgH46rWI3AteuZLh6b2AEEHeeD
         eN4A==
X-Forwarded-Encrypted: i=1; AJvYcCVD7ZC542rYkHBbOoCpsdyUxACeqPCiVFezi5QC9F13ao4ehSubD4OThoolh4NJ45+hbPDN8fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNKhA6dsNnEFRtkBcmIDKjWLkRGoPjzM/k/v08d/nceoBiC2Pv
	jhOw9sklCtGsayzHy1ZmQd/awZF3xXSa87Q4ZfZvOr3XREcz4+zboudE+VeSjMa2YxmJhFlmxZV
	lKJ6XS2tLupGlwbHQLsXNQflZcxotFEPfwR2cCFm5cdAKjdxPvmTTZxGay160D9wG8k/vvaVkvw
	==
X-Gm-Gg: ASbGncsvM4UjongAGle4j/qELH09NuVIIJ66xDhtcBaAEWj+MuOB+tEOxVmOEUrY29/
	JmRUV0bFRbjF0sWWNKw+eEDRg4qg6b6v/RpNynmbJ/SPGBsN8ctCK9uiYKYto3IiMy+TiZnSPru
	JkR/IDDUzOg1su126NiN9VRaOVEnGB0aCQfJ/j04eCADmCHuIK3MmfwSto01W8/CO9aVUc97YbA
	lSMBKEQ623wjiBvu/u0hul9GFJJ0286JpJGTv03O8PA9fTegnN1nen7M5S3wrWjhqKNrIEGuXBA
	P5uj9ZIuTHv4Z05TQSmgG0L4Tjx9lIOlNn7S5jWWJBQD1/45gA==
X-Received: by 2002:a50:d6c4:0:b0:60e:f46:326d with SMTP id 4fb4d7f45d1cf-60e0f46379fmr524106a12.33.1751233506001;
        Sun, 29 Jun 2025 14:45:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeG0HXUZS+VZqUBDBm8csLUlE85Zu71t9cWNi9cmpg397iu6ZGZalKE0CjWDY0LX20CtiqaA==
X-Received: by 2002:a50:d6c4:0:b0:60e:f46:326d with SMTP id 4fb4d7f45d1cf-60e0f46379fmr524095a12.33.1751233505618;
        Sun, 29 Jun 2025 14:45:05 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828e1a96sm4712037a12.19.2025.06.29.14.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:45:05 -0700 (PDT)
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
Subject: [RESEND PATCH net-next 3/6] af_unix: introduce and use __scm_replace_pid() helper
Date: Sun, 29 Jun 2025 23:44:40 +0200
Message-ID: <20250629214449.14462-4-aleksandr.mikhalitsyn@canonical.com>
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
 include/net/scm.h | 10 ++++++++++
 net/core/scm.c    | 11 ++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 84c4707e78a5..856eb3a380f6 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -88,6 +88,16 @@ static __inline__ void scm_destroy(struct scm_cookie *scm)
 		__scm_destroy(scm);
 }
 
+static __inline__ int __scm_replace_pid(struct scm_cookie *scm, struct pid *pid)
+{
+	/* drop all previous references */
+	scm_destroy_cred(scm);
+
+	scm->pid = get_pid(pid);
+	scm->creds.pid = pid_vnr(pid);
+	return 0;
+}
+
 static __inline__ int scm_send(struct socket *sock, struct msghdr *msg,
 			       struct scm_cookie *scm, bool forcecreds)
 {
diff --git a/net/core/scm.c b/net/core/scm.c
index 0225bd94170f..0e71d5a249a1 100644
--- a/net/core/scm.c
+++ b/net/core/scm.c
@@ -189,15 +189,20 @@ int __scm_send(struct socket *sock, struct msghdr *msg, struct scm_cookie *p)
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
+				err = __scm_replace_pid(p, pid);
+				/* Release what we get from find_get_pid() as
+				 * __scm_replace_pid() takes all necessary refcounts.
+				 */
+				put_pid(pid);
+				if (err)
+					goto error;
 			}
 
 			err = -EINVAL;
-- 
2.43.0


