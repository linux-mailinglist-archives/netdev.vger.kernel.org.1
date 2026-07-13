Return-Path: <netdev+bounces-307103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vSwbO5etVGpCpQMAu9opvQ
	(envelope-from <netdev+bounces-307103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:19:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB3D74937B
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 11:19:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=sSmh4Y7K;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307103-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307103-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 069EC3001199
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CDF3DE441;
	Mon, 13 Jul 2026 09:19:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CCC390204
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 09:19:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934353; cv=none; b=KCuOxv51bJT1Nb9dL0ZCaQqAwS4qPH6Fffj770fGZHHGhqmkrl0hO6UswFZepYqsg8weemYF7NVOaOkbkcQQCcWFwDASdEdPNSfCjlKJguEKSGwOGFxTPd9ZdAD+pPX+xJ5N6FPlBtQ7X+zPmvLpGGAjXSC1dbWv7G8TVPCYge8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934353; c=relaxed/simple;
	bh=MP/mraMYPzMCsg/a5Ny4sp39c4ZUBsePrVPYbxMVRQ8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c6gXOuvwaDaJahN9gMYUrLzwT/FUVv8oRNnk7GICz5JpW4316alDjKp3Af29VKxwW9JorqfXxOQutkzgTCbBW47R+MINHMINU+hfpFTqk55fvcLlnCA2gjG1Ch5ZFOxmWI3cgucNH8BfIPsYeAN0jaRKZeiW6EiHXECr0CBvD1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sSmh4Y7K; arc=none smtp.client-ip=95.215.58.173
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783934349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TfurWKfkQ/L/AF2s3gX9ZPsRLKGrIjeB4Q2OBHdEoYY=;
	b=sSmh4Y7KlODc31q/R4GP//R7098tdBA4zhKubhcKGSgahsYRp/CmH/eAFnu+bWTGl2IaN0
	GHM4dMHq2EwJ2S93kcAdinpQ9ZYm6QPA1zjpRX44VjGicthGQllnhHjMIqf6FakRrgakG3
	CkfvLDygRP5Gax4vAjVlg1kkR+/tnG4=
From: Chenguang Zhao <chenguang.zhao@linux.dev>
To: jiawenwu@trustnetic.com,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: chenguang.zhao@linux.dev,
	netdev@vger.kernel.org,
	Chenguang Zhao <zhaochenguang@kylinos.cn>
Subject: [PATCH net] net: txgbe: fix FDIR filter leak on remove
Date: Mon, 13 Jul 2026 17:19:11 +0800
Message-Id: <20260713091911.1614795-1-chenguang.zhao@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307103-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[chenguang.zhao@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jiawenwu@trustnetic.com,m:mengyuanlou@net-swift.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:chenguang.zhao@linux.dev,m:netdev@vger.kernel.org,m:zhaochenguang@kylinos.cn,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenguang.zhao@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DAB3D74937B

From: Chenguang Zhao <zhaochenguang@kylinos.cn>

Perfect FDIR filters can be added while the interface is down and are
kept on the software list for later restore. unregister_netdev() only
calls ndo_stop when the device is up, so txgbe_fdir_filter_exit() in
txgbe_close() is skipped in that case and the filters are leaked on
driver remove. Free the filter list from txgbe_remove() as well.

Fixes: 4bdb441105dc ("net: txgbe: support Flow Director perfect filters")
Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
---
Reproduction:
 1. Load the driver (interface remains down after probe).
 2. Enable ntuple filters: ethtool -K <dev> ntuple on
 3. Add a perfect FDIR rule while the interface is down:
   ethtool -N <dev> flow-type ...
 4. Keep the interface down (do not bring it up).
 5. Unload the driver (rmmod / PCI unbind).
   unregister_netdev() skips ndo_stop because the device is not IFF_UP,
   and without freeing the software filter list in remove, each rule
   leaks sizeof(struct txgbe_fdir_filter).

 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index 20c5a295c6c2..c277863baf67 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -945,6 +945,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	netdev = wx->netdev;
 	wx_disable_sriov(wx);
 	unregister_netdev(netdev);
+	txgbe_fdir_filter_exit(wx);
 
 	timer_shutdown_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
-- 
2.25.1


