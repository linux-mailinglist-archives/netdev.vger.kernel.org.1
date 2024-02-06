Return-Path: <netdev+bounces-69514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D67B84B82E
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA6D2286E85
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62EF8131E53;
	Tue,  6 Feb 2024 14:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCb5TiQt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A11332B0
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230613; cv=none; b=R4bW2O5EUQU9EgDGwlL/IPLMwJZEUekCZADM8M7ZrESEcBMCJf+1JxYm5V04IxCdJwSFfhNC4kdvZl0ntlIb63R0k8sdjgAhwGbNUeX3FTUUg59qkuYiEFazZYFUdMD28LLBneY6yCyAxGaOkLY4fA3NdvWo49QnKoxm6CFigsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230613; c=relaxed/simple;
	bh=vieDUHajw9g9bI48TCXDZok68ePYZRrGPwH2sUEDu2c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pUQmPoCJ2WdUA12Ouk6khGS9WJxtNEV9IzqshvuRiJjt0Tj8ICao1glXVMfeHnVrOnJSKREQczq61g8qtlNq9V43I/oR6+tXDxGtpKAoD2HoNQ7nWNhZFukmXCZd1yvDDlgOMQ9N0Y+CfAOK8gTzki7qng0QSQ/4XryknQTw+O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WCb5TiQt; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so1205010276.2
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230611; x=1707835411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vwMkZajDKB3tGfY3+yic7STHRhzWz7YpyyPaMIumdYU=;
        b=WCb5TiQthnmcd84q05+p6pQOdRVTmIMMdm/Clp8mCJgOMLaw2CXrcnG+d+teXJhbhP
         cMnup9GPvVC3Q+rFIQqtB2E65jX8SmdQp/CjB5mdmumq2ikVcV8WcjfDOKNUJIXerOcU
         QDNVo+Qqp9m1zkAKgSCPElL7Rq4jSbmeZ2PCgU8/OUt+OQs5tiR54xFg6FftxeQBBspP
         P8EDr+RoXAOlIFVVe3ed9vRL9FjB4qWZxqOy0HBID1zgEdW4tr3IoatBxJ6o73h7V4mN
         qVE4gu29ks/hj69az7wkwGsFfZoMlHXcUF7uaszSpLx4rlFe+k13WtNLRaRAH8+7PIje
         H07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230611; x=1707835411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwMkZajDKB3tGfY3+yic7STHRhzWz7YpyyPaMIumdYU=;
        b=NvmPm/Eyri45aHMCPz7t8lLZbh5r/4R42Dy6+xZRP+mqEPxidBN3MCGQcIR0M389wK
         sBACsABo5gvoryiGPGBdciBDL5iVl/W88/LDALhlc1+Vx+G8LArwYVeXugbpRXkNjeBf
         sIeorlWvs+fDSAh/FMFLZCpIBlpXCyTdF/jqE6SUZVnWeJzUndPVRaNAdzE1SBccY76J
         6E7L3pa+9FqErnVAskzl1mToexWd/gYI++JWQEY4s1mocFPZuOHKzTow4nbeVVBIha/2
         1RZH8LkFSSlf3wz3qLK8xN4itvBTM6Zo6mSry6Owd2WqaG4eOcE/+fwFgjd4Yjn+AKi2
         UFdg==
X-Gm-Message-State: AOJu0YypbZi24aRHYqj1ULFl+cLxLJ0NxJYbENRCqyQR9nEtGuwe8J9t
	eZv6JCCcJKBpEBu6jBt+U534h+sSvWTuGZ/os86QMDuLi/JvnnZSRf+ziraroTlt3uStRZldPjT
	WonwZO7zkmg==
X-Google-Smtp-Source: AGHT+IEFftT5kZkq8mrpLcqBpa/Ff4XQ95wJmDsqLkoC6IbAjTCDm00K4H15lRUKMk95olG8APv1SWnCIhhUow==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b88:b0:dc6:ec15:5f6f with SMTP
 id ei8-20020a0569021b8800b00dc6ec155f6fmr54939ybb.6.1707230610832; Tue, 06
 Feb 2024 06:43:30 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:04 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-9-edumazet@google.com>
Subject: [PATCH v4 net-next 07/15] ipv4: add __unregister_nexthop_notifier()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

unregister_nexthop_notifier() assumes the caller does not hold rtnl.

We need in the following patch to use it from a context
already holding rtnl.

Add __unregister_nexthop_notifier().

unregister_nexthop_notifier() becomes a wrapper.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/nexthop.h |  1 +
 net/ipv4/nexthop.c    | 19 +++++++++++++------
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index d92046a4a078250eec528f3cb2c3ab557decad03..6647ad509faa02a9a13d58f3405c4a540abc5077 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -218,6 +218,7 @@ struct nh_notifier_info {
 
 int register_nexthop_notifier(struct net *net, struct notifier_block *nb,
 			      struct netlink_ext_ack *extack);
+int __unregister_nexthop_notifier(struct net *net, struct notifier_block *nb);
 int unregister_nexthop_notifier(struct net *net, struct notifier_block *nb);
 void nexthop_set_hw_flags(struct net *net, u32 id, bool offload, bool trap);
 void nexthop_bucket_set_hw_flags(struct net *net, u32 id, u16 bucket_index,
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 7270a8631406c508eebf85c42eb29a5268d7d7cf..70509da4f0806d25b3707835c08888d5e57b782e 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -3631,17 +3631,24 @@ int register_nexthop_notifier(struct net *net, struct notifier_block *nb,
 }
 EXPORT_SYMBOL(register_nexthop_notifier);
 
-int unregister_nexthop_notifier(struct net *net, struct notifier_block *nb)
+int __unregister_nexthop_notifier(struct net *net, struct notifier_block *nb)
 {
 	int err;
 
-	rtnl_lock();
 	err = blocking_notifier_chain_unregister(&net->nexthop.notifier_chain,
 						 nb);
-	if (err)
-		goto unlock;
-	nexthops_dump(net, nb, NEXTHOP_EVENT_DEL, NULL);
-unlock:
+	if (!err)
+		nexthops_dump(net, nb, NEXTHOP_EVENT_DEL, NULL);
+	return err;
+}
+EXPORT_SYMBOL(__unregister_nexthop_notifier);
+
+int unregister_nexthop_notifier(struct net *net, struct notifier_block *nb)
+{
+	int err;
+
+	rtnl_lock();
+	err = __unregister_nexthop_notifier(net, nb);
 	rtnl_unlock();
 	return err;
 }
-- 
2.43.0.594.gd9cf4e227d-goog


