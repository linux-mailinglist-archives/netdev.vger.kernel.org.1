Return-Path: <netdev+bounces-149845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD479E7ACA
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 22:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66074286E2C
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 21:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF35228CBC;
	Fri,  6 Dec 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Zne3Ld4o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF225227561
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733519952; cv=none; b=ckqjvxvUw/Y6YvZ/13ZQfHK0TTXVVqU9OhmCI4QfULcHmj7SEZmlkNsjaxQ2mKnPBwb+UmaMcYylBzg6KR/z8p5XmrjV3BERetWz5HLI1b3wKnHPPMyI7sMBd//ablaWBxl5lSKrpZSMZheyOEPNnfm3IY9ecyraVN1EplS7ZyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733519952; c=relaxed/simple;
	bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZIO4SYmFyZHWIPLvEBo8kb12nerd6ha6kOjwbtAfFqmJQ1V5hLPeBwXFpUJyg0LLnARp0WKxlYqK2wAeprUFL21l00Z5lmI4H8jhrrZUtSQ4xsb28bnw9HJReJJqX0ZpJi4JM5HD36XpVvcRQ5AUhCrFD+2hLAF+VqpPn59++VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Zne3Ld4o; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-385d7b4da2bso2167310f8f.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 13:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733519948; x=1734124748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=Zne3Ld4omp0u1ceXyw8A35ex74usasrP5gPYSoT4Q7bqaA96jPkbJnVh4iqfD7WbJI
         zIgS1EMp41wtZ9a7964cHfUFpE6D/YHdT+esDb4PLo38ZyZn4fE62d7Tsg/hsOEiYUN5
         HPc2M7smr47LhwcurPRUtxIlADHaxtcgAKyGKWAnTx400nNuO1hTJX0E3nKBVn/1LZb9
         C0fW4vBIbAC2qUgeZrQkDFoX94rFWVraAQ7aFv8oL1g0bZ88qhcNcdDMMQAKA/QdY53g
         i4f9KEbhdpzFSZid+I3ckcim/TNnYXxubOnVcOw+xi1CudtIXNxops9Cpq8Aoi6DIIyU
         PVGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733519948; x=1734124748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jb7KHSQUPGhy5o0HEst1Kbqk3ULde1AaGrsUDUj2wbI=;
        b=AneGM/dH7wuDoJtk2CaJLqsuWL7A2xKcsGhjOUnUkwcHMR5yZpKNx1tnKKzrF71kGL
         GnqHdbjysbF8NV7UQ7Ld+/JOr75toZXbkjJAZKuiAuTzVzeWpk5XXfmpnqMrMOalaQ+0
         a39LCRCf55f7sL9cLSFbBhcpiLlywy3jEXzdjkvvCYTyob9me7C+Fc719Uos6hXnQr3J
         0GpNK/NWULBv+nqYYpnL8Dm0FvYvbGTxYb5wIIB8Jdbd8+m2g7nsJ56Wqf1Rkt4T5n6e
         rF0EXdyPCeKgYWWI2WZ9bWB4lVCVLSNg5bdG88on5i9Nbgq8RRvRiXbyEQ+GFsGHyJEP
         Rqtg==
X-Gm-Message-State: AOJu0Yz2Pdu8z27qtZiwTwXEe2aC29qvn1BBZuhJ7FdGpxgxO6xj93WT
	9eqK8usBS7yOg3ypdzH4L8B+ZLzXQh3z9I4h4p3IW3hbQVwmVjO+O1s6+KwMMP0=
X-Gm-Gg: ASbGnctbyiWaio1b90s5mUu1E0CUI8NxV5mM7I6mYMVJQwjGATCP9T1Ka+rOatPOveL
	W8vOqPHsOE/55dNtz88MCXHMsEqtrk4AfUKvEy5zVhO11WwJ03ncwWa+HZnr8IkVA1BMBQLTyst
	9LYTqJPnxFftUAsz9oUF6rSAo545yGUDAXUA391EEpM5VIaDTZ7GU7eZRmZndjZ466SJ6qu/68P
	VJAJgkpGKrX+80EMU5nGQjc++tgdaR9RgmuMa+V9JkusbDy1txKdMllIBa13Q==
X-Google-Smtp-Source: AGHT+IFUtBqb3ICYhyZa/SFeIsmZYtiFaEEpUP7mRnVfVvusILtWZUJ97EnWxcGKIqTG8boUZd0yKQ==
X-Received: by 2002:a5d:6da8:0:b0:385:ef8e:a652 with SMTP id ffacd0b85a97d-3862b3e30fcmr4466988f8f.56.1733519948055;
        Fri, 06 Dec 2024 13:19:08 -0800 (PST)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:3cee:9adf:5d38:601e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861fd46839sm5441302f8f.52.2024.12.06.13.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 13:19:07 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
Date: Fri, 06 Dec 2024 22:18:46 +0100
Subject: [PATCH net-next v13 21/22] ovpn: add basic ethtool support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-b4-ovpn-v13-21-67fb4be666e2@openvpn.net>
References: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
In-Reply-To: <20241206-b4-ovpn-v13-0-67fb4be666e2@openvpn.net>
To: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 Antonio Quartulli <antonio@openvpn.net>, Shuah Khan <shuah@kernel.org>, 
 sd@queasysnail.net, ryazanov.s.a@gmail.com, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1699; i=antonio@openvpn.net;
 h=from:subject:message-id; bh=W5T+iVYKaPmO/gOfKB0RnKXCUMfDvh3g/zI0cvgMIlg=;
 b=owEBbQGS/pANAwAIAQtw5TqgONWHAcsmYgBnU2pYBycUwK6W/nE4hHdW5xggEUD8kuoUUo8gu
 9HG8BxqBl+JATMEAAEIAB0WIQSZq9xs+NQS5N5fwPwLcOU6oDjVhwUCZ1NqWAAKCRALcOU6oDjV
 hybPB/4k9l+J3Qty9sNx9W5Y2YX/fymwpsUVnPDgaDRnZtPee0VGl3vRei/dAAn6ualWkoOXe79
 BRUs/eZSjNSzsFe0rQctYAx87mdYLv+vU/0dCj+mSNtNTffTUvbOYopXvFJNMMM76cy9dK8LVUm
 9CbsbvMM1ZXPct2BG8jTFJgTuLN2atJSXUZjjEH7ytvaEpYjNFUw2MbOWdpeivblIhlbZ3sAB7f
 VFRC3aLA5YB8MxFGXdiHUcJHH9JkOxkSrc/HOFs5KQqwOtiYlBNTnN3uSi9fc3LFMhJbuAfVf60
 1wiTXMUJH+hHZvMPaPAzCG+CrFUdF9wb2LmMTMO+6cZmOCGS
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
index 6b3a59e75e5aa918b28957c073990be9fb1d2124..6a828728d4f98f84e39ea429a8b76069c6d83e69 100644
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


