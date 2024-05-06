Return-Path: <netdev+bounces-93579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E44A8BC55F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9841C20E39
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 01:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE8A4CB23;
	Mon,  6 May 2024 01:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="COwWduZv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3354D9FA
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 01:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714958166; cv=none; b=RTw9rdKa5gkzYGuzO/Yjc0gADwhIZpDnrgBGySUhnx/+2mYXCBanCdETrdjSVXlbs6NJyjpVtyDj4aPq1tJKq6OLHo640/ag0INM3U0rzPt9ziLiHkt9epwyKAGrMmxRpHaCGOxXIzIzBq4ncWR8LRYLlNBM/wsHMcj7u3/LKNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714958166; c=relaxed/simple;
	bh=VfrmnYoDrcgRtjKLEf0hKG2o52Bu0QOKwtCVhPGYlaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rmaATt2tBfIjK9NGPX0tEpuM7slaVOMaanQQElFW4AhNwsL6p7w2vZINBaVKB4byfvXEE45+veYw7T1pIixrcr0cd0iFt44lYKzBWyRuynpoqc+lD2ea5uD3dciEcIMrfzXG7SIv5K3CH3vJehCeMcyYJRmdzDqEhgK5mxKqO3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=COwWduZv; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ecd60bb16so5471805e9.0
        for <netdev@vger.kernel.org>; Sun, 05 May 2024 18:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1714958162; x=1715562962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dmnlAoiH1hGDI6ejHZsr25rQXeI5w/yXG/2a3IoX5Es=;
        b=COwWduZvO9wvPoF6CyqHoq8/SW4HNBVANv5fAkAJKgPSY8dkKePM0qsKH60ekP2ldu
         yC79yzhwlh49VOHHUfg23xyv67ppKmfrN/G52ll43YyyB3q8dYMoOrFBAxQhb7iwqiaP
         fFQM981aan+OebHouYkn8N8wtDLe1dmF0cujG9gjFkOOLwB5+lk0T2oivBDHdiytuDUU
         rhYFjQmBP6VCV3Z6eLuYAjVHpXiOQIJqHUuCCDLWuFbsfKXFVp6WcInpB8rmomBR7ufU
         KolPKG5Pka00AqSNOJ9stbD8RYMqnxP4RZtBiXmiEihGt//67Gab2wRQYIgZ0vQTcOy4
         IrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714958162; x=1715562962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dmnlAoiH1hGDI6ejHZsr25rQXeI5w/yXG/2a3IoX5Es=;
        b=qHI0fWanBeoglDv+nhNpFliRjFFTaMlKVMoqAUGdASLAbUBtc7eOjtW8GWJaun8CRL
         GxpQSgpIoYTVZoQ33XMCPzRCbtWKsIm6IG7jUPwFY8uy3ljSjHrMaptidoT8sukmL+QY
         jWfy9cWO1ubj7ftTRJgGYmDB2wjpKlyYBhpbSaGwR65f5X4ohmWEYWMV/sMIF62Ay4dM
         wy9Mvgt881l86KXcNblHZp7h6d1EZMYi6DSOwr0FCMLLH+Q4ljixv3/ZAdITGZtTLooY
         VHJRfD4F/vrxxzNrpsHUnGRz3wkdR3A8sGLg+Ymw32blOt+m3zDIBX7bgiSrh8MqVbwa
         m8rw==
X-Gm-Message-State: AOJu0YzTZqTaGAiIv9oTwy0QqUB1QOaiuOXYqmDfLouukWvJ92rqLgsT
	eNV2ME8V7x2dsPCkD0wPcJzhDQkWNcBh1Hu+9T+DJoe3thzfaAmV22CPhEgaZPqbYPCrQvAhX1e
	i
X-Google-Smtp-Source: AGHT+IGpzH9oKX6izVsj40Skqcb6DgMiJmpC9yMGWcKBxGcanXukzoDbVeXTZovhU1pdA8f3lnj5Aw==
X-Received: by 2002:a05:6000:142:b0:34d:707c:922a with SMTP id r2-20020a056000014200b0034d707c922amr7617887wrx.13.1714958162615;
        Sun, 05 May 2024 18:16:02 -0700 (PDT)
Received: from serenity.homelan.mandelbit.com ([2001:67c:2fbc:0:fbf:f0c4:769e:3936])
        by smtp.gmail.com with ESMTPSA id n8-20020adffe08000000b0034df2d0bd71sm9363621wrr.12.2024.05.05.18.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 May 2024 18:16:02 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Esben Haabendal <esben@geanix.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v3 23/24] ovpn: add basic ethtool support
Date: Mon,  6 May 2024 03:16:36 +0200
Message-ID: <20240506011637.27272-24-antonio@openvpn.net>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240506011637.27272-1-antonio@openvpn.net>
References: <20240506011637.27272-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement support for basic ethtool functionality.

Note that ovpn is a virtual device driver, therefore
various ethtool APIs are just not meaningful and thus
not implemented.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 drivers/net/ovpn/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
index d6ba91c6571f..17ccc9a483fe 100644
--- a/drivers/net/ovpn/main.c
+++ b/drivers/net/ovpn/main.c
@@ -7,6 +7,7 @@
  *		James Yonan <james@openvpn.net>
  */
 
+#include <linux/ethtool.h>
 #include <linux/genetlink.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -88,6 +89,19 @@ bool ovpn_dev_is_valid(const struct net_device *dev)
 	return dev->netdev_ops->ndo_start_xmit == ovpn_net_xmit;
 }
 
+static void ovpn_get_drvinfo(struct net_device *dev,
+			     struct ethtool_drvinfo *info)
+{
+	strscpy(info->driver, OVPN_FAMILY_NAME, sizeof(info->driver));
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
 	/* compute the overhead considering AEAD encryption */
@@ -102,6 +116,7 @@ static void ovpn_setup(struct net_device *dev)
 
 	dev->needs_free_netdev = true;
 
+	dev->ethtool_ops = &ovpn_ethtool_ops;
 	dev->netdev_ops = &ovpn_netdev_ops;
 
 	dev->priv_destructor = ovpn_struct_free;
-- 
2.43.2


