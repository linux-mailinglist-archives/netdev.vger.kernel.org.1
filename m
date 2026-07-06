Return-Path: <netdev+bounces-304950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SsajFLGZS2o6WQEAu9opvQ
	(envelope-from <netdev+bounces-304950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:04:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DE37103A0
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 14:04:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b=GPVlpaGD;
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304950-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-304950-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F28638B95DA
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8783E4C77DC;
	Mon,  6 Jul 2026 09:46:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15AD3A1686;
	Mon,  6 Jul 2026 09:46:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331203; cv=none; b=fHU59H3KRH0LUpBP2MeBJmI5CXNeB6tkqkXWXi5VDkSVx3ElSig1uLmgc7taIT+tftWQCHLA1271Xqlcdc/xkuOVGJ3LiQoq2aOxz/ORml+YcBwVHmTkOb/DreSmh8k6KJoM3mCcoztwHnBBVfC4gE6Wro3pFOBiI1XDretGDFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331203; c=relaxed/simple;
	bh=qBGu4Eg6aXtmJf84ub/wFLby4RjgGYZfQwlHcJU1pHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rNjhvnf5yc26lidWvkkpZ8gUhasfm71yBJLivd7yWLNaland6Wr+vhThmLY1EjbDYFNknh7LFCynGWLw/e+EyUIHMDVFX+yhiQbXPyjs2HLmu8eys3o5Hf0q4t4E1nHNDUMoaN7jIAlYnkItgUcIYYyxkillrihuipOEVxybFx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=GPVlpaGD; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1783330992;
	bh=4aUq9hNomM3wVZ+MmRk9U8Emi4jxb74PHusgdr1u9DE=;
	h=From:To:Cc:Subject:Date;
	b=GPVlpaGD0FyiOz1hb8O69MIemTbYKSCZlr8FJMxlal8SOVcnSciMb3Zx8M+Bgx7GY
	 JQzGEBNlvVA/222VPFJv3Vk+BSj7uEe77Jp8aQsvrzSSbeMPAaWLbL/eZEs4tZbw5y
	 jLIh58UM3FbTW9nbBq+cVjcoHV248jG4yeC1uo1g=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.105])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 6669hBLT020592
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 6 Jul 2026 11:43:11 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowangio@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Tim Gebauer <tim.gebauer@tu-dortmund.de>,
        Brett Sheffield <brett@librecast.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Simon Schippers <simon.schippers@tu-dortmund.de>
Subject: [PATCH net v2] tun/tap & vhost-net: make qdisc backpressure opt-in via IFF_BACKPRESSURE
Date: Mon,  6 Jul 2026 11:42:42 +0200
Message-ID: <20260706094242.115992-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304950-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:willemdebruijn.kernel@gmail.com,m:jasowangio@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mst@redhat.com,m:netdev@vger.kernel.org,m:horms@kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:andrew+netdev@lunn.ch,m:tim.gebauer@tu-dortmund.de,m:brett@librecast.net,m:linux-doc@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:simon.schippers@tu-dortmund.de,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-dortmund.de:from_mime,tu-dortmund.de:email,tu-dortmund.de:mid,tu-dortmund.de:dkim,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B4DE37103A0

Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
when a qdisc is present") did not show a relevant performance regression
in my testing but on Brett Sheffield's librecast testbed it shows a
significant performance drop in a IPv6 multicast testcase. The regression
can be pinpointed when multiple iperf3 UDP threads are sending. For 8
threads the performance dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is
the reason why this patch makes the qdisc backpressure behavior opt-in.

One option to accomplish the opt-in would be to set the default qdisc to
noqueue at init. However this may also break userspace as users might
have chosen a custom qdisc even though most of the qdiscs did nothing
for tun/tap in the past due to missing backpressure...

This is the reason why in this patch, the flag IFF_BACKPRESSURE is
introduced instead which is required to enable the backpressure logic.
This means the stopping logic in tun_net_xmit() and the waking logic in
__tun_wake_queue() are skipped if the flag is disabled.

