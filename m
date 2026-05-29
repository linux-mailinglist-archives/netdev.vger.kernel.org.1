Return-Path: <netdev+bounces-293053-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDh7A+xYGWqtvggAu9opvQ
	(envelope-from <netdev+bounces-293053-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:14:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7C25FFC1C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 834803009574
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5074D3BB66C;
	Fri, 29 May 2026 09:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="2/Aauukv"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DB5318BB5
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780045898; cv=none; b=G15Ah2CYOirUlWOKhyCu3R1wTOLiG9ulNhbtBmt1uY3mcwUWPbpTp+gabAFoQcg3OzhqvS8mU2FS29pQjCQEapp3mkyjzvGcKjTyKdFbCZ6yNIibk/x8eRn9HdQn99RKT7FkKjiL8q+jLe1dGYb+Ga9mmWsT7carxAwbh9BpLjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780045898; c=relaxed/simple;
	bh=EJeg1mkxwIaUpczEydPRuCzGgAqPpAlZAhDi2w26uPY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qYGoiqz1CB6eoAgtrOyac/0o9L5Ygj0lst7IvDEbQEXTcyuxAfPJK2SLmBgetuxskiGhjA1ZYgJkyzdtWGOKf6NDcBoV4p72Ls++45BxJua1YBIQFvFagENIRGWkveMveixZzIOhOvt09qezug2Lm+WzZmB0eY84JO+vu+6MuMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=2/Aauukv; arc=none smtp.client-ip=113.46.200.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=c7Q5+eGGEH5fQf4B4xOR/p+Kx2FKJ+4bga7SrJXkwdc=;
	b=2/Aauukvhrv0v3IUXBdUJdjWEfZ7Pff+gZl6QphNLoYlXuzlVBo7hPcxAnk3U6FFQW0jR5uxX
	wU125Yeqc1G0DMfvAOLZmrQu+oTYYERSocBq9nJx4GFxS8fT4/iVwE88s37sn8+IP6flRMbXWGT
	wC3ghVTvuGNBS9cJGjohy0M=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gRcpk0730zKm4Q;
	Fri, 29 May 2026 17:03:42 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D3A54056A;
	Fri, 29 May 2026 17:11:31 +0800 (CST)
Received: from kwepemq200002.china.huawei.com (7.202.195.90) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 17:11:31 +0800
Received: from localhost.localdomain (10.50.85.175) by
 kwepemq200002.china.huawei.com (7.202.195.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 29 May 2026 17:11:30 +0800
From: Dong Chenchen <dongchenchen2@huawei.com>
To: <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <tpluszz77@gmail.com>
CC: <netdev@vger.kernel.org>, <zhangchangzhong@huawei.com>,
	<xuchunxiao3@huawei.com>, Dong Chenchen <dongchenchen2@huawei.com>
Subject: [PATCH net] xfrm: Fix dev use-after-free in xfrm async resumption
Date: Fri, 29 May 2026 17:21:11 +0800
Message-ID: <20260529092111.1089315-1-dongchenchen2@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200002.china.huawei.com (7.202.195.90)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-293053-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[secunet.com,gondor.apana.org.au,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dongchenchen2@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email,huawei.com:mid,huawei.com:dkim];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BD7C25FFC1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

xfrm async resumption hold skb->dev refcnt until after transport_finish.
However, xfrm_rcv_cb may modify skb->dev to tunnel dev without taking
device reference, such as vti_rcv_cb. The subsequent async resumption
will decrement the tunnel device's reference count, which lead to uaf
of tunnel dev and refcnt leak of orig dev as below:

unregister_netdevice: waiting for vti1 to become free. Usage count = -2

Release refcnt of the original dev after tunnel rcv modify skb->dev to
fix it.

Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
Reported-by: Xu Chunxiao <xuchunxiao3@huawei.com>
Signed-off-by: Dong Chenchen <dongchenchen2@huawei.com>
---
 net/xfrm/xfrm_input.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index f65291eba1f6..c979872b6006 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -467,6 +467,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 {
 	const struct xfrm_state_afinfo *afinfo;
 	struct net *net = dev_net(skb->dev);
+	struct net_device *dev = skb->dev;
 	int err;
 	__be32 seq;
 	__be32 seq_hi;
@@ -730,6 +731,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 	if (err)
 		goto drop;
 
+	if (async && skb->dev != dev) {
+		dev_put(dev);
+		async = 0;
+	}
 	nf_reset_ct(skb);
 
 	if (decaps) {
-- 
2.25.1


