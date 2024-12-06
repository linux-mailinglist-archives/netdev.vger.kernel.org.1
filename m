Return-Path: <netdev+bounces-149853-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636909E7BDC
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 23:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CB3F16D4D9
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 22:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497421C3F34;
	Fri,  6 Dec 2024 22:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SP6gid6e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F21522C6D9
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 22:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733524697; cv=none; b=B53L1Jmax1oT4Zjs7fb8P9zCjP5Z9rlhMV5LsJUByi7Ys91IY+/GJ9RfCsAdWjE4bi28k1MYalfpxNzoqhbsRm/5pKtNGRTdqGRVplslNXm0r1qmQzB+XRXOl6VP/Llp/JMJ7IkQrs1HWukjrRQkEF88iSAB/X+sJi5h3C4bdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733524697; c=relaxed/simple;
	bh=+KahjWkKKHf7Kr+cIJ8XN54sSNZKpQNaIP4nqimDcAo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FOnlB/W5KLPIcKpHaGDM7ZgZhkO+sVdz2pb0kFefYxpDNd8gkKchvQKMY9nUs8OkELMFpTSUiroN8u4431QMOgIWsMZ+bBCoPv5FYdaW3q3mgJ2vpmzJ/OQhfAkSVVl/1UN3pxHQvVLCUmOtFDOPiRLejN1/8N4KLT544XyoEXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SP6gid6e; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7b69c165661so298982885a.2
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 14:38:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733524694; x=1734129494; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rwCouMcX1+pw+wA3+z1ardlTUZELDS3YzjK5RN5UVyg=;
        b=SP6gid6eyzEo40wS+sj61w8HZ+ff7xrk2n/cwnV2iA2GBUhbo59VEy79bH+yUzvZOs
         FcQstaqqxAtaTZcAy0QdrZgoEWoKA7+6C3ua9bg2d2wcacHsAcL4b0SLNDj73nTvAkdV
         jI+mAXiY8qjPWFSvdQlWWO5GqT5G1CzrmiQH7JgOI8C37d4MQju3DwcdQB277ZVt6hNX
         VxQl3RDlnZMfPjSQCXVPOHZJ+Ya5pUcXZuOdneBJxF50a26lg1k/PRGV0D8xIvoWTUES
         UgUBFIm2dP1abtgCUCXfQ7Kuvu7UTmvjiIOEeJhnTdxCiwFdO5NnwR+Cb5CTIuX9xenQ
         628g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733524694; x=1734129494;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwCouMcX1+pw+wA3+z1ardlTUZELDS3YzjK5RN5UVyg=;
        b=m2Yk/PIauxi8A0MCa/wU20hEYh3OvrpYLDc5S9tqOwSqQqa7L5xPP66+/dBp9RcbVi
         5GLUYueL29tRBqx0SxI9EeTDpcW8kDuDtX5VsFJzPIq43N3Lgsku93rzrfbiEJR2IGff
         +iG207JpgQO023MMa6qZaeLshfVwKHwfmIO09XPGWCPFPofEwAu0ep62W22OFWglWuJx
         k6doRCwQvkcCQIhhYhzxKHW+yv4SmVSreiCMYQ4xHpRm5xlfttEP348ecgaRTunLpG/i
         WVo30BAxx4+9PHePdTTcvqO5LqFPY8DCzAVzuXgAknG8u9y+djbNZ0IpVkMoCOzkP8Wx
         skAw==
X-Gm-Message-State: AOJu0YydHjxV4v1Nc+Kwpf9tKjvlqxMnSrfOH4KbLYSOlQ3IhVqtC8e9
	/E6zpsUF0Z8yeEu7v11/SPwWXPrr2C9szOfay5/MLQk6h4LFvEZpMEAqfzmetxi2MbdgZbefa2W
	PZFZU13IwLA==
