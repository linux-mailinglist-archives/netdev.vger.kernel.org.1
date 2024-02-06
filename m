Return-Path: <netdev+bounces-69521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB9F84B835
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:45:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5556C1F25B1F
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B2A13398A;
	Tue,  6 Feb 2024 14:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wtN0Htqw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F074B13249A
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230625; cv=none; b=CfF2A3l/ko33c9OEvPN7Gw5deHbxUMq3SmkGbD4KugOYpVWIGY23dgszIYUkzpYBYiaHyCOOqyM9/e+Va6hHHWrnSLFUJBXGMMi5QCOJc1RDd36LXKOJ+CUfkTPtmaHpk1PDzamwcUZKK8Tk1jSDPXY8a4o2Fiy2cN0d8ZWCg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230625; c=relaxed/simple;
	bh=4zrgDxfQyQr/MMxBX+zy4rapi5D5t+FXILJZ6E/m2l0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Fa/lTwQVWH8PJ8tX67sgKOgcGbELpWpsrl7OjXUsYd0ZifCbOmH2EtG9pKG+bi4a3CvZeiU8OASrSL94QyDWN99uaRWF8GfiYgEVJH8Jz9CedNdFm8mPOPM6IrZpw6vG9C1UNKHfw3Ri1uZ7yUUZUQUOpgc96sZwTB2AoADNSag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wtN0Htqw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-603c0e020a6so72871177b3.0
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230623; x=1707835423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ucrSInxhM/tToihWu9krdoEfDlDiN1lPApGKi5+rQ0I=;
        b=wtN0HtqwCajxo7Uqbq3GOI7G+A3n7T0GIMzTApZ0C3/wJmonMvl45cpNUfxhKGNL33
         Ibcv9lvQa5ldDSib793aj6ERTSvAwgwIy/yHrDiQH6rTJVOdY2u7VaH+EnMVEJ2IkcEe
         GEzcfVm5OtzqDp8Igqw0DSKETXCP++EH2GaX8bZaoToJSaqGLbX+CPTG9PH+b5Fr2eTh
         sJVitK8f75XSnzUG1zdTNgoTtHmmd7gSBRxY+E454CwyzXPntc7Y6PGFujATiTPrrfYa
         eVaqUS03QOhAp05+zjWg5beaUUfP8aDd9etPOvayFYJc/Q7supFsrCHdyZt9dwXg3Jdh
         uGSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230623; x=1707835423;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucrSInxhM/tToihWu9krdoEfDlDiN1lPApGKi5+rQ0I=;
        b=GArSr++94pcAM1rLVwCkAACy43a5Q0rwxUkxWCEcUZC6bsCtx0/CSaAmlOeWAbeIQi
         9uys1VNCw4BtcybsIvy+tcdtYbxtWchr6PRLDGZq5yP1U2YYOM55tDCtpe0i06RzfoSE
         zJe/Qq0g5tlEGZGnBi1g3RQXjfmDpPOIJBrcqC00Yyzjl5gd/CxfN96Z2LdWETpVgkKm
         wS2qZPry7QNM39oGxF4oVIr+dzowLDkq8HArXg4BVdcNaONx55taXPIXz+HlP2Y3w5nG
         77kJNvjxirJ7A48pnXL7CpymnOHrWoSG9wc9JxTTqlHI8Usk+TmJdMqtmV324MYAORUa
         zIvw==
X-Gm-Message-State: AOJu0Yyg1ceTtrtG6JlI3z59bzQ0coxlTIdRnJ5il3CtoCudpBCaW6f6
	OHrN94QP12hDM/oJaDwomm9+t+EOs/AHO3hiar+qplcQgk/SHZy8+o9DRA5s5OmQ7ygnqqi4e4c
	Ix7QbSL+YPg==
X-Google-Smtp-Source: AGHT+IFGr4TsRIfwXlp9Ux1YMlwhhjTZl85bpczc8vkHoJKOZk/xKJBjJhIE8vV/iK9yUbtPkbCEiNQKYHDf7A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1b81:b0:dc2:25fd:eff1 with SMTP
 id ei1-20020a0569021b8100b00dc225fdeff1mr47935ybb.4.1707230622911; Tue, 06
 Feb 2024 06:43:42 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:11 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-16-edumazet@google.com>
Subject: [PATCH v4 net-next 14/15] bridge: use exit_batch_rtnl() method
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
2.43.0.594.gd9cf4e227d-goog


