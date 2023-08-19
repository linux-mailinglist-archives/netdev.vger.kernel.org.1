Return-Path: <netdev+bounces-29046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9E878174C
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 06:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146491C20DC0
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6741398;
	Sat, 19 Aug 2023 04:06:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B84AA57
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 04:06:51 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7612D5D
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:06:49 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d27ac992539so2079274276.3
        for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 21:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692418008; x=1693022808;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vaNG/WL4DUG1P1tWL2rRFBL1VVrIgCrnL4Px7Zr61ZY=;
        b=bvER7mscAcaUvcuS6rhUK1G8ke+qAew02ajfjcLLpWIxMs61BcZ9EfthnHK8RywDBq
         LSXhdl8OdXHo4Xh7Dx95U1diiQp0SmVxRPq/rMneHpYY/HJrdJrEUoriH/LWaeLgsV9Y
         bQLob57+URGkJlWq72lzhnQ+vPaEGCJ8fitfdREnBnDSeptsl+KtR1yTvuHXJ+7xAvaq
         P+9b5BmpQ29xP+8GFN88rwS3Sc1+uuduIQgz3v5lEqGMNiG10JUen/OSh6pViO4baQVL
         fVIoiTYk8gjSI6aD+DprmYu7Vpui64R3MkpF0eY3YK0Rg1bQAN1ZuDNTPi3hiq4FvluT
         APog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692418008; x=1693022808;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vaNG/WL4DUG1P1tWL2rRFBL1VVrIgCrnL4Px7Zr61ZY=;
        b=LQ/folB2KYFDxYBA3hyyuqGnyFCtsNmKiA7W9XBWOyqfjQG5OOR0wZUCDJK3xAjSJZ
         x9nOPWdFTn4RBpSOkRzNwUUfgqtL/qpXS/M89owdErTTZZbC+m8aXjdlZkNDr6NiMG7H
         oGPuPDfo/zXDZz5Y37r6wYMOQqjy8UWrLbJGoNLy6oUC8ye//r19MHBh7k6HGldJlfWM
         KU4vScvTX16w27fE48+9BABGlRvYmhlcveI57obNELn4NPBS/2oSLqgt5omS0356GQbd
         /DmfHew05aHImL5H8cUAQUc9+CsZtbLd18snEbSlXzwtu4b1UwD/Cq8mH1XFZBb+6kPw
         Gn8w==
X-Gm-Message-State: AOJu0Yz3eJLND9vzNxaDPk0wB9Kd2gtaiEdWVAk5vgMvSdPekscHwNPE
	nCOaKr0MX5lrLXyRH5S4vTL7JEHE5iGKqg==
X-Google-Smtp-Source: AGHT+IF8ifUaZYi3h2dpkyQyNLUFa2dU51Nl44F29lXaodtTACoEGAlJo2f4GC9w5VjY5g3g1kgEbIHh0W9Iaw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1612:b0:d47:f09c:cc8e with SMTP
 id bw18-20020a056902161200b00d47f09ccc8emr8411ybb.10.1692418008682; Fri, 18
 Aug 2023 21:06:48 -0700 (PDT)
Date: Sat, 19 Aug 2023 04:06:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230819040646.389866-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net: annotate data-races around sk->sk_lingertime
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

sk_getsockopt() runs locklessly. This means sk->sk_lingertime
can be read while other threads are changing its value.

Other reads also happen without socket lock being held,
and must be annotated.

Remove preprocessor logic using BITS_PER_LONG, compilers
are smart enough to figure this by themselves.

v2: fixed a clang W=1 (-Wtautological-constant-out-of-range-compare) warning
    (Jakub)

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/bluetooth/iso.c |  2 +-
 net/bluetooth/sco.c |  2 +-
 net/core/sock.c     | 18 +++++++++---------
 net/sched/em_meta.c |  2 +-
 net/smc/af_smc.c    |  2 +-
 5 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 6b66d6a88b9a22adf208b24e0a31d6f236355d9b..3c03e49422c7519167a0a2a6f5bdc8af5b2c0cd0 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1475,7 +1475,7 @@ static int iso_sock_release(struct socket *sock)
 
 	iso_sock_close(sk);
 