X-Google-Smtp-Source: AGHT+IFtn0AMRSzG04GpSFNWOWkAuTjB3s1HfejltXt+f6W8BzOWODgnqfG3kQn0VQZU9bobDu5tKJfIOh1yQA==
X-Received: from qtbbn5.prod.google.com ([2002:a05:622a:1dc5:b0:466:a9ac:a24a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5fca:0:b0:464:94cf:98a3 with SMTP id d75a77b69052e-46734f977b6mr56472751cf.51.1733524694561;
 Fri, 06 Dec 2024 14:38:14 -0800 (PST)
Date: Fri,  6 Dec 2024 22:38:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241206223811.1343076-1-edumazet@google.com>
Subject: [PATCH net-next] mctp: no longer rely on net->dev_index_head[]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
	Matt Johnston <matt@codeconstruct.com.au>, Kuniyuki Iwashima <kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"

mctp_dump_addrinfo() is one of the last users of
net->dev_index_head[] in the control path.

Switch to for_each_netdev_dump() for better scalability.

Use C99 for mctp_device_rtnl_msg_handlers[] to prepare
future RTNL removal from mctp_dump_addrinfo()

(mdev->addrs is not yet RCU protected)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: Matt Johnston <matt@codeconstruct.com.au>
---
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/mctp/device.c | 50 ++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 31 deletions(-)

diff --git a/net/mctp/device.c b/net/mctp/device.c
index 26ce34b7e88e174cdb6fa65c0d8e5bf6b5a580d7..8e0724c56723de328592bfe5c6fc8085cd3102fe 100644
--- a/net/mctp/device.c
+++ b/net/mctp/device.c
@@ -20,8 +20,7 @@
 #include <net/sock.h>
 
 struct mctp_dump_cb {
-	int h;
-	int idx;
+	unsigned long ifindex;
 	size_t a_idx;
 };
 
@@ -115,43 +114,29 @@ static int mctp_dump_addrinfo(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct mctp_dump_cb *mcb = (void *)cb->ctx;
 	struct net *net = sock_net(skb->sk);
-	struct hlist_head *head;
 	struct net_device *dev;
 	struct ifaddrmsg *hdr;
 	struct mctp_dev *mdev;
-	int ifindex;
-	int idx = 0, rc;
+	int ifindex, rc;
 
 	hdr = nlmsg_data(cb->nlh);
 	// filter by ifindex if requested
 	ifindex = hdr->ifa_index;
 
 	rcu_read_lock();
-	for (; mcb->h < NETDEV_HASHENTRIES; mcb->h++, mcb->idx = 0) {
-		idx = 0;
-		head = &net->dev_index_head[mcb->h];
-		hlist_for_each_entry_rcu(dev, head, index_hlist) {
-			if (idx >= mcb->idx &&
-			    (ifindex == 0 || ifindex == dev->ifindex)) {
-				mdev = __mctp_dev_get(dev);
-				if (mdev) {
-					rc = mctp_dump_dev_addrinfo(mdev,
-								    skb, cb);
-					mctp_dev_put(mdev);
-					// Error indicates full buffer, this
-					// callback will get retried.
-					if (rc < 0)
-						goto out;
-				}
-			}
-			idx++;
-			// reset for next iteration
-			mcb->a_idx = 0;
-		}
+	for_each_netdev_dump(net, dev, mcb->ifindex) {
+		if (ifindex && ifindex != dev->ifindex)
+			continue;
+		mdev = __mctp_dev_get(dev);
+		if (!mdev)
+			continue;
+		rc = mctp_dump_dev_addrinfo(mdev, skb, cb);
+		mctp_dev_put(mdev);
+		if (rc < 0)
+			break;
+		mcb->a_idx = 0;
 	}
-out:
 	rcu_read_unlock();
-	mcb->idx = idx;
 
 	return skb->len;
 }
@@ -531,9 +516,12 @@ static struct notifier_block mctp_dev_nb = {
 };
 
 static const struct rtnl_msg_handler mctp_device_rtnl_msg_handlers[] = {
-	{THIS_MODULE, PF_MCTP, RTM_NEWADDR, mctp_rtm_newaddr, NULL, 0},
-	{THIS_MODULE, PF_MCTP, RTM_DELADDR, mctp_rtm_deladdr, NULL, 0},
-	{THIS_MODULE, PF_MCTP, RTM_GETADDR, NULL, mctp_dump_addrinfo, 0},
+	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_NEWADDR,
+	 .doit = mctp_rtm_newaddr},
+	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_DELADDR,
+	 .doit = mctp_rtm_deladdr},
+	{.owner = THIS_MODULE, .protocol = PF_MCTP, .msgtype = RTM_GETADDR,
+	 .dumpit = mctp_dump_addrinfo},
 };
 
 int __init mctp_device_init(void)
-- 
2.47.0.338.g60cca15819-goog


