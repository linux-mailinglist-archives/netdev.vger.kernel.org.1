Return-Path: <netdev+bounces-170098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0799CA4742E
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:16:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575193AF5EF
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666B822B582;
	Thu, 27 Feb 2025 04:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v6y4S31Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BE71F583E
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629547; cv=none; b=k6G7nOUiBA8F4KfAwSBAY9h3GRAvinHcqJsnw8cgADFoNXdQ2G0bC3l4XlQVcX3CEb/dFRhDNojoMAG4ZOyh4s9U3SgNqmU2ru38gfZt89fDhumLZExAIFGk464oyPDegE0J83Ff0cb7BlyOZFtG/NCbDa7PuOht58noYOvj8L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629547; c=relaxed/simple;
	bh=GvcT8AKSmZkQfzKz7YEMgUlDLlmUyxkr186tf9XcX4w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tvO82TFhOcQJu71g8XLAa2gIEh/R1VAQ4tSXR6UWc5YEHsasyWT4Niw5SA8N9AG57KTs9KyrZYL5Lx4tVOozsj3TkCwpbcnkQtQ+uWRwdddYfFp+JzDpXnLEqQIUgCrOGmvcFfu1GKidia2UBKh6KcU2orhiKzr9ChMj5n8J4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v6y4S31Y; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fce2954a10so1801849a91.1
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 20:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740629544; x=1741234344; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BK8UWHjd2d73PlicaTz2yvcD3Y84sSY5zmWMDwEl4c=;
        b=v6y4S31YKv4x+uW9O+Igp8KrfXI3dFYNdGbVp8qu8vT9jCfd3QbOl1PVy5st92cxY5
         KnI37iEcM2f4L/5JL0DUV2yD593EpbWDcxy/mvArqJ9n5SLCbGTyTt26HtyzPaEqxSMf
         Q9Dhml0AhVw2z9pSStOGA1ZA/fCBRh0aHBOon+xzxw35W1FuRONNsbNYIlTTu/EK4KIM
         pb4dqVsCgkKVWycO/sNwDop3+m5KgYz2aPLnjTU78EurqMnH8vhOP575WzyJuxmG1sH7
         gk2nyaUm8YLZl5lJXf+bdb1UD9fNkhv4XYSnUqkzGMeO+ls0I598okWGTmhAV4McFFeT
         O2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629544; x=1741234344;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BK8UWHjd2d73PlicaTz2yvcD3Y84sSY5zmWMDwEl4c=;
        b=n6yx0w6wImXD4jDVjNDsGTTVQ4O7Ht/YN8JFAHIoZeCmS3I5bcLktqf3C2uhq0M9cR
         Leva6dvylA+/7ciTdnqJsay2dczIo7Gi+sNJaEh9gW2bxaZzeXDXu6Y2MakMTpXrVg54
         ec9QPQBd2Oi8ZEiQIcOGeJIBUV0n5dbV5+fn8b2XXSssxHz9rEH8Dj6udVdunfJnsjzL
         np9HQFrRibk7dl9V2La6h4o/i6gooFcwcBq4Djb62j3LdDd8s0s7okq/mu605EIz9BcE
         LW0uRUPSIpFS1DtYRuICuhq6Yq+uDezXGmXil0paKQOQNN9JwB7dwwXAwryMq7Pb5zle
         IL5g==
X-Gm-Message-State: AOJu0YyGwUbzP1eh6AHPRc7qLX77IG5nGsDOWlXWjjy9sSeMT9K/WThm
	+Gzo1YO2UnFVRi4csgvoXEbzuEv5dFSIYiFzyNLEQKtZC3eXTGuAOcZw1AysBiaBbb9oiD6lh5l
	SgsoorKIaBlSa4flIQ2o3W8v+Ys8v5hi4iQaEaVnjkYHWcS1qOAZthAXo3uUWJ4DnIrbP9mR2Fe
	uxeDb5S6MmZ1MN9MtOOjFYladM9tkdHCdiUyVaPHsqA1gUS4NrbzRsQeeyMg4=
X-Google-Smtp-Source: AGHT+IHTUySLG4gKkq1561d2wLktf6kPf+TzsmbkPTQcuGF4Ixx/z+TeQmg+TX9wQn3KAepG/Npu4ft2SXxLD33YGA==
X-Received: from pjz6.prod.google.com ([2002:a17:90b:56c6:b0:2fc:3022:36b8])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:3b83:b0:2f6:d266:f45c with SMTP id 98e67ed59e1d1-2fce868c637mr39635027a91.2.1740629543963;
 Wed, 26 Feb 2025 20:12:23 -0800 (PST)
Date: Thu, 27 Feb 2025 04:12:08 +0000
In-Reply-To: <20250227041209.2031104-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250227041209.2031104-1-almasrymina@google.com>
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250227041209.2031104-8-almasrymina@google.com>
Subject: [PATCH net-next v6 7/8] net: check for driver support in netmem TX
From: Mina Almasry <almasrymina@google.com>
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kselftest@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Jeroen de Borst <jeroendb@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"=?UTF-8?q?Eugenio=20P=C3=A9rez?=" <eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, 
	asml.silence@gmail.com, dw@davidwei.uk, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Victor Nogueira <victor@mojatatu.com>, Pedro Tammela <pctammela@mojatatu.com>, 
	Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"

We should not enable netmem TX for drivers that don't declare support.

Check for driver netmem TX support during devmem TX binding and fail if
the driver does not have the functionality.

Check for driver support in validate_xmit_skb as well.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>

---

v4:
- New patch

---
 net/core/dev.c         | 3 +++
 net/core/netdev-genl.c | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3f525278a871..80636c569cf4 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3921,6 +3921,9 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
 
 	skb = validate_xmit_xfrm(skb, features, again);
 
+	if (!skb_frags_readable(skb) && !dev->netmem_tx)
+		goto out_kfree_skb;
+
 	return skb;
 
 out_kfree_skb:
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 6e7cd6a5c177..6c5d62df0d65 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -972,6 +972,13 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
+	if (!netdev->netmem_tx) {
+		err = -EOPNOTSUPP;
+		NL_SET_ERR_MSG(info->extack,
+			       "Driver does not support netmem TX");
+		goto err_unlock;
+	}
+
 	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd,
 					 info->extack);
 	if (IS_ERR(binding)) {
-- 
2.48.1.658.g4767266eb4-goog


