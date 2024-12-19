Return-Path: <netdev+bounces-153189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B49569F7231
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 02:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA5916EF4E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 01:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251B41D356E;
	Thu, 19 Dec 2024 01:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="IDdy66/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E51F1C1AAA
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 01:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734572570; cv=none; b=eycXQrdQEsRreHg2NlCnxRVirgBnvimDlEQIFQ0Sl3rOtSE74IkTTsiei0sJNS7FO5dqdqLWbIA/jXn97l6/mTDaquzjQpcuY9OrQIPEV9DtUyI66Sj2Ycyt/Msie781blPDZFDk20chW6eyw1i/LWtxND72spmI2xNPmtUIyGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734572570; c=relaxed/simple;
	bh=lH+70+vbb8mzsnWhRaq1p07+gp3g/U0ZT6i44uGNdws=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pYNRNYrk41pYHCOP43Gb4Ir6FR6QBU4ttB+OjXhb281bD9v1usS0U5lLHrRhs/bxZsU3ZXaBhUJDbtatB5J3Vm9cKihNDASfhIldVfdUROhg0Jb6IlGETOANRAet8HTKvx599GV62l0cFAuV0egng7b+NsKzRGGQAPpP+B99x7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=IDdy66/v; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862a921123so194905f8f.3
        for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 17:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1734572566; x=1735177366; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/6fd/nqlYwcpFBbPM1ixmIIbdfkkly/YsiIhiew+A3k=;
        b=IDdy66/vS1TpwfNTgP0h8awzeezvLooxqvus3aGDtt/Ohzf1cy+OOu45r4QMwDes8p
         6bMnxSeapCDFXk7PxYU2Vborm+FMswIYrvUosmJnvrr+Jfgilmnum9uv42n2/jlJGnos
         I7TIJhJ08Ls4yADjh/TizeWaXWydhobiC5/af7IxoIvg5/zRfJQJ6SqBqB1uKh1OD22f
         M32/Ks0YbvWtUJDiOwuijbxAZHZBkj9dGRgyrZkYni0lQr08wad4ENwtVxgIp10Ambaj
         /prrkcLvwJmPBxAgrcU4IiBXR/bEhyzXY36PaASvnn8w6AFH2CFChsc5peuxQKnal5IE
         zfAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734572566; x=1735177366;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6fd/nqlYwcpFBbPM1ixmIIbdfkkly/YsiIhiew+A3k=;
        b=Nn+Qo39lpmUzkkCcb0qWjMBoUW9MYl45Dbos2EG9xUvVEY2JUWvOpZVkSbrsPzqPks
         CKYKXofO0lBXCaqp/pNK+Ec0fs/kZRZe8iaU7O3eKh+s4O6J99XOQXyBQAxifdwC4YrG
         sexS55jPYXieBAzMW6dSZ5VqX60s/8C6t9WM8RIl3kl/SJH3FJ5fVGAlcT6XSsSidtdQ
         py/UxqmXtfVuA0XgTfrFHGOC7mgESWkUPIxSB6iGi+Dp5AHR3mq28MVI3BI2V+X9RWJP
         do4JnXfeZdSXnAxwUXay5/cPTe3KQldXFuoF+lD8SQ9d2jyU55ol631reb1XTVunWlNB
         4wag==
X-Gm-Message-State: AOJu0YySWZNFtSrbhMIxlhp1m6kZTF7SrKPlsb0vagSd6dNuieFGxqdf
	jqYPlnRjE5kM+zUoOL+DtgBBW2us1pLMbObQxbhucHPTTt0dv9/HJqhC/CNty3o=
X-Gm-Gg: ASbGnctgV19RdJh9H+4Fb8WghuVEmtcvyS174zIxCCiciQalYqggF8wN1v0bd8XwbFm
	O7O/Z/TveENSD9CHOEeRtNpFdKC1CaxP6OwuhxsqKCDiwpu4m9XvMEhjtFX+oqhcHVWhbOcAFeY
	0JQzYxyO2EB3mJzbeaJTdEw5MQjuE2G1CUdQlN5SjkHdsSgtRHKiHWthqQ8k0yhAX9luhaNSd1L
	5kvukOnteQQ6wxGRGMIiugdzZIx9iRWOfukD12tg9hduuPCExCSHGlgioZS+QCoqNB2
X-Google-Smtp-Source: AGHT+IG5N4suecAtq5lUtoaXqjEZAqAJ6Ib41P2DunbR+ADeWed9H6rDTmAZx9jOMhm1ceWGiaIHGQ==
X-Received: by 2002:a5d:6487:0:b0:385:e394:37ea with SMTP id ffacd0b85a97d-388e4d575dbmr4031044f8f.22.1734572566448;
        Wed, 18 Dec 2024 17:42:46 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3257:f823:e26a:c3fa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4364a376846sm63615715e9.0.2024.12.18.17.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 17:42:45 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 19 Dec 2024 02:42:19 +0100
Subject: [PATCH net-next v16 25/26] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-b4-ovpn-v16-25-3e3001153683@openvpn.net>
References: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
In-Reply-To: <20241219-b4-ovpn-v16-0-3e3001153683@openvpn.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=lH+70+vbb8mzsnWhRaq1p07+gp3g/U0ZT6i44uGNdws=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnY3oXhIz1AGiA+6UKf5HJZ9//rpOpYrKTyPJ+n
 FdbYe3Hs5eJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ2N6FwAKCRALcOU6oDjV
 hxW4B/9l7s9Qj9GkpLFs+NKKLpSovwuVWPFw5Eoq4y9lQvV7B+gseK8TQeKliBIe0gvMjtvL7Gr
 s54GnWkEDGnpq+93aBea+oiqPCMq5XOM5Lmi1usVVWO/r0whFv2v6BubJoYoGQHLuU1FzUBo6Gz
 TES9p+xMstNUTqBH8oSBxuls33xUmNJcI98hs5Oql4t0gN93Z5zaTvVhMGYiJHNWxD77/d/xBPc
 1frTTS3onjn3s6Ekp2Qw34+Ddj3Tv2HU+H+ORjoB0T3wthfDnquV925WqpGnvtViiHhbO+ygTii
 GGSGOCPfytb4W9GjXqwB/UeBMX3lEilGbPmxJejoCa1jXZ3B
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
index c7299a4334b6d50fb1596bab0af41323ed09edd0..2de1070f0188078418c14f332dba35d98bb1dbb0 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -94,6 +95,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
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
@@ -104,6 +118,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_priv_free;

-- 
2.45.2


