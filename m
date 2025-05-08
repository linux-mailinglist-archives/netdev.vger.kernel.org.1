Return-Path: <netdev+bounces-188892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA6FAAF2C5
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 07:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21B1F4A810F
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 05:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BACA205AC1;
	Thu,  8 May 2025 05:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="EmYmdajx"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFBD86323
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 05:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746681521; cv=none; b=s0xJMmML7yq++62c4a6nLNOp5CEKdafA5ZMcRobBILORGyVBid4Fs0M0e3WSEx7zn2/zxcUlkFxPIUH+D8Yc399uLy0QKQ3QPfewpSu7HrgU0UsOXqonYLORXcygamldu8LCZfS8V496tPDyx1IWUk5eaMOXhzjQC8xmxKBzXLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746681521; c=relaxed/simple;
	bh=QDmtF33IX1rswxe11r3HdSIjVhOQm88dBvSGNf7V/Hg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Lo4PBLhGhxBYQyAK6rlCdGM9veKGhDmelw3DY33d2J2EiC0nkwjnrVleIiBytRCxh2yldzu0BC4vcz/i9sVbgEfuhuUrY/msMbrffjrQHRubumcsF+v0Qv1a3PQinqZHmIVWzhY+l+STZ4ZbKoFwkk7OJYjXLCgDVPWO/NMZuN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=EmYmdajx; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1746681517;
	bh=VjFq/n+F8OJWeyaEcotA5o0tCPu8V1Jf8iYVj8KWFDs=;
	h=From:Date:Subject:To:Cc;
	b=EmYmdajxl3QyFI5EbuDPKFAReZQxCHHn+DCyL1G0fnUz1rYl4/obKWgMY0adcBV5d
	 4urqNlKh2Rw1vtnbkaxPpvu489ZzGCiT5XykDTHdLa5IPVCpCKG5s7slyfNTNrLarI
	 LxrIr/w124VSQU4WQ1ku59VoURafl2uG8M2t3/mGhPUmuMe+11qcwQLDtlqJ1SScPT
	 7PpnMa5dBLA2jj7F9AT9f5Sd2WoueQMCu4uEc+fErI97TAywaH5t/x1Hw4P9wRYJDK
	 3a6F7VU4427J57JwP9yeec953e/UyWrZ4H8UMXWWYO2n9f7PLkplpStUBDuKE+XfCL
	 Yu6+ThY+GT+sQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 53D637E97C; Thu,  8 May 2025 13:18:37 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 08 May 2025 13:18:32 +0800
Subject: [PATCH net v2] net: mctp: Don't access ifa_index when missing
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250508-mctp-addr-dump-v2-1-c8a53fd2dd66@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAKc+HGgC/3WNwQ6DIBBEf8XsuWtA2yqe+h+NB7qslYNAAE0b4
 7+XeG/m9GYyMzskjpYTDNUOkTebrHcFmksFNGv3ZrSmMDSiuYkiXCgH1MZENOsS8N61LCZDXa+
 uUEoh8mQ/5+ATHGcYiznblH38niebPKN/e5tEiVqpTsh2UurVP8gbJu9SjivlmvxS6xXG4zh+7
 cdF3bwAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1746681516; l=2606;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=QDmtF33IX1rswxe11r3HdSIjVhOQm88dBvSGNf7V/Hg=;
 b=x/GNydGA51/AgTwrUGYeK8noExytrs1tfv9DFp7JB6GYNXvvisMPalsI7lM1cghfi2VMJyZfQ
 dC7Oro0TODMDwNil9iBH+H8YdodZN2Edt/By0STceGT7nWOc4enxoI/
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
Changes in v2:
- Don't test for ifa_family=AF_MCTP
- Fail if strict_check is set and header is short
- Link to v1: https://lore.kernel.org/r/20250505-mctp-addr-dump-v1-1-a997013f99b8@codeconstruct.com.au
---
 net/mctp/device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 8e0724c56723de328592bfe5c6fc8085cd3102fe..7c0dcf3df3196207af6e1a1c002f388265c49fa1 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -117,11 +117,18 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
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
+		ifindex = hdr->ifa_index;
+	} else {
+		if (cb->strict_check) {
+			NL_SET_ERR_MSG(cb->extack, "mctp: Invalid header for addr dump request");
+			return -EINVAL;
+		}
+	}
 
 	rcu_read_lock();
 	for_each_netdev_dump(net, dev, mcb->ifindex) {

---
base-commit: ebd297a2affadb6f6f4d2e5d975c1eda18ac762d
change-id: 20250505-mctp-addr-dump-673e0fdc7894

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


