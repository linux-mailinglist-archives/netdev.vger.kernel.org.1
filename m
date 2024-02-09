Return-Path: <netdev+bounces-70637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17B384FDAF
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 21:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517D1B29875
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 20:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AF56AB7;
	Fri,  9 Feb 2024 20:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sdlQEguP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCA9125D5
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 20:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510907; cv=none; b=H/D6YrwJ9flrmpzoOV9A3dz61d6c0MwS9X0/MK55og+GXdjfFoRgV+3+WKcCbjWfiPwi7C6INADA9eEvfOSEdb1hejlAfpcX+WOrJGPGIE2/zz1TTEVSpQ6Bdh/+lJv/CgJk+cAJJG4gUmlOHO1wQy9U1vUQVg4YC90H9RmV4NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510907; c=relaxed/simple;
	bh=ILX2k7U/2+OHd5KhkBoijktwK+6BWz/8geRXDH/krYc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MfnnAzB0fYJ6LAOwrUBJx2OpfFdynGyu4QtnEtb9pdZ+MIHy3ar+kTTcCombXnt6efCv1p3eEd3/5vo1jBEIAPabv5TnGUQ+RRgLasvcANlX/IOwpu5zhPGR3QFE0GrK8pKle33+GO/T2+mpSGm73f0t57HTT3MoUnhcs8sVrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sdlQEguP; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-784066a6190so108180685a.0
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 12:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707510904; x=1708115704; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=feQpn6Q/lP4IBJxKRUbCmaXBBf3iTjYD3LJEdw5crMA=;
        b=sdlQEguP3wkg8WIvgD9yrW6KOMFIHIUzsNXjHrvnJkojaEziCO+lq2vpnSPXn8JOml
         cIDtdoW9o7S/vW19dkvdivDwefU/DCgkP2owPGkCc/e1kGukAWdVQ2DzY+gqBIdkbeYI
         J6Hw3piPtnbKP6KKt/l8mB3dA7vQvjIJZVbI9LpNpqnv+OgxVdpRoSFaAeuQqUiQt/6x
         Hw+/vZKnAg6ab/QlYXcboB0panxkg8vjmyStm+rYKCNAqkanmTHs+a9pS0zClOOxrrqQ
         gTH+0rk9DPK07+lER09c/qJRLpFDbrOtvzvJ+7woWlseb2eDMlR85spzjkgCDsEp5eoB
         A03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510904; x=1708115704;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=feQpn6Q/lP4IBJxKRUbCmaXBBf3iTjYD3LJEdw5crMA=;
        b=ZxSJBMdPgzkh183eiVswbwnO+dB2IcMpBiS1o2gzgEehNxE8Jpyg/DNqeTQwYPoJX0
         2O4vo5rRzDQlsSWtP4UFBNP0rYzZK+nGaF52k7IYANKeayTGM7EgECGdnGC0/fl2Uhv3
         SWHNDobL4Gvq29j5akLrTJ4qkkIU8X3acdxtfx6Ix1xioi86bdQytD1NxqiDU74idSDE
         ceqEY5lOeocn71TVCNboo5SUKaWDiYOMWaWXG0L1yd6PNs69v2bRPR1HMElWJgN2wrbi
         R0iGFhaJJpZMEGg6/vXLL3CBQ/rP693X/+JNsTtfuC+8xZMFjutuCkYEMtO52UVDWeQ2
         yoNA==
X-Gm-Message-State: AOJu0YyIkMu3cYPvxiLfyybx+fBtjOH30q6xjfYOY8nKeynDEtHhf2G/
	XIXzd3nGMeWcmynjRhpwGr3rZ+0kIq6MU0ZnPd2fF1ST+p+2ryNtO65XW1bq8Jam5Scq7EG3Osy
	9rqmWW3qpeQ==
X-Google-Smtp-Source: AGHT+IFz/nWHJZHX2Nz6KSa11aFnTPZxQmg+2cKDgFc6Pgqzlvsx1m9DzPfsBoPoK+Q6qPE41lju3yICrpLyuA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:620a:63c7:b0:785:ba2f:7fb7 with SMTP
 id pw7-20020a05620a63c700b00785ba2f7fb7mr507qkn.10.1707510904700; Fri, 09 Feb
 2024 12:35:04 -0800 (PST)
Date: Fri,  9 Feb 2024 20:34:21 +0000
In-Reply-To: <20240209203428.307351-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209203428.307351-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240209203428.307351-7-edumazet@google.com>
Subject: [PATCH v3 net-next 06/13] net-sysfs: use dev_addr_sem to remove races
 in address_show()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Using dev_base_lock is not preventing from reading garbage.

Use dev_addr_sem instead.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/netdevice.h |  1 +
 net/core/dev.c            |  2 +-
 net/core/net-sysfs.c      | 10 +++++++---
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 24fd24b0f2341f662b28ade45ed12a5e6d02852a..28569f195a449700b6403006f70257b8194b516a 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4031,6 +4031,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 			struct netlink_ext_ack *extack);
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 			     struct netlink_ext_ack *extack);
+extern struct rw_semaphore dev_addr_sem;
 int dev_get_mac_address(struct sockaddr *sa, struct net *net, char *dev_name);
 int dev_get_port_parent_id(struct net_device *dev,
 			   struct netdev_phys_item_id *ppid, bool recurse);
diff --git a/net/core/dev.c b/net/core/dev.c
index 7d9d43ce2cb779c922759224e2690e24acda77fd..0c158dd534f80c46e66c890628be9a876e85068a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -8951,7 +8951,7 @@ int dev_set_mac_address(struct net_device *dev, struct sockaddr *sa,
 }
 EXPORT_SYMBOL(dev_set_mac_address);
 
-static DECLARE_RWSEM(dev_addr_sem);
+DECLARE_RWSEM(dev_addr_sem);
 
 int dev_set_mac_address_user(struct net_device *dev, struct sockaddr *sa,
 			     struct netlink_ext_ack *extack)
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 678e4be690821c5cdb933f5e91af2247ebecb830..23ef2df549c3036a702f3be1dca1eda14ee5e76f 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -142,17 +142,21 @@ static ssize_t name_assign_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(name_assign_type);
 
-/* use same locking rules as GIFHWADDR ioctl's */
+/* use same locking rules as GIFHWADDR ioctl's (dev_get_mac_address()) */
 static ssize_t address_show(struct device *dev, struct device_attribute *attr,
 			    char *buf)
 {
 	struct net_device *ndev = to_net_dev(dev);
 	ssize_t ret = -EINVAL;
 
-	read_lock(&dev_base_lock);
+	down_read(&dev_addr_sem);
+
+	rcu_read_lock();
 	if (dev_isalive(ndev))
 		ret = sysfs_format_mac(buf, ndev->dev_addr, ndev->addr_len);
-	read_unlock(&dev_base_lock);
+	rcu_read_unlock();
+
+	up_read(&dev_addr_sem);
 	return ret;
 }
 static DEVICE_ATTR_RO(address);
-- 
2.43.0.687.g38aa6559b0-goog


