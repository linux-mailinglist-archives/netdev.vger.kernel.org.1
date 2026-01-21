Return-Path: <netdev+bounces-251976-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MI0ZEJ4XcWmodQAAu9opvQ
	(envelope-from <netdev+bounces-251976-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:14:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EEF5B20F
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 19:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 198907E4C0D
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCE847A0B5;
	Wed, 21 Jan 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mls6MwKU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A23E47D93C
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011559; cv=none; b=Qw1naiQ4srMJz/ml3WuJgmEp+/b/zKiuvy3EfHz8AR2bEeNEAituHVQagE5GMpNS2iDHacZuvhFnYpTKXgebDoxcJ6tyQ8fH5kaYWZ67IlMXQjEbPQsh+BKizGwYcTcF5XdpK/N90KvGk7WO1J+QU/ZrwzdhooUm1j+be7QcU5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011559; c=relaxed/simple;
	bh=/6iZY9Yye6MXdthga5BbGRUGXEKzhpfXag8teVv4IEo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j3otNlxQxOcX0UinYU2LWHX+cH6qbEIi89DCFjZOCM4Nog4q9rJaf2Lx4ZhGliqlKqiJzhX/AxNOKjOk7kCnu78iUnx+6KQ4JaqUxoSKBVUxL8JneBCb1Y14v8XYIC+gJiVrl629rQZQGPlpziKq4hTkDjzs150i+YPd2f4H4oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mls6MwKU; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yyd.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c5311864d9so427988985a.2
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 08:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769011556; x=1769616356; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WtuKORY1B0vCI7NuyqlVQa8MtlF+7JUnpW++HJzEkYg=;
        b=mls6MwKUq3cSEGakjBsLLbk0z01OnTzszS0zd5Wl7AHY9Dn3c9ASWG22Tq6kLPtZdq
         XiYdd1BgSw8KbC0umDbAXPPnYp8LMx2Csn7cqtH0ji1S7xh/4+TxR0sum/ZKCsUhIKdP
         +JlSWyr9aEpcJ4c/QwqNfIkr1hD+7m3ypM6DAEAzbCYgRZxm+F0byIujiMxamuw5iWTp
         /d/ZX9LD0Y92ewwyMsjSALyvxWW028MTSnfUeQ+MzKm06MZ8Wlb5Bulrecx9hWhXyfro
         m2e90SXeEhcv6BAOBDAvBQLQ9tBwsP4WBcb1eDo+CAS3dfJDQ3+z28e8jbvFX8qxNs4z
         QsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769011556; x=1769616356;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WtuKORY1B0vCI7NuyqlVQa8MtlF+7JUnpW++HJzEkYg=;
        b=eYzxLm17FawTwnAbYXElnhPLhprHG6KXC4LmjtbsF7wEs3W82NgymTho28o//wF8x/
         BnbaKMRKBt5PjjdJHodNAGzz/xQ+p0dTc+WI6SrkZhcN5ay2uo20JVoVpaF8NotK2x/Q
         oVTQ7Q2v4Xp7crKkrbA9cLjVEW45cGuRDOF5N4wk2+xjfujJaU/BZ64MMw748uHpOd7C
         CcnZX/a8IHn8S4OwqhOSykyC0lUFl+lXEFWCno3g75w2v9wlfavu178RJ/I93eiDnvH9
         QEgxpM3rovd2WpVECCaSdqXdsnNGV8GLLhRxYpIY5EOwXs1+QhnEgCxkxh6idsG2UWa2
         cfLw==
X-Gm-Message-State: AOJu0YxEhC5OGANEJKhp3OA25kTESI7ideZtKv2IEeZ5cr6iA8tcq9cn
	po6M4dWSNO/0pk6piGHypwMOSGj9Yw9ZvdGFzLPGI8z5K9YWBhfUIPyKTfzPzwglFQN8pQ==
X-Received: from qkbbj36.prod.google.com ([2002:a05:620a:1924:b0:8b2:4d20:bb8d])
 (user=yyd job=prod-delivery.src-stubby-dispatcher) by 2002:a05:620a:29ca:b0:8a3:f8c2:5ee4
 with SMTP id af79cd13be357-8c6ccdc158emr731478285a.37.1769011556033; Wed, 21
 Jan 2026 08:05:56 -0800 (PST)
Date: Wed, 21 Jan 2026 16:04:57 +0000
In-Reply-To: <20260121160458.990785-1-yyd@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260121160458.990785-1-yyd@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260121160458.990785-2-yyd@google.com>
Subject: [PATCH net-next v2 1/2] net: extend ndo_get_tstamp for other
 timestamp types
From: Kevin Yang <yyd@google.com>
To: Willem de Bruijn <willemb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Joshua Washington <joshwash@google.com>, Gerhard Engleder <gerhard@engleder-embedded.com>, 
	Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, yyd@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-251976-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,lunn.ch,davemloft.net,kernel.org,redhat.com,engleder-embedded.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yyd@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 11EEF5B20F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Network device hardware timestamps (hwtstamps) and the system's
clock (ktime) often originate from different clock domains.
This makes it hard to directly calculate the duration between
a hardware-timestamped event and a system-time event by simple
subtraction.

This patch extends ndo_get_tstamp to allow a netdev to provide
a hwtstamp into the system's CLOCK_REALTIME domain. This allows a
driver to either perform a conversion by estimating or, if the
clocks are kept synchronized, return the original timestamp directly.
Other clock domains, e.g. CLOCK_MONOTONIC_RAW can also be added when
a use surfaces.

This is useful for features that need to measure the delay between
a packet's hardware arrival/departure and a later software event.
For example, the TCP stack can use this to measure precise
packet receive delays, which is a requirement for the upcoming
TCP Swift [1] congestion control algorithm.

[1] Kumar, Gautam, et al. "Swift: Delay is simple and effective
for congestion control in the datacenter." Proceedings of the
Annual conference of the ACM Special Interest Group on Data
Communication on the applications, technologies, architectures,
and protocols for computer communication. 2020.

Signed-off-by: Kevin Yang <yyd@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
 Documentation/networking/timestamping.rst  | 21 +++++++++++++++++++++
 drivers/net/ethernet/engleder/tsnep_main.c |  8 +++++---
 drivers/net/ethernet/intel/igc/igc_main.c  |  8 +++++---
 include/linux/netdevice.h                  | 21 ++++++++++++++-------
 4 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/Documentation/networking/timestamping.rst b/Documentation/networking/timestamping.rst
index 2162c4f2b28a6..05e3607b43551 100644
--- a/Documentation/networking/timestamping.rst
+++ b/Documentation/networking/timestamping.rst
@@ -671,6 +671,27 @@ Time stamps for outgoing packets are to be generated as follows:
   software time stamping and therefore could lead to unexpected deltas
   between time stamps.
 
+3.1.1 netdev_tstamp_type and ndo_get_tstamp
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The ``ndo_get_tstamp`` operation allows the stack to convert a hardware timestamp
+to a specific time domain or format. The ``type`` argument specifies the
+requested timestamp type:
+
+- ``NETDEV_TSTAMP_PHC``: The hardware timestamp in its PTP Hardware Clock
+  domain.
+- ``NETDEV_TSTAMP_CYCLE``: The hardware timestamp as a cycle counter.
+- ``NETDEV_TSTAMP_REALTIME``: The hardware timestamp converted to system time
+  (``CLOCK_REALTIME``).
+
+For ``NETDEV_TSTAMP_REALTIME``, the driver is responsible for converting the
+hardware timestamp to system time. In that case, ``ndo_get_tstamp`` does not
+provide an accuracy guarantee. A device might use a disciplined clock that is
+synchronized with ``CLOCK_REALTIME``. Or, the driver might estimate the system
+time. The accuracy primarily depends on the physical hardware and driver
+implementation.
+
+
 3.2 Special considerations for stacked PTP Hardware Clocks
 ----------------------------------------------------------
 
diff --git a/drivers/net/ethernet/engleder/tsnep_main.c b/drivers/net/ethernet/engleder/tsnep_main.c
index b118407c30e87..d1c0cbaba06e7 100644
--- a/drivers/net/ethernet/engleder/tsnep_main.c
+++ b/drivers/net/ethernet/engleder/tsnep_main.c
@@ -2275,15 +2275,17 @@ static int tsnep_netdev_set_features(struct net_device *netdev,
 
 static ktime_t tsnep_netdev_get_tstamp(struct net_device *netdev,
 				       const struct skb_shared_hwtstamps *hwtstamps,
-				       bool cycles)
+				       enum netdev_tstamp_type type)
 {
 	struct tsnep_rx_inline *rx_inline = hwtstamps->netdev_data;
 	u64 timestamp;
 
-	if (cycles)
+	if (type == NETDEV_TSTAMP_CYCLE)
 		timestamp = __le64_to_cpu(rx_inline->counter);
-	else
+	else if (type == NETDEV_TSTAMP_PHC)
 		timestamp = __le64_to_cpu(rx_inline->timestamp);
+	else
+		return 0;
 
 	return ns_to_ktime(timestamp);
 }
diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 7aafa60ba0c86..3bbb9098c6fc4 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -6947,7 +6947,7 @@ int igc_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
 
 static ktime_t igc_get_tstamp(struct net_device *dev,
 			      const struct skb_shared_hwtstamps *hwtstamps,
-			      bool cycles)
+			      enum netdev_tstamp_type type)
 {
 	struct igc_adapter *adapter = netdev_priv(dev);
 	struct igc_inline_rx_tstamps *tstamp;
@@ -6955,10 +6955,12 @@ static ktime_t igc_get_tstamp(struct net_device *dev,
 
 	tstamp = hwtstamps->netdev_data;
 
-	if (cycles)
+	if (type == NETDEV_TSTAMP_CYCLE)
 		timestamp = igc_ptp_rx_pktstamp(adapter, tstamp->timer1);
-	else
+	else if (type == NETDEV_TSTAMP_PHC)
 		timestamp = igc_ptp_rx_pktstamp(adapter, tstamp->timer0);
+	else
+		return 0;
 
 	return timestamp;
 }
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d99b0fbc1942a..bfbdeca150c03 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -1062,6 +1062,12 @@ struct netdev_net_notifier {
 	struct notifier_block *nb;
 };
 
+enum netdev_tstamp_type {
+	NETDEV_TSTAMP_PHC = 0,
+	NETDEV_TSTAMP_CYCLE,
+	NETDEV_TSTAMP_REALTIME,
+};
+
 /*
  * This structure defines the management hooks for network devices.
  * The following hooks can be defined; unless noted otherwise, they are
@@ -1406,11 +1412,10 @@ struct netdev_net_notifier {
  *     Get the forwarding path to reach the real device from the HW destination address
  * ktime_t (*ndo_get_tstamp)(struct net_device *dev,
  *			     const struct skb_shared_hwtstamps *hwtstamps,
- *			     bool cycles);
- *	Get hardware timestamp based on normal/adjustable time or free running
- *	cycle counter. This function is required if physical clock supports a
- *	free running cycle counter.
- *
+ *			     enum netdev_tstamp_type type);
+ *	Get hardware timestamp based on the type requested, or return 0 if the
+ *	requested type is not supported. This function is required if physical
+ *	clock supports a free running cycle counter.
  * int (*ndo_hwtstamp_get)(struct net_device *dev,
  *			   struct kernel_hwtstamp_config *kernel_config);
  *	Get the currently configured hardware timestamping parameters for the
@@ -1661,7 +1666,7 @@ struct net_device_ops {
                                                          struct net_device_path *path);
 	ktime_t			(*ndo_get_tstamp)(struct net_device *dev,
 						  const struct skb_shared_hwtstamps *hwtstamps,
-						  bool cycles);
+						  enum netdev_tstamp_type type);
 	int			(*ndo_hwtstamp_get)(struct net_device *dev,
 						    struct kernel_hwtstamp_config *kernel_config);
 	int			(*ndo_hwtstamp_set)(struct net_device *dev,
@@ -5236,9 +5241,11 @@ static inline ktime_t netdev_get_tstamp(struct net_device *dev,
 					bool cycles)
 {
 	const struct net_device_ops *ops = dev->netdev_ops;
+	enum netdev_tstamp_type type = cycles ? NETDEV_TSTAMP_CYCLE :
+						NETDEV_TSTAMP_PHC;
 
 	if (ops->ndo_get_tstamp)
-		return ops->ndo_get_tstamp(dev, hwtstamps, cycles);
+		return ops->ndo_get_tstamp(dev, hwtstamps, type);
 
 	return hwtstamps->hwtstamp;
 }
-- 
2.52.0.457.g6b5491de43-goog


