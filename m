Return-Path: <netdev+bounces-208145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A39B0A39A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 605DC188AD6A
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B759D2DCF47;
	Fri, 18 Jul 2025 11:52:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB82DC348;
	Fri, 18 Jul 2025 11:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839544; cv=none; b=nAK2xwAhfLW0eZ1HM6L1ZnLOKFIXiRGGy591iAKwgLSsEJ3OHfG94r4STZfeDrgH2Rpsk9HXXGdrL46AzJaqLGsMdpSkFjJ7+NphpMs8CJaagu7qcYDr9P/D97pzyZAlgVnJ2UEHUwyMf0DFlOA3L/NP5klJGkeBiOiUFLIBjq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839544; c=relaxed/simple;
	bh=/7CHHKqdDDOfq9BdS7bFwCjG6K2UKEXfHl/n8vC+iQk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u/8XJrmyRKXPOUq9R5WzqgMCZa3nqc0u/e5suWN0aYQsfLFo7UTFR+WV2EDJb2x396jANF9idQnHWDH9G0kODAhqwS83/BmQq99Wzo50j/u6YJiz+Gw1RUYRlZbwtHaaoTx7DO4NWekUMN8rjwTGVfEabDWByyCDxeSJ2Zmippg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae04d3d63e6so370022866b.2;
        Fri, 18 Jul 2025 04:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839541; x=1753444341;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zfweb8Lprtz6U1Z0+6B/k2IheTq6ouQOgUs35bz0iNk=;
        b=mjYxsAyK74pncMbvVEAtHXkFkwcETQH9VzrJikRYZ6DMf3C54DrJrczJqvsgOS2yEO
         e84HIuFsbMCI8W4DY4xFeYWz5Vt6krV26ChbpoeZ6irjA5/cdy4o92LWFdQqO/InPA69
         VfRYOJ8jDYMtz8G3oVJ151wN89m1iAv8dpzR27HWB20JxruRGpbZV/kM9xbFiid7dLzm
         mXG6FAYGlI59lUKwhUjwqD84ig5z/67wIvbICcVXu4R5LVGGpGgtE0gzis5S5hHbHuSD
         eBOJ7d/8/F7iy8xSk/Ed8oVAkHLNXgSEOe13bTp95+ybnzjqQWpeNDKfNZZdOtTQq9Qa
         royw==
X-Forwarded-Encrypted: i=1; AJvYcCXAiDSzfsRBEc+aKIgr4GVk5nXFSd/JhBQaWNpruregxVPqaZY6rzZ2hM/f+xiufGfJpJRfpmX5ZNyez2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB7L0gSBIDEk/FOwE7M4YhrtiXksXlS+FWNH8xDIBzhApNdtvk
	Eh1iXKYKSmUfYKci/2UHYWsCM7wxYubR9YCh7Ni1ctV5Y2mStIhR43/d
X-Gm-Gg: ASbGnct5tGWbWIIP4Fi6eqemR0PR5IRU19U5PAdYMeJ2e/njfCzcqEhtgNQOiAkXrrf
	cApI4j3xTz5UJGkismmd278eSgdcOK25hVzVO4G4sIRGKYAzsodg+BQeU1/UlBONNDeV5DZyxZH
	PBsJKC4AlUo2C5npInhUOfNPqX3EQ9MkHWDMhplaj7RlWAq2aTvDb3dFYq5h6WltwiHYYpr8ovU
	QQV9ceA8EW0WG4BXRnKb6CqTGxneSgezauOKX7bJN9mW30qzW777cxgf4smN3P5LdpWKaQ+azRM
	CJJ4FH1/ejqxXJkYB/e8cVB8ASVKg0b5+ClXPjR/Lc+ewwtP1YxjFy3g1tB37kJ6cHH1T3x3aWT
	5C2dVb+ULvHe3
