Return-Path: <netdev+bounces-68132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8424A845E30
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36EA31F28141
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01246160895;
	Thu,  1 Feb 2024 17:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nyX5DPPr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E270E160874
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807399; cv=none; b=pLoFbOD4fsEiXrt+cKmq5uPR4D90iXdZ/ZuCa0Q+uAhnACBgUH84JXxrGGXxkBKxmTtYEPlKklbvrtiGaEHWplWZt5kGbKOsnIcWgl2lTds3Aq6vpeM80x8povBkLEEz4LKh3Uqxu2m4yhZt/sbis7VAfAqf5FK5suvG4bvOm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807399; c=relaxed/simple;
	bh=JMszb2Z5KV9ZDDpIwhxfStIvwhp947l6K/avJlMkHRA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=J3xHSn6EzqkZUKtuFfS+ASw0fmBhssNrwmv7CJ+K2cBR5q72toQagQYdItrIy1NGvF8+SPJuPZATIApvkQXKYRrYewmRjzsmRMR3s8DyNdkcNFkMkPj2ugGb4p9BVXIbmm34kSRpvxkws6ci+asIsyeIISmksbjizZi+dHbLwRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nyX5DPPr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc693399655so1839504276.1
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706807395; x=1707412195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u3H8MHJng4CjO1otVqKpoT61CfOdj4d3Ms+Y4lV+Ros=;
        b=nyX5DPPrcFQAD/MFO+AN/8+QRNYVKUBAVtuz6BPWxFDf4Q2LHBVJz/nFe62DiEEWMR
         d2BgWC7d7/T1da3XX7jgDmJqK8xYrfYs8/2qXKj5BtczpfMheNIjZLJhHa2UvkzjAr5F
         oPOtxVyb48ftAuGFUn1P1DrPtIukgE39CQfYVOsZoVNzXRUKwZEmMEDQVbug/XUMt7+F
         p3IJyBmRaa1ZndVav4YF0orTeR2P/c6fmadv5RZ0xyCI30714WGypSpQiRdW6BhTN2a1
         H9F70XJ5TCgThmqr2cYP40vkRsdaNpxqEGJtGsNx3Vogfc63WoDF5eoFLu5BtJKZCBdp
         ZtXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807395; x=1707412195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u3H8MHJng4CjO1otVqKpoT61CfOdj4d3Ms+Y4lV+Ros=;
        b=l3Tp1DFYlHxY3wKhVUgOK5ce/ihqiCTJous4SG4Kzh6fxWeX7vLD6WZOS/VRthy8ZK
         NcIDLrCKza4VaplXdlD8ZKvQYan2CoxPcy2wCCnb6MVHrW9Lm974d03ygmyPIy0egcjX
         2wAhpi/utzXTw/vZ/kcmUhFVqxgUmQr6cxtifusRQ6+bIhwoEbqoO4S6drD9L82jKkko
         aEpUihxcyB51KsdXfNBYFSkURN4GKvKBcgMus4EVJQJ50auQOqpYlg4p7Zwz/S2dQ45k
         XH+5fG9bjZ1ICVF8v+znwgAg0jq/MnHlG0ro4dYK7ABRd/7QhmU/m5Fyy4Oln73GPBYM
         Fn4Q==
X-Gm-Message-State: AOJu0YzlqG8ombF1o4noZ34Bj7q2ULTLMdFz5xCl0spPoC4HlUGU7Uh3
	+VbwMUIS7d6XOpe2CfoJ0aAL1+XF83aPxaKH1x0qesJ/mmI/vVcm1Qxi53u1OVA9UWVU+fIgrIz
	3Hy3OBbr7SA==
X-Google-Smtp-Source: AGHT+IFDb4yt41sYFGR+uza9l2m590wFumDxMGOCzzuvX6EEDWLFi7TnkoBgQ+rk/0KYf8vXY2khWval6JejLg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:f0a:b0:dc6:d3c0:ebe0 with SMTP
 id et10-20020a0569020f0a00b00dc6d3c0ebe0mr708608ybb.0.1706807395320; Thu, 01
 Feb 2024 09:09:55 -0800 (PST)
Date: Thu,  1 Feb 2024 17:09:33 +0000
In-Reply-To: <20240201170937.3549878-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240201170937.3549878-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240201170937.3549878-13-edumazet@google.com>
Subject: [PATCH net-next 12/16] ip6_vti: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_vti.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index e550240c85e1c9f2fe2b835e903de28e1f08b3bc..cfe1b1ad4d85d303597784d5eeb3077383978d95 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -1174,24 +1174,22 @@ static int __net_init vti6_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit vti6_exit_batch_net(struct list_head *net_list)
+static void __net_exit vti6_exit_batch_rtnl(struct list_head *net_list,
+					    struct list_head *dev_to_kill)
 {
 	struct vti6_net *ip6n;
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list) {
 		ip6n = net_generic(net, vti6_net_id);
-		vti6_destroy_tunnels(ip6n, &list);
+		vti6_destroy_tunnels(ip6n, dev_to_kill);
 	}
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
 }
 
 static struct pernet_operations vti6_net_ops = {
 	.init = vti6_init_net,
-	.exit_batch = vti6_exit_batch_net,
+	.exit_batch_rtnl = vti6_exit_batch_rtnl,
 	.id   = &vti6_net_id,
 	.size = sizeof(struct vti6_net),
 };
-- 
2.43.0.429.g432eaa2c6b-goog


