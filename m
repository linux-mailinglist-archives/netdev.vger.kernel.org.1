Return-Path: <netdev+bounces-199521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84ABAAE095C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 16:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5105A7E5B
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 14:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C742422688B;
	Thu, 19 Jun 2025 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibd/sC9b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35725226520;
	Thu, 19 Jun 2025 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344907; cv=none; b=REvLOCgFBn9sHBW7Fjcz4aigLczEg1by9Hi7EycpNYnWpbvXqDlNzUGzHoAcrvYE5IhWxLTHwogAnR32KKqAqiVtSqNrRHXJvhUJdyryhULIKYLldiEo26lEg1WyxZGmwWpOS6P7BVIP4NWlgqVi+fb369+BVoGVDuKxSiCTg/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344907; c=relaxed/simple;
	bh=2kvm4JxzYNtTLaRaIThJydIL+hEEYReBidtatR2KnlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dFu1ejR7vNbhDnvbZLlFBF3awSl2V7TnRdroiMhvORjZ0Bep+exzL7UHITCLeaiCR5opJX1CPrNaMW/MWuFFyYzmbz1xYLuULQOtAKheagrwcjy5Z5K5//4CZ8hrYsetK2A1KDKOPJPWOAyKT07t66g4ZMjyG7yrRjNn+bs46Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibd/sC9b; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-3138e64b42aso928227a91.0;
        Thu, 19 Jun 2025 07:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750344905; x=1750949705; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fCc8wvcGt1Bzj1+8h/7it2Sg3YOCUwTqtEA7c0OIsck=;
        b=ibd/sC9bRA1p/EdOC6dlUcfd2PHh5luotWfqXmQUIEnFuKXWtAAHmyNiztKpJJ4XRZ
         Z4cXWXiK2jqUHLL5fNC6uRafVLSviIVPjUY07rlD8cpD0T7om5btkty/4ZxwBp+QJpSk
         Pyp3zE8pmHfCoQ309MwaUIKYexMHGkvlJFf5NXx40zd1Xf1Fxz703oY4Vpd1nHxXLUam
         1I358DzqBSYwAHnwIo4MqwnUY12I6UkTTCc6fw4+ga+TAEGCICRJySA1ltp6M5kp5b+c
         lA9C7l0S2pCnDJ4/z9SaDamiu9s/eNKJTzPS8nm+qs1fEN39EbmRsTWrHW/+rQp9L0YI
         x19A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344905; x=1750949705;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fCc8wvcGt1Bzj1+8h/7it2Sg3YOCUwTqtEA7c0OIsck=;
        b=FJye4lKbwk3SxFSpu02YokMOqxWmbYAEU0OcAIOOx+fpkex3upeEfgpfLQ9yTswh0M
         qxG2y5tlXBtzVL+5lkC1Do/kWTFHJoXj6yW8BCfH/d5Ntu4PypTZGI6IUfhAipsgXjSj
         08gynMbnxtLt7gkaNA+HKA2BAA/tu8m5Y4Ba/QxYXFNztaJ5hQ3lpEaDc47ErYnfZbPY
         0/VdpmlM59zxS1ghswubhpdQs9iyt2gj2azTvxjulewXBZ1jEPgGwxxME7+t52UL01HH
         t1SSZouCMBFmRe7HtVhcNRlEdg2IGkAfjTj3batBx9pRLKUn8vu/RFPI1iwrYuDV9GpL
         nTGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbnkVOJQ1BX2ubgzvqQ/j8vzTuNyYDC7ZS2WEzH79bCSsYdeph3vcMsK3uI0jM+K6gg7/OnPcC@vger.kernel.org, AJvYcCWWrPRxDuN+eL4flzSByt7WXvAymdyxd/mIUgRBktpychE9tTnKKuAoyxRI3KnGA74J7vZcWjGhqfuCoxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFFSP2duU+VpkWXE7i4ltc9TRtxm8fCgcJ3lJUknoOjZ9U3cAM
	7HNHFL9gGJyFBJgk98ENp4jvW5kp9jBuW3ZbrKBn8dDnX8EzRDEwYnwk
