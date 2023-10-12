Return-Path: <netdev+bounces-40555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339887C7A83
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8311282B06
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD4F2B5E6;
	Thu, 12 Oct 2023 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="P4uS1OVA"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1257B1D68F
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 23:41:18 +0000 (UTC)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A25DE
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 16:41:17 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7a2cc9ee64cso60848439f.1
        for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 16:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1697154076; x=1697758876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8lPotT7caJ2i4rnfmOn5KsESAOXBOrfHJSZKahlwL+g=;
        b=P4uS1OVAhhol/x5j9dfFaJZXBZAXoZyPEY4vGo1aH2YNwyG/8LORaaKOa6FXc/pdVM
         IWVVoy7gOpYDXLGZtyh12nuKINDOOnT1kNTtj1tXdOBFPl8iX+D8NOv+elRuyF5jpl4+
         AF0pjlkicHLO5bX5Ba/zUaFxzNF40KYAJBzh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697154076; x=1697758876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8lPotT7caJ2i4rnfmOn5KsESAOXBOrfHJSZKahlwL+g=;
        b=tCIeNJ/m/uJJUdkcntYfLncx77v5/CDOLTi01c3uv2pbb6bl8xfUk3xXIwxw1L6jcz
         Di/HQU7qURoOlvuqejvCNEUbwNnzBSuTPqjGJ6+h3bf2PkfAN6PoGym3Ct3oIabKToOh
         ukrfsclvKUl5lAehTD+94bQO/I1xwB5IzNlpU1qwZB022rfPMAF3zhWJgN4g/Q9BWoKT
         Tsgh15hqKe7kKjqyYMGltFsYzfAU6fvZcU6kHLcb+T/efrK12a4+HH1uHInA4klpTI2r
         WpnwyK9srWYBYqKNhPuHcxbg6iEfwN1ql3XiqMu0sTgnGiqFAFeC8lqAKJNYZjC/rBFa
         v+NQ==
X-Gm-Message-State: AOJu0YzyWdM31w4k9OXrMj/Bz53YJBNi3C0XM//B3JGkJO+Yp1+MT/Ro
	c8hlfYorTj+2eO2iuvOtfVNoVg==
X-Google-Smtp-Source: AGHT+IHVcCcrRF23qP1MJVBs2OIkv1QitZZk132Zae4UHLUIu2aj2KVqpLdgi6v/dJwUgreFF9xBIA==
X-Received: by 2002:a6b:f319:0:b0:783:63d6:4c5 with SMTP id m25-20020a6bf319000000b0078363d604c5mr29820716ioh.12.1697154076350;
        Thu, 12 Oct 2023 16:41:16 -0700 (PDT)
Received: from localhost.localdomain (d14-69-55-117.try.wideopenwest.com. [69.14.117.55])
        by smtp.gmail.com with ESMTPSA id c6-20020a5ea806000000b0078702f4894asm4480238ioa.9.2023.10.12.16.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 16:41:15 -0700 (PDT)
From: "Nabil S. Alramli" <nalramli@fastly.com>
To: sbhogavilli@fastly.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: srao@fastly.com,
	dev@nalramli.com
Subject: [net] ipv4: Fix broken PMTUD when using L4 multipath hash
Date: Thu, 12 Oct 2023 19:40:25 -0400
Message-Id: <20231012234025.4025-1-nalramli@fastly.com>
X-Mailer: git-send-email 2.31.1.windows.1
In-Reply-To: <20231012005721.2742-2-nalramli@fastly.com>
References: <20231012005721.2742-2-nalramli@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Suresh Bhogavilli <sbhogavilli@fastly.com>

On a node with multiple network interfaces, if we enable layer 4 hash
policy with net.ipv4.fib_multipath_hash_policy=1, path MTU discovery is
broken and TCP connection does not make progress unless the incoming
ICMP Fragmentation Needed (type 3, code 4) message is received on the
egress interface of selected nexthop of the socket.

This is because build_sk_flow_key() does not provide the sport and dport
from the socket when calling flowi4_init_output(). This appears to be a
copy/paste error of build_skb_flow_key() -> __build_flow_key() ->
flowi4_init_output() call used for packet forwarding where an skb is
present, is passed later to fib_multipath_hash() call, and can scrape
out both sport and dport from the skb if L4 hash policy is in use.

In the socket write case, fib_multipath_hash() does not get an skb so
it expects the fl4 to have sport and dport populated when L4 hashing is
in use. Not populating them results in creating a nexthop exception
entry against a nexthop that may not be the one used by the socket.
Hence it is not later matched when inet_csk_rebuild_route is called to
update the cached dst entry in the socket, so TCP does not lower its MSS
and the connection does not make progress.

Fix this by providing the source port and destination ports to
flowi4_init_output() call in build_sk_flow_key().

Fixes: 4895c771c7f0 ("ipv4: Add FIB nexthop exceptions.")
Signed-off-by: Suresh Bhogavilli <sbhogavilli@fastly.com>
---
 net/ipv4/route.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index e2bf4602b559..2517eb12b7ef 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -557,7 +557,8 @@ static void build_sk_flow_key(struct flowi4 *fl4, const struct sock *sk)
 			   inet_test_bit(HDRINCL, sk) ?
 				IPPROTO_RAW : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk),
-			   daddr, inet->inet_saddr, 0, 0, sk->sk_uid);
+			   daddr, inet->inet_saddr, inet->inet_dport, inet->inet_sport,
+			   sk->sk_uid);
 	rcu_read_unlock();
 }
 
-- 
2.31.1


