Return-Path: <netdev+bounces-93081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F93D8B9FA8
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 19:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FD71F229BA
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 17:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117D016FF3C;
	Thu,  2 May 2024 17:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sEM+XDKC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903C916F90F
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 17:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671570; cv=none; b=LesIxDJPvlNSVGYhPtHIdjvTL5Q5Qy2LmNR3+y6w0iiIgHPdpui8imT+1EjtfI926Ka1C9qE9SOnxg97OJAdNuwNtD3Ut1nSvHwiVlel/zvPWlnXocqGd65DWl7imtGiviF4HpwAOZ4VNe4RbgEIxRsbV5js8IxW9BoLDaSxq0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671570; c=relaxed/simple;
	bh=tSCiw2bVFh3HmMADVN/8tHrIhjAu4UC1zYl3xYwO6Dk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K+kwcXZk7MInWAJm7X1zZnPvHU+pLVz7U4HfEa6TONnLReXtFhXwRVq3paTF9sAUTJrPBbeBMDhd6uWXcu+PJsNvbSR56DijS76L37oHcUG9g8eqWvzzbt+cP3t5G0kQTrCCG9niM9uesCCEUXYkx3sRotDI7IqtomGxOsmm5ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sEM+XDKC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61be452c62bso69496977b3.2
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 10:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714671567; x=1715276367; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5BlJHbwrMkgujJtLWrYtCZPh1/wsaOHiWOT5tOj6rlk=;
        b=sEM+XDKC/t2eT+YftZHnYhPd0OrcKlDn6ef+ad7mRAtjE7VhqSC1F7WKofOb9nkw5c
         NmWJWTD2cYBfeEbOqBq8TPKktZ6h/G3Ip+QlukpYXmkjYGwbBV3OhH/S2ccCCGGNH7l8
         vpmm/YtFuIg2eKd8gZq6WmtAOnG67KUOVyJrCgC4qUGCkR8oJ8m1uYPr7ql+gNGaeMCr
         Xm2Mcv5MaIrfZogQYyrFaRlvfeZjAVem7TKPaDK4X2C0DmudXiPkm8Qvk16YDdDH61aK
         loHtP+8GX10oU8+numvG0SyxIdhoFhSCe36KPRkEiwYjoOkz2PcfGGp80d0i6hUPalEb
         t0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714671567; x=1715276367;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5BlJHbwrMkgujJtLWrYtCZPh1/wsaOHiWOT5tOj6rlk=;
        b=bj8vzrVWEmpRZkgrMUwj+bLtFIFIeuCfGaVl3E8xwZZhIwMTbDDCBnWFujs3IHcZL9
         z72SwHktqIaWy/5ftqcguJectbc06UnAup2jUTByTk3zWHB0F0Lq1zxfBf+Sw5kA+QUK
         0ADaw/wEYPJPy11JUTHE3Zx9IzmXHpo3cX86wSrdO02IGeD0xgt0LBMqrtBcQI6B0xgX
         jdyHxDoWptoFcE4wo1zKcPzCWxCb0053fTm0eN5gmj6EAGf/l7DJ7aqLsH0ODngh9JBH
         bwLzfhInQszJn5xCePUvB1CxJ6SmMMjN+rIxqdA3c1p7F2GLAmFrNzPmDoQL55MMbB7R
         AWzw==
X-Gm-Message-State: AOJu0YykaVoXQLKUaPUNrOYu/YILLr7zaxPkk4sW416F8NfKsn70HNXg
	7vza31kMDUupiS2JP5yvauB+En45h715Oi9WbWFgsM106HbCbXDxwwXDGXEqJ4Gz0x9415PP+G9
	NDHwzG4NPTg==
X-Google-Smtp-Source: AGHT+IHq6sMy/2iuNICb2jWaF1ntq0y1cr3yoFMA4rmYxg8jitsu3YlzH1z5cD6cGUSWk8Wo0Fy8NSEwurp1lw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:914f:0:b0:61b:e253:31ad with SMTP id
 i76-20020a81914f000000b0061be25331admr19031ywg.8.1714671567515; Thu, 02 May
 2024 10:39:27 -0700 (PDT)
Date: Thu,  2 May 2024 17:39:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240502173926.2010646-1-edumazet@google.com>
Subject: [PATCH net-next] net: no longer acquire RTNL in threaded_show()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

dev->threaded can be read locklessly, if we add
corresponding READ_ONCE()/WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h | 2 +-
 net/core/dev.c            | 4 ++--
 net/core/net-sysfs.c      | 8 ++++----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 41853424b41d7a95e896e2f62318c161468c2437..2814a15eed73bfe27be6dc490b2e030158f86ead 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -2370,8 +2370,8 @@ struct net_device {
 	struct sfp_bus		*sfp_bus;
 	struct lock_class_key	*qdisc_tx_busylock;
 	bool			proto_down;
+	bool			threaded;
 	unsigned		wol_enabled:1;
-	unsigned		threaded:1;
 
 	struct list_head	net_notifier_list;
 
diff --git a/net/core/dev.c b/net/core/dev.c
index e02d2363347e2e403ccb2a59d44d35cee9a1b367..d6b24749eb2e27ca87609e31b0434c6c09f0e8d8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -6531,7 +6531,7 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
 		}
 	}
 
-	dev->threaded = threaded;
+	WRITE_ONCE(dev->threaded, threaded);
 
 	/* Make sure kthread is created before THREADED bit
 	 * is set.
@@ -6622,7 +6622,7 @@ void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
 	 * threaded mode will not be enabled in napi_enable().
 	 */
 	if (dev->threaded && napi_kthread_create(napi))
-		dev->threaded = 0;
+		dev->threaded = false;
 	netif_napi_set_irq(napi, -1);
 }
 EXPORT_SYMBOL(netif_napi_add_weight);
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 1f7f09e567715f418bc163079d0dd19c51c3571c..4c27a360c2948e520b6cf06934553d82e250057d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -605,13 +605,13 @@ static ssize_t threaded_show(struct device *dev,
 	struct net_device *netdev = to_net_dev(dev);
 	ssize_t ret = -EINVAL;
 
-	if (!rtnl_trylock())
-		return restart_syscall();
+	rcu_read_lock();
 
 	if (dev_isalive(netdev))
-		ret = sysfs_emit(buf, fmt_dec, netdev->threaded);
+		ret = sysfs_emit(buf, fmt_dec, READ_ONCE(netdev->threaded));
+
+	rcu_read_unlock();
 
-	rtnl_unlock();
 	return ret;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


