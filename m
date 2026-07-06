Return-Path: <netdev+bounces-304956-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5nsgFM+KS2q+VAEAu9opvQ
	(envelope-from <netdev+bounces-304956-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:00:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B39D70F951
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:00:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=163.com header.s=s110527 header.b=i26Y78cs;
	dmarc=pass (policy=none) header.from=163.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304956-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304956-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 588FE309C34D
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5AE41735E;
	Mon,  6 Jul 2026 10:03:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD2C2BEC43
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 10:03:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332209; cv=none; b=MnKYnXYhlRxQs/7p/UXsNaYFNih7BNz6fbzeyMK3o3UGq200Q1ykz+rmi/yT3bPc8aEZP5zCsdcOsoTLSjw5BI+2ndOOFbYu4vfcB4WqVhGlby5KyY41VLMMp/Ck0o8lTnuQYJ6zbWL+XNNNqnqVxO0MlPnYomAZTdq4/Zyfwjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332209; c=relaxed/simple;
	bh=SQrDTprm3umr+ce3Sgt9QuROrfdtOoxJvVvAbBurWOc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekZyN1J15psCac8IXGYDzr/F/GXY1V8rEu0tg8CHiqJmPkzC4NEE/TuvKvoTKy1/yPbO5JP2SoNSvmGhIGQkRPdNFlXC3HHhnbIHOSma5FWrtGc8USPx+NeJGoLpcBm1QxVHYd6lN63BDvruVsud/5HG27QGZX0YkGZZsMZVenM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=i26Y78cs; arc=none smtp.client-ip=220.197.31.3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=JZ
	bxPyhSxERyKahBZdc20f6bMMlZ7WgR+AHtNlbB1mw=; b=i26Y78csGwlea10dmU
	AxFeixO1QH69sdXyWGvnxQtkdgIdE+CGS3qGVMmYK5ngJHA3hHPOOKrEFRkvIgSi
	3oRr8NSPruYY5ZarNUHgQMcvN5iKi7c7fTgVM1tS0LltabnzN2N8E/+PBRX8Gk1g
	KWBfD1bcRh/Br83MbmGt8qdAI=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3b0E1fUtqQtSiHg--.27701S2;
	Mon, 06 Jul 2026 18:02:30 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kuniyu@google.com
Cc: mhal@rbox.co,
	bjorn@kernel.org,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: skbuff: use net_zcopy_get() instead of refcount_inc()
Date: Mon,  6 Jul 2026 18:02:29 +0800
Message-ID: <20260706100229.13812-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3b0E1fUtqQtSiHg--.27701S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy5ur4fCw1fXFyrXr47Jwb_yoWfWwc_Jr
	ykZr4kC3y8JFy7Cws0krW5Gryvk3y09a4ruFZ2vFy2q345X398G34kGFW29F1kCF48WrW5
	GFnIvrW8Aa4F9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbjjg3UUUUU==
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BbZqGpLfTYk0AAA3V
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[luyun_611@163.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304956-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:kuniyu@google.com,m:mhal@rbox.co,m:bjorn@kernel.org,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luyun_611@163.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[163.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B39D70F951

From: Yun Lu <luyun@kylinos.cn>

The net_zcopy_get() increments the uarg->refcnt, which is called both
in pskb_carve_inside_header() and pskb_carve_inside_nonlinear().
Also use net_zcopy_get() in pskb_expand_head for code consistency.

No functional change intended.

Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9cfa..bcf3b2c65fb9 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2326,7 +2326,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 		if (skb_orphan_frags(skb, gfp_mask))
 			goto nofrags;
 		if (skb_zcopy(skb))
-			refcount_inc(&skb_uarg(skb)->refcnt);
+			net_zcopy_get(skb_zcopy(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 
-- 
2.43.0


