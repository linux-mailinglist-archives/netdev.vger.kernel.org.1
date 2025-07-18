Return-Path: <netdev+bounces-208142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE285B0A398
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911287BB9EA
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB272DAFB2;
	Fri, 18 Jul 2025 11:52:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2042DA75E;
	Fri, 18 Jul 2025 11:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839540; cv=none; b=fMZjAea8L8qB8rjs1Z0EN3zHkOMV+3NrD9e+sAjYxuZzETkSh/pI634eBHv8KfeOghj4HWyI2jeXnUhbOKWCz55taeGD45boEl1lfTYWL4JGtzXN+zNt4ayw+wUOXtOZmFFRrvVAVSj7mje4k8MtBtx8I0tZKU5M96LNntVQ2RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839540; c=relaxed/simple;
	bh=LXKhX2xGJ1XURDACwlP/aaNOyFrwLxfo2adz710C7bw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ujutOnZb3lLdZybN2sR7Ach1gqSqVNqldNAnRXpFClThD0cvDGclR+5Hg3WBrb/5CPUwg09MOdbMYXnKPfXIcsN9nyW4ncwWi2EkqjnZkfke77sRR4clfAyOlODLG+QI4NnO87ieHxDqYPlkp0MTcMFsWitrsiAj5K0UimxRqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0e0271d82so357459666b.3;
        Fri, 18 Jul 2025 04:52:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839536; x=1753444336;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7+8Ag+vFn7qJNVgKf6C+5RLYQ3PejsKZzoL2fH5p+0=;
        b=Xd4WbZ7340m7/VaMsTZnBfeY30pvH3Bq9QRiensDE2zlCZM0G1VThJo4zyUFqe4aBs
         OymOuFUj8EWtvFeBREItk8WGu8gDvTRqydTe02LwrTEYSdMCcDVIHUyEaLL30oOkfRRG
         RizAy+eB5zZj1IfWGX66XOtj5MMwbZJmsJDbsDpWFNioZCxpcu1Ob84ssupbv71zC88E
         DToCk8o8U8NQQJGHVCv7XZ7AGaA648Bp29YqOq3GHIrYajV84dqoqW+ZAoiul3SAvHLC
         d9PED8CFRW3B/C4yblmWpG0N/+27C2SGYIvGGSTPffEVlD6iWELJ7Q7qZdEGw9VYStdj
         OCBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmctKruBsRciW+U1Lc2Y9q85M8hc8s2ONSBEMr60fVlT8DHShjr+6exyrP6O3tW9hsBB//Pl7domw7/rM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOXP0JqOctG5WTrRfRi2ylMCvemAHKUDz16ENDuKYdFf+DF7Ti
	gm6NlgjuZWIMMoHTJEtIcCIGvW8cCrBSS6oq2DNOoO52dWniNe+9+8KG
X-Gm-Gg: ASbGncvOzDsIXjxF3Lb4llN9OLTMRQGiOjnHxRGcCWBvGWjAS1fqWyRjmC3Swm30zGZ
	OTnvx/4FczUzbSvzX9Kqz7NfujsBYaH8Dv9OWUb78JYEWlXdjOXzAWk8d4E9RWjIfPovn1xBCfj
	byB/6LGOowTp/d45n4XoqV+87VooDzfLSlXcNmp7Y5LnpdNVr90wj/3tbzF9JLuQnKPp7CbJ6DD
	+pRPAmYcXv/SKSPqWITfG6QDz9KkxLyCQorzIIXr999OZ79X2VJ4aTrllHHubebSyKRX0fgxOGj
	mQG4/DsBMP1k/pcby5mLHFoVjyQYHbGhG6EB+UvLASTcUB7146Vg3FdFA5LIMb3XQ/2JVnXG5en
	l2KoZpev+pL9T2CTv9iynH30=
