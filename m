Return-Path: <netdev+bounces-162290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE04A26642
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86A85164CCA
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7189E20FA80;
	Mon,  3 Feb 2025 21:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuLNUJlH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFBA20F07C
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619901; cv=none; b=m/sSBqpJReHH7u7rOxVL6AScYWdCHevblDS4Mv8qY+R7ef7zZE9Xc+wulTp9zmp4Qna8Xg3CWZ6ayaCpA8nAz0fUc0Tm3QPQbRRLexXPpyT49qT54k0kkZ8CWrUKA2g1VGPo4dw6aBHdRorS6/8cx7m9lneVj+KgBxhxBnSE5t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619901; c=relaxed/simple;
	bh=Qi9FRgHkkrnnXzQ6qTP6FBQ/+DAq2OsOWTdWS9sXlF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hTEGqh86N7ONii2qUOA+cg9+3E1ln5NjJiicuWgQhTu9I2o8Kq3vyZjPk9pUJ1n7GH+3Tt1wYVL/K+VSXv7EicniQLWDlVt1tZ7HlWv5n728IAyC6U++7fqYT4SwNNA8ZwRC0Q+erdSDT3g0FxfrzOXKgWz2lmQyn8dTD+DdXIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuLNUJlH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE24C4CED2;
	Mon,  3 Feb 2025 21:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738619900;
	bh=Qi9FRgHkkrnnXzQ6qTP6FBQ/+DAq2OsOWTdWS9sXlF8=;
	h=From:To:Cc:Subject:Date:From;
	b=PuLNUJlHhZYr2TZT5dZXp0VTsFfatMQCBNAgtlFp4VpW+2KyKLWRYBzjCxZEUU2O7
	 q1Mx9lO+SYUjJenP4WFpuP2ztIi1/9/zQNCvjmF2maQIGZ3wD7pPQnWQOjMGZXgNm6
	 gtCMF0ttW7P4yquNZTF3vgPetxoIgHZHzRrzcEuRgOXFFICaOPEdjnD2WVTnV0pRDs
	 aarU1eB1XibmIovtwZld7bS+cWbZxWS97QpPad0wK29dNrX5/BZqJF7ophKB47GGho
	 RvZCPUyJq2V/wLsxPB2n1r5gmsU9D5TThi2TLYsMPfEu1Qb4a4z59iLvkmY0CCLrBt
	 iaCsnkYsgipww==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] net: warn if NAPI instance wasn't shut down
Date: Mon,  3 Feb 2025 13:58:16 -0800
Message-ID: <20250203215816.1294081-1-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drivers should always disable a NAPI instance before removing it.
If they don't the instance may be queued for polling.
Since commit 86e25f40aa1e ("net: napi: Add napi_config")
we also remove the NAPI from the busy polling hash table
in napi_disable(), so not disabling would leave a stale
entry there.

Use of busy polling is relatively uncommon so bugs may be lurking
in the drivers. Add an explicit warning.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/core/dev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index c0021cbd28fc..2b141f20b13b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7071,6 +7071,9 @@ void __netif_napi_del_locked(struct napi_struct *napi)
 	if (!test_and_clear_bit(NAPI_STATE_LISTED, &napi->state))
 		return;
 
+	/* Make sure NAPI is disabled (or was never enabled). */
+	WARN_ON(!test_bit(NAPI_STATE_SCHED, &napi->state));
+
 	if (napi->config) {
 		napi->index = -1;
 		napi->config = NULL;
-- 
2.48.1