-	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
+	if (sock_flag(sk, SOCK_LINGER) && READ_ONCE(sk->sk_lingertime) &&
 	    !(current->flags & PF_EXITING)) {
 		lock_sock(sk);
 		err = bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingertime);
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 50ad5935ae47a31cb3d11a8b56f7d462cbaf2366..c736186aba26beadccd76c66f0af72835d740551 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -1245,7 +1245,7 @@ static int sco_sock_release(struct socket *sock)
 
 	sco_sock_close(sk);
 
-	if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime &&
+	if (sock_flag(sk, SOCK_LINGER) && READ_ONCE(sk->sk_lingertime) &&
 	    !(current->flags & PF_EXITING)) {
 		lock_sock(sk);
 		err = bt_sock_wait_state(sk, BT_CLOSED, sk->sk_lingertime);
diff --git a/net/core/sock.c b/net/core/sock.c
index a0722954e4a8fce5d4f2a24161c36309e6df295a..666a17cab4f5605076af3f929864d03bc5e90058 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -797,7 +797,7 @@ EXPORT_SYMBOL(sock_set_reuseport);
 void sock_no_linger(struct sock *sk)
 {
 	lock_sock(sk);
-	sk->sk_lingertime = 0;
+	WRITE_ONCE(sk->sk_lingertime, 0);
 	sock_set_flag(sk, SOCK_LINGER);
 	release_sock(sk);
 }
@@ -1230,15 +1230,15 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			ret = -EFAULT;
 			break;
 		}
-		if (!ling.l_onoff)
+		if (!ling.l_onoff) {
 			sock_reset_flag(sk, SOCK_LINGER);
-		else {
-#if (BITS_PER_LONG == 32)
-			if ((unsigned int)ling.l_linger >= MAX_SCHEDULE_TIMEOUT/HZ)
-				sk->sk_lingertime = MAX_SCHEDULE_TIMEOUT;
+		} else {
+			unsigned long t_sec = ling.l_linger;
+
+			if (t_sec >= MAX_SCHEDULE_TIMEOUT / HZ)
+				WRITE_ONCE(sk->sk_lingertime, MAX_SCHEDULE_TIMEOUT);
 			else
-#endif
-				sk->sk_lingertime = (unsigned int)ling.l_linger * HZ;
+				WRITE_ONCE(sk->sk_lingertime, t_sec * HZ);
 			sock_set_flag(sk, SOCK_LINGER);
 		}
 		break;
@@ -1692,7 +1692,7 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 	case SO_LINGER:
 		lv		= sizeof(v.ling);
 		v.ling.l_onoff	= sock_flag(sk, SOCK_LINGER);
-		v.ling.l_linger	= sk->sk_lingertime / HZ;
+		v.ling.l_linger	= READ_ONCE(sk->sk_lingertime) / HZ;
 		break;
 
 	case SO_BSDCOMPAT:
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 6fdba069f6bfd306fa68fc2e68bdcaf0cf4d4e9e..da34fd4c92695f453f1d6547c6e4e8d3afe7a116 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -502,7 +502,7 @@ META_COLLECTOR(int_sk_lingertime)
 		*err = -1;
 		return;
 	}
-	dst->value = sk->sk_lingertime / HZ;
+	dst->value = READ_ONCE(sk->sk_lingertime) / HZ;
 }
 
 META_COLLECTOR(int_sk_err_qlen)
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index f5834af5fad535c420381827548cecdf0d03b0d5..7c77565c39d19c7f1baf1184c4a5bf950c9cfe33 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -1820,7 +1820,7 @@ void smc_close_non_accepted(struct sock *sk)
 	lock_sock(sk);
 	if (!sk->sk_lingertime)
 		/* wait for peer closing */
-		sk->sk_lingertime = SMC_MAX_STREAM_WAIT_TIMEOUT;
+		WRITE_ONCE(sk->sk_lingertime, SMC_MAX_STREAM_WAIT_TIMEOUT);
 	__smc_release(smc);
 	release_sock(sk);
 	sock_put(sk); /* sock_hold above */
-- 
2.42.0.rc1.204.g551eb34607-goog


