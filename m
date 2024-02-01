Return-Path: <netdev+bounces-68126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88636845E2D
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E097B29A18
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862415F315;
	Thu,  1 Feb 2024 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gih1VRv3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13CA15DBD9
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807388; cv=none; b=Lka3alvWjavPB7evl2g4pNAIyfHGyMSyKpRtes+T4CfzkqO68MDeETd9iY9gzY8RlrFNHcIphYzrYfLeTt7l9e5zLOrPv1tzGGstLbRFKucEwH7F3s24mGbOJcGfr3O3scxIIJpnRXOWpYjtufw7GzI5A62JU2RoeOpArSG/XZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807388; c=relaxed/simple;
	bh=2IjWj5gc704KgFLhJvsBP6MeK3+tfEG+6Fy/lxkQj5I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j4U92Y6OezSW0CvR/s25rn9DUMnuCQwO1yGemNvuHlSI3ciPmbBwGG95o+xs7PQWP18Bt/KmqXsaDAHa5C92OdlhalUPw7t7woPg5W3zupnEke4QDN69NqHy7ZDcv1QBEZZlMTSbjADUleBcfss4h3duC9XmTT79eMVOV70D2oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gih1VRv3; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26845cdso2022470276.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807386; x=1707412186; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AlogTDx9JVj0q6XkK5TUp+YTwNQ9LKK+FD0uPTdeY8E=;
        b=Gih1VRv33ZhWNuEVBrYflzvQqdWqCpH23BCb5oX/vox5KpHYxTyCJ672VUm056UNeL
         JUlhk7SEe3oVCBnu9z6Q1RCS1HKmV/LbZGPwgwxKjHIOJajAKqOYUpyFm+gnlqaFtkTF
         MYPuwqum+emlp0likV3C3vvfXV2/HrDz/V3akaX4wIAUiiB2dr8RdzGaUxOZgZ7Kn4wa
         6R8T4p9VCpZytJVRXN5sUGdqQZDvVm57X7XSoTW1GdkDtfUU+HW+HKZM4OQxNDtLgaGn
         JQDWOSdKmiXIu58tzDA+VWjTJ4LGZGUdup2mcDGckJwM/zleYhMW2Y6ObA8zFFbFlmwe
         vGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807386; x=1707412186;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlogTDx9JVj0q6XkK5TUp+YTwNQ9LKK+FD0uPTdeY8E=;
        b=G9moxog2aKNo2UZLOJIMvjoZkqnG6prjkSqiBZIWF6BeGU+6HMm46g7ugfsaeZ8oSG
         hNcyX3XexBfTQYsfUoD1Lasl+E95kYVCiRLI3m8Tz8SJk0oKb+QPrPihyu0/7fiGpQtU
         ZvXoon13m8/rLAr6y12vwpBZJcKe1tfyQFUZbC1E3YM6UuKHTgUE3qZbWMsYl09o9D4M
         lEKhDBZPCFfcVS9zt61fPF28hofTa+iVPc9nYF1CNbNJcVogkaFQIka/1kvHAkvR01+c
         4G5wxHZNCnoKBvoow7iJ/SActXK8Bo/MCGOAAbWXm6NPJbqJlXiIrkgddFgcnXR/oNZZ
         tGeQ==
X-Gm-Message-State: AOJu0YzrsFl9FlH1w8GN4+0a0CAWwjcBZ/ssHNRbfsTJcHwTkidCRW6H
	8uLQc9tSCfddfvZHBsdj5nRzBuMxPYqV6s8VF0liV6dpPGBLK4blEkKyDgTEbijlf7gANeMPVAb
	0QVo3eaxScg==
X-Google-Smtp-Source: AGHT+IFzOhU/CupJS32HBFgsQZDxnzUcDmYmgP1XGczLg0XwPOxOncNp3Oxx023UlCdg9OCi+Sz9ARQZuINFyA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:e13:b0:dbd:b165:441 with SMTP id
 df19-20020a0569020e1300b00dbdb1650441mr1361074ybb.0.1706807385893; Thu, 01
 Feb 2024 09:09:45 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:26 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-6-edumazet@google.com>
Subject: [PATCH net-next 05/16] bonding: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair,
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/bonding/bond_main.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 4e0600c7b050f21c82a8862e224bb055e95d5039..181da7ea389312d7c851ca51c35b871c07144b6b 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -6419,34 +6419,34 @@ static void __net_exit bond_net_exit_batch(struct list_head *net_list)
 {
 	struct bond_net *bn;
 	struct net *net;
-	LIST_HEAD(list);
 
 	list_for_each_entry(net, net_list, exit_list) {
 		bn = net_generic(net, bond_net_id);
 		bond_destroy_sysfs(bn);
+		bond_destroy_proc_dir(bn);
 	}
+}
+
+static void __net_exit bond_net_exit_batch_rtnl(struct list_head *net_list,
+						struct list_head *dev_kill_list)
+{
+	struct bond_net *bn;
+	struct net *net;
 
 	/* Kill off any bonds created after unregistering bond rtnl ops */
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list) {
 		struct bonding *bond, *tmp_bond;
 
 		bn = net_generic(net, bond_net_id);
 		list_for_each_entry_safe(bond, tmp_bond, &bn->dev_list, bond_list)
-			unregister_netdevice_queue(bond->dev, &list);
-	}
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
-
-	list_for_each_entry(net, net_list, exit_list) {
-		bn = net_generic(net, bond_net_id);
-		bond_destroy_proc_dir(bn);
+			unregister_netdevice_queue(bond->dev, dev_kill_list);
 	}
 }
 
 static struct pernet_operations bond_net_ops = {
 	.init = bond_net_init,
 	.exit_batch = bond_net_exit_batch,
+	.exit_batch_rtnl = bond_net_exit_batch_rtnl,
 	.id   = &bond_net_id,
 	.size = sizeof(struct bond_net),
 };
-- 
2.43.0.429.g432eaa2c6b-goog


