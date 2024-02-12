Return-Path: <netdev+bounces-70971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 768B58516B5
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 15:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A96961C22F9B
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 14:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24383BB46;
	Mon, 12 Feb 2024 14:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xm6QYh3J"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BFF3F9D4
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 14:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746825; cv=none; b=IYGI3kEHfFzISjRC+l6rXtEOgko5CeuYMGZyzEvPo5NgQC+bJuBRzqFAQ0tJWtQT/yQLln4+H6CnSfKfOn+ktVrJeF+DeuND+tXl6U/Th4TF9mr2Zh5Z6lxl1YnhfRY5X3Lhd3nMACK3fcJyjVJsq6XhOdgre4iQkAMgZ/aeP/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746825; c=relaxed/simple;
	bh=xkkKDeb7BhGF3UBXi9VXOECRpIs/B20lzDdtRcMTq5A=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e7uisfxfmj6MqI1pqt61jKI65LwI8Paw+lPBYZa+JrgvzzGMuEGWJNphyRwkMrPSQa6MqKJV0kdHhuRKZLvxF4PID0o+thCUmg9qfsN8BbCRN5SCEEuYgVpPPTQjDtDu6W4Uyhj1Wi7vA0rK+yyAXgGD2y/a5XQqDkB5bUXzJjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xm6QYh3J; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604ab15463aso52386787b3.3
        for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 06:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707746823; x=1708351623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6mUPuemn6ioPSkZySkqkj7JFY1KOSr64+WsbHTb1EM=;
        b=xm6QYh3JKrbKsylO9kv4lcNQv2cH6JhcmTH4/wGwCuXGnKphdKfOgsHTQty9ZTQIPf
         GmvKSLJD0eGmDdIqnFU970s4MCca8PaYj+YPI+JTyODVtmJKS1D/silFllxbLLW2yXdV
         IUQ4XDdtjFM2R0/lgAi/vuKNz/IH2AVPL9Gzk8t2Kan6iuQpW55qtA3lXlmKnE7uL9m/
         9RCutXTAgUTqnTJJGaaWR+Aj9+2qZv59enUslBsRYWxeqPPasMAyQzoPlSGJIw6REox1
         noUxxewu/1Np9zM1DT3nRsh4e3zKDd2rNsHgDm0uSo2OkOuR8vMjYMGidzf5URmyY0Hj
         1umg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746823; x=1708351623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6mUPuemn6ioPSkZySkqkj7JFY1KOSr64+WsbHTb1EM=;
        b=wwCuSNPCcT5/gtNFOKzx+1ZQDnb84FYCd3h+QCp3VBcnSQBViWUWMsNgOKf73hO3ip
         ny86t+q70eCSbbNemZRMamXsR3FLFecD3maFGJPAgrXW0l+p4e1YF0h4ff/22O4K9ACP
         ECIbxBJ67xzJBI4Tm06vOzL5HFDdPFfoVPvdvGtZirlG3d9yBXZyYpighTZ1WdlGR5wG
         NZ399SDo4/G+dzH6C9yD9pB6b1iA2zqZLO1Jbfr1G1+00G6VVpWMLJv7c2KVDlzWhALQ
         C4rMGFmY087MBZsifRWdAyBndPmfeJZRb3mCpbytnglmbtYn25IRNs1UNRPLkMIqxJuQ
         WVIA==
X-Gm-Message-State: AOJu0YzEdrsytgZKhnme3kpKJ1oscJInBbtgvMD56Q8ui+25cNqlnQ3u
	6FPFQJE7pJQKkxfWYDjsGp5FXJMaZFbYitWlEqrkRUjh9AWUaFXRCSj/wyBlNgg+ZXWZdsrQVNV
	emb7oH47tlA==
X-Google-Smtp-Source: AGHT+IGHz5xOlY7MbvhhbbxW9Fqy7cqTFp8FvdtbJMv3VygaUxm0KULBhtYYLZEB2nb1whDUVq5JybPDAiP7lg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:ae15:0:b0:dc1:f6f0:1708 with SMTP id
 a21-20020a25ae15000000b00dc1f6f01708mr240163ybj.7.1707746823341; Mon, 12 Feb
 2024 06:07:03 -0800 (PST)
Date: Mon, 12 Feb 2024 14:06:58 +0000
In-Reply-To: <20240212140700.2795436-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212140700.2795436-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212140700.2795436-2-edumazet@google.com>
Subject: [PATCH net-next 1/3] vlan: use netdev_lockdep_set_classes()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

vlan uses vlan_dev_set_lockdep_class() which lacks qdisc_tx_busylock
initialization.

Use generic netdev_lockdep_set_classes() to not worry anymore.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/8021q/vlan_dev.c | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index 407b2335f091ec48d3795e225367f53d354aca4f..790b54a7cbe3801154bd99375866c9f2ec4a158e 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -504,28 +504,6 @@ static void vlan_dev_set_rx_mode(struct net_device *vlan_dev)
 	dev_uc_sync(vlan_dev_priv(vlan_dev)->real_dev, vlan_dev);
 }
 
-/*
- * vlan network devices have devices nesting below it, and are a special
- * "super class" of normal network devices; split their locks off into a
- * separate class since they always nest.
- */
-static struct lock_class_key vlan_netdev_xmit_lock_key;
-static struct lock_class_key vlan_netdev_addr_lock_key;
-
-static void vlan_dev_set_lockdep_one(struct net_device *dev,
-				     struct netdev_queue *txq,
-				     void *unused)
-{
-	lockdep_set_class(&txq->_xmit_lock, &vlan_netdev_xmit_lock_key);
-}
-
-static void vlan_dev_set_lockdep_class(struct net_device *dev)
-{
-	lockdep_set_class(&dev->addr_list_lock,
-			  &vlan_netdev_addr_lock_key);
-	netdev_for_each_tx_queue(dev, vlan_dev_set_lockdep_one, NULL);
-}
-
 static __be16 vlan_parse_protocol(const struct sk_buff *skb)
 {
 	struct vlan_ethhdr *veth = (struct vlan_ethhdr *)(skb->data);
@@ -627,7 +605,7 @@ static int vlan_dev_init(struct net_device *dev)
 
 	SET_NETDEV_DEVTYPE(dev, &vlan_type);
 
-	vlan_dev_set_lockdep_class(dev);
+	netdev_lockdep_set_classes(dev);
 
 	vlan->vlan_pcpu_stats = netdev_alloc_pcpu_stats(struct vlan_pcpu_stats);
 	if (!vlan->vlan_pcpu_stats)
-- 
2.43.0.687.g38aa6559b0-goog