X-Google-Smtp-Source: AGHT+IEWheBDBQ2C9Dmm6F0vNrKz03zOHSrvsTFhF4VzvKXKLrzsmYUJKB6IUKVpg65ig+Mg0hU4yw==
X-Received: by 2002:a17:907:7286:b0:ae3:74be:49ab with SMTP id a640c23a62f3a-ae9cddb3a1fmr1088392066b.10.1752839540921;
        Fri, 18 Jul 2025 04:52:20 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6ca3005bsm106854466b.88.2025.07.18.04.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:52:20 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 18 Jul 2025 04:52:05 -0700
Subject: [PATCH net-next 5/5] netconsole: use netpoll_parse_ip_addr in
 local_ip_store
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-netconsole_ref-v1-5-86ef253b7a7a@debian.org>
References: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
In-Reply-To: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1594; i=leitao@debian.org;
 h=from:subject:message-id; bh=/7CHHKqdDDOfq9BdS7bFwCjG6K2UKEXfHl/n8vC+iQk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoejVqq4JQXiAhsZ3aVkfrRk3XeTMPI38IDOwD8
 bLHNjpZ7WOJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHo1agAKCRA1o5Of/Hh3
 bT2SD/9ev/w8JsXlvdARvaxqs/o87KAJGwZGYrU9fe2CM55TzVuplvXPF1J4Cm0IVI2bBs+wG4l
 5uuExjvhODJjs12ma2Ok/wMLEp48MJ4e5oVy+V3jV1jRIBAl5YmliKK8PK72C0Pk86I7yAu/AKc
 FuA2ff/QqCPi/LqsL+LFxHGHKty4ShNICRco1r2QECKJnoORLEkEq1sIL/myhc/83eJI4Tx5JIF
 qCMyaANogdpYHl0afBvfrwGMEoH5VOhiJUEAv/VEOxiBo0e/65q+7NP2aVWqBmOh5U7bmCuj5SK
 NZwo1ha1tgT+X/d0fSmU6kms8A7pCxOVJq85ePn8aGEKHOJhCVpXu5qESpIBQLStdMA5imcG41f
 G51Sj14Xg1aVRxnBHZD9uAC6FB88XvJG1sPuizKVYiSGm5+hLPcqaIceGJhn63RD12fMc2B9Zec
 ejjPiC7J6gRyQi1urIJJgbkluTLLRa/fZi+9OwdsPZeLPiuZRYyFB+4JsEhT3wZhyDhqdYiy8RA
 eIdPIRTDKKzpjLIQse6jTjYl2qAAEMEox+uv2iXzcRcheJHMPJD3tDz78ffiV2Cos1qHoOezmKk
 hswRFOZ8prFKbrMU+j9PDKnQwfuczE5fQSzVw5sFNzschRey72cZ4li7X1gYr7pGKGdv5ZPaoCd
 17KPubzJfMsNJCg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace manual IP address parsing with a call to netpoll_parse_ip_addr
in remote_ip_store(), simplifying the code and reducing the chance of
errors.

The error message got removed, since it is not a good practice to
pr_err() if used pass a wrong value in configfs.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 3044349c5fe37..de6f1a7c24cc0 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -776,6 +776,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
+	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -784,23 +785,10 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	if (strnchr(buf, count, ':')) {
-		const char *end;
-
-		if (in6_pton(buf, count, nt->np.remote_ip.in6.s6_addr, -1, &end) > 0) {
-			if (*end && *end != '\n') {
-				pr_err("invalid IPv6 address at: <%c>\n", *end);
-				goto out_unlock;
-			}
-			nt->np.ipv6 = true;
-		} else
-			goto out_unlock;
-	} else {
-		if (!nt->np.ipv6)
-			nt->np.remote_ip.ip = in_aton(buf);
-		else
-			goto out_unlock;
-	}
+	ipv6 = netpoll_parse_ip_addr(buf, &nt->np.remote_ip);
+	if (ipv6 == -1)
+		goto out_unlock;
+	nt->np.ipv6 = ipv6;
 
 	ret = strnlen(buf, count);
 out_unlock:

-- 
2.47.1


