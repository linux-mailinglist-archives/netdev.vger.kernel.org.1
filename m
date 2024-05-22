Return-Path: <netdev+bounces-97635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB308CC77E
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 21:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50C96B20FE2
	for <lists+netdev@lfdr.de>; Wed, 22 May 2024 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6FB1465B2;
	Wed, 22 May 2024 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="I1sOM9Yw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp72.iad3b.emailsrvr.com (smtp72.iad3b.emailsrvr.com [146.20.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF3146004
	for <netdev@vger.kernel.org>; Wed, 22 May 2024 19:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716407525; cv=none; b=WDGXVGvU5nVH65kRJ1mYz65MnlpyQYVc/KknEnJK22cMWG06mQpofbKi8BKrzELNGV7w4r1atWG80i2fwg6WQf83pY/s3EakHjec4S+xKXY6WOd+LCUNjg58uX1Y1mh2M4YqAkOGBKDZVyLOUOIJcVgcTYvs6SdE6t6TBs3VIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716407525; c=relaxed/simple;
	bh=ySNPFp42Pieo074fBKwdp9rOAjmYfFBiDHDybLRZ5yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jJXypwTocH0TE7I295+xdDO7/MJJopEIhxdXqTKQGHg0Oww9uIGdUuaOo7BFOPaQBglfqBjREB+qhSQNBU+SdJlwq/LG3vVFUoEGKO0+tbETMOmhjxUqem/lEqDp+TvtJJ5XjZbXTYL8ktMxajduwUUnghcp+C7ir7xP3ivTZLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=I1sOM9Yw; arc=none smtp.client-ip=146.20.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1716402792;
	bh=ySNPFp42Pieo074fBKwdp9rOAjmYfFBiDHDybLRZ5yQ=;
	h=From:To:Subject:Date:From;
	b=I1sOM9YwNhBKkJHBauFg6rOU4OIqzluZ8nH+acyY8RdNrl/0NesBmWFmiryFMCSYX
	 zxSk12F3GBBiQYc8Zt5NrBANuQM3XI6Kj3+2o9hi/5Vz9i/BQOt/TNEtx/rWe7CaC0
	 eUYsVSWbQQUxsOD1P68okQ9GiWJBjMrRXx/910T4=
X-Auth-ID: lars@oddbit.com
Received: by smtp18.relay.iad3b.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id BB159E01A1;
	Wed, 22 May 2024 14:33:12 -0400 (EDT)
From: lars@oddbit.com
To: linux-hams@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Lars Kellogg-Stedman <lars@oddbit.com>
Subject: [PATCH v4] ax25: Fix refcount imbalance on inbound connections
Date: Wed, 22 May 2024 14:31:34 -0400
Message-ID: <20240522183133.729159-2-lars@oddbit.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: f7386572-d13f-4673-a958-15858f2dedea-1-1

From: Lars Kellogg-Stedman <lars@oddbit.com>

When releasing a socket in ax25_release(), we call netdev_put() to
decrease the refcount on the associated ax.25 device. However, the
execution path for accepting an incoming connection never calls
netdev_hold(). This imbalance leads to refcount errors, and ultimately
to kernel crashes.

A typical call trace for the above situation looks like this:

    Call Trace:
    <TASK>
    ? show_regs+0x64/0x70
    ? __warn+0x83/0x120
    ? refcount_warn_saturate+0xb2/0x100
    ? report_bug+0x158/0x190
    ? prb_read_valid+0x20/0x30
    ? handle_bug+0x3e/0x70
    ? exc_invalid_op+0x1c/0x70
    ? asm_exc_invalid_op+0x1f/0x30
    ? refcount_warn_saturate+0xb2/0x100
    ? refcount_warn_saturate+0xb2/0x100
    ax25_release+0x2ad/0x360
    __sock_release+0x35/0xa0
    sock_close+0x19/0x20
    [...]

On reboot (or any attempt to remove the interface), the kernel gets
stuck in an infinite loop:

    unregister_netdevice: waiting for ax0 to become free. Usage count = 0

This patch corrects these issues by ensuring that we call netdev_hold()
and ax25_dev_hold() for new connections in ax25_accept().

Fixes: 7d8a3a477b ("ax25: Fix ax25 session cleanup problems")
Signed-off-by: Lars Kellogg-Stedman <lars@oddbit.com>
---
v3:
- Address naveenm's comments regarding the ordering of variable declarations
  (https://lore.kernel.org/netdev/SJ2PR18MB5635B7ADC7339BEDB79B183DA2EA2@SJ2PR18MB5635.namprd18.prod.outlook.com/)

v4:
- respond to kuba's comments regarding the Fixes: tag
  (https://lore.kernel.org/netdev/20240522100701.4d9edf99@kernel.org/)

 net/ax25/af_ax25.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ax25/af_ax25.c b/net/ax25/af_ax25.c
index 8077cf2ee44..d6f9fae06a9 100644
--- a/net/ax25/af_ax25.c
+++ b/net/ax25/af_ax25.c
@@ -1378,8 +1378,10 @@ static int ax25_accept(struct socket *sock, struct socket *newsock,
 {
 	struct sk_buff *skb;
 	struct sock *newsk;
+	ax25_dev *ax25_dev;
 	DEFINE_WAIT(wait);
 	struct sock *sk;
+	ax25_cb *ax25;
 	int err = 0;
 
 	if (sock->state != SS_UNCONNECTED)
@@ -1434,6 +1436,10 @@ static int ax25_accept(struct socket *sock, struct socket *newsock,
 	kfree_skb(skb);
 	sk_acceptq_removed(sk);
 	newsock->state = SS_CONNECTED;
+	ax25 = sk_to_ax25(newsk);
+	ax25_dev = ax25->ax25_dev;
+	netdev_hold(ax25_dev->dev, &ax25->dev_tracker, GFP_ATOMIC);
+	ax25_dev_hold(ax25_dev);
 
 out:
 	release_sock(sk);
-- 
2.45.1


