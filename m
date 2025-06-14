Return-Path: <netdev+bounces-197727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B96B3AD9B26
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D71E18963B7
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C79D2147E6;
	Sat, 14 Jun 2025 08:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLiKTGcf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5653221146C;
	Sat, 14 Jun 2025 08:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888021; cv=none; b=ZKq1zfpAKODEimaz8ne4xWsZP2PDwP0jhV0c9Lax2LAS/zDh3U0sXYNd/qe+vS8+ssilwA/OYvePOnHGRYpHjJ0br/N3ewiI0LteTCuHh/59bDCWidhJsth28h2G0k1lnnlLKvMmFJG3LBRRFHwE7hYBvz6R7Q7+zQox3OKBCxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888021; c=relaxed/simple;
	bh=lrwz9lTK/Ht3jtPIaHRJybrlxxMJIckE6OX0IhWzWQM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbQZk7HGphUAH2zpkDG+Jr/r7BynSWZ0TVpqg4GhI6w/Q/Z4szVrGt2iDNu0qaxRxZq39p38gq1lQRQNTbucbWYDfrX9zDHm73FDI9ipQgSObEMAUltTs2RR5xlNNX9c6X7vcKSfN80vP5nfp42TSqsSXN2a908VGPW7MTgPDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLiKTGcf; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-441ab63a415so31891705e9.3;
        Sat, 14 Jun 2025 01:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888017; x=1750492817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KA3iDOrnGZWK9D0DaouVhPmzdiHQRy0P+xXagLHVJVU=;
        b=LLiKTGcf5mAAxoqpPe1pDo0fCUe9WhAo12dSIuT8XVEbCKa/K2g5h0RFjuAoLvBWr4
         3wcAIWmFnIB91lpMTDqIYYxHpDfzfAdREjKGJV8pv0bHtVDZAHsvstJg4WQCjj5lOB00
         ChWMoC3BuuGcOlelMrrShJ7kQa+Fy3OyMokoBHdSRFVUWEG0Ux2iKg1ME+OowJcNcN8j
         CZBfTyHSdQPDeKnnLbBT1wA5bNjYKbdcjEKqzWLEh7XFn4Hx+6UXh+/1XDqLfYFZgCKd
         nqxJjwrWZEfyMmyLuJAHyWymTXZo29c+x5pAIXAxqoqSCOBF59yNu8LQ36Qb/9xz/d6b
         Ojzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888017; x=1750492817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KA3iDOrnGZWK9D0DaouVhPmzdiHQRy0P+xXagLHVJVU=;
        b=Klx8FhlVHDtcfKtKvqR43scOegKuzMACW6a8BZjGoHNlRsknRPbMZOzkkuSBMtCOfV
         9XCkrGcvxvKIVUoNjON60rQiOz/Y/I6tlhRNcs42Mk8mi0oTzc/wav5Fqygpk1Zr9FiH
         970RZjZHhS2gV46bEiZi7acIjw6ga/YJDWuryZSM4TDAXZvo0JTmyMv35DN2loufbPnq
         FMI0HYFesk9E/E72i/YyrVyq6EQK6Zf63BfPvy4X6nC+TL0cp9EH5Ij4/6W6WeHOBf+O
         nFJm27veb+9Qk0xiL60OhB3s0mbSsU9LJLnZ9XQ/jWILyq1MxXM1luc7epIKqq2KUvwl
         Ac/w==
X-Forwarded-Encrypted: i=1; AJvYcCUJFyqdgJH43Fq+fCfg4TVdaC7yh4tX8r51qPRtdUc1uYrrSDsAsVxuXZtn2AXCP9YXl/L/+gynD5kLnaw=@vger.kernel.org, AJvYcCWvOF6N6MCZ0nawaqucN7a7Si7Zfn6Awe0sTq/kD/XuWx/c4PJNfTWVEOBCfWXrG/HrILbbVP8b@vger.kernel.org
X-Gm-Message-State: AOJu0YyFu5WmnDTY3qEOImp1aJF7ZCW68gh63Eo3RgnXzWnAiuqQi8mq
	F+qCQT0DYIYxHFma2vccLC7G6XENzs18uUXkvohsrBFYitc0a4YIYqFf
X-Gm-Gg: ASbGnctmVjHE+dBU1v/pqyfD+3b9lSqD4jv+Svc4q42ncgjyBeBjCD//nUz4GATCw7J
	V1MqfDx6jFDHCvNgqFBWrlZXtvp5FL3/BN0BEUG7if8IrUkU8qqyw0iewuCjRaFeROHQQFemEY4
	jfHQWHOYVEi+wghNCiOPaIrdFbCDaeNgOouuiZHlwKIIn3ckdUYGzom5h2pdxBWdtrTwzhEO6Op
	/V4BcIEuGHiL8e+C0DfWtuuSeWs7num33tsUfJDm0tOtqYwc1YcmORZPl7fyE/YzbjKbzivDy7W
	Hpy4bUOF/GnVUEjrHG+o3WCaiFVjNEDdjwiKXl/+XNb8dUR8Q2UoN847cooF57VQOhNjE+bpHoH
	v5icP1cqw2QKsu8HhBMtbM1m/ez4kBEjX37Uk3vmXGmAl02kdqfVkw/ng1+W8zEE=
X-Google-Smtp-Source: AGHT+IEdFI3H8dq9rgNIEMTS3HTAmaNM0vicdlz/k8EmGPOSO6C/0M9Dc6czVWZeGm5ExCYFStqfKQ==
X-Received: by 2002:a05:600c:8b65:b0:44b:eb56:1d45 with SMTP id 5b1f17b1804b1-4533ca6e6a8mr29372615e9.15.1749888017392;
        Sat, 14 Jun 2025 01:00:17 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:16 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v4 09/14] net: dsa: b53: prevent DIS_LEARNING access on BCM5325
Date: Sat, 14 Jun 2025 09:59:55 +0200
Message-Id: <20250614080000.1884236-10-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BCM5325 doesn't implement DIS_LEARNING register so we should avoid reading
or writing it.

Fixes: f9b3827ee66c ("net: dsa: b53: Support setting learning on port")
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

 v4: no changes

 v3: no changes

 v2: add changes proposed by Vladimir:
  - Disallow BR_LEARNING on b53_br_flags_pre() for BCM5325.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index c7c950127448..daf7c1906711 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -593,6 +593,9 @@ static void b53_port_set_learning(struct b53_device *dev, int port,
 {
 	u16 reg;
 
+	if (is5325(dev))
+		return;
+
 	b53_read16(dev, B53_CTRL_PAGE, B53_DIS_LEARNING, &reg);
 	if (learning)
 		reg &= ~BIT(port);
@@ -2243,7 +2246,13 @@ int b53_br_flags_pre(struct dsa_switch *ds, int port,
 		     struct switchdev_brport_flags flags,
 		     struct netlink_ext_ack *extack)
 {
-	if (flags.mask & ~(BR_FLOOD | BR_MCAST_FLOOD | BR_LEARNING))
+	struct b53_device *dev = ds->priv;
+	unsigned long mask = (BR_FLOOD | BR_MCAST_FLOOD);
+
+	if (!is5325(dev))
+		mask |= BR_LEARNING;
+
+	if (flags.mask & ~mask)
 		return -EINVAL;
 
 	return 0;
-- 
2.39.5


