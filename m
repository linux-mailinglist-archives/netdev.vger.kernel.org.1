Return-Path: <netdev+bounces-212571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BC8B213F5
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCB66255BB
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB862E1C65;
	Mon, 11 Aug 2025 18:13:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E47E2E0B73;
	Mon, 11 Aug 2025 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936026; cv=none; b=OyFg6DeChdDdMFOmnjKL6tyyUdyrB0BELfxJsqpr6WIi1BMwNJphIjqn0tnJRHNeIg4bJlmpbTDjxDQyqs1uR5ahEI3IuwBcFMQrNameKI9lfm5rYeVEUrby8G/z6ydjYwhfBfz07wS9V/1Ks8hDLk5qydzD1hY6maTett9m3x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936026; c=relaxed/simple;
	bh=TYuHsvzHVOr+9PvIQi9gEgWUd6z1ZxvE9ypUBBhqWyc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JNT4/sa0d3JzmK41eD3q1YiPZoCuyOgq5h728+6tIPaLdhvEy11rspVm6FKupGG6pRmVWjmQW3P+tF7H7Dp5lZholonxegVlz8z6Nq1gYBGqv8l7MgBBhser4B76lBCWsXAxmRyIUB03qNiQHAPXcmsrHCa4De5OWPVn3ujPvLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-af90fd52147so705884366b.3;
        Mon, 11 Aug 2025 11:13:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936023; x=1755540823;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlANYRkx09sjmHv9uIlhrUyb8IuPz3ei9Bead1UID0U=;
        b=PzZ0m0bofIPH0ZTu30exyfR6I1yEDDL1CETi68t9+LMsYMrMhrDGGtS7pxuGfKB3K8
         1Tu+TzL8CJ26mZNzxxl7ilZZzHDJ5iLlwv2vzwX6tQC5lYQ+lcylvGksPuRGkeWs4Oyz
         /Ffihf9F6GFHQWTsaRhIEHgOz2Un48Ny+M4QD3OpJHredAsDQNnPn4gwPd3pdY0uzs4H
         N99JROaY2afOSqYgxv8HeqOP1D6Y9P6P3L9mGB2VEv1qDAP3vHh4G1kgNZah+yZs8ZGI
         ZS6oUoAIHTc2RUj96ReUysIRz9rXigAv82ubINIKECqnRLLT3hIb47gEzgdpumoaCzoy
         osfA==
X-Forwarded-Encrypted: i=1; AJvYcCX/Vv4nUAx0wBdETQq7pvO2x4n4oO0AzbEwxhUsK4FCV+X+d6s3oqXpH6roHXBMeMiLca8E9i19vx4clQg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5kvwQv8OEoBO8Mr19UbY5zxyQW3iFoIUNbUCb+qAhOiIArPk
	saExDYpWSIjLeo53RpeCJE19+ryyjmG87bYG35T6QY2yTdMWfRQvJzxt
X-Gm-Gg: ASbGncuWpZ1tpx++hWrINmuy7iYAQesvkuj/ggRBk9YpEywt5j/y9xRcBtiB2+i2C//
	LY3ZqUw4/NufgasWDl4NxsH5Ris1yt2/H4G0BKJcOustrRovsAZ1iuhnYI5IK/HiaFy/5q0k+Vp
	llgaLGOm5D/0JWRJrOQZOoil3wYCEkMRWnVyHfb4J6XIu33fQHda6PlP9tOIJvO4JjZ6KxhqCMS
	SB3Zll8oYXbiT+1BNJiN58zkEOM4vY4kmahQJXg8vRMxlL+woWZJF386K1E7+/JPDNCrlEuvT62
	FO+1T8nUbmW9isdiCqtBgGGw5siAodg59k7QHDL2/FHbDN+WikbLIuBVY+zTLAXhnPjMo8C6fp1
	joTlRq1JoeO3c
X-Google-Smtp-Source: AGHT+IEERT7iogdm51K8PLVxGdGK7NUkoPv0Da4E3sTjfBoYrWSCEnt1emeA/S8OJ4YyvhG50pGJxA==
X-Received: by 2002:a17:906:d54b:b0:af9:2668:4c36 with SMTP id a640c23a62f3a-af9c6518c38mr1431441166b.48.1754936023337;
        Mon, 11 Aug 2025 11:13:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:2::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8fe77cfsm18800092a12.42.2025.08.11.11.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:13:42 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 Aug 2025 11:13:28 -0700
Subject: [PATCH net-next v4 4/4] netconsole: use netpoll_parse_ip_addr in
 local_ip_store
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-netconsole_ref-v4-4-9c510d8713a2@debian.org>
References: <20250811-netconsole_ref-v4-0-9c510d8713a2@debian.org>
In-Reply-To: <20250811-netconsole_ref-v4-0-9c510d8713a2@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=leitao@debian.org;
 h=from:subject:message-id; bh=TYuHsvzHVOr+9PvIQi9gEgWUd6z1ZxvE9ypUBBhqWyc=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBomjLQS8H8diuPCc3a5zukFoK3EhBNB3Wu3DSpE
 kvXJWj2BvuJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaJoy0AAKCRA1o5Of/Hh3
 bS/SD/9gACcc5OGWQ9svWr+LUgWerkwdaIJVa2OueKkyZtZZpD+JCkNNJNlBOMpFxZnRJVJJ+Q0
 izDrfwZTSekf3RtwDLoJdU/HujFA+Tw7oFt6QqCR3ArjRw60nC9oIDOi5ZmZVukbpnEKUxVhSUp
 AFWoJcMgGclvqVS9Iq0Eru/NEy2J7tTrjXVXIxHDeZO0h6PrRa5JG6aTSuFvWwBvsFT7J6TfSQH
 6O89sUVXfaC3gmMgL6ezpgknZa1C2C+7miYf0HoCK/WxCiVzijgxV3rT+tBiygIjUw/ALtPmqvE
 a82Be2W6mo1q7/DuqChitkQ30UM/YvwVgH7KDoMIpuJtoRswQKwkTE9+9sLHu/2sS8rZzqIhtaj
 LzPoxwjEaCQ2WH/VCxIiXk3ZyNqj0+dqikkXChF8Qvc3j97/TiheLKwvKOIp0GkCXu+9zfm2X3t
 70N7vSMH+cRkDz0167GBfhIpT++3RVx/qU8IFCtgDFFwuWmt0iOl4cLmAc3XjLa1xb3USc5yXq2
 /uUTLyMjLPzVwJD0h9hQTxqSpcWxluygd5sFm6wz68mvGpqtpozYYQ3WfWuDT2hiUfqIg6PI+gR
 zAvl6PhPX17MUkOUGumAOO8jSZiQq535RUaA8S0ZX8u9XF5sCNw18CX31RMmV5b7WHnC7MZ72D8
 3maX/RkZrwqKwTA==
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
index a9b30b5891d78..194570443493b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -782,6 +782,7 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
+	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -790,23 +791,10 @@ static ssize_t remote_ip_store(struct config_item *item, const char *buf,
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
2.47.3


