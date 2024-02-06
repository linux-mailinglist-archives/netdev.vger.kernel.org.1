Return-Path: <netdev+bounces-69516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000D784B858
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C24A3B298B6
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61871332BD;
	Tue,  6 Feb 2024 14:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TDUrnutC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695C913246F
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230616; cv=none; b=SGWnNCzzM0mb8J+GfdzU/Tc+uIIhtHDu1MJvlEJTX1RD0OqgcdYzVGrpXiwuVENOe5dQTNlmxJsxjK9Y4GAWYH44PtzppFsj6cyKX59A1jSVu2dMEn6IOtFu+mC3EKc4Rgpf1cIuaLFO0SxKSFVGwikMTslzFtMq1GyZR7aI5ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230616; c=relaxed/simple;
	bh=JHINC854ia98PUJGcuLobWS/goCDxB+drerbt4+vUfo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H+rU+BgeYV1SoJtgBSqrkD+qJ8lTXreeveIpMUVjJzqouxi9pOO2vIlviAlLZciUfqsD+M6sHoR+ARlVYpMQU3vLT98wbr0J58AN7y0QDCZTL3NwtKEo21+J0H6ijqFHmMqFsxbrsl610MlL7vDqbQIUZD9byHMYkzK/RuucbBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TDUrnutC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b269686aso1464506276.1
        for <netdev@vger.kernel.org>; Tue, 06 Feb 2024 06:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707230614; x=1707835414; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ5+OvkCx7q7sa2Wuj/YvUBwdeuOFa3Bfx0+2rdMfyo=;
        b=TDUrnutCj5NGWj/4zexSKM+EOZwC76wu/KXmoVefXsCUIvF/fh6WNdC4sHVjZjJkWG
         vfK7PnVcTXEaZkjlco1/D1idnNwZ8OSoqgYu3PAg69BLjPMLpRtKwxhyKjkz3b6VQMZj
         nfw9+lHqqbdXEDhdlWqL3tZIX+mx7ZGxV2GyLbemeCVvYlfXO35E2XzHqc1XvmBuRLan
         yQtvZNS18NTHiimTqb4lv9LKIPn4UK3++iPenkWBrKFb+NN/IZEoASOrAXAVgdrdYlOX
         0uIw/NC198R9aLUSibS+oo7Jmus/CCvYweYiiMbdmlps2dXTC8uiD+hYIsLPKWuiMQoq
         h7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707230614; x=1707835414;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sJ5+OvkCx7q7sa2Wuj/YvUBwdeuOFa3Bfx0+2rdMfyo=;
        b=b9bdz/UwX9XLRUIGE8KAIE4EpJPj1E3nKgUjn0SqGkGADwzTnSZpsnZqRp0UNw41wd
         /+RneAKZFhR43o0iiCPDgHAzJiwubtAf8+T8R1qemJpB5dhPordICkQ2+p6ORoxM/VfD
         li4JoL5accrjrQeh+2DDlw8vn3Mq3xM21zUq39yj+2v4IitQEQxf6TxWlOqqqm9LWjBm
         7V2m9i2cJHma4lbzqvTRvI1aqdnc9IAv1LwIx/uQq2hfFqA0piL8aUAhoLdYA1l/m2sS
         8g/T/pXCohATOfSLpbgcnD7GqxlPEuF5P7O3B7wdn2pvhqYochA/xIIl1M9fWo4FGRuH
         xyVg==
X-Gm-Message-State: AOJu0Yxy69D8bItA6axOZMTl4ntiAtVAYzCxELGwp7LVRyvSauPhl2bB
	1KvF7dflWRutodzdv0QVL/fpuNtLUXhahS3Q7cpkCRXcalzRKzaKxbg2Gq1cRRc9yy694/dEbKU
	8oyuntVQ/5Q==
X-Google-Smtp-Source: AGHT+IHyC91Y+gAlHTgkM6jPP3Up3BEe0en6EYIocaa7im3qex11oNcBimtjh6ThzkNhlmQSoEkExk8Hd/+t1Q==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:248a:b0:dc6:d1d7:d03e with SMTP
 id ds10-20020a056902248a00b00dc6d1d7d03emr54830ybb.8.1707230614450; Tue, 06
 Feb 2024 06:43:34 -0800 (PST)
Date: Tue,  6 Feb 2024 14:43:06 +0000
In-Reply-To: <20240206144313.2050392-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240206144313.2050392-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240206144313.2050392-11-edumazet@google.com>
Subject: [PATCH v4 net-next 09/15] ip6_gre: use exit_batch_rtnl() method
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

exit_batch_rtnl() is called while RTNL is held,
and devices to be unregistered can be queued in the dev_kill_list.

This saves one rtnl_lock()/rtnl_unlock() pair
and one unregister_netdevice_many() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_gre.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 070d87abf7c0284aa23043391aab080534e144a7..428f03e9da45ac323aa357b5a9d299fb7f3d3a5b 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1632,21 +1632,19 @@ static int __net_init ip6gre_init_net(struct net *net)
 	return err;
 }
 
-static void __net_exit ip6gre_exit_batch_net(struct list_head *net_list)
+static void __net_exit ip6gre_exit_batch_rtnl(struct list_head *net_list,
+					      struct list_head *dev_to_kill)
 {
 	struct net *net;
-	LIST_HEAD(list);
 
-	rtnl_lock();
+	ASSERT_RTNL();
 	list_for_each_entry(net, net_list, exit_list)
-		ip6gre_destroy_tunnels(net, &list);
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+		ip6gre_destroy_tunnels(net, dev_to_kill);
 }
 
 static struct pernet_operations ip6gre_net_ops = {
 	.init = ip6gre_init_net,
-	.exit_batch = ip6gre_exit_batch_net,
+	.exit_batch_rtnl = ip6gre_exit_batch_rtnl,
 	.id   = &ip6gre_net_id,
 	.size = sizeof(struct ip6gre_net),
 };
-- 
2.43.0.594.gd9cf4e227d-goog


