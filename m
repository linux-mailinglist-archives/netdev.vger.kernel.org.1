Return-Path: <netdev+bounces-249819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE27D1E916
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 12:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6327830670B1
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 11:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6A0396D16;
	Wed, 14 Jan 2026 11:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UPbIsKw9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA008396D37
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 11:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768391388; cv=none; b=Mka2l4RUE5mDt/dtCf48UGZKdG8vABkyZ8OYAatgDXOTn5apnczUazbBzluwYN1Je1NpmZHs1lFc8ouXfV4LoZURqMC2Sc7JBaqXBoHIhaRUSMY4HRmdH/AKET/FOPQizLqJXkh0UENFlzgKMcOlgGWJVPtJADKhHUW7qZFfzFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768391388; c=relaxed/simple;
	bh=mHd5/FDiQ86yScP8/xKWBTcg+ow54G9KDtNwccSg1Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fi9VyNMwJTcKOkHoGeCQR+epLdOS7JSmG7cSfaYVfpsIDJyblL59VzqUeDsxWULz1anstezMwp4eBG5RZyYLKEGVIrPOdTNQavXDVCmuJ3K3kvr9W1vSGVVddIzHPf2NAJboPRBKJ3zGt9VSATGdrwDICUe5c0hjqsAja0amnoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UPbIsKw9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c227206e6dcso5512065a12.2
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 03:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768391386; x=1768996186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qykhmziqocBs83eOMsCXS+riegj3dQCRKqwsythsgqI=;
        b=UPbIsKw9rTGrJ0YchZMoe5YB2dExA6jg3yz2G6T3KOPpdUTSX2E9sGfj/qJWoPfdkB
         /14NyQ0ejiJfMQZm/pvMaxKeoeu6O+9C0codz1OJF9iCsx1cD4b4+7FstdYC16t+pQon
         vpasjHat4RoGVmqHeNwG/VuP1yrvwJbdamnP03I1E14RP4XpNuImMUv2ri17pJLwbm9X
         1vr0uobR0ORSTQwIMwGWbsl6Px6OZV2uimQLHKb6RWexwAFqjNq+MaP81yzNKw9YcwXr
         kNa1+t/tdEDB4hszdxaZqwP1j6k3FJO8NCmlnHrpLl3edwx2bdZ4MiG0g9q736ho8T7W
         8LdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768391386; x=1768996186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qykhmziqocBs83eOMsCXS+riegj3dQCRKqwsythsgqI=;
        b=XCO4+naqgHd4V3n8TG7+2ldKIuFIAZ0hq23Ure3Ny1LSRWSbr+f8rTgcrG1Id/rf8L
         m6Ph9ZWTJOoDtUEjK44XnOI/XC16CSC9erdSuxveAFRYwJrZ5cKTYPDQ3EjeDUb1UTfr
         6q1qSD5cFYkFURzRpBBj/c1pMRJqYeiS7MXv8WsDy1JPP5BTFRiaSiYO9aMBHRgs9rfM
         UKYlOCZ40N61SerVuI2I48qxC+z3mI2S3EUx1rwx3+XZb9Ogz88dYIUijG0DsidD/Toc
         0WhiiaMu8AoxXFGjhm05NIK82swwkKlRQzdcxnshFoHw34k6u+SX+WQ0RcDTI3iOzhUF
         H7iA==
X-Gm-Message-State: AOJu0YzxW+NIB7TzwyjkmqrUCEYS9QA4Rp4A0GynkAVBRF2ybzwlqcpT
	YoAGNd8CVuCkhVHj94GSFr9bEMTFHHCliJs89KebOPvZxi5fGLx0FX6wzQJLRA==
X-Gm-Gg: AY/fxX6dlFHZ3bKFMvnHRTUaCUMzrN9LdiUP/C0PNbq31sQdgnFAXz7M8NJ1IJbJ5Rf
	gpLS7RJe/Xj6iI/QJi1rRGb/b0S7yiEAwetKg6xpkY5D8+hIyM7xOVApn4pBW4ZVODsko5WK2ow
	7uNW3isxVFbo2yrzNUDSvzsnu4VtYNOVFi52g3C4q7JU+LUcrz52y62t0HBCQG9ciFTn4py/Thb
	7m0EdPUYdmPB4XVMktjw/HJgNBoIi53KRKSucUCzn4VTAM/w6VDE33cnnxjZFhvXme5k1J1HXbI
	JxHzGFMbL9WHFDdOVmJEyDnWVjmYyqM2yusOoP6FVxOmWWWfQUuepC5rOdCw1AtdcCRCyXtVLp6
	6rbXGbDb3CXRkz41dcTgbrJgQ+l9dHs7HRFy3q21bJbisa95ZboeR+fds0KrOdZtLnLmcTHsBal
	QN/EjNj5c8Civ2dRYAINreJm/IDTg2iSm3Gp8agj4bGrHAGtEpzEZWTg==
X-Received: by 2002:a05:6a20:3d0e:b0:35f:84c7:4031 with SMTP id adf61e73a8af0-38bed1f3939mr2523103637.55.1768391386021;
        Wed, 14 Jan 2026 03:49:46 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cbf28f678sm22632123a12.3.2026.01.14.03.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 03:49:45 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH net-next v5 1/2] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Wed, 14 Jan 2026 19:47:41 +0800
Message-ID: <20260114114745.213252-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114114745.213252-1-mmyangfl@gmail.com>
References: <20260114114745.213252-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reported by the following Smatch static checker warning:

  drivers/net/dsa/yt921x.c:702 yt921x_read_mib()
  warn: was expecting a 64 bit value instead of '(~0)'

Fixes: 186623f4aa72 ("net: dsa: yt921x: Add support for Motorcomm YT921x")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/netdev/aPsjYKQMzpY0nSXm@stanley.mountain/
Suggested-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 0b3df732c0d1..5e4e8093ba16 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -682,21 +682,22 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
 		u64 *valp = &((u64 *)mib)[i];
-		u64 val = *valp;
 		u32 val0;
-		u32 val1;
+		u64 val;
 
 		res = yt921x_reg_read(priv, reg, &val0);
 		if (res)
 			break;
 
 		if (desc->size <= 1) {
-			if (val < (u32)val)
-				/* overflow */
-				val += (u64)U32_MAX + 1;
-			val &= ~U32_MAX;
-			val |= val0;
+			u64 old_val = *valp;
+
+			val = (old_val & ~(u64)U32_MAX) | val0;
+			if (val < old_val)
+				val += 1ull << 32;
 		} else {
+			u32 val1;
+
 			res = yt921x_reg_read(priv, reg + 4, &val1);
 			if (res)
 				break;
-- 
2.51.0


