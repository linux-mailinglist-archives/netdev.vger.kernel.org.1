Return-Path: <netdev+bounces-15959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0814D74A9FE
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 06:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B49BA281637
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 04:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D8F13078;
	Fri,  7 Jul 2023 04:39:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D75EA0
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 04:39:42 +0000 (UTC)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EAA1BF4
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 21:39:40 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-1b05d63080cso1450164fac.2
        for <netdev@vger.kernel.org>; Thu, 06 Jul 2023 21:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1688704779; x=1691296779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9UWYQqOrYqkxR5XpwKp6R22GVBVnnsxJZJsmiNrkFSw=;
        b=W0t5g/B1oy0yWoS9I4G0cGXHdlj4SznvVg7lqL2NZauZ7JCHiUBrbWDFm5zuVLIBct
         NYyiqasx+mGmFapxdlx7IvBBfH+l0yeOsdcDVTQc6r8ykfBeseb8UeARhrrX4JEAGV6Y
         GMr4VR8b6MIs9LYlKiMoNmSb6/eCC4N5QZG3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688704779; x=1691296779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UWYQqOrYqkxR5XpwKp6R22GVBVnnsxJZJsmiNrkFSw=;
        b=j5BNG/cBHltTxlSK8fWyK6W/4h1BdlSDWoFRdLXpjngu8KOv21MaA1+ykp4sH07CwU
         ppABNZAly6et65lYi+Y1TMT/pYgXuDOeZ5tNd+mBDuSvlYH+YaV/7FZZEDKcsA2pKtc7
         az0Qk54dSLrx2w1Ysl+ycutZ6U/jPA+SfZueYe5f51b0MU4YE23Rv3N6Kv3N5MZeL1Td
         K5I8orYHZllftCsQRspoEVDkkQrgA+cCc4dGVUvIB6UwUb6Riojw8+CnUsimCJV46KKQ
         YE5DHKNCZCEwlpKjBupCAyzjlIMpJD4GdNZ+GWdc5+Z5VdEY4NeJ8y9bQWEwm7aG4fNe
         lcoQ==
X-Gm-Message-State: ABy/qLZnARO+t9Fi/2hDbNcRJO7rs+YmecePCAv9Hy0GeGtIZkj599Hr
	MS5Fe611qLCES1ivqrjOGh2UTG85/PJ1iWAOhPfBcg==
X-Google-Smtp-Source: APBJJlFmgPUvYnZf5B/mqoJrxp5s/bQoPHgPHPa3ft527lToxgI0pMs4rl3RBhthX5RmGK/P+cVJuw==
X-Received: by 2002:a05:6870:2215:b0:1b0:3637:2bbe with SMTP id i21-20020a056870221500b001b036372bbemr4848122oaf.54.1688704779673;
        Thu, 06 Jul 2023 21:39:39 -0700 (PDT)
Received: from localhost ([2601:644:200:aea:502d:5846:fd1f:55e7])
        by smtp.gmail.com with ESMTPSA id n2-20020a17090a670200b0025c1cfdb93esm576569pjj.13.2023.07.06.21.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 21:39:39 -0700 (PDT)
From: Ivan Babrou <ivan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Ivan Babrou <ivan@cloudflare.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Peilin Ye <peilin.ye@bytedance.com>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Petr Machata <petrm@nvidia.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Satoru Moriya <satoru.moriya@hds.com>
Subject: [PATCH v2] udp6: add a missing call into udp_fail_queue_rcv_skb tracepoint
Date: Thu,  6 Jul 2023 21:39:20 -0700
Message-ID: <20230707043923.35578-1-ivan@cloudflare.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The tracepoint has existed for 12 years, but it only covered udp
over the legacy IPv4 protocol. Having it enabled for udp6 removes
the unnecessary difference in error visibility.

Signed-off-by: Ivan Babrou <ivan@cloudflare.com>
Fixes: 296f7ea75b45 ("udp: add tracepoints for queueing skb to rcvbuf")

---
v2: added tracepoint export to make it build with IPV6=m (thanks Jakub!)
---
 net/core/net-traces.c | 2 ++
 net/ipv6/udp.c        | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/net/core/net-traces.c b/net/core/net-traces.c
index 805b7385dd8d..6aef976bc1da 100644
--- a/net/core/net-traces.c
+++ b/net/core/net-traces.c
@@ -63,4 +63,6 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(napi_poll);
 EXPORT_TRACEPOINT_SYMBOL_GPL(tcp_send_reset);
 EXPORT_TRACEPOINT_SYMBOL_GPL(tcp_bad_csum);
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(udp_fail_queue_rcv_skb);
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(sk_data_ready);
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index e5a337e6b970..debb98fb23c0 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -45,6 +45,7 @@
 #include <net/tcp_states.h>
 #include <net/ip6_checksum.h>
 #include <net/ip6_tunnel.h>
+#include <trace/events/udp.h>
 #include <net/xfrm.h>
 #include <net/inet_hashtables.h>
 #include <net/inet6_hashtables.h>
@@ -680,6 +681,7 @@ static int __udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		}
 		UDP6_INC_STATS(sock_net(sk), UDP_MIB_INERRORS, is_udplite);
 		kfree_skb_reason(skb, drop_reason);
+		trace_udp_fail_queue_rcv_skb(rc, sk);
 		return -1;
 	}
 
-- 
2.41.0