To avoid a possible stall due to disabling IFF_BACKPRESSURE, the new
helper tun_force_wake_queue() is implemented. The helper safely wakes the
respective netdev queue and resets cons_cnt while the consumer_lock and
the producer_lock of the ring are held. The helper is run in tun_attach()
when a queue (re)attaches, in tun_set_iff() for attached tfiles, and
in tun_queue_resize().

The documentation in tuntap.rst is updated accordingly.

Fixes: 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present")
Reported-by: Brett Sheffield <brett@librecast.net>
Closes: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/T/#u
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
V1 -> V2:
- Sashiko: Ensure detached queues are woken on re-attach by calling the
  new tun_force_wake_queue() helper from tun_attach(), and reuse it
  across the existing wake paths.
- Specify the failing test case in the commit message.
---
 Documentation/networking/tuntap.rst | 17 ++++++++++
 drivers/net/tun.c                   | 49 ++++++++++++++++++-----------
 include/uapi/linux/if_tun.h         |  1 +
 tools/include/uapi/linux/if_tun.h   |  1 +
 4 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/Documentation/networking/tuntap.rst b/Documentation/networking/tuntap.rst
index 4d7087f727be..599264825dd2 100644
--- a/Documentation/networking/tuntap.rst
+++ b/Documentation/networking/tuntap.rst
@@ -206,6 +206,23 @@ enable is true we enable it, otherwise we disable it::
       return ioctl(fd, TUNSETQUEUE, (void *)&ifr);
   }
 
+3.4 qdisc backpressure
+----------------------
+
+Starting with Linux 7.2, IFF_BACKPRESSURE can be set to enable qdisc
+backpressure. Without it, TX drops occur when the internal ring buffer is
+full. With it, the kernel stops the TX queue instead, letting the qdisc
+hold packets. Drops only occur as a rare race. This can benefit protocols
+like TCP that react to drops. Backpressure requires a qdisc to be
+attached and has no effect with noqueue.
+
+The TUN/TAP ring buffer size can be reduced alongside this flag to
+further shift buffering into the qdisc and reduce bufferbloat, but comes
+at possible performance cost.
+
+When running multiple network streams in parallel, the flag may reduce
+performance due to the extra overhead of the backpressure mechanism.
+
 Universal TUN/TAP device driver Frequently Asked Question
 =========================================================
 
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index ffbe6f13fb1f..62e5eab4e345 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -98,7 +98,8 @@ static void tun_default_link_ksettings(struct net_device *dev,
 #define TUN_FASYNC	IFF_ATTACH_QUEUE
 
 #define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | \
-		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS)
+		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS | \
+		      IFF_BACKPRESSURE)
 
 #define GOODCOPY_LEN 128
 
@@ -694,6 +695,20 @@ static void tun_detach_all(struct net_device *dev)
 		module_put(THIS_MODULE);
 }
 
+static void tun_force_wake_queue(struct tun_struct *tun,
+				 struct tun_file *tfile)
+{
+	/* Ensure that the producer can not stop the
+	 * queue concurrently by taking locks.
+	 */
+	spin_lock_bh(&tfile->tx_ring.consumer_lock);
+	spin_lock(&tfile->tx_ring.producer_lock);
+	netif_wake_subqueue(tun->dev, tfile->queue_index);
+	tfile->cons_cnt = 0;
+	spin_unlock(&tfile->tx_ring.producer_lock);
+	spin_unlock_bh(&tfile->tx_ring.consumer_lock);
+}
+
 static int tun_attach(struct tun_struct *tun, struct file *file,
 		      bool skip_filter, bool napi, bool napi_frags,
 		      bool publish_tun)
@@ -737,11 +752,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		goto out;
 	}
 
-	spin_lock(&tfile->tx_ring.consumer_lock);
-	tfile->cons_cnt = 0;
-	spin_unlock(&tfile->tx_ring.consumer_lock);
 	tfile->queue_index = tun->numqueues;
 	tfile->socket.sk->sk_shutdown &= ~RCV_SHUTDOWN;
