Return-Path: <netdev+bounces-95415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 441158C22FF
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 13:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673B01C212F3
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 11:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F232F1708A0;
	Fri, 10 May 2024 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ARIWUGbW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53EA17089A;
	Fri, 10 May 2024 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339949; cv=none; b=nXsRAFP5/hmMmSlAzF51DvGBgq1H7X1X2NSUquYCHipNPUyZ+BkN8qQwKwAqvhj3FA/EMGG5t2GsUfepxPGoRVj04UJqDDhMtWoSvG+NIoLP5dSNSM4RrkRqUEIkupoZJs8LZBjhPrz1plpP42VpeXPf0fhvlP7y7ZymrtUr+Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339949; c=relaxed/simple;
	bh=xbCxQm7NYK+1wRRkdU1YZqrQE67obVDoGOLdbAX28Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AnqAexhRUcz/j0asQ5UxmdO6oTQFhV6MDVcY3So+02ADWQh6C+sJV6SJkxqaaWsrPN+Lj+vrWxXYe5sk933mwRy+2FiYobY8+DNEYHLmUhnQxLEqvImg0Pv+hodmIE/5wZLLCh5gcBldhe/I2ISQiwh04TP9P+ZNvMjVS5aiOuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ARIWUGbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF1FC2BD11;
	Fri, 10 May 2024 11:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715339949;
	bh=xbCxQm7NYK+1wRRkdU1YZqrQE67obVDoGOLdbAX28Bo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ARIWUGbWqjKWCzXGTQUsQW2kEIY4+1FUaei1Ipim4kPSjhDdPLzYJttG293hD5XUV
	 cIKGsTfW7rKLfeuGOudfHCPdb1VKXPSHBbUD3PZraHS5zpFhbgQ44LALBsHgpFROWU
	 qZRNffnB9x5n18eYNYUQAf+X4dAd2XKgFYB5jYW6Y+OaMekwLZTcVWN56m4f2V0sjV
	 9spu5B272P33AsuXF0VEpOIph2Z3/XLaqAR8FumVd/5+NcBF0UwoLS1bG1qD2M4q49
	 1XSeDb0fXUrjRcVXSQexJyxrr0KtgFP5D0N4nJ1DMQQkaf8hcOZgW2IurT70hESj8l
	 VxEVwp5RsISOg==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 10 May 2024 13:18:35 +0200
Subject: [PATCH net-next 5/8] mptcp: prefer strscpy over strcpy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240510-upstream-net-next-20240509-misc-improvements-v1-5-4f25579e62ba@kernel.org>
References: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
In-Reply-To: <20240510-upstream-net-next-20240509-misc-improvements-v1-0-4f25579e62ba@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2664; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xbCxQm7NYK+1wRRkdU1YZqrQE67obVDoGOLdbAX28Bo=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmPgKcc2r9q5h7H1i/aLEx24OsCJy2Wa1zE3IeU
 fhSct5FzEqJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZj4CnAAKCRD2t4JPQmmg
 c7sPD/4hpkNHeOFB5lQSXgVrUQw2P3twOxcElic9JWU8YWa9taxfoCiyiX3HrgtDf3Q0o4F2lxb
 OE0UvdLcJ19w/JiBe/zpYPP99i/zsPCjdHSxhABcFC8RNOdm+cQY6AM1EBf7p/dkXc4M0YQrZzv
 m+mmh/T+Th/8Mz/ZFIL5wRRVB7SQZ+MiSAapKVOEFb+v698ho2LMFYoR1hLi0jp58zYoxCEJNIU
 JU+eiW9rJitvYfjeUv2XZ8fwfLc2IogattzWZLl600PdCxMpRhPz8VddaCjF5stqLxwD+F88rRJ
 obyAMIgvRW8CGxdl2TYFjKBLPMrO8OUvKeUfyo01jJJ4iGRfcnKMRrGZM2QB0XUxkfqY4Zsu8HT
 39myYfpwbsLdhYe2VbLl+YmVm5NIgY4PgISPPGfzgvvMW3SQWO5CGNVx5Qzz3qS3ibxWdlhaJAv
 LCbHfX60lhnoojQKcNQsmOQmFcEJ8q4eQTu6JgkBwUOhJf4N9nlFDWs9AY/dXmMx39H8IA1evUB
 0ljpYDgA4cqnWQKMsQixTFMaTjN1m/cIftewQFybJRlhy/FmHx9zo5ggXSdscU34a1updoTfRRi
 k9Gfc1A9pYCGMHEGArpZxmCK09fTgtm9ckdWfwZ48IGheFtTgIxeRX3l6EJ30TCSzFXdVIQHv3w
 XGyRvEbbr1I0UaQ==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy() [1].

This is in preparation of a possible future step where all strcpy() uses
will be removed in favour of strscpy() [2].

This fixes CheckPatch warnings:

  WARNING: Prefer strscpy over strcpy

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Link: https://github.com/KSPP/linux/issues/88 [2]
Reviewed-by: Geliang Tang <geliang@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/ctrl.c     | 2 +-
 net/mptcp/protocol.c | 5 +++--
 net/mptcp/sockopt.c  | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 542555ba474c..98b1dd498ff6 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -92,7 +92,7 @@ static void mptcp_pernet_set_defaults(struct mptcp_pernet *pernet)
 	pernet->allow_join_initial_addr_port = 1;
 	pernet->stale_loss_cnt = 4;
 	pernet->pm_type = MPTCP_PM_TYPE_KERNEL;
-	strcpy(pernet->scheduler, "default");
+	strscpy(pernet->scheduler, "default", sizeof(pernet->scheduler));
 }
 
 #ifdef CONFIG_SYSCTL
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index bb8f96f2b86f..a42494d3a71b 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2814,7 +2814,8 @@ static void mptcp_ca_reset(struct sock *sk)
 	struct inet_connection_sock *icsk = inet_csk(sk);
 
 	tcp_assign_congestion_control(sk);
-	strcpy(mptcp_sk(sk)->ca_name, icsk->icsk_ca_ops->name);
+	strscpy(mptcp_sk(sk)->ca_name, icsk->icsk_ca_ops->name,
+		sizeof(mptcp_sk(sk)->ca_name));
 
 	/* no need to keep a reference to the ops, the name will suffice */
 	tcp_cleanup_congestion_control(sk);
@@ -4169,7 +4170,7 @@ int __init mptcp_proto_v6_init(void)
 	int err;
 
 	mptcp_v6_prot = mptcp_prot;
-	strcpy(mptcp_v6_prot.name, "MPTCPv6");
+	strscpy(mptcp_v6_prot.name, "MPTCPv6", sizeof(mptcp_v6_prot.name));
 	mptcp_v6_prot.slab = NULL;
 	mptcp_v6_prot.obj_size = sizeof(struct mptcp6_sock);
 	mptcp_v6_prot.ipv6_pinfo_offset = offsetof(struct mptcp6_sock, np);
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index cc9ecccf219d..0f6ef494525f 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -616,7 +616,7 @@ static int mptcp_setsockopt_sol_tcp_congestion(struct mptcp_sock *msk, sockptr_t
 	}
 
 	if (ret == 0)
-		strcpy(msk->ca_name, name);
+		strscpy(msk->ca_name, name, sizeof(msk->ca_name));
 
 	release_sock(sk);
 	return ret;

-- 
2.43.0


