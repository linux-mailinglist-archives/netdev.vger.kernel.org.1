Return-Path: <netdev+bounces-26295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571D177762D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 12:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286D11C20950
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B20B20F9B;
	Thu, 10 Aug 2023 10:40:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF371F956
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 10:40:06 +0000 (UTC)
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C52562130
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:40:04 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id d75a77b69052e-4100bd13cb5so10533541cf.0
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 03:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691664004; x=1692268804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GlY0x4pUFucvlfOzeaXMYa7WhyRv/5QM+Hj4B0mEeDc=;
        b=inzjiKtntVhSr2PhoDYqywcEN1FtPDPGyguoJefPypGY6yHAwJjrPt4+4i+Lz2SGD0
         AbZL3eT2F2NasxMNf9kKx8OdBphgBwTcc6o40MepR2hod6O6fGxENUenzxPesQD+Tmkx
         jK5WW0kjDUC50/EthzruKueNyM+1+8n33XW9Nh69z/qw7lN/XyrACgw3iu2B8SasXvnG
         Z01BH2IzvbxtQmEdtPCo4b9VE6Va+mdUA2+mR5uG2KCWDebog2JwrDrNRmFyDMVzQU2O
         5ZVLepwCNzQTtGmCw0PGHlgM+JN/YQrd+N+Uzv65k2OL1PNhnzJ8zB4+koGTfLF/1hD4
         S/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691664004; x=1692268804;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GlY0x4pUFucvlfOzeaXMYa7WhyRv/5QM+Hj4B0mEeDc=;
        b=TtAtzz5pt3/bDOwSktMH+xbqf7n1PX2Hkv33lnHOrsOet2FGG9IbNHjVBhb6dd1aZs
         CTGq4s6dLpzd0EtbORMXn/Gyw9FpVIhMR3/RGiklOnluJICdPdMhEkwAC72v8HPeCXbE
         iTQAdn3iNk/AQXiHLkeTOXlgizH6odNVrUlo17ZzyhwVLh5okatMgidIoG98sJG563RC
         Lqh4qcXWYeL2wpjkenzJMLZCi8fad3begZVXEhkKAc6ZG3AIX5BF0kUIKyfbuK/HFxJr
         QyooahCM9Afod7NH1ifM+LkO+ZFLDPIV6JZA+j1/eYc5PfxGNZH8Bh6esFL53iSAUdKA
         L2fQ==
X-Gm-Message-State: AOJu0YwA8Eqj/KhdLsZ9vMnCZKt6ZlQGvgASdmmP3nRT4ZknlgrNtgXL
	zAAaEh5TRvxX5tDZJ16WE+Gi/JUgkTBcRA==
X-Google-Smtp-Source: AGHT+IGIeSUtg/O9sfjgVm/gDaRi2shmBtRwJB5A/+dOn8F7bRClMFTwI2dpfDMdtHrcAJdaPSrICAfd+UWz6g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:622a:1a26:b0:403:a91d:bfec with SMTP
 id f38-20020a05622a1a2600b00403a91dbfecmr26353qtb.0.1691664003915; Thu, 10
 Aug 2023 03:40:03 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:39:27 +0000
In-Reply-To: <20230810103927.1705940-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230810103927.1705940-1-edumazet@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810103927.1705940-16-edumazet@google.com>
Subject: [PATCH net-next 15/15] inet: implement lockless IP_MINTTL
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <simon.horman@corigine.com>, Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

inet->min_ttl is already read with READ_ONCE().

Implementing IP_MINTTL socket option set/read
without holding the socket lock is easy.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/ip_sockglue.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/ip_sockglue.c b/net/ipv4/ip_sockglue.c
index dbb2d2342ebf0c1f1366ee6b6b2158a6118b2659..61b2e7bc7031501ff5a3ebeffc3f90be180fa09e 100644
--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -1030,6 +1030,17 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 			return -EINVAL;
 		WRITE_ONCE(inet->uc_ttl, val);
 		return 0;
+	case IP_MINTTL:
+		if (optlen < 1)
+			return -EINVAL;
+		if (val < 0 || val > 255)
+			return -EINVAL;
+
+		if (val)
+			static_branch_enable(&ip4_min_ttl);
+
+		WRITE_ONCE(inet->min_ttl, val);
+		return 0;
 	}
 
 	err = 0;
@@ -1326,21 +1337,6 @@ int do_ip_setsockopt(struct sock *sk, int level, int optname,
 		err = xfrm_user_policy(sk, optname, optval, optlen);
 		break;
 
-	case IP_MINTTL:
-		if (optlen < 1)
-			goto e_inval;
-		if (val < 0 || val > 255)
-			goto e_inval;
-
-		if (val)
-			static_branch_enable(&ip4_min_ttl);
-
-		/* tcp_v4_err() and tcp_v4_rcv() might read min_ttl
-		 * while we are changint it.
-		 */
-		WRITE_ONCE(inet->min_ttl, val);
-		break;
-
 	case IP_LOCAL_PORT_RANGE:
 	{
 		const __u16 lo = val;
@@ -1595,6 +1591,9 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		if (val < 0)
 			val = READ_ONCE(sock_net(sk)->ipv4.sysctl_ip_default_ttl);
 		goto copyval;
+	case IP_MINTTL:
+		val = READ_ONCE(inet->min_ttl);
+		goto copyval;
 	}
 
 	if (needs_rtnl)
@@ -1731,9 +1730,6 @@ int do_ip_getsockopt(struct sock *sk, int level, int optname,
 		len -= msg.msg_controllen;
 		return copy_to_sockptr(optlen, &len, sizeof(int));
 	}
-	case IP_MINTTL:
-		val = inet->min_ttl;
-		break;
 	case IP_LOCAL_PORT_RANGE:
 		val = inet->local_port_range.hi << 16 | inet->local_port_range.lo;
 		break;
-- 
2.41.0.640.ga95def55d0-goog


