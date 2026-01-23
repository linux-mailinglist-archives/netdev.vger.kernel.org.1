Return-Path: <netdev+bounces-252892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNRcMHGqc2nOxwAAu9opvQ
	(envelope-from <netdev+bounces-252892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:05:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 483B878C73
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 18:05:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F1B304EAA8
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B722BD015;
	Fri, 23 Jan 2026 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl/IiyNW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639CC290DBB
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 17:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769187891; cv=none; b=h9HS/76maJrVzrThGwn8/59Qk8bI01TrxoBe/C4usyDF7PNVwg+RFvzQ8j+pNl+U4JuSYXX/J+BKt7VShNd8fWBKLNjGMeazsbgNZq+EnO1LYOBgj2lXIJrJSfAtatUzYsa9cydJUZa4DOsGlYU607OYkPPnubEGhxgQybkoVns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769187891; c=relaxed/simple;
	bh=HNLPvS/ZYh4SfguEwz3h/S0QV+sR52qM/d2Ywn2mdo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiWcLzgQdaU1aZKN2/WmuyCZCDPErjCyHdCC4/lXbWPOEmf7BCv2z/bKl2fMHwkeIGlS6PNf/MauDBXrJxPWMUb4MLijrpIP/GOySiOrobzTIQsz2wAOlQj9YLELIowmZtx71OIIaLvgoomuc+F1ZXjZvyPQYP/df3hcqsR1dZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rl/IiyNW; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-385b6a15affso30609331fa.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 09:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769187887; x=1769792687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vT4D+hteMlMYNWrENg/st+OzFLnRNjAZ+lYZNNlBTlM=;
        b=Rl/IiyNWLhYFkzeob8YBCklS3S1B+kihvEgG8XVC61mzej7pZvSk2e428WNXkjL5ez
         BcKSERBWxMfoUu7uVZkG9MAgU7n/4Y2/EhevvRF8jiU+Iz9sKNtbdfob4NLXdxKLOv82
         k9jcubpgOdsnMh5hsVKE2O197O77i3qiHA8gnDyyCa3N+tmw1epphTgovy8Zh8UTuppp
         Cp90MUvvlh32pt4qvwtrTtcwTtfZa6W7EKLfUYmcY2W9aArRM7dBYE6smb6r8xSw4y7r
         WiGJBQEzeUC5BRNZKELV9zkMvxjNxlOi2T6MEIr4QSuF5Jn6KEEIsF/HskpC4pdWufMb
         ZIvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769187887; x=1769792687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vT4D+hteMlMYNWrENg/st+OzFLnRNjAZ+lYZNNlBTlM=;
        b=D2PbeN49N6pP0UAUb0Nl4+24d74g8jAb+jNJ6s9/aM35E7Cxz5+S0ALP9IlYkdn5sV
         cPyvRvQibrQKYsL31ogKDpx1/PHJxARFMiy0E60oWXbP8UAnsey+wEBKpICARGcDtiuJ
         gNpKFsd1APhyAJc0vsk7jSKxLpd/aylUZbH0oepwIYytViO/0ZbgKXb/t6x8AYfSV+cS
         fogKSxac2FfrzTvQ6FMlIfsbtNqpkmiLD/edbEDLCD2bExen3LXg9OMqqWyaJ3XjiwM6
         Bg4U82OJ38qkOIgRLAYSovUbEoes+zenhl+p1ygNT7QO7CnBAQZb1CJWq3PG9BXYrj76
         IpqA==
X-Gm-Message-State: AOJu0YymcgjK2jSY5/XsPGKrvPm7DwMrA531yKySTN9ZhHCYPnENlTth
	nUWoNseG2QcDzC+8fnBvOrxzVFao+ENpBYfEfOqxDzsI1nGids3JPAluSiXDxOsEJG8=
X-Gm-Gg: AZuq6aLYczRgKBVMW4owsoFPP8aU8o5P3ZYNeVJ1/CH6sTgrjHfadxykIFhggL7HzPC
	JE8DFYhWI0rf4ALB1Nkry/kD0/6YMrc5npXdWkCNA47lxsSuOLuAABygsZn1v8FMacUcjLWUmhr
	dQnXzTfZsFilW144o7/QVP6HcIYavSTXbyoRly0KnNp3/f+UioYoX7IQN27PoUGYbcrlO3ovmiU
	BuTF8rVCm+mR1f1sDJZVOhbIv3XQtxzMkD1L2u6vkqsLK7DOjB7mdL+Ev9Nd3zfYLqdKbVKH5k8
	qp+JMArAszLRCOm05VAqLPM0JNH/Psa3cDX29Q1lYD5He4eYV6/NT4/MNN2VLSk5bZrjI0l70I+
	xfU3rZaNHBBPBkocXY8mW1T2IiPPqGQ7l5wcgoawgAt3iIHXCy9rPqK3cT9P5nJAsm+m3ksg4Hn
	72vdAWCS6p8W8IhWql4L7gLkIUsUjghGIQsomyvv44dH1b+Q==
X-Received: by 2002:a05:6512:3d17:b0:59b:a9e5:68c8 with SMTP id 2adb3069b0e04-59dd7bd965amr2592889e87.5.1769187886785;
        Fri, 23 Jan 2026 09:04:46 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.23])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59de48e5fd3sm801772e87.33.2026.01.23.09.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 09:04:46 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Dmitry Skorodumov <skorodumov.dmitry@huawei.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH v2 net-next 2/3] ipvlan: Common code from v6/v4 validator_event
