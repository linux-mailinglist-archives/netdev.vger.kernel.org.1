Return-Path: <netdev+bounces-68621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 565DB84765D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7FD21F224D9
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1690B14D43C;
	Fri,  2 Feb 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P5Adi6+p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7296C145B2D
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895623; cv=none; b=B+mjrZBn/WzzKVdgU3xWdvwS+byptuU9CDlReQdqwUsjcDtM5Hk8WwxiTSv9EkBoQfhlmDzcVfuOJMPjTkKLjJsN+rSqWgmmz38gL9+jp8RKIgIUrd7PHN9/B6UiNaiBZnFn0IanuCuvdzKum5AdW6Ft6za8cqSoFOAbavq0/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895623; c=relaxed/simple;
	bh=3kdCeRYsyI0ajFHIAb5IAbcYoMO+hdbkYa02jDl5grY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Yt6xwfF1Qet2bwcWph9FuMYAjrtWrtPTQG8NnLtzBFZCKqeIRr9Y3ykFSZ+K1+CGqaMBG/UwUa3z3kNMIpXU6PAy7LzEh7bMsxeXdNKXVf2SgloBswdBFm4qrV0dY/ACDScHFxGblo/KjmiVXCkdKelMGntgfZzqoOmlyX2opDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P5Adi6+p; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6df2b2d1aso2389561276.1
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895620; x=1707500420; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3crcVTsghXsSywbMFzI5MYM02CM47kPTeW36cEIF42M=;
        b=P5Adi6+ptf2/V8ZnFrEt0z6JjKqWcc+V0RdNHKyyfd5npoAHgpHYWOCV7uObthl/8s
         NKH8UBv/xe8sWH9wVDeKQCYYwCT4pxANRyb5IptIR3thAPhH79LTVAviAyAuuzjlMVuI
         To9TXj6ldSAquMqmguHpy0ZVFz309mBfXn1kWU9Q1GpOEVLFPfYI05dFvzN16VsLwTyd
         bGuyUVchXd/OzcVbFzkg1GXqwJiBBlwrppEsbQBVjJszdSHpG3rF3PrSF53tKFxsD/G6
         Y/DfYxaYlSB2VLuBZhdQNAi+4mFOW35S5lHfA7oEvr90mrFkc+YaBxDqWuLNN9S9CYXV
         JJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895620; x=1707500420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3crcVTsghXsSywbMFzI5MYM02CM47kPTeW36cEIF42M=;
        b=BtRgnyUdgU7TFWEnTl/XSPlEkIrd8n33nJvtxKKrAyf4A50ZyQcCqaWRTo5w6GGCfH
         bwwlUpi+4DWA0IPsL/H1rxZPw4OvY36TKMAWg/Gi7x6GyaKGgLi82bdr84PoOGdFVoyk
         cGK1TCT8FJ7e6pkDV3yHaclojcOsi0BJquu42Xb9S4bRXROU8QmtbzLjgeLPJevXcL1I
         yAdrOy0/MSUwhkZ9ZGpqueYdbDd1ThGppf78wI4cEPVwp8N6uQQmMgGUTZjH5XAsTAg0
         ptyRphCdYPLMCIRE3lipPTl/Pp2hW2hyLkiRVxSfjr2d3zz7jnt9SSm/VYV5O4DOIlej
         eU3g==
X-Gm-Message-State: AOJu0YzHbipUwvDnumm9RgsF5t4TALEpvPcE2p0Kvzuvl8iNjTFHH21S
	NEb+TSJmg2C41AN/zJwLMvKJeW+ZCPU3YwtRVTf3dREfhKkKiq0K/zuG53iCMP4dFBxavLqFhw1
	e/HyIhoGFcA==
X-Google-Smtp-Source: AGHT+IGbbaU0RuBYhSwxu+02gIB1U2T4tb+107DZBAJDC8eJz3mf5Fazgi7I2/mnwRCx/5dBZmIWqM84tKNofA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:98d:b0:dc2:5273:53f9 with SMTP
 id bv13-20020a056902098d00b00dc2527353f9mr259794ybb.1.1706895620372; Fri, 02
 Feb 2024 09:40:20 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:54 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-10-edumazet@google.com>
Subject: [PATCH v2 net-next 09/16] vxlan: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair per netns
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/vxlan/vxlan_core.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 16106e088c6301d3aaa47dd73985107945735b6e..df664de4b2b6cc361363b804e7ad531d59e2cdfa 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -4846,23 +4846,25 @@ static void vxlan_destroy_tunnels(struct net *net, struct list_head *head)
 
 }
 
-static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
+static void __net_exit vxlan_exit_batch_rtnl(struct list_head *net_list,
+					     struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
-	unsigned int h;
 
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list) {
 		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
 
-		unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
+		__unregister_nexthop_notifier(net, &vn->nexthop_notifier_block);
+
+		vxlan_destroy_tunnels(net, dev_to_kill);
 	}
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list)
-		vxlan_destroy_tunnels(net, &list);
+}
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
+{
+	struct net *net;
+	unsigned int h;
 
 	list_for_each_entry(net, net_list, exit_list) {
 		struct vxlan_net *vn = net_generic(net, vxlan_net_id);
@@ -4875,6 +4877,7 @@ static void __net_exit vxlan_exit_batch_net(struct list_head *net_list)
 static struct pernet_operations vxlan_net_ops = {
 	.init = vxlan_init_net,
 	.exit_batch = vxlan_exit_batch_net,
+	.exit_batch_rtnl = vxlan_exit_batch_rtnl,
 	.id   = &vxlan_net_id,
 	.size = sizeof(struct vxlan_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


