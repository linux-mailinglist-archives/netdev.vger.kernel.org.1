Return-Path: <netdev+bounces-166044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EADD5A340B7
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 14:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE5F1882C17
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED0923A9AF;
	Thu, 13 Feb 2025 13:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fM3DNAfv"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8484323A9A4
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454348; cv=none; b=gcrkovEQQCE7zpgII4/sN3qv0/GSzeN21RSr4aEQj22ec5/WuA8gIfA2HroTr45JLbCcjQq/PETRL79ZvPVwMEK5/2p2ce8HRW74OY9oBzU9i3UH1DSfodVTbqq5uXT3A1ZB0BuMDRwH5UPS7a4mVr4JsWtnjjtNWy1EWvMcfYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454348; c=relaxed/simple;
	bh=HOfco/xdCYia5pNHZITyjejL4RpeMLYBGAKJzbbPo+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=huLpnTl4yPHrvXHrV9u2FTBcQII0NI7P3WwR9DosCS4n2VDdcAs5D13pnyOxJdvkOP6MxyDVDrAE7izgYrFyG1RJe+hUeBBIuP4ThYWe4CMvTw57tAO6lpJuxOxTzwilLjy1M+Tw0hr242EZQ/UohTyE8IO4HrDv1q/0Sy6qekU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fM3DNAfv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739454344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zGkN3kWzRsqdFvrTMP8CHR54/ajUPf3F7octssbtusQ=;
	b=fM3DNAfvHm04Pzf8B3h1NjhwuddWfoD6awHzdKXhZJ4eXYegxlq25Mpr4LyREr5DFNTYjw
	Yvm+j7cUFQOSo5RCP1ApS/HBUB8R0I6UW0pbn1ltz7njqcGz3kKDQ6WWnCx3DyeTxXGNtl
	xNpIb8Xa16DrILhS0bO4DGB81PJ7HQA=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-pgYPw0-0P2y23ZiA9HC2VA-1; Thu, 13 Feb 2025 08:45:43 -0500
X-MC-Unique: pgYPw0-0P2y23ZiA9HC2VA-1
X-Mimecast-MFC-AGG-ID: pgYPw0-0P2y23ZiA9HC2VA
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-5450c2f98b5so478145e87.1
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 05:45:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739454341; x=1740059141;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zGkN3kWzRsqdFvrTMP8CHR54/ajUPf3F7octssbtusQ=;
        b=YG+CBYwipLyuOd/hcJhCJSwMbWVipHq5rwYdprSSec7NrtaAyVZSVoAliOMQK57Zpr
         WGooQKKexewqcjZJw6tJOqWE0EbvV3yJ9xDmtxu0t+iA62AS6soSl+pSSkGOpHPeFnfc
         lDapgShppLH6Y7Sq84m1jazozGVaAsLkBc7m49Y5Z393Rd2dAERTL3XRuwUB7pTPIS+s
         ELK0PS7QC9je6mnAvk9TusdA85QbYnGfF4UiwaGx7mhuEW4uIlr765y6XEtTFHKqAedV
         4WobXC2n6uTk8YksAedWtYhdyBTSyH5BKcNj48hDvtZhIY0fInMHlBuHRWfVf8r8WOVz
         4Yog==
X-Gm-Message-State: AOJu0YxMQeZQY3xmX9Qpj5RgiZUqiYPF0zabimvKoRC+K/Mrj2uG+Rje
	Zsos2vdclVnLfRE2LPX4jsHocl2q7mL62cbRMuF0r4bfRfWr6GzrnctunXAxw6CDVT//TBkH4FO
	zcbBwHWVaevznTIrRjfKF4t9sQtLAb+PcfsM70k8u0KzA2cLH2Y3nPw==
X-Gm-Gg: ASbGncvuy4d93LebewZ9o+QpoJn2JjoVJvfnAaoEJVejcK9nKESCO23nYIwfBFrk+9Z
	5FozBoeLtGJl/j1ddEzMDh5fs6zGSqPccvxjfFIbztD/JBDvhQgDs4MeoUobebh+kvnqdV5XSFi
	XyYoz69rmH/s3zPtATIcSl0sbefleboBYfY/ELoR+UBd1ULqrTze0x0Y345tr+Lcw+OjGiaUlNx
	6CaFm3sLqrZJiVABlh+ubInwVvcubv21Knfndl09+a+ATE/OZe2uqnD0KqtEEDQ57BkhzYrYHrN
	gw==
X-Received: by 2002:a05:6512:3988:b0:545:aa5:d455 with SMTP id 2adb3069b0e04-5451810917dmr2459801e87.15.1739454341408;
        Thu, 13 Feb 2025 05:45:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAxReg1UL5YJhcCIG9CAFhB+U9nMViKVRFENgX39i/PqCoRvwnMTCNFlcXul2pyMgio72PqQ==
X-Received: by 2002:a05:6512:3988:b0:545:aa5:d455 with SMTP id 2adb3069b0e04-5451810917dmr2459791e87.15.1739454340962;
        Thu, 13 Feb 2025 05:45:40 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5451f09b31bsm176760e87.91.2025.02.13.05.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2025 05:45:39 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 03210184FF36; Thu, 13 Feb 2025 14:45:37 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Thu, 13 Feb 2025 14:45:22 +0100
