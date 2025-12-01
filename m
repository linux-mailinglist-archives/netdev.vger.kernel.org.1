Return-Path: <netdev+bounces-242923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D48ABC966DE
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 10:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FB633A44FF
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 09:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF49302156;
	Mon,  1 Dec 2025 09:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL69i2q6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA4D302144
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582194; cv=none; b=TqE87mP6iq/CNr4lmxYVtSND1dJwFd0mgqfmrHMGfcnIdmX8H1SGvwOcAcKm7fEB8LMiPN3yTvtZKt2yDMIruZY01yz3SdbdIfVCnpRxx5Q56Qp0n6uupDvyqmzojQTbfdhsCeRLmnCyR7x0NTejtz8mhnTrqLBrlYxiKkpDd44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582194; c=relaxed/simple;
	bh=1Yv1oIT699SVdaLFcOJTIkCkF0JQ6OixdnuNEzqgMgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ths9SSCnI40+Yhuj4BquqgoZBlc6kdfDIUPf9ltUF+wsa60j41BB1juRdf1JX7TZkIUXgDE0CvUtgBbDgIHUzXdw14o2ueirExAmTS8IT742YVAoZVoXnqfcUWdYi8P0UvGZcp2DiNc/07Way/fsKk+SHX/Ir8p2S3E6aRGQFIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL69i2q6; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so4769304b3a.2
        for <netdev@vger.kernel.org>; Mon, 01 Dec 2025 01:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764582191; x=1765186991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZetbUmdM6eNyqBVZeKZQSq1buO8MH0g2Wynwyyea2/g=;
        b=cL69i2q6nHGO8oTysb8JtuV4rUZmNMkXlglyh3HIGcO8DHOzugK83cMvhs//MM8uB+
         tRE3+ND6JpWlPz9A9pXyJ4cWvvoZnp9RQV4eXHnEpF/D6qxiNgN0Ki6xwZqFWvOJux0f
         hFG2cHe6itaKO7tivd+oCVSBD/Se481Wt+N8IilDthMnIqU8pegEG6uZDO5oKPftUWFO
         pHBw8m+R+2JIsx8KQkkUl80LTu2AhbaJ2kW5hyh1wRqiwq0VVEdFi8gb6vPmUBBh0YCH
         r1yCjsj3VMZe4iikHNrMllm01jdPva7465cIhePb+CvBHUgQRMAMcYkGPPC1p6g0xyrG
         LQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764582191; x=1765186991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZetbUmdM6eNyqBVZeKZQSq1buO8MH0g2Wynwyyea2/g=;
        b=m8+yyTS4ouzFagmpPpdceRnhlZ7FzbzAVDoj2zKrnb7Vee9jHHyYTFUeGDb8KaIzNR
         0+jhy+E+5fmuY5u9HX4QyxiLPfpgnpV8zKV+qy3/f5xc4d5jCN+KE/gr9tOMuvuhkH9L
         VYnmr5fqe7X0zSJcnF4hmZ5ldptKURYKCrr9vkOCtLqMm1b49xx1i9bpQUriUK78iZQo
         W+NldOah8k7hStHzGJtiJrnCUKdFXWuDsNCWVenxO4GnUey94acGPQcde34EYSynGCg4
         d4sJatv296X2wnZHibIYR/uvdqQ1DdYKAuXK/F5sfXg5vyzHwJGrEzJOkmXta1g1UCp+
         ZXvg==
X-Gm-Message-State: AOJu0Yy0GMTgWyBhfGNGPykuh1oevhoXsi7Z/oUjhWkjKz8joCrnT21U
	27hvL6poUbbeZ4jqESSYpsZEsM3gGzoAH5UdjnsSnTsRebGqTbUnTH5TvqBPTw==
X-Gm-Gg: ASbGncvXxS+yE6WPz8YLW6mVIBXJeSA3L7PeNkftFGY1VHGPfeGfyG6VatXRI6mT/Kt
	oeQRn3N96sMdPEIsPa2Dy1AlT4Omf3y6q7gfuD0YjEf0lpN4ugkdeEw4/u6lsE3Qv49GOdJyqt9
	M/VgS2ajZ+4B7jwikUaCdH1v9KpQ2eOWeAJyn7ODWzk5hNUUl8Q6DUNaC+LzxZeXYf+maiRVglj
	dY3PtWfUZYpoHLMgfSDjjvRKIfJz/yP84zYcYD7v/uPY+2D6fbD5lj0hZNCKHOdhPmefiMEoMYV
	REWBGRb/UopCjcT8i21QpxqiSDhhXE36B8SCSNkktv1zYh2UzXA/pcbLaPgg46MSsqAcqco8dn+
	AI5MaE4m4zdIw2IthbussgSWadJNsdPIj5vhPgeJvYeKdONSHApIfjZNQ45oDB8fMct6LiyZMJ9
	lstIdG8+k3PBaIF6OUoJiH/g==
X-Google-Smtp-Source: AGHT+IGXi3xxRFPd1my2mhDXveeMZhBTd+iKBkyq5cYVaRv6g/MMo0MvPg/c+n1gZGH0Bnze4+/yjg==
X-Received: by 2002:a05:6a00:8cc:b0:7b8:7c1a:7f67 with SMTP id d2e1a72fcca58-7c58beb7a10mr38194089b3a.4.1764582190758;
        Mon, 01 Dec 2025 01:43:10 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15f9260a4sm12928333b3a.58.2025.12.01.01.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Dec 2025 01:43:10 -0800 (PST)
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
Subject: [PATCH net-next v4 1/2] net: dsa: yt921x: Use *_ULL bitfield macros for VLAN_CTRL
Date: Mon,  1 Dec 2025 17:42:28 +0800
Message-ID: <20251201094232.3155105-2-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201094232.3155105-1-mmyangfl@gmail.com>
References: <20251201094232.3155105-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VLAN_CTRL should be treated as a 64-bit register. GENMASK and BIT
macros use unsigned long as the underlying type, which will result in a
build error on architectures where sizeof(long) == 4.

Replace them with unsigned long long variants.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 44719d841d40..01ef623946fd 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -382,23 +382,23 @@
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


