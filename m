Return-Path: <netdev+bounces-304356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BK+lFOxNR2pPVwAAu9opvQ
	(envelope-from <netdev+bounces-304356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:51:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE09F6FED93
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 07:51:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=ImB3wbrP;
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304356-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304356-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F290F303323B
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 05:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5610388893;
	Fri,  3 Jul 2026 05:48:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58B370AFB;
	Fri,  3 Jul 2026 05:48:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783057708; cv=none; b=oJX1fNlq7+vq9iuI+zmL5olvrjLuTQf3qEiYhJn9WMsani/0CQOCWfXOT8dfbVwtgCvfrdDbJ1eA0FcNsrHghlAh5tX5fOcR5TxalV/cCYpDI6RQ5GkyRnp9QAmiZ5CwlNYvOIIEpsbUlvMNAW/g9Ph1Ue0fgmb3w74nOorjGOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783057708; c=relaxed/simple;
	bh=TwZTBAQgTjOS0ESdNKNh3XEYz6XD1IX1I+JeD5VRPOo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+eQQt3y45p58IybMG1556F9u34hwQcFkYBhXB/vWFQnZ0GeV9l4uaVJokgx8gK2oBF4X7epk0rlhrEsauV/PUM3gBvDHPeJV7U8GuqjYqolBsiYns4AFVY0Q01eYgiDjGRmD+fu1vD8VvWwxVueiH4tF3wUAu5ptFafB1ZPMmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ImB3wbrP; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1783057672;
	bh=2Y6q0pcXQ0GbTXsBMm3bOYhvy7L4LJz/70KxBbcmFk4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ImB3wbrPltEo560SmoyH0hHTnNKOjLckGRzLTFfK+N6zWeV705pAbW0yTlj8inPD1
	 ly2OyWz944TmGm/JHDF1T6KGXdu1dKXC3hWkTzCKzZUW/hkDW1ENbbdyygDDjZw1Bm
	 RHucgNiFIRB9Q3MOYvUAEoyxnX5lz/0V2q4M1Pr/1FmLRXZn/OGYYpbmvUi0z/Lo5z
	 7xZZDoGwuzLO5jMPAgiMcWcKOHF7zdKVk/MjYL9ccREx7kTLeAw2QVVi0WdFMsCwD+
	 ydkv1soz0PzztXOAQXd3yD4bC0nOhte9lTBY8Z6pxikat2RBe4BdxY4v6rqX1o6Bca
	 rI3V2SsJQYS5A==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id B596166295; Fri,  3 Jul 2026 13:47:52 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 03 Jul 2026 13:47:30 +0800
Subject: [PATCH net-next v2 10/12] net: mctp: usblib: Add initial kunit
 tests
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260703-dev-mctp-usb-1-1-v2-10-60367b861b33@codeconstruct.com.au>
References: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
In-Reply-To: <20260703-dev-mctp-usb-1-1-v2-0-60367b861b33@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304356-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:from_mime,codeconstruct.com.au:email,codeconstruct.com.au:mid,codeconstruct.com.au:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,usb.id:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE09F6FED93

Add some initial tests for the usblib receive path, where we're
extracting MCTP packets from incoming USB transfer data.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
v2:
 - account for KUNIT_ASSERT-based exits; do cleanup through kunit_action
   facilities.
 - fix off-by-one in packet count duing skb length checks, in case we
   ended up with more skbs than expected
 - perform route updates under rntl lock
---
 drivers/net/mctp/Kconfig            |   5 +
 drivers/net/mctp/mctp-usblib-test.c | 389 ++++++++++++++++++++++++++++++++++++
 drivers/net/mctp/mctp-usblib.c      |   4 +
 3 files changed, 398 insertions(+)

diff --git a/drivers/net/mctp/Kconfig b/drivers/net/mctp/Kconfig
index a564a792801d..c40ac9c665b7 100644
--- a/drivers/net/mctp/Kconfig
+++ b/drivers/net/mctp/Kconfig
@@ -57,6 +57,11 @@ config MCTP_TRANSPORT_USBLIB
 
 	  This will be automatically enabled by the transport driver.
 
+config MCTP_TRANSPORT_USBLIB_TEST
+        bool "MCTP usblib tests" if !KUNIT_ALL_TESTS
+        depends on MCTP_TRANSPORT_USBLIB=y && KUNIT=y
+        default KUNIT_ALL_TESTS
+
 config MCTP_TRANSPORT_USB
 	tristate "MCTP USB transport"
 	depends on USB
diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
new file mode 100644
index 000000000000..17aec83e59e3
--- /dev/null
+++ b/drivers/net/mctp/mctp-usblib-test.c
@@ -0,0 +1,389 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mctp-usblib-test.c - MCTP-over-USB (DMTF DSP0283) transport helper library,
+ * unit test definitions.
+ *
+ * Copyright (C) 2026 Code Construct Pty Ltd
+ */
+
+#include <uapi/linux/netdevice.h>
+#include <linux/netdevice.h>
+#include <kunit/test.h>
+#include <linux/if_arp.h>
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+#include <linux/usb/mctp-usb.h>
+
+struct mctp_usblib_test_dev {
+	struct net_device *ndev;
+	struct mctp_dev *mdev;
+	struct sk_buff_head rx_pkts;
+};
+
+struct mctp_usblib_test_ctx {
+	struct mctp_usblib_test_dev *dev;
+	struct mctp_route rt;
+};
+
+static netdev_tx_t mctp_usblib_dev_tx(struct sk_buff *skb,
+				      struct net_device *ndev)
+{
+	/* we don't track any TXed packets at present */
+	kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+static const struct net_device_ops mctp_test_netdev_ops = {
+	.ndo_start_xmit = mctp_usblib_dev_tx,
+};
+
+static const mctp_eid_t local_eid = 8;
+
+static void mctp_usblib_dev_setup(struct net_device *ndev)
+{
+	ndev->type = ARPHRD_MCTP;
+	ndev->mtu = 8192;
+	ndev->flags = IFF_NOARP;
+	ndev->netdev_ops = &mctp_test_netdev_ops;
+	ndev->needs_free_netdev = true;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
+}
+
+static void mctp_usblib_test_dev_action(void *data)
+{
+	struct mctp_usblib_test_dev *dev = data;
+
+	skb_queue_purge(&dev->rx_pkts);
+	if (dev->mdev)
+		mctp_dev_put(dev->mdev);
+	unregister_netdev(dev->ndev);
+}
+
+static struct mctp_usblib_test_dev *
+mctp_usblib_test_create_dev(struct kunit *test)
+{
+	struct mctp_usblib_test_dev *dev;
+	struct net_device *ndev;
+	int rc;
+
+	ndev = alloc_netdev(sizeof(*dev), "mctptest%d", NET_NAME_ENUM,
+			    mctp_usblib_dev_setup);
+	if (!ndev)
+		return NULL;
+
+	dev = netdev_priv(ndev);
+	dev->ndev = ndev;
+	skb_queue_head_init(&dev->rx_pkts);
+
+	rc = register_netdev(ndev);
+	if (rc) {
+		free_netdev(ndev);
+		return NULL;
+	}
+
+	rc = kunit_add_action_or_reset(test, mctp_usblib_test_dev_action, dev);
+	if (rc)
+		return NULL;
+
+	rcu_read_lock();
+	dev->mdev = __mctp_dev_get(ndev);
+	if (dev->mdev)
+		dev->mdev->net = mctp_default_net(dev_net(ndev));
+	rcu_read_unlock();
+
+	if (!dev->mdev)
+		return NULL;
+
+	rtnl_lock();
+	rc = dev_open(ndev, NULL);
+	rtnl_unlock();
+	if (rc)
+		return NULL;
+
+	return dev;
+}
+
+static int mctp_usblib_test_dst_output(struct mctp_dst *dst,
+				       struct sk_buff *skb)
+{
+	struct mctp_usblib_test_dev *dev = netdev_priv(skb->dev);
+
+	skb_queue_tail(&dev->rx_pkts, skb);
+
+	return 0;
+}
+
+static void mctp_usblib_test_fini_action(void *data)
+{
+	struct mctp_usblib_test_ctx *ctx = data;
+
+	/* The device will have been destroyed, so ->rt will be unlinked.
+	 * Just ensure that the refcount is as expected.
+	 */
+	KUNIT_ASSERT_TRUE(current->kunit_test,
+			  refcount_dec_and_test(&ctx->rt.refs));
+
+	kfree(ctx);
+}
+
+static struct mctp_usblib_test_ctx *mctp_usblib_test_init(struct kunit *test)
+{
+	struct mctp_usblib_test_ctx *ctx;
+	struct mctp_route *rt;
+	int rc;
+
+	ctx = kzalloc_obj(*ctx);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	INIT_LIST_HEAD(&ctx->rt.list);
+
+	rc = kunit_add_action_or_reset(test, mctp_usblib_test_fini_action, ctx);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	ctx->dev = mctp_usblib_test_create_dev(test);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->dev);
+
+	rt = &ctx->rt;
+	refcount_set(&rt->refs, 1);
+
+	rt->min = local_eid;
+	rt->max = local_eid;
+	rt->dst_type = MCTP_ROUTE_DIRECT;
+	rt->type = RTN_LOCAL;
+	rt->dev = ctx->dev->mdev;
+	rt->output = mctp_usblib_test_dst_output;
+
+	rtnl_lock();
+	list_add_rcu(&ctx->rt.list, &init_net.mctp.routes);
+	refcount_inc(&rt->refs);
+	rtnl_unlock();
+
+	return ctx;
+}
+
+/* Init a MCTP-over-USB packet within a buffer. @len is the length of the
+ * buffer to write, @payload_len is the reported size of the MCTP-over-USB
+ * packet.
+ */
+static void mctp_usblib_test_init_pkt(void *data, size_t len,
+				      size_t payload_len)
+{
+	struct {
+		struct mctp_usb_hdr usb;
+		struct mctp_hdr mctp;
+	} hdr;
+
+	hdr.usb.id = cpu_to_be16(MCTP_USB_DMTF_ID);
+	hdr.usb.len = cpu_to_be16(payload_len);
+	hdr.mctp.ver = 1;
+	hdr.mctp.dest = local_eid;
+	hdr.mctp.src = 0;
+	hdr.mctp.flags_seq_tag = 0;
+
+	memcpy(data, &hdr, min(len, sizeof(hdr)));
+	if (len > sizeof(hdr))
+		memset(data + sizeof(hdr), 0, len - sizeof(hdr));
+}
+
+static void action_rx_fini(void *data)
+{
+	struct mctp_usblib_rx *rx = data;
+
+	mctp_usblib_rx_fini(rx);
+	kfree(rx);
+}
+
+static struct mctp_usblib_rx *
+mctp_usblib_test_rx_init(struct kunit *test, bool span)
+{
+	struct mctp_usblib_rx *rx;
+	int rc;
+
+	rx = kzalloc_obj(*rx);
+	if (rx) {
+		rc = kunit_add_action_or_reset(test, action_rx_fini, rx);
+		KUNIT_ASSERT_EQ(test, rc, 0);
+	}
+	KUNIT_ASSERT_NOT_NULL(test, rx);
+	mctp_usblib_rx_init(rx, span);
+
+	return rx;
+}
+
+/* Single packet, starting on a transfer boundary, contained entirely within
+ * the transfer
+ */
+static void mctp_usblib_test_rx_single(struct kunit *test)
+{
+	struct mctp_usblib_test_dev *dev;
+	struct mctp_usblib_test_ctx *ctx;
+	struct mctp_usblib_rx *rx;
+	struct sk_buff *skb;
+	size_t len;
+	void *buf;
+	int rc;
+
+	ctx = mctp_usblib_test_init(test);
+	dev = ctx->dev;
+
+	rx = mctp_usblib_test_rx_init(test, true);
+
+	rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &len, GFP_KERNEL);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	mctp_usblib_test_init_pkt(buf, 8, 8);
+
+	rc = mctp_usblib_rx_complete(dev->ndev, rx, 8);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	skb = __skb_dequeue(&dev->rx_pkts);
+	KUNIT_EXPECT_NOT_NULL(test, skb);
+	if (skb)
+		KUNIT_EXPECT_EQ(test, skb->len, 4);
+	kfree_skb(skb);
+}
+
+struct mctp_usblib_test_pkt_span {
+	const char *name;
+	size_t n_pkts;
+	size_t pkts[6];
+	size_t n_xfers;
+	size_t xfers[6];
+};
+
+static void
+mctp_usblib_test_pkt_span_to_desc(const struct mctp_usblib_test_pkt_span *t,
+				  char *desc)
+{
+	strscpy(desc, t->name, KUNIT_PARAM_DESC_SIZE);
+}
+
+static void
+mctp_usblib_test_pkt_span_validate(struct kunit *test,
+				   const struct mctp_usblib_test_pkt_span *span,
+				   size_t *len)
+{
+	size_t pkt_len = 0, xfer_len = 0;
+	unsigned int i;
+
+	for (i = 0; i < span->n_pkts; i++) {
+		KUNIT_ASSERT_GE_MSG(test, span->pkts[i], 8,
+				    "pkt[%d] len too small (%zd) for %s",
+				    i, span->pkts[i], span->name);
+		pkt_len += span->pkts[i];
+	}
+
+	for (i = 0; i < span->n_xfers; i++)
+		xfer_len += span->xfers[i];
+
+	KUNIT_ASSERT_EQ_MSG(test, pkt_len, xfer_len,
+			    "invalid pkt_len (%zd) != xfer_len (%zd) for %s",
+			    pkt_len, xfer_len, span->name);
+
+	*len = pkt_len;
+}
+
+static void mctp_usblib_test_rx_pkt_span(struct kunit *test)
+{
+	const struct mctp_usblib_test_pkt_span *pkt_span = test->param_value;
+	size_t len, xfer_len, off, xfer_off;
+	struct mctp_usblib_test_dev *dev;
+	struct mctp_usblib_test_ctx *ctx;
+	struct mctp_usblib_rx *rx;
+	unsigned int i;
+	u8 *pktbuf;
+	void *buf;
+	int rc;
+
+	mctp_usblib_test_pkt_span_validate(test, pkt_span, &len);
+	pktbuf = kunit_kmalloc_array(test, 1, len, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, pktbuf);
+
+	/* lay out packets */
+	for (off = 0, i = 0; i < pkt_span->n_pkts; i++) {
+		len = pkt_span->pkts[i];
+		mctp_usblib_test_init_pkt(pktbuf + off, len, len);
+		off += len;
+	}
+
+	ctx = mctp_usblib_test_init(test);
+	dev = ctx->dev;
+
+	rx = mctp_usblib_test_rx_init(test, true);
+
+	/* feed transfers */
+	for (off = 0, xfer_off = 0, i = 0; i < pkt_span->n_xfers;) {
+		xfer_len = pkt_span->xfers[i] - xfer_off;
+		rc = mctp_usblib_rx_prepare(dev->ndev, rx, &buf, &len,
+					    GFP_KERNEL);
+		KUNIT_ASSERT_EQ(test, rc, 0);
+
+		len = min(len, xfer_len);
+		memcpy(buf, pktbuf + off, len);
+
+		if (len == xfer_len) {
+			/* whole/end xfer, proceed to next */
+			xfer_off = 0;
+			i++;
+		} else {
+			/* partial */
+			xfer_off += len;
+		}
+
+		rc = mctp_usblib_rx_complete(dev->ndev, rx, len);
+		KUNIT_ASSERT_EQ(test, rc, 0);
+		off += len;
+	}
+
+	/* check received packets */
+	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, pkt_span->n_pkts);
+	for (i = 0; ; i++) {
+		struct sk_buff *skb = __skb_dequeue(&dev->rx_pkts);
+
+		if (!skb)
+			break;
+
+		if (i < pkt_span->n_pkts)
+			KUNIT_EXPECT_EQ(test, skb->len, pkt_span->pkts[i] - 4);
+
+		kfree_skb(skb);
+	}
+}
+
+static const struct mctp_usblib_test_pkt_span mctp_usblib_test_pkt_spans[] = {
+	/* One packet completely within a transfer */
+	{ "1p1x-complete", 1, { 8 }, 1, { 8 } },
+	/* Two small packets combined within one transfer */
+	{ "2p1x-combined", 2, { 8, 8 }, 1, { 16 } },
+	/* A packet split over two transfers, at the MCTP payload */
+	{ "1p2x-split-payload", 1, { 16 }, 2, { 8, 8 } },
+	/* A packet split over two transfers, at the USB transport header */
+	{ "1p2x-split-usbhdr", 1, { 16 }, 2, { 2, 14 } },
+	/* A packet split over two transfers, at the MCTP header */
+	{ "1p2x-split-mctphdr", 1, { 16 }, 2, { 6, 10 } },
+	/* Single packet split over 3 transfers, middle entirely continuation */
+	{ "1p3x-split", 1, { 12 }, 3, { 4, 4, 4 } },
+	/* Max-sized single transfer */
+	{ "1p1x-large", 1, { 8191 }, 1, { 8191 } },
+	/* Two large packets, split at the worst-case for allocation, with a
+	 * single byte continuing the span
+	 */
+	{ "2p2x-large-split", 2, { 8190, 8190 }, 2, { 8191, 8189 } },
+};
+
+KUNIT_ARRAY_PARAM(mctp_usblib_test_rx_pkt_span, mctp_usblib_test_pkt_spans,
+		  mctp_usblib_test_pkt_span_to_desc);
+
+static struct kunit_case mctp_usblib_test_cases[] = {
+	KUNIT_CASE(mctp_usblib_test_rx_single),
+	KUNIT_CASE_PARAM(mctp_usblib_test_rx_pkt_span,
+			 mctp_usblib_test_rx_pkt_span_gen_params),
+	{}
+};
+
+static struct kunit_suite mctp_usblib_test_suite = {
+	.name = "mctp-usblib",
+	.test_cases = mctp_usblib_test_cases,
+};
+
+kunit_test_suite(mctp_usblib_test_suite);
diff --git a/drivers/net/mctp/mctp-usblib.c b/drivers/net/mctp/mctp-usblib.c
index d9d08c59028e..79245294fd21 100644
--- a/drivers/net/mctp/mctp-usblib.c
+++ b/drivers/net/mctp/mctp-usblib.c
@@ -583,3 +583,7 @@ EXPORT_SYMBOL_GPL(mctp_usblib_tx_cancel);
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Jeremy Kerr <jk@codeconstruct.com.au>");
 MODULE_DESCRIPTION("MCTP USB transport library");
+
+#if IS_ENABLED(CONFIG_MCTP_TRANSPORT_USBLIB_TEST)
+#include "mctp-usblib-test.c"
+#endif

-- 
2.47.3


