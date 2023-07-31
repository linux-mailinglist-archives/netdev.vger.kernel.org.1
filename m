Return-Path: <netdev+bounces-22859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF2D769A52
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 17:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8351C20BC4
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 15:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FD4418C1C;
	Mon, 31 Jul 2023 15:06:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7F018C17
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:06:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44527C433C8;
	Mon, 31 Jul 2023 15:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690815992;
	bh=SmbB1NRVGfVe43ZZQ5eHW0QwfIzFtOhbwfNqlWANFaw=;
	h=From:To:Cc:Subject:Date:From;
	b=hGixK/jIkwNsyaHCEn6I2bAnU/Cpb4O4WJy+Qco99VGW42GDxpCGuB9/Xruc42mSz
	 WYu3doUmQFaR8BxO8PjlFQNMKnv4MvMD2wGYbeUsyybqOLk1DfFRjKYsTjj54h7clJ
	 Gb520eow1Vxlee1He+NhpTnfDEZPTfP//Oo9UDqMHHjXAWfSUuzZC05fJTXQxX7kgf
	 /PDbq0n22/7QtoYpfcSN3NzC5/6onO4gMIpZcFadlAKz49DsfmvOoWytAGg9UJs7fI
	 4p3h3DR6KggZ/oRr7ERQemn4kVWKqlcIIc4Afl4OSb8GM/8T41b/rqfo3DkiumkaDw
	 MhQXV6TQGp9CQ==
From: Jakub Kicinski <kuba@kernel.org>
To: dsahern@gmail.com
Cc: stephen@networkplumber.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH iproute2-next] ss: report when the RxNoPad optimization is set on TLS sockets
Date: Mon, 31 Jul 2023 08:06:28 -0700
Message-ID: <20230731150628.419715-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to RO ZC report when RxNoPad is set.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 misc/ss.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/misc/ss.c b/misc/ss.c
index e9d813596b91..c71b08f98525 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -2983,12 +2983,6 @@ static void tcp_tls_conf(const char *name, struct rtattr *attr)
 	}
 }
 
-static void tcp_tls_zc_sendfile(struct rtattr *attr)
-{
-	if (attr)
-		out(" zc_ro_tx");
-}
-
 static void mptcp_subflow_info(struct rtattr *tb[])
 {
 	u_int32_t flags = 0;
@@ -3219,7 +3213,10 @@ static void tcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,
 			tcp_tls_cipher(tlsinfo[TLS_INFO_CIPHER]);
 			tcp_tls_conf("rxconf", tlsinfo[TLS_INFO_RXCONF]);
 			tcp_tls_conf("txconf", tlsinfo[TLS_INFO_TXCONF]);
-			tcp_tls_zc_sendfile(tlsinfo[TLS_INFO_ZC_RO_TX]);
+			if (!!tlsinfo[TLS_INFO_ZC_RO_TX])
+				out(" zc_ro_tx");
+			if (!!tlsinfo[TLS_INFO_RX_NO_PAD])
+				out(" no_pad_rx");
 		}
 		if (ulpinfo[INET_ULP_INFO_MPTCP]) {
 			struct rtattr *sfinfo[MPTCP_SUBFLOW_ATTR_MAX + 1] =
-- 
2.41.0


