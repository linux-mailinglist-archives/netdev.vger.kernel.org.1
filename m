Return-Path: <netdev+bounces-195614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3104BAD17AD
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 06:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C36443AB38E
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 04:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207F519F464;
	Mon,  9 Jun 2025 04:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="EuwDw9qM"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06A727FD50
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 04:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749442361; cv=none; b=LxlTWYt3aaCQsS0AawKGTQNmjKQmpa1CzhthMPumrfLH9XpwIY8UKyuH9TxZikZDfkoyEvQp7jefKEjoxxhFZ4eK5XLIY44tO/kXGhvqKCu5Lz2WR0hKzsQjAFQvCRnMAzO6BMlZwuBzTrJC+/X9DRhUYRyI+Ggkg04LcJ4S+44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749442361; c=relaxed/simple;
	bh=5kpHYCzM/m+ZbTz7BuIz+G6bjdd7cAdYCRY10p9OcnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=j+eqVN4wIDgwYdq6wvTX9MFsAm52vBzTnmIcJCzGv1TiO6wrRNwIQhbT510sUBI/XPNgQJy+AaU2Rg/g9WluyTJfrdBtOHQTd8e3kl1l0LmmXtdk7VtjZbJ0OWTj1o66bcMbfeUate8wHii7LcMAeWN+0oxsKtfiQm9ADjcoHkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=EuwDw9qM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749442348;
	bh=37Mdyc2WCGRCpOhy52o2jw4H+m75TvnuBMYpnVk/nsQ=;
	h=From:Date:Subject:To:Cc;
	b=EuwDw9qMmh7ej8+U/j+hAhjRUwuitChjTTFS7TOWHY9aG8kiHIy6bE/5iC6cQ3+i3
	 ezfGDVoTb/IB0B2x6nbev7VN7uaUScy9PFEMA1/XLj+GIAuqX5gRAuU5fluIip+agi
	 iWxZvG3ERcSqO3lM/L834IUXu2nm0UZ7LqJ5CsvYOg6S3D1Ew+O75/Xum9wQj7AF1Y
	 5EN4gcs4YaPHweA1Zw+E2Ak9l6C49ZNkeOCrhh+OJ/m2C9cc95HbcK/3vo5TZkQQ2A
	 rVvZG35jZaMvqiJhgrJLcr0ydpk5fh/1rDYEjgyl++747x+uNuh4mhSC7kblA8WJOX
	 IBbhzwzsLlSNg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id B930564C1D; Mon,  9 Jun 2025 12:12:28 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 09 Jun 2025 12:12:09 +0800
Subject: [PATCH 6.6.y] Revert "mctp: no longer rely on
 net->dev_index_head[]"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-dev-mctp-nl-addrinfo-v1-1-7e5609a862f3@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIABhfRmgC/x3MQQ6DIBBA0auYWTsEIWD1Kk0XCoNOUtFAQ2qMd
 y/p8i3+vyBTYsowNhckKpx5jxVd24Bbp7gQsq8GJZWRVg7oqeDmPgfGN07eJ45hx1np0Jm+18Y
 9oKZHosDf//YJVlhxwuu+fwwo8HZtAAAA
X-Change-ID: 20250609-dev-mctp-nl-addrinfo-b23f157735c8
To: Sasha Levin <sashal@kernel.org>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Patrick Williams <patrick@stwcx.xyz>, 
 Peter Yin <peteryin.openbmc@gmail.com>
X-Mailer: b4 0.14.2

This reverts commit 2d45eeb7d5d7019b623d513be813123cd048c059 from the
6.6 stable tree.

2d45eeb7d5d7 is the 6.6.y backport of mainline 2d20773aec14.

The switch to for_each_netdev_dump() was predicated on a change in
semantics for the netdev iterator, introduced by f22b4b55edb5 ("net:
make for_each_netdev_dump() a little more bug-proof"). Without that
prior change, we incorrectly repeat the last iteration indefinitely.

2d45eeb was pulled in to stable as context for acab78ae12c7 ("net: mctp:
Don't access ifa_index when missing"), but we're fine without it here,
with a small tweak to the variable declarations as updated patch
context.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
The 6.6.y branch is the only stable release that has the conversion to
for_each_netdev_dump() but not the prereq fix to for_each_netdev_dump(). 
---
 net/mctp/device.c | 50 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 8d1386601bbe06487bea46eeae56733124c85098..27aee8b04055f0ad19b24b08117406c303a566cc 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -20,7 +20,8 @@
 #include <net/sock.h>
 
 struct mctp_dump_cb {
-	unsigned long ifindex;
+	int h;
+	int idx;
 	size_t a_idx;
 };
 
@@ -114,10 +115,12 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct mctp_dump_cb *mcb = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
+	struct hlist_head *head;
 	struct net_device *dev;
 	struct ifaddrmsg *hdr;
 	struct mctp_dev *mdev;
-	int ifindex = 0, rc;
+	int ifindex = 0;
+	int idx = 0, rc;
 
 	/* Filter by ifindex if a header is provided */
 	if (cb->nlh->nlmsg_len >= nlmsg_msg_size(sizeof(*hdr))) {
@@ -131,19 +134,31 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
 	}
 
 	rcu_read_lock();
-	for_each_netdev_dump(net, dev, mcb->ifindex) {
-		if (ifindex && ifindex != dev->ifindex)
-			continue;
-		mdev = __mctp_dev_get(dev);
-		if (!mdev)
-			continue;
-		rc = mctp_dump_dev_addrinfo(mdev, skb, cb);
-		mctp_dev_put(mdev);
-		if (rc < 0)
-			break;
-		mcb->a_idx = 0;
+	for (; mcb->h < NETDEV_HASHENTRIES; mcb->h++, mcb->idx = 0) {
+		idx = 0;
+		head = &net->dev_index_head[mcb->h];
+		hlist_for_each_entry_rcu(dev, head, index_hlist) {
+			if (idx >= mcb->idx &&
+			    (ifindex == 0 || ifindex == dev->ifindex)) {
+				mdev = __mctp_dev_get(dev);
+				if (mdev) {
+					rc = mctp_dump_dev_addrinfo(mdev,
+								    skb, cb);
+					mctp_dev_put(mdev);
+					// Error indicates full buffer, this
+					// callback will get retried.
+					if (rc < 0)
+						goto out;
+				}
+			}
+			idx++;
+			// reset for next iteration
+			mcb->a_idx = 0;
+		}
 	}
+out:
 	rcu_read_unlock();
+	mcb->idx = idx;
 
 	return skb->len;
 }
@@ -517,12 +532,9 @@ static struct notifier_block mctp_dev_nb = {
 };
 
 static const struct rtnl_msg_handler mctp_device_rtnl_msg_handlers[] = {
-	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_NEWADDR,
-	 .doit = mctp_rtm_newaddr},
-	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_DELADDR,
-	 .doit = mctp_rtm_deladdr},
-	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_GETADDR,
-	 .dumpit = mctp_dump_addrinfo},
+	{THIS_MODULE, PF_MCTP, RTM_NEWADDR, mctp_rtm_newaddr, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_DELADDR, mctp_rtm_deladdr, NULL, 0},
+	{THIS_MODULE, PF_MCTP, RTM_GETADDR, NULL, mctp_dump_addrinfo, 0},
 };
 
 int __init mctp_device_init(void)

---
base-commit: c2603c511feb427b2b09f74b57816a81272932a1
change-id: 20250609-dev-mctp-nl-addrinfo-b23f157735c8

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>


