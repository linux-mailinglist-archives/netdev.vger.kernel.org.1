Return-Path: <netdev+bounces-250772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6339BD39219
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE4FB300ED81
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3F212B0A;
	Sun, 18 Jan 2026 01:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1F6wLHt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FECD212542
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768700390; cv=none; b=S3el/bC56+eUGEKwk3dMHau/gptRdzF+sH+DzmpvKV/RPB2WioEgKfEJUUKOGCk+ykIYVSVmqOyReZWSjtU/weOUKnV043TpWpsLOpaR83vcs0VdpFn/DRNVJIX6Hkvsno2qPLYdagxGBlK4YE4ycx89TeQ1vKNRoVuYHwzSa2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768700390; c=relaxed/simple;
	bh=mHd5/FDiQ86yScP8/xKWBTcg+ow54G9KDtNwccSg1Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QbnQwESPmzqKFEpc2plwPQQjM2LZaqbRAIfxGnG6/8QVxIn3TNLQPpPuUwuXaLmLiop6qeMxWE6wAk9jdzzcAvcnnt9RF/30F9AGWSSyXn3P4i/vC6zKL6gpv4c6uZi0MCsZdd+Qcjx1JqJSR5jfyKTHDS1rXAXK5NNnlKwJwQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1F6wLHt; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29f30233d8aso22004095ad.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 17:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768700389; x=1769305189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qykhmziqocBs83eOMsCXS+riegj3dQCRKqwsythsgqI=;
        b=F1F6wLHtBVff3S8i3w5YUDm6RO/A5gmWxKXksgHJnpJUzu9Qti7ETGMZAzKIpz9tXp
         HKmvttyUi5Z+1PdhY7eZbmVYvUbJqqxFymBdz97XlfsWgiKGOMHTh/i12wBMygnuTfnP
         tKKF2qjgNKnbQUnOAOzI2AcBfhxcaH5I9V8n3U5DIbmlVyJot7j9RuaVdt6UO0fYLfZG
         oXZ3jmHByuGlSxNRLWDxTZPoeZ4rIzl98jPuZqyD2hmrLVib1p6RryjLhEiz4Qo0/Ztb
         4Zs6D8qhQ3gyHXZqJ2r4xvBX79mXMJ/LyYOE8uldNeICpumRIDCcENTXehY7Oro3Z8tv
         ZOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768700389; x=1769305189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qykhmziqocBs83eOMsCXS+riegj3dQCRKqwsythsgqI=;
        b=GV1UJCvsfT3CaQAR0EauSDkSefXq7csqfcxDjYzchIEVqmU3SRxm5lFoCioalUSEC/
         TiG72VR7AbzCChJiz7o1777HdO9OzBVOtH1MfLDyNrwCdhRPczyLFov+3vqHxcKTAFXv
         5YlX09o/07386d2+ygjkrOLGtZ0uKvtVY5Bn+3WjvfK6RA8vUHFYd/+9X9QKF1qJOHTr
         SfcQlxZe6Mj1bb02ZLfRHdd/8YPQy73auGyulPjlKoM+P2qphHfmYYSs5KY/BisrKy3d
         hk4gWTs784SLYI1RpVwr+m5vmQPpydkwkU8i1reWemRiBd/Af8iRk9J4T2TtODhi+cwL
         DgTA==
X-Gm-Message-State: AOJu0YwcOTCEUnIBfX4qeHA1v5iX8RrKl8q6/8XFMU9XYQuntYS7IzH0
	mA152tjx5D2hSvswKRj8muZNk1djYriGwjePxhR1VNDb+iOFiTdPDeb6H1b76A==
X-Gm-Gg: AY/fxX5hvJK/fnuIiza8fITPDptRs4z/vrkShPHP/1hk013UgEzOCbYWerNWZ9u/xAs
	7wxL//Ften/TmbyhjR0t9CZHw1JTtkeeDg6dcpl7JXulZA5cAxc96bbpVGUXVqzJlDln9y1tebQ
	VD+aTUYWVceIVRkd7I+M2/TEWNuNynoGxta7RTywhjXX5iJM4aAdzULT4pJmrHpkisRt6u6mDmp
	DGiaM8hPEaFIRWh+bQlK+s3H7ccSecZVCUsZ43XS/RIjkuREJ2Lx+UNqmJ/mJVL+ZI/tzNqDKAj
	DYiCtAqnYKdXZwfyZTifnhLFQ8VFQTakMuxVIQBhLR1CDqAdsQxjhZhhjkT90lJN1GxGzl3kFAn
	IMaG8QfNuk9o9SZ2JFcw2zG18dWR+VCkBFdMDt4mZjOVT9bwu+xGDxj1OHFPxMzg6YdPG2504Ax
	l93+kYvQvhoO4L86DNZQeCZJQLbuHGlx9H3GscHHuCSkYK8a+lFA==
X-Received: by 2002:a17:902:ccc7:b0:2a0:d5b0:dd82 with SMTP id d9443c01a7336-2a718a743e4mr64000315ad.61.1768700388730;
        Sat, 17 Jan 2026 17:39:48 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbbf5sm56030615ad.47.2026.01.17.17.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 17:39:48 -0800 (PST)
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
Subject: [PATCH net-next v6 1/3] net: dsa: yt921x: Fix MIB overflow wraparound routine
Date: Sun, 18 Jan 2026 09:30:14 +0800
Message-ID: <20260118013019.1078847-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118013019.1078847-1-mmyangfl@gmail.com>
References: <20260118013019.1078847-1-mmyangfl@gmail.com>
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


