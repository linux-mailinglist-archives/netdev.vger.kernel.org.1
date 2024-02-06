Return-Path: <netdev+bounces-69513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F076F84B82D
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F99B1C22FE3
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DEF131E44;
	Tue,  6 Feb 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ATezVZ/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83ED13329B
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230611; cv=none; b=dx1iweFhVaB1Kr7CTqUsKlhHS96e77FDuP617TEYagav7elNPmZkStOHLFc7B3qhE/iJZIeMdLFdavTPV3b/bC8B7xI56cNDr2QoARkTJXIln3KkO0/iJXL31rRdN8QpNaCU/hqOpX8iHkL38A23qw20JeUwtYZXkjpcvMU02t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230611; c=relaxed/simple;
	bh=D4zdKYgEI8SANhLoeqnPAi4IZHnljQAAsNLd75I1ZM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uzj4xAFiQhVi8/PLR8KozHSLGEqM0HnVThV9DKgNuRoBTA2BK2i0IZiwcbpz7cT+hwxY5Jd66r76a8AprL/2ehFdUUvdHb+/1fWNJBsBVIaHapXATr6cMDToynhzVwplPqE6efNpNWHVTrQIIoLHIBOwhM52qLKtl+Kc3VXxQxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ATezVZ/v; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6041bb56dbfso80646007b3.2
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230609; x=1707835409; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KyZCd8Hb1FDN7k6tGmc5xiWirDlutdqrradrH80psE0=;
        b=ATezVZ/v6yqDVKeGALgr38TAnrvaya/crVmWixCjih9AU1xccT2Ydb/rq90b/eusN9
         4+9esJe2qoCqkHChO1b39f31LxfLuRqgiQpbt8oWH/Vxjzrox5QdUMDLJ8k2ircogywW
         SeEXh6Q5414JeSQQqm5/UkRR62/yUOhs3jaq8KRgIyCWMxoOk0/EfqY3R78eVPOGGnRn
         5D6yUBob3WeiidUsd3Ba96A1SEnQPJ4iksAIOauFEoEh+mvl2gQCM/L64p/1ho69ANLx
         ZSshwICbZqZ5equulPP8+RhXxW1a9D0GpVJPetcJUjJyr1ivhdDTKNcrei65w4DuldM+
         vj8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230609; x=1707835409;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KyZCd8Hb1FDN7k6tGmc5xiWirDlutdqrradrH80psE0=;
        b=j0D091TxuqnLVigTUEZ0Tqx+X948vfN07f1bxSTAEAfRbLu9kiF/I3tZq3APM/hVEC
         HaUup20GxaZOkaXZ/tStsrKOOoZzDVxDsizgXQNHKNGWB99LxqOVJ/Zku8vUc0jr+gwZ
         ycMDap9yBDEf7FdJp4H6LzYR/+vDTMpG6lXFja0eYUu+ncdpbCBtjs4YPIttqt26KzAm
         F3jpKDM1/Kuvc+bnBgDYR+9TVF+q9Gny7cVmOp95ABxb/MmW3ya0Jq/ok9WmEp2AZJ9h
         LfShscsOnf2BsHf4kcwPkcNcSHNT7ANm0dMeElFOxYdtpqlErEq6QdtQcM3kg0QUfBUW
         NhtA==
X-Gm-Message-State: AOJu0YyS8S2UQWMjc1L3I7m8S7/80Mm2CG3aQTI+z2cT7fXsP6jqnufm
	IojkwLqyBWWMenANXG4RskULdJwlljadCcxF9pXxXwk4VbThXnOxN9g+gaxZEr4PyR2Cn3kM/c3
	wgdyttSmRDg==
X-Google-Smtp-Source: AGHT+IECvOkbqZ+kspjK/dAO5J9bMNifgBdFJktHTiNTSO5crk7nDYby8SFPWkQvz1Bt/eUugR7ipLc7JfC8bQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:2489:b0:dbe:30cd:8fcb with SMTP
 id ds9-20020a056902248900b00dbe30cd8fcbmr48714ybb.0.1707230608871; Tue, 06
 Feb 2024 06:43:28 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:03 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-8-edumazet@google.com>
Subject: [PATCH v4 net-next 06/15] gtp: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair per netns
and one unregister_netdevice_many() call per netns.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/gtp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index b1919278e931f4e9fb6b2d2ec2feb2193b2cda61..62c601d9f7528d456dc6695814bf01a4d756d2da 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1876,23 +1876,23 @@ static int __net_init gtp_net_init(struct net *net)
 	return 0;
 }
 
-static void __net_exit gtp_net_exit(struct net *net)
+static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
+					       struct list_head *dev_to_kill)
 {
-	struct gtp_net *gn = net_generic(net, gtp_net_id);
-	struct gtp_dev *gtp;
-	LIST_HEAD(list);
+	struct net *net;
 
-	rtnl_lock();
-	list_for_each_entry(gtp, &gn->gtp_dev_list, list)
-		gtp_dellink(gtp->dev, &list);
+	list_for_each_entry(net, net_list, exit_list) {
+		struct gtp_net *gn = net_generic(net, gtp_net_id);
+		struct gtp_dev *gtp;
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		list_for_each_entry(gtp, &gn->gtp_dev_list, list)
+			gtp_dellink(gtp->dev, dev_to_kill);
+	}
 }
 
 static struct pernet_operations gtp_net_ops = {
 	.init	= gtp_net_init,
-	.exit	= gtp_net_exit,
+	.exit_batch_rtnl = gtp_net_exit_batch_rtnl,
 	.id	= &gtp_net_id,
 	.size	= sizeof(struct gtp_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


