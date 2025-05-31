Return-Path: <netdev+bounces-194502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C596AC9A7F
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 12:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A371BA3532
	for <lists+netdev@lfdr.de>; Sat, 31 May 2025 10:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06F9D24167C;
	Sat, 31 May 2025 10:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2E846Cn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4982A23F405;
	Sat, 31 May 2025 10:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748686409; cv=none; b=aXswev9tVTF0uoYNGmR7WXeTcRCBnht+/sHomYSI9bnZLEe14zJ4z6GJfBMLNY9dYRTq2mof04XpruJyC1TT6GCznDPqA1tdJRapy5UCfhZV4KDEJu4ZFhBYsM71P1Qzi1WXqX/KVogXdquW/T6Y4cLmwT2VcUcl9laFoSZRyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748686409; c=relaxed/simple;
	bh=UpNy+T/jEeXU+1/iDHTBtU2p5viCTPkkNk3fmI9mJGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q+M7QC5ypCxXHCIxQQ4U04VN+8Vgy0dwZ8McCWykApu16BpYnJIzp7Z8oJjdTbc7R0kXjbLN4jNAW1tM1SuSp1JfvXMqOhMYobUsYxYI7IIRnr1L2un55aUnRN1Y1NeEgY3am0q33x/2Xv2/Cshy4VvWOUAV+oa5yxHNvQ8IUt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2E846Cn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4508287895dso21790455e9.1;
        Sat, 31 May 2025 03:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748686407; x=1749291207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/UR8qDTsnmdHS6jO91Tr00ab8YJ0mbEjDWTOADy+HJM=;
        b=N2E846CnP+xfAb1q9MHYWY/VdOlKwVJSq7TUYJIBXebcq+Tj6UrMOAvLBJDyRqx2Y9
         XwIxEbqsrZ8u7hrwr6/UtSJWHdnVjpX2bpRFwzU6TkvO/yHwH6SK31RYoctcDmgKkgfl
         BBjmqtCGRaBDTLaRmCQRjtZdH+mrAZaGr5msjoRfiSuQyRcKl6z6/3FHi3HWnf7Gb+fo
         HFoi6RNyOhETwv+96Gk7p02fDOKGmVfKM5cN9utl0P1YCh5XJsII2m4zCLFd91MBOf7w
         pCIVQecIXl9qMfOJDCnVgyGBSVldQ+qXrOYR5YcNNeu9MUMMeyYbZutBxx7pAUEO6y6o
         mAUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748686407; x=1749291207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/UR8qDTsnmdHS6jO91Tr00ab8YJ0mbEjDWTOADy+HJM=;
        b=hT36wL9L9E+ullw1lwJYax+YAPHLvtWrPW6J0HUgcSIyZZjwlsB7MkrSNJiTI0iRYZ
         3H/Hf3UCmdnFDO+ueuRjzJRooGE/Am00HVLEdw/oej+gY/qsasG7PjhPY4IOh4CySECz
         hh5UgYbE+S0PIjLfW++B+0G9EnFtvtsTVZRuDDCH7eyhqa5Nnfk3nPGuGB1dSD14HygB
         Mq76MXJdr4bKiLJfWRAp5sPdttP4QaoRT1Objzzt4a34jmcCryxiBKOLpZnAV8D7T9DL
         fM6b139huoEVBLu9emMG9NAQ5uwTr2Ab+Ztjq/U2OvpUIlwGgGFUPcV1yYda+lsR6mpu
         HQYg==
X-Forwarded-Encrypted: i=1; AJvYcCUvYIpxdWXHwjNzpoqzcFMK9zwxgMP5p62xVTZxDp2u1/6foDe5+EA4qdWrd3lFG0KfNcQCtPaw@vger.kernel.org, AJvYcCW+Mps6qb7/7x/Q8TspWSsJvSHdj8vhVvvsFqbVxD4qa2/CdYmNWMIJs2qen2ZGHdZDJTPHVsRUJzdWcqw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+TRjau3zQqNIbQJ/5S+YRkgMqh98GW2Hj5m4Fv/LTr+M+lOzS
	BI+XbeMFf/dA1Ze8O8nB78If05OKI5PLUXlgkJZBqCzisBszTAnLR8K+
X-Gm-Gg: ASbGnctiq6qyOuBUvR/dlaRyfz4pAkb7l+ooAV40vTT6Kze3BH8FGuBLwTlRTuhYD+O
	mn0DnfxYzEBgpfsHc1E3EPP91dIEJr00WFVGt6rpfIXk7YmyTmVGkNN7zhHEyYS7ZMu49W70oG6
	ssgtrickSY5l3+gU+/ybqmmGLiahTHwITn8pNR46isiS8jAf4QFw5qqHgnfaRfi5AOuy3H4A9aq
	xQ966kCSScICIvoiVHIBUfc5P5eEa0M7dfQ0hD8uGqbqEvRm1xK+1OwzPSV/66PIm54xU7sLXFD
	73gbgv5PR4QIOhAL5HiNMtBLKe+2JQhUxUjiwGQXq/8NTzQ0hRtMJK20PBbieuSRqJG70Cnh7D4
	ZpdTqsM/72gUm5XeEvZY8D2zO0QP+sDl6Pz2AVxQgn8dWIPKHicgS
X-Google-Smtp-Source: AGHT+IHu7dyYTJKj8oSLt/gG35ZMcoa2d/i2amrHpzYkdvrMMnM30Dnc/vOgmcQTBNRJdZD/kUDOXw==
X-Received: by 2002:adf:b356:0:b0:3a4:e238:6496 with SMTP id ffacd0b85a97d-3a4eedb8aabmr6875064f8f.18.1748686406581;
        Sat, 31 May 2025 03:13:26 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-1200-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1200::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450d8000d5dsm44500205e9.26.2025.05.31.03.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 May 2025 03:13:26 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [RFC PATCH 09/10] net: dsa: b53: fix b53_imp_vlan_setup for BCM5325
Date: Sat, 31 May 2025 12:13:07 +0200
Message-Id: <20250531101308.155757-10-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250531101308.155757-1-noltari@gmail.com>
References: <20250531101308.155757-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CPU port should be B53_CPU_PORT instead of B53_CPU_PORT_25 for
B53_PVLAN_PORT_MASK register.

Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index d5216ea2c984..802020eaea44 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -543,6 +543,10 @@ void b53_imp_vlan_setup(struct dsa_switch *ds, int cpu_port)
 	unsigned int i;
 	u16 pvlan;
 
+	/* BCM5325 CPU port is at 8 */
+	if ((is5325(dev) || is5365(dev)) && cpu_port == B53_CPU_PORT_25)
+		cpu_port = B53_CPU_PORT;
+
 	/* Enable the IMP port to be in the same VLAN as the other ports
 	 * on a per-port basis such that we only have Port i and IMP in
 	 * the same VLAN.
-- 
2.39.5


