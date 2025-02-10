Return-Path: <netdev+bounces-164698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3036AA2EC05
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C94E3A8CA7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AAD2010E6;
	Mon, 10 Feb 2025 11:56:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E76C1F8AF8;
	Mon, 10 Feb 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188590; cv=none; b=Yjj1L+8B9w9oNyjJl7uwExiyxEDi9uaHWh7sazGmDK2g/77YBU5Dk0Zo3ObEBqaReu8Lb8taEstRS4dZeVB56sVcphu2j+9yjqYniUNK2lytzFh1cP8vaNhakqhXtK6zJCe/ocsUGd0AMMwpqZuoAGkVFseX+x1pjHLWNg1hJR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188590; c=relaxed/simple;
	bh=9qXMD7DKRRdpXXGGa3eUFsuBDPSVwnqaFAfpKKOmmHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IIH0Jb40hyersXGbpHhGSBuI8INy+FSfRXszcA+3kE8j+y4/YlJie5CO/45KmTegDtplbMMAxTmGYfvvD4av04nWhGsxVk1ybkZgtNNdVpaZpn89JND1ozep3tpmn+TwIs/QaDK5KXU7kC0VpZIK09GJssW1hPnEwu7jo0s7p84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-ab7a342ef4eso383785066b.0;
        Mon, 10 Feb 2025 03:56:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739188587; x=1739793387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OMERjpwIrdcVA9o9RHksiHjsobY3OD/zSwX31FPJNBI=;
        b=Sbx/mTmnotIiBVc1Lhu8doi3dfuAvDts9tEP24ubwWVDi0Vvh70uxLoW8JyG8ZxZRl
         LbyOi6bJRSVkf4Airx1/zs4ESWLBQ50930LIs8JXMYck7U4UIcVImDbNrd5Uv8F1otL1
         J7+pYl02GeZsxL97Ovy6w1E98X/pHcqdetsRHyxWPhjWX4dJAbE7bcMyC/CRbYtZLkPc
         lPnxqR3A7x0rRSHOE+0Z4YQ5c18hAaJf47wNe98JhOVhPUCvZJB/4efBe+DdiQAD5w7f
         yFN94JHCnOeBJd3ayEBqPQBg1wYHUHENIvY0Ya6vWszLNw4R5qYh9q2XwLlqnUAopTfp
         X3bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5HJjIgHkd3Ky8TiZjg881LVFZFtLkEvNXnFsKPsR9pN2+vjqEGFqgcesczv7YoqQ6xYyGUIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmaS/2yX/5+DJE3tcQaFTBbrfejW2rmjLwGZo8ErHB5TQ8QzON
	S82GsdPXM8LVPt9r1vYd5pcmn3hKQV/g1ioby5VSvURGNbTPNKJu
X-Gm-Gg: ASbGncujWmEADlgyXXVeWLXew5ui0TgUJiikgZmd4wnnm4bVH011W/GLv56DQDQdnES
	Y5DyQdHo0A7mpF9NqbZGPQuimX1zc2qjzsrfcLI98SpaJrzixFFHW/hIYe/f1F0bfMFSIpgeWtU
	dz+8o4oROZQY/OQuLmtN3gnMC6UiUOTnmWBuxkzSF4PffeGEBfaEHpSsauAUskG1SH1a60nbuIf
	HUi3ZlYQk/rivSjwakYTBWUMfZN9ITcBJfm5rSqIwLGJuTomUTZdK1qzuuVsQT0fqIzZS7BhpAg
	49Tiyw==
X-Google-Smtp-Source: AGHT+IGcFjSGks/05m3rV5CJD4HeNIWGYR5HugYAXLx2P6eXSRK/kHwMi+pDBpu+oYiAAzvxJ5tMCw==
X-Received: by 2002:a17:907:d1f:b0:aa6:9461:a186 with SMTP id a640c23a62f3a-ab789c5179bmr1466759766b.46.1739188587116;
        Mon, 10 Feb 2025 03:56:27 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7860da0e7sm738693366b.110.2025.02.10.03.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 03:56:26 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 10 Feb 2025 03:56:14 -0800
Subject: [PATCH net-next v2 2/2] net: Add dev_getbyhwaddr_rtnl() helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-arm_fix_selftest-v2-2-ba84b5bc58c8@debian.org>
References: <20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org>
In-Reply-To: <20250210-arm_fix_selftest-v2-0-ba84b5bc58c8@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com, kuniyu@amazon.com, 
 ushankar@purestorage.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3573; i=leitao@debian.org;
 h=from:subject:message-id; bh=9qXMD7DKRRdpXXGGa3eUFsuBDPSVwnqaFAfpKKOmmHM=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnqelmkHgavEJjD1R2wYYKAPTgq+UYa+sWoTtTc
 wPxLONeU4aJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ6npZgAKCRA1o5Of/Hh3
 bbvnD/9qB+4cTBOJcQTZzGI1C79x9ReURdxRYNbUIlPRH/6AHnp5/FESXs6ZQbI0fMQlNRJNOiL
 AWyBppqFUFD4zhyheInb4uTWidpHBUuS6HtlBuoNhBsTYK8fnkKMHjZre4kSobb4LzIzTKwN+k1
 +evI2kv6MdaVjX4C76P2lO9QzfO07xg77EVDCc6zTGwqE+626ZFYWmtAA9lm7vLh7jz1CadSr/1
 GNS6nnBeHXMUfhb65kdAZuuV3WrGQdH1rd4q1/fpPuiaFgnDav+r+EkbHEKK/YKM+d1tzbaJ7im
 ntG+DO7Hle9GqaY3R7sUtS7vnxKP4uHIX5sLr/zbXOiGc5Tjj1TBpGS7qJTWwGX8t1vi+dSLjfQ
 27ikqs0glqX9UwH1oV8PJLbWrPcC+jxJOG8TkeFbc8aL9lk7GRsR2wFXZUU/WGaXtIPpEC3KSVB
 zRbqFBE6EgF5FZHn866EFNpV1JaUZ22Fq34fNFkOtI3+tm83xpcMHamKhUgfzwuzppY1Nn5nLEn
 TkWeB5XjpzyfZe3acJpP9KuSMNwuWBw+VBbPhrNZYW2IXFi/pFW+tlPaHGR7uRC2QDwlYCJkIex
 YEIwxfRdYDWCbAIYrtu/mIs6uvJNJ5w170bffkLdDl9r0k0vgFQqYfSvc5jj0X4z05BkbBV9IeQ
 +jPsymdW9KHE4Ug==
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
index 0deee1313f23a625242678c8e571533e69a05263..6f0f5d327b41bfd5e0ccf9a3e63d6082bdf45d14 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3271,6 +3271,8 @@ static inline struct net_device *first_net_device_rcu(struct net *net)
 }
 
 int netdev_boot_setup_check(struct net_device *dev);
+struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
+				   const char *hwaddr);
 struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
 				       const char *hwaddr);
 struct net_device *dev_getfirstbyhwtype(struct net *net, unsigned short type);
diff --git a/net/core/dev.c b/net/core/dev.c
index c7e726f81406ece98801441dce3d683c8e0c9d99..2a0fbb319b2ad1b2aae908bc87ef19504cc42909 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1121,6 +1121,12 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
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
@@ -1129,7 +1135,7 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
  *
  *	Search for an interface by MAC address. Returns NULL if the device
  *	is not found or a pointer to the device.
- *	The caller must hold RCU or RTNL.
+ *	The caller must hold RCU.
  *	The returned device has not had its ref count increased
  *	and the caller must therefore be careful about locking
  *
@@ -1141,14 +1147,38 @@ struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
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


