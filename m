Return-Path: <netdev+bounces-195072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F119ACDC38
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 12:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64431715A0
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 10:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C6F28DEF9;
	Wed,  4 Jun 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cvJ+gkSs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37D28DB75
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 10:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034700; cv=none; b=QfsqY/RGZfQ552eoK5zRtb1XpC7VrOi5a17hDNybhjSZqPtZkHLUUmVgI18gckPv7bgAwp+iTVL1Bt/0fBCjOMfGFBclq28TkXG0hWKRqzHzjkUl1A6F9//npT6Npdt5IJXY0Dc6mKvts/FVPXkAhYTZCOVhCrK1qChFWI5nM78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034700; c=relaxed/simple;
	bh=z68afDz9p2pRwG2ni4R7OHgv1R+4eIRjnIkDcyLROuQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QP35vY0Dbac747r2huGsSlhigdim/D9VbHuh8zhXTi93pK3BiVV9OXIPKOc/7oDToawRQupyNBQu+AIrmFYJuPs7EZriouiNIM3TwVPNASzS5HJmTe36WaT3eB7pmlEFiIKrlK6pLhxHk1PgGZkFpAMQeuTje7qLN4nApPbmIWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cvJ+gkSs; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a38007c7bdso135777381cf.3
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 03:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749034697; x=1749639497; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i1dAMD7l/5uTLCMS71HMGr74YTJ/ut/5VPHGUNVWhM0=;
        b=cvJ+gkSs0BgPGdHAMOnJHWGVAl+H73v7aWtdmL/7MSb+T0cbxdXVmssMmtIzy8qoZY
         cVLgNDlAwsMlRQTRR7Z8YL68lUMV3lAQxI5U8Uk8Kz67Dk5HytaZimlbYF8Jv87tO4QX
         4QV73omVLPtURZAaBVo4Xix6LucTNJ/3uNS0XXqhUY32z2ZhgbP2xnPayBi87JZUbns1
         u7q/Hr2YT08iBwe5m6HhqrjpuAe21K4Uwi/HjDKpFhi847fYTjnYDpsgP+J9vRRP0L6H
         3D++r9yPwhrm1Nb1zCgOH7OEZNSrPKpiC//m55qnGHwaWVa1SvW+hDHz7R3dK5pqQsIZ
         5RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749034697; x=1749639497;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i1dAMD7l/5uTLCMS71HMGr74YTJ/ut/5VPHGUNVWhM0=;
        b=FaFZ43sCZuhnH9uHwyZ24wlrAoh+L3dTIpzzZzipq+CoGXVx8u6/gIdaGFbgMCSEgX
         0FTO7DuA2akLFokL0zSGpNHQRYU302vMWneQuAoXpIXIjgtIjNplvNqGSXLDp14Ipw1i
         retrhXCEKc6X8xcrypndEPiriq8WHuE3St4e3PBVYHJCqBj7iLWmKU8j8a4NDppTPzyc
         NcHmt1VOGG/yuhagmczm1xlC/P8w4i8cHMJEPfPwQCB58EKc3fAAFbbQHd80oManHnY3
         zklhTtQWBF6OkVTUj4eTb2Fg53dl7F0LZearaDencI9UxmhzHxIWg4p+QfcD7yMmQtOW
         02dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUPNXSmXoV4gcXlhfoScnGKWDTmh5kIT8OPlsiWj8HRlutkaVcUcP+5fnieL71zFjjapaf78o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjyTtR0YUa9RtoGtEuLVDIFKutwPk2VvRTRENPqTNH4+Qc7uMY
	hBkZ4cTacf3T4xGNSkMximCTqZkaQBoOJCWiBwLzPMPhkaqwzBij2usTBHqqdnrysrry9j/I9Mn
	zpoQhiBj9vCO5AA==
X-Google-Smtp-Source: AGHT+IHVsnC58uh4YsFItkivf/7k7sjysLWRIefquN9aCR8yOFSBlnfeM/4VoDHAPeX6ppGr+t0bbl0gFbsW9w==
X-Received: from qtbbr26.prod.google.com ([2002:a05:622a:1e1a:b0:4a4:3d26:8419])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4a10:b0:494:b148:930e with SMTP id d75a77b69052e-4a5a58969cbmr40039181cf.49.1749034697413;
 Wed, 04 Jun 2025 03:58:17 -0700 (PDT)
Date: Wed,  4 Jun 2025 10:58:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604105815.1516973-1-edumazet@google.com>
Subject: [PATCH net] net: prevent a NULL deref in rtnl_create_link()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+9fc858ba0312b42b577e@syzkaller.appspotmail.com, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"

At the time rtnl_create_link() is running, dev->netdev_ops is NULL,
we must not use netdev_lock_ops() or risk a NULL deref if
CONFIG_NET_SHAPER is defined.

Use netif_set_group() instead of dev_set_group().

 RIP: 0010:netdev_need_ops_lock include/net/netdev_lock.h:33 [inline]
 RIP: 0010:netdev_lock_ops include/net/netdev_lock.h:41 [inline]
 RIP: 0010:dev_set_group+0xc0/0x230 net/core/dev_api.c:82
Call Trace:
 <TASK>
  rtnl_create_link+0x748/0xd10 net/core/rtnetlink.c:3674
  rtnl_newlink_create+0x25c/0xb00 net/core/rtnetlink.c:3813
  __rtnl_newlink net/core/rtnetlink.c:3940 [inline]
  rtnl_newlink+0x16d6/0x1c70 net/core/rtnetlink.c:4055
  rtnetlink_rcv_msg+0x7cf/0xb70 net/core/rtnetlink.c:6944
  netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
  netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
  netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
  sock_sendmsg_nosec net/socket.c:712 [inline]

Reported-by: syzbot+9fc858ba0312b42b577e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6840265f.a00a0220.d4325.0009.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Cc: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f9a35bdc58ad2a6c7d2aa023bef9b48f72336bbc..c57692eb8da9d47c3b0943bf7b8d8b7f7d347836 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -3671,7 +3671,7 @@ struct net_device *rtnl_create_link(struct net *net, const char *ifname,
 	if (tb[IFLA_LINKMODE])
 		dev->link_mode = nla_get_u8(tb[IFLA_LINKMODE]);
 	if (tb[IFLA_GROUP])
-		dev_set_group(dev, nla_get_u32(tb[IFLA_GROUP]));
+		netif_set_group(dev, nla_get_u32(tb[IFLA_GROUP]));
 	if (tb[IFLA_GSO_MAX_SIZE])
 		netif_set_gso_max_size(dev, nla_get_u32(tb[IFLA_GSO_MAX_SIZE]));
 	if (tb[IFLA_GSO_MAX_SEGS])
-- 
2.50.0.rc0.604.gd4ff7b7c86-goog


