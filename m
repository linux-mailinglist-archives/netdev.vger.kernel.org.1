Return-Path: <netdev+bounces-240198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD56C71597
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 23:48:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 699E7302E6
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 22:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8ED33BBC7;
	Wed, 19 Nov 2025 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="KfDfAGR/"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E43A3396E1;
	Wed, 19 Nov 2025 22:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592180; cv=none; b=KzPnW7PxoNhXCVm7tZCTmwY+KOjIDgsH3tpVim8sjdGlyJNRQkqkTBQxS0OZz0DKvUl7L8ljFmEmiqmXQ8F5/DrEMobNM20oKFu4XjKUaQcwHwhwpg7EArVAoHwpgrZ6xN0e/vUFbAQWhN1jut7PykBAoDpnBw0safjiEWm+mjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592180; c=relaxed/simple;
	bh=kDTQhJIiq4Kp004XdWpSKDD3BQKOQI9MO/ePej/Dds0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qIHl1RAbHo6SSqQQZj1Ej98M60KXP3fQ2ibjDSjA0SzQ0NJtTH82WWs9ylO0Q94Rcqmvnnm9QGXlLS0Hs3OuIIT7gxt9SjodnRmclFx5sr18NMBRd+6HcgSC1nBRIBUuskmd5Mh2kI2b/09jKEeuS2DDJTysKkiF22n8lykewTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=KfDfAGR/; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt5-006kz2-5Y; Wed, 19 Nov 2025 23:42:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=CvT81+/OMdXIo3A/snFu6tlNvkl886+eK8dSY3ZBXJ0=; b=KfDfAGR/6CG5etf7USf9VWenKL
	GREPJJdM1fDVS+mr5G1/mFmzwIs8sIek6Ezji9nPizCgYA3zQbCEx85uWeazAhzWjNPEgst3cJtNm
	gFh0Y9hfgdBAvg6qOp2Wg379crmK7hyC6o3ZmNc4zVAcsXDLYZCRqHWYQyOeFWZ1sPJB0Fij6Ipfi
	FNhePtiZoRKDcTDA2Y/ITBjrGMceGZWABKg39B49b0tfZFl4GEem31IGkglz4723RRGb6RZQrDRq5
	8DjaFtdAk7tQlpgVBCl+qkbcK39pi0yTNsFCqaJr5/iKifpYsVTPt0lLHVzqNijtEtBHBHE1kKSvZ
	42tPschg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqt4-0000EX-NM; Wed, 19 Nov 2025 23:42:54 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsq-00Fos6-9P; Wed, 19 Nov 2025 23:42:40 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Matthieu Baerts <matttbe@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 44/44] net/mptcp: Change some dubious min_t(int, ...) to min()
Date: Wed, 19 Nov 2025 22:41:40 +0000
Message-Id: <20251119224140.8616-45-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

There are two:
	min_t(int, xxx, mptcp_wnd_end(msk) - msk->snd_nxt);
Both mptcp_wnd_end(msk) and msk->snd_nxt are u64, their difference
(aka the window size) might be limited to 32 bits - but that isn't
knowable from this code.
So checks being added to min_t() detect the potential discard of
significant bits.

Provided the 'avail_size' and return of mptcp_check_allowed_size()
are changed to an unsigned type (size_t matches the type the caller
uses) both min_t() can be changed to min().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 net/mptcp/protocol.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 2d6b8de35c44..d57c3659462f 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1123,8 +1123,8 @@ struct mptcp_sendmsg_info {
 	bool data_lock_held;
 };
 
-static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
-				    u64 data_seq, int avail_size)
+static size_t mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *ssk,
+				       u64 data_seq, size_t avail_size)
 {
 	u64 window_end = mptcp_wnd_end(msk);
 	u64 mptcp_snd_wnd;
@@ -1133,7 +1133,7 @@ static int mptcp_check_allowed_size(const struct mptcp_sock *msk, struct sock *s
 		return avail_size;
 
 	mptcp_snd_wnd = window_end - data_seq;
-	avail_size = min_t(unsigned int, mptcp_snd_wnd, avail_size);
+	avail_size = min(mptcp_snd_wnd, avail_size);
 
 	if (unlikely(tcp_sk(ssk)->snd_wnd < mptcp_snd_wnd)) {
 		tcp_sk(ssk)->snd_wnd = min_t(u64, U32_MAX, mptcp_snd_wnd);
@@ -1477,7 +1477,7 @@ struct sock *mptcp_subflow_get_send(struct mptcp_sock *msk)
 	if (!ssk || !sk_stream_memory_free(ssk))
 		return NULL;
 
-	burst = min_t(int, MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
+	burst = min(MPTCP_SEND_BURST_SIZE, mptcp_wnd_end(msk) - msk->snd_nxt);
 	wmem = READ_ONCE(ssk->sk_wmem_queued);
 	if (!burst)
 		return ssk;
-- 
2.39.5


