Return-Path: <netdev+bounces-209432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF73FB0F8F4
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 19:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BD801CC2EE4
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C3A22D4E9;
	Wed, 23 Jul 2025 17:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC0D228CB8;
	Wed, 23 Jul 2025 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753291267; cv=none; b=UplDdYTTCsjJc1BMR7QtEPnienpGZ9vr/OwmCIMJO4CPES09TDzEAp+zWduWzdlMQtp0wfuiIv0TAxw3f3nCzn++LDiznS6Mc7Ad93DzvczjSUkC9tCKDOiHV+234/j0uVTBvEjlQb9Ttvc5Jp9/zeaNJ2EDYYPE0fFsXkiXgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753291267; c=relaxed/simple;
	bh=nguDrM0leEHBq0w7xffcJG4/xal3jI5Q+mFldOTxOoc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5dG5Q/vt7gXGNXcLji2Ft9C76QP3tSDTz12ObrwhaVPtmdEEl/ntyVEDo7RX3etpnXOMGPXCDdlLOOrZPrM4lmHt5Ful954ip8wk7/g8iGjcdiOrzO2SASxhSTbL47D256cjwHalpPuXQNAJL9xHCS475Gr0gdPL6wguwZ658U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so14973666b.1;
        Wed, 23 Jul 2025 10:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753291264; x=1753896064;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UganVJsRCwC7ZF0STQTZO3KVXTs10kIxoj5lxh6bhws=;
        b=AhKQsVuuAjsciVUSS9N5fFo9w4MzjQ9+pES4KCAFAe23UBhKzbzc6rKVfUNKoDjVzY
         Q5YfZphBKcrXzP3y44aZdlXpdGo5+MwqE+xtzIZGyzztaILgJEvJRZXim3/msLsOqutV
         Z6oRjMcP5ok0zji/GqeUAue1bM26BXYNX19ATvvF36uORoxLCgpVOazI6thhUdF31SG4
         pSHCKjddyvncTGlvO3Da/Liv29Xz0BeL4uiGKI+d3IfRV2XwoQ1NP8LJ3qqQjjoYhOra
         06twCZ8RsiqWn/OzIon5023RgDozLffjz3hNzgWsr7RClHE3wdmdV1SrN/tNnt7fAVYd
         wL9g==
X-Forwarded-Encrypted: i=1; AJvYcCV8Q+jbZqzRTl4iNJp+kwxQ87cDtuOMmESmyrEop3PaWy59ZtyqNIt5MLMLTQU9PP9puaw37gwcJ2Bcgxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGGI/X5xvgIklFvKKM6OvSSOpbBJOBpHqakLfwsyxe9Q4b0n/m
	Q6Fr7luz+tMtIEBOKtNjBQRG3NqcS7RPV621ApGwTCT+C3Q2YhuFZQN6
X-Gm-Gg: ASbGncu+pS5biXo4dVyKs21GTVDN5qQsqj8XChLJqx7isOPC2b6ZCYgJ4NVvsWjyOnK
	OkTH+Xr2RSS39U5rD+oA5x0uiYaqWn6kRh+Zy6Qq/265orQaIXKEVWug0gs6DLwPVzSPmVZfnvb
	cPz0JlWtty24dAGQK1Jr23p3IUhk+cKXsKxUORGs97BUfUvgJd+9pUA29VI3qr65sa6Ql0pukl0
	7aANJTiagmvHpU3+emS3qgfXk+IIcrc+iXdI7h55WK4Tf8TMzW4+vRrHCLrGhhCZiIq6byp/Yim
	PZL6SwnGlbSESzBBYOM3Qj/w+hlmNRi+UDoms87iCKmd/3rb3DCncgKdMxp01+kMfSTF39VG2QE
	TZs8BwLeWJ4+9
X-Google-Smtp-Source: AGHT+IFb1L7Q/2kG8/sUIMK7WmvK4HQLRZ483cU1yV4JWbXeLbcQus3B/CI2hqSW6KzG0eZ4kJM4zw==
X-Received: by 2002:a17:907:9409:b0:ae8:e6f9:7cf with SMTP id a640c23a62f3a-af2f6c0af6amr378904666b.23.1753291263715;
        Wed, 23 Jul 2025 10:21:03 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:3::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c79d6c6sm1082551266b.32.2025.07.23.10.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 10:21:03 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 23 Jul 2025 10:20:33 -0700
Subject: [PATCH net-next v3 5/5] netconsole: use netpoll_parse_ip_addr in
 local_ip_store
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-netconsole_ref-v3-5-8be9b24e4a99@debian.org>
References: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
In-Reply-To: <20250723-netconsole_ref-v3-0-8be9b24e4a99@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=leitao@debian.org;
 h=from:subject:message-id; bh=nguDrM0leEHBq0w7xffcJG4/xal3jI5Q+mFldOTxOoc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBogRn3ZmHdjG+Ae3bE9OD0bm2x1cP2UjX22/c0k
 NocQK2J/6CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaIEZ9wAKCRA1o5Of/Hh3
 bVDMD/9DYWYpodEJDjKbWknVtvuQazGZpnIsRMz4WBM4mWS/njRSRVsKdv//lrX5qed+ZpjDUbH
 3C5i2ebPXX2ssaaZuKDfGJNFD2vOBHVLzPtZIVBSjR1Cv9cioZW9b2J58iK/Dzij0m/FAS5dFiJ
 5CBv8louQ6jNTqTIDtVYR52BZD4sgUNdxqhVgkvZi98Zg3JLKDXRyQP7PIrcJMiIwg4/Q2XxK6z
 d2v9Ftv+YOxpBBz7tg/CXFZzvF6pq9TIaWFehiiJ+YTWhuMGm32zRjhW7FQC1klUqoEzCDrdR94
 kOoXtU3EIGr7xdk94T31RuFeTKPnwPFhGxwomIoU1Wxx+l9xJeKucgATPDoAUYN5l19o+bDpusA
 hTCdQ/QUNpqtPmtVoFC7Qni8WFGksyByKGd0k2wWzc1aF8v02sZRF8Szw4Dv3ZbHccs6SazbiHM
 7JSj2txk1THF7BbQ+n2wYJBDU1/z8LmCPSSqV3kMZnwUieymE57vEHsq90DbIZD/YP5g3ZBcr/o
 d/If8KpdMUrK1gJ3Gw36vlmIvY5/aBCVXypsOq0lurlsu/F5pEPSdFvSUh6otqDIKLZcdnVZKWf
 klHtIApjrJe2oOh5Q4sX/vl+oXp/WJrgVA9XONu6P81uZWYOPtVhfvtMTuKf3aKOQBxHqtMQNZN
 5uG64v+i3LiN+/g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace manual IP address parsing with a call to netpoll_parse_ip_addr
in remote_ip_store(), simplifying the code and reducing the chance of
errors.

The error message got removed, since it is not a good practice to
pr_err() if used pass a wrong value in configfs.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 358db590a5046..ef7d385a28151 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -775,6 +775,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
+	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -783,23 +784,10 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
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
+	nt->np.ipv6 = !!ipv6;
 
 	ret = strnlen(buf, count);
 out_unlock:

-- 
2.47.1