X-Google-Smtp-Source: AGHT+IFQqT50hIcvB/p8HVTE3B/FX8glm4Qyni1GKc0QBnNbNy5/VRtzg4CCdiWzNEuB0dIyvYbGow==
X-Received: by 2002:a17:907:a904:b0:ae3:bd96:78cd with SMTP id a640c23a62f3a-aec4fa4387emr695648066b.7.1752839536059;
        Fri, 18 Jul 2025 04:52:16 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79a056sm109299166b.14.2025.07.18.04.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:52:15 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 18 Jul 2025 04:52:02 -0700
Subject: [PATCH net-next 2/5] netconsole: move netpoll_parse_ip_addr()
 earlier for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-netconsole_ref-v1-2-86ef253b7a7a@debian.org>
References: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
In-Reply-To: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1854; i=leitao@debian.org;
 h=from:subject:message-id; bh=LXKhX2xGJ1XURDACwlP/aaNOyFrwLxfo2adz710C7bw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoejVq4Qty917MxfLHcvA3jRk48xQbOhVp3F11l
 z96/3FKLl6JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHo1agAKCRA1o5Of/Hh3
 bcg/D/4uUNsQPuwAXEkylfj1lHmW4Wneyc+dWfoK1B0sAx9/DgFy6jfd6xQjqT1FuYsQ01r5qQi
 Mu14jYk5O8Qm0q1/iBlAYhZwZgWNnZsFt1UdtMZNxFEUjiLjfK2nxy6oPZePOKIc1yUqKeiIn/2
 xkez2ZrFGMw7K/23/4OEzLzyvmFDjy/qUEnTFBO4OoFi8UogXZqid3x1IVvWaCRTSlKzAukbNAK
 YgIJ0CQgjQDO5UxTHxrsLKtQE2Iq05UHGkD5rPHRL84iWYtGBaSBCcnkXWZvvuu8IZ6JqUtqZwH
 zfli8OOrC1IIwna+7PhQVEZLJ6Wc03o8Pd3n4b9W7ojAf6TZ/mS1uq74zBDUmRpRQi02q0QQi6g
 VudIS8q8gljZTNZyunItwMtkNh52hPl62kVm0IckSjSK4J7j0Tu4sgqtBME6iL93hxQB3Mr+RZY
 dOYnFDLgFerLFmP34KLZLIoxfuX1YkQaSoAKa1gLt+tbLklUbw3B+C8+uyE0UivDxvRxwU1K4Et
 g9+La5mF+sJivyZ6bG8ZkCCKYsS9F++wu4LOyJypIvVswxKJnBHZeOmiGo1jaT0IJABlRRB7jYf
 du7k/t5Fg5sy6/rC8dMxDGAxxtOjESJZwB6bdiKoQCY27Kn7NrsOcW+Z4d9Gh/LCnBM2Z7xvc1j
 b85LQDBOHxBw1Ww==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move netpoll_parse_ip_addr() earlier in the file to be reused in
other functions, such as local_ip_store(). This avoids duplicate
address parsing logic and centralizes validation for both IPv4
and IPv6 string input.

No functional changes intended.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e3722de08ea9f..be946e8be72b1 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -360,6 +360,26 @@ static void trim_newline(char *s, size_t maxlen)
 		s[len - 1] = '\0';
 }
 
+static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
+{
+	const char *end;
+
+	if (!strchr(str, ':') &&
+	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
+		if (!*end)
+			return 0;
+	}
+	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
+#if IS_ENABLED(CONFIG_IPV6)
+		if (!*end)
+			return 1;
+#else
+		return -1;
+#endif
+	}
+	return -1;
+}
+
 /*
  * Attribute operations for netconsole_target.
  */
@@ -1742,26 +1762,6 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
-static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
-{
-	const char *end;
-
-	if (!strchr(str, ':') &&
-	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
-		if (!*end)
-			return 0;
-	}
-	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
-#if IS_ENABLED(CONFIG_IPV6)
-		if (!*end)
-			return 1;
-#else
-		return -1;
-#endif
-	}
-	return -1;
-}
-
 static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 {
 	bool ipversion_set = false;

-- 
2.47.1


