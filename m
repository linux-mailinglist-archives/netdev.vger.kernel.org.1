Return-Path: <netdev+bounces-68616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22755847658
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 18:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B068E1F27CFA
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 17:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D17F14C5AB;
	Fri,  2 Feb 2024 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ikEKMP4l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB1914C59E
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706895614; cv=none; b=nYRuKxHMQpom9uLVQ3YYlF/3hXhw4AR8IoYU4ojEzuELCijh1qVdPtIBngPz8cVnf8d0N34qdY9tPefNuFYo2Rb1HplQbu909ALmSdMhlGJlFFbqfXqzwDZ9kdz4F4V4uFkqxy/HPCSrVe0mCWESpRVqD5uMUgZHlOndpRxIPwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706895614; c=relaxed/simple;
	bh=xb+Yntnpma5b5FD59MjrMsXtgS1nVOU+euoCiWrnlS4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TI/Pp2a7mFnhFL+zb67RX/+gnO+CPTV+XRHC41un/DvMZoD+Wnbb8yjAHrzc8lMkv1jIAQIhKUzU7ai3U6KKvta0mQy6L+JspKauenXZmKrBZLUAa3+iMvQiE4bfazW/8oEwNS+aDAPisDFTrgGKgq7vGY0aS5CTr5IKj8z6eTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ikEKMP4l; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6cd00633dso3289712276.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 09:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706895612; x=1707500412; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PRDD1b2WfbhGvwvQZ+N0AOi68liJv0jrT1neOpHo8AM=;
        b=ikEKMP4lMMRBVPwp5WwSGHQ0sMxBZ0MUyDRB61WB8MmyVIr3d2ssYDL1jNn2GVrI93
         G2GZLAOqAf01B8Uk6RZ8lzCVdtFMLg5tPtox+L0R679EKn4c1+L42izHvZfM69B/k/qQ
         Xqv6Cs7HeOvALniyXrRhIoksSViQmm+Ysw4uAsIIKSLJoQ/nPdz+Qiynk5rgE9Qq8SnL
         VdRN9526rwRKCZf0UFbvzKV4nUiPna6ztyqF2dMj8mFQhEs46QOO93jLR/6wGUGkJVAu
         TqRT5ordFzUks7uSLQWC8ul4OuB24s01YYI7tewPsj+MP3+5tUypvPCpkM9sJUOH4gV1
         CPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706895612; x=1707500412;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PRDD1b2WfbhGvwvQZ+N0AOi68liJv0jrT1neOpHo8AM=;
        b=l5TYw+rb/aSFSXLzuqhrY4JKgZn36BVd6aKIihICn61qSVN1b7Iup6tIeJoGYjrelk
         YFxXUwbcYRoOLCe/RFTzVBl6N+5Mz+a+/096S2fbKGbivVz/+u0OPMMuLKuMvvuRHj8e
         1kN6m5Etpof5Uuzmxan7DebTDGtNjfVOszNxbBCaD0oW6GJmnF9vs3CmDLDwJ+t1e5tp
         OjQAgn9COiaHR5exMeXqzrb1RNrdTmqVky5C50ijcXREh2CFyeFCSFKF7h/RvnY2yyhl
         dAVdsC1Fg9veRXtQgwdgfrv4nTOGx5CqMge2UZ+dNdArjx6FayW6JFPzcT7XeaUL9Gtc
         BZZA==
X-Gm-Message-State: AOJu0Yxn0DZ07IcjsiLSh9p/Nn5u79IhHHJUPrdouF+8tnkSXoN3flsM
	aexcZovaaDTmWAijWpnvontV4n+sgI3rb08cPEm3x9hPkI7thPLiVEoHDC6JrKIw4pjqhe0HW9/
	BdZytI0agZA==
X-Google-Smtp-Source: AGHT+IGDORsP7aunfYWHEdc7kiRIn6aSTbZ6A7LRz7pMwbKvzGQkgA2X6X2fbElzKftWXx4IG2rUaplRGEiwDA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:e13:b0:dc6:b768:2994 with SMTP
 id df19-20020a0569020e1300b00dc6b7682994mr299139ybb.0.1706895611839; Fri, 02
 Feb 2024 09:40:11 -0800 (PST)
Date: Fri,  2 Feb 2024 17:39:48 +0000
In-Reply-To: <20240202174001.3328528-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202174001.3328528-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240202174001.3328528-4-edumazet@google.com>
Subject: [PATCH v2 net-next 03/16] net: convert default_device_exit_batch() to
 exit_batch_rtnl method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair,
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/dev.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b53b9c94de4008aa7e808d58618675425aff0f4c..86107a9c9dd09d5590578923018be56065fbd58c 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11596,7 +11596,8 @@ static void __net_exit default_device_exit_net(struct net *net)
 	}
 }
 
-static void __net_exit default_device_exit_batch(struct list_head *net_list)
+static void __net_exit default_device_exit_batch_rtnl(struct list_head *net_list,
+						      struct list_head *dev_kill_list)
 {
 	/* At exit all network devices most be removed from a network
 	 * namespace.  Do this in the reverse order of registration.
@@ -11605,9 +11606,7 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	 */
 	struct net_device *dev;
 	struct net *net;
-	LIST_HEAD(dev_kill_list);
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list) {
 		default_device_exit_net(net);
 		cond_resched();
@@ -11616,17 +11615,15 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	list_for_each_entry(net, net_list, exit_list) {
 		for_each_netdev_reverse(net, dev) {
 			if (dev->rtnl_link_ops && dev->rtnl_link_ops->dellink)
-				dev->rtnl_link_ops->dellink(dev, &dev_kill_list);
+				dev->rtnl_link_ops->dellink(dev, dev_kill_list);
 			else
-				unregister_netdevice_queue(dev, &dev_kill_list);
+				unregister_netdevice_queue(dev, dev_kill_list);
 		}
 	}
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 }
 
 static struct pernet_operations __net_initdata default_device_ops = {
-	.exit_batch = default_device_exit_batch,
+	.exit_batch_rtnl = default_device_exit_batch_rtnl,
 };
 
 static void __init net_dev_struct_check(void)
-- 
2.43.0.594.gd9cf4e227d-goog


