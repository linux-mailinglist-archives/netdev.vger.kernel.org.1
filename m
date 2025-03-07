Return-Path: <netdev+bounces-172813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BEDA562A0
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161933B49BE
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 08:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE7D1A83E8;
	Fri,  7 Mar 2025 08:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q1jwJkop"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E45C2E0
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 08:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336548; cv=none; b=k/iZkGzx0YiOGPmdtxcNM7BzHhd+LL7Y08pPPjdgzI21X/CGeybsLN82h7ZFPVbteJDQh3bXDQcy4qnui4iv4EyupF3CUYP67JMCPRWw7INDN8LE8UMF6Wqlr04fcSmM8KrGsgZAqwnBim/W7kdxfoA5zNOTqcyQy0z1A1ciCSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336548; c=relaxed/simple;
	bh=/lYb1TKtACuLYZwHsxHYPhvCmLgJCSmlcpAkGcMR0TM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KTkaUQvSekJXrrV1t8e/wAXfezU4yIOkyhea/kCTLK/Qz3Jp724FpZUab9mJcYPgMlpDPkVktnQqtCbsB+Ge28UFjHwB5gVZDTPjU/lVG8NABka5RL9c6leQ2xu0jAAc96lDI0UuPAkbcfzT0rbHyvIMkrRr63ANiiTlnD+UQ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q1jwJkop; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c3cbb51f03so343261985a.1
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 00:35:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741336546; x=1741941346; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p/SUwj89fyfNI0rLwBJEGgU25CfNLf2OBuFwRcisgPk=;
        b=q1jwJkophjWWKtK9a93KoZ50EiLW5FxZgIQKXNUUO5B+pQ9aFbMbFdXVa18U7ZvCi+
         OPdG3U+tI1HSgqQubAlk8+6edSzhuLebOHvh10z9w5vJ7y/Dd9Gj31b5+qX6iKwpGoZr
         jzDP2zeDXJWk0b2AKRAEgyyJghv5EEPz0zNOhGS3NeqBRNt4OZrX7ko7h6xqfkwsmTgo
         JLqxT8boYFzddI9QR1c06z52y8pCm9wQYv8pUOgSTYkREmNjJiYprm8p0wLSgex8ttdV
         5ayqgVGOMP0GKef1Ll6IqpWVk28mza9hBd7ycvpT1CgCq5AxBazljsKIAvVffdEjQ9Lz
         7G1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741336546; x=1741941346;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p/SUwj89fyfNI0rLwBJEGgU25CfNLf2OBuFwRcisgPk=;
        b=fXZmxFt0GjjDshEcBKHNupmAHv0k5Ym+qWlt8xUR+UMGT9/Wohoh3wTghx6e2thzbV
         LlWECd550WQstH6tJD9kPKxh7y63QIdMnCf3cJN9j9W2DaLesfDjB7p7dfCGGMXo0axC
         RzSAsexzEUcJIaBXmZjmno3bAry6ADWH1DBSTVRRnKVVkitRVx5K8mGu/kkTgn30IzSp
         GUrBAIFGMqYXTNs1xQWpKMrZX9Ez1N+xFSoE/lq3AFdkfMlsoeUfQJMYuDT8GE8CrAOh
         bTxWWgR3VBIyO6WRePWGzCFQdePqwa5kY4XQTUOxaE0yiq8Zz/SDjoKWsIkvmLqgGtEm
         I8FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP8h4sPu62bvWVpgX/P3vNE0HyodngENQTRJgLOqPbv6kNE6swvnDjtu+LF4+bfLcVqLXOPfs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0Yk4p3pxQXaSAUimJbZkEahcXrLA4Qp2sSrtqLDGJCb8g+8w/
	hqchfyCQuy69PstZP70alDKdxBph1HP3js63lktcFQFbtH6jDaYEaemSv24EmUt2KeVplBkbeTR
	sKvw9IX0jJA==
X-Google-Smtp-Source: AGHT+IERCnlT9n3jIQ/G/wWw4Adj5PfA9AEJmvKTREI9kbfY6KgJTYriIKZwud7/vrW9hSxMn4u5iQxuRTWLbQ==
X-Received: from qtbeo13.prod.google.com ([2002:a05:622a:544d:b0:474:e62f:76e9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4d3:b0:474:dc6d:5206 with SMTP id d75a77b69052e-47618afe01cmr26203231cf.51.1741336546016;
 Fri, 07 Mar 2025 00:35:46 -0800 (PST)
Date: Fri,  7 Mar 2025 08:35:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307083544.1659135-1-edumazet@google.com>
Subject: [PATCH net-next] net: ethtool: use correct device pointer in ethnl_default_dump_one()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+3da2442641f0c6a705a2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

ethnl_default_dump_one() operates on the device provided in its @dev
parameter, not from ctx->req_info->dev.

syzbot reported:

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000197: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000cb8-0x0000000000000cbf]
 RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
 RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
 RIP: 0010:ethnl_default_dump_one net/ethtool/netlink.c:557 [inline]
 RIP: 0010:ethnl_default_dumpit+0x447/0xd40 net/ethtool/netlink.c:593
Call Trace:
 <TASK>
  genl_dumpit+0x10d/0x1b0 net/netlink/genetlink.c:1027
  netlink_dump+0x64d/0xe10 net/netlink/af_netlink.c:2309
  __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2424
  genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
  genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
  genl_rcv_msg+0x894/0xec0 net/netlink/genetlink.c:1210
  netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
  genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
  netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
  netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
  sock_sendmsg_nosec net/socket.c:709 [inline]
  __sock_sendmsg+0x221/0x270 net/socket.c:724
  ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
  ___sys_sendmsg net/socket.c:2618 [inline]
  __sys_sendmsg+0x269/0x350 net/socket.c:2650

Fixes: 2bcf4772e45a ("net: ethtool: try to protect all callback with netdev instance lock")
Reported-by: syzbot+3da2442641f0c6a705a2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/67caaf5e.050a0220.15b4b9.007a.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ethtool/netlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index 239b5252ed2a1925f03b876ca47c6613f76b4636..70834947f474cb724073e890d3d4f428e7d4e785 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -554,9 +554,9 @@ static int ethnl_default_dump_one(struct sk_buff *skb, struct net_device *dev,
 
 	ethnl_init_reply_data(ctx->reply_data, ctx->ops, dev);
 	rtnl_lock();
-	netdev_lock_ops(ctx->req_info->dev);
+	netdev_lock_ops(dev);
 	ret = ctx->ops->prepare_data(ctx->req_info, ctx->reply_data, info);
-	netdev_unlock_ops(ctx->req_info->dev);
+	netdev_unlock_ops(dev);
 	rtnl_unlock();
 	if (ret < 0)
 		goto out;
-- 
2.49.0.rc0.332.g42c0ae87b1-goog


