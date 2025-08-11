Return-Path: <netdev+bounces-212570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9564B213F3
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 20:14:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A2EC18879FF
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9476D2E11C5;
	Mon, 11 Aug 2025 18:13:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88382E06D2;
	Mon, 11 Aug 2025 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936025; cv=none; b=iOTzk1ZS1p9ysSMmSLzNy25jPcGu+xBCMe/dN8CNtFXAjX8mEXZAMNdEtyan6VFINiIpE9Y+KrCLJTSsYBKE50OwuGCmAykmQGjkXaqPX6acgXotJmv+hp1uogKRNcTXqRNOmHvt/UjW5YZfu3xL1ovkhEdZyQxtTTTwDriWe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936025; c=relaxed/simple;
	bh=2RxZv02sO2aOx2TZEIBRAFNt+IxFx4gGxT8mRrKTvYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SudnaZPM1cjYmBtVmw18OlgOFkBsDfR8/2cR5S3b0XrF6H6iGs1suQrxvhSAkO0aj5Eof6z6So+evH/5+AJLKjz4zTs9UVsVLAHqEWVBWKyI5+DIJjErKfK/Aqw8moVm9ytPkye23vpcPsDbx3PgjvRi1PixCJwHWhPx3NU1qd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-af9842df867so828001666b.1;
        Mon, 11 Aug 2025 11:13:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754936022; x=1755540822;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ODOgtGh0+BpM6WIduaOUCWVOWgR49or9dGLz4zuRqs=;
        b=U7A2kzdqISO3EDgreU9zSuhPNftwe6Vry4w8sfzM70F/g4l8hhwIlLxOks7SnT+++n
         xxS1+uP7d8NA9+fAXCmV5KjxMrgcVYioCAuwQEs3iHdJeowgdQMWvqAhezHNYtJXIvQZ
         at3KGbMBbyoez9Z6XWUQLdP3UrjggDPUmA4EGqAsKEFgas56UuzorOQSoxXjwuP6aWGV
         mJt+7/jVc3DXfM40BpuAoECI7Wz5UCpFw9/K2BLJePxuUH4idY9XXPRl7civzvBkaLPl
         8pdSWMsEf37L9ypACVb8/Z0/GXnEg49bWQzxGCRa5esd/DFNfNyeAQn4vGkw09LfFM9j
         dQFw==
X-Forwarded-Encrypted: i=1; AJvYcCVmeEgAA/0Xr/xlPviY4BMwkR4ZIYTh8/aMkzyH0CR34a7TPtdGpN3yXbA3Gh9Q1CDfBdmv/DbWAT2lVOY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yymv8FMx16dlYaYW+Grp+Z+ut/wKcGIedKZt5uJESVfIqXj1Uil
	UiYAV8DcBIpTSHhfnaEV6YjZpv4IMcqZBS99NsEdudGK1eFz5EevFn2x
X-Gm-Gg: ASbGncvDQ6xoNB8icXSyrnCCzgjbgqlRQGxT4AyjB8NK2B1jYeB1MC3ob+PvitjtMmO
	46h85NNjJ8TOI22NMgRxyaWGZryzjNuUasUaQzHcm3yivyUKCBuJYjYRnNn4iuyNeClFcF9tgno
	2BRtWER0biMH9xSQY4H0W/dNY0t6AYXXMCgHM2NwOB2xwapsgQEfQvm9I1aneoHfNl3iAEZwHRD
	X/YZdJKDTbckreIA9KOJcQz2iIuE5+AGb0jZa2kYMtvo02JzBmB0tl27jMGFVH/nObZiKAJ8LW8
	FTqEuKS1dEhCBNKFq4PBZJQDAvzjiiE4cLxP7hVGlKAwROQi/5DXbRBP0T8QfMYLCGw6x8vsgKY
	HeysguBd+KnlUkCMsVyoTiiTvHE3T5lyM1A==
X-Google-Smtp-Source: AGHT+IE73uPsFKgQFOuk2I/rTanhn0eQF/dfkFMZhR6zi+/4PB8Bhp3BOw58UntXkTAaU4cwAZneiw==
X-Received: by 2002:a17:907:7b8c:b0:ae3:7255:ba53 with SMTP id a640c23a62f3a-afa1e14e79dmr39503966b.53.1754936021864;
        Mon, 11 Aug 2025 11:13:41 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a1e8332sm2062371366b.75.2025.08.11.11.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:13:41 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 11 Aug 2025 11:13:27 -0700
Subject: [PATCH net-next v4 3/4] netconsole: use netpoll_parse_ip_addr in
 local_ip_store
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-netconsole_ref-v4-3-9c510d8713a2@debian.org>
References: <20250811-netconsole_ref-v4-0-9c510d8713a2@debian.org>
In-Reply-To: <20250811-netconsole_ref-v4-0-9c510d8713a2@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1683; i=leitao@debian.org;
 h=from:subject:message-id; bh=2RxZv02sO2aOx2TZEIBRAFNt+IxFx4gGxT8mRrKTvYw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBomjLQwyx8GgWXnKc1005KHfxs8GKKeQrBQ0GBe
 X94AXjvi8eJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaJoy0AAKCRA1o5Of/Hh3
 bQ0yEACbi/dhp08sUuJyhCvSTOC9t7TPjeV8RlxQhFsPChVxXc6JfYPkXaRxN5nUcLYcpSlFsZ1
 x9OcC+t7ZEXcTEOGXRROTyUh1P4020RZ6F1RKUl+cVuabMg8JWXhWEwJIkrFZHkpFQL1k/RzQ35
 ufvyTdmGSl5irenbcCXR4lml+wndj5YXG25C0Nm7z3h+9ZsFnEjShvLmnLsG9Xbn8skM8pwdzKY
 ToZZzPer7eIMGen3VkIZrputNEqdb0P0peqJ0oc7POxU7jz5sD3dR2n98oZLv6+7nmHUyVTkROX
 R+xhvOGS4nJnQZHrZQtR0Lm+KHVyBMFfQziGdBTOiIgvBn1g0DS3j1S0dkrxYD+33WhwHBiKiNE
 xs+2D1ctjqYnUAY1k7rq51YjFee4R5FmuXN/ueGl7nz4HNSSMzJw62axqgKY0IJN/GcDAGec757
 2zhjycLhz0yZeVhstP6BBWlTsVdZeEt3T7J5zKZzsyoci94XLdSNumYP6vYEaj5LZoHyicPrnow
 o0COJIahHIJcMrvo976E1OrQeJKFtLiP9NtviwNDW9Ym/vjimW1hC5cngEl2FjcdAZm+QQmoElP
 0BJfV988L7GpV+9w3z6hzRZnw249SarlvEqR4WwPWjByFllVDh7F6TKlTIR32UsDEsogPREHlbB
 sTZBj0hndHks7hw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Replace manual IP address parsing with a call to netpoll_parse_ip_addr
in local_ip_store(), simplifying the code and reducing the chance of
errors.

Also, remove the pr_err() if the user enters an invalid value in
configfs entries. pr_err() is not the best way to alert user that the
configuration is invalid.

Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/netconsole.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 2919522d963e2..a9b30b5891d78 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -757,6 +757,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
 {
 	struct netconsole_target *nt = to_target(item);
 	ssize_t ret = -EINVAL;
+	int ipv6;
 
 	mutex_lock(&dynamic_netconsole_mutex);
 	if (nt->enabled) {
@@ -765,23 +766,10 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
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
+	nt->np.ipv6 = !!ipv6;
 
 	ret = strnlen(buf, count);
 out_unlock:

-- 
2.47.3


