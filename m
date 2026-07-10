Return-Path: <netdev+bounces-306479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eIOQKje6UGpV4AIAu9opvQ
	(envelope-from <netdev+bounces-306479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:24:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1439E739002
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 11:24:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=J611ZhH7;
	dmarc=pass (policy=none) header.from=secunet.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306479-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306479-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1562E30D26E7
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 09:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F423DC4DA;
	Fri, 10 Jul 2026 09:04:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD703D34A2
	for <netdev@vger.kernel.org>; Fri, 10 Jul 2026 09:04:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783674253; cv=none; b=dj2+Z0qRb4cw1i1d44hBCGiHtlGos+JWIkZ398xIsOd4jb0AOPqr5whwdyH0ZU9LvD0WJR2KXZsguyseh2DfExZ0acNNCnA3sT6kFTLILNyV5pH3PHtu1UhVMGMbmZXW0yR4KktOHI0cHU/UV+31Pua2f3E/TCcK6N1FK+FRCvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783674253; c=relaxed/simple;
	bh=+HbzBVvsY+w4tvQvFk5vECtInE0cLc7qzHEYoJzsY6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9wifvC4dK3Qps/mQdlrCYQJSbMqZ78i4eBvij5cjMS8Csg/lKVLuRL49P480pkcvzHx0w1M+zsNmW6r4TiLnm2O9XfuMcT98g7pDCVMDy1+AWgtUumg1paq3E6N1WGF7zG1XbVw8RHyGA/RB4TKybwI2qm4Y9MXGrD8ahBmvsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=J611ZhH7; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 3F127205E5;
	Fri, 10 Jul 2026 11:04:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7fTFZr_-iCyy; Fri, 10 Jul 2026 11:04:09 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id D1213207B0;
	Fri, 10 Jul 2026 11:04:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com D1213207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1783674248;
	bh=Jz1FwvmGOxetp4jp8qLe9rCPnfeqc1d5vn54v+a/sXQ=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=J611ZhH7tkGzlbPkW2H3LSn0Ezv96bYrzHhEx6xpBp9X8ZBCAJzUXxobqkvADctt5
	 z0HHvWhYVNNcxVNC4GG6sjv/arTha5mNros2xjsRFO8gDj4rOaqyFgJCoL7ID3BYu3
	 BQz6ZVmjdHOWe+xky65LpY4HPRBJGB3xxKxJxmrWIOa5wZSzhB79+yOo0n1Jm/4p6O
	 MHNmoulTLH1UCtBVQImaxqMll5h1TxhnESctZLumy0Vby4IOizZ9DhKLXMIVayvj9N
	 J7nmmcKOmC48LPQVRPB1yYQq3RuEQp+tocS3s+Ox9p7j42QD2QRuELiJ26fjLzXjAC
	 3UbeaYv8aVZRw==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 10 Jul
 2026 11:04:08 +0200
Received: (nullmailer pid 343860 invoked by uid 1000);
	Fri, 10 Jul 2026 09:03:52 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 09/10] xfrm6: clear dst.dev on error to avoid double netdev_put in xfrm6_fill_dst()
Date: Fri, 10 Jul 2026 11:03:22 +0200
Message-ID: <20260710090349.343389-10-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710090349.343389-1-steffen.klassert@secunet.com>
References: <20260710090349.343389-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-04.secunet.de (10.32.0.184) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306479-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:kuba@kernel.org,m:herbert@gondor.apana.org.au,m:steffen.klassert@secunet.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:from_mime,secunet.com:email,secunet.com:mid,secunet.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1439E739002

From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>

On the error path where in6_dev_get(dev) returns NULL, xfrm6_fill_dst()
releases the device reference with netdev_put() but leaves
xdst->u.dst.dev set. dst_destroy() later calls netdev_put(dst->dev)
again, so the same net_device reference is released twice, underflowing
its refcount (ref_tracker WARNING + "unregister_netdevice: waiting for
<dev> to become free").

Clear xdst->u.dst.dev after the netdev_put(), the same way the XFRM
device-offload paths xfrm_dev_state_add() and xfrm_dev_policy_add() in
net/xfrm/xfrm_device.c NULL ->dev when releasing the reference on error.

  ref_tracker: reference already released.
  ref_tracker: allocated in:
   xfrm6_fill_dst (net/ipv6/xfrm6_policy.c:86)
   ...
   udpv6_sendmsg (net/ipv6/udp.c:1696)
   ...
  ref_tracker: freed in:
   xfrm6_fill_dst (net/ipv6/xfrm6_policy.c:90)
   ...
  WARNING: lib/ref_tracker.c:322 at ref_tracker_free+0x58b/0x780
   dst_destroy (net/core/dst.c:115)
   rcu_core
   handle_softirqs
   ...

Fixes: 84c4a9dfbf43 ("xfrm6: release dev before returning error")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/ipv6/xfrm6_policy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 125ea9a5b8a0..3b749475f6ed 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -88,6 +88,7 @@ static int xfrm6_fill_dst(struct xfrm_dst *xdst, struct net_device *dev,
 	xdst->u.rt6.rt6i_idev = in6_dev_get(dev);
 	if (!xdst->u.rt6.rt6i_idev) {
 		netdev_put(dev, &xdst->u.dst.dev_tracker);
+		xdst->u.dst.dev = NULL;
 		return -ENODEV;
 	}
 
-- 
2.43.0


