Return-Path: <netdev+bounces-187697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C8AA8F2A
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E1E164073
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39CC01F4CB7;
	Mon,  5 May 2025 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lSL4CaxZ"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410101F4C97
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 09:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436507; cv=none; b=s8TO+gK2qrkMAzwkLfwM6jtaXRAEudvAIBsATh1FHm4ejha2fi7uL3/GUQ5OZaWWmIwg2CU77UiqZvXKFDUGODeq7hw3Z+K/VheBQjRRoG4SdOafgQEP73Zwyg2LjNKH58ix9PXymb7MFyxgGyWcud0B+dDD6sVvnYmD0TVYD0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436507; c=relaxed/simple;
	bh=bvPDlKJLUfDwrOM3TVQzXMoltiuoAzh+aXpJ+cNNsW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ENdJoZ+LPUEgz3Dk+Y0IYbwU+emnNQS822s1AH0Uwz9XSOWzNZ5lvd8sHZmNXQNUZc30tmZCgdLb8TVdM3cZyGwAOaYP1EGpgJC9oMh9xI+/f1KKp7F6RftLaRoTODyAbpR6WatfVlEPu4amN71472R5VUmyQbxOT4Fzrfx8tgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lSL4CaxZ; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1746435923;
	bh=oXqBDEcTn8k7y4zmpSs29XEcQ0Mrw0n4KBq3glGBi3o=;
	h=From:Date:Subject:To:Cc;
	b=lSL4CaxZPaDzLmYyfrYvXEVFWCEQuOZCeTZxRm2QBAato24yuiD21NOmxiwGyqFlT
	 EPVRCUg3JZfBMkSAxSvB6jXBEJlBmoMY6zaQpD0ysfORTOzLMG27d7plwkIi2L/1em
	 pfB+JRpalNoLxV7o1yLq4zdm5KLlNeJWKZVeCQn7s4B6YVTdDWPqd2HJhmucK8h9uM
	 10T/ALDLm4gStoVHYkzmpdaE7vW+toALbkakr8VlZxTmK46+Lc5+BqWLatUMR4ogLU
	 SCZUDjS/bBJao7402SdR1WX1SA9776/28uKZILmawehhWowEZ1f2kARU/Y318aVN/2
	 vL36PBebJJdrg==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 0545A80666; Mon,  5 May 2025 17:05:23 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Mon, 05 May 2025 17:05:12 +0800
Subject: [PATCH net] net: mctp: Don't access ifa_index when missing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAEd/GGgC/x2MSQqAMAwAvyI5G6j78hXxIE2qOVhLqyJI/26RO
 c1h5oXAXjjAmL3g+ZYgh01S5BnobbEro1ByKFXZqATu+nS4EHmka3fYdhUrQ7rrhxpS5Dwbef7
 hBJZPmGP8ALAUia1lAAAA
X-Change-ID: 20250505-mctp-addr-dump-673e0fdc7894
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, 
 syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com, 
 syzbot+1065a199625a388fce60@syzkaller.appspotmail.com, 
 Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746435922; l=2444;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=bvPDlKJLUfDwrOM3TVQzXMoltiuoAzh+aXpJ+cNNsW0=;
 b=GjjBmX86BTQjZiWsjbjHlVeuROFk59geJfQH+3hsV2fc0c2y/oWWiGb/p6kwi5xdz+x1yGDQw
 UR/kSiYTDpMCe23uUH1ohXyRek2PluONGr1e1efxVwk821Hqzp24FE9
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

In mctp_dump_addrinfo, ifa_index can be used to filter interfaces, but
only when the struct ifaddrmsg is provided. Otherwise it will be
comparing to uninitialised memory - reproducible in the syzkaller case from
dhcpd, or busybox "ip addr show".

The kernel MCTP implementation has always filtered by ifa_index, so
existing userspace programs expecting to dump MCTP addresses must
already be passing a valid ifa_index value (either 0 or a real index).

BUG: KMSAN: uninit-value in mctp_dump_addrinfo+0x208/0xac0 net/mctp/device.c:128
 mctp_dump_addrinfo+0x208/0xac0 net/mctp/device.c:128
 rtnl_dump_all+0x3ec/0x5b0 net/core/rtnetlink.c:4380
 rtnl_dumpit+0xd5/0x2f0 net/core/rtnetlink.c:6824
 netlink_dump+0x97b/0x1690 net/netlink/af_netlink.c:2309

Fixes: 583be982d934 ("mctp: Add device handling and netlink interface")
Reported-by: syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/68135815.050a0220.3a872c.000e.GAE@google.com/
Reported-by: syzbot+1065a199625a388fce60@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/681357d6.050a0220.14dd7d.000d.GAE@google.com/
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 net/mctp/device.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 8e0724c56723de328592bfe5c6fc8085cd3102fe..7780acdb99dedca1cd6a17e4d6bf917c7f7f370f 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -117,11 +117,17 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	struct net_device *dev;
 	struct ifaddrmsg *hdr;
 	struct mctp_dev *mdev;
-	int ifindex, rc;
+	int ifindex = 0, rc;
 
-	hdr = nlmsg_data(cb->nlh);
-	// filter by ifindex if requested
-	ifindex = hdr->ifa_index;
+	/* Filter by ifindex if a header is provided */
+	if (cb->nlh->nlmsg_len >= nlmsg_msg_size(sizeof(*hdr))) {
+		hdr = nlmsg_data(cb->nlh);
+		/* Userspace programs providing AF_MCTP must be expecting ifa_index filter
+		 * behaviour, as will those setting strict_check.
+		 */
+		if (hdr->ifa_family == AF_MCTP || cb->strict_check)
+			ifindex = hdr->ifa_index;
+	}
 
 	rcu_read_lock();
 	for_each_netdev_dump(net, dev, mcb->ifindex) {

---
base-commit: ebd297a2affadb6f6f4d2e5d975c1eda18ac762d
change-id: 20250505-mctp-addr-dump-673e0fdc7894

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


