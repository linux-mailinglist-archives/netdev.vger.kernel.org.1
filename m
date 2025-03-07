Return-Path: <netdev+bounces-172998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8936CA56CD1
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1743177BBE
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 15:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA88221D80;
	Fri,  7 Mar 2025 15:57:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A970221700;
	Fri,  7 Mar 2025 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363052; cv=none; b=cqbuLqe0Oofl3T5Y9y8v9dGrhYWt6rSdFVGeemhSKVmgbDw0yoa+uST5A78iorpPyAVV5+Y/ElXFul4sXYwSQLvu4OQ3AtGAXYA9u0IbrMWcahl/lPuISRtAgKlapuVSepQb5oIwDSfiybv0UeGnh7oC+R1amYuArAM7Mzq1uMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363052; c=relaxed/simple;
	bh=GN6Op8TH/Jsez7Jm4eQm4K7bgfkB1UTCd6/YG9PCL5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUbkUC41Q+Clamqj+s/5v1+GQh6lg431FJ20YUGoVLmq1KPjHS6WJ5/orxIeCl+WIVbMQOGpdEIR2Wn4rlaMI+xGwPeyV/v6ZZQwzyNQOMzcCKYVhJmq3Rg+tklijX7r2Ld/QdBUzNYZaacNSr9nHo4G8kdU0anDwp8LceKEECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so2271840a91.1;
        Fri, 07 Mar 2025 07:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363050; x=1741967850;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s3Q9mEWcCQiysBRQMwjr211wmRnTzGybB6MFLrlgznk=;
        b=dL0q2YIPYuAdG9xzNtLMPy7oT8G1AlOwj6j/8GH4+JXFYsApHkGZ13eUhZxu1Tt2v2
         1SD6+5ILJgwDZ9dYBJ1x+A5ho6GLgRAihPLe1ZWKXx4KiNrq1zsXAx1dSjDS7xVJd/Ws
         iLBq9TjcRyS1+Qw8K0TQauOK521FLBL7a2/FWE081nbb1xFX9M9fFXAjCf7DEb5+G0c0
         hjK/NCXbuiXqm/kkjZ3qkqM5IzB0j2hJa1IgUzLFSJqeCFSYDeRhgeygCDbwREICr/av
         DKt4WDHYdeo0f8zQN4U8H3rQXfU+RazQoA4fr9mQvS4qCz/SDR0vJUJyEZBlcdX+WjZx
         LIpg==
X-Forwarded-Encrypted: i=1; AJvYcCXdocQWgUhzTtmhqGJjyPSjRw0WRx24yLECCkYZEanv97C6PaUumWUdHJq7zw/o8rUv8mbKwl5V6YYoAHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQHhG3R8459qz7aExJUgrnqbtnSL9QvkjF2iBCJPElq84cYU0A
	NEGIIutjWLJ3NUYbnkMGJtqgEduR/3daTxXR2Qrr5LwMwOfr9Gewmyfv
X-Gm-Gg: ASbGncuiTYAcq4ptwY0WQrONydnfledGDCiMC1UzuYnfWUoS4oMGU4106YoNtb5IjJp
	LfGqAsqbPEk1Jn9CbUCWJXyLnhuOVNpo92hy5v2FTsJZ2vBlA9maBiJW9dUgkCf+kiIVTKt9at+
	DKcoyICSrMGFh5i+XMJP7usd6Kjptp+8e3Fr4s+Wpctimk7Q0e9Jn3wqeM2w0985TADYaFEvbEm
	5PPcv5GJMOc8+AsTS7hKyvhsdzpwkbPw6HP1fw1DwLWXVPVTRylVn3pKmiUEGuSXkfydCnKw2nH
	O+TJBP64IJdcAfT5fbq56sKsofWEzjmINM0UVezGwrWY
X-Google-Smtp-Source: AGHT+IF2BmNraH2QXVQIEzs4eJGtB74Dm75ZgAwr6Sdps7YblYQeVGelxck2K4x1t3uj1s7rL2zBdA==
X-Received: by 2002:a17:90b:4b4f:b0:2ff:570d:88c5 with SMTP id 98e67ed59e1d1-2ff7ce831d4mr6614394a91.9.1741363050003;
        Fri, 07 Mar 2025 07:57:30 -0800 (PST)
Received: from localhost ([2601:646:9e00:f56e:2844:3d8f:bf3e:12cc])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-224109ddfbcsm31805275ad.21.2025.03.07.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:57:29 -0800 (PST)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	jdamato@fastly.com,
	sdf@fomichev.me,
	xuanzhuo@linux.alibaba.com,
	almasrymina@google.com,
	asml.silence@gmail.com,
	dw@davidwei.uk
Subject: [PATCH net-next v1 3/4] net: add granular lock for the netdev netlink socket
Date: Fri,  7 Mar 2025 07:57:24 -0800
Message-ID: <20250307155725.219009-4-sdf@fomichev.me>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307155725.219009-1-sdf@fomichev.me>
References: <20250307155725.219009-1-sdf@fomichev.me>
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
 net/core/netdev-genl.c       | 5 +++++
 2 files changed, 6 insertions(+)

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
index a219be90c739..8acdeeae24e7 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -859,6 +859,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_genlmsg_free;
 	}
 
+	mutex_lock(&priv->lock);
 	rtnl_lock();
 
 	netdev = __dev_get_by_index(genl_info_net(info), ifindex);
@@ -925,6 +926,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	net_devmem_unbind_dmabuf(binding);
 err_unlock:
 	rtnl_unlock();
+	mutex_unlock(&priv->lock);
 err_genlmsg_free:
 	nlmsg_free(rsp);
 	return err;
@@ -933,6 +935,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 void netdev_nl_sock_priv_init(struct netdev_nl_sock *priv)
 {
 	INIT_LIST_HEAD(&priv->bindings);
+	mutex_init(&priv->lock);
 }
 
 void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
@@ -940,11 +943,13 @@ void netdev_nl_sock_priv_destroy(struct netdev_nl_sock *priv)
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


