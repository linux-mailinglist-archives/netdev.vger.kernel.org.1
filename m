Return-Path: <netdev+bounces-259416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBSoCLvRlmkZoQIAu9opvQ
	(envelope-from <netdev+bounces-259416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:02:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F72F15D2F2
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 10:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F56B300B55F
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 09:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DAB334C20;
	Thu, 19 Feb 2026 09:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Px1IMb43"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87A5333733
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 09:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771491766; cv=none; b=pKEazAxpuT5ExAQ2mzCbxAlNRK1ANpLHGXwfrGZTdJKkpqFs8q70cFT1h5pcfHPvJfGZ8UMz6TN5Ud+1SW+dOIMwyHdHtGUvTQZCZ1ICWl6kQ487+FOSNMJONy7gAud81swovCg0neVeBqFdponMBki0Ci/4yrkGkymhKzYwcg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771491766; c=relaxed/simple;
	bh=x4m5N0xkK1VAOmJGsckz4FS7UXmOUVgb2CRC1Z3Btxg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i+03zvRKhMkT4RBazdP9ABrqwjutUVm5qlrFbz7ZvAfvVvxrv6wGhB9ZrTBGiCh5l5s/jprdZMPTtomzQQKsJoPV7YHfDihDRzGQUmcEFY5INCbux/3Rbztm/u37QTclCFXBI3uHyTZ5tLykJi13cb++bT4mwEL+zi6yvYBw4yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Px1IMb43; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2a95de4b5cbso6198685ad.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 01:02:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771491765; x=1772096565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FdCAN6g0YtElyjxGqQjQ19PdmFtnzKPpjCD9MmgGuxw=;
        b=Px1IMb43ihaNmt7yoB3bw/myrUaiZ/7W6lLJfRhUZJsZCM3axOOpOz9v0pvaCKSxwM
         5JJP16wn5kKjiWL/O+Qjm7gcVj96jWJ55YPpPFyvNNubpZDW4kP/A4ex+TQDklcB9L02
         QKdogFsd+WM45ma0/FetPCQf7yl5/NUxn6riG2l4SaQvrMRg5QzFy3ZQohjxspbrGEk0
         vgavgJSREnr0ME2FHXynK70V4ybkwGavic15znb/sEgHBITpJqIrIF5OZRHV7JtHV50R
         TiqF0SBGwD/wqVBPAQSz57Tg4GaatWhZB2SjWPPl0zG3LaYILVKTWU0yVMg3WNF4Hw4U
         fVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771491765; x=1772096565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdCAN6g0YtElyjxGqQjQ19PdmFtnzKPpjCD9MmgGuxw=;
        b=umFY28ka2M2KLxwSbnArtaYj2BZj3WIh32PSoBLWV+rPcdyBqLkXUIs2/4YPQ/xs/1
         bQQQ4LPFDEqa4Ccpyfb1PI/9hBDE49yMAkvpKyDwt0+kmvFiXi4Hp17CqJwHQUjtdIKe
         /HXzoG6m8168ZJnS2iYxsPYPq50O3a/UbXFBuhDeLW+7FzUrVPEWqnq7qPNYlgz2oums
         2ofM+CyICwD6QZbaGHGbmUdvDqJ26LwSn81Q3smyum3En/mqrk3reDvg9R0D7cQcj6jc
         5aK/GBSVmVL0tO2hi2ph0M6a8XyNJD++QYH9WW15SUFVaOpklwQQMKRC/v+OXDSz66+j
         /cVw==
X-Gm-Message-State: AOJu0YyJM+b+SefFKlaZjhPNYUtk8Gj7341lYj4ApoW4/Pib6GQ774D5
	g6ZxKb/HIF+mX5ovyqcxBWB7/rb+QJlCNJRWd6r33JjN7h8XFv+8Wpg3
X-Gm-Gg: AZuq6aKXxRaQTGkHgtWXZ9F3AYwCIlRlTrwq4yv4dltQK4ybrkiUAw+QNdKZ6LzSo5N
	X4p8GI0ooFcHErHv8YWvD+JlfBV65+aMXoNaWrW5Q36IToCc3qoCNTY/4I1izdvexOe3hGqL2y4
	Dbgb5JO+IMAlYVuvuR8l65rz54+Hs6BrrT0p99aJ0l6OYWXnff4hFRwqql6FQROC/qvRxDsQAO4
	z0bxao/FDSNYyBHPp58Xs1d+Jgt5LnKouAzWmeJCnagRKApEV3ZMOXgg1VitQNyyopIYuA8jbZH
	EtRvN1dSW5bB1GAxXynbUF8iPZ+Sm6oIv7u1VV7ywo8wWFQS01bBEAUcEJBSximkh7YnMrvtw3o
	Y0UgkVaKqHSMGaNru5frxKfMemItcGD7Zi5z7AD9UmvI66+rDZ5UpgxOPA/1mBMFlbrJNUGwkTo
	aaZa72lzSBdSIdlGBK1+E6DW3PXX8h0lxqc6E0jlPAlLgBrYpEvg5IoTZY6typLpIGP470
X-Received: by 2002:a17:903:11ce:b0:2aa:d287:693d with SMTP id d9443c01a7336-2ab4cf94770mr209786915ad.20.1771491765191;
        Thu, 19 Feb 2026 01:02:45 -0800 (PST)
Received: from zeeshan-Standard-PC-Q35-ICH9-2009.. ([110.93.227.54])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a713675sm221090545ad.27.2026.02.19.01.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 01:02:44 -0800 (PST)
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
	Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
Subject: [PATCH net-next v1] net: core: fix logical inconsistency in failover_slave_register()
Date: Thu, 19 Feb 2026 14:02:16 +0500
Message-ID: <20260219090216.12884-1-zeeshanahmad022019@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-259416-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zeeshanahmad022019@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F72F15D2F2
X-Rspamd-Action: no action

Smatch warns that 'fops' is dereferenced at line 66 before being checked
for NULL at line 85.

The current code inconsistently assumes 'fops' might be NULL at lines 62
and 85, while dereferencing it without a check at line 66.

Move the NULL check to the beginning of the function immediately after
'fops' is initialized. This ensures safety for all subsequent
dereferences and allows the removal of redundant checks.

Signed-off-by: Zeeshan Ahmad <zeeshanahmad022019@gmail.com>
---
 net/core/failover.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/failover.c b/net/core/failover.c
index 2a140b3ea669..88e376be0255 100644
--- a/net/core/failover.c
+++ b/net/core/failover.c
@@ -56,10 +56,10 @@ static int failover_slave_register(struct net_device *slave_dev)
 	ASSERT_RTNL();
 
 	failover_dev = failover_get_bymac(slave_dev->perm_addr, &fops);
-	if (!failover_dev)
+	if (!failover_dev || !fops)
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
 
-- 
2.43.0


