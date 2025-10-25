Return-Path: <netdev+bounces-232900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6BCC09DC1
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C343E4F04C9
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 17:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B1D301701;
	Sat, 25 Oct 2025 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h7Lvfv4o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4E3009CB
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 17:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761411981; cv=none; b=uazWXEi9k+7Xo+2U3EpNB3f+Z4zuDnv/ROEFtHawEVfU1ylnGJ+ld3WcV+FO35qIOTyVujHQreC+XOW8Bg1Te4ZtR910WqfpHErywsm89PAIbiTwzdmF4fNzoUdysBYEMYNax2z/AkcnxeaJxQh8S5VjDmArouYGE4BsTeHOIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761411981; c=relaxed/simple;
	bh=XPoMqDwwNJLwd6t8oOPZg8CGm6E3Kw7Z8uoFKk912hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDUa7OzDH8/DPFNA852RZwl/WG4YnxULGlFOfkg+YJ4gCsju0h5mYg2qnPAcsfA8kw3Z9uTXi8W4qn0Vup/BaddiI6mZqn416crtvod7HecnC6SIW3UDqX7NfNC+9jj1HbzYi7z2xRXaVyEem8PfkPNkj9UtURqeSqvH0xIrEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h7Lvfv4o; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-33067909400so2368319a91.2
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761411978; x=1762016778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Kzhu4s+NpOCVTnPevu9VK8eZq5kgkG4j+tx0i0eXd0=;
        b=h7Lvfv4oVmgMuQCLnbxUOz36SpE45JFOCd3yan6OQwEPCFfXV6BY+baecVkeuQgSdC
         mBfK4Ouv5JsYM5kgS/QWAL8TQcqO5pbN5I3hSBlnpQUmmzbnQWQvwj2HBtHTde4Lp4g3
         b4YVxEV+NKoMt7pYK5pLIHEC7oCtEXg+sKa4oWn6MAofJmw39fJmLR4ik46fM9EsUWhr
         eQ2mla3AB8U66e8SGZWWoBqQeCMUy82r78NJAmOlnY7tHuGHimBKrcs06oOtUGPGHlA6
         ujemapTFrzznxc+79y2PVYrcg5/N8Wpw1qQRkqMhzz6UyXh/6goeVhtVnJz6p4Z0YQla
         JxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761411978; x=1762016778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Kzhu4s+NpOCVTnPevu9VK8eZq5kgkG4j+tx0i0eXd0=;
        b=e1fE8QB1APAvDGKdI1yjoEreP0FdPiJK9JQu9Yr6eD7kH1KU76aWwyHjPWsL0HuuBk
         pVkhy+aov7jnZK7UX+7F9wGGXFOE3LjTKiMwVtqfhWvf0a9PnTYx2p+Y4qeSo0xl55Fn
         gfzV8jIJRbiQB467mvniKDvrVVHTpY5faKEZFM77zmGXcmhEMIL2zDfbooKPvp7Io8wl
         89PJ700D2S2VMRUSh5ppFQU1B2/IvNx/asI5h6yVcZ+TRjP1UKMuivTeo25QR0mL/9Dg
         EcXtn0svG+yhulROSFqpOpi+2NoqnBv+l2tQCsWFFzZ3HqdqtqDAAHcNV49DZtQvYajp
         3KYg==
X-Gm-Message-State: AOJu0Ywo8vLncSYZ3eCifvt407Nk8/fa+a5lj2pVJlf4UTvIg77bqRx+
	rGpF/Hv1l0e6lQzK0LCFYj5/UZ8YiuLQZ2SlRJInIzo+B/XqJ89U+l4hDJcT5jAd
X-Gm-Gg: ASbGncuy6/Ta0XKY76nxOvgZdFdNlHhcfGn7y49/LPx3y0Kbe9j5QsbG9vSo4vwX9qa
	8czDgX+VIXgo1XgtXJizN/yPToTryqe5qFfE3cn8oAeXAp1PbnG8oQ6RAwK41H5wK5j3HGhAJaq
	CTxaodV/sxhi37D2UCdDZ11zPsQc/BN7+trjS71VV5NctDwxevyUjkthH2GZ0WmRShbw38nUx1F
	uXeCnbjZmz2xLVbZQ9BIGUW9o2KtA1fwAtUMdEWJVHain+GQzdEjXpEZs7X1hiG7dZLV+9/wdEy
	jx1JlZHqDBVrxQ5mIoQW98xGjLFlPbFvtKIzZvkeG6k16XE708xF3TFVPeXa186Y9PnNxh6miyE
	0eNwrRv5i/yrvUcJhQoXHUlMIk//3FtEh0T6WODarfHW5RYBqtfHdF0cj09+GTLUEPNj6mPGAKT
	nUin5zIuuCndlLe3ZQ0g==
