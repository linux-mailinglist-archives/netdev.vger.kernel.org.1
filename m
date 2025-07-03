Return-Path: <netdev+bounces-203942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC33AF8353
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 00:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF8666E62DB
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 22:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129242C3240;
	Thu,  3 Jul 2025 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="MwBmgNwk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA0D23C4EA
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751581433; cv=none; b=HGeEF0E2qCIh1BjFZIIDa2TG4MIIHCOBWLP+kPr2XBO7THYi/RO2sfSlZtoU+jMDhoMkn/3jLKRfREghv/ZToAzG02Wq8eoBn8J4HPCsqH19pL7pjnrXo4L+HIkgudLom0URD3Nr9YavbUEjK/OZlEvcD457/ryzLg/mmjDvb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751581433; c=relaxed/simple;
	bh=QD++eQ0mdA3X9osAOwOaccdl8io/UixGrQb/zmCK6Z8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZiEo/642rgFxU6hF3GqHfU/C2j8UH46Q+8y1iDUBYyv2yVfA9lCK9Wg7iOPHfEoMjA4M2q/wh6Gd5L8+MGwdTNlGiwkPy2FelQBEnQzlihv8w27XaOIARBYKxgM/aAqBZGYoq2GlfzP7XSsT5V3siYiptmd0ybj6K+wt+S9Y9yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=MwBmgNwk; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 54FF53F91E
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 22:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751581427;
	bh=5uSoGMqL3ZtB0VgpeBJZUFVBttzjqZO2/y9STyu6+9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=MwBmgNwkatnApxIxP1f+xA6WK9c4IdMLh/Zuw7u21PCSwnfeadFv+yF6CaD1+4kFj
	 qcZt3HgmmtPKbhk0MvkCkKXh9xFu515I40ZOMDdv0DtLaUPpWhFMzFlECAuBCQYx19
	 aR+amU6Ckw/5Dnuy35eII2hLgYYh3ixrOcukO6TM3dpZgTa3rQfINkXCCnigCJLkfj
	 zS6HpNrxhv1xQlQgtIyNiq3deEAvgHhl3A0fbhoTh/Z/e8LaqzVi/Y4DRXN5vBTGM7
	 uYI4sqoeG+EdZmomKC0O3h9qjn+2WU0skAZ9nyPzykfS1fNQrudwmLbdGk8ViwuN6v
	 /XqX05zNVOyIA==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ae0cd07eeb2so23938866b.3
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 15:23:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751581423; x=1752186223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5uSoGMqL3ZtB0VgpeBJZUFVBttzjqZO2/y9STyu6+9U=;
        b=RWRNXJCI/POzbbvl0yEH3c5HrpzYBmj/plGq8olOp8/qTYT/mvLhoACtNj+lzfUHUv
         YF0gokuri6b3DK9nhuIbkpIFZlrCrBkG4XtQpoG1J84pWj3svDWyaN4tSTZxMRXse7GR
         BogXoFciVaoMqfWqmPkhrpJPtaIBl8AmN2WmSmIYbuGJhxX+pQSh4R08xvXVcylUCf7s
         NIeADO3BdujaX9Z3biLyZ+KXJ7/VKSIRFvPk3ziy9PD52Gvsy/3C3/FWV8mp7ieWrn4t
         UT63tZvzcICn09UuVsFkgEiHJD5+lKJe6OlDRycgJjbdIjsvVFQLZif/scp3AJKC++sT
         eGKg==
X-Forwarded-Encrypted: i=1; AJvYcCUEBCLXREQiEy93lnn4M3+1N1OthIz+agoHO5U81wab3/Gt6l3ifl/NP/hx59Oxu4si+jMIVDc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSIZiTjRQ6c17T+hml25KoxDdkcmkNTtS0fsKp9sd0vDROGw7V
	pMUbeUsXNWNKciGam7ZONSDNRpRHW0rxMxfGvI5PF+vpbmMnVFMpA570rAbgA10bLbgE11YNP+g
	FvEeitHVjBmn9Cl18RjGIw81cUYFT33HphvNl3gsMd+J43mM+0g/SKLhDMFmgiub6NpgFzwjtTg
	==
