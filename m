Return-Path: <netdev+bounces-165629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA01A32DD8
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A7516885F
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 17:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC9D25EFAC;
	Wed, 12 Feb 2025 17:47:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 505FE25D546;
	Wed, 12 Feb 2025 17:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739382466; cv=none; b=acXvUxn980N/oEuZLgpd2UzLIlio1ycQGQf9ZBnxdHXIUQCzh3OePfL4qBe0YwsO2Ehl73lz6JKfbOOvEhzZEyrq7aDqOa+hZfy0+h3OCpXZnBHVzfQXJ7jIINiyz8NYByDjNfCaeviwZL048Kjha8xwGJjNQNfpiGV92C/uvAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739382466; c=relaxed/simple;
	bh=GfR6JTuRSsa2IYJJgEme7fW5A4V2org/1egMMxi3lEA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t9XFsIQpvaPoBiZ3mKATzDyTCHZPEEQX1uh2wr9I/Au8tm/YGuu/llw+fVUPw0In5u1AyXapATxFDdQO5psUfAJBZdqBNNF0kNA8h/kO7gNZLaJZvGSr9FFjUpIEEMYXRs+CLSpL3JwFbGVZulD/Epm7xjNHCMA6On+Hh0EXRC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dec817f453so386645a12.2;
        Wed, 12 Feb 2025 09:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739382461; x=1739987261;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DJqbUdrIBG93xhwXUYCen7csaum05otOobrUq2xeUA=;
        b=chwnPa3++rOmRJcPid+GmmTCfPjynNae/o3nCw1wlpCJaPJRwsNjyyHwaMUikflwvs
         M129vMvLf1Au62H+7KO6wury6Bb4LkB6/wa+an7QOXHZdbIZrVX8UFuDrFRlPkxaFZ8T
         4h+zZCIRob8xpwSo2vt0b0P8/5sd1+zQgp7YNNYk9ZPLn0J/M3r/i7oCU9Vt6RsGRL41
         InxTolq2tG9rjqPMEG8JydqYyI6NeiVJbe/xLulh8qGXqVmwcQ18L2yoNNTNW3bcSQha
         XciouAtzp3kHmJCPF8lW9MFc+QlvHmgmWTWb6OJCqaTp3dPwXL9LChCro0GgFJkZbs7u
         segA==
X-Forwarded-Encrypted: i=1; AJvYcCUtmz7EEqAwxaLm3zKm7PBln+Ttpin/4rFZtIiHjj7NKc/c3XzC9kij8oBAYUOIrpnFy7jEsfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhBNtMX8LLmv3KHkc4kqPbrmeSyHC0/FUN+smP8NJ+zYMI7cGZ
	vrkahb0bI8Hj+43p367f4ygklmk82flViLLOGgaA+kRbRjobB5/7
X-Gm-Gg: ASbGncsrgMdrrDWk/X+J1qu6lHjxM69H/0Lmg45k4jSYC4FadaWr6ZlGbVEQI48pNTE
	JWK4tpzrMbjiXtjVYebYT8IekscNjAmzS0JDztcHjSe0SHkRRridynZh2Gl4q3RciNvCAsZzEnT
	zrIAlOkWgBzaYzaBUtztySGRSGJXuUYZRdQu9R8yu8hQSzmVyPA9vsAYye5enqFHxyTcWzzI8zx
	w1IE1CbxuFOi+OTDtW7uEQhds7riiZ+A5Ycf7CjPaeSqhdekKG74EirlUtBe4azpT6outE8c2Q7
	5CZq2w==
X-Google-Smtp-Source: AGHT+IEM9cL9mfPZWC6PdtyKbpT+cMyOcYAdAhPmC6gbjZ8NAdy8ccqiWYRnMBUvMk8+BZS3Mk7r3g==
X-Received: by 2002:a05:6402:5114:b0:5da:ba6:3a3e with SMTP id 4fb4d7f45d1cf-5deadd780e6mr3859145a12.7.1739382461304;
        Wed, 12 Feb 2025 09:47:41 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:4::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dcf1b73f8csm11671510a12.8.2025.02.12.09.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 09:47:40 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Feb 2025 09:47:25 -0800
