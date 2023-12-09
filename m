Return-Path: <netdev+bounces-55553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FA880B3E1
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 12:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68BB51C2093E
	for <lists+netdev@lfdr.de>; Sat,  9 Dec 2023 11:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3913AE3;
	Sat,  9 Dec 2023 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="iMDwsRhC"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB1310C8;
	Sat,  9 Dec 2023 03:05:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1702119867; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=J05YNytQQ08OVuEdffm0ONXgnJz70v6PpR74ibqfIFaAG39gVFS/F97r+BcBED5cTm/SqE7UOUJb8ufbVLVymHG1haE6V69eEV9Fhu0KSObbOfK5RlJHF+xHQ4PccxoWt9vwb/C9iGs8Ks501gwQ+fNoyikp+ENGb4YRAMRyjME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1702119867; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Scp3IrJnE67ltgIhAprfULm6HsQ/s5KxrhhmK7w7AQs=; 
	b=ZDAUYayn2MUkW3y3O+V8hqpZbFHaay/Av5s+Gxd8bhI626qK4Ixg73Z/4FvrCzYxjv6FQmvbCBFyZREoF8CThp468IN5u+me/YaOdrQCmn7k17dWkpZspoV6at+Eh28ZAQz9LCsmc40K12X3Wzm80+K66QiU+r7l0/UuNj67sqQ=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1702119867;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=Scp3IrJnE67ltgIhAprfULm6HsQ/s5KxrhhmK7w7AQs=;
	b=iMDwsRhC0/xem8Bu+VmUiIJDrKS1Ja2e/WXxWEMgbD3barv4hDhni9K2KkfF6YTb
	edfvTrwBZtrR8tcC0BMujRKxjRwPPpn+LH+xCNcTj6t+ESAPyy+8J/QoJg88o33awNA
	BDHWs7LuOHQLwZue22pKG7+9Src4aeeu+DFyaeJo=
Received: from kampyooter.. (110.227.243.208 [110.227.243.208]) by mx.zoho.in
	with SMTPS id 1702119865580645.3578578519617; Sat, 9 Dec 2023 16:34:25 +0530 (IST)
From: Siddh Raman Pant <code@siddh.me>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Suman Ghosh <sumang@marvell.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/2] nfc: Do not send datagram if socket state isn't LLCP_BOUND
Date: Sat,  9 Dec 2023 16:34:21 +0530
Message-ID: <a7cc7f6c6fce30fee695297664d24516103ac667.1702118242.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1702118242.git.code@siddh.me>
References: <cover.1702118242.git.code@siddh.me>
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


