Return-Path: <netdev+bounces-98089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 112958CF4A8
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 16:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A678E1F21169
	for <lists+netdev@lfdr.de>; Sun, 26 May 2024 14:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE284171C9;
	Sun, 26 May 2024 14:57:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.67.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2751863E;
	Sun, 26 May 2024 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.67.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716735472; cv=none; b=mEAr0NZSJrdspEiay4mzqIYqBiQOPUAAfDF3MrXqzBQQ+bzFw9DsEZX8Lx6Po+e5ujjFPbc/B6QAjUq70WvmKnRtFTMzOoqsD0ydhn87CAxalsYwS19bRGvT3pAMRFUpK5C3vGL+X1++lDpD11kaZDpj9V0sTuxyGOSQCgSsylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716735472; c=relaxed/simple;
	bh=nrD4hFFvapXYZd2L53EHBsQezPh8Yz2h9r35lDCw8rA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dEuRAL9pB1XqFTjkD9JxJldczDoQw/Fd9GU4xlogCqeLAlpRsZLJ4wbGslEnE9AY0mhV+OAVe9NVZeO5wMdMZe7Gfa4+VA43yCEEzMxW0godki7Xv+FJTlLXw5hxgXrRgQkgc2Fef/mFFn88Cqcb4Uvr0pKDpHf4GvPlMoMf8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.67.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp90t1716735448tjvg0qfg
X-QQ-Originating-IP: K72cxvKEX3Aw3XDhR4O/4VT8Xy+EieP4tjIR8Zz/AfM=
Received: from localhost.localdomain ( [125.76.217.162])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 26 May 2024 22:57:26 +0800 (CST)
X-QQ-SSF: 01400000000000I0J000000A0000000
X-QQ-FEAT: D6RqbDSxuq6QJkXJx+RtBYhcIlGiq6QAi8sR0DhEb4B9PY63Zcngyo2cg4aJi
	TryaNq8M8wR/IPplEXxsI7zOmjJ8Ski90vfc7lST+mXwxPYllM+XB5ucAXTF70fndovfCqt
	8JegV229Yz6Tb/kC/CRBoomQjWj6nqWhxhlvWSRWFgWYYlfFsFJy5sHwBQxOPAXDoyTyD6q
	RAx8r2HbltBUj86hy09lRg29WN9JqjpDIMY/h2k6MIudZF+NB3EnQvT6KkWW/+b7htK1FFF
	YfXuKVl4kbZE/N/OE9rYnInDHhtzCRH7T1tk5GvhN2s+X3C8lNR7bRXzA7cN1zqnq21ylRX
	CsQPmzKgActsdmT8xlHvWqs2aWhDGsCRAc9HaH0Q5uoFkQ9P0ZsvjqAgFQxsuUOxCjfGutg
	GnqYmbqcfxg7Ry/dgFmXQ5/j25Oa0Y4g
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1830244723863975844
From: Gou Hao <gouhao@uniontech.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	wuyun.abel@bytedance.com,
	leitao@debian.org,
	alexander@mihalicyn.com,
	dhowells@redhat.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	zhanjun@uniontech.com,
	gouhaojake@163.com
Subject: [PATCH 2/2] net/core: move the lockdep-init of sk_callback_lock to sk_init_common()
Date: Sun, 26 May 2024 22:57:18 +0800
Message-Id: <20240526145718.9542-2-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240526145718.9542-1-gouhao@uniontech.com>
References: <20240526145718.9542-1-gouhao@uniontech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-2

In commit cdfbabfb2f0c ("net: Work around lockdep limitation in
sockets that use sockets"), it introduces 'af_kern_callback_keys'
to lockdep-init of sk_callback_lock according to 'sk_kern_sock',
it modifies sock_init_data() only, and sk_clone_lock() calls
sk_init_common() to initialize sk_callback_lock too, so the
lockdep-init of sk_callback_lock should be moved to sk_init_common().

Signed-off-by: Gou Hao <gouhao@uniontech.com>
---
 net/core/sock.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 67b10954e0cf..521e6373d4f7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2262,7 +2262,12 @@ static void sk_init_common(struct sock *sk)
 	lockdep_set_class_and_name(&sk->sk_error_queue.lock,
 			af_elock_keys + sk->sk_family,
 			af_family_elock_key_strings[sk->sk_family]);
-	lockdep_set_class_and_name(&sk->sk_callback_lock,
+	if (sk->sk_kern_sock)
+		lockdep_set_class_and_name(&sk->sk_callback_lock,
+			af_kern_callback_keys + sk->sk_family,
+			af_family_kern_clock_key_strings[sk->sk_family]);
+	else
+		lockdep_set_class_and_name(&sk->sk_callback_lock,
 			af_callback_keys + sk->sk_family,
 			af_family_clock_key_strings[sk->sk_family]);
 }
@@ -3460,17 +3465,6 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	}
 	sk->sk_uid	=	uid;
 
-	if (sk->sk_kern_sock)
-		lockdep_set_class_and_name(
-			&sk->sk_callback_lock,
-			af_kern_callback_keys + sk->sk_family,
-			af_family_kern_clock_key_strings[sk->sk_family]);
-	else
-		lockdep_set_class_and_name(
-			&sk->sk_callback_lock,
-			af_callback_keys + sk->sk_family,
-			af_family_clock_key_strings[sk->sk_family]);
-
 	sk->sk_state_change	=	sock_def_wakeup;
 	sk->sk_data_ready	=	sock_def_readable;
 	sk->sk_write_space	=	sock_def_write_space;
-- 
2.20.1


