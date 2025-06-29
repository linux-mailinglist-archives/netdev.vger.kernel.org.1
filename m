Return-Path: <netdev+bounces-202294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 539F1AED14E
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 23:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD0174448
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 21:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2BA242D8A;
	Sun, 29 Jun 2025 21:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="GodWCOfe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8D22417FB
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751233240; cv=none; b=sw8UxAyVR1msMFmMDNowmodSEKog/+VUlxXU5o9Ml+s+DnEpy3fsjU8e+oXO0W6i3ydHk9nLF3W6FTGCCBOTe8pVw48yYJdKF4SMrLApL5cFKnyC1SdA6TkPKwrWXEF0Tz0xp+VXP6iDRNFEsM8TvPDToKAPTu/YhWlX2J2QRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751233240; c=relaxed/simple;
	bh=kvcbJF2gqpLsLCd/IovZeBo7QSbHZvsPm2YuBtmttAg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AQfZZVb67sN7Dk0QGyz41ZoPSsBKhcleMfQn0DGL1i9AL8cMSS0bvAYIhH5c2XIrYIZUDffxVs+Z29jOQYc8gPXSvggi7wuSxgQg4Zu1bGRwxioMG7u5iX/LEdY7Ouy3TdqShRrEra/+EgEwmntiSp9KwUdEeHt6ufVxa8Q7yRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=GodWCOfe; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id F14483F22B
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1751233228;
	bh=QTemUsWeLJmmZyto6KQ3VZl2RnE1/5oF2xDkIiQpRdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=GodWCOfeRhw/ftPICRnYEIbEWByeqtZvbj+Zk5bEJgVTDFJxYMDzJsrAEYe5cu2d5
	 vHodG0lbXlbSpekvLTibsZL4m2TmZ0A2dFkovnrwY73+G7VkHQlO44uH/VZHvYjNgw
	 MkIj6KOZXyQqKN7KTTEn9lu+U033LaX6yrQWqApTeWVeDdlVRVYD+qbmKFNciymIhw
	 0DxhfcCq08QcgImCCiLPHe1cxNziCyIyJlEOkgef+LjspKPCll1YityDeI/HaA/Q+b
	 GcS7/OgahZhdkBRXUfSb28Cc2LzRakmZpTC71xDsZSmLSf7pB0or4THDi3fQ6o03SW
	 6t9Bc7t3LEexA==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae0de1a6a80so116789066b.1
        for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751233228; x=1751838028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTemUsWeLJmmZyto6KQ3VZl2RnE1/5oF2xDkIiQpRdI=;
        b=XxDE6zm+pRso3cUd0FohUYCaeHVq9z5as3rVgGJzBbE5v3LDxwqoPw5qkrAZTeVNNj
         QSzxuUjOAw9PEUlYNIPbwH9a+Yix4rVutGyTPjk82u2/2SVcx+70q5plLM/3GraxaQZk
         5gHiK3jbWlM1i6OsK6F+YHDlFTrMQ4Js8USzLdI9biPlTdniGC9o+qU1X3xcEzh6SL+1
         U/9y9+XH3vFwEw0PSF9E66bb0zl0tq4lTvH4vB7zjLq4RRkbrgT7NKoFRorh43+hWXkb
         5V2cue7YWbIqz1nn/aik1Kretbx5Mn/MjBXfHfQ0NfmhcNTa6mcPMjwh/ZMd+fKy9XDv
         d3bA==
X-Forwarded-Encrypted: i=1; AJvYcCVXpkaF/S+RbTS//z8fWn/fdLPA12WNlsli9pitEJqCIEobBsB+lRAynFM7+za7hMKSX9Ir544=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBE3ZJm85hzMqVY6wvfuMFBhKb2hiFMRccdPtoj4D3L6iklz3F
	5uYacHH66spZNPAlUq/ELX6jPlz2dFClA2WaXoI8QHjYy5E7QnzvM6++fW3npoM7mBZFcwoG4cl
	LDVQoJM+Tb3e15UVYKiv410cCvY/en+eXrikgl1Ll8cqwCA6aa4Kcza3fGPUg5uVi65yvkwbUFQ
	==
