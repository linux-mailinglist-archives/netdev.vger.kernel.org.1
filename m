Return-Path: <netdev+bounces-220285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED58B452EA
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 11:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E5B7189A67F
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 09:19:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95C42877E5;
	Fri,  5 Sep 2025 09:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDR5eS97"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F424677A
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063758; cv=none; b=OwkcOmTwcrNPe6ZESbsjtj93HOXcrb69a9vhdGxukCPZBGePuGxJhNXB+dnhuB86jhC6QmlxWR8+Jr8PgIUgFXeOvbcVH8gXuKtAhGPBhiOA9pkV6H2/D+bGWun6chCP3YZt8P5DzbguCNisCsaPQppYLyyBlN/7tf+eAD2ItEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063758; c=relaxed/simple;
	bh=Wwy3ruCuqfb2Hlf7FbvX3uSE6TPMdE9sCWYuzX7xZcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=suQM7Df/MrwhzPDQ87u99tghwij0GFTjqecq11pz9TVnISQF6sJZQBhsqOvOhp9voIKdJGCZvhZ56bssbrMdXwsOzcP2Hknr/sE8sU4E00MQRQyJTkCl87n01icWHagqw6NljJh/YbqdcHEzdgcA7+mCy0hTF5qVv7fTA2bpcRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDR5eS97; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7724cacc32bso1543256b3a.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 02:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757063756; x=1757668556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OPKMG3e9ZReQgWt2V8//LK/vnJHBqxfQ5zALcUNLE80=;
        b=PDR5eS97uKrnWOVKb46baJ1yWtQ890I0HdrQaelTyt7uAudyZgv+XL5SQkyHj2hUTK
         GXqES2qNt5zEbIXHZ+Tb5sKG1yx1zOnUPo5XEcwnF66Xgei9IJ9be1zax0eicHD6RaZ4
         NAzM2BaaJqnCuMZnTgZLOqz9O05Qo1TuKDzD75G5DCfWsPNXAqSi9lM7nNGyvkPj/g6u
         vRzzXB9ZRkQDk5lXNMgahOtEyBoipS4PhkN1VncoOEOE7qFSidsJkccoh2pPjcUunbFA
         X4CUyUMZcqvgrgdTzUZ2TkLI+kJsm5w1tutEHSKrgu2wjtfREe4LSBys2eFXwC7/cjoM
         JvnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063756; x=1757668556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OPKMG3e9ZReQgWt2V8//LK/vnJHBqxfQ5zALcUNLE80=;
        b=Y+Gw305esJFGbNY4xe+td1IaEkMBMDnj+ByOgHuj0/mMtHQxPZjurYcxQ7hh97Wkmz
         m7y3bu4jEwvDngSXtPH/O+lr3w1mzKTcCqz/57PLXdM5/1FvambGX72zz6p2XTP3y7JU
         tNb93535B6DVGHcrgwvlsZmLIatXmvLb/6knTOvF/rTIuc5jnDgAMILyxEAo4qAeEz4T
         8xIlvWRcd+OtmkKTRQD7NHhguwhSa3+7NI0m/8RB/1GsPyhK+BtNmnlcVMhhRyfBMp5Q
         DXIxErrOBQrnXJnqCjFjZojcPz1DCkU5DeDdhG1IRPzJjmlGICAiaXZ4RYfyhXvaLJs7
         xEiw==
X-Gm-Message-State: AOJu0Yx+nbh44kdFgbyj/J+NN1DU9Q9ejJt83EwM2bOnaqh/gySr5M6c
	mHM3nth0f9x4ZXO71buUuoNdbtfNhfidzc4iMRQIbINaJLWT9X+m48UNLpagxCid0fs=
X-Gm-Gg: ASbGnctBWRm/67G/piM69D50aGh6MbP3s1sPgAhiSpJKSx7s2r6fHQLO6IFeVEp8eyR
	UEeVTGBD8KhcuyLGugRPpIkA/FdYnOBEgFvqmsjiZ55RkYtpRKbuQ2BbM4TgeMSEp9FeEubvskn
	vz4K2xCjVXoECTlOeH7EoZCGQNEJebqOH0+Zw0YOVUYWMMxcZve9ee1W99rMuGmTDPp6pwNg67N
	DQ4mmuT3rQt4i4aN2qkOkM1QTHbqJBsYM2uzxF/5J0wm202e0U4DGHVjd24zIAHYiNip7FWIwg6
	gD2XDeSiTbarwD7dZnnI5dxHQ5Fda0/ZoZ959Knd8mbCxHctPKkRoBKyacflEaJOoMGS9Rlj8rN
	QI2d+5wTQ2wv3GLrh88t4ci0R/zm2BkbcdzKyBjia3+K71+GpemMP
X-Google-Smtp-Source: AGHT+IE6WRSBTKSjUljDU0ZYog37RbzByDvdrcz6HKFLPWL3G2goI/QLEHWsd27FDaglqAGJRryYhw==
X-Received: by 2002:a05:6a00:4b56:b0:772:2c15:230e with SMTP id d2e1a72fcca58-7723e21e99fmr29042456b3a.6.1757063756378;
        Fri, 05 Sep 2025 02:15:56 -0700 (PDT)
Received: from fedora.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a71c60bsm21078281b3a.103.2025.09.05.02.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:15:55 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	MD Danish Anwar <danishanwar@ti.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jaakko Karrenpalo <jkarrenpalo@gmail.com>,
	Fernando Fernandez Mancera <ffmancera@riseup.net>,
	Murali Karicheri <m-karicheri2@ti.com>,
	WingMan Kwok <w-kwok2@ti.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCHv3 net 2/3] hsr: use hsr_for_each_port_rtnl in hsr_port_get_hsr
Date: Fri,  5 Sep 2025 09:15:32 +0000
Message-ID: <20250905091533.377443-3-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250905091533.377443-1-liuhangbin@gmail.com>
References: <20250905091533.377443-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hsr_port_get_hsr() iterates over ports using hsr_for_each_port(),
but many of its callers do not hold the required RCU lock.

Switch to hsr_for_each_port_rtnl(), since most callers already hold
the rtnl lock. After review, all callers are covered by either the rtnl
lock or the RCU lock, except hsr_dev_xmit(). Fix this by adding an
RCU read lock there.

Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 net/hsr/hsr_device.c | 3 +++
 net/hsr/hsr_main.c   | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
index bce7b4061ce0..702da1f9aaa9 100644
--- a/net/hsr/hsr_device.c
+++ b/net/hsr/hsr_device.c
@@ -226,6 +226,7 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct hsr_priv *hsr = netdev_priv(dev);
 	struct hsr_port *master;
 
+	rcu_read_lock();
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	if (master) {
 		skb->dev = master->dev;
@@ -238,6 +239,8 @@ static netdev_tx_t hsr_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		dev_core_stats_tx_dropped_inc(dev);
 		dev_kfree_skb_any(skb);
 	}
+	rcu_read_unlock();
+
 	return NETDEV_TX_OK;
 }
 
diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
index ac1eb1db1a52..bc94b07101d8 100644
--- a/net/hsr/hsr_main.c
+++ b/net/hsr/hsr_main.c
@@ -134,7 +134,7 @@ struct hsr_port *hsr_port_get_hsr(struct hsr_priv *hsr, enum hsr_port_type pt)
 {
 	struct hsr_port *port;
 
-	hsr_for_each_port(hsr, port)
+	hsr_for_each_port_rtnl(hsr, port)
 		if (port->type == pt)
 			return port;
 	return NULL;
-- 
2.50.1