X-Google-Smtp-Source: AGHT+IHcunpgm/kUmSDaDAkhbrYQGDPGWnTI3si/TQgkka4BpRb5fy72VcvUXELVm0ssffWlf6x+fg==
X-Received: by 2002:a17:90b:4d91:b0:32e:389b:8762 with SMTP id 98e67ed59e1d1-33fafa65affmr11410120a91.0.1761411978336;
        Sat, 25 Oct 2025 10:06:18 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed7e70d1sm2857842a91.11.2025.10.25.10.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:06:18 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/4] net: dsa: yt921x: Use *_ULL bitfield macros for VLAN_CTRL
Date: Sun, 26 Oct 2025 01:05:24 +0800
Message-ID: <20251025170606.1937327-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025170606.1937327-1-mmyangfl@gmail.com>
References: <20251025170606.1937327-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VLAN_CTRL should be treated as a 64-bit register. GENMASK and BIT
macros use unsigned long as the underlying type, which will result in a
build error on architectures where sizeof(long) == 32.

Replace them with unsigned long long variants.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 3e85d90826fb..85d995cdb7c5 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -328,23 +328,23 @@
 #define  YT921X_FDB_HW_FLUSH_ON_LINKDOWN	BIT(0)
 
 #define YT921X_VLANn_CTRL(vlan)		(0x188000 + 8 * (vlan))
-#define  YT921X_VLAN_CTRL_UNTAG_PORTS_M		GENMASK(50, 40)
+#define  YT921X_VLAN_CTRL_UNTAG_PORTS_M		GENMASK_ULL(50, 40)
 #define   YT921X_VLAN_CTRL_UNTAG_PORTS(x)		FIELD_PREP(YT921X_VLAN_CTRL_UNTAG_PORTS_M, (x))
-#define  YT921X_VLAN_CTRL_UNTAG_PORTn(port)	BIT((port) + 40)
-#define  YT921X_VLAN_CTRL_STP_ID_M		GENMASK(39, 36)
+#define  YT921X_VLAN_CTRL_UNTAG_PORTn(port)	BIT_ULL((port) + 40)
+#define  YT921X_VLAN_CTRL_STP_ID_M		GENMASK_ULL(39, 36)
 #define   YT921X_VLAN_CTRL_STP_ID(x)			FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
-#define  YT921X_VLAN_CTRL_SVLAN_EN		BIT(35)
-#define  YT921X_VLAN_CTRL_FID_M			GENMASK(34, 23)
+#define  YT921X_VLAN_CTRL_SVLAN_EN		BIT_ULL(35)
+#define  YT921X_VLAN_CTRL_FID_M			GENMASK_ULL(34, 23)
 #define   YT921X_VLAN_CTRL_FID(x)			FIELD_PREP(YT921X_VLAN_CTRL_FID_M, (x))
-#define  YT921X_VLAN_CTRL_LEARN_DIS		BIT(22)
-#define  YT921X_VLAN_CTRL_INT_PRI_EN		BIT(21)
-#define  YT921X_VLAN_CTRL_INT_PRI_M		GENMASK(20, 18)
-#define  YT921X_VLAN_CTRL_PORTS_M		GENMASK(17, 7)
+#define  YT921X_VLAN_CTRL_LEARN_DIS		BIT_ULL(22)
+#define  YT921X_VLAN_CTRL_INT_PRI_EN		BIT_ULL(21)
+#define  YT921X_VLAN_CTRL_INT_PRI_M		GENMASK_ULL(20, 18)
+#define  YT921X_VLAN_CTRL_PORTS_M		GENMASK_ULL(17, 7)
 #define   YT921X_VLAN_CTRL_PORTS(x)			FIELD_PREP(YT921X_VLAN_CTRL_PORTS_M, (x))
-#define  YT921X_VLAN_CTRL_PORTn(port)		BIT((port) + 7)
-#define  YT921X_VLAN_CTRL_BYPASS_1X_AC		BIT(6)
-#define  YT921X_VLAN_CTRL_METER_EN		BIT(5)
-#define  YT921X_VLAN_CTRL_METER_ID_M		GENMASK(4, 0)
+#define  YT921X_VLAN_CTRL_PORTn(port)		BIT_ULL((port) + 7)
+#define  YT921X_VLAN_CTRL_BYPASS_1X_AC		BIT_ULL(6)
+#define  YT921X_VLAN_CTRL_METER_EN		BIT_ULL(5)
+#define  YT921X_VLAN_CTRL_METER_ID_M		GENMASK_ULL(4, 0)
 
 #define YT921X_TPID_IGRn(x)		(0x210000 + 4 * (x))	/* [0, 3] */
 #define  YT921X_TPID_IGR_TPID_M			GENMASK(15, 0)
-- 
2.51.0


