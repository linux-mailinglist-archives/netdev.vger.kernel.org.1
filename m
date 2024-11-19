Return-Path: <netdev+bounces-146362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F049D30A0
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 23:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6789EB21EEB
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 22:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78341D07BB;
	Tue, 19 Nov 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2NmGdEA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813331BBBD3
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732056277; cv=none; b=BYziE2qUcaDr5ACAf5bjVR4y66UPsnqyZ3mnOz4tFtR6jf1or1FjebleLdkMgAukWPXedl6M/eZZRFL+nQ3cIAubtzCdetz4SWNVl08ODGct1h4u20+xWY7cUlMaqHbr/QHIC1JDe7C6C8vUopujL4qvjWckiE2LyA7cgfgWDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732056277; c=relaxed/simple;
	bh=Gn4XjLvrdElZ61Q3hQ7/HcT3g68zcnVnwjENfbyBM2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EHPlm2XBxZDKJqJLzzYnvPEx1fKj9dyRAOq2v7uEtnwXLP8/jq0lh9IquV2csUfaoVRQ/iatU40wb+SlxpuJLssAXiJP/L7SvkBn4YX152obggCnGgSE30esB/k9Yk44h4tv5Ab5uPziNiHq8spLXLYaNtdqSdNqA798F2cSGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2NmGdEA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C14E9C4CECF;
	Tue, 19 Nov 2024 22:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732056277;
	bh=Gn4XjLvrdElZ61Q3hQ7/HcT3g68zcnVnwjENfbyBM2Q=;
	h=From:To:Cc:Subject:Date:From;
	b=I2NmGdEAirAe6s1m082KixbL8Uex/7AyGg8XJboPxupgtXikxtVaPipOR0QHAYgt+
	 qvV316xVzaC7iHwEunqtTU6ne4B5t6Bou0Tzg9djNKxqW27YaUNaH8cqwNqhpRFSDR
	 uspYX6vfrr9gs2BfT0nvXT6NnXFstcETMLKcP+64vSKeHvmPWnT02tuRO33eN/BhiQ
	 A53VU5FNx6kSTuKR9j0pISc31Xjq9/Qisq5IDXT26RqCgAnVh65sg8w41roXD4Gt+1
	 FV5usmwM2GVkM9+K4wjvXF2dmxtWqAO7GvGPOA7gO0MGGFR/wtg3X1V3uM+OBXGrSw
	 VgT2eOegLIPHA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com,
	dsahern@kernel.org
Subject: [PATCH net v2 1/2] netlink: fix false positive warning in extack during dumps
Date: Tue, 19 Nov 2024 14:44:31 -0800
Message-ID: <20241119224432.1713040-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit under fixes extended extack reporting to dumps.
It works under normal conditions, because extack errors are
usually reported during ->start() or the first ->dump(),
it's quite rare that the dump starts okay but fails later.
If the dump does fail later, however, the input skb will
already have the initiating message pulled, so checking
if bad attr falls within skb->data will fail.

Switch the check to using nlh, which is always valid.

syzbot found a way to hit that scenario by filling up
the receive queue. In this case we initiate a dump
but don't call ->dump() until there is read space for
an skb.

WARNING: CPU: 1 PID: 5845 at net/netlink/af_netlink.c:2210 netlink_ack_tlv_fill+0x1a8/0x560 net/netlink/af_netlink.c:2209
RIP: 0010:netlink_ack_tlv_fill+0x1a8/0x560 net/netlink/af_netlink.c:2209
Call Trace:
 <TASK>
 netlink_dump_done+0x513/0x970 net/netlink/af_netlink.c:2250
 netlink_dump+0x91f/0xe10 net/netlink/af_netlink.c:2351
 netlink_recvmsg+0x6bb/0x11d0 net/netlink/af_netlink.c:1983
 sock_recvmsg_nosec net/socket.c:1051 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1073
 __sys_recvfrom+0x246/0x3d0 net/socket.c:2267
 __do_sys_recvfrom net/socket.c:2285 [inline]
 __se_sys_recvfrom net/socket.c:2281 [inline]
 __x64_sys_recvfrom+0xde/0x100 net/socket.c:2281
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
 RIP: 0033:0x7ff37dd17a79

Reported-by: syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com
Fixes: 8af4f60472fc ("netlink: support all extack types in dumps")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - move the helper to af_netlink.c and move the WARN_ON() inside
v1: https://lore.kernel.org/20241115003150.733141-1-kuba@kernel.org
CC: dsahern@kernel.org
---
 net/netlink/af_netlink.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index f84aad420d44..775d707ec708 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2176,9 +2176,14 @@ netlink_ack_tlv_len(struct netlink_sock *nlk, int err,
 	return tlvlen;
 }
 
+static bool nlmsg_check_in_payload(const struct nlmsghdr *nlh, const void *addr)
+{
+	return !WARN_ON(addr < nlmsg_data(nlh) ||
+			addr - (const void *) nlh >= nlh->nlmsg_len);
+}
+
 static void
-netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
-		     const struct nlmsghdr *nlh, int err,
+netlink_ack_tlv_fill(struct sk_buff *skb, const struct nlmsghdr *nlh, int err,
 		     const struct netlink_ext_ack *extack)
 {
 	if (extack->_msg)
@@ -2190,9 +2195,7 @@ netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
 	if (!err)
 		return;
 
-	if (extack->bad_attr &&
-	    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
-		     (u8 *)extack->bad_attr >= in_skb->data + in_skb->len))
+	if (extack->bad_attr && nlmsg_check_in_payload(nlh, extack->bad_attr))
 		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,
 				    (u8 *)extack->bad_attr - (const u8 *)nlh));
 	if (extack->policy)
@@ -2201,9 +2204,7 @@ netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
 	if (extack->miss_type)
 		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_MISS_TYPE,
 				    extack->miss_type));
-	if (extack->miss_nest &&
-	    !WARN_ON((u8 *)extack->miss_nest < in_skb->data ||
-		     (u8 *)extack->miss_nest > in_skb->data + in_skb->len))
+	if (extack->miss_nest && nlmsg_check_in_payload(nlh, extack->miss_nest))
 		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_MISS_NEST,
 				    (u8 *)extack->miss_nest - (const u8 *)nlh));
 }
@@ -2232,7 +2233,7 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	if (extack_len) {
 		nlh->nlmsg_flags |= NLM_F_ACK_TLVS;
 		if (skb_tailroom(skb) >= extack_len) {
-			netlink_ack_tlv_fill(cb->skb, skb, cb->nlh,
+			netlink_ack_tlv_fill(skb, cb->nlh,
 					     nlk->dump_done_errno, extack);
 			nlmsg_end(skb, nlh);
 		}
@@ -2491,7 +2492,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 	}
 
 	if (tlvlen)
-		netlink_ack_tlv_fill(in_skb, skb, nlh, err, extack);
+		netlink_ack_tlv_fill(skb, nlh, err, extack);
 
 	nlmsg_end(skb, rep);
 
-- 
2.47.0