Date: Fri, 23 Jan 2026 20:03:55 +0300
Message-ID: <20260123170412.906280-3-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
References: <20260123170412.906280-1-skorodumov.dmitry@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_FROM(0.00)[bounces-252892-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,huawei.com,fomichev.me,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dskr99@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 483B878C73
X-Rspamd-Action: no action

Extract commond code for ipvlan_addr4_validator_event()/
ipvlan_addr6_validator_event() to own function.

Get rid of separate functions for xxx_validator_event()
and check whether we are called for ipv4 or ipv6 by
looking at "notifier_block *nblock" argument

Signed-off-by: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
---
v2:
  - Fixed warning about unused by specifying __maybe_unused
    for ipvlan_addr6_vtor_notifier_block (used only with CONFIG_IPV6)

 drivers/net/ipvlan/ipvlan_main.c | 110 +++++++++++++++----------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index cf8c1ea78f4b..d5b55876d340 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -878,6 +878,33 @@ static bool ipvlan_is_valid_dev(const struct net_device *dev)
 	return true;
 }
 
+static int ipvlan_addr_validator_event(struct net_device *dev,
+				       unsigned long event,
+				       struct netlink_ext_ack *extack,
+				       const void *iaddr,
+				       bool is_v6)
+{
+	struct ipvl_dev *ipvlan = netdev_priv(dev);
+	int ret = NOTIFY_OK;
+
+	if (!ipvlan_is_valid_dev(dev))
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case NETDEV_UP:
+		spin_lock_bh(&ipvlan->port->addrs_lock);
+		if (ipvlan_addr_busy(ipvlan->port, iaddr, is_v6)) {
+			NL_SET_ERR_MSG(extack,
+				       "Address already assigned to an ipvlan device");
+			ret = notifier_from_errno(-EADDRINUSE);
+		}
+		spin_unlock_bh(&ipvlan->port->addrs_lock);
+		break;
+	}
+
+	return ret;
+}
+
 #if IS_ENABLED(CONFIG_IPV6)
 static int ipvlan_add_addr6(struct ipvl_dev *ipvlan, struct in6_addr *ip6_addr)
 {
@@ -922,32 +949,6 @@ static int ipvlan_addr6_event(struct notifier_block *unused,
 
 	return NOTIFY_OK;
 }
-
-static int ipvlan_addr6_validator_event(struct notifier_block *unused,
-					unsigned long event, void *ptr)
-{
-	struct in6_validator_info *i6vi = (struct in6_validator_info *)ptr;
-	struct net_device *dev = (struct net_device *)i6vi->i6vi_dev->dev;
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
-	int ret = NOTIFY_OK;
-
-	if (!ipvlan_is_valid_dev(dev))
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case NETDEV_UP:
-		spin_lock_bh(&ipvlan->port->addrs_lock);
-		if (ipvlan_addr_busy(ipvlan->port, &i6vi->i6vi_addr, true)) {
-			NL_SET_ERR_MSG(i6vi->extack,
-				       "Address already assigned to an ipvlan device");
-			ret = notifier_from_errno(-EADDRINUSE);
-		}
-		spin_unlock_bh(&ipvlan->port->addrs_lock);
-		break;
-	}
-
-	return ret;
-}
 #endif
 
 static int ipvlan_add_addr4(struct ipvl_dev *ipvlan, struct in_addr *ip4_addr)
