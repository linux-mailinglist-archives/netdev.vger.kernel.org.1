Return-Path: <netdev+bounces-186641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98896AA0078
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 05:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D18D47AA7FD
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 03:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A404278149;
	Tue, 29 Apr 2025 03:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q3os2TqV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E35276041
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 03:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745897225; cv=none; b=QlG6KYvLc7MPsMhRTt/HKnCHpKQ7Tt7tFoSkeUg/SaHg35GjG6QV2gzx1d1lw/4/meAqsAJxoBOsXNGDQZ4pzPJi0tFT8L+baoR45kOGmydWJanVXkFNuFS+QPmLS9O7snrWPNrdkizU70bLbaEyqoSLLvBmLOUbcha9uAGQEfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745897225; c=relaxed/simple;
	bh=A7Gqoe2REliQn3D8I8ViowlNgFS3gK0zrYxlmzIFsP0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sb1m30BCFDC8cDkMPXV7Rl3uuDHZ64s5KSpImlF7W/3H5tjrKgzWTPIwElbR4cbXk7CF+D+kH+Jy85zv6mexY30F6xy8U4O3TnO/O9CVJ1NLuJ1QxcBsriD4L4dTq2XEY/KQYoQMO5YJ4bkAODSopl7jvwxdAlBBz8nHdXrUoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q3os2TqV; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73e0094706bso6937243b3a.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 20:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745897222; x=1746502022; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=e1032nSfcUejN3wnyduYVEgTSlMhJTQ/ggAvfPEjRBQ=;
        b=Q3os2TqVlL+qYULQ4sS+ZyR0q7ABt95gyDwsqItLaFSVM9u3woxI57CpI5+36agj+w
         Mp1sNhZvkiQ2Sa915ciHGtwVfNGcktOPb1ZwuqiE0Ta0N2fBF1XbpVOnAdTsloI6TkYv
         c53730JQCTlwUzM5HY8i3LQP/Y/gFZNhnqJL47g6NTRsZ29NfqMYEocnq9b/2ceCY+rg
         pobsDG4UngnRNOMcggS0ddZE5B5SgRwtptaBtu9REYO25dQxTLQemCNKSlYFVYcIKDhx
         TOH9VHuff5e/n5yA1bFNIw2IvGr5dLgWBXELg9IhPHiWPFXiFD+om1MJOnU7oNWU3r6y
         KgFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745897222; x=1746502022;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e1032nSfcUejN3wnyduYVEgTSlMhJTQ/ggAvfPEjRBQ=;
        b=dt+G3aFwt1azu1R7KJ9fcUhPkjLydy4IhhOrtecp9TKRJIxkkGgbjN5Ays7Hs7N90g
         8pvz+oZn7n3bAXQJi+aFY0L7NDt7NOSy0QiNtR0J96mi9y+6nTS0TT/IjTJqdyU3057z
         crKIjZfRYA6InjGmAOqAWbZmZBuFWHHxkfG3OO35KaTD9pqS+DUhSBEB2hgTgyq8vu1y
         lgtLV0fVlQ2db1wqsdzXssE573hR1z79Jt2BKkw6fLGXQVUBaVv2QLHPbhO/v2f81l45
         HWX8gWMfv0N4P04uDXeZgwd0I5y4TSqrR8ArvDccgkEs6D6H7oq6kuZHwG3Jc9gnfDCK
         6AEw==
X-Gm-Message-State: AOJu0YzN4Ca7wt4N26TcjsB/uCes/nEszaNZENmYmvic0VbHIRzfcknO
	yiKr7cupRTacYCDK1M7oL0eVb0dY9//suHD0IUhYgxiLRo8kV1eCm4CApDi/cZKBemxzb3v/hOa
	NYqLUfXx8bX7YoHX7jlBELh3L9+7rX6BZCjqarzsKRTvr7ha0idbLxVPtqrDZFqdNKqvgDLub1E
	fpkbH7hzUxNoWsuEc0T1M0V65I/6SbaRyLl/liDkkp5L6rTkwUaMMFYUxjh80=
X-Google-Smtp-Source: AGHT+IFmVM3YrkOhLWbCT7+b8wtIRcYElhCtGh67rI6iSh5PAx3yi8oyEgSS83P+VHq5mzTmEXYtXAkmX8xqOcB1vg==
X-Received: from pgbdo9.prod.google.com ([2002:a05:6a02:e89:b0:b0d:967f:2404])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:cfa4:b0:1f5:58b9:6d97 with SMTP id adf61e73a8af0-2093e52803amr2977856637.35.1745897221928;
 Mon, 28 Apr 2025 20:27:01 -0700 (PDT)
Date: Tue, 29 Apr 2025 03:26:44 +0000
In-Reply-To: <20250429032645.363766-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250429032645.363766-1-almasrymina@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250429032645.363766-9-almasrymina@google.com>
Subject: [PATCH net-next v13 8/9] net: check for driver support in netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, io-uring@vger.kernel.org, 
	virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not enable netmem TX for drivers that don't declare support.

Check for driver netmem TX support during devmem TX binding and fail if
the driver does not have the functionality.

Check for driver support in validate_xmit_skb as well.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v8:
- Rebase on latest net-next and resolve conflict.
- Remove likely (Paolo)

v5: https://lore.kernel.org/netdev/20250227041209.2031104-8-almasrymina@google.com/
- Check that the dmabuf mappings belongs to the specific device the TX
  is being sent from (Jakub)

v4:
- New patch

---
 net/core/dev.c         | 34 ++++++++++++++++++++++++++++++++--
 net/core/devmem.h      |  6 ++++++
 net/core/netdev-genl.c |  7 +++++++
 3 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index d1a8cad0c99c4..66f0c122de80e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3896,12 +3896,42 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
 }
 EXPORT_SYMBOL(skb_csum_hwoffload_help);
 
+static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
+						    struct net_device *dev)
+{
+	struct skb_shared_info *shinfo;
+	struct net_iov *niov;
+
+	if (likely(skb_frags_readable(skb)))
+		goto out;
+
+	if (!dev->netmem_tx)
+		goto out_free;
+
+	shinfo = skb_shinfo(skb);
+
+	if (shinfo->nr_frags > 0) {
+		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
+		if (net_is_devmem_iov(niov) &&
+		    net_devmem_iov_binding(niov)->dev != dev)
+			goto out_free;
+	}
+
+out:
+	return skb;
+
+out_free:
+	kfree_skb(skb);
+	return NULL;
+}
+
 static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device *dev, bool *again)
 {
 	netdev_features_t features;
 
-	if (!skb_frags_readable(skb))
-		goto out_kfree_skb;
+	skb = validate_xmit_unreadable_skb(skb, dev);
+	if (unlikely(!skb))
+		goto out_null;
 
 	features = netif_skb_features(skb);
 	skb = validate_xmit_vlan(skb, features);
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 67168aae5e5b3..919e6ed28fdcd 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -229,6 +229,12 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_binding *binding, size_t addr,
 {
 	return NULL;
 }
+
+static inline struct net_devmem_dmabuf_binding *
+net_devmem_iov_binding(const struct net_iov *niov)
+{
+	return NULL;
+}
 #endif
 
 #endif /* _NET_DEVMEM_H */
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index db0e9a6a4badc..119f4fbc0c944 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -982,6 +982,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
 	}
 
+	if (!netdev->netmem_tx) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Driver does not support netmem TX");
+		goto err_unlock_netdev;
+	}
+
 	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
 					 info->extack);
 	if (IS_ERR(binding)) {
-- 
2.49.0.901.g37484f566f-goog


