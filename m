Return-Path: <netdev+bounces-173859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37449A5C049
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:11:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DA627A9F68
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAD825E462;
	Tue, 11 Mar 2025 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WrCpLdFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4425DB1D
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 12:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741694619; cv=none; b=ToScG3unwf8Gnf3ikTdEVWjBeJUkBhKXEmlo6GByoWGDt+BVyuF10WDtVw+LDHHNk8X5vGcz2UvrznVmvrhZK+drO6a0EHQUnhf9k5MEKMz7ez4iZx+mMqwj/SLom15onJdEcuzBfGZqkhnBZxpJIkYpWOAkgIo/TcEI/kBawiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741694619; c=relaxed/simple;
	bh=Dpo86dcLuQHi+/ffLApLvGiDvMqBLBDHjZmNUI8Fgv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V7ZriGfv8ZfptlaemaDqa72Kk1tggMRPRoDT5Mpt/hB6SHJ7zlEISaE48+xtF7aCUytvgBCuBfFWzgVmzgDJTDFYzL3vsNgrtMr10fsfWpsBTKvZE8G3sL0Ykc0VZ2py2dVm48fJrFrCmoriRUpu1PUFkXLH4LCWsbyMwcl79S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WrCpLdFW; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so18857195e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 05:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1741694615; x=1742299415; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7513MgPTWzlFUV4A94AszGTBKoC1WXOdZLnItud/+rw=;
        b=WrCpLdFWBB9YB2n55gPleyWijfvLWomlEGhlOom4kVCz2CgSajLelpV+fu8WgmZXEY
         r2tPF23bEBaohTPdy6JNUWnDnEDDtwm5UCrk5sRogrMkx7Ni69XwtGGMy9EkNcBHnwry
         eHC8mUVY2tuZmMKoJvIc10r4xS6Ra9Sd/CH0y9WfiN/+/WFGBN7dP9tviBBDA+AZGJU6
         MbLj23x5dgO5GGu7yQH2QlMMOTKZquZfvaKrnNOFHtXR6zeUxmENKXKLuebC8Zgrhu6U
         aFt7MBqGmx1uA1RZGQx9D+LMoxAEdS+pI3/54jjnuLS2WW7fiDAmhLf8eDCznhWCaVbH
         Np/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741694615; x=1742299415;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7513MgPTWzlFUV4A94AszGTBKoC1WXOdZLnItud/+rw=;
        b=rtjo1fFr+BkiJwkHnEEkl3RAaDlf1gtL8dewz4tS9xvUw2/Qf00jer4UdGHsuYYalT
         ZGwSVZxNejraIOZwZyW4CnaPjOF32M9t9YJmWxz6tWNGPnOcFhF3aFu9dF5/RUM+246J
         e2h/stMuwGtHR5Sji5f9wse+Nkc8a/wXB19n/EPabQd4ji4dlZVQsQYt3OXxD9oPkHEk
         q65olIbFouShQpFdH9a4/P6G8TKiqlOQVugid2L4diFGwCGgCOenHQ8RmDDepM6fjzW3
         o9pefnTmtSE7xIKKbfIp4rt4KmN6cTQTKK7orb7S+JM7aaVUvBRFNiOFZlQUQ14GCfC2
         0Nlw==
X-Gm-Message-State: AOJu0YzDNzANPD2xUsLBgutZFXAkU+34/KBSWH4DX2kO9VkmrydoHF6r
	0A7iVOHtZ+p3OjpeLA9CATTOFdos0C60OHqB0T5Oa4zkB41edK7wepW4FQqB6ec=
