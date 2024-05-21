Return-Path: <netdev+bounces-97390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF41B8CB3CB
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 20:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C3AAB20819
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 18:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0372D047;
	Tue, 21 May 2024 18:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b="NayxH8+S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp78.ord1d.emailsrvr.com (smtp78.ord1d.emailsrvr.com [184.106.54.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A0A1C69C
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 18:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716317207; cv=none; b=BYbj1O1D/aE6dZDwm31XIOsaXQGGJPrw0wX7MfRpX6yR/4+xGk5vc6dmoYgcoXj8NAC3HNzGZuGM5f9u1T434OsuDVAAb/HmnFECo2eFcxQGAVxd94mko+rOtlnxy4OSduege87esotJwSR6Vgy8RxYKY55+fyG0Ba5LuP4s1rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716317207; c=relaxed/simple;
	bh=lOKK/5m+qA9LdcBHtKAEthPfe6R9WLDjsnuKWoCBCZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHHVbr5t6pLo5l0XP0Ic5DQ4GhB7eJE+NYeQdfOm5/Ch35ElVfuM2Bsy5GVRlsEs5B1LDSvQWFggP6UQ5qmdLmCbsPpkPjkC231wf9NuKzHMkn+ZycWi+quyxjs+RHtBR+3LUesENUhh8H2vwJ42RQaUwzthYzHpqgu51jii06s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com; spf=pass smtp.mailfrom=oddbit.com; dkim=pass (1024-bit key) header.d=oddbit.com header.i=@oddbit.com header.b=NayxH8+S; arc=none smtp.client-ip=184.106.54.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=oddbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oddbit.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=oddbit.com;
	s=20180920-g2b7aziw; t=1716316029;
	bh=lOKK/5m+qA9LdcBHtKAEthPfe6R9WLDjsnuKWoCBCZQ=;
	h=From:To:Subject:Date:From;
	b=NayxH8+ShytwclL3FH7ph0rkTerv5q3cBktCUb6V86yMA6cTNeacB/XjYSKrUlONk
	 1+p6/dzrfu5PvBEJS6Vp/crfSMRhMGqvAcOPN6VfTk3hpBb/MDKxm5y8qv8HDp1jeW
	 +rnMB784A00rRVbVDWA8HzXnr0pmMaWkhXnzqAlo=
X-Auth-ID: lars@oddbit.com
Received: by smtp2.relay.ord1d.emailsrvr.com (Authenticated sender: lars-AT-oddbit.com) with ESMTPSA id 3D72B2010B;
	Tue, 21 May 2024 14:27:09 -0400 (EDT)
From: lars@oddbit.com
To: linux-hams@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Lars Kellogg-Stedman <lars@oddbit.com>
Subject: [PATCH v3] ax25: Fix refcount imbalance on inbound connections
Date: Tue, 21 May 2024 14:23:25 -0400
Message-ID: <20240521182323.600609-3-lars@oddbit.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <46ydfjtpinm3py3zt6lltxje4cpdvuugaatbvx4y27m7wxc2hz@4wdtoq7yfrd5>
References: <46ydfjtpinm3py3zt6lltxje4cpdvuugaatbvx4y27m7wxc2hz@4wdtoq7yfrd5>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 5f2aa4a5-fbf8-4e20-b489-d3016774c572-1-1

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

Fixes: 7d8a3a477b
Signed-off-by: Lars Kellogg-Stedman <lars@oddbit.com>
---
v3:
- Address naveenm's comments regarding the ordering of variable
  declarations (https://lore.kernel.org/netdev/SJ2PR18MB5635B7ADC7339BEDB79B183DA2EA2@SJ2PR18MB5635.namprd18.prod.outlook.com/)

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