+	tun_force_wake_queue(tun, tfile);
 
 	if (tfile->detached) {
 		/* Re-attach detached tfile, updating XDP queue_index */
@@ -1077,7 +1090,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	spin_lock(&tfile->tx_ring.producer_lock);
 	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
-	if (!qdisc_txq_has_no_queue(queue) &&
+	if ((tun->flags & IFF_BACKPRESSURE) &&
+	    !qdisc_txq_has_no_queue(queue) &&
 	    __ptr_ring_check_produce(&tfile->tx_ring) == -ENOSPC) {
 		netif_tx_stop_queue(queue);
 		/* Paired with smp_mb() in __tun_wake_queue() */
@@ -2151,8 +2165,12 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 static void __tun_wake_queue(struct tun_struct *tun,
 			     struct tun_file *tfile, int consumed)
 {
-	struct netdev_queue *txq = netdev_get_tx_queue(tun->dev,
-						tfile->queue_index);
+	struct netdev_queue *txq;
+
+	if (!(tun->flags & IFF_BACKPRESSURE))
+		return;
+
+	txq = netdev_get_tx_queue(tun->dev, tfile->queue_index);
 
 	/* Paired with smp_mb__after_atomic() in tun_net_xmit() */
 	smp_mb();
@@ -2764,7 +2782,7 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 	struct tun_struct *tun;
 	struct tun_file *tfile = file->private_data;
 	struct net_device *dev;
-	int err;
+	int err, i;
 
 	if (tfile->detached)
 		return -EINVAL;
@@ -2894,7 +2912,8 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 	 * xoff state.
 	 */
 	if (netif_running(tun->dev))
-		netif_tx_wake_all_queues(tun->dev);
+		for (i = 0; i < tun->numqueues; i++)
+			tun_force_wake_queue(tun, rtnl_dereference(tun->tfiles[i]));
 
 	strscpy(ifr->ifr_name, tun->dev->name);
 	return 0;
@@ -3690,15 +3709,9 @@ static int tun_queue_resize(struct tun_struct *tun)
 					  dev->tx_queue_len, GFP_KERNEL,
 					  tun_ptr_free);
 
-	if (!ret) {
-		for (i = 0; i < tun->numqueues; i++) {
-			tfile = rtnl_dereference(tun->tfiles[i]);
-			spin_lock(&tfile->tx_ring.consumer_lock);
-			netif_wake_subqueue(tun->dev, tfile->queue_index);
-			tfile->cons_cnt = 0;
-			spin_unlock(&tfile->tx_ring.consumer_lock);
-		}
-	}
+	if (!ret)
+		for (i = 0; i < tun->numqueues; i++)
+			tun_force_wake_queue(tun, rtnl_dereference(tun->tfiles[i]));
 
 	kfree(rings);
 	return ret;
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 79d53c7a1ebd..73a77141315c 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -69,6 +69,7 @@
 #define IFF_NAPI_FRAGS	0x0020
 /* Used in TUNSETIFF to bring up tun/tap without carrier */
 #define IFF_NO_CARRIER	0x0040
+#define IFF_BACKPRESSURE	0x0080
 #define IFF_NO_PI	0x1000
 /* This flag has no real effect */
 #define IFF_ONE_QUEUE	0x2000
diff --git a/tools/include/uapi/linux/if_tun.h b/tools/include/uapi/linux/if_tun.h
index 2ec07de1d73b..97b670f5bc0a 100644
--- a/tools/include/uapi/linux/if_tun.h
+++ b/tools/include/uapi/linux/if_tun.h
@@ -67,6 +67,7 @@
 #define IFF_TAP		0x0002
 #define IFF_NAPI	0x0010
 #define IFF_NAPI_FRAGS	0x0020
+#define IFF_BACKPRESSURE	0x0080
 #define IFF_NO_PI	0x1000
 /* This flag has no real effect */
 #define IFF_ONE_QUEUE	0x2000
-- 
2.43.0