@@ -997,38 +998,15 @@ static int ipvlan_addr4_event(struct notifier_block *unused,
 	return NOTIFY_OK;
 }
 
-static int ipvlan_addr4_validator_event(struct notifier_block *unused,
-					unsigned long event, void *ptr)
-{
-	struct in_validator_info *ivi = (struct in_validator_info *)ptr;
-	struct net_device *dev = (struct net_device *)ivi->ivi_dev->dev;
-	struct ipvl_dev *ipvlan = netdev_priv(dev);
-	int ret = NOTIFY_OK;
-
-	if (!ipvlan_is_valid_dev(dev))
-		return NOTIFY_DONE;
-
-	switch (event) {
-	case NETDEV_UP:
-		spin_lock_bh(&ipvlan->port->addrs_lock);
-		if (ipvlan_addr_busy(ipvlan->port, &ivi->ivi_addr, false)) {
-			NL_SET_ERR_MSG(ivi->extack,
-				       "Address already assigned to an ipvlan device");
-			ret = notifier_from_errno(-EADDRINUSE);
-		}
-		spin_unlock_bh(&ipvlan->port->addrs_lock);
-		break;
-	}
-
-	return ret;
-}
+static int ipvlan_addr_validator_event_cb(struct notifier_block *nblock,
+					  unsigned long event, void *ptr);
 
 static struct notifier_block ipvlan_addr4_notifier_block __read_mostly = {
 	.notifier_call = ipvlan_addr4_event,
 };
 
 static struct notifier_block ipvlan_addr4_vtor_notifier_block __read_mostly = {
-	.notifier_call = ipvlan_addr4_validator_event,
+	.notifier_call = ipvlan_addr_validator_event_cb,
 };
 
 static struct notifier_block ipvlan_notifier_block __read_mostly = {
@@ -1039,11 +1017,33 @@ static struct notifier_block ipvlan_notifier_block __read_mostly = {
 static struct notifier_block ipvlan_addr6_notifier_block __read_mostly = {
 	.notifier_call = ipvlan_addr6_event,
 };
+#endif
 
-static struct notifier_block ipvlan_addr6_vtor_notifier_block __read_mostly = {
-	.notifier_call = ipvlan_addr6_validator_event,
+static struct notifier_block
+ipvlan_addr6_vtor_notifier_block __read_mostly __maybe_unused = {
+	.notifier_call = ipvlan_addr_validator_event_cb,
 };
-#endif
+
+static int ipvlan_addr_validator_event_cb(struct notifier_block *nblock,
+					  unsigned long event, void *ptr)
+{
+	struct in6_validator_info *i6vi;
+	struct net_device *dev;
+
+	if (nblock == &ipvlan_addr4_vtor_notifier_block) {
+		struct in_validator_info *ivi;
+
+		ivi = (struct in_validator_info *)ptr;
+		dev = ivi->ivi_dev->dev;
+		return ipvlan_addr_validator_event(dev, event, ivi->extack,
+						   &ivi->ivi_addr, false);
+	}
+
+	i6vi = (struct in6_validator_info *)ptr;
+	dev = i6vi->i6vi_dev->dev;
+	return ipvlan_addr_validator_event(dev, event, i6vi->extack,
+					   &i6vi->i6vi_addr, true);
+}
 
 static int __init ipvlan_init_module(void)
 {
-- 
2.43.0


