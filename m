Return-Path: <netdev+bounces-164529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 623D6A2E1C8
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 01:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DEE27A212E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 00:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B50AD21;
	Mon, 10 Feb 2025 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cLlVVVPe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8E632;
	Mon, 10 Feb 2025 00:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739147623; cv=none; b=oGMZJU4YUu23V+KRiKmJnSVITK7jCpiZxDVjrTUKP3h0wvs1k/WQx2ftyIQIZGGrrVe8cvLHkvPUcYLRiftorgfTM+i2Lb4TKb25IbeMU/oErzxc8HOUkDfQpHLfsuWEx57/o+ut7U0HbZ7Jl3BodDf3Nrz7eRzaH6tLwY4N/cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739147623; c=relaxed/simple;
	bh=/igThWQZd1obWiTXszq65tIOC8QyzYqUXzxqyPjDKWs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ujsSQd+IcjXNdNa0Z7V+IPuNmw7/S/BlD20f8l+iRJdwxASKF++RrwdAyAACMHPG3+yyIRlU+CRW58IBYzDnHD/CpSY8KUCn99DrUPgedXuoEKNrhtc+BZohZ4KjJ4kIbjjeevq90iPS+y2cdGh0Qa/LMeuD0PSMY77CoBcAwKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cLlVVVPe; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5fc0c7b391fso1123018eaf.3;
        Sun, 09 Feb 2025 16:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739147621; x=1739752421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fzm9ukSWXeN4BhmkAYPVWf/4ojQPtcjcxM7QmAoeOIU=;
        b=cLlVVVPetU8akzBIstCKj9fNyvki6/8ctIk7N2ta9mRizkrM3fG58Y8067kvioShjU
         kUts6h/6Rlx4NF3yq9ibnz13b5WUWWZO65Ljf1AYxBF2ptD140u6QMJs6zJth0vuLVz9
         5+Agdpjri7nNiHokUwG3rmBUq5iOii73NfqcEyxgGP1DY7eBMHd5OYbgTHGmHtZR+Tg6
         shk+K0QYO+pDg9hXTJdfonQ2pwL8DPI62QGKgtAGEaLq0f6JadaXNZFVAZUvwBxl4gL+
         Jh2gsGEHVzsjx4jsgmFZz7hIxIjgcsIx9Bfx5LSAqYUaqvwClXXwDWQWGcU8vnmK8/7b
         sovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739147621; x=1739752421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fzm9ukSWXeN4BhmkAYPVWf/4ojQPtcjcxM7QmAoeOIU=;
        b=SDNKkGBlQ/wKgQIhVJ83E4muVMjpodDuaZBKRwUvNvuKWJU/Ir97ZGrDPEDgVJptl6
         N+mAFmWKw8YN/OD3vvCHlZSRFycJHO1ZFPjuUdppwII1cHOxyJeBuQ6V/y1c7NCntGwy
         8y+d8H3jSMlWhDSfF6iRQtEXrtEXjQafSuEma9wHFg0fFBhTI/57L9u++NFSbuMyYqj2
         hAykOFuJNC91N2zpqK8o+Zb4tvpKhaFtrZ8mqldZXdYIDMXUnTMjAGIo0H7TJWQsj9Xg
         /QT7dKSLTQq8Q4EHZ8y7jMXE2JSx4J5dsRC9Vsc5KJEyFfclFiV6XanW2J8sHXQ14Tyg
         FBVg==
X-Forwarded-Encrypted: i=1; AJvYcCUCTYf34WzBa9mGhXc4ZURNIJjCrxwg/O9vLCkJX3j22akCNvKe/3discoNVkDMNiZUx81iMsGgft5vfTs=@vger.kernel.org, AJvYcCWpMmfAZ+H1A7zuuHdra0SiSoP9qLlMM6HHEK1NqbUyKXcAenEJiSey9wTSReTg/DUiFxip6Wmc@vger.kernel.org
X-Gm-Message-State: AOJu0YxP2q/3FhYECx97WzouXjOgLQHXN1AlbCTRPGPDT9u93RyBEFbb
	zVFvuLeqHQQ2AqQ7I/jo5mGmJg5oeaAsFX/fDOHyXqQueoHKKgVY
