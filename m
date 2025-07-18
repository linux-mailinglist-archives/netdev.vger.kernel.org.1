Return-Path: <netdev+bounces-208144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 913EAB0A397
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:53:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 207F31C25890
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 11:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCA442DC347;
	Fri, 18 Jul 2025 11:52:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB12DAFD2;
	Fri, 18 Jul 2025 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839542; cv=none; b=Bax1cw3z9BJkMhC1eEr6LNqHT4pCNnBSeeOeCb/d9aCTIL2i81gVHv6BON2CehAW9NrRZRxYJt5wFAvnO7GKuCGC6ckl5hwCM1tPb6vXTRslhoV51HU/yuEzocRGWjoF/JoY0xwa5m+NS8a7Y2X5zHBHI8KUD3Pf0fUyrnHZw+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839542; c=relaxed/simple;
	bh=tkg2bjgERJF800sMkU9QziteGVriZ7Ij2VSeuqHCCWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lBQ6hbtS/6FOsX+HgzSJkycWIgtdYue7D/x8STXnsZESKCWsgllZy7GmOb+7cooQiFxW07+BoJ4wb9jPchzUOqXpQekyPN6w8ZXi+cta3BBPb2UZa/hSxmi8hbc6SjghFxK0FK9aoHUnMya3LpximZGXGho1XLu8xMeySOcF8+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-adfb562266cso330219766b.0;
        Fri, 18 Jul 2025 04:52:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752839539; x=1753444339;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NbafC6s8Z9+DMd3ZcAxF/btYBQ3dbcafQYtJ1Hk3lNk=;
        b=kW80RVDvWotO22oH2Il39akFmx4HGr1mUT1RnJEPJaYkTMNpIBygeAA1xvr/vcQyli
         8JWuFXY9ogIfr3tbneWeRfx/boFVxEvc3YvPlp1lIAkK91x0jaZKLha4hmMz6LG4Wuxo
         P3u9h3X4xhN/z6uFWeo+seEhz4QfxTfKZY9e5eEwqIGVT0Q4zjFbGsNunJ3eODUNxjUO
         XcnDCjk6tebBjLu28/9MgT70yzx1CNbqSU2PQZGSurcHMGn+9GII6Vz+LCxYVnXaK8u6
         FILGLI4ymGukBnUpLS7/29XyL1jCXXjBsccit0DXvbLj16/T2iuuJcYy+uBW8+fdOrtm
         K3kA==
X-Forwarded-Encrypted: i=1; AJvYcCUXUiYrEs32mpMp8QwmSMeggdqkuVbMUn7dYftI+me13ltwNwluiQ0HBPtAJRgy0Wk7ccK3p7jo6ZBW8HQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI1szj1vHMsIp7eqHYaNbH5wgA/TBNUmXERSOaiYAy7/m/f/T6
	E/quwOVHRxaAITm0g8rDXFgqFz9Fdzl3v/BlxzwjfnMimylsfRvLBm+l
X-Gm-Gg: ASbGncvkAf0NCedFT66PmK4P+UtZEKqKLqJCO4P6vCAqCV9CJ+vMau5uOaKF+UxpSqw
	KyHtbZW7VILvVN7DaeBwnUYZQ7P1DHDyRoO54IqI9R9Z/AXDCqlDTShywEOkuyA+ePnMi6zm7jw
	IyHNpSv+qxJcNHjIEeJhEQS4m7XLwk5D1g3OtNJxl4IaHMuxxmUSxKUQNq/0d24G5VQfFg2d5ZE
	Ka7aDYMc4Bmuk6IgC7GK8H0QUHx6uRj/VVWw6J84Dy/WZTN1EARIPmjfYlCZw6T7+fsi9vsQM30
	FfeVMYT8CtH4IPlVKuu/jzZWEEPZib1ZTiqRM6db4EPhymXSOem8glmv4khnRbvi09NM4VTeCby
	gX7eYrebjcQ==
