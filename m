Return-Path: <netdev+bounces-242666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C0CEC93800
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 05:22:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7AD65348B3E
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 04:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D8F223DDF;
	Sat, 29 Nov 2025 04:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwgoR3n1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC1F188CC9
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 04:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764390118; cv=none; b=TtkcoG7DeNAIZiwT40NGn6c4Xd0Wy32IYsKait03TFpp7NVXlmKnnnAVIpY0x+TxXkSfE64eIvnby2zIQ5S1TKmscGnvQQ8f4yc/14svI0a8SgWZixnM/YC7WE5Vw9clLPjsPNCeomi3ifGbgSH4R+28ylwlGAv+KeERg2pCT2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764390118; c=relaxed/simple;
	bh=e7l6wzKTukbDEuaa1Urag72pSBUniuTYMdV1yTwwuNA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RiZlDdkVHrrmtKieJP5l21DdiyAMz2K+/ADh0r5tFqPLmQ96E9aRbZ+cdt2rv498io6HIsaTS2oIUqqNSmPOHz7Jk3S+EGuMV0DljfiA2NZk/0oIZTKFhq6CJMOUwE74hkGbsclikdCGDzaXx0Sky8qw2M86ScQ8JpluSKTxirM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwgoR3n1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-298039e00c2so35027975ad.3
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 20:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764390116; x=1764994916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c2GkItaOT5ykQMkZu9n7CrnGme19dmT3HH8CwuLA6PM=;
        b=LwgoR3n111IrV7l8CDvEMV6gExz0neaYCsaDtjMtM0IA2hFpdwqy+J0KznUq2Gd9fK
         DzzOfVHW2+M9Jv6fQYQUkRSbGod5pavk4PjeUAlHiRXQGEkKk7awkK1yK2mDWvHuOaEr
         W/YM7u3mkdkPtv2Igb2e3k4o8TdtcWntVFXfIwaEuVNDJqJiYfJHcd1LN3GRYlbpk62z
         iyUfFLa+OwOKH13beX5YIplQDdlmyLR7JXQ2ZzIpRm52A23eIDEkgMPybyxeyAoEq7R4
         JfoG7HUmL6W1NR/eGCYlyt5wKLr6GwkJTYXWVPE0YRtHGpckLquKHfzKwNEhU+0OwFxV
         QCeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764390116; x=1764994916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c2GkItaOT5ykQMkZu9n7CrnGme19dmT3HH8CwuLA6PM=;
        b=GhjXXs+nTN/WAQgDDAYNoQoKi1FlVKdPnHDo7s+y9gOWecT++u0JJuSbt7U1iKgbxw
         mzx94CYx8jjPd+cHJfBYAqWRO5P3C3DIxRRbRAy5u181oeezp28cKUz/IglDr19mAk8K
         XhkS2XXjM1VUY2f6IpAsRyc2aiAaP3PnDPaDuMOUhAAKTZeOckyCvKLXlX5XB1cOh7EH
         SU574yZDFp3L67rzyo1WJjUE2o91wtc/WoLEmdMbMref7LI7qbgIZLLKYWfOK6D0tjBM
         0gEm0HqeFThmc3H0Os1zdQdufq3gj1yG85Mlp4VF2k+zXxnhB+iJbdZF4KN1TEGrRMkZ
         pICQ==
X-Gm-Message-State: AOJu0Yz9eJuS2U/t4rS/OPu0a33DEjZU3oQEJrxaC+BIYT7BDM21qwy+
	xdrum7ZqX6EOgDLepv6+93REprduE29DlRNmNiN60n0aK8mGX+Q8M5PGKsgBng==
X-Gm-Gg: ASbGncvtHa7G4EdwHWOoyRLdNjuw0MkGLoXDos4WcdxO9a4UXRdB6u5QWXZnOfti+MX
	FuhIeMsEe80qKRkmVRNG2z2RfOZ6D5zFZ6YHWZKPCqmiO78XqqaYF8L1Oa5qp1s61driExsSvN6
	Iytle2koExlezPeX+dqIkkJBfwq2t8KQ5VscwetKO92fJBlndqEUXXZFFEyiYEbO1onQTL+pNH9
	RfG4jWgVtPvB28Cwj98WEulkz5Eh0Ew+Ax+rdU0Q0DQmqZfWt9bQrHu5UELE6xmyujEz2sJr7Zz
	rPziOliV/GyKyr5JkzQjX8NuQI6bXFYailapsVfxOT0ei7swXWsNyy3mQwzMTINTwddIHF7UOU4
	8TI4MkJ+IgKscvOa++23CM8DGW9QddYTmgSnYiB1fext3OoI8G4gAF6Mhli3YqdTvLNrB6ULbla
	MztFrfsyoBuif4an4SSA==
X-Google-Smtp-Source: AGHT+IEM+GsTacTkyzLmyuERcxe4E2+rFECrPLm0tnsZSHkAiPQfzhopk/bWEVpyNXxu7L0lhrWdxg==
X-Received: by 2002:a17:903:11c7:b0:296:ec5:ab3d with SMTP id d9443c01a7336-29b6bfa0be1mr343221825ad.61.1764390116114;
        Fri, 28 Nov 2025 20:21:56 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb54915sm59879455ad.92.2025.11.28.20.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 20:21:55 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: yt921x: Set ageing_time_min/ageing_time_max
Date: Sat, 29 Nov 2025 12:21:34 +0800
Message-ID: <20251129042137.3034032-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ageing time is in 5s step, ranging from 1 step to 0xffff steps, so
add appropriate attributes.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index ebfd34f72314..d5fb17d2b6e0 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -2855,6 +2855,8 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 	ds->assisted_learning_on_cpu_port = true;
 	ds->priv = priv;
 	ds->ops = &yt921x_dsa_switch_ops;
+	ds->ageing_time_min = 1 * 5000;
+	ds->ageing_time_max = U16_MAX * 5000;
 	ds->phylink_mac_ops = &yt921x_phylink_mac_ops;
 	ds->num_ports = YT921X_PORT_NUM;
 
-- 
2.51.0


