Return-Path: <netdev+bounces-128619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA1D97AA16
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 03:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22E98285EAE
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 01:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F05F1B813;
	Tue, 17 Sep 2024 01:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="JK6YuR/a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46361A95E
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 01:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726535284; cv=none; b=GgUCy/c6gaFgtJxo9zk7SSTRGzc2sYsKxKsp6HnfH9/w81M5WByXHxkq8Kx+nxZPMMjg4TBhx3GUS8nB9yYhN8aGcbeicRRrX5yX5NqaYIy8e6U2FUHsZL1Udxnog5LASga+axguITUdNMulcC7/fWadqv3mOJqLo+DeAvWji1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726535284; c=relaxed/simple;
	bh=CT6ukuB/cYH0nUxu0ecRzSYQjlJH5Q+CKfG1graPoCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DANaPJZ4aYkM8y+ukTLl43Enk0Jvi5lHA7i56zrc1uFbgxjH6Uv+CzGQyVgAGLdtkv0ZmbjDBCpVUS/ggQBhhoh3kU1rzKaczGKzQHQpVYi39SZbxJLPVJLdJ3JaqRigzjKqtoFtKUoDdb6ILEACV1yW0nHqKG0La5AMlSsXYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=JK6YuR/a; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374c1963cb6so3447526f8f.3
        for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 18:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726535280; x=1727140080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wo+AzPDBlM39ZsyClk3eZn/8mh01kfwXtq1C/xpQE0Y=;
        b=JK6YuR/a6CPHSuX9y5Rf/lKU88B3tiEBuiulCA0SM3iPhn8V7vnc1Pwpmq8lO5zunF
         Ges8abnW36HtRRZZCOdWmOJ+r6WBnXbe4Y1ZtXuaNnXpYBxJtkXKVwCh+ju3lGXZwfdf
         TKvMQPGO7nKX1QZQytFCuKvSqcDri5b9LhE7Z+9dSiLYmrTrMiklqnkUwILuUXChH0EJ
         1bFTx93VhwNdisLVouj1g9qg+cN1U/5gxaQkWkQaMEd3X4/q+n2gX5XM52da084JhEAz
         llZV5whWASg2Ra/Zoc1/aEhYaIgnFoJZ6cupd9/CwqaFsNQgUKQlgQr/OCggWJpmWP88
         JSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726535280; x=1727140080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wo+AzPDBlM39ZsyClk3eZn/8mh01kfwXtq1C/xpQE0Y=;
        b=rF6UydzbQ6uz/+qInsjAynwB/PxAzNvEJmQNLDKMh9owexMXV2F3fiBo2DmbXKBBIV
         0spTDKNit+As1kWfCUqthyl/Jc3K62pPdBghhj8G4zR4b33mj12z9aRu5Ed7qpMGF0Tl
         s/MiqDiH7THgyICv1hx+vds794+0VFU367XDfPGfBP2qpCkSI2DfTeifM0CDK5DYulIa
         Gi86sF86XKGcnSvnrQPG5lJPRP0pcZiHdXfhkP3Pxhe7DTAohRsheoVR6xdAMfPu1H5Z
         F0uSoRGRepZaa93MmSzKB3h42iQxmukkW1/d7FasKBwc4RFo/N3E0YPNncFrDmXaLBdF
         tr8Q==
X-Gm-Message-State: AOJu0YyxAYgaU4A2LLVcE/m3YSwQfPd0dhGRzbSN4ksmBIbFyGclsm+k
	WAzRKaZGmFp/bxZkgzdI5vSwRbRzQOoWl+/l1JJtfVc0zcM522xIji0aLU9E+7vffy5o6xreJo5
	0
X-Google-Smtp-Source: AGHT+IHFwoF5BRnPvQu1ScDLHpX0eGHYRS0MMbkpdpScCW8QAjxHikNx3DVwHatphVmbqwSJobvwxg==
X-Received: by 2002:a5d:4704:0:b0:371:8319:4dbd with SMTP id ffacd0b85a97d-378c2d06272mr9482901f8f.17.1726535279539;
        Mon, 16 Sep 2024 18:07:59 -0700 (PDT)
Received: from serenity.mandelbit.com ([2001:67c:2fbc:1:dce8:dd6b:b9ca:6e92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73e80eesm8272422f8f.30.2024.09.16.18.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 18:07:59 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	ryazanov.s.a@gmail.com,
	edumazet@google.com,
	andrew@lunn.ch,
	sd@queasysnail.net,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next v7 02/25] rtnetlink: don't crash on unregister if no dellink exists
Date: Tue, 17 Sep 2024 03:07:11 +0200
Message-ID: <20240917010734.1905-3-antonio@openvpn.net>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240917010734.1905-1-antonio@openvpn.net>
References: <20240917010734.1905-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtnl_unregister_ops calls __rtnl_links_kill which calls
unconditionally ops->dellink on any related interface.

However, if a module hasn't implemented dellink, this
invocation will crash.

Add a check to avoid calling dellink when NULL and rather
invoke netdevice_unregister_queue to schedule unregistering
the device as usual.

Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 net/core/rtnetlink.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f0a520987085..7e7fcd319af8 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -453,8 +453,12 @@ static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops)
 	LIST_HEAD(list_kill);
 
 	for_each_netdev(net, dev) {
-		if (dev->rtnl_link_ops == ops)
-			ops->dellink(dev, &list_kill);
+		if (dev->rtnl_link_ops == ops) {
+			if (ops->dellink)
+				ops->dellink(dev, &list_kill);
+			else
+				unregister_netdevice_queue(dev, &list_kill);
+		}
 	}
 	unregister_netdevice_many(&list_kill);
 }
-- 
2.44.2


