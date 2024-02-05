Return-Path: <netdev+bounces-69121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01706849B00
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1970F1C22320
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 12:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3EFA2C1AF;
	Mon,  5 Feb 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="etwZBtdM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAB92C18D
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 12:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137286; cv=none; b=Q0jOh/l0MJIrRiF9HG3FcEBzvz5lp1wxtVCO/DqEEcdq6c9L9DmP1Ufc1ecRv7dnU+N9U0V73z2GDsccnM/RbQAVI566yQTaNmmwo/pHYd/Y2zELtTut3+4ajtspiex7tFmqRhSYgp/Uaz5RBOPVLYx9MZRJ02g2wbcVDCERegQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137286; c=relaxed/simple;
	bh=ayxOrI72K6/MWZME44DpehPtpq+P0Zcwx9RlGIOMnUw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jWRQvnS1qdOCMJ795ss19GJJXMt2nODmeGTecyXjxzXJsvi+bUIecdhAGNG93Siz6bwTPRY2gBhwaxUIifSKogNsTVT4bXCldsDt0ezsJGPngIpWePXqNg2zI/pyMjEn/ZO2uCwhqJssSlhY0LeU99fq3Dtll6OfzJ8j6CkMfKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=etwZBtdM; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso6138293276.1
        for <netdev@vger.kernel.org>; Mon, 05 Feb 2024 04:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707137284; x=1707742084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BFeVsJGz6LUPJVJRWx6DWARi15RK/k8eAVyBBsCykA=;
        b=etwZBtdM6btEnxCqhjXA1Mwev7u1tv8bPRfNplFkDQxJp4Tk5apuMA3P3XPFXAiJ0v
         F3QUI1G891U8JgM9w5Fc4lT9iK84OtgcpmSSvpN6iBYDPyOAa67kfLbGt4Y6IdWETEIS
         1Xy/gv3f8GcTDdUW9lMW8hxpNUY/rf32Ka6o1JJ0wvOxwFm+bDl2S8br3xnnQhujng6P
         9LLEigeGqSUwMoDpePsv8xpXNyj8pXjxeAfKZXbppkcIkBGeirVMDDOhXN13X29i0JSR
         zpPXPfSdiWjRXq+qpBUMbqGD60JzRKJyH+6yhkknp1IG3VT/ZlbA+YzJVYmSRR4m3bJu
         dMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707137284; x=1707742084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7BFeVsJGz6LUPJVJRWx6DWARi15RK/k8eAVyBBsCykA=;
        b=nLEHK0rYkrqvUdL8LN7Ak4AkUgDSP5YQb3SnmF7CUvqLyE2aacNAAhq8oDd8216ADT
         pPmX40QxokIHKCTixucYQGplBnmYknYBc4NdGiF6jU4tXcpYH/KDwitNff9x+yJ0UED3
         sQe4S4+vqu/d2jxDn7Lc0iSgVvct/knQOGpAu6Ajo+RNdHzHkgRUZ0Lg7gsomrfYHVHj
         mlaqq4cZrchlmTaJhwO9s7Lr63qTRScUobNORTO1ci9o6kVMC8oimq0B1bucK/qRcXhD
         DQkI6a6TTOrdqgDxGH9mRi9JsspdNhCyCpOLjg3ujwlfZNMN+KETIT6PUP/QWmk1PDXH
         sf2Q==
X-Gm-Message-State: AOJu0Yw3VrBO9lk3D/sAc4wX8Wnldq6oE/M1BOVUQKx4R4VcRJAMYFIN
	Bjhu2QN1fUUCkU6OPxMzXgRXNvHrchuFfydQg2qDjCDi8TNL/THOlRvs7LnElUChQxCLCaEhNep
	Ed0gFj3f3Yg==
X-Google-Smtp-Source: AGHT+IHPTIKKoiyW8/Aorblau7c3jMn9ZcfoQYd5xooqq22ikN6FxOj0DKF+TOeueBSaW1mZOb3CEvvMYvvTtg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:230d:b0:dc6:e077:18ff with SMTP
 id do13-20020a056902230d00b00dc6e07718ffmr413746ybb.1.1707137284314; Mon, 05
 Feb 2024 04:48:04 -0800 (PST)
Date: Mon,  5 Feb 2024 12:47:40 +0000
In-Reply-To: <20240205124752.811108-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205124752.811108-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240205124752.811108-4-edumazet@google.com>
Subject: [PATCH v3 net-next 03/15] bareudp: use exit_batch_rtnl() method
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
 drivers/net/bareudp.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bareudp.c b/drivers/net/bareudp.c
index 31377bb1cc97cba08e02dc7d48761068627af3fb..4db6122c9b43032a36b98916bb4390e3d6f08f68 100644
--- a/drivers/net/bareudp.c
+++ b/drivers/net/bareudp.c
@@ -760,23 +760,18 @@ static void bareudp_destroy_tunnels(struct net *net, struct list_head *head)
 		unregister_netdevice_queue(bareudp->dev, head);
 }
 
-static void __net_exit bareudp_exit_batch_net(struct list_head *net_list)
+static void __net_exit bareudp_exit_batch_rtnl(struct list_head *net_list,
+					       struct list_head *dev_kill_list)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list)
-		bareudp_destroy_tunnels(net, &list);
-
-	/* unregister the devices gathered above */
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		bareudp_destroy_tunnels(net, dev_kill_list);
 }
 
 static struct pernet_operations bareudp_net_ops = {
 	.init = bareudp_init_net,
-	.exit_batch = bareudp_exit_batch_net,
+	.exit_batch_rtnl = bareudp_exit_batch_rtnl,
 	.id   = &bareudp_net_id,
 	.size = sizeof(struct bareudp_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


