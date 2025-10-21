Return-Path: <netdev+bounces-231142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1668BF5A93
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 11:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90120405A6B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBE52EBB9B;
	Tue, 21 Oct 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YGmBDpIj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12D528725A
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761040659; cv=none; b=t3WhmsRX6RgVAOn6z/TjPdJquksGEbr0GkfGK5DiimDMQC3UNQzYTWmRCyhbvdAlKuYYoA0+b49j4pTazOj2KU1r9U39vTbVvhwEL2KjcUIitjniiedyMYJa3WenRcdqsus5n/S+yD6jltgMtKOaWp8YAPknStoOgP7e6GXimaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761040659; c=relaxed/simple;
	bh=3rHdcF1gkowZn0MaD0PIbEANXOSfLSax16NhvoBYzXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DNoWxWZRltmRZVHFb1OZaubdIgbIJFoil4GLhklGy7w8lXRFFg7g5DPv4F0c40KaNA9j+vqcDKFi4r0hhdMvYSGWkLBDj3OD6MGPA2w7z3OAFxVN82BerFqpzSNor3NwsytYumc5KApQ9FpEw6E63vL/nqjlSULdhCsbihyxruI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YGmBDpIj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33d7589774fso2931582a91.0
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761040657; x=1761645457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7sC9oR3m4VtzSoHRqoSz+2ga+6oLEF4co52Cu8N8glo=;
        b=YGmBDpIjP056d6WZYU91Do1Cm0YrE0JXvBnNaicvfvpXogZjB7adxKPyUlWaAKZBId
         WN28oXhBt0Dt2nPAqOfXLjoPLmtiNLyXDlOnG44c4ky7YsfryEj6FZk+adfLf52ZQoK7
         3XTwKYymIP1jGUiYfwTPAbjFJrY9b0AES1hFjbvYlA+l2i7zO2FSMzuDaKm0/oLD6QdE
         XRPPm0VAcI8jVEh5pMdQ63KOM1st3sA5pixXyNlVVS7nwvVDPwwVFjbLvZg6N1xSlGrF
         Cn2mMbA/DAF+Ml00DWGfdpEvBCGxHroJ2mV7Z247PMTNXx4JU2ljTZ69yIAqd504Wn3y
         Zl1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761040657; x=1761645457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7sC9oR3m4VtzSoHRqoSz+2ga+6oLEF4co52Cu8N8glo=;
        b=VFxdyUPFIvoR3s2OexO/t1eO1UA3M4sgP9c3I60WXPmaaK2q79jX2x4cTwY/A9RM9q
         MpN7ZtSxOfgMmKJsARg5a6URlIfO77vNmEqJESZalXYui2J89d6/AmS/nc9mLn3z/MKP
         JbJpKOMrbUvnACJUmKXut/VBXrNnniEB+1nZf0wf+XWcXGjfnGhga9ax5xF82fsoFxWy
         PmQNSNawjYwjKmw/j8LnYuoIoPXCBsAqJMoOiE9jIH2AIVY1xC8wiKd44fkIDzVyzi8H
         W7KTZlCrVUnldQ75VnPUtlhcYyibaP0PpLCzKNjNODuPBm89NyFd9B4h7IPIB+4qXEeT
         QEHA==
X-Gm-Message-State: AOJu0Yx9IJ65fke9zLWR7Vfu6lscdKU2bVZcuY+WOUshwMPus0aHQx+t
	0mXOa3XssS+0rPy/cf6rBKe+7HRoSD54ymlKI0PSGyKcU1WZx+sHtX6HZh4/pxStW60=
X-Gm-Gg: ASbGncsTrsTfXwAGFccrnA/UpCe9uENGSCCoBccY1gGhxVpHmqDpv2g5YB8BihkTXRk
	iboyOpxnGKdAbiri+OiwdRC3u7cZ9tzXz/IrLVZcQdF/KPZ0QuDUIvxpNMOiaSrgXlOIawnkZdZ
	G/pHWM7gR4lJgb5hK0pMsk65BGUPKcYg20dFxLCQs35g8iY/nPzzlAZV7PCQ9UFoM2XXBSABygy
	JQahWM/uXO3VoKuVf9p6kzve7NHV395aaTUWg2WazlSVX/yiOVlZPKx28fT8VWd/FVpVWq0YOrr
	2eSPUPw70fweM5BjiZ5W9n9Nlw4bvDnQc52Rt6DvJPRQTETRX5Sy9CaNoV5U4KHj9FyrwITf1Fo
	oiarWuo9kz+tcwMlQdJwmFfwJroLdw+lshXOHhTtEwxKfreAKJSXENMEiXlOk9M1NHWhdD+GjqB
	KQm3r+iGUAOX2obKo=
X-Google-Smtp-Source: AGHT+IEglQrz1zljoE46soPg8HDaXlilgAqH/So7w07dITCXiNqVjLxHnBo8xfPWys0sYVgI3S7INQ==
X-Received: by 2002:a17:90b:3fc6:b0:338:3dca:e0a3 with SMTP id 98e67ed59e1d1-33bcf87f8b8mr23748112a91.16.1761040657134;
        Tue, 21 Oct 2025 02:57:37 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5df5c2eesm10634540a91.13.2025.10.21.02.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 02:57:36 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Dong Chenchen <dongchenchen2@huawei.com>,
	Oscar Maes <oscmaes92@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net] net: vlan: sync VLAN features with lower device
Date: Tue, 21 Oct 2025 09:56:53 +0000
Message-ID: <20251021095658.86478-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

After registering a VLAN device and setting its feature flags, we need to
synchronize the VLAN features with the lower device. For example, the VLAN
device does not have the NETIF_F_LRO flag, it should be synchronized with
the lower device based on the NETIF_F_UPPER_DISABLES definition.

As the dev->vlan_features has changed, we need to call
netdev_change_features(). The caller must run after netdev_upper_dev_link()
links the lower devices, so this patch adds the netdev_change_features()
call in register_vlan_dev().

Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---

I’m not sure what the proper Fixes tag should be, so I’ve left it blank for
now. If anyone has a clue, please let me know.

---
 net/8021q/vlan.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index fda3a80e9340..4857fb0ee11d 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -193,6 +193,8 @@ int register_vlan_dev(struct net_device *dev, struct netlink_ext_ack *extack)
 	vlan_group_set_device(grp, vlan->vlan_proto, vlan_id, dev);
 	grp->nr_vlan_devs++;
 
+	netdev_change_features(dev);
+
 	return 0;
 
 out_unregister_netdev:
-- 
2.50.1


