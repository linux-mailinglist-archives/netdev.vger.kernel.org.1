Return-Path: <netdev+bounces-133875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED266997517
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:47:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94B042848BC
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B33A613A244;
	Wed,  9 Oct 2024 18:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OxBfxbdc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD955684
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499637; cv=none; b=aJIT4JuoywSqI9i87b3mqhKccollS64Yp7qyX4E/zd5ku1mSA8/OcAbdvX+lXKgdfAIj8an54VZHYy9P/CSdc6joWzgV+i7khzbvzQ//uBlgwhnNq3F1KsjAnS3aIIbC4EihiBP/vZrHV6U9HVzyjab+PzzEnVCBvyKQZlf6ORo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499637; c=relaxed/simple;
	bh=mqQXb1PRcCkiH0OpP5ASsUkHVa4zm5DVcQJVseI3wvs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PI3DZtQf6rP0o/CBwEsjJYom4MY/DJzWi6mxN59DWS0RgFWQ8c4fMmTYyJcjEwvgRTbO4np/9Y8vwo/GdCvgUKmG39B8UjclwO5r6X5v6/8IVUElKWPu+twdyq/B9577l7lqTxMmVFPI/ahfyjJZ93yjwdZV+qiCfRlEG3Kaw7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OxBfxbdc; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7a99e4417c3so4533285a.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728499635; x=1729104435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zfBCp52mvk68I7rc+l3mFAeNp86IoOAUXWouNKdT8ys=;
        b=OxBfxbdcHwc59pMnq0rGRzB/kNIaKq/LknrObT1hjlytCGajsnUiXkLDl8Ed6n+AMs
         GVPhXF++yBX4IY2AQ3rAUMOz1smFJ42p4zElyhgnhVnY8mbq6XlmnVnUAtmaI33eHk83
         eD7VueCQG94pr+naz1hjth1LQmyqRltcxZhhVnjOlH71cUmWYR/KybIXsEGcmLayxuxv
         9Z8G2UEQD2Dys1VTAeHUm6vz/dl3XL/AnRiVs3Qk7vI+aqP6Vmqus7gW7/XjZKkEYXel
         5TxBsHaU7WOrOuisPRuTbzjWSARmBk/60+0ziQfoiOdA31fU9pB/UqmAsjHIoehOud/u
         kWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728499635; x=1729104435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfBCp52mvk68I7rc+l3mFAeNp86IoOAUXWouNKdT8ys=;
        b=G/O7gVFRtF/OHMXQJgKBJF+l2svlqaXBH9jcvkwYyqql1/8Tbsuwv5iAEri1DqZPy2
         TUXXUKrND5vR9lsn2E31AWZfFib7JAGTAN10hZ3lo6h0TPbJt8pb4xLpw7ATOMJWgdJk
         Abyb2iS6ZtDfebBziKFJDzbH5Wth5NKOoPzQslXqrCCEo1c/SVE3mP8WBDchDiTUdiQb
         l79eimqoS4FoDCKpaXhswzic682f3moV1setixc+AAVuu5WbWuD3Y2Yq3/JJ5rmE8U03
         yiNAAIKjah/6USmS/IVQCfcpGnrMNs4pcm5R/A6IzDwXIKYbH96owAtK0F0I5QCJyzox
         R5Pg==
X-Gm-Message-State: AOJu0Yw4d6sbArEbs2yri5BgE4rgArkTAS0+PFYv7MNQOO41H/G73S5W
	sHIpEZPXhjvgW9x4g2jLbM5dVhlTRRdZea3ze177zV91tCYKZ3Rn0mL43Q==
X-Google-Smtp-Source: AGHT+IEiPk1RY+Wb3MMraOqBozTCjZKYcb1eL2ctwTAdGKkE73Lmsjd+DGO7lAqA23R9QpIbf/IOUA==
X-Received: by 2002:a05:620a:3197:b0:7af:cdf9:8c13 with SMTP id af79cd13be357-7b07954f1f1mr655737385a.36.1728499634821;
        Wed, 09 Oct 2024 11:47:14 -0700 (PDT)
