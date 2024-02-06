Return-Path: <netdev+bounces-69512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B22D984B82C
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:44:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E51AD1C22E82
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA6813329A;
	Tue,  6 Feb 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKB2GxfB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B4C131E44
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230609; cv=none; b=giHJUEyaWW63eR3bmr/qmIwrcNK6HSADjmNeZcZSYFRb2mIa3Ap+SqwiL4owA1ooy6MS2/SQY0wSUGteQo3UQm57pLbN+AiOpEAZdCVQfVadIt65ZxJY4oF1JYMvE8UZvCfc08FMY+pOkw1eUcVTeTFpKR2dHLnw66zblV9KyRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230609; c=relaxed/simple;
	bh=XBnCSfolVTj/02HZWEPxvE0AbUAjK7SADaTDmb76y/Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EW82Mr6PvE40YvfD9KJlqbL+KK7uStZ//9XQjoDWrxFwN3XkBUj868RYtVNojZqTgmlJ0YkI6Bk8XDeSBBJzpRqmmtOcQYHT/UmnsxbwwXyUkgs+jhatPfSPoelot0dFBBsITU2z2gFRTObdZcIm/Ik4SgQ0fPFqiTwHnb2j6Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YKB2GxfB; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6040a34c24bso15206387b3.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230607; x=1707835407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xfUhmHF5a8CyJYd72BQ6v1H7YkRoq0buO2KpJJPPmNo=;
        b=YKB2GxfBDVNKfPVK24l/+RplzSctuRrSFFFCK1I7KmO7d2UPllqiHJ5s2cAiApbqHA
         rUSzArJ27NWgBMsc8BJQVmty+47kkfL5VfnwCf9mdO12iWJJ1NrV0wpvDdwO0pU+P/Ee
         HqiZDspY5CjC89skNvjLd0F8BfOL3LfvGHQ3Qs+1vypj/2eH/nOEtCKM2nMEG0PKoxtF
         bd47jKHh2Hu9O/a6C/PAc46DLJqeHdPcnWNSOULZ+L2Faf51D+WaT0fHYaLBKWoUaTeT
         55O2IIwcLvWoDEwKxHoIjEPymLKFa0Z0V5AerAq0PDZ0ji26Dr/6M4qmbJxB6Zx/WqH9
         errw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230607; x=1707835407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xfUhmHF5a8CyJYd72BQ6v1H7YkRoq0buO2KpJJPPmNo=;
        b=FvnQbMbu1sFvu4Ucni6REN7eOiaQipAgcivLD+RHoRplLAtyNLQj7zVS5u+bqYH1Zu
         ZxgbTI0HmJOFqWmhYsqs/4mgRgTciRDfm9vXPTWNeX/FHxAIaENU5uRQH6aWEePnpsnV
         Nre99Py0TpM0TX8sodylbievR2LVxqPN/jnwsBNEoiUBwX7xDNoVohrcSBjfGtDfNxUO
         KUpXm/KNXzD6Y2KtSM7jtlhb24+9vd3pAfY/e8oZtjV1N9qRmf0KjSVfalTkhkbmNbRL
         /WjPy/9m9QRyohecDk6yrphtOP047iz5mNIFu1+bLrVbnROpL/a0tMNJowtgryMrZ9ON
         956Q==
X-Gm-Message-State: AOJu0YxJ2FjkiK/ROmiBsQ4hVMvtttpzjGM4NPgaHdt0MalgKl4iaj8g
	OB8cn8VUpLyeBGplEGTQSejEOnHfP/1aalnXmDwkb35riSnExrX/Zbv3+QmU6MYR7iDSp/EZjIE
	hYXud55fI1w==
X-Google-Smtp-Source: AGHT+IFe/37Z9E5X3kRocKx7kthELa9IVY6+T1e6ObazpPd08eYTAehr3F8fxbp93brNDOhcai3vXEpNBGrOJw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b06:b0:dc2:3247:89d5 with SMTP
 id eh6-20020a0569021b0600b00dc2324789d5mr54808ybb.4.1707230607156; Tue, 06
 Feb 2024 06:43:27 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:02 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-7-edumazet@google.com>
Subject: [PATCH v4 net-next 05/15] geneve: use exit_batch_rtnl() method
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

Note: it should be possible to remove the synchronize_net()
call from geneve_sock_release() in a future patch.

v4: move WARN_ON_ONCE(!list_empty(&gn->sock_list))
   into geneve_exit_net(), after devices have been unregistered.
   (Antoine Tenart feedback)

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Antoine Tenart <atenart@kernel.org>
---
 drivers/net/geneve.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 32c51c244153bd760b9f58001906c04c8b0f37ff..23e97c2e4f6fcb90a8bbb117d7520397f560f15f 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -1900,29 +1900,26 @@ static void geneve_destroy_tunnels(struct net *net, struct list_head *head)
 	}
 }
 
-static void __net_exit geneve_exit_batch_net(struct list_head *net_list)
+static void __net_exit geneve_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list)
-		geneve_destroy_tunnels(net, &list);
-
-	/* unregister the devices gathered above */
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		geneve_destroy_tunnels(net, dev_to_kill);
+}
 
-	list_for_each_entry(net, net_list, exit_list) {
-		const struct geneve_net *gn = net_generic(net, geneve_net_id);
+static void __net_exit geneve_exit_net(struct net *net)
+{
+	const struct geneve_net *gn = net_generic(net, geneve_net_id);
 
-		WARN_ON_ONCE(!list_empty(&gn->sock_list));
-	}
+	WARN_ON_ONCE(!list_empty(&gn->sock_list));
 }
 
 static struct pernet_operations geneve_net_ops = {
 	.init = geneve_init_net,
-	.exit_batch = geneve_exit_batch_net,
+	.exit_batch_rtnl = geneve_exit_batch_rtnl,
+	.exit = geneve_exit_net,
 	.id   = &geneve_net_id,
 	.size = sizeof(struct geneve_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


