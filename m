Return-Path: <netdev+bounces-208379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48255B0B2AD
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 00:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DCAD189CE13
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 22:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E840289E2D;
	Sat, 19 Jul 2025 22:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BdrLv/7q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81DF28983D;
	Sat, 19 Jul 2025 22:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752965096; cv=none; b=EcIL5ZSzrX4qbmTpilwBi8lMfqXBCVVvKLjDoEywYQ3bjwyH++Y4rpvRMUThD3OFN6T+5ppOetvc3UF6zINQw8yqbYRrIwSWNK2UKlpH3uYSOo4tA53BERxyUx8Vy7tDb/EKyVGVBrIgbH13GjdjV3CdlaRhWXdiqx+xFmYynYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752965096; c=relaxed/simple;
	bh=IMCeg5lW+pArBByKNkBkoyCvVvQDm4elIlrSGedsDbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B4XM+q68P/wgaP4jJRJWZwBYUGmGSnaA0pdX93bylh4a8/BVZrIbp+QZk4AbwxCCd8wd76WrepcPbrKe9XT7Oyyr+SN4nHIbXIbusKlu6YUSp5AMrG5S6hbcLlf4PGJPq5e6WtEI+l8vkDVjvxWheECEEgFAyr+qY/bR1FFW50s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BdrLv/7q; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-74ad4533ac5so2330603b3a.0;
        Sat, 19 Jul 2025 15:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752965094; x=1753569894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+iJGo+evc2L+FHv0RiQZvlWwxutqT5SwKMfAl/86uLw=;
        b=BdrLv/7qBlzhV3/zrnVk3GjQiNbRgcz2TbBUB9O+t3DieBqAc6bJMTYI5kcOD77Ox9
         HYlLl30CZBCigQsyhWBCWh3S0M4V59aMTrOqv+HOohQXDiTFjq7zkbLBjTwvGZ2Yiy+H
         VCZYmwi5FHHHZDH8xGwxsfCBuAaDuIy5SJpYPA/oSdOKsXhL7KEheeJwssWFdQGHeLPg
         h2332uDR0F1DlMIMjJrP7vAEBhz35YcsvCQ+rGIGb7Z4t3Jy4ECv9lxctVSiN0BzoVXM
         rvKoBf57hv3e/3rByCyJCkdJ5sW3wzK1Edg296iJHQXHfYGpqhOFvPFVPzjYxwAQjsKE
         3sgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752965094; x=1753569894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+iJGo+evc2L+FHv0RiQZvlWwxutqT5SwKMfAl/86uLw=;
        b=Rk87/8/gjunoBIC43UbuuhoTkq8oiAnhK5szh++49ZawLRscG7cPPyJRmeD/nmNXox
         LksO9X+pOPusJRMEYGPXVXZnWjp8Tq/GZ2TJolY0F/g6Y6By2e5QC3AX1epdhf07nc7A
         fyzGyFesTvmyCgPDoj2m+MU+7BtzHaf8+9+RppuP1xgkQ9hZOIzsAVguYRmtfZmhlJwu
         FYcqCvep1C5n3QWPHz1pQOZI1OTljEjNbiKCAWq6lXF80yu/Ltks9tqJDMK4yIwysvxn
         YoJk10pI3YyUD0DJro0U06TVwDbnnpiWWbxVwnwIVCLMhJuFl3mBf9PPSO11e/bI8ZQo
         irNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmaKRb5QaHDau/P7hQ8GbWHKXCuIzXyp1ocq9TNv035P53tgq+Qa24KAEThyHPcFFzb8W13D+ClD27h5E=@vger.kernel.org, AJvYcCV7mAewUPuEXQkptacC9tSXCt4zdd6DVIWBjM5b56u15W1GY5KuObdMomD5SPh4daJ9p3bYwSke@vger.kernel.org
X-Gm-Message-State: AOJu0YzfldWMczmyPXmWA5VQphqlkJqV1RYuiIFoqQ088/kCU7myZcdf
	6oyjt16MGCurUvllYv31Ey4lj7DmshUYEFsfk+qxFXZ8nWVZ4aH/JzzR
X-Gm-Gg: ASbGncvfHy73DURlZWMCbQPufrjC0uqUOxdgRwhjVxTTae4cmgTYTXJ2SyGiEOsKLOL
	RkFxrjVHb7GojfgId38flFMiIN/Q08xW+hj6Yb5uJIEdhUVL2GRgMrfmkjYhbEEfgB5NA1rsjgc
	GBQdTeqScdwpSdx45hsmwxzcz1l5rZ4MWssB7lvi/8JS168BzSAInpATiSsXGjW5ofnBS2JWuUD
	3/PwyT/kdWf81NZ8/In7aH6GDwhfyPC1IpFDiqHa2+tDaiCxsWv6fEeJyKI9rlGNN6lAlDujUOj
	V2t4ZaO45voisKSP0DOaMTX6gWOhZg9qQE/fD68iH3xyGHYmjbrj7IotAz50qj2ohNIf0/N3R5T
	jRYsKUaRkZs4q/dAtu1Tabg==
X-Google-Smtp-Source: AGHT+IHdQ4UpnsC/CBi3lvY5pcItF/kF9ghnPx0kUzR8vZ67JjhtSuWwPaLJenOiLXPhJpa6QYE/7g==
X-Received: by 2002:a05:6a21:32a1:b0:234:97af:40b9 with SMTP id adf61e73a8af0-2391a2d7d31mr14272124637.2.1752965094115;
        Sat, 19 Jul 2025 15:44:54 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b3f2ffa6351sm3057193a12.60.2025.07.19.15.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jul 2025 15:44:53 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 2/2] wireguard: queueing: always return valid online CPU in wg_cpumask_choose_online()
Date: Sat, 19 Jul 2025 18:44:43 -0400
Message-ID: <20250719224444.411074-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250719224444.411074-1-yury.norov@gmail.com>
References: <20250719224444.411074-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov (NVIDIA) <yury.norov@gmail.com>

The function gets number of online CPUS, and uses it to search for
Nth cpu in cpu_online_mask.

If id == num_online_cpus() - 1, and one CPU gets offlined between
calling num_online_cpus() -> cpumask_nth(), there's a chance for
cpumask_nth() to find nothing and return >= nr_cpu_ids.

The caller code in __queue_work() tries to avoid that by checking the
returned CPU against WORK_CPU_UNBOUND, which is NR_CPUS. It's not the
same as '>= nr_cpu_ids'. On a typical Ubuntu desktop, NR_CPUS is 8192,
while nr_cpu_ids is the actual number of possible CPUs, say 8.

The non-existing cpu may later be passed to rcu_dereference() and
corrupt the logic. Fix it by switching from 'if' to 'while'.

Suggested-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/net/wireguard/queueing.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 56314f98b6ba..79b6d70de236 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -106,7 +106,7 @@ static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
 {
 	unsigned int cpu = *stored_cpu;
 
-	if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
+	while (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
 		cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);
 
 	return cpu;
-- 
2.43.0