Received: from wsfd-netdev15.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ae756611b5sm479330385a.77.2024.10.09.11.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 11:47:14 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Mahesh Bandewar <maheshb@google.com>
Subject: [PATCH net] ipv4: give an IPv4 dev to blackhole_netdev
Date: Wed,  9 Oct 2024 14:47:13 -0400
Message-ID: <3000792d45ca44e16c785ebe2b092e610e5b3df1.1728499633.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to
invalidate dst entries"), blackhole_netdev was introduced to invalidate
dst cache entries on the TX path whenever the cache times out or is
flushed.

When two UDP sockets (sk1 and sk2) send messages to the same destination
simultaneously, they are using the same dst cache. If the dst cache is
invalidated on one path (sk2) while the other (sk1) is still transmitting,
sk1 may try to use the invalid dst entry.

         CPU1                   CPU2

      udp_sendmsg(sk1)       udp_sendmsg(sk2)
      udp_send_skb()
      ip_output()
                                             <--- dst timeout or flushed
                             dst_dev_put()
      ip_finish_output2()
      ip_neigh_for_gw()

This results in a scenario where ip_neigh_for_gw() returns -EINVAL because
blackhole_dev lacks an in_dev, which is needed to initialize the neigh in
arp_constructor(). This error is then propagated back to userspace,
breaking the UDP application.

The patch fixes this issue by assigning an in_dev to blackhole_dev for
IPv4, similar to what was done for IPv6 in commit e5f80fcf869a ("ipv6:
give an IPv6 dev to blackhole_netdev"). This ensures that even when the
dst entry is invalidated with blackhole_dev, it will not fail to create
the neigh entry.

As devinet_init() is called ealier than blackhole_netdev_init() in system
booting, it can not assign the in_dev to blackhole_dev in devinet_init().
As Paolo suggested, add a separate late_initcall() in devinet.c to ensure
inet_blackhole_dev_init() is called after blackhole_netdev_init().

Fixes: 8d7017fd621d ("blackhole_netdev: use blackhole_netdev to invalidate dst entries")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/ipv4/devinet.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index ab76744383cf..7cf5f7d0d0de 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -298,17 +298,19 @@ static struct in_device *inetdev_init(struct net_device *dev)
 	/* Account for reference dev->ip_ptr (below) */
 	refcount_set(&in_dev->refcnt, 1);
 
-	err = devinet_sysctl_register(in_dev);
-	if (err) {
-		in_dev->dead = 1;
-		neigh_parms_release(&arp_tbl, in_dev->arp_parms);
-		in_dev_put(in_dev);
-		in_dev = NULL;
-		goto out;
+	if (dev != blackhole_netdev) {
+		err = devinet_sysctl_register(in_dev);
+		if (err) {
+			in_dev->dead = 1;
+			neigh_parms_release(&arp_tbl, in_dev->arp_parms);
+			in_dev_put(in_dev);
+			in_dev = NULL;
+			goto out;
+		}
+		ip_mc_init_dev(in_dev);
+		if (dev->flags & IFF_UP)
+			ip_mc_up(in_dev);
 	}
-	ip_mc_init_dev(in_dev);
-	if (dev->flags & IFF_UP)
-		ip_mc_up(in_dev);
 
 	/* we can receive as soon as ip_ptr is set -- do this last */
 	rcu_assign_pointer(dev->ip_ptr, in_dev);
@@ -347,6 +349,19 @@ static void inetdev_destroy(struct in_device *in_dev)
 	in_dev_put(in_dev);
 }
 
+static int __init inet_blackhole_dev_init(void)
+{
+	int err = 0;
+
+	rtnl_lock();
+	if (!inetdev_init(blackhole_netdev))
+		err = -ENOMEM;
+	rtnl_unlock();
+
+	return err;
+}
+late_initcall(inet_blackhole_dev_init);
+
 int inet_addr_onlink(struct in_device *in_dev, __be32 a, __be32 b)
 {
 	const struct in_ifaddr *ifa;
-- 
2.43.0


