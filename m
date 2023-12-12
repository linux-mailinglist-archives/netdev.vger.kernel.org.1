Return-Path: <netdev+bounces-56556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C29FD80F5B8
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 19:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789721F2175F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 18:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121ED7F558;
	Tue, 12 Dec 2023 18:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="k0wHo+ms"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C31CF;
	Tue, 12 Dec 2023 10:49:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702406967; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=XpzMMmouJS+8v/yHAlGE+Vj0dS7q19omTsyt9qq81XP91R//5rD+1t86xedine7cqif/Nq0aOuXshoneQ9G7tgDrHYqmK9+DsX3pV8+dYuAodaA/wJA6geCRnPBYTu/2Fc2xdIZBrf3DFXPD8TPCxRLgOBzRYO8BN482GlestYI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1702406967; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Scp3IrJnE67ltgIhAprfULm6HsQ/s5KxrhhmK7w7AQs=; 
	b=YlEi3Tx5nLg4cA0rF76WQsConbJT/jLXHHC0VjA4KY45oHiqQXyM5SRuQMJc0UK8+FwF4VFyHB8sUZ7Z3QqK7Tx+CdQkkSOck2jiW2FoJ29EB7rpZmL2Iw/oA7tmoa3woKo67DHNGLXWT7S5oFn5nxNxToqjh2zy1Qi5JvvlUxE=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702406967;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Scp3IrJnE67ltgIhAprfULm6HsQ/s5KxrhhmK7w7AQs=;
	b=k0wHo+mshJJqA16AI3bcFJ/7cbLuMAXKkpgdSDg5+800Pq4Dqtac8nanoCvjXxoa
	bTyb6S6oc0RmxKM4qHgU0UyhJRY/bYQ/zL6N49CZ3L2J3Xg7jHHUd3J8mOLsA9fQSsk
	SCRBvYdf3vgFvgEtvAZLj5bgT3/YYrKuhlnY4g5c=
Received: from kampyooter.. (182.69.31.144 [182.69.31.144]) by mx.zoho.in
	with SMTPS id 1702406966251239.8701045805791; Wed, 13 Dec 2023 00:19:26 +0530 (IST)
From: Siddh Raman Pant <code@siddh.me>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Suman Ghosh <sumang@marvell.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v5 2/2] nfc: Do not send datagram if socket state isn't LLCP_BOUND
Date: Wed, 13 Dec 2023 00:19:20 +0530
Message-ID: <8a44ed2afb2f02be34d57d56c6836a5b911bffb0.1702404519.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702404519.git.code@siddh.me>
References: <cover.1702404519.git.code@siddh.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

As we know we cannot send the datagram (state can be set to LLCP_CLOSED
by nfc_llcp_socket_release()), there is no need to proceed further.

Thus, bail out early from llcp_sock_sendmsg().

Signed-off-by: Siddh Raman Pant <code@siddh.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Suman Ghosh <sumang@marvell.com>
---
 net/nfc/llcp_sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 645677f84dba..819157bbb5a2 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -796,6 +796,11 @@ static int llcp_sock_sendmsg(struct socket *sock, struct msghdr *msg,
 	}
 
 	if (sk->sk_type == SOCK_DGRAM) {
+		if (sk->sk_state != LLCP_BOUND) {
+			release_sock(sk);
+			return -ENOTCONN;
+		}
+
 		DECLARE_SOCKADDR(struct sockaddr_nfc_llcp *, addr,
 				 msg->msg_name);
 
-- 
2.42.0


