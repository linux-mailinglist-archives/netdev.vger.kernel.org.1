Return-Path: <netdev+bounces-304093-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YEq8EY08RmoLMgsAu9opvQ
	(envelope-from <netdev+bounces-304093-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:25:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2976F5DB7
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:25:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=PSVV+m6I;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304093-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304093-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 544683078B60
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3243A47CC8E;
	Thu,  2 Jul 2026 10:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF530F7EA
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:11:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782987081; cv=none; b=iHqQHHQVqjTnj3eMrvtfICoew5frwjcZ4snUT+JAJM2/1ppVzSP6yyI2x/zneSmo1cy8buxDtzOqBJ1tI5VLgNm3bNy8fneP6s3cMRO1fHpiAl4UgW/LFyRyFJoM7kotT+BI6GZ5cggaT02cY7soXgeOv2GtPaKQ4CP86LGDCEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782987081; c=relaxed/simple;
	bh=rm+ZYKaQ3gj/Bdb3jYZ5Gr5Oqj0jDzO8oiPzHd7Um8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pe0Fw4S4JYy23r83NhR9qx8q8deQ8L7D9MGDN/Pzn5Flg8omaz7V0XI/ikuOfnOvAJ/wuHN77dwq+l01ZyEG1eaKSC2lOOHoZj7jbMH1C/XYxmHPt++UDH0TmpXFdpwdb1mUuyxijP+MA/FILl5p0AwK6AAIN25uzIBiwlSPJ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PSVV+m6I; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782987078;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XrZNxex3nITm4dFXovN1ZBHhXp+aPjsJQAiwCXDZ+X8=;
	b=PSVV+m6IZBKT62UBc0R/ZbRyGbqyD/VuZOthTsJXqwcthQCi7ttK1kcwveReKt6ZLVVCW1
	4fXK8wcfMf1aj1xrK89wmwbretQf9jT7jQiySk6rNQGQFdZ1A0uPwO9JbKaXiECjH3eNS/
	i+Q8RB3GA3irNLUl48v1A15zNn+wxgE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-348-8wPaUucOPem2ImngSXCcuQ-1; Thu,
 02 Jul 2026 06:11:15 -0400
X-MC-Unique: 8wPaUucOPem2ImngSXCcuQ-1
X-Mimecast-MFC-AGG-ID: 8wPaUucOPem2ImngSXCcuQ_1782987074
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7902C1944F08;
	Thu,  2 Jul 2026 10:11:13 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B7E5194510E;
	Thu,  2 Jul 2026 10:11:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: jk@codeconstruct.com.au
Cc: matt@codeconstruct.com.au,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next 10/12] net: mctp: usblib: Add initial kunit tests
Date: Thu,  2 Jul 2026 12:10:49 +0200
Message-ID: <20260702101049.139262-1-pabeni@redhat.com>
In-Reply-To: <20260630-dev-mctp-usb-1-1-v1-10-86a311fc67b7@codeconstruct.com.au>
References: <20260630-dev-mctp-usb-1-1-v1-10-86a311fc67b7@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304093-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS(0.00)[m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:gregkh@linuxfoundation.org,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB2976F5DB7

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: mctp: usblib: Add initial kunit tests

This commit introduces an initial set of kunit tests covering the
mctp-usblib receive path, exercising packet extraction from incoming
USB transfer data.

> diff --git a/drivers/net/mctp/mctp-usblib-test.c b/drivers/net/mctp/mctp-usblib-test.c
> new file mode 100644
> index 000000000000..ac837cbb4436
> --- /dev/null
> +++ b/drivers/net/mctp/mctp-usblib-test.c
> @@ -0,0 +1,330 @@

[ ... ]

> +static struct mctp_usblib_test_dev *mctp_usblib_test_create_dev(void)
> +{
> +	struct mctp_usblib_test_dev *dev;
> +	struct net_device *ndev;
> +	int rc;
> +
> +	ndev = alloc_netdev(sizeof(*dev), "mctptest%d", NET_NAME_ENUM,
> +			    mctp_usblib_dev_setup);
> +	if (!ndev)
> +		return NULL;
> +
> +	dev = netdev_priv(ndev);
> +	dev->ndev = ndev;
> +	skb_queue_head_init(&dev->rx_pkts);
> +
> +	rc = register_netdev(ndev);
> +	if (rc) {
> +		free_netdev(ndev);
> +		return NULL;
> +	}
> +
> +	rcu_read_lock();
> +	dev->mdev = __mctp_dev_get(ndev);
> +	dev->mdev->net = mctp_default_net(dev_net(ndev));
> +	rcu_read_unlock();

[Low]
Can __mctp_dev_get() return NULL here?  Looking at net/mctp/device.c:

    struct mctp_dev *__mctp_dev_get(const struct net_device *dev)
    {
        struct mctp_dev *mdev = rcu_dereference(dev->mctp_ptr);

        if (mdev)
            if (!refcount_inc_not_zero(&mdev->refs))
                return NULL;
        return mdev;
    }

If mctp_add_dev() fails inside the NETDEV_REGISTER notifier path, mctp_ptr
will not be installed and __mctp_dev_get() returns NULL, making the
subsequent dev->mdev->net = ... a NULL dereference in the test kthread.

> +
> +	rtnl_lock();
> +	dev_open(ndev, NULL);
> +	rtnl_unlock();

[Low]
Is it intentional to ignore the return value of dev_open() here?  If
dev_open() fails the netdev is registered but never brought up, and the
test then proceeds against an inconsistently-initialized device.

> +
> +	return dev;
> +}
> +
> +static int mctp_usblib_test_dst_output(struct mctp_dst *dst,
> +				       struct sk_buff *skb)
> +{
> +	struct mctp_usblib_test_dev *dev = netdev_priv(skb->dev);
> +
> +	skb_queue_tail(&dev->rx_pkts, skb);
> +
> +	return 0;
> +}
> +
> +static void mctp_usblib_test_init(struct kunit *test,
> +				  struct mctp_usblib_test_ctx *ctx)
> +{
> +	struct mctp_route *rt = &ctx->rt;
> +
> +	ctx->dev = mctp_usblib_test_create_dev();
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->dev);
> +
> +	memset(rt, 0, sizeof(*rt));
> +	rt->min = local_eid;
> +	rt->max = local_eid;
> +	rt->dst_type = MCTP_ROUTE_DIRECT;
> +	rt->type = RTN_LOCAL;
> +	rt->dev = ctx->dev->mdev;
> +	rt->output = mctp_usblib_test_dst_output;
> +
> +	list_add_rcu(&ctx->rt.list, &init_net.mctp.routes);
> +}

