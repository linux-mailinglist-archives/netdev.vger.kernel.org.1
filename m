Return-Path: <netdev+bounces-117239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD294D375
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:28:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95851B2165A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2414019884D;
	Fri,  9 Aug 2024 15:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sO0IxqGy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9BB15B992;
	Fri,  9 Aug 2024 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723217275; cv=none; b=ZEkqw/ms439yNIsHtHPp2Z14c4q1B5mqoH5T8O5k67IkcOV1htdQKBlxFB4s23aUhaewfMAEfuOGxdDPB1Up4VWtwXfsOLr82IwQxR20O6ziA37Ny4wUy/nvekSTCDVxWIzsOX6R5JYd74uFjih/JHK3plsg5jkRrIfBUj67tz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723217275; c=relaxed/simple;
	bh=78MTpby5wUdMPDJYFhMoXDD9VtwkON7pKOzZZuUVa8o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LMUuhzR5Wck08h98Qcoa3LgSQCLYDDIgPYl80ZQnZ9H9/ZAFhKlZzpenTh7e4QxQH2rPeEQ/2pyyMrtKHvCJ/ejAOa7+/lhK0POY37OtcFWWb8An1LESi4SKrFp7qQyP8HdIvmvy0gssI4mh92cLPnUaoGl1YxNyL7z/6vMHwLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sO0IxqGy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F7DC32782;
	Fri,  9 Aug 2024 15:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723217274;
	bh=78MTpby5wUdMPDJYFhMoXDD9VtwkON7pKOzZZuUVa8o=;
	h=Date:From:To:Cc:Subject:From;
	b=sO0IxqGyW0S6fPtHKANNdur6onARB40reweqbZ6295fDYGtnoyGQhHBft0Ms81Q0c
	 ZHYnw3ZLX3XFTppp3TZaA5f1EYpp0X6GUuyh09qwkduPLNAvgSPP8IRIMhCIkiFl7U
	 +bC2ZWqNzb64k4lwY3EtS/5T/LYPTaBcWVFrP2KX54YFhAQAoxcJmQzwPy7bgMrLGB
	 LcIYMJecNHWCOB8z5HBnEon1GMY/dqMpUHLq2YzW/VOROQ9N5BW2e5h2xH2Lg9Shi2
	 ISKGPHNfErG83T8YIgCJwB6jR/TkvlkKMAMptCbraxJ57sfYkw/DqbaHlkW97NYbU/
	 y0CgEXvQBCFGA==
Date: Fri, 9 Aug 2024 09:27:51 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] UAPI: net/sched: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <ZrY1d01+JrX/SwqB@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end has been introduced in GCC-14, and we
are getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of multiple other structs, we use the `__struct_group()`
helper to create a new tagged `struct tc_u32_sel_hdr`. This structure
groups together all the members of the flexible `struct tc_u32_sel`
except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct member currently causing
trouble from `struct tc_u32_sel` to `struct tc_u32_sel_hdr`.

This approach avoids having to implement `struct tc_u32_sel_hdr`
as a completely separate structure, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

So, with these changes, fix the following warning:
drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h:245:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update subject line. (Jakub)

 .../chelsio/cxgb4/cxgb4_tc_u32_parse.h        |  2 +-
 include/uapi/linux/pkt_cls.h                  | 23 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
index 9050568a034c..64663112cad8 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
@@ -242,7 +242,7 @@ struct cxgb4_next_header {
 	 * field's value to jump to next header such as IHL field
 	 * in IPv4 header.
 	 */
-	struct tc_u32_sel sel;
+	struct tc_u32_sel_hdr sel;
 	struct tc_u32_key key;
 	/* location of jump to make */
 	const struct cxgb4_match_field *jump;
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index d36d9cdf0c00..2c32080416b5 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -246,16 +246,19 @@ struct tc_u32_key {
 };
 
 struct tc_u32_sel {
-	unsigned char		flags;
-	unsigned char		offshift;
-	unsigned char		nkeys;
-
-	__be16			offmask;
-	__u16			off;
-	short			offoff;
-
-	short			hoff;
-	__be32			hmask;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(tc_u32_sel_hdr, hdr, /* no attrs */,
+		unsigned char		flags;
+		unsigned char		offshift;
+		unsigned char		nkeys;
+
+		__be16			offmask;
+		__u16			off;
+		short			offoff;
+
+		short			hoff;
+		__be32			hmask;
+	);
 	struct tc_u32_key	keys[];
 };
 
-- 
2.34.1


