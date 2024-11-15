Return-Path: <netdev+bounces-145106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43D59CCD1D
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47CA3B21FA5
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74021096F;
	Fri, 15 Nov 2024 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJCqfkxP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A141362
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 00:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630714; cv=none; b=LDlIzXRUp3QLvkN8NAhe/o+Fb/pWMpNhsWolI6vEJ2M5cYqnue7K24VcZVl3GpArAjhGKZ9l7o/mX4FbPbZwZqijeMG4ud2lFckiAN7lWfJE9XSrfeD/aotfmwLWltXTnyavk14sXhZQ92WbDFnyHDJNCSxecnQE04UyHUU7z+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630714; c=relaxed/simple;
	bh=LU3XarEKwd1387jdjxqg+xfc1xKz1LA795ie3WoNQCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XcVxDsSTTpqyvOHttYjdRUnevKGps5BJJ+RpE0rcfiC5Z/QPlr0Iaz4684Br1VCbcFGpknNLJRnmGgEk2SF/HwAyc54ND4YBhQk3QXn5t+V0/bRjwTNRxxVWmHsW3FLQEWP8rrFN8Mw9lhuPBYyc+Pu3FxHMH7mMqsEI0wwcNyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJCqfkxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33E3C4CECD;
	Fri, 15 Nov 2024 00:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731630714;
	bh=LU3XarEKwd1387jdjxqg+xfc1xKz1LA795ie3WoNQCc=;
	h=From:To:Cc:Subject:Date:From;
	b=XJCqfkxP3BRZCf4ECAMx134YF9cbeXg/nCapfD7yPTjK4OougmH6h8zQsO+gdoXqg
	 S0cMhOxrct06YMSGzWRM5c85ZM6G04oRRmoknF+tol5fqk/wv5TltWDHtHo+SZYNBW
	 mSvwDg6ECx8wR00weAWB11HjEt4RCDmAVh/3+GZt5tya/HLCWkFR6r6Sn9q85S2+Jo
	 ZjuxPgfgvYbQbS1yfli+TeDIPnAqyIR4ROJ7W5wTmsKcq2VvM6lPNqrJw2qJ7F4yb/
	 i/7TUzbrRk21FP33Urph99GF5B3p1y4hUzCGW6Jh9IIrDJ2M5/EPmQgYf6e/x5dvk1
	 XFCv9pu8ZsT1w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	syzbot+d4373fa8042c06cefa84@syzkaller.appspotmail.com,
	dsahern@kernel.org
Subject: [PATCH net 1/2] netlink: fix false positive warning in extack during dumps
Date: Thu, 14 Nov 2024 16:31:49 -0800
Message-ID: <20241115003150.733141-1-kuba@kernel.org>
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
CC: dsahern@kernel.org
---
 include/net/netlink.h    | 13 +++++++++++++
 net/netlink/af_netlink.c | 13 +++++--------
 2 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/include/net/netlink.h b/include/net/netlink.h
index db6af207287c..efd906aff22f 100644
--- a/include/net/netlink.h
+++ b/include/net/netlink.h
@@ -659,6 +659,19 @@ nlmsg_next(const struct nlmsghdr *nlh, int *remaining)
 	return (struct nlmsghdr *) ((unsigned char *) nlh + totlen);
 }
 
+/**
+ * nlmsg_addr_in_payload - address points to a byte within the message payload
+ * @nlh: netlink message header
+ *
+ * Returns: true if address is within the payload of the message
+ */
+static inline bool nlmsg_addr_in_payload(const struct nlmsghdr *nlh,
+					 const void *addr)
+{
+	return addr >= nlmsg_data(nlh) &&
+		addr - (const void *) nlh < nlh->nlmsg_len;
+}
+
 /**
  * nla_parse - Parse a stream of attributes into a tb buffer
  * @tb: destination array with maxtype+1 elements
diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index f84aad420d44..b49c9d745239 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -2177,8 +2177,7 @@ netlink_ack_tlv_len(struct netlink_sock *nlk, int err,
 }
 
 static void
-netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
-		     const struct nlmsghdr *nlh, int err,
+netlink_ack_tlv_fill(struct sk_buff *skb, const struct nlmsghdr *nlh, int err,
 		     const struct netlink_ext_ack *extack)
 {
 	if (extack->_msg)
@@ -2191,8 +2190,7 @@ netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
 		return;
 
 	if (extack->bad_attr &&
-	    !WARN_ON((u8 *)extack->bad_attr < in_skb->data ||
-		     (u8 *)extack->bad_attr >= in_skb->data + in_skb->len))
+	    !WARN_ON(!nlmsg_addr_in_payload(nlh, extack->bad_attr)))
 		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_OFFS,
 				    (u8 *)extack->bad_attr - (const u8 *)nlh));
 	if (extack->policy)
@@ -2202,8 +2200,7 @@ netlink_ack_tlv_fill(struct sk_buff *in_skb, struct sk_buff *skb,
 		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_MISS_TYPE,
 				    extack->miss_type));
 	if (extack->miss_nest &&
-	    !WARN_ON((u8 *)extack->miss_nest < in_skb->data ||
-		     (u8 *)extack->miss_nest > in_skb->data + in_skb->len))
+	    !WARN_ON(!nlmsg_addr_in_payload(nlh, extack->miss_nest)))
 		WARN_ON(nla_put_u32(skb, NLMSGERR_ATTR_MISS_NEST,
 				    (u8 *)extack->miss_nest - (const u8 *)nlh));
 }
@@ -2232,7 +2229,7 @@ static int netlink_dump_done(struct netlink_sock *nlk, struct sk_buff *skb,
 	if (extack_len) {
 		nlh->nlmsg_flags |= NLM_F_ACK_TLVS;
 		if (skb_tailroom(skb) >= extack_len) {
-			netlink_ack_tlv_fill(cb->skb, skb, cb->nlh,
+			netlink_ack_tlv_fill(skb, cb->nlh,
 					     nlk->dump_done_errno, extack);
 			nlmsg_end(skb, nlh);
 		}
@@ -2491,7 +2488,7 @@ void netlink_ack(struct sk_buff *in_skb, struct nlmsghdr *nlh, int err,
 	}
 
 	if (tlvlen)
-		netlink_ack_tlv_fill(in_skb, skb, nlh, err, extack);
+		netlink_ack_tlv_fill(skb, nlh, err, extack);
 
 	nlmsg_end(skb, rep);
 
-- 
2.47.0


