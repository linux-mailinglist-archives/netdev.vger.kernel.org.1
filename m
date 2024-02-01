Return-Path: <netdev+bounces-68123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E90F845E31
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31C19B28C5D
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B290B15DBBF;
	Thu,  1 Feb 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B9FMTTnd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1980015D5BC
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807384; cv=none; b=qbyELHr/ZHavzvRkH85xQ/OxGUBxR886Bt+r4XlBvCHS/E2zZGmW6RdNEd46G6bTLu46popBDhNMSURi1lXU9ymfypk/nywXnp5FTQs6b/6/sNbsTCkhqHT5ozGISalbQyAKAXtrfUDNK3DHzO1TNXGUYSk0S+R0SX/efa8Bz9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807384; c=relaxed/simple;
	bh=4yrivkjWSb/hp+LKDR1ukpkhCL5E3cnxmn0j2+kh234=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PkgmOxzN+aFKbuxklay8ZieEVcsb81NMi89D+3dDmDg1DVfOGqtpl4ZtUMY8Q3OToCdv08NsX32ytlwVJAUnn+RP8vRzM9GZTjCOEMa9XUSB0/P3lGcuCtmLucKPLCGHqjc+UfhgHGHNHZbQtwEWFQDBqpnbqRn0oA0IfsZ6XGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B9FMTTnd; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6040ffa60ddso22744347b3.2
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807382; x=1707412182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6ve0QvbI2bLOC5KjisnhpPU7DG7UJ/BbP8jjLzCWyuo=;
        b=B9FMTTndwBriTxDp27QGYByjdwvxeE8o8vu2PWhPDyGPD9s4JBihIi7bpBHiFpX2EQ
         twhp2poImO/nmYucYdTHInwf2YD0MJWYg/OQARhw7YIbklqBPxBNYQDEyDu7h/4lmJBw
         29a8AllpVfDazlVAvL7vFKynjGonnguK4VMgO6QQJNRfxwCHVFic0CLAMzayPcmgDOS4
         QEoFq6wJaOx5f5skMagO5xwqs1vfEIaNv/0Ro077WlEdnn8UzbXCqg+6NkcRBK+pMvsQ
         75U65Ry+Nxxd1g0R/DPiqmNKXf1LR0urWazH20+TAbXxMuA+9FBONtBegq8t8iie4WRF
         ZuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807382; x=1707412182;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ve0QvbI2bLOC5KjisnhpPU7DG7UJ/BbP8jjLzCWyuo=;
        b=m2Ub+vLMjLvYyy+svptoEKgyxHyX1L5Ev0yF1rCJ0MvFZKBfvTe+w6ywfVEjxS1//D
         KmoHWcOkWBcoVtmyNrqdpKTQYyIHcHbbLef9wXujoG9lBF+FLG8+csVR9TkM73T2GzLk
         pT/qVqeaNY05WG79rdkV8BSlKkznPxpW1yX+yUw0UDcIQI7ZGNZS0CgIX9tkQL/Y4NcG
         zOKPkQFVJNV08kQcU+h4gB5cKQnFkk65p9eHxXTZ1Sif1heLxRAd36tSslNTaFDlL1Sq
         /84iAAVrfkg5gHut3JCeMwaL2rVL55K07OKsh1GvDVPjvUU502h+CFZU0GIaqsqvPYuf
         T8dw==
X-Gm-Message-State: AOJu0YwUAu39EIWIrRmznlG5kRayXY76eL2Os4Q6ZF8JSfEtNhpam1hS
	DQuewEu/Z1ofXYEp2XKuKd6nifN2G0LgqR6HV62KYd8Ay4mfwJJidDFrDUoaScG8y7okqX8Ydtg
	Vg8M3UHGsSg==
X-Google-Smtp-Source: AGHT+IFDIo+3BvI9sf8AnlV5t3MuckfpUIPKsYtUeB/0YfX0VvTULPW5aR87e8Qi1LpK4R5eRscy8ga38QRd2Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:39c:b0:5fc:d439:4936 with SMTP
 id bh28-20020a05690c039c00b005fcd4394936mr1204485ywb.8.1706807382098; Thu, 01
 Feb 2024 09:09:42 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:23 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-3-edumazet@google.com>
Subject: [PATCH net-next 02/16] nexthop: convert nexthop_net_exit_batch to
 exit_batch_rtnl method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held.

This saves one rtnl_lock()/rtnl_unlock() pair.

We also need to create nexthop_net_exit()
to make sure net->nexthop.devhash is not freed too soon,
otherwise we will not be able to unregister netdev
from exit_batch_rtnl() methods.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/nexthop.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index bbff68b5b5d4a1d835c9785fbe84f4cab32a1db0..7270a8631406c508eebf85c42eb29a5268d7d7cf 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3737,16 +3737,20 @@ void nexthop_res_grp_activity_update(struct net *net, u32 id, u16 num_buckets,
 }
 EXPORT_SYMBOL(nexthop_res_grp_activity_update);
 
-static void __net_exit nexthop_net_exit_batch(struct list_head *net_list)
+static void __net_exit nexthop_net_exit_batch_rtnl(struct list_head *net_list,
+						   struct list_head *dev_to_kill)
 {
 	struct net *net;
 
-	rtnl_lock();
-	list_for_each_entry(net, net_list, exit_list) {
+	ASSERT_RTNL();
+	list_for_each_entry(net, net_list, exit_list)
 		flush_all_nexthops(net);
-		kfree(net->nexthop.devhash);
-	}
-	rtnl_unlock();
+}
+
+static void __net_exit nexthop_net_exit(struct net *net)
+{
+	kfree(net->nexthop.devhash);
+	net->nexthop.devhash = NULL;
 }
 
 static int __net_init nexthop_net_init(struct net *net)
@@ -3764,7 +3768,8 @@ static int __net_init nexthop_net_init(struct net *net)
 
 static struct pernet_operations nexthop_net_ops = {
 	.init = nexthop_net_init,
-	.exit_batch = nexthop_net_exit_batch,
+	.exit = nexthop_net_exit,
+	.exit_batch_rtnl = nexthop_net_exit_batch_rtnl,
 };
 
 static int __init nexthop_init(void)
-- 
2.43.0.429.g432eaa2c6b-goog


