Return-Path: <netdev+bounces-127647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7354975F32
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201182856A3
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6C48183CC4;
	Thu, 12 Sep 2024 02:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQRosFMw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633CD1714D0;
	Thu, 12 Sep 2024 02:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109358; cv=none; b=QQaQHm0xZdAIoKnxT/O+39m0puc6Ls/VJNTF1hPp2YMKNXknav6d+pkLDgyqeCYmDwzMCwDztD/QEpeZMeNnIciwmUJuIeRkGAgzXy5sSirVBEcv3E6G+mJQoNW/qFSa5+B4lv32YOFTwEKHgmFmCU44R8RJQEH2CtMirHkt2A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109358; c=relaxed/simple;
	bh=2i2M/OGGqpsddwsJZ9tuwhPH3SSIh30ZP9VSe0uNJAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i8j/uskK8sgJAc1XZXnbh4MJHrV9i47INeHkKFvtQ1NjI6uhLi7zonQQNfUPC4qzbjtVY8jbATnmmsm/2RsWz2JjY2I+EQd74H4wSy/wxBVwIELgYM1L1SnOjyB0iONLBcqBHSKsS4UO+AmHHIDvicOPsLUOgK6P/5+kP8wbv84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQRosFMw; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2d8818337a5so1165654a91.1;
        Wed, 11 Sep 2024 19:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109356; x=1726714156; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WKSmeMBI0xqoZ2BrFo0nUluXTJXqB5d/naPVU/Qsaqs=;
        b=OQRosFMwz1TGhEM26tPtJ28SsUDDx0aKGIKT1AfFON8jVdSFvmQcrzS//yZ4vtXQWT
         Gn1gRPyKnXnO5kCsV6XN/mPooENyg+HAmZ3Zc8pYVMqokP9jCMaRu4J6JDQd/g3L6rub
         rGyBS554UK/mPi65J5DaIvElXKBcckuaqlGvzGfMRHUtGsZNyDzWhsrlMvl1bzSnCb7a
         /n1VIGN1aSSeULe/uekInJRvSx/r71M+CuhagF5mc3IquaAjUK7scrQB9d0CA7l8BCSo
         pwe+z7UXeg7nXRHjqiMFuwARo3uqWyRHVJYB11FS2LDvppO1BqMrE/eB2eRdiO9hziKZ
         LVRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109356; x=1726714156;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WKSmeMBI0xqoZ2BrFo0nUluXTJXqB5d/naPVU/Qsaqs=;
        b=OYuqWbqxoB2Z61AkIBVjtz0Z5wmoK4wCF97339Tsske/qOCOAypG7GR+CpRIo9jTIT
         Avf9oxQdG4l+rydwXrBGRKHa2ieiliaKiGmqdR3gGIKBKx2s8IVt99sij/jc62POyGwN
         jxlwCjbV89NU1YvN7iP7JmgME1Dx3G81NFa9c3Ovo01tiAKCT7C/HgTIH6/hEscd7dte
         IhpMAT1130DXqorwsHS2inpgnXD4SmrrCYrM5kcm7r6J88iWjDmP5YdtX95lLDPoU829
         sd7sEuVBHdcwR7E93F9rZVYdvIp2DaDJnFCQKeYuPa6yh6Mc7Q/CqKXE9JbMaH9rAtam
         mkNA==
X-Forwarded-Encrypted: i=1; AJvYcCXY+WJDisiCPeiWZwlxJI2gu19u32D84VKhusn//c5JRTJw+R9yB7zYIU84nwCSLEuneT+m4dA1j0bDqG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3vyflEemvsHTAYqAWli1OR3dljmaVeZAOpqhWU6R2Pbqhuoy
	5Y30bkGXvGtvpbZiG1ruL2BSqBH6Rq5PCpHXJLLWO3WvL3ZOMTi+yhxDbQmU
X-Google-Smtp-Source: AGHT+IGiunGRUyXupyW2k2tPkSpsAEMfalA//U2LOuxp5sEzNuai/K8z1OKUBBLG5nvXeHkcHU+9Xw==
X-Received: by 2002:a17:90b:906:b0:2da:82d4:c63c with SMTP id 98e67ed59e1d1-2db6717819bmr12903883a91.4.1726109356639;
        Wed, 11 Sep 2024 19:49:16 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4897sm11457868a91.7.2024.09.11.19.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:49:16 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv5 net-next 7/9] net: ibm: emac: replace of_get_property
Date: Wed, 11 Sep 2024 19:49:01 -0700
Message-ID: <20240912024903.6201-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912024903.6201-1-rosenp@gmail.com>
References: <20240912024903.6201-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_property_read_u32 can be used.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ethernet/ibm/emac/core.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index f79481b6da30..6556f9b2b48f 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2444,15 +2444,14 @@ static int emac_wait_deps(struct emac_instance *dev)
 static int emac_read_uint_prop(struct device_node *np, const char *name,
 			       u32 *val, int fatal)
 {
-	int len;
-	const u32 *prop = of_get_property(np, name, &len);
-	if (prop == NULL || len < sizeof(u32)) {
+	int err;
+
+	err = of_property_read_u32(np, name, val);
+	if (err) {
 		if (fatal)
-			printk(KERN_ERR "%pOF: missing %s property\n",
-			       np, name);
-		return -ENODEV;
+			pr_err("%pOF: missing %s property", np, name);
+		return err;
 	}
-	*val = *prop;
 	return 0;
 }
 
@@ -3301,16 +3300,15 @@ static void __init emac_make_bootlist(void)
 
 	/* Collect EMACs */
 	while((np = of_find_all_nodes(np)) != NULL) {
-		const u32 *idx;
+		u32 idx;
 
 		if (of_match_node(emac_match, np) == NULL)
 			continue;
 		if (of_property_read_bool(np, "unused"))
 			continue;
-		idx = of_get_property(np, "cell-index", NULL);
-		if (idx == NULL)
+		if (of_property_read_u32(np, "cell-index", &idx))
 			continue;
-		cell_indices[i] = *idx;
+		cell_indices[i] = idx;
 		emac_boot_list[i++] = of_node_get(np);
 		if (i >= EMAC_BOOT_LIST_SIZE) {
 			of_node_put(np);
-- 
2.46.0