Subject: [PATCH net-next v3 2/3] net: Add dev_getbyhwaddr_rtnl() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250212-arm_fix_selftest-v3-2-72596cb77e44@debian.org>
References: <20250212-arm_fix_selftest-v3-0-72596cb77e44@debian.org>
In-Reply-To: <20250212-arm_fix_selftest-v3-0-72596cb77e44@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, David Ahern <dsahern@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kuniyu@amazon.co.jp, 
 ushankar@purestorage.com, kernel-team@meta.com, kuniyu@amazon.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3573; i=leitao@debian.org;
 h=from:subject:message-id; bh=GfR6JTuRSsa2IYJJgEme7fW5A4V2org/1egMMxi3lEA=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnrN648rReug6hS5mIJNHOHbNvHBy1Z/vJmSmUh
 hXywQZTWyiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6zeuAAKCRA1o5Of/Hh3
 bQwzD/9nOcuExTATmY0VnbrnOgXqaQxRNcbgDi2TclRrBnwWixFCyUdugTYjv/+NBPCzc0s77UF
 A7msvkPPDzUzddCL0ZQMm2MX/MkEDIx/TKASeHR5nrXPpPrQPRwEqGtbzD3+/Jp98UT831pz4x6
 DRCrR/CuL7TvLcoGLGNcuBIxsh26EB/wAxp6nmcpL5uqGUmckAw+qs3PZyICxWA19XmComvtPM/
 qm52Jt6kjjREPKs/4QdxfDmpU5aonu+0tcPQLS3+0uFgCCVBayuE/G2bwVidfy0CUKr1M4Z41Rv
 ouBVcf2sTf9lszRr+jVXwW74h3LiAs4rOvt/kq3ils3tZJbxRVTEYE/QW9UT+wR9Cpis0TF4Euw
 fy+/F+CSUb1G1IJGUQO1Dvh3zelvKTF1vxmK36g8zk+MKT3LjQwl8pIJrPXVf6BRxDe6vdoJtCX
 LEd8YJGgFQXbrdBjQqWID0vT/6ciWAUVQok/E66RXuLvG+cnSxFGMxoYbQL3ERMnIUh7yVF5HAP
 zCJ+i+dnOjJzJXMKt2CEZhMs5b0rWMOJWNOkxnOLMj7CG7TjOTXVMd+d2eijxc/4wIky5OQBhFA
 npFip61RR1Gd6KpR01OU9crzXcnUjsQWMhOk6Ncs2HC4t/lB1M34M0P+0Ryv6g2c5ug7Olot+zM
 XRy8kc7jJRisAew==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Add dedicated helper for finding devices by hardware address when
holding rtnl_lock, similar to existing dev_getbyhwaddr_rcu(). This prevents
PROVE_LOCKING warnings when rtnl_lock is held but RCU read lock is not.

Extract common address comparison logic into dev_comp_addr().

The context about this change could be found in the following
discussion:

Link: https://lore.kernel.org/all/20250206-scarlet-ermine-of-improvement-1fcac5@leitao/

Cc: kuniyu@amazon.com
Cc: ushankar@purestorage.com
Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/netdevice.h |  2 ++
 net/core/dev.c            | 36 +++++++++++++++++++++++++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 5429581f22995bff639e6962a317adbd0ce30cff..641091c73710f8c4229e76c66f40ede9c235c221 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3270,6 +3270,8 @@ static inline struct net_device *first_net_device_rcu(struct net *net)
 }
 
 int netdev_boot_setup_check(struct net_device *dev);
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *hwaddr);
 struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 				       const char *hwaddr);
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type);
diff --git a/net/core/dev.c b/net/core/dev.c
index 0b3480a125fcaa6f036ddf219c29fa362ea0cb29..fd15f96cbd8a99da0aa686f22e3e955d179ffc99 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1122,6 +1122,12 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
 	return ret;
 }
 
+static bool dev_comp_addr(struct net_device *dev, unsigned short type,
+			  const char *ha)
+{
+	return dev->type == type && !memcmp(dev->dev_addr, ha, dev->addr_len);
+}
+
 /**
  *	dev_getbyhwaddr_rcu - find a device by its hardware address
  *	@net: the applicable net namespace
@@ -1130,7 +1136,7 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
  *
  *	Search for an interface by MAC address. Returns NULL if the device
  *	is not found or a pointer to the device.
- *	The caller must hold RCU or RTNL.
+ *	The caller must hold RCU.
  *	The returned device has not had its ref count increased
  *	and the caller must therefore be careful about locking
  *
@@ -1142,14 +1148,38 @@ struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 	struct net_device *dev;
 
 	for_each_netdev_rcu(net, dev)
-		if (dev->type == type &&
-		    !memcmp(dev->dev_addr, ha, dev->addr_len))
+		if (dev_comp_addr(dev, type, ha))
 			return dev;
 
 	return NULL;
 }
 EXPORT_SYMBOL(dev_getbyhwaddr_rcu);
 
+/**
+ *	dev_getbyhwaddr - find a device by its hardware address
+ *	@net: the applicable net namespace
+ *	@type: media type of device
+ *	@ha: hardware address
+ *
+ *	Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
+ *	rtnl_lock.
+ *
+ *	Return: pointer to the net_device, or NULL if not found
+ */
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *ha)
+{
+	struct net_device *dev;
+
+	ASSERT_RTNL();
+	for_each_netdev(net, dev)
+		if (dev_comp_addr(dev, type, ha))
+			return dev;
+
+	return NULL;
+}
+EXPORT_SYMBOL(dev_getbyhwaddr);
+
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type)
 {
 	struct net_device *dev, *ret = NULL;

-- 
2.43.5