Subject: [PATCH net-next] rtnetlink: Allow setting IFLA_PERM_ADDRESS at
 device creation time
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250213-virt-dev-permaddr-v1-1-9a616b3de44b@redhat.com>
X-B4-Tracking: v=1; b=H4sIAHH3rWcC/x3MQQqDMBBG4avIrB3QSA30KsVFmvnVWTSVSQiCe
 PeGLr/FexdlmCLTs7vIUDXrNzWMfUdxD2kDqzSTG9xjcOPEVa2woPIB+wQRYy9eYvBxju+JWnc
 YVj3/zxclFE44Cy33/QN+ak8ZbQAAAA==
X-Change-ID: 20250213-virt-dev-permaddr-7d7dca7c6cb3
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Eric suggested[0] allowing user-settable values for dev->perm_addr at
device creation time, instead of mucking about with netdevsim to get a
virtual device with a permanent address set.

The original use case for this was easing testing for network management
daemons that use the permanent address to match against. However, having
the ability to set a permanent identifier for a virtual device at
creation time seems generally useful, so decided to go for this approach
instead.

[0] https://lore.kernel.org/r/CANn89iK8YpzNhJv4R+x80hcq794bh_ykS-O-2UHziBXixNhzyA@mail.gmail.com

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/core/rtnetlink.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index cb7fad8d1f95ff287810229c341de6a6d20a9c07..38dec2ae1a19f91daf9200744c7497088ecc037e 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -2224,7 +2224,7 @@ static const struct nla_policy ifla_policy[IFLA_MAX+1] = {
 	[IFLA_PROP_LIST]	= { .type = NLA_NESTED },
 	[IFLA_ALT_IFNAME]	= { .type = NLA_STRING,
 				    .len = ALTIFNAMSIZ - 1 },
-	[IFLA_PERM_ADDRESS]	= { .type = NLA_REJECT },
+	[IFLA_PERM_ADDRESS]	= { .type = NLA_BINARY, .len = MAX_ADDR_LEN },
 	[IFLA_PROTO_DOWN_REASON] = { .type = NLA_NESTED },
 	[IFLA_NEW_IFINDEX]	= NLA_POLICY_MIN(NLA_S32, 1),
 	[IFLA_PARENT_DEV_NAME]	= { .type = NLA_NUL_STRING },
@@ -2647,7 +2647,7 @@ static	int rtnl_set_vf_rate(struct net_device *dev, int vf, int min_tx_rate,
 }
 
 static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
-			    struct netlink_ext_ack *extack)
+			    struct netlink_ext_ack *extack, bool create)
 {
 	if (tb[IFLA_ADDRESS] &&
 	    nla_len(tb[IFLA_ADDRESS]) < dev->addr_len)
@@ -2657,6 +2657,17 @@ static int validate_linkmsg(struct net_device *dev, struct nlattr *tb[],
 	    nla_len(tb[IFLA_BROADCAST]) < dev->addr_len)
 		return -EINVAL;
 
+	if (tb[IFLA_PERM_ADDRESS]) {
+		if (!create) {
+			NL_SET_ERR_MSG(extack,
+				       "can't change permanent address");
+			return -EINVAL;
+		}
+
+		if (nla_len(tb[IFLA_PERM_ADDRESS]) < dev->addr_len)
+			return -EINVAL;
+	}
+
 	if (tb[IFLA_GSO_MAX_SIZE] &&
 	    nla_get_u32(tb[IFLA_GSO_MAX_SIZE]) > dev->tso_max_size) {
 		NL_SET_ERR_MSG(extack, "too big gso_max_size");
@@ -3010,7 +3021,7 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
 	char ifname[IFNAMSIZ];
 	int err;
 
-	err = validate_linkmsg(dev, tb, extack);
+	err = validate_linkmsg(dev, tb, extack, false);
 	if (err < 0)
 		goto errout;
 
@@ -3614,7 +3625,7 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
 
-	err = validate_linkmsg(dev, tb, extack);
+	err = validate_linkmsg(dev, tb, extack, true);
 	if (err < 0) {
 		free_netdev(dev);
 		return ERR_PTR(err);
@@ -3642,6 +3653,9 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 	if (tb[IFLA_BROADCAST])
 		memcpy(dev->broadcast, nla_data(tb[IFLA_BROADCAST]),
 				nla_len(tb[IFLA_BROADCAST]));
+	if (tb[IFLA_PERM_ADDRESS])
+		memcpy(dev->perm_addr, nla_data(tb[IFLA_PERM_ADDRESS]),
+		       nla_len(tb[IFLA_PERM_ADDRESS]));
 	if (tb[IFLA_TXQLEN])
 		dev->tx_queue_len = nla_get_u32(tb[IFLA_TXQLEN]);
 	if (tb[IFLA_OPERSTATE])

---
base-commit: 7aca0d8a727da503a8adeb6866a136ded5bea4b1
change-id: 20250213-virt-dev-permaddr-7d7dca7c6cb3


