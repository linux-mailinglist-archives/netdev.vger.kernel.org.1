Return-Path: <netdev+bounces-241120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F04AAC7FAE2
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 10:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD153A4C7B
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 09:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3207F2F6561;
	Mon, 24 Nov 2025 09:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChvgmneM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042C02F618B;
	Mon, 24 Nov 2025 09:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763977333; cv=none; b=Vlbvd3ppzwfQr6ftw9Isz06Wum2/BGANWyRyfTVlbit0KSm0WZe6HSa9s6Y0G3xDNBHEGdG3FbiW6IjmnUEzC6LYJr35pKdtJGxBwmigyUXK0ZJhnpkUI3N5/v2ZNlg3ar2fp67ukBBEbER27EWOUO+GFZKeU521eC5/8sRq6H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763977333; c=relaxed/simple;
	bh=5jhK+RYQnVUmMzlNJEn9OCohqB4w3y9XfjbAFGm+chQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mViSCV7elsDaWW4bqtPIxn1wASQSo7NUJRumwglwxIKQ0cpcR71c9XKbYfZH4LPmFvWyhwc1OJCf3i8MtVEcoKfPtx+Kh0w/bOeL5TW7rbOSi1T5ajOPx3lYVvxie1Ttv5o0xmp6WOP7DREtkq/9T19PRd7ugTV8ULYCvHw0Jcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChvgmneM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA5FC116D0;
	Mon, 24 Nov 2025 09:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763977332;
	bh=5jhK+RYQnVUmMzlNJEn9OCohqB4w3y9XfjbAFGm+chQ=;
	h=Date:From:To:Cc:Subject:From;
	b=ChvgmneMgaYIYdt6WH1No34HRC8PT3OijKu1k68R0bFnI6ICc6+Dg/ezJK/qzFB4C
	 CcVk2MYMlf3P+EmTZWNoaw07Ayr0qP4BoCobgH7qZ+aR055PlOQFNawyHmF7VUxrQb
	 H4jEPcBwm0NB2yG5rdjHY8i09lQbW2qldwrHJX0Rudd+sbjye6FSnY+15PWCF+TtzR
	 sJ80+U8mFd9+20g9IDcEwmjZ1jXdX+/KV0UoMQEsChg4XWaqTj3J2E4X5jMuzmnLcj
	 tzwXyL4hftCBozSJvXBiEziVXEvz3ZG6jSkKP70BwyZ/TIZ0HI5ihzzuiWL8r0oh9i
	 PLVMYJm8wAPFA==
Date: Mon, 24 Nov 2025 18:42:08 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Ayush Sawal <ayush.sawal@chelsio.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] chtls: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <aSQocKoJGkN0wzEj@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Use the `DEFINE_RAW_FLEX()` helper for on-stack definitions of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:

drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c:163:36: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c   | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
index 4036db466e18..ee19933e2cca 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_io.c
@@ -159,19 +159,13 @@ static u8 tcp_state_to_flowc_state(u8 state)
 int send_tx_flowc_wr(struct sock *sk, int compl,
 		     u32 snd_nxt, u32 rcv_nxt)
 {
-	struct flowc_packed {
-		struct fw_flowc_wr fc;
-		struct fw_flowc_mnemval mnemval[FW_FLOWC_MNEM_MAX];
-	} __packed sflowc;
+	DEFINE_RAW_FLEX(struct fw_flowc_wr, flowc, mnemval, FW_FLOWC_MNEM_MAX);
 	int nparams, paramidx, flowclen16, flowclen;
-	struct fw_flowc_wr *flowc;
 	struct chtls_sock *csk;
 	struct tcp_sock *tp;
 
 	csk = rcu_dereference_sk_user_data(sk);
 	tp = tcp_sk(sk);
-	memset(&sflowc, 0, sizeof(sflowc));
-	flowc = &sflowc.fc;
 
 #define FLOWC_PARAM(__m, __v) \
 	do { \
-- 
2.43.0


