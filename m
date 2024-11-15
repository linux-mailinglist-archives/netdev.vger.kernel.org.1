Return-Path: <netdev+bounces-145108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F0E9CCD30
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B33F01F22551
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 00:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02AE15E8B;
	Fri, 15 Nov 2024 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BizuAkgT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC38A1362
	for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 00:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731630746; cv=none; b=I5gNmSBxTFeM5rM1rNYrKNEFEs5LH0JJy/zgc+5PEwoN/j9ffuA0iHvVuXJBMQ+zzDleg/lavfwe1ihaCQv2PWbp7Wy8toItbW0a2YYCwZOspr3X53ZcS2hBh5N9UGCu7bPLkm8PdjQgBDe4oendHrSfNqqsFfSThoRvIsltcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731630746; c=relaxed/simple;
	bh=QuPQz7X7LzV3pUXR1NJ2Qm+3AYBIYfOU0aKBJJGG36w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZLrhOjHDYFw01MDhqPZJUpQNAowNuzIsqGsw609txZeS+hQuxSGJHHgSQqqJb4Fdy7LnrKYAC0sDjzymwr24SPCQtcLJssHr4xqEWM0fqnAR5WY0vmLNGHonE0DBBxzbN8dZmDQ14qj/yJimWSYRdNN92xLDHaK29iHOmVC3cSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BizuAkgT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D04C4CECD;
	Fri, 15 Nov 2024 00:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731630746;
	bh=QuPQz7X7LzV3pUXR1NJ2Qm+3AYBIYfOU0aKBJJGG36w=;
	h=From:To:Cc:Subject:Date:From;
	b=BizuAkgTuFl6jmBJfYfzEwYf1wR/PpeJmS5LvfzkrBcm2LUqklMRvsWdxZiE7Zf5e
	 1d7Mqw9ur9PR6zCn7qjIdbcYssRFzoEhUi0d3UFEQ6Nj9d/NwinL/+OUHx12meHjZT
	 jBCB+NDDjdIy+JyIKD1Tjvjxg9Grsj+355GhvcOmMBNnnJEEfBTPTu8YH+b1D5alal
	 50IafNZr+QpA6WpnOfCWmxX5zaB+nPX3ns7PpxEYA0Wo6x1ITRZmpO40Sli1C1dBZ+
	 WwvEPQuOgaOBu22Y1WeE0eOZl6SjNPSjkmeKgsVNN6XnYAqHKNbCQ2e9AjLJCgMy28
	 9gqlyuCQ4Yl7A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	joel.granados@kernel.org
Subject: [PATCH net-next] net/neighbor: clear error in case strict check is not set
Date: Thu, 14 Nov 2024 16:32:21 -0800
Message-ID: <20241115003221.733593-1-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 51183d233b5a ("net/neighbor: Update neigh_dump_info for strict
data checking") added strict checking. The err variable is not cleared,
so if we find no table to dump we will return the validation error even
if user did not want strict checking.

I think the only way to hit this is to send an buggy request, and ask
for a table which doesn't exist, so there's no point treating this
as a real fix. I only noticed it because a syzbot repro depended on it
to trigger another bug.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: joel.granados@kernel.org
---
 net/core/neighbour.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 77b819cd995b..cc58315a40a7 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2876,6 +2876,7 @@ static int neigh_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 	err = neigh_valid_dump_req(nlh, cb->strict_check, &filter, cb->extack);
 	if (err < 0 && cb->strict_check)
 		return err;
+	err = 0;
 
 	s_t = cb->args[0];
 
-- 
2.47.0


