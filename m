Return-Path: <netdev+bounces-69663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B3384C1CB
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C8831C24873
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 01:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8308D528;
	Wed,  7 Feb 2024 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lf3weUAP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E20D2E5
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 01:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707268746; cv=none; b=RLqiKuXuuEelK649gcLKB9X4Dgk42svVn1akDHRn8u/vG7/x4sRT/9Lw3uO84bGE6aHVO3OIEHZsTxBSwmHi+CsIhSYdnJbwSRRIchIhHMbyFboA9qT8UPs4g56YwzPOlxpGgcYnK6MPBLraFOaQ1r7RTn5MDV8Ry1IjE3ykLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707268746; c=relaxed/simple;
	bh=MPAMZ+2JRFlZpMeM+oDUWePVo6iLChJIqlSKP75cyNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aA41klEL7N7jNivN7t4jbW16rx3jbXLvMOeKTksy7SFbLM/NkctxVglGSynbpxaBrQcKLN2dLy5YSzZAskf9fMDcm7eRH5jhEqyoJmzXTWz2rWLMqlrVUFHIFrONuNWHGUKmRxPf6UpFNfsGj58obasfEZO5gBVQevi4TdglR0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lf3weUAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D503CC43394;
	Wed,  7 Feb 2024 01:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707268746;
	bh=MPAMZ+2JRFlZpMeM+oDUWePVo6iLChJIqlSKP75cyNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lf3weUAPkmhw9R+bWvgbVXtz81KtMfxZsMGaEgBoDg15nCtNdX9HSPVqgrLYxjA3K
	 7ABMzxB7kgWvSUqbG1AVijpEwMfmLFE0FXzitY/JnHH4IXXBGVCJNpYDoWeY9fiaM3
	 PzIqrdjkWmYFfwQ9zpfYydnMiJkv7CffLpk23Kd3AygTlQY/12K4yyv/NrqoXbdD3k
	 0xjGIVfvSvzLp33+Dul0gOFIPJ5LNiZC7zvDz+d9Ow0tB7W/y69OoRaT9YTee0J/0k
	 w2het3AswdVxbi3vNYpIlDTAJXRLkvqfeF43oK6aKr0gkgj3GktpUoNhlEdYsSjMaE
	 5VWWBbUfiDxKQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	sd@queasysnail.net,
	vadim.fedorenko@linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	valis <sec@valis.email>,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	vakul.garg@nxp.com
Subject: [PATCH net 3/7] tls: fix race between tx work scheduling and socket close
Date: Tue,  6 Feb 2024 17:18:20 -0800
Message-ID: <20240207011824.2609030-4-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207011824.2609030-1-kuba@kernel.org>
References: <20240207011824.2609030-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to previous commit, the submitting thread (recvmsg/sendmsg)
may exit as soon as the async crypto handler calls complete().
Reorder scheduling the work before calling complete().
This seems more logical in the first place, as it's
the inverse order of what the submitting thread will do.

Reported-by: valis <sec@valis.email>
Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: borisp@nvidia.com
CC: john.fastabend@gmail.com
CC: vakul.garg@nxp.com
---
 net/tls/tls_sw.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 635305bebfef..9374a61cef00 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -447,7 +447,6 @@ static void tls_encrypt_done(void *data, int err)
 	struct tls_rec *rec = data;
 	struct scatterlist *sge;
 	struct sk_msg *msg_en;
-	bool ready = false;
 	struct sock *sk;
 
 	msg_en = &rec->msg_encrypted;
@@ -483,19 +482,16 @@ static void tls_encrypt_done(void *data, int err)
 		/* If received record is at head of tx_list, schedule tx */
 		first_rec = list_first_entry(&ctx->tx_list,
 					     struct tls_rec, list);
-		if (rec == first_rec)
-			ready = true;
+		if (rec == first_rec) {
+			/* Schedule the transmission */
+			if (!test_and_set_bit(BIT_TX_SCHEDULED,
+					      &ctx->tx_bitmask))
+				schedule_delayed_work(&ctx->tx_work.work, 1);
+		}
 	}
 
 	if (atomic_dec_and_test(&ctx->encrypt_pending))
 		complete(&ctx->async_wait.completion);
-
-	if (!ready)
-		return;
-
-	/* Schedule the transmission */
-	if (!test_and_set_bit(BIT_TX_SCHEDULED, &ctx->tx_bitmask))
-		schedule_delayed_work(&ctx->tx_work.work, 1);
 }
 
 static int tls_encrypt_async_wait(struct tls_sw_context_tx *ctx)
-- 
2.43.0


