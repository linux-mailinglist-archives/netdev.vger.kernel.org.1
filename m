Return-Path: <netdev+bounces-19255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD7075A09A
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 23:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1453E281B25
	for <lists+netdev@lfdr.de>; Wed, 19 Jul 2023 21:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E29263B9;
	Wed, 19 Jul 2023 21:29:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1779822EF5
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 21:29:22 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D4B1FC0
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:20 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c6dd0e46a52so82495276.2
        for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 14:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689802160; x=1690406960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0W2XBGAmdAt/+G45dLGl8lnySX1PByBxox1lbefosjw=;
        b=NcrvKeDY5twbxtwlGcMlVQuuF9pd9HsNI/7TeLqMstCYkcjOcduDGeio34nT+3NGo7
         lBpPIWeg+oiYeSELrQw7HqwDCSEyqJ8u7t6J6zWUfiaKq6T9JfZTzvVIHpwywQLdO342
         +Upw23YJ3n1N3m+65rxoabU+6DOkXh054DUh4ldTxTddk/6EUvWkPxO08MLgHMdQiw4C
         kalN0C9kFwGcB0Cw9Okk2zB0JId3AO4kHX8DIj9P0OMpreUHGaObPK5LATZLpOOxQLFo
         1wupbgWIsu37gZhHIWswUzaYqYvDXgdBNtaRuRs8JoVC29dQ4IVAvMuHBIzC35u2Zz8K
         /RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689802160; x=1690406960;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0W2XBGAmdAt/+G45dLGl8lnySX1PByBxox1lbefosjw=;
        b=PIqSVWvX/NWmF/uCAVG9QxK0t/mkWIJa47nnX+MsuERR4JE33dwHwwrenjLcS8PUSc
         zbGPfCwt4fjf4eTzTyV48V1l2gA1EZDTDvX7HPrvKLY4fNnrRxmdfV7FeN6RWBSIWjR0
         WvOo0I7fxAqTmAB2W+2Fl8RAOshyy1e2CaAWn5SgwVhKfpMU46Uc9aLd5h9Mrpr3vsQR
         V378B7LSsD0s6GV6bPUjzab91DKdD6HTO+2MCmIOuxOrwQJ7iEnIBKerHysUFWF6Z/gT
         fqhhrMXBRAZFUGPIDAwfdrf+R0ZUhrY5qGHlqdgdPR4QBbx18rvpNddLDBjU5U9ZTQR2
         dUpg==
X-Gm-Message-State: ABy/qLa1wv5MI1tzZNiVrUMqZHFRTzu/nFPt0OEh2DZCEy84TTKCBXm+
	5w5LQ5tPEPOCOM9OAtKKl9XkAWx0Ji0t3g==
X-Google-Smtp-Source: APBJJlElnwtmj9UhRwhgLQuEirxCG4G0m/FTzBdw3ufGzgNZ35bF7Lczaz5NeJjukbf5JdhwSEVaTQQNuzObug==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1746:b0:cea:ef04:1c61 with SMTP
 id bz6-20020a056902174600b00ceaef041c61mr30350ybb.1.1689802160182; Wed, 19
 Jul 2023 14:29:20 -0700 (PDT)
Date: Wed, 19 Jul 2023 21:28:55 +0000
In-Reply-To: <20230719212857.3943972-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230719212857.3943972-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719212857.3943972-10-edumazet@google.com>
Subject: [PATCH net 09/11] tcp: annotate data-races around tp->notsent_lowat
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

tp->notsent_lowat can be read locklessly from do_tcp_getsockopt()
and tcp_poll().

Fixes: c9bee3b7fdec ("tcp: TCP_NOTSENT_LOWAT socket option")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h | 6 +++++-
 net/ipv4/tcp.c    | 4 ++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 855dbe72e431776257037d75e32037b44905453c..a32d1963cb75ff81c164b3021a848d3d29816642 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2059,7 +2059,11 @@ void __tcp_v4_send_check(struct sk_buff *skb, __be32 saddr, __be32 daddr);
 static inline u32 tcp_notsent_lowat(const struct tcp_sock *tp)
 {
 	struct net *net = sock_net((struct sock *)tp);
-	return tp->notsent_lowat ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
+	u32 val;
+
+	val = READ_ONCE(tp->notsent_lowat);
+
+	return val ?: READ_ONCE(net->ipv4.sysctl_tcp_notsent_lowat);
 }
 
 bool tcp_stream_memory_free(const struct sock *sk, int wake);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 5beec71a5c418db65e19eb2a68ffd839d4550efc..2b2241e9b492726562a6b5055cf8c168e5fed799 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3664,7 +3664,7 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
 		err = tcp_repair_set_window(tp, optval, optlen);
 		break;
 	case TCP_NOTSENT_LOWAT:
-		tp->notsent_lowat = val;
+		WRITE_ONCE(tp->notsent_lowat, val);
 		sk->sk_write_space(sk);
 		break;
 	case TCP_INQ:
@@ -4164,7 +4164,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 		val = tcp_time_stamp_raw() + READ_ONCE(tp->tsoffset);
 		break;
 	case TCP_NOTSENT_LOWAT:
-		val = tp->notsent_lowat;
+		val = READ_ONCE(tp->notsent_lowat);
 		break;
 	case TCP_INQ:
 		val = tp->recvmsg_inq;
-- 
2.41.0.255.g8b1d071c50-goog


