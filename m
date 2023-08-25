Return-Path: <netdev+bounces-30694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3461788902
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3A8D1C21006
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A9CFC0A;
	Fri, 25 Aug 2023 13:50:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04CFBE5
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 13:50:11 +0000 (UTC)
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317C82681
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=apc6ddPsbN2O4xlXDk5ps3wbiKUIdfB7++U9foAmPPs=; b=Nq0UyqyD01XgkVH6Siv2xm+RUp
	eZXRoBkg1owYqItlGNVGgOEKIbGWyKLGr53g9UpmTb9Qi3KpuwxZdudVTQe2SmjAZ22gzBlDfaTEu
	tskv6kbztP8nZjfvxu33/XkNHJWIK9HBT9+b2bHAdyHWIg2w0mbLG8cUSXchshd84D4UWSdNEuyaT
	qkkgyMbZm5EJ57mVT2vyt91NH4JfxrvdpCbShN/XbyqdEW9du8t3oWIO0wbcMXypTu2AWBZYhzVGH
	I/L/QUxDYOp13DPEvsrlz+pHtvl6xrS+Wun5moSyzkuX8rg9+km2rP5LLfbYFiRTzmKbvlCeDi+Gt
	NuICWwyA==;
Received: from 226.206.1.85.dynamic.wline.res.cust.swisscom.ch ([85.1.206.226] helo=localhost)
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1qZXCF-000Eu8-K2; Fri, 25 Aug 2023 15:49:55 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	pabeni@redhat.com,
	kuba@kernel.org,
	gal@nvidia.com,
	martin.lau@linux.dev,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next 2/2] net: Make consumed action consistent in sch_handle_egress
Date: Fri, 25 Aug 2023 15:49:46 +0200
Message-Id: <20230825134946.31083-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20230825134946.31083-1-daniel@iogearbox.net>
References: <20230825134946.31083-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.8/27011/Fri Aug 25 09:40:47 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

While looking at TC_ACT_* handling, the TC_ACT_CONSUMED is only handled in
sch_handle_ingress but not sch_handle_egress. This was added via cd11b164073b
("net/tc: introduce TC_ACT_REINSERT.") and e5cf1baf92cb ("act_mirred: use
TC_ACT_REINSERT when possible") and later got renamed into TC_ACT_CONSUMED
via 720f22fed81b ("net: sched: refactor reinsert action").

The initial work was targeted for ovs back then and only needed on ingress,
and the mirred action module also restricts it to only that. However, given
it's an API contract it would still make sense to make this consistent to
sch_handle_ingress and handle it on egress side in the same way, that is,
setting return code to "success" and returning NULL back to the caller as
otherwise an action module sitting on egress returning TC_ACT_CONSUMED could
lead to an UAF when untreated.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 9f6ed6d97f89..ccff2b6ef958 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4062,6 +4062,8 @@ sch_handle_egress(struct sk_buff *skb, int *ret, struct net_device *dev)
 	case TC_ACT_QUEUED:
 	case TC_ACT_TRAP:
 		consume_skb(skb);
+		fallthrough;
+	case TC_ACT_CONSUMED:
 		*ret = NET_XMIT_SUCCESS;
 		return NULL;
 	}
-- 
2.34.1


