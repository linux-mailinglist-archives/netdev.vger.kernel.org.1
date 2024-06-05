Return-Path: <netdev+bounces-100850-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1225A8FC452
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9472889E8
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 07:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34FA21C190;
	Wed,  5 Jun 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgpvu7o8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C545621C187;
	Wed,  5 Jun 2024 07:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717571777; cv=none; b=tSn5McwzYJlpVaNBd8e61phn+Tj3BjPfTkM3+nD4x/cIzbCbCfgD0XXC1ipIxlqA/N8NpQ0HfdcOTPIf9zYw5QUWEYmhKFg94esZU88PghlYO4OvW14UOHD0n+drHZLETPCa8xKuLzoQeXV5NCU2dg97vCa0bYRrRwVywO9GC2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717571777; c=relaxed/simple;
	bh=LOBwy5aLlC0g+D8jrSC0hZDHeIAdkfdzQ+XApr6oUvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PNVztmU9u5U88FKYtRDO6i71hrakSG/vXvqdjHwgh4hoUP4nNn7AGxG1DX3kbwlEcddY3mTsjMQqM/er/lGGJfBC4hAfod1ib1tk0UHsWU1HL1bjHMYrfL5gSyJyOUzLvmxJxew8yJgugHiTYvuU2mqTb42WT/THLNDMHf9fcgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgpvu7o8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F9DC4AF07;
	Wed,  5 Jun 2024 07:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717571777;
	bh=LOBwy5aLlC0g+D8jrSC0hZDHeIAdkfdzQ+XApr6oUvY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fgpvu7o8JCxjr3nmQGh/TFcTCl+/Xv10MBugAQ8UP49s++gxsVXkp1hWtuSTwZhuW
	 xukfvBJgfh3caJH9V+BAgUAy+iUrTo4R6WgZKn1FRWBQ+UOIrUN+4vimPHAZnBDVZJ
	 0G+jvMkyewnYSavVQu8ZjqzUcFVYTZhbOT2lT6ltMGE/LHP0azWDDHPQpkcBRuxrwP
	 xzpb0q3tWKd4avp1RXfmfjhkOIP4buoPmcHebzithY60fjTo53TJdbTuRyrJca9Jcj
	 4KBaux0BunwX6omuzfJqMVWgda+J1+5N5yHNwufi3320sYN6HqAlAyyInxi6F0s5Il
	 bOxEM6TEcnKHw==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Wed, 05 Jun 2024 09:15:40 +0200
Subject: [PATCH net-next 1/3] mptcp: use mptcp_win_from_space helper
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240605-upstream-net-next-20240604-misc-cleanup-v1-1-ae2e35c3ecc5@kernel.org>
References: <20240605-upstream-net-next-20240604-misc-cleanup-v1-0-ae2e35c3ecc5@kernel.org>
In-Reply-To: <20240605-upstream-net-next-20240604-misc-cleanup-v1-0-ae2e35c3ecc5@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>, 
 Geliang Tang <tanggeliang@kylinos.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1013; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=xSJg35UP/4cXaiH0S4yJZVk63acIeOzJ2YCZ8nw/uSk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBmYBC6tQGVmVNayvDuFQ0uSQcQKfSTGkOnywo74
 kPdeTjTUO2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZmAQugAKCRD2t4JPQmmg
 c3FBEADKPoboOFju1iwc5k09MjSZt6izgwv36ugPM5NPh2oOglW9RqXzzqdf5FpSA8W11dW/dlh
 +Cem2ztUZ+LerSpcLixoJTsr3GNgu15a9B0c9XHY0PQxwAAkWd7UYUFMJJ6JngqA8Bn1CRlLZAb
 NJ1Qj7PB1GX2hvnEQXF9QdBV1dtfEEGH7VJDCOEkf2fSBWMuTuYwSFsET9BpX+lk2H0eoDmDhLb
 e3QpYHplGNdVbzq7sgnIWoDiSPFvm5AwCMnP0h+jybNjkHXnLmv0BxINOb4Z6+LnguovBgT12Wi
 bHtTwyzgQyHqCxb43YZI7KnyLbSKIwhdAT/edw6enaDMPi+UYs5XQhYVsAu6/K1KkN3lM6vZsa0
 We1sEwx1K4REkjuuj2swerR1prKAuRLfrdtn8xnzIPxyEQ7tJ3kK1R9pX9N/uh93ETfEc+nwnar
 tltlnZIENCCvthyNFEfMEKz6t6kjsXjdRcbW6nNObBwH22xO4rh1auohZ9noe2yfWjOCH1IhwWH
 j2ahcBUvefWa/Q/+7EzOlraTf8X03+FSTOo3iTraYK4euD1DqNoZNl8g0PK+WrOu+PiSxO8x14F
 lKmyqSkJvCHMHeGG0vlttZXmbXJc8/YmsU6MPs7LugS++f6yCu/xCtCTnocn6CKhEgUJ8b+NTOc
 RMcZzK05n0VJT9g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Geliang Tang <tanggeliang@kylinos.cn>

The MPTCP dedicated win_from_space helper mptcp_win_from_space() is defined
in protocol.h, use it in mptcp_rcv_space_adjust() instead of using the TCP
one. Here scaling_ratio is the same as msk->scaling_ratio.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 7d44196ec5b6..546c80c6702a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -2046,7 +2046,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 		if (rcvbuf > sk->sk_rcvbuf) {
 			u32 window_clamp;
 
-			window_clamp = __tcp_win_from_space(scaling_ratio, rcvbuf);
+			window_clamp = mptcp_win_from_space(sk, rcvbuf);
 			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
 
 			/* Make subflows follow along.  If we do not do this, we

-- 
2.43.0


