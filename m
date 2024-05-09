Return-Path: <netdev+bounces-94833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20AB88C0D2F
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D05D9282918
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D78514A0B8;
	Thu,  9 May 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j3V+3T4w"
X-Original-To: netdev@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35FA51D6A5;
	Thu,  9 May 2024 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715245887; cv=none; b=s3cfn3TMCHIDxy2RNbSylkDzHJrBtgBG0IeHxcclM8rcmN4j8guvEW1t8LMPw1eX9VWr3RbGmnbMjPWsJ9/k5g9xxFRu2rSgypg3I10Qr+z8zf7l7no482uIFu6/4NAel6ZT2t0T/ElB4ifWQa0ZmUQCw0pZNd34C8Fx8y/bIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715245887; c=relaxed/simple;
	bh=PhA2isl0xqvqqwLsz+Hq49gLXJdHdLhs9QtkmvjsCjI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=QTNjpXJHBQreyXjhdb1R35TtucE/Kw5bAizIoVa8Yv2ono0wpPOLlVKYxJ51wq2fcS+bYpViSFt+h8q3sbuuAN49CtXSurBg6W+sNhviCJMgS8L8jugCCfGo8VR86VY+iBS7VcqeieuY6ebmVKlpXTu3kFNSgOSIU8UqLE/sfUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j3V+3T4w; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 9BC172085C24; Thu,  9 May 2024 02:11:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9BC172085C24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1715245885;
	bh=OMMgT6984I7d/5ikV2+Qam6oJc08svn3gC0xGzvFYrk=;
	h=From:To:Cc:Subject:Date:From;
	b=j3V+3T4wpPWaAbVLE7UwJwpWCtJd6qf/YO83D0MhXTAH0JQMNd+RdjI7H5fnYNm8+
	 K59ePRjPuvZ4fN51yeTBwrEFKSF09Ws/VWqz26z1iyj0OAkYlux88dDGE6IxagOmKq
	 +hUMJwjiXuAudUIZv04TG0o+qS/a+Q8Wtu53RV6I=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Breno Leitao <leitao@debian.org>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [PATCH net-next v3] net: Add sysfs atttribute for max_mtu
Date: Thu,  9 May 2024 02:11:23 -0700
Message-Id: <1715245883-3467-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

For drivers like MANA, max_mtu value is populated with the value of
maximum MTU that the underlying hardware can support.
Exposing this attribute as sysfs param, would be helpful in debugging
and customization of config issues with such drivers.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 Changes in v3:
 * Removed the min_mtu sysfs attribute as it was not needed
 * Improved the commit message to explain the need for the changes
 * Seperated this patch from other mana attributes requirements.
---
 Documentation/ABI/testing/sysfs-class-net | 8 ++++++++
 net/core/net-sysfs.c                      | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-class-net b/Documentation/ABI/testing/sysfs-class-net
index ebf21beba846..5dcab8648283 100644
--- a/Documentation/ABI/testing/sysfs-class-net
+++ b/Documentation/ABI/testing/sysfs-class-net
@@ -352,3 +352,11 @@ Description:
 		0  threaded mode disabled for this dev
 		1  threaded mode enabled for this dev
 		== ==================================
+
+What:           /sys/class/net/<iface>/max_mtu
+Date:           April 2024
+KernelVersion:  6.10
+Contact:        netdev@vger.kernel.org
+Description:
+                Indicates the interface's maximum supported MTU value, in
+                bytes, and in decimal format.
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index e3d7a8cfa20b..381becdd73a8 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -114,6 +114,7 @@ NETDEVICE_SHOW_RO(addr_len, fmt_dec);
 NETDEVICE_SHOW_RO(ifindex, fmt_dec);
 NETDEVICE_SHOW_RO(type, fmt_dec);
 NETDEVICE_SHOW_RO(link_mode, fmt_dec);
+NETDEVICE_SHOW_RO(max_mtu, fmt_dec);
 
 static ssize_t iflink_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
@@ -660,6 +661,7 @@ static struct attribute *net_class_attrs[] __ro_after_init = {
 	&dev_attr_ifalias.attr,
 	&dev_attr_carrier.attr,
 	&dev_attr_mtu.attr,
+	&dev_attr_max_mtu.attr,
 	&dev_attr_flags.attr,
 	&dev_attr_tx_queue_len.attr,
 	&dev_attr_gro_flush_timeout.attr,
-- 
2.34.1


