Return-Path: <netdev+bounces-177317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A491A6EF00
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA5EF7A4188
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5136525743E;
	Tue, 25 Mar 2025 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tg7vjrNQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD2B257427;
	Tue, 25 Mar 2025 11:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742900908; cv=none; b=A8TTa/F4QwApaOtryimF8SgyGrRhynb4RwplDtzcuck1Y3BuDFGH0jdmoWvhDvtD0PfOH0WgNTKpJ2yw9+6iVXNYoqxNMyk8cwWELx8DR6fQHlNaLDqxfUyoTLNMi0Bxplt4AKHWlAo08L857pxnD9wV6TLJieYsLTgLA8ySCTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742900908; c=relaxed/simple;
	bh=Fp3OuqKIGI87B+2qLAxVYAj1U/8NXpcexesT2kFFqoc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Byhghtxa2MPfgg7XhvVBrpQfO1zc0t89zAc0MI2PShY7CjBtJVKEowMvatRzYED7r27cxTdzmoLKXAR6j+zLEIHjXfisAuGzVP4WZeTF72yGwgef/03fIsR0i/FSNmADZgpj6x0EA6sw8dVxiTD32tpkhDLGt5kEkyC2k/5mudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tg7vjrNQ; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742900904;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=cQwFKVuOUJVkhVIojgcrzkha3ElxfIW69cI+JU/dNp4=;
	b=Tg7vjrNQRJ6lXbi19BR8wkML3vpzTtgbaltdrGjQi7/ovYGEf+urVTbTtwe+L13zmxmk+n
	Zatr/MZ7LHa8epIRed9+nfLrFVAcbmhwF6rblxhnPmTVTN9WD1xzZmuuaPa5w2RrLLqHOf
	nKWFZ9HCZX4YiGWycUodp95zp0abBmo=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mptcp: pm: Fix undefined behavior in mptcp_remove_anno_list_by_saddr()
Date: Tue, 25 Mar 2025 12:06:39 +0100
Message-ID: <20250325110639.49399-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Commit e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
removed a necessary if-check, leading to undefined behavior because
the freed pointer is subsequently returned from the function.

Reintroduce the if-check to fix this and add a local return variable to
prevent further checkpatch warnings, which originally led to the removal
of the if-check.

Fixes: e4c28e3d5c090 ("mptcp: pm: move generic PM helpers to pm.c")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/mptcp/pm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index 18b19dbccbba..5a6d5e4897dd 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -151,10 +151,15 @@ bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
 				     const struct mptcp_addr_info *addr)
 {
 	struct mptcp_pm_add_entry *entry;
+	bool ret = false;
 
 	entry = mptcp_pm_del_add_timer(msk, addr, false);
-	kfree(entry);
-	return entry;
+	if (entry) {
+		ret = true;
+		kfree(entry);
+	}
+
+	return ret;
 }
 
 bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)

