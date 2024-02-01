Return-Path: <netdev+bounces-68136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D89845E36
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4AC6294A29
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB6C161B5F;
	Thu,  1 Feb 2024 17:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VQh1NXce"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248477A00
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807402; cv=none; b=U7fo12sjx/byAczWy62I7qZgu+Cwbeqv/Hntt4T0wsRstwPI7Qg/ce6Mu0azDddoRpHqmRD4sW5ekfsieQ+4HqZSzvp3T3xJQl8OOT1kw8EUF5t2wgQYmAlU0XhiBtyyVE6GL01P0DJrAdW+ROXSFNau5ciDXKwHXpT2UC9MJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807402; c=relaxed/simple;
	bh=Cq9PcObZdqosdaesc4ujaDFLK2u1ADvFxZIUhiyCqeU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kxUTDEBPMIWHbr6a3HLUtv+dtEYSvAnW4BaU3YADSAdcEpmiUQYZFI89KQg2DfMtbpyXwMPmlxmviU90QoHll/i8uluAaKi19BdiOCaFl/s3GvAKdXHk/TBjsilBdAQpiMIgQ9G8VaU3aV682olNfOZ0Q5BieKR4G/SgVkOY//c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VQh1NXce; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6040aaa4e79so18890577b3.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807400; x=1707412200; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QC0vfFxLW0KGWFrcZH0YSELGCgQ0d41lb4ijkHsusSU=;
        b=VQh1NXce8uDYgaElkF/wcE1dcO007KvBBM70nSBz52QDV135jlNauCraaC2c1R2PDa
         Yv1MQa5PWCQZOq7h9L/TaFKdnHPGvtxTDqSmdTSk/p0OjKwoM+aO/xZFCBJ3bzGuQ8sC
         X72QraVbHcpiV3hx4BEnQ+HtKovJAOJJywdVGqklr20ISTq2UmlWJr0bTLW9RUWPO2rX
         z99zF4TuTMoOEZa2vJwSYvR82Q6O5gXhEXMQynIUSEpjOjCm+RnldMOzYN38a8K9A1FB
         mwS5TTXq3+35rfEqpoXJ64eBA6obkoXJBw6VWWgMWwAajivfAm0qTrQfLxp9vJyv3HE8
         lrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807400; x=1707412200;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QC0vfFxLW0KGWFrcZH0YSELGCgQ0d41lb4ijkHsusSU=;
        b=JcNeNaUn87LoN/PCrxhox+aSWctQkzPRapoWD1coVxr8nrAPziOZWkG2N+3DxEaqeP
         WTw6F7gqlVlyvEp1Te2A/i4sBo2OB2TOq6+gVaVKLBpjH7bji5+TJ+xKY5RwRcxssoxx
         vaUttY5HzZN805SbMzMWRC7EH1wn0VRRtr+0d72Tn99nm7KyTAlPIXfhBDSgOgGQFdrs
         y5lnsqKCk18mBklnB/Fg9Oztmb/lhNXMYOJBJEhm4nJNUtKGrveMis++4YQBkLHOj0jA
         Z2KE6s6pKCcdT/UIRAF7rizL/XnT2AOl6Hn3/q/4/0DfS92lpXIoKO+ZfVGIavvetFNh
         SEaA==
X-Gm-Message-State: AOJu0Yydvq64E3nboOCFQNjNGxSU7z0LBqE5zmk9homDFEVjW1nOznxk
	lkt8ysUA3llZ+vFPAqQrb3ER/LCYB7Wy/pfsrwNF6ml59S/M1zxqp9/CQvtDRGgy4NOaFcjGs4w
	uPqBK2CQmvA==
X-Google-Smtp-Source: AGHT+IGVIZLIKrgl/q5iR6pmG8/9CoKwRkCdKZis1Baaa9eIOX6MHcFedxPwlu9WJerIeGCE8lFAe9p69BZcRg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:d89:b0:5ff:a17b:34d with SMTP id
 da9-20020a05690c0d8900b005ffa17b034dmr883602ywb.8.1706807400046; Thu, 01 Feb
 2024 09:10:00 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:36 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-16-edumazet@google.com>
Subject: [PATCH net-next 15/16] bridge: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair per netns
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bridge/br.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index ac19b797dbece972f236211b9b286c298315df25..2cab878e0a39c99c10952be7d5c732a40c754655 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -356,26 +356,21 @@ void br_opt_toggle(struct net_bridge *br, enum net_bridge_opts opt, bool on)
 		clear_bit(opt, &br->options);
 }
 
-static void __net_exit br_net_exit_batch(struct list_head *net_list)
+static void __net_exit br_net_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
 	struct net_device *dev;
 	struct net *net;
-	LIST_HEAD(list);
-
-	rtnl_lock();
 
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list)
 		for_each_netdev(net, dev)
 			if (netif_is_bridge_master(dev))
-				br_dev_delete(dev, &list);
-
-	unregister_netdevice_many(&list);
-
-	rtnl_unlock();
+				br_dev_delete(dev, dev_to_kill);
 }
 
 static struct pernet_operations br_net_ops = {
-	.exit_batch	= br_net_exit_batch,
+	.exit_batch_rtnl = br_net_exit_batch_rtnl,
 };
 
 static const struct stp_proto br_stp_proto = {
-- 
2.43.0.429.g432eaa2c6b-goog


