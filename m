Return-Path: <netdev+bounces-170061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D7AA4713D
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 02:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 333DB3A00E6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 01:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7AD22B8CD;
	Thu, 27 Feb 2025 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="EtaT7UZS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77C7215173
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 01:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740619402; cv=none; b=Z+4vJKJuZ0S3FIQ5OzYGlBrxDiZzi4IETEHkRzouLjTMVXLjdHcZYoGSqu/UR88hGEwLe+okOg/wf2TMcI8yuUSyozYA7Q5HIooq32GvAomW3NJ7pq/01ziR9QBvudQqgZHu7ALl0PH62xAIm5agsa1B6qeHCaf0xSToRbk93Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740619402; c=relaxed/simple;
	bh=9eMW594XfN5EIuY/VExIDGVlhmzTpHIdbYaduaY6Ljg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TkTgCiNa99/gB7mD9288GQa6dlzJ4RVBxrT5DlSW1O7hOpKw9DWNY+smWTbciv9IxtxiZXvcOLO5GRAOxULqxaoPlS81istkIrhkUKsbaBhOstzpFuSFGPghxeqAQbYiXnE3LD3CT/dGnqnJscR+rMQFd1dpQZWINXyEpeyPNVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=EtaT7UZS; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-439846bc7eeso2520585e9.3
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 17:23:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1740619399; x=1741224199; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6i3SM/z2SciT1CwyKc7K9lXDEKyQeNchp7V0ExUQcg=;
        b=EtaT7UZStb474v2cqKqhwScpMA3lVLQGM/72OW/eo/au7NujN4eqJyZfCftAm+kOer
         fDXtzYMHu2cr0BbpFZoBt74TO+CD2rYYz+/k2XhIeL9bkqimqz9JsJ8BAis2ze0BfxlU
         dOd+mgMEbbNVz2CKf145/JVKpuZxX8SoqN24RdsxHWrs6vZADdiQbgliLZDF3X9B8cci
         /CQdpc5qPnN/6IxhoJhHNQCvdy+wGtf6bQjm09ckU1/dLOWMfU+MGqbSCF5vROO815kw
         LI9qIeV+7AeERylexBjpj5CYWsZ25Px10RCrSurNNHyPY559n++X9rFIAEDAnwfbkl2R
         NpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740619399; x=1741224199;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e6i3SM/z2SciT1CwyKc7K9lXDEKyQeNchp7V0ExUQcg=;
        b=PO+x6Z7U/Ay4dP0bmygdlJKSrNn39IRJ9uiVqZbAuuRRzXgG+pUpspGPT5E+qXDWSN
         1UrHwutTUa3yALCUoBjDMedxC7jXnNOm9VQ1GfFWo5E/NS6YgQsEV1z/DTCfSqWMC4ia
         DAmUYIqFGEO3/QyCc0vXLSUrDaiDxODjlefkjET1BwUn7U0Q/zXdUStuBBsjOMItY7DA
         AwZxXznedzN8lBevq7SgZ0BcyQEdojwU2Kv1w0X1oafVpC2VzWscDE/wHQyOLCQ0XL2u
         H3OYHI/V0QYEJzjbAbhNtIquWhVy4p2iAWVLKqdeOSdQ1zyZRaLo/24NywamEdZvCozt
         BM4Q==
X-Gm-Message-State: AOJu0Yy26+QE0LQoueSYBXZiv6/GWhtaoJRaGBW4Luy+Cys/MYNGBiNk
	eBHuck1uSMCWBTO4OnUVPH+p5Fb5Yk1az+ypLALVF1FaDFRb9CTMBP3jLFjFZqk=
X-Gm-Gg: ASbGncsllMAs7aXevVz8y3rUTxZCPBtlanymPp3Ac/iwB+wevM+zbmN2u5vRT4twyeq
	ei2NxlIlmEcuAlDls6QwTpaj3w4pnaYKn88XOYJ1zyP54rhON+eDDKj7Hk5ItbzsZcMWXMGSp3R
	qzZWhEwZd9ZHYi/odl0S4qRAQWPN3F+9NQIut7ZChvdHTvWDOntPKhISGtmhXNJd69InqrNOIDI
	xNk52JVWuekf6pPAOqpkJf1OPqkM1v6pm8LrAUP0UsPgtZ6lqhNQRjFvZAtU/MjjOo+xtRTNx6P
	9AQim8wQPlFcqDkFk8eyYEtjGVdX3g3e/fifkw==
X-Google-Smtp-Source: AGHT+IGdtsGowAY8C/acswBJeCYv1tTLtiw4AFghDIJXo4f5Ct14fh+H1VzuM0U6MSKtGcRzSfPEdQ==
X-Received: by 2002:a05:600c:5123:b0:434:fa55:eb56 with SMTP id 5b1f17b1804b1-43ab8fd8ee4mr48717015e9.7.1740619399091;
        Wed, 26 Feb 2025 17:23:19 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:7418:f717:1e0a:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba5327f0sm38375395e9.9.2025.02.26.17.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:23:17 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Thu, 27 Feb 2025 02:21:49 +0100
Subject: [PATCH net-next v20 24/25] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-b4-ovpn-v20-24-93f363310834@openvpn.net>
References: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
In-Reply-To: <20250227-b4-ovpn-v20-0-93f363310834@openvpn.net>
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
 h=from:subject:message-id; bh=9eMW594XfN5EIuY/VExIDGVlhmzTpHIdbYaduaY6Ljg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnv75hnQmvmyHlZJmB7itQ+3walrdOBaRP72mER
 L/njhRsLVeJATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ7++YQAKCRALcOU6oDjV
 h88iB/0XpL8STfcLwOUAKqG/0+ZfU9pCmrerZ42c4KYIjkJSysKZmWGWUd6YtCAjI8IHBofU3+a
 JAXm5h/M7SO6slVqM3mu7Zj1Ib1lPW1kQg/qqf2wRKUF+z2gRjcpKsAw1jXXSJkNxVucuwwuo4p
 8ft7Vp8gVedFnUwvAXg1r3W7tZh7MW2NtErEHQQbaSx4MGlWNwxNVIQ/Kmxq87GmrSG0YcPr4lG
 Ij/nsUD42G3cZ92cvEQhjIX1HiRCmuGSMFjKxzFjQcUjXttuzcTF3qE0CEoot6vs1kIDwKDJn8i
 LcbNHJhN7ZpE+PpUpWtHbHmueql0/uqvV+dBIOix2cgsLYEN
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
index d123d47e128592521082b30061a2e42309488901..649e766572d73e58b88d167c4dcd5abbaeafdfb7 100644
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
2.45.3