[High]
What happens to ctx.rt on a KUNIT_ASSERT_* failure later in the test?

The ctx variable is a stack local in mctp_usblib_test_rx_single() and
mctp_usblib_test_rx_pkt_span(), and mctp_usblib_test_init() inserts
&ctx->rt.list into the global RCU-protected list init_net.mctp.routes:

    list_add_rcu(&ctx->rt.list, &init_net.mctp.routes);

KUNIT_ASSERT_* macros invoke __kunit_abort() which calls
kunit_try_catch_throw() and ultimately kthread_exit(0), so control never
returns to the test function:

    lib/kunit/test.c: __kunit_abort()
      -> kunit_try_catch_throw()
        -> kthread_exit(0)

When the test kthread exits, its stack is gone, leaving a list_head in
init_net.mctp.routes that points at freed/reused stack memory.

The next RCU traversal of init_net.mctp.routes (subsequent mctp test,
mctp routing code, another kunit run) would then dereference that
dangling pointer.

The same abort path also bypasses unregister_netdev() and the
mctp_dev_put() done by mctp_usblib_test_fini().

Would using kunit_add_action() / kunit_add_action_or_reset() (or suite
.init/.exit hooks together with kunit_kmalloc()) ensure list_del_rcu(),
synchronize_rcu() and the netdev teardown always run, regardless of
assertion outcome?