X-Gm-Gg: ASbGncs4EYLJOd3irsJt7wSPdDPac7qR2l7sM7cCCHNVfLEk7dKIgwDKhcEBLUohRaq
	Rl2AYhErGYQv3/KOQ0rtuJ1VJhXG/JxWnQydvwnbuBF4MwFgdODmslxZxYyJta9HEomAlf0Mf4i
	05Q2jv1Gj+1T9NrOG5IAnPUqod9mNoERfGTIRp1eY6rbRJ8AMicSuhylkC7l1KNuPLoGxBmM2DT
	TodHLyH8aNB+BuE0HgtQTM9S/hmExDsBJ9ijSLWVhvXiCt31ge+5Ttgz0Frv3ScAE9uHddyKSx+
	gj2emTw/kHuex7anUWAETv2zOMeqdOwQf+dxcvKQ58RfLWWuqg==
X-Received: by 2002:a17:907:d93:b0:ae3:61e8:c6a8 with SMTP id a640c23a62f3a-ae3fba363a1mr24998166b.0.1751581422799;
        Thu, 03 Jul 2025 15:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBHhw9D3yJgbkNuNyxC4DptnT1/9dBd4TzRzY6hn1dbib2RfP84YGYMXyfTs/CHXFSD4vppg==
X-Received: by 2002:a17:907:d93:b0:ae3:61e8:c6a8 with SMTP id a640c23a62f3a-ae3fba363a1mr24995366b.0.1751581422377;
        Thu, 03 Jul 2025 15:23:42 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fcb1fb083sm355164a12.62.2025.07.03.15.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 15:23:42 -0700 (PDT)
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
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH net-next v3 4/7] af_unix/scm: fix whitespace errors
Date: Fri,  4 Jul 2025 00:23:08 +0200
Message-ID: <20250703222314.309967-5-aleksandr.mikhalitsyn@canonical.com>
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

Fix whitespace/formatting errors.

Cc: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v3:
	- this commit introduced [ as Kuniyuki suggested ]
---
 include/net/scm.h  | 4 ++--
 net/unix/af_unix.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/net/scm.h b/include/net/scm.h
index 84c4707e78a5..c52519669349 100644
--- a/include/net/scm.h
+++ b/include/net/scm.h
@@ -69,7 +69,7 @@ static __inline__ void unix_get_peersec_dgram(struct socket *sock, struct scm_co
 static __inline__ void scm_set_cred(struct scm_cookie *scm,
 				    struct pid *pid, kuid_t uid, kgid_t gid)
 {
-	scm->pid  = get_pid(pid);
+	scm->pid = get_pid(pid);
 	scm->creds.pid = pid_vnr(pid);
 	scm->creds.uid = uid;
 	scm->creds.gid = gid;
@@ -78,7 +78,7 @@ static __inline__ void scm_set_cred(struct scm_cookie *scm,
 static __inline__ void scm_destroy_cred(struct scm_cookie *scm)
 {
 	put_pid(scm->pid);
-	scm->pid  = NULL;
+	scm->pid = NULL;
 }
 
 static __inline__ void scm_destroy(struct scm_cookie *scm)
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index df2174d9904d..323e4fc85d4b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1929,7 +1929,7 @@ static void unix_destruct_scm(struct sk_buff *skb)
 	struct scm_cookie scm;
 
 	memset(&scm, 0, sizeof(scm));
-	scm.pid  = UNIXCB(skb).pid;
+	scm.pid = UNIXCB(skb).pid;
 	if (UNIXCB(skb).fp)
 		unix_detach_fds(&scm, skb);
 
-- 
2.43.0