X-Gm-Gg: ASbGncsNZu6y/GIWatwIG4y/wzcJCnI1y8cWgsbWoNJkOqvdpdKJOenswAcfNo7Gcft
	UP75rb2y0PgDHRNaggyGPbfSo6t42PC+t9cQyNdcq8ygWV1jYGadUwWF5ujekOBvLBzENaSKGQy
	6DQxoMp274cMqibu41t2zGIhgugGDjhGnI+lBht+iULgMhin2HDrLYptsK3IPN46Ivtx8Gx8wR6
	+J5v3YYwkVNCOE/vmdw40/YZu1u8CoVglQiD+Qb2QtUlFrlxUsr17jo3cAp+lmLf1sAgL7QPbAa
	YrwS65b3qgeFva0ovyJWmQI5T8Ds1d3TNxMOEDPr7g==
X-Google-Smtp-Source: AGHT+IGREqbuyoImnYbgFjJhW/d0v9jo08ssGpVpZNRtricqNFqqL69IN1VockK0XBdDiOURgseunQ==
X-Received: by 2002:a05:600c:4316:b0:43d:35b:9a74 with SMTP id 5b1f17b1804b1-43d035b9d3fmr29016675e9.6.1741694615460;
        Tue, 11 Mar 2025 05:03:35 -0700 (PDT)
Received: from [127.0.0.1] ([2001:67c:2fbc:1:52de:66e8:f2da:9714])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ceafc09d5sm110537605e9.31.2025.03.11.05.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 05:03:35 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 11 Mar 2025 13:02:23 +0100
Subject: [PATCH net-next v22 22/23] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250311-b4-ovpn-v22-22-2b7b02155412@openvpn.net>
References: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
In-Reply-To: <20250311-b4-ovpn-v22-0-2b7b02155412@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1701; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=Dpo86dcLuQHi+/ffLApLvGiDvMqBLBDHjZmNUI8Fgv8=;
 b=kA0DAAgBC3DlOqA41YcByyZiAGfQJnGgkRGfCkARtacCijCtX2FKUpqIfOp3qofnFhiZT/zJL
 IkBMwQAAQgAHRYhBJmr3Gz41BLk3l/A/Atw5TqgONWHBQJn0CZxAAoJEAtw5TqgONWHiNoH/3Pc
 rT7PvhT7gULcb6mztxX7KGJ0SDYr1EO+n20tCgscmoo4f2ltEo/vx9OJhEI/VAZuFL7qiP8Mhz8
 hQO3l0KfkHEEIeK7WCWUwl1psJpjfl0hqyZvX8TVconxgqNg44H9KMpo7fGKmI6CPsjhZESm/BL
 +sTxNW2zXF10+VxmIsh/2+kGsgbCiSRJUGwz+Eed/2Tk2NaHXWUGfpip+rTfZYeJ841hrUKoHMJ
 /XsnWJ8JrWV183PK03P1OPYVgKbTKEEDmIDaz5Mz/LmvQaooB7HVVKHb4a9oLDFOxwbF9+FquAI
 HTo7vmab5rF8md0C3a6fYNQna0Bb7yfaU86boBE=
X-Developer-Key: i=antonio@openvpn.net; a=openpgp;
 fpr=CABDA1282017C267219885C748F0CCB68F59D14C

Implement support for basic ethtool functionality.

Note that ovpn is a virtual device driver, therefore
various ethtool APIs are just not meaningful and thus
not implemented.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index dd05d0fe7a2d139bda55ebd68b9e1d78f5c00af9..886601ddaf7bdee4761691d293274a61da204f2b 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -143,6 +144,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops == &ovpn_netdev_ops;
 }
 
+static void ovpn_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, "ovpn", sizeof(info->driver));
+	strscpy(info->bus_info, "ovpn", sizeof(info->bus_info));
+}
+
+static const struct ethtool_ops ovpn_ethtool_ops = {
+	.get_drvinfo		= ovpn_get_drvinfo,
+	.get_link		= ethtool_op_get_link,
+	.get_ts_info		= ethtool_op_get_ts_info,
+};
+
 static void ovpn_setup(struct net_device *dev)
 {
 	netdev_features_t feat = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_RXCSUM |
@@ -153,6 +167,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_priv_free;

-- 
2.48.1


