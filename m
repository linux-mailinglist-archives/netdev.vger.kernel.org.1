Return-Path: <netdev+bounces-53265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 073F9801D82
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 16:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AF4F1F2109D
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 15:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C329219465;
	Sat,  2 Dec 2023 15:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=siddh.me header.i=code@siddh.me header.b="fanfBt63"
X-Original-To: netdev@vger.kernel.org
Received: from sender-of-o51.zoho.in (sender-of-o51.zoho.in [103.117.158.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E6A11F;
	Sat,  2 Dec 2023 07:41:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701531674; cv=none; 
	d=zohomail.in; s=zohoarc; 
	b=II7atRkYs8DsFlatf6IG3jLHij/WBsxs9ClikySOYt9Ld+Wxut/l+lQGqFv03/QyDQkgW1/iKJV57ETeOp8eyZ5b1AnKX4Wf2rBtqwIpWYGvlNd8RIdsviMPSPLYpt0uh70vZFLlaHIVRhferCocCQ3+c68XoxAGwUkqYiioU6o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
	t=1701531674; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hsnJ/KNlUs6XiyX2XlbfSpC3bHgmAF/BmM03d8xcwm0=; 
	b=GB7rkLQU8d5MPzNqT5EFrGs6w19XCDgho+G31jgynu6FrgWPiMm2L4mS+BShCCfkLeObe4RXblrAUvVRv8oJrhbkdASnWpWmlBKYJrHRDg7Zzx3ixOe0g2kkgL7256LscGndraMp2awmPngYNR64gf9BzYDo7V8M2sYJCAAnqZk=
ARC-Authentication-Results: i=1; mx.zohomail.in;
	dkim=pass  header.i=siddh.me;
	spf=pass  smtp.mailfrom=code@siddh.me;
	dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1701531674;
	s=zmail; d=siddh.me; i=code@siddh.me;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=hsnJ/KNlUs6XiyX2XlbfSpC3bHgmAF/BmM03d8xcwm0=;
	b=fanfBt63yWMtEPnCArLJt8IPBOtbC+KKbFKtgD2C4ukNf5RgMGkWkLDKuwnsG9mr
	WU0ca/mPoiAPjysWoRKwWEL6VjR9Gu8FtOgO5/9C7qJq8bN1RmZAIjeoj76ridGLBJR
	OfPCfPbBuKmKPfi+5921LqlKLLaPECBG/HPhiVCc=
Received: from kampyooter.. (122.170.35.155 [122.170.35.155]) by mx.zoho.in
	with SMTPS id 1701531672332946.1333406858636; Sat, 2 Dec 2023 21:11:12 +0530 (IST)
From: Siddh Raman Pant <code@siddh.me>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>
Subject: [PATCH net-next v2 2/2] nfc: Do not send datagram if socket state isn't LLCP_BOUND
Date: Sat,  2 Dec 2023 21:10:59 +0530
Message-ID: <fed27fede2b38a190e24b0d4b53306eeece22ec4.1701530776.git.code@siddh.me>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1701530776.git.code@siddh.me>
References: <cover.1701530776.git.code@siddh.me>
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