X-Gm-Gg: ASbGnct8is45wetQU6Z7rJH2wl6tQJ1UBoSO8jpirbXvnettq2OBRTgbU6wl1L7KVj3
	Gxg3CQc9z4WW7P8bXjkttC/5NPwMxLfermowwalBb7113+iwa408rklVkmrlByRMFs2DcGCEjUH
	KQa4Tvp9e6/NxDREEXV/sNuStLMu41rV6i+NCwBGjsjesop+ehvhLbU9OT6pPN6UHkymTFXH3wp
	gOu2V2p2Z9EnALIoNNWAgSbFaTfOJnT9JQPtyv1bd3ffewlH0JVYvhOQyyV7/pYD4wpUfQDaYYf
	05JpPJSIbUmZ+Tu0j4UEZKwluZj1wmHze7xwMxKc5XWJaole8Q==
X-Received: by 2002:a17:907:1b29:b0:ade:3bec:ea40 with SMTP id a640c23a62f3a-ae34fd2bc54mr932857666b.10.1751233228558;
        Sun, 29 Jun 2025 14:40:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTGWAqr2cYFXliuX8B24KQBUcbldsB6HuCJVhDhy2pn5wpEbt2R5iLuguahv9SroXd+9vqmA==
X-Received: by 2002:a17:907:1b29:b0:ade:3bec:ea40 with SMTP id a640c23a62f3a-ae34fd2bc54mr932855766b.10.1751233228149;
        Sun, 29 Jun 2025 14:40:28 -0700 (PDT)
Received: from amikhalitsyn.lan ([178.24.219.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35365a754sm557263366b.62.2025.06.29.14.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 14:40:27 -0700 (PDT)
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
	Leon Romanovsky <leon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Luca Boccassi <bluca@debian.org>,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH net-next 2/6] af_unix: introduce unix_skb_to_scm helper
Date: Sun, 29 Jun 2025 23:39:54 +0200
Message-ID: <20250629214004.13100-3-aleksandr.mikhalitsyn@canonical.com>
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

Instead of open-coding let's consolidate this logic in a separate
helper. This will simplify further changes.

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
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Lennart Poettering <mzxreary@0pointer.de>
Cc: Luca Boccassi <bluca@debian.org>
Cc: David Rheinsberg <david@readahead.eu>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 net/unix/af_unix.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6072d89ce2e7..5efe6e44abdf 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1955,6 +1955,12 @@ static int unix_scm_to_skb(struct scm_cookie *scm, struct sk_buff *skb, bool sen
 	return err;
 }
 
+static void unix_skb_to_scm(struct sk_buff *skb, struct scm_cookie *scm)
+{
+	scm_set_cred(scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
+	unix_set_secdata(scm, skb);
+}
+
 /* unix_maybe_add_creds() adds current task uid/gid and struct pid to skb if needed.
  *
  * Some apps rely on write() giving SCM_CREDENTIALS
@@ -2561,8 +2567,7 @@ int __unix_dgram_recvmsg(struct sock *sk, struct msghdr *msg, size_t size,
 
 	memset(&scm, 0, sizeof(scm));
 
-	scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
-	unix_set_secdata(&scm, skb);
+	unix_skb_to_scm(skb, &scm);
 
 	if (!(flags & MSG_PEEK)) {
 		if (UNIXCB(skb).fp)
@@ -2947,8 +2952,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 				break;
 		} else if (unix_may_passcred(sk)) {
 			/* Copy credentials */
-			scm_set_cred(&scm, UNIXCB(skb).pid, UNIXCB(skb).uid, UNIXCB(skb).gid);
-			unix_set_secdata(&scm, skb);
+			unix_skb_to_scm(skb, &scm);
 			check_creds = true;
 		}
 
-- 
2.43.0