X-Google-Smtp-Source: AGHT+IFxioSGKRKyLPLM3eJBMDnbARqUZZqXwsaH9+NjjhUb+EInhQjMExIxaMaHRLT5C1NdXlkk3w==
X-Received: by 2002:a17:907:d2d2:b0:ae0:abec:dc13 with SMTP id a640c23a62f3a-ae9c9b59e13mr1050417866b.53.1752839539203;
        Fri, 18 Jul 2025 04:52:19 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d8fcasm108745366b.68.2025.07.18.04.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 04:52:18 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Fri, 18 Jul 2025 04:52:04 -0700
Subject: [PATCH net-next 4/5] netconsole: use netpoll_parse_ip_addr in
 local_ip_store
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-netconsole_ref-v1-4-86ef253b7a7a@debian.org>
References: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
In-Reply-To: <20250718-netconsole_ref-v1-0-86ef253b7a7a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1635; i=leitao@debian.org;
 h=from:subject:message-id; bh=tkg2bjgERJF800sMkU9QziteGVriZ7Ij2VSeuqHCCWs=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBoejVqqvvb1pfYo8JK+NWLmQxzzDEBTt0OQnPh9
 OpuEiPtn8CJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaHo1agAKCRA1o5Of/Hh3
 bSTlEACL6NOxhdD3SgmYzkrd6+VAQD4Y28EcUKx0nQp6IxBo+mWVq5jv/bQO1+f52QrJSgYf4tm
 wnLUgrLekw9NytjBSuqOXxbLzK8uapPER6hY6uMLVWhQyxqAVus5YB4DHASgAEtac8yYOTmV/OC
 PCYwW2jQXxpcTSsvWj9jN4Fu+X7Ip3TwhtOhJU7B4GIP9OHudiVb7p2wjkR8rNawz9A+8fGamdP
 gXmPnS8uZ8DUsfPgoukUin5SKYVUwYW4D0gjH9gFV9ZObDpE8BpWeLBFpJUc9dZzM7h7OCu9IPw
 lc7KVLtpPuMBz+XsiREwXVu3QYyXHcQdUlz3OKy89osMxy6HdTKfDc6u997xNBkZdeTbtBdhx40
 8HJp/wa9VbyEx/fHfJkje2g2afWFFWPEKyDQwNn+FuiNvlSaH+O2x5Skf4pJgahfzKTGQv02/nf
 15YWECYiGu6EEh6M4FuW34jotKncGIZZeC6he/sxc2L8KlfNIRVDQSTIhuTZDRocfFAb1WufLQj
 HhOPve2HenvXgLnHGY6CUHG5T0mtYGbqSRCtJ+pctXnMrUZU6dXt/CWQZLUfO7En3i6f55hZYyj
 QW5Dk8ApX6pEDyOtlq7Vd6/pILYrXm/acHL1dsGFWVF6rE2SlWXiSn+e4r2IWeVTuQD04smeNVB
 wR3yChXeBwAdijw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace manual IP address parsing with a call to netpoll_parse_ip_addr
in local_ip_store(), simplifying the code and reducing the chance of
errors.

Also, remove the pr_err() if the user enters an invalid value in
configfs entries. pr_err() is not the best way to alert user that the
configuration is invalid.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 7ea265752e021..3044349c5fe37 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -751,6 +751,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
+	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -759,23 +760,10 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 		goto out_unlock;
 	}
 
-	if (strnchr(buf, count, ':')) {
-		const char *end;
-
-		if (in6_pton(buf, count, nt->np.local_ip.in6.s6_addr, -1, &end) > 0) {
-			if (*end && *end != '\n') {
-				pr_err("invalid IPv6 address at: <%c>\n", *end);
-				goto out_unlock;
-			}
-			nt->np.ipv6 = true;
-		} else
-			goto out_unlock;
-	} else {
-		if (!nt->np.ipv6)
-			nt->np.local_ip.ip = in_aton(buf);
-		else
-			goto out_unlock;
-	}
+	ipv6 = netpoll_parse_ip_addr(buf, &nt->np.local_ip);
+	if (ipv6 == -1)
+		goto out_unlock;
+	nt->np.ipv6 = ipv6;
 
 	ret = strnlen(buf, count);
 out_unlock:

-- 
2.47.1


