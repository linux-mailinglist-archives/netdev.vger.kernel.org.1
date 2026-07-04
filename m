Return-Path: <netdev+bounces-304704-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3ROyGoXtSGravQAAu9opvQ
	(envelope-from <netdev+bounces-304704-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 13:24:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 332557076A3
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 13:24:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tu-dortmund.de header.s=unimail header.b=OgP90bpl;
	dmarc=pass (policy=none) header.from=tu-dortmund.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304704-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304704-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DD7030028D0
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CBF36164D;
	Sat,  4 Jul 2026 11:24:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47A433E8C;
	Sat,  4 Jul 2026 11:24:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783164287; cv=none; b=XM00643lZJlM1TO4blFMvMR5LaOx4FoPLkJzUggHPWYtVfAe4ZjRfp8WmGnrjRQ2XSGHjjkRco35RVAZkB2YVLwVmGtfB9eNzBh7w8vUb9GJiK8bYYo5EDoFWA/zKW/puyTmzs9KFJ8AKxlSNu730Rikfdca0X7pfxI23XjQkTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783164287; c=relaxed/simple;
	bh=4fOf6IXbEH66LQECeBuF/0Rt8XaxrckHsD+LOO8Ay/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PSk5Mh23Rjnz+G3Sw6X+Zhfg7ebraVOlaEUjgQ8MqgPuYDTsd86hodwa/QkN78ya/wK1I0QX+DRfYwRZmdKDB6ACLmMe2BCPydfz91bkShQAA6BtEgdlH4Wjgk6Zhky9CFRdEpWM1YdfGLpvSYBtzgGngzFKsHZ/3hyy9Dkg1r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=OgP90bpl; arc=none smtp.client-ip=129.217.128.51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1783164080;
	bh=F7CEOlgk7OIq+TsTOEFv9JiycRsTfQEkLuR7K4P5tLs=;
	h=From:To:Cc:Subject:Date;
	b=OgP90bpligmzDSTAL/u6vw8YMlcQ8RkvmWWds+keFR4m2r0JBlEm3VxgNy+u+/iR5
	 PSnLhUAUs64yxuEMz+JoEV7TW/bU9jzEVbwFYrKW0TKi5dyAspVdiXrKAX8Ro3K2cC
	 rpcU80AekuQ+1Nd+rqQzLoxd1bXSpCSzUOYvwn0w=
Received: from simon-Latitude-5450.fritz.box (p5dc887d7.dip0.t-ipconnect.de [93.200.135.215])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 664BLIUF019003
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 4 Jul 2026 13:21:18 +0200 (CEST)
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
Subject: [PATCH net] tun/tap & vhost-net: make qdisc backpressure opt-in via IFF_BACKPRESSURE
Date: Sat,  4 Jul 2026 13:20:58 +0200
Message-ID: <20260704112058.95421-1-simon.schippers@tu-dortmund.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304704-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 332557076A3

Commit 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop
when a qdisc is present") did not show a relevant performance regression
in my testing but on Brett Sheffield's librecast testbed it shows a
significant performance drop. The regression can be pinpointed when
multiple iperf3 TCP threads are sending. For 8 threads the performance
dropped from 13.5 Gbit/s to 9.13 Gbit/s. This is the reason why this
patch makes the qdisc backpressure behavior opt-in.

One option to accomplish the opt-in would be to set the default qdisc to
noqueue at init. However this may also break userspace as users might
have chosen a custom qdisc even though most of the qdiscs did nothing
for tun/tap in the past due to missing backpressure...

This is the reason why in this patch, the flag IFF_BACKPRESSURE is
introduced instead which is required to enable the backpressure logic.
This means the stopping logic in tun_net_xmit() and the waking logic in
__tun_wake_queue() are skipped if the flag is disabled.

In tun_set_iff(), netif_tx_wake_all_queues() is replaced with looping
over all tfiles in which the netdev queues are woken and cons_cnt is
reset while the consumer_lock and producer_lock are held. This is to
ensure that tun_net_xmit() can not stop the queue concurrently, avoiding
a possible stall.

The documentation in tuntap.rst is updated accordingly.

Fixes: 1d6e569b7d0c ("tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present")
Reported-by: Brett Sheffield <brett@librecast.net>
Closes: https://lore.kernel.org/netdev/akVnoOYQOrt8k-Gu@karahi.librecast.net/T/#u
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 Documentation/networking/tuntap.rst | 17 +++++++++++++++++
 drivers/net/tun.c                   | 29 +++++++++++++++++++++++------
 include/uapi/linux/if_tun.h         |  1 +
 tools/include/uapi/linux/if_tun.h   |  1 +
 4 files changed, 42 insertions(+), 6 deletions(-)

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
index ffbe6f13fb1f..3bf8a73a0816 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -98,7 +98,8 @@ static void tun_default_link_ksettings(struct net_device *dev,
 #define TUN_FASYNC	IFF_ATTACH_QUEUE
 
 #define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | \
-		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS)
+		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS | \
+		      IFF_BACKPRESSURE)
 
 #define GOODCOPY_LEN 128
 
@@ -1077,7 +1078,8 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	spin_lock(&tfile->tx_ring.producer_lock);
 	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
-	if (!qdisc_txq_has_no_queue(queue) &&
+	if ((tun->flags & IFF_BACKPRESSURE) &&
+	    !qdisc_txq_has_no_queue(queue) &&
 	    __ptr_ring_check_produce(&tfile->tx_ring) == -ENOSPC) {
 		netif_tx_stop_queue(queue);
 		/* Paired with smp_mb() in __tun_wake_queue() */
@@ -2151,8 +2153,12 @@ static ssize_t tun_put_user(struct tun_struct *tun,
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
@@ -2893,8 +2899,19 @@ static int tun_set_iff(struct net *net, struct file *file, struct ifreq *ifr)
 	/* Make sure persistent devices do not get stuck in
 	 * xoff state.
 	 */
-	if (netif_running(tun->dev))
-		netif_tx_wake_all_queues(tun->dev);
+	if (netif_running(tun->dev)) {
+		for (int i = 0; i < tun->numqueues; i++) {
+			struct tun_file *i_tfile;
+
+			i_tfile = rtnl_dereference(tun->tfiles[i]);
+			spin_lock_bh(&i_tfile->tx_ring.consumer_lock);
+			spin_lock(&i_tfile->tx_ring.producer_lock);
+			netif_wake_subqueue(tun->dev, i_tfile->queue_index);
+			i_tfile->cons_cnt = 0;
+			spin_unlock(&i_tfile->tx_ring.producer_lock);
+			spin_unlock_bh(&i_tfile->tx_ring.consumer_lock);
+		}
+	}
 
 	strscpy(ifr->ifr_name, tun->dev->name);
 	return 0;
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


