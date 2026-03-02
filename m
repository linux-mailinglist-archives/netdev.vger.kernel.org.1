Return-Path: <netdev+bounces-262530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JezcG6oxpWli5gUAu9opvQ
	(envelope-from <netdev+bounces-262530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:43:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B54991D3859
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 07:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00B95300A630
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 06:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D04D2D3EF2;
	Mon,  2 Mar 2026 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMef/nYa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D60131E49
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 06:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772433831; cv=none; b=W59NMJth0bc59ZaSctDjV5jsjnroH9/EpFTXaW+blSwxaOlXUGR326nauOlpNYbMMo4yiDwMFXyXuFnSF3QdmhRPIhqfwqA80bSqQna/NMcs67kyvRBFHDx62sBNLsTe5DYq2eKjF/InFQObR+GLxF42RE4zmXNo8bn23xxNfHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772433831; c=relaxed/simple;
	bh=PKNSEVqwgpezkdcE7Jg366jjgNQJdfEBDD+dXkoYfgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VpPJ4f2JR+MJ/wMfpcufJOopFIrYQ1DLWG4urIAIhJCdevMTFZ9N4eARVVN/0HYoYrOAppM5l921jUhUx0LX61OOZWDS5/ILfrVZevC0rJDeLgV+OkcxvNM15X74ccqY7QoNdD1Ye9NFtqFafn0FH7WV4bvrpT6TXSjo3W6KJmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMef/nYa; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-82418b0178cso2289015b3a.1
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 22:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772433829; x=1773038629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aEMJ/SEK1uGPP1uyITOdW3C1N0iniu09gHnQF77+QCU=;
        b=LMef/nYa9WOuNFpYa9XV5VXBBlB3tdsqHJtKZA21NvwNHdEqIecDCmz1UmqvfJJFI4
         wyR7e2JWsqRLL6cNIN7oisxxJiQOGo6x4HNZxFKWaJAstor/TFFvgwXGOqz98Re+Wq9P
         TxdS6Bts+BvAAHNB9N1YrSv1+gfEuLt0MQvZo+Fl0AEYNT+VMudlAoKHhK/HIwxJChu1
         7cd60gAjSTk9oq/LdrhDCYXpVntJB77j7ml+Mev2vfYkvl9OIW1bAFl6K0ABkZnTstII
         cXtXuNvpVanRHzny9R0zYyvEDDK+P5L6y16ws2tZIwi+KfdwD0UoGkODNXLvDEis9V8m
         qvgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772433829; x=1773038629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEMJ/SEK1uGPP1uyITOdW3C1N0iniu09gHnQF77+QCU=;
        b=hasE3/7+ntdy9mX8kJBmyTaTZlfrQzQGo7EGvl7UpMg9bZQsa+yOQAdoZGu65Adfyd
         hUSq8dDnUYndHTbjrB5WJpwkCVO5qsu4JlAcSZtwR2/qcPPnIR7ZGOnhydSXQEhMX2IY
         lTBaEDxI/Cpnrgxuk5/T0e5sgwm69XXsHD98XXlYkUMf1WHmOOD8U/n/7oCK6Lz5NaWX
         Vpbz22MI5xxbZKTeH6wRzKJlAtKl5mrEz4I0EmQliQ0XZ9NvMHviFTY5Fhs4G6b4VMkt
         mA40Al6Qnsob+MI5FdfRbPB8d07H5WcAXD8AwnBkT5nkRLYVheDo854jzX/Ns23mYPL1
         hM+Q==
X-Gm-Message-State: AOJu0Yz87w0H9Mq5imUA3bi7AvySQieeMIPhdBJcsi/Bh1lwctPfElcr
	cGtPAdsh/+0xgkK7lOptAKM9FwqAtnfDzhFSJ2nOpmqTrMiYvchKSRp4
X-Gm-Gg: ATEYQzzw7iew21nAJ145E4cUYsd4uYXbnjVv5zJR7HGEI3asD5UWCYrDZYGZXhv1LRV
	/PqdQyX8C4lTUrG5t3EPjlO0gHHzztDX5RhvllczLHyxlP1NVMPyM4pm2KPNu8l9SPibYzKPscW
	5TTDO1GgBSXv97FtJOv75rUMJmzC6NNWSxwCg35Nf5hjOaKXHeLyF4ffRphhaiNVNE8h//h+jPe
	2DoeevdaR6zl/yrglTT8UUjGs/lu/bAIHNlMrlRH6ICqMXMlFxpjdljPSBN+BdZ3mU+e8tdtC6l
	V2yMELCweDDtMp0ghY/yEenTnienFNa4NgdsyRRkTAasEAgQvgN/zRNyE7mD31r3ShF+y/0FeQm
	4XQR9nkPtmhnoxULFm8vM/ZPPWQLvuKuqNSL1YP/RulYkIIivWqzofDzM16tICnF/B0jsOyhWKy
	vNHypLL2pQqfuW9SHRChCwBVeWkabDpF26L2QqKz1FCzn/rPllICcr/rOB6O0vtkIKUutj
X-Received: by 2002:a05:6a21:1186:b0:392:e5cb:da81 with SMTP id adf61e73a8af0-395c39f7bb6mr10443610637.3.1772433829349;
        Sun, 01 Mar 2026 22:43:49 -0800 (PST)
Received: from zeeshan-Standard-PC-Q35-ICH9-2009.. ([110.93.227.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82c531sm11015265a12.24.2026.03.01.22.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 22:43:48 -0800 (PST)
From: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
To: Sridhar Samudrala <sridhar.samudrala@intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Subject: [PATCH net-next v4] net: core: failover: enforce mandatory ops and clean up redundant checks
Date: Mon,  2 Mar 2026 11:43:17 +0500
Message-ID: <20260302064317.9964-1-zeeshanahmad022019@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,linaro.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-262530-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zeeshanahmad022019@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B54991D3859
X-Rspamd-Action: no action

The failover framework requires 'ops' to be functional. Currently,
failover_register() allows an instance to be registered with NULL
ops, which leads to inconsistent NULL checks and potential NULL
pointer dereferences in the slave registration paths.

Harden the entry point by requiring non-NULL ops in
failover_register(). This ensures the 'fops' pointer is guaranteed
to be valid for any successfully registered failover instance.
Consequently, remove the now redundant NULL checks for 'fops'
throughout the module to simplify the logic.

Signed-off-by: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
---
v4:
 - Harden failover_register() to forbid NULL ops as suggested by
   Jakub Kicinski.
 - Remove all redundant NULL checks for fops throughout the module.
 - Remove the Fixes tag and target net-next, as this is now categorized
   as a refactor/cleanup rather than a standalone bug fix.
v3:
 - Move the fops NULL check to the top of the function before any
   dereferences occur, as suggested by Dan Carpenter.
v2:
 - Wrap the dereference in an if(fops) block instead of an early return 
   based on feedback from Simon Horman.

 net/core/failover.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/core/failover.c b/net/core/failover.c
index 0eb2e0ec875b..11bb183c7a1b 100644
--- a/net/core/failover.c
+++ b/net/core/failover.c
@@ -59,7 +59,7 @@ static int failover_slave_register(struct net_device *slave_dev)
 	if (!failover_dev)
 		goto done;
 
-	if (fops && fops->slave_pre_register &&
+	if (fops->slave_pre_register &&
 	    fops->slave_pre_register(slave_dev, failover_dev))
 		goto done;
 
@@ -82,7 +82,7 @@ static int failover_slave_register(struct net_device *slave_dev)
 
 	slave_dev->priv_flags |= (IFF_FAILOVER_SLAVE | IFF_NO_ADDRCONF);
 
-	if (fops && fops->slave_register &&
+	if (fops->slave_register &&
 	    !fops->slave_register(slave_dev, failover_dev))
 		return NOTIFY_OK;
 
@@ -115,7 +115,7 @@ int failover_slave_unregister(struct net_device *slave_dev)
 	if (!failover_dev)
 		goto done;
 
-	if (fops && fops->slave_pre_unregister &&
+	if (fops->slave_pre_unregister &&
 	    fops->slave_pre_unregister(slave_dev, failover_dev))
 		goto done;
 
@@ -123,7 +123,7 @@ int failover_slave_unregister(struct net_device *slave_dev)
 	netdev_upper_dev_unlink(slave_dev, failover_dev);
 	slave_dev->priv_flags &= ~(IFF_FAILOVER_SLAVE | IFF_NO_ADDRCONF);
 
-	if (fops && fops->slave_unregister &&
+	if (fops->slave_unregister &&
 	    !fops->slave_unregister(slave_dev, failover_dev))
 		return NOTIFY_OK;
 
@@ -149,7 +149,7 @@ static int failover_slave_link_change(struct net_device *slave_dev)
 	if (!netif_running(failover_dev))
 		goto done;
 
-	if (fops && fops->slave_link_change &&
+	if (fops->slave_link_change &&
 	    !fops->slave_link_change(slave_dev, failover_dev))
 		return NOTIFY_OK;
 
@@ -174,7 +174,7 @@ static int failover_slave_name_change(struct net_device *slave_dev)
 	if (!netif_running(failover_dev))
 		goto done;
 
-	if (fops && fops->slave_name_change &&
+	if (fops->slave_name_change &&
 	    !fops->slave_name_change(slave_dev, failover_dev))
 		return NOTIFY_OK;
 
@@ -244,7 +244,7 @@ struct failover *failover_register(struct net_device *dev,
 {
 	struct failover *failover;
 
-	if (dev->type != ARPHRD_ETHER)
+	if (dev->type != ARPHRD_ETHER || !ops)
 		return ERR_PTR(-EINVAL);
 
 	failover = kzalloc_obj(*failover);
-- 
2.43.0


