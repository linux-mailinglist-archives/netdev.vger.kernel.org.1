Return-Path: <netdev+bounces-173933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17ADA5C415
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 15:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090AE17115A
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0C925D55A;
	Tue, 11 Mar 2025 14:40:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412A125D213;
	Tue, 11 Mar 2025 14:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704034; cv=none; b=FXM+b8NJgiFtZsnytexPovTErCaarWx2mjVcR7OAgclIHEsT0S+g4NXQ2c57POD9qSmBTbFoqFSK8bgscOgnAfRWHHEXys+prdE9mcpJIQAauqE3flxYVki4bnhb4bsNkTVRbf5lLC7YlLCVRYN4lOCEh7lb4lHeGW0U/tTXNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704034; c=relaxed/simple;
	bh=N1mIZ5aHIAdEIQ9Xu004oo+tEjwnQH70IfbsiDMnVes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVv0APY1h2yupxEVNZmQx3Z7gTddZdSEgdo2WfCr9Lms0L27W1EU5N2d/M09mEBqA0sFyrN7iCo0z4ap2tNgU5IfZvhXwRgxNTuJ02My+65xK1vO9CLophksP7cvBodCu1kiWc87OvwhhYegl9ud1H5NgaeeR1Gj58ZeqL+qK6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-223fd89d036so109190855ad.1;
        Tue, 11 Mar 2025 07:40:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741704032; x=1742308832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ANCxA7+p0eA4GCg1Qm9ypPlb2PsgQIC2MSDt7WmnMdg=;
        b=pDRBoWEoBd0SC9+93lH1o6bB/lNUlO6kIo3scBxHRpptmB0tMhLWfsJRmIvbOM7cLz
         uqJzNmo1jmUWknZuwR2lebywJBIPGCmfWt7lRTp+XWGtHA6alYUXNwouNE8I8inuNhfh
         Da0cy3tLDQ7rg1zoDT1iUNWL38YKYhH9nqdGCjn/AdOgqVkZn36dD11bmKL3EuXPnyXt
         CHjwUxSfsroR3L3uaVByVGY+kLHy7frRXes+E0PLFXGtbCL89grbglTYkMYVDiZk6j7d
         u8FsqXbLFl5W0KWc+aNFwMpjBN0nj5rQM3NzHzpGYUZDONztQlVGfs6rfzt9dHBY1BXy
         Fg8g==
X-Forwarded-Encrypted: i=1; AJvYcCVyT+htCmt4aecIHdgZ81kNLZv+Df4DdGEKkMUub1dIXoljILquTFy0E5eVuMhJe88npe3b5KjbWtj1oZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxRg744Zc2qST+0MrFYsrgBg5j2fGaj6i2yHrLeTrKu9/QP3qv
	84DYKC3JpYKcDEhy2lJB8ydN5ME1U5hyMr16Z2BB+RNGfo5ZRVI8BGnin+Bmaw==
X-Gm-Gg: ASbGncsv7HUhlT+VG+JnMivGUlL+7T+xRTTfJVQcY7A2Qq9RvSmS86cWv6QOWnQaApm
	UdnvR4pKDIYdSjwuoFLJ5Lvt3EDTMqAQ1g6zo4jvkQdS6O2BWzMyGvTP33OJcm2i7i5RBpPPzdt
	DeAUUEB4BOVFQxjX+LUPHrYQSZtApiyAQPl0TmXhucK38bwDiSl8L03ZToXVcGtw1b2Hbe+Pk6w
	UQTLtFlclK9BAxzeBDHdm3U8HSxaf7w82cT5VVdJtitLqbsLH1fqJIC1GIu0XQKbjLoQXBqdKjZ
	7MqPUJLhfgTNTMh3ppARtwnUrjorKb1Dlnp+vug7e7Wx
X-Google-Smtp-Source: AGHT+IHoNcyH+Ck8bVIbkVAcxYdZo4TmYd5vae8vnKHE+ufqswy1zQuq39qQts/9s6WJMohsW24FVg==
X-Received: by 2002:a05:6a21:2d04:b0:1f1:b69:9bdd with SMTP id adf61e73a8af0-1f544c87e20mr30237463637.37.1741704030753;
        Tue, 11 Mar 2025 07:40:30 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73698246387sm10382649b3a.72.2025.03.11.07.40.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:40:30 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	donald.hunter@gmail.com,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	jdamato@fastly.com,
	xuanzhuo@linux.alibaba.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk
Subject: [PATCH net-next v2 2/3] net: add granular lock for the netdev netlink socket
Date: Tue, 11 Mar 2025 07:40:25 -0700
Message-ID: <20250311144026.4154277-3-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250311144026.4154277-1-sdf@fomichev.me>
References: <20250311144026.4154277-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As we move away from rtnl_lock for queue ops, introduce
per-netdev_nl_sock lock.

Cc: Mina Almasry <almasrymina@google.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/net/netdev_netlink.h | 1 +
 net/core/netdev-genl.c       | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/net/netdev_netlink.h b/include/net/netdev_netlink.h
index 1599573d35c9..075962dbe743 100644
--- a/include/net/netdev_netlink.h
+++ b/include/net/netdev_netlink.h
@@ -5,6 +5,7 @@
 #include <linux/list.h>
 
 struct netdev_nl_sock {
+	struct mutex lock;
 	struct list_head bindings;
 };
 
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index a219be90c739..63e10717efc5 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_genlmsg_free;
 	}
 
+	mutex_lock(&priv->lock);
 	rtnl_lock();
 
 	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
@@ -918,6 +919,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unbind;
 
 	rtnl_unlock();
+	mutex_unlock(&priv->lock);
 
 	return 0;
 
@@ -925,6 +927,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	net_devmem_unbind_dmabuf(binding);
 err_unlock:
 	rtnl_unlock();
+	mutex_unlock(&priv->lock);
 err_genlmsg_free:
 	nlmsg_free(rsp);
 	return err;
@@ -933,6 +936,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
 {
 	INIT_LIST_HEAD(&priv->bindings);
+	mutex_init(&priv->lock);
 }
 
 void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
@@ -940,11 +944,13 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
 	struct net_devmem_dmabuf_binding *binding;
 	struct net_devmem_dmabuf_binding *temp;
 
+	mutex_lock(&priv->lock);
 	list_for_each_entry_safe(binding, temp, &priv->bindings, list) {
 		rtnl_lock();
 		net_devmem_unbind_dmabuf(binding);
 		rtnl_unlock();
 	}
+	mutex_unlock(&priv->lock);
 }
 
 static int netdev_genl_netdevice_event(struct notifier_block *nb,
-- 
2.48.1


