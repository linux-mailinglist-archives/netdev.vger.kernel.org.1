Return-Path: <netdev+bounces-202292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19066AED14B
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F090189613A
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136F52417D4;
	Sun, 29 Jun 2025 21:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="h8Mnffcx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC6524166B
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233239; cv=none; b=G3D8MwJqDuMKXT/qPtirTlj7NrN7xT4Dvgpp1eYRnkQmSk2oCnxTf8aHS4MpBVfB49UF7vDycLNnk0P8XtZHwLDYzi4ybopxX/c5XBFd8ipLBvdy6C3fElksmi0YExrtshkbk2Rx2zRsUxkqTopNhR9PWaVq3XrR9WqxhcwMa9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233239; c=relaxed/simple;
	bh=IyxrDFbacMBAx6Onjmukxc0YN1nXFQ5UE0pW+oMO/pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psCDLpiCE83G2FvDCkqVaBnKCx7C66c9Ll0Ju9z376tecBO75HpvfBmaBqE0oJDY1MhwmsPV7Yp2OIxuA/YVicjXXLCnm6zD9omW82glCOQmKtHSnUTv5I+dAA7uWSlOeu3CFM1MEe+/ZjH10TSrt0K2AszUWCAhXjkZ3qxTffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=h8Mnffcx; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 45CE13F942
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233233;
	bh=48BdSf3QfnCKs3/i9D2aI5kg4hr1YnePWMmrRnRqmkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=h8MnffcxT1CAqhUAmin3AhvvUsNr1Az9pzSph6uvPuL3a9NQ8L0eGm4/MZ4zWry6/
	 Y+fnTLF5BbA32KkIWKWhuCrXTNhdUjxpBIrMU7j0pkQL7K1nyOqe2dpQ5kgB+Sl35s
	 +InLro+hYKOuSYkNAJ4oPFH5ivkyDUCYlB/UnWFwQPK2ris0VqzctDW3q8Rh8Yt2RU
	 l5drDyauTj7c3J1ja+ixOh4PZctiAbTK4TuwOhO/hfi0S3fRQMCTOUP45Bgw0xtqKS
	 /sZh7oULZ09IXfJs9Pb5Mjl9qanyigWzFPSVSsJxdRiHsouN7PKe1fUIEIaowBMg7Q
	 9uQxzpDzvCnLw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-adb33457610so147445966b.3
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:40:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233232; x=1751838032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=48BdSf3QfnCKs3/i9D2aI5kg4hr1YnePWMmrRnRqmkI=;
        b=Grq3pgUsyMsTKA4nHJetT1GpEwSrcQDKE5gKgX24CcVVKwfQl/PtaWV7evpIOCTOxZ
         21jq42fu1axa7rNgqpwFM94Ib7mUux/KGG/n4Ged3VZzMQ2EsoHrLCp8IvS83BuAzQB1
         nsYzeAvaKoE/N2rU+BnvNgAxhXq6mP01Lc6xIMZg/JZ0eTYP5se2MV5UNzM74cApT0Ry
         ypCgsRl83CiLcHJKuJEpCEMtM0fbi5vcxVxquZZUa8KHzGcTV7ahjRzIlrye4Dcci6o8
         4cUwcHUoIIQvW9gs0iosJJdxku5tAxjvuyZujHMbRSBXn1WcsA2luy34yWIjJxcUBgoQ
         PXjA==
X-Forwarded-Encrypted: i=1; AJvYcCU5J8yTglNuM78taVhH0dHFiuu1xf+OuYXODuMg1GBS1+HMq4MUAZMYU28bn9sI5s7V/Jq7Mzw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi8fyRDw2koN5juYyUm8jXOHfmyGb0o8xLFLKrYXC+mhTCtSXV
	sEgtYgclDqug5qtZpI+BR3OO/HenO8DRNZOjPpwG14nb+lDwZ7bBZvD8wDsXhLLEPbeETkjM9NX
	IWfo0IyOof8QDFrVlbczq222k22DBxQ41bBYvASObm3hDv15FwkH89qTs3Lb2b7c+2gGApTEtdA
	==
X-Gm-Gg: ASbGnctCnGnqIQ44BUCO0j9CCqB+LOHow6UqS+e6cx0RYLA/Ss1H8t5JMcSWmLGUx0G
	bOAY8g0Hj0+2nGvnfGt3BHthhdiOohpD8a2YmxUg34x274lRpLCckk1VhgaxdzBOHm1tIWfpbVC
	lHyUwxfY42DUWf/+KFGqB3kcI5OumEsGBl++oEwbnIxDbtYU4Wu7PcYGcrtm7YJ0sflEOdtvBkD
	tD/huPIwcJsGvzX6NorRGfc+ZfFLdSPjWZZ2THuQYdAE0sbLH31s1qUQX2GMtAk63U0AESQEQb9
	OTm6GYygPYQq9jipcYbUOzg56dSDw7iXuOUL278V8BsbR6Fm4A==
X-Received: by 2002:a17:907:9490:b0:ae3:7084:7358 with SMTP id a640c23a62f3a-ae37084758amr558688066b.58.1751233231651;
        Sun, 29 Jun 2025 14:40:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSIm7upfMuuJVnjznmjrVxm+tXaPhq4fTHwTaW1KebVCezBY91akX8QVAoBLuxIE1VBzR56A==
X-Received: by 2002:a17:907:9490:b0:ae3:7084:7358 with SMTP id a640c23a62f3a-ae37084758amr558685966b.58.1751233231308;
        Sun, 29 Jun 2025 14:40:31 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a754sm557263366b.62.2025.06.29.14.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:40:30 -0700 (PDT)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: kuniyu@amazon.com
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
Subject: [PATCH net-next 3/6] af_unix: introduce and use __scm_replace_pid() helper
Date: Sun, 29 Jun 2025 23:39:55 +0200
Message-ID: <20250629214004.13100-4-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250629214004.13100-1-aleksandr.mikhalitsyn@canonical.com>
References: <20250629214004.13100-1-aleksandr.mikhalitsyn@canonical.com>
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
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
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


