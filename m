Return-Path: <netdev+bounces-302315-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MsazIZ6XP2okUwkAu9opvQ
	(envelope-from <netdev+bounces-302315-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 11:27:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F6C6D18FD
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 11:27:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=seu.edu.cn header.s=default header.b=BlsYlC+f;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302315-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302315-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=seu.edu.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04268302AD0F
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 09:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB2E396597;
	Sat, 27 Jun 2026 09:27:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28582395AEA;
	Sat, 27 Jun 2026 09:27:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782552457; cv=none; b=QwZ/FoLX7xpxoZ1s2IWins/oiWnyax2k47tAhtCOYSk6gUlstUd7/xTo7u9T97KV5bjdE2loXReJ+oDbgOYTXBK0KyNHyOftHPv10xlWGTWZGixktMttv+1/uQMS8UbrAMbOEOrx9ZK/vI4ZpT9iJ1zA88pz1HiPcK/DUhYgWdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782552457; c=relaxed/simple;
	bh=l7XM2AVZdatBvllVHmZNwMMfq0/bhHAfuiI1wJjzYwU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KHUbLGSmEBIGJu6cjFyphnQwn1i2FNPyFUW5RmFym/6ia/0vDxpnfVMKaqnfl8Fz/MyjUi2nZhBOGUNJVd87NtEPdo8pKE7tRWh5vn7B+HMJnjmTun6LlnK6ycnOV3eEu9Jv16qojU26sogIWgaSslixpMKmWovjic0rDIZ0610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=BlsYlC+f; arc=none smtp.client-ip=45.254.49.197
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 43fdf9cda;
	Sat, 27 Jun 2026 17:22:21 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: sam@mendozajonas.com,
	fercerpav@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	runyu.xiao@seu.edu.cn,
	jianhao.xu@seu.edu.cn
Subject: [RFC PATCH net 2/2] net/ncsi: stop device work before freeing channels
Date: Sat, 27 Jun 2026 17:22:14 +0800
Message-Id: <20260627092214.373480-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260627092214.373480-1-runyu.xiao@seu.edu.cn>
References: <20260627092214.373480-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9f08631efc03a1kunmb5b491adc8bf0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGBhJVh1LHklOSU5NGhlCGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=BlsYlC+fHCYoZ1tZcP2y4DFmPJrCdM+aMkmRgSVUMZujPlVmqNo4T27qy5a35oVYDpatmBnedhS88UjE0yrbglmcptQtri9Ffkw8wMfKChIQ2cPmAd5J5cuKX789u5IHzb3uaGVmZQuNyfA6CZUTjsLYbb4JJtYA9lzRkWk5yZg=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=WvNRjtPj8ElX4II/Zb/SLufSf65ErdXS12z35MPn1is=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302315-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[mendozajonas.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:sam@mendozajonas.com,m:fercerpav@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:runyu.xiao@seu.edu.cn,m:jianhao.xu@seu.edu.cn,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[runyu.xiao@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,seu.edu.cn:dkim,seu.edu.cn:email,seu.edu.cn:mid,seu.edu.cn:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5F6C6D18FD

ncsi_unregister_dev() tears down packages and channels before it
disables the NCSI device work item. Current trees already stop the work
before freeing ndp itself, but a teardown window remains where a running
or already scheduled ncsi_dev_work() can still reach package/channel
readers after ncsi_remove_package() has freed the underlying objects.

One visible path is the configuration flow through ncsi_channel_is_tx(),
which walks package channels and ndp->channel_queue while choosing a
transmit channel. Channel queue entries are struct ncsi_channel objects
owned by the package channel lists, and ncsi_remove_channel() frees
those objects during package removal.

Disable the device work before package/channel teardown. Also clear any
remaining channel_queue links while the channel objects are still alive,
so no stale queue membership is carried into teardown.

This was found by our static analysis tool and then manually reviewed
against the current tree. CONFIG_PROVE_RCU_LIST was used as
target-matched triage evidence; the teardown change is based on the
source-level workqueue and channel lifetime review rather than on the
dynamic warning alone.

This is deliberately limited to the teardown ordering problem. It does
not change the normal package/channel RCU-list update model.

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 net/ncsi/ncsi-manage.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/ncsi/ncsi-manage.c b/net/ncsi/ncsi-manage.c
index 5316eadd8ce4..289974dff0c1 100644
--- a/net/ncsi/ncsi-manage.c
+++ b/net/ncsi/ncsi-manage.c
@@ -1956,10 +1956,18 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 {
 	struct ncsi_dev_priv *ndp = TO_NCSI_DEV_PRIV(nd);
 	struct ncsi_package *np, *tmp;
+	struct ncsi_channel *nc, *ntmp;
 	unsigned long flags;
 
 	dev_remove_pack(&ndp->ptype);
 
+	disable_work_sync(&ndp->work);
+
+	spin_lock_irqsave(&ndp->lock, flags);
+	list_for_each_entry_safe(nc, ntmp, &ndp->channel_queue, link)
+		list_del_init(&nc->link);
+	spin_unlock_irqrestore(&ndp->lock, flags);
+
 	list_for_each_entry_safe(np, tmp, &ndp->packages, node)
 		ncsi_remove_package(np);
 
@@ -1967,7 +1975,6 @@ void ncsi_unregister_dev(struct ncsi_dev *nd)
 	list_del_rcu(&ndp->node);
 	spin_unlock_irqrestore(&ncsi_dev_lock, flags);
 
-	disable_work_sync(&ndp->work);
 
 	kfree(ndp);
 }
-- 
2.34.1