> +
[ ... ]

> +static void mctp_usblib_test_rx_single(struct kunit *test)
> +{
> +	struct mctp_usblib_test_dev *dev;
> +	struct mctp_usblib_test_ctx ctx;
> +	struct mctp_usblib_rx rx;
> +	struct sk_buff *skb;
> +	size_t len;
> +	void *buf;
> +	int rc;
> +
> +	mctp_usblib_test_init(test, &ctx);
> +	dev = ctx.dev;
> +
> +	mctp_usblib_rx_init(&rx, true);
> +
> +	rc = mctp_usblib_rx_prepare(dev->ndev, &rx, &buf, &len, GFP_KERNEL);
> +	KUNIT_ASSERT_EQ(test, rc, 0);
> +
> +	mctp_usblib_test_init_pkt(buf, 8, 8);
> +
> +	rc = mctp_usblib_rx_complete(dev->ndev, &rx, 8);
> +	KUNIT_ASSERT_EQ(test, rc, 0);
> +
> +	skb = __skb_dequeue(&dev->rx_pkts);
> +	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, skb);
> +	KUNIT_EXPECT_EQ(test, skb->len, 4);
> +	kfree_skb(skb);
> +
> +	mctp_usblib_rx_fini(&rx);
> +	mctp_usblib_test_fini(test, &ctx);
> +}
> +
[ ... ]

> +static void mctp_usblib_test_rx_pkt_span(struct kunit *test)
> +{
> +	const struct mctp_usblib_test_pkt_span *pkt_span = test->param_value;
> +	size_t len, xfer_len, off, xfer_off;
> +	struct mctp_usblib_test_dev *dev;
> +	struct mctp_usblib_test_ctx ctx;
> +	struct mctp_usblib_rx rx;
> +	unsigned int i;
> +	u8 *pktbuf;
> +	void *buf;
> +	int rc;
> +
> +	mctp_usblib_test_pkt_span_validate(test, pkt_span, &len);
> +	pktbuf = kmalloc_array(1, len, GFP_KERNEL);
> +
> +	/* lay out packets */
> +	for (off = 0, i = 0; i < pkt_span->n_pkts; i++) {
> +		len = pkt_span->pkts[i];
> +		mctp_usblib_test_init_pkt(pktbuf + off, len, len);
> +		off += len;
> +	}

[Low]
Is the kmalloc_array() return value missing a NULL check?  pktbuf is
dereferenced immediately via mctp_usblib_test_init_pkt(pktbuf + off, ...),
so an allocation failure (including under kunit fault injection) becomes
a NULL deref.  Would kunit_kmalloc_array() or an explicit
KUNIT_ASSERT_NOT_NULL(test, pktbuf) be more appropriate here?

> +
[ ... ]

> +	/* check received packets */
> +	KUNIT_EXPECT_EQ(test, dev->rx_pkts.qlen, pkt_span->n_pkts);
> +	for (i = 0; ; i++) {
> +		struct sk_buff *skb = __skb_dequeue(&dev->rx_pkts);
> +
> +		if (!skb)
> +			break;
> +
> +		if (i <= pkt_span->n_pkts)
> +			KUNIT_EXPECT_EQ(test, skb->len, pkt_span->pkts[i] - 4);
> +
> +		kfree_skb(skb);
> +	}

[Low]
Should this comparison be i < pkt_span->n_pkts rather than
i <= pkt_span->n_pkts?

With <=, when i == n_pkts the test reads pkts[n_pkts], which is a
zero-initialized tail slot of pkts[6]; the expected length then
underflows to (size_t)0 - 4 and produces a confusing diagnostic instead
of a clean failure if the queue ever holds more SKBs than expected.

> +
[ ... ]
-- 
This is an AI-generated review.


