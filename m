Return-Path: <netdev+bounces-200693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D958FAE68E1
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97E6C1C2210D
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 045F128B4E7;
	Tue, 24 Jun 2025 14:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nb4bEF7H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D508427FB31
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775330; cv=none; b=M1j0BqqnGF0hGMlES//C+7U2xT+QHfU20WRsImN5d0k9lzGg5Dt6KBEV5UFR1os1qSAyJeRMuQKzu55S1OgkYyftg+UGvuin9xfXbxHDp37x1sKCVSW6Y/37GAluwzSOLzudgBnPrdXRd73FUhHn5SgORbJ7w1ygneHLX/tg8kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775330; c=relaxed/simple;
	bh=BzHvtfEX9D4YtKgxMjCAIkPEY0uV8yTi3yi5AfwRmYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBEKUFeypZvqx8C5NSr3dF+57LBExAnPV1fsaD4aO8SFLNjrRm4EfhZa2hDPWzTw+lxC2GLe1Tqb69wmnw+v6pLEtWEAM+qT+FZPM5L1JUMV5xCtZzkwqJZ45h0OJoP8Gu6n8fj0TbL5l0vYIEy35MKBrpJhSXjGQVq1aKV3uVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nb4bEF7H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103C0C4CEEE;
	Tue, 24 Jun 2025 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750775330;
	bh=BzHvtfEX9D4YtKgxMjCAIkPEY0uV8yTi3yi5AfwRmYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nb4bEF7HfViqO7k4LyIuXX5hJH7zJng2cr1W+Bpl+GXLOwb8OXo28zCX2+HYzVpfB
	 9rumCuMZOMQs6YErQRbwtjJVxq/qSD5BZuOJCFRLHCxDpGBxLQvW7xD1F8lsl9WXTs
	 zA8Piu+pOJoxjHK7inCpDr+sxSfMCUbs5U0Gux5TMZ5JuDAplQ7o/QYrNiGa00uXVb
	 rOGuyD1hmQB/e0OIm1uwWBJ0F/qo8BPiVgQfZC3QesugCTvI5l1zInSN1elVR+pVIB
	 +O9YrVxRF/4j9LbKP16N9s4I6wZ/zObfXPw3IBSEn8lj43adbrg20M+oYTjEb/658+
	 2nHjrtbC87inw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	mohsin.bashr@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/5] eth: fbnic: remove duplicate FBNIC_MAX_.XQS macros
Date: Tue, 24 Jun 2025 07:28:30 -0700
Message-ID: <20250624142834.3275164-2-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250624142834.3275164-1-kuba@kernel.org>
References: <20250624142834.3275164-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Somehow we ended up with two copies of FBNIC_MAX_[TR]XQS in fbnic_txrx.h.
Remove the one mixed with the struct declarations.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index f46616af41ea..2e361d6f03ff 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -141,9 +141,6 @@ struct fbnic_napi_vector {
 	struct fbnic_q_triad qt[];
 };
 
-#define FBNIC_MAX_TXQS			128u
-#define FBNIC_MAX_RXQS			128u
-
 netdev_tx_t fbnic_xmit_frame(struct sk_buff *skb, struct net_device *dev);
 netdev_features_t
 fbnic_features_check(struct sk_buff *skb, struct net_device *dev,
-- 
2.49.0


