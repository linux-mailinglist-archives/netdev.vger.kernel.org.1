Return-Path: <netdev+bounces-52480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A48C7FEE12
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 12:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9834B20DD3
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 11:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CA23C6A7;
	Thu, 30 Nov 2023 11:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MFXTVHYS"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E4E010DF
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 03:40:12 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701344410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=NTo/KQQFEKB5cdC4RkdHzgx+ceXO4URIfFSeciyVXgs=;
	b=MFXTVHYSusV951Pk3RANkK8fDKmFQhh0f2WLnLM2w6iRGcJypKsSJdweM4/q8UmShh6cUe
	g3qSWgsly4267aI1BBSHideSViWxAPHERuXetOoRr/5HqM73y6Aw3i4WrYjZPYrZYcuAqr
	Zr7jyp6PJpWMopPWw3+LjnbtqiZo7YA=
From: Geliang Tang <geliang.tang@linux.dev>
To: David Ahern <dsahern@kernel.org>
Cc: Geliang Tang <geliang.tang@linux.dev>,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>
Subject: [PATCH iproute2-next] ss: mptcp: print out subflows_total counter
Date: Thu, 30 Nov 2023 19:40:36 +0800
Message-Id: <ecf501dce539b4cc77e450d510c0414eec4bba7f.1701344289.git.geliang.tang@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

A new counter mptcpi_subflows_total has been added in mptcpi_flags
to count the total amount of subflows from mptcp_info including the
initial one into kernel in this commit:

  6ebf6f90ab4a ("mptcp: add mptcpi_subflows_total counter")

This patch prints out this counter into mptcp_stats output.

Acked-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Geliang Tang <geliang.tang@linux.dev>
---
 include/uapi/linux/mptcp.h | 1 +
 misc/ss.c                  | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/mptcp.h b/include/uapi/linux/mptcp.h
index 99b55575..c2e6f3be 100644
--- a/include/uapi/linux/mptcp.h
+++ b/include/uapi/linux/mptcp.h
@@ -55,6 +55,7 @@ struct mptcp_info {
 	__u64	mptcpi_bytes_sent;
 	__u64	mptcpi_bytes_received;
 	__u64	mptcpi_bytes_acked;
+	__u8	mptcpi_subflows_total;
 };
 
 /* MPTCP Reset reason codes, rfc8684 */
diff --git a/misc/ss.c b/misc/ss.c
index 7e67dbe4..67363ec0 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -3239,6 +3239,8 @@ static void mptcp_stats_print(struct mptcp_info *s)
 		out(" bytes_received:%llu", s->mptcpi_bytes_received);
 	if (s->mptcpi_bytes_acked)
 		out(" bytes_acked:%llu", s->mptcpi_bytes_acked);
+	if (s->mptcpi_subflows_total)
+		out(" subflows_total:%u", s->mptcpi_subflows_total);
 }
 
 static void mptcp_show_info(const struct nlmsghdr *nlh, struct inet_diag_msg *r,
-- 
2.35.3


