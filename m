Return-Path: <netdev+bounces-181053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B49CA8376C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 05:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0823BAFF7
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15BF31F12F6;
	Thu, 10 Apr 2025 03:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="S2/s9RzP"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F77D1E5734
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744257236; cv=none; b=TmhhVd5x7ynKTCq4TQp0q1VCAUr0D2mhiKt5FZIchSalfFx0+s0P3fxG1ELIlYeD2VukiKK3rFyMQIJOKth7X2HqN7nt5y76nqDOJbzLpvq5BhqMJAx+LwCGJNXt95ytUGV+sEIG35napKOD89QncTHB/J90uJ3NNazg2AgG8eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744257236; c=relaxed/simple;
	bh=CU5MCPkXa2yqFbSriKG60zWvrUrMajHUhDAsuIO7u2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EfMLyWOLj6WcVlSAfVf2LwYyy8H37FRr8Mwd6qrG6ImDpkzD6HqpfznP6thBnR7X3XHCE03u7km6g/U5xi1dQ30RpLMFbDdIxS5XTSGJWn1j4uGeMz5k4Ajzc5cQnXK/bizPWLegh0Np4B0PhtxGiIvwF/GwbEtU60b5Yja9dF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=S2/s9RzP; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1744257225;
	bh=2uqj/6xaiiAzficmKx6oRmf4/bzarQ7WTSUwETnTF3c=;
	h=From:Date:Subject:To:Cc;
	b=S2/s9RzPsUKgbS6+VxvBe60qhhpvGZvP29X8H6RMVd6k+czdZWQfnInlU0aSdJRuU
	 iJTweraXlDWOjVa3/T8J+YoiMC2tsojo+CQTnWx5TNrdxT9Emo4/S+cQUHEn2PkNe3
	 q2yCP4PTACgKnI19UV+G2XT0cVl1yxmR3lDqL+EfrdZUMfAtWvBsTg4Q9fyh7HNGky
	 mmVDDULgz7jWiU/0jX3/ub+Jjr+2tKGji37Vr30Fam2omcNrNka8F6e572IIm+Y06K
	 WPB08DfFYhfG7aRDXZsx6qssLdRu7hgmyrQ1ynprZPfb3XAdNwjTrE0PJAox8Gh7r3
	 5h79keceGVpYw==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 336BD7D3CF; Thu, 10 Apr 2025 11:53:45 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 10 Apr 2025 11:53:19 +0800
Subject: [PATCH net] net: mctp: Set SOCK_RCU_FREE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250410-mctp-rcu-sock-v1-1-872de9fdc877@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAK5A92cC/x3MQQqAIBBA0avErBvQKMquEi1KxxoiC7UIwrsnL
 d/i/xcCeaYAffGCp5sDHy5DlgXodXILIZtsqETViFoK3HU80esLw6E3FFa2zWxUrdoOcnN6svz
 8vwEcRRhT+gDoRajpZAAAAA==
X-Change-ID: 20250410-mctp-rcu-sock-0f175bd94978
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744257224; l=991;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=CU5MCPkXa2yqFbSriKG60zWvrUrMajHUhDAsuIO7u2I=;
 b=qr4+E+IpcVrKbb4lKeRCnRCDNWo+QmaI2CsLULTxv6ICEW6krFhedAjG5/lwNGsh3q8pNIxVJ
 1wZ3F+IYaODD3FB1hfhdhMkisWlBzo1ZLjrFkJGhM3M/4hYISj25V2I
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Bind lookup runs under RCU, so ensure that a socket doesn't go away in
the middle of a lookup.

Fixes: 833ef3b91de6 ("mctp: Populate socket implementation")
Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 net/mctp/af_mctp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index f6de136008f6f9b029e7dacc2e75dce1cd7fd075..57850d4dac5db946420120f8b15c82704c1044e7 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -630,6 +630,9 @@ static int mctp_sk_hash(struct sock *sk)
 {
 	struct net *net = sock_net(sk);
 
+	/* Bind lookup runs under RCU, remain live during that. */
+	sock_set_flag(sk, SOCK_RCU_FREE);
+
 	mutex_lock(&net->mctp.bind_lock);
 	sk_add_node_rcu(sk, &net->mctp.binds);
 	mutex_unlock(&net->mctp.bind_lock);

---
base-commit: 0bb2f7a1ad1f11d861f58e5ee5051c8974ff9569
change-id: 20250410-mctp-rcu-sock-0f175bd94978

Best regards,
-- 
Matt Johnston <matt@codeconstruct.com.au>


