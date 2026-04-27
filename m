Return-Path: <netdev+bounces-281280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHY4H6As72mb8wAAu9opvQ
	(envelope-from <netdev+bounces-281280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:30:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D49BE46FEFE
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 11:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C5A53007ADE
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 09:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F523B27EF;
	Mon, 27 Apr 2026 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rSWDtvu3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220CE3B19D9
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282198; cv=none; b=bVhYLxtjOpC1jWnnOMCsMF7yPK3xLeRozGXRTH0Qa4mQ8cD70ZCrx6vyEkwOF99gDJcsS0VjE2jmDjQ84NHOidn7KLcA/+rYNKlrlK1E3J7u8Bl0th5Q7m68cbbHwnkodi6C6ZqT3Bcrabaa+ZUP6sfIH6MNxUNVy35PMsf9dKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282198; c=relaxed/simple;
	bh=vxAPrA4h7sngX6vMYHOE4RLJnGkPRGJ+kDIsLhudF4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NmS8jUsT1SqhjLWMOHtYC81KHcuStBlWj91uwgZc1XBXg7OetD4pAxMtsMa9OQQC0MstMooAwvRS+otDAyfAsMrWl9DjMw8jQnVIWAN9gJ+yjnMyc6ot8vJ3mZDf5nFhAIwKvqb6I4J4alHzwatQL5B7d7irQobTXj9WCHyNYnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rSWDtvu3; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-2de831d2b20so102529eec.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 02:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777282196; x=1777886996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wJSiZFuPqpMMIdyaSn5sB5W/37bLoscNlqqFWkR6yQo=;
        b=rSWDtvu3twwJAzoSXm2D0lYJ8uKtrRnVgTeHfBhfxTt1GLhViKPM1gFfZ9y3tDXNqi
         c0lguDNT6YBnliuV8RRuwLKyoUFz+L2s3R+20Z/ms2ER2XESN6mUMv7KEE1oEx1NKrA3
         07Uu0BhvPiUoB1tilpCVD5+/Vv/8AG8rBuklrwmOQcFojOkrAlNta85QBM1VbDXgcqz9
         uuV/XckTHIBYVwFH4P4bvJJ93ikCr49YnfRxQCx+91GQ90hsDj0ZnJz29WLnl2o0Q0kz
         UPtYIp6uB6LJ8ECBMiMI+7OwY0xso4fhxPErrMBEQDpQMIGooEvsuf21bQYZA/GJbMok
         arBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282196; x=1777886996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJSiZFuPqpMMIdyaSn5sB5W/37bLoscNlqqFWkR6yQo=;
        b=XbArudpy9SEGA5kzLtx/8d3DWS3zS7zZ3yG/A0KyXEHcQdfKH+8aRVdtb6YU77LVLa
         nrznC4H+ai5bSI4Tz4qr/8WfQr3aNmlSgcS3/kfWiLFYJona1TY8qHnBG0je5DE9KmSP
         rjMfjFWvNKBvEkFWcNscBYdYIe6m6Mz2yNfhpYmHvdx+4dFy+YZw8HHyJYUVzEgJRpDq
         W9wf3xaii+Mi0mXxfxFTL7q8sRZKhHn/xbyyvOTtc2e7u220Ov5FDU358MrczUckcPKC
         ykr4i4mCPLskvtUQFIe0Ra3Pb8A97j53t68sYvnQH6E07NvnzvMlQnKDCZAp5crZ4y6b
         jx9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/639Y4KuK6Wm0WPVxV3kFUFRMxhwluIfaSJhJdHZ3I37Lq15gG5QLqaShcUTf6e9nmqFVABJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm9mA/jKpmGU4lPEUtAollWFEIWC+3GTT0YHK98jhZTTZB+mVc
	N0oaLrJKSFp6ZrmH/nRlFNPmmeUafcplo+7n6q6RcsNqCKzvYYM05opP
X-Gm-Gg: AeBDieuVP9APudLTAco2gA8PQsfrFWwZVYOx9al8Onpr4vLVq+eQnlZIPWRQoDj/ujz
	8+alxUgorLL1nvmJocojY3JxyyQJneU39pYnifsI4USYaeAplALAIaqY3pbYSGxoTXEoTVguYNv
	dyp73AnNTpaEUskQNo/O01aQ3D9kHrJU/5x1WTBfS/zv+2XJMU2WwKrRtaORVfc5cwglu4M3+dc
	vlKjjwWWlxp9ogLrv2UpNAZK6I5mITjn3u9UxPn/eQ1UQz/4iniEvPjYa/hG+52NK/5LDJ7enBW
	WBQxjXqmd9+7itK0fKZESqcgUQgn6rdiqdnLPsCPXN6eiwotUD8fu3jLxPL0xeYpAUbxZQp8f7a
	9Qu2ZzhcbGG7KqK7okwXAacFYwAaOz8CvuSHupv/DsyJTrEWI8bbxdtu1NU/dsNChOW1L9+6JE6
	TAZYp+JS2nYOmceQcJDUb90L4lEyM8TYbR
X-Received: by 2002:a05:7301:4186:b0:2de:cc07:e99 with SMTP id 5a478bee46e88-2e464dafc4cmr20887075eec.7.1777282196148;
        Mon, 27 Apr 2026 02:29:56 -0700 (PDT)
Received: from dev-ubuntu.. ([128.14.159.2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53ac84c38sm43671903eec.13.2026.04.27.02.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:29:55 -0700 (PDT)
From: faicker.mo@gmail.com
To: faicker.mo@gmail.com
Cc: horms@kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: net_failover: Fix the deadlock in slave register
Date: Mon, 27 Apr 2026 17:29:22 +0800
Message-Id: <20260427092923.93901-1-faicker.mo@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D49BE46FEFE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281280-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[faickermo@gmail.com,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: Faicker Mo <faicker.mo@gmail.com>

There is netdev_lock_ops() before the NETDEV_REGISTER notifier
in register_netdevice(), so use the non-locking functions
in net_failover_slave_register().

Call Trace:
 <TASK>
 __schedule+0x30d/0x7a0
 schedule+0x27/0x90
 schedule_preempt_disabled+0x15/0x30
 __mutex_lock.constprop.0+0x538/0x9e0
 __mutex_lock_slowpath+0x13/0x20
 mutex_lock+0x3b/0x50
 dev_set_mtu+0x40/0xe0
 net_failover_slave_register+0x24/0x280
 failover_slave_register+0x103/0x1b0
 failover_event+0x15e/0x210
 ? dropmon_net_event+0xac/0xe0
 notifier_call_chain+0x5e/0xe0
 raw_notifier_call_chain+0x16/0x30
 call_netdevice_notifiers_info+0x52/0xa0
 register_netdevice+0x5f4/0x7c0
 register_netdev+0x1e/0x40
 _mlx5e_probe+0xe2/0x370 [mlx5_core]
 mlx5e_probe+0x59/0x70 [mlx5_core]
 ? __pfx_mlx5e_probe+0x10/0x10 [mlx5_core]

Fixes: 4c975fd70002 ("net: hold instance lock during NETDEV_REGISTER/UP")
Signed-off-by: Faicker Mo <faicker.mo@gmail.com>
---
Changes since v1:
  - Fix the space chars (Simon)
  - Change the dev_close to netif_close (Simon)
  - Change the label err_dev_open to err_netif_open
---
 drivers/net/net_failover.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/net_failover.c b/drivers/net/net_failover.c
index d0361aaf25ef..3f7d31033bae 100644
--- a/drivers/net/net_failover.c
+++ b/drivers/net/net_failover.c
@@ -502,7 +502,7 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 
 	/* Align MTU of slave with failover dev */
 	orig_mtu = slave_dev->mtu;
-	err = dev_set_mtu(slave_dev, failover_dev->mtu);
+	err = netif_set_mtu(slave_dev, failover_dev->mtu);
 	if (err) {
 		netdev_err(failover_dev, "unable to change mtu of %s to %u register failed\n",
 			   slave_dev->name, failover_dev->mtu);
@@ -512,11 +512,11 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 	dev_hold(slave_dev);
 
 	if (netif_running(failover_dev)) {
-		err = dev_open(slave_dev, NULL);
+		err = netif_open(slave_dev, NULL);
 		if (err && (err != -EBUSY)) {
 			netdev_err(failover_dev, "Opening slave %s failed err:%d\n",
 				   slave_dev->name, err);
-			goto err_dev_open;
+			goto err_netif_open;
 		}
 	}
 
@@ -562,10 +562,10 @@ static int net_failover_slave_register(struct net_device *slave_dev,
 err_vlan_add:
 	dev_uc_unsync(slave_dev, failover_dev);
 	dev_mc_unsync(slave_dev, failover_dev);
-	dev_close(slave_dev);
-err_dev_open:
+	netif_close(slave_dev);
+err_netif_open:
 	dev_put(slave_dev);
-	dev_set_mtu(slave_dev, orig_mtu);
+	netif_set_mtu(slave_dev, orig_mtu);
 done:
 	return err;
 }
-- 
2.34.1


