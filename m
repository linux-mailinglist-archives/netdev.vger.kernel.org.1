Return-Path: <netdev+bounces-20453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 649D575F9BD
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F3332814E2
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71C9D524;
	Mon, 24 Jul 2023 14:24:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA71AD505
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 14:24:01 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AFE10C3;
	Mon, 24 Jul 2023 07:23:53 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so6705121e87.2;
        Mon, 24 Jul 2023 07:23:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690208631; x=1690813431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ChPT/lHzXHpKHyXlCB2W1LoY3mnd1UwLMSxiYiQjKmg=;
        b=X4sufUvUx313D5bZKrfZpnfttnOH0qc75uaSUQY8iTco6wHbtGIxtmk+pCdZCiAg5I
         mWT5uFi+UXheWqhYlsXACOieHsMVQQl+rg5EVHXgjd7hH1h6WYrUNMVOslNEp1OmZOBS
         mov6/QteUErk8VGB0URwmQPyDTBd31czj/C6YjcyCea/wf5B5cNrLFw0sEbOP491JEOk
         /gpAb8x7981SH3Pzx3Zu6i5oL0YfiCtWXt0I3qyeXHc0rMmlOK2MR0aTu+duFkl25eLx
         dGEl9U8/uPUjVqdcsIJ8nzt2TCsAvVfPCWT0yhuhyVjua6dU/GHUje6RabfRudBcsi6y
         Vtcg==
X-Gm-Message-State: ABy/qLYBtDOp8RBGgTc3EABtKmqktgOf9QbPJMNz73iDapzJsrgCEfyV
	5NSpeaCiCnVBFEVFv0jbOzdEOp7I3t0=
X-Google-Smtp-Source: APBJJlE991JcdDNxQmvs3s+jlsS0PAawC3OmvHXpKD54nLZID4BKysKlhxDO+z9x9+61alUm02K++A==
X-Received: by 2002:a05:6512:3083:b0:4f8:4512:c846 with SMTP id z3-20020a056512308300b004f84512c846mr5794975lfd.49.1690208631269;
        Mon, 24 Jul 2023 07:23:51 -0700 (PDT)
Received: from localhost (fwdproxy-cln-011.fbsv.net. [2a03:2880:31ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id lr20-20020a170906fb9400b00992b3ea1ee4sm6948428ejb.149.2023.07.24.07.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 07:23:50 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: asml.silence@gmail.com,
	axboe@kernel.dk,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: io-uring@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	leit@meta.com
Subject: [PATCH 1/4] net: expose sock_use_custom_sol_socket
Date: Mon, 24 Jul 2023 07:22:34 -0700
Message-Id: <20230724142237.358769-2-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230724142237.358769-1-leitao@debian.org>
References: <20230724142237.358769-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Exposing function sock_use_custom_sol_socket(), so it could be used by
io_uring subsystem.

This function will be used in the function io_uring_cmd_setsockopt() in
the coming patch, so, let's move it to the socket.h header file.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/net.h | 5 +++++
 net/socket.c        | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 41c608c1b02c..14a956e4530e 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -355,4 +355,9 @@ u32 kernel_sock_ip_overhead(struct sock *sk);
 #define MODULE_ALIAS_NET_PF_PROTO_NAME(pf, proto, name) \
 	MODULE_ALIAS("net-pf-" __stringify(pf) "-proto-" __stringify(proto) \
 		     name)
+
+static inline bool sock_use_custom_sol_socket(const struct socket *sock)
+{
+	return test_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
+}
 #endif	/* _LINUX_NET_H */
diff --git a/net/socket.c b/net/socket.c
index 1dc23f5298ba..8df54352af83 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2216,11 +2216,6 @@ SYSCALL_DEFINE4(recv, int, fd, void __user *, ubuf, size_t, size,
 	return __sys_recvfrom(fd, ubuf, size, flags, NULL, NULL);
 }
 
-static bool sock_use_custom_sol_socket(const struct socket *sock)
-{
-	return test_bit(SOCK_CUSTOM_SOCKOPT, &sock->flags);
-}
-
 /*
  *	Set a socket option. Because we don't know the option lengths we have
  *	to pass the user mode parameter for the protocols to sort out.
-- 
2.34.1