X-Gm-Gg: ASbGnctEdzat7tB2ppfx2wBdsGx3ZXiqe38a07yoPCt2VfjjFkI8CCeq+6LXMsGS0B7
	7wmPpP4jESrFbcOcumijIc15RzCUfK8sIvFu8ciYppzA12e6R+iCGxt65ZOYqA+cbEr+lRXIafI
	ddU8amom3AMgGC85AWx8hOOq7EbR5xEe9inKRIfueDaILPdRUoymBz0kSlXYZE5V/Q7p+lQn6rf
	jRy+vqcOUaLWN7TlsA8ne5aCAr7ztp3LoyeDHp7Rb32rIdy8giutAemgYldSbc7mXMXWjVjsBiS
	Kbe/WfaYfJM/Q2HXT7lYMKk8RgvcywUbm2zGo/jd7f00TEsPQ3wRc/QECL0YQvqcxJao1IU4
X-Google-Smtp-Source: AGHT+IHFRai+eXLqEsx2ey+Wqt2gXo8kOT6meJ0aM2dbnVCHxPE9uC9Md/iQOR7yx7gT07xj188dPw==
X-Received: by 2002:a17:90b:2dcc:b0:311:9c1f:8516 with SMTP id 98e67ed59e1d1-313f1c3fb20mr36050743a91.15.1750344905433;
        Thu, 19 Jun 2025 07:55:05 -0700 (PDT)
Received: from localhost ([216.228.127.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a24cac2sm2506610a91.27.2025.06.19.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:04 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: "Yury Norov [NVIDIA]" <yury.norov@gmail.com>
Subject: [PATCH v2] wireguard: queueing: simplify wg_cpumask_next_online()
Date: Thu, 19 Jun 2025 10:54:59 -0400
Message-ID: <20250619145501.351951-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yury Norov [NVIDIA] <yury.norov@gmail.com>

wg_cpumask_choose_online() opencodes cpumask_nth(). Use it and make the
function significantly simpler. While there, fix opencoded cpu_online()
too.

Signed-off-by: Yury Norov [NVIDIA] <yury.norov@gmail.com>
---
v1: https://lore.kernel.org/all/20250604233656.41896-1-yury.norov@gmail.com/
v2:
 - fix 'cpu' undeclared;
 - change subject (Jason);
 - keep the original function structure (Jason);

 drivers/net/wireguard/queueing.h | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireguard/queueing.h b/drivers/net/wireguard/queueing.h
index 7eb76724b3ed..56314f98b6ba 100644
--- a/drivers/net/wireguard/queueing.h
+++ b/drivers/net/wireguard/queueing.h
@@ -104,16 +104,11 @@ static inline void wg_reset_packet(struct sk_buff *skb, bool encapsulating)
 
 static inline int wg_cpumask_choose_online(int *stored_cpu, unsigned int id)
 {
-	unsigned int cpu = *stored_cpu, cpu_index, i;
+	unsigned int cpu = *stored_cpu;
+
+	if (unlikely(cpu >= nr_cpu_ids || !cpu_online(cpu)))
+		cpu = *stored_cpu = cpumask_nth(id % num_online_cpus(), cpu_online_mask);
 
-	if (unlikely(cpu >= nr_cpu_ids ||
-		     !cpumask_test_cpu(cpu, cpu_online_mask))) {
-		cpu_index = id % cpumask_weight(cpu_online_mask);
-		cpu = cpumask_first(cpu_online_mask);
-		for (i = 0; i < cpu_index; ++i)
-			cpu = cpumask_next(cpu, cpu_online_mask);
-		*stored_cpu = cpu;
-	}
 	return cpu;
 }
 
-- 
2.43.0