X-Gm-Gg: ASbGncvWKC0mBPHbyElhSMWxQzYWgFi99KfdQPC855TCF9bqSBCfUtSYNNDdVwWdlO8
	dYyCp12i56pfU1n3JYTEHVp5AAvRnPIxyYLtRUOb2vNcEfwelH3zffHmc83l3h9j4+pJz5wk59X
	njd6v7ixSM/jrnbzI/lU9jAIYi4c85zwx0UwEXewmUP81IETQi/f5m0s8AHVD23yyle35cjQsO3
	jQzZ2bybIqVNwY9pZ1+L4S8+VkA0qCZqm2u8tujDuIECa+jS0Jqmz+uLkbOo8xOntJsjp1o1QQX
	+pUAXpf3U94sQ50i8SydsCTMAaQCf2laR2AizbAUn51VePUhp/bohifQKuVru9pibky7a+OMLI/
	qbUBTPzXAQOxwxy69
X-Google-Smtp-Source: AGHT+IFclqOhIoMzNRCRdvbrza/dG7hfwwDGnWsOZ5Xa2VJUYmlDQu9qeZF7/m09obrp0XPNPJSkcA==
X-Received: by 2002:a05:6820:2208:b0:5f7:d455:16c4 with SMTP id 006d021491bc7-5fc5e70f35bmr7341630eaf.8.1739147621107;
        Sun, 09 Feb 2025 16:33:41 -0800 (PST)
Received: from rhel-developer-toolbox-latest.redhat.com (c-71-56-251-26.hsd1.co.comcast.net. [71.56.251.26])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fc544b0560sm2157779eaf.6.2025.02.09.16.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Feb 2025 16:33:40 -0800 (PST)
From: John J Coleman <jjcolemanx86@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Ben Hutchings <bhutchings@solarflare.com>,
	David Decotigny <decot@googlers.com>
Cc: John J Coleman <jjcolemanx86@gmail.com>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ethtool: check device is present when getting ioctl settings
Date: Sun,  9 Feb 2025 17:31:56 -0700
Message-ID: <20250210003200.368428-1-jjcolemanx86@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An ioctl caller of SIOCETHTOOL ETHTOOL_GSET can provoke the legacy
ethtool codepath on a non-present device, leading to kernel panic:

     [exception RIP: qed_get_current_link+0x11]
  #8 [ffffa2021d70f948] qede_get_link_ksettings at ffffffffc07bfa9a [qede]
  #9 [ffffa2021d70f9d0] __rh_call_get_link_ksettings at ffffffff9bad2723
 #10 [ffffa2021d70fa30] ethtool_get_settings at ffffffff9bad29d0
 #11 [ffffa2021d70fb18] __dev_ethtool at ffffffff9bad442b
 #12 [ffffa2021d70fc28] dev_ethtool at ffffffff9bad6db8
 #13 [ffffa2021d70fc60] dev_ioctl at ffffffff9ba7a55c
 #14 [ffffa2021d70fc98] sock_do_ioctl at ffffffff9ba22a44
 #15 [ffffa2021d70fd08] sock_ioctl at ffffffff9ba22d1c
 #16 [ffffa2021d70fd78] do_vfs_ioctl at ffffffff9b584cf4

Device is not present with no state bits set:

crash> net_device.state ffff8fff95240000
  state = 0x0,

Existing patch commit a699781c79ec ("ethtool: check device is present
when getting link settings") fixes this in the modern sysfs reader's
ksettings path.

Fix this in the legacy ioctl path by checking for device presence as
well.

Fixes: 4bc71cb983fd2 ("net: consolidate and fix ethtool_ops->get_settings calling")
Fixes: 3f1ac7a700d03 ("net: ethtool: add new ETHTOOL_xLINKSETTINGS API")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Tested-by: John J Coleman <jjcolemanx86@gmail.com>
Co-developed-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
Signed-off-by: John J Coleman <jjcolemanx86@gmail.com>
---
 net/ethtool/ioctl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
index 7609ce2b2c5e2ead90aceab08b6610955914340b..1d7c72d7bb9a0fcbb8d47556ec3173440db32447 100644
--- a/net/ethtool/ioctl.c
+++ b/net/ethtool/ioctl.c
@@ -659,6 +659,9 @@ static int ethtool_get_settings(struct net_device *dev, void __user *useraddr)
 	int err;
 
 	ASSERT_RTNL();
+	if (!netif_device_present(dev))
+		return -ENODEV;
+
 	if (!dev->ethtool_ops->get_link_ksettings)
 		return -EOPNOTSUPP;
 
-- 
2.48.1


