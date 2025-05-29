Return-Path: <netdev+bounces-194230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D55FAC7F94
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FD4C1C00362
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 14:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6316C1E9B2A;
	Thu, 29 May 2025 14:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="usWSvOat"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF361E3DDB
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748528441; cv=none; b=to8ITV3LsIBosOIp9p0KFOYyLx+IS/xfFgya5lldoxtH+04s78Fcoac59hcsPpGmdoFlAAAtBu3xz8WClDY20zRgYKb1tQuwt+5d7yNOzZByvQQFHQ0w7WdyCe+PNSjK369hG0I9bQNnBxzdZ63mxjpTGjg0JzZRGvDAmrtdSfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748528441; c=relaxed/simple;
	bh=IMQ2EwB0ki/jDYUO9sRr3iIcdsu9yn0ZGJfZYlK9hcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gy4Dq++pmT73CfbXMHvDbeZ/Ce+zQ9nG2EwR/WC1qcB7XXnQR7TZK7ksSZ/vJ+9NnqM7TzWdfRQFP9DfF2t/v6r4puRLGJMKAXN1o0QzxBXmhkIJix2KBnpH2GhFgxbtlWVpqCSLRcpfXyK7Y4QHxDGcip60lPu2oExYBaGOwSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=usWSvOat; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79044C4CEF0;
	Thu, 29 May 2025 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748528440;
	bh=IMQ2EwB0ki/jDYUO9sRr3iIcdsu9yn0ZGJfZYlK9hcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=usWSvOat2U7RrWuVmcqLESZkYnaANmsaRY1Bw83i3pH2cWFM2b96W5itEjNcIr7iC
	 cQAUbMu83yp7Kcv3nTs5GQWjesueFtwu9e6f8kh0wZdPViVHyYGGiVzLVNIwdu7ucE
	 q+83sfKbNtNjIi8da738f4KrYKPM/EYKTo9zLtiMBeZJ/ayJTapStVagUiKO8MtZwY
	 7t12CsFfQcJ8dKiEUjoBzPyztd0EfoQVOkuCFDOuLCTOZBa9fZijOkr+c8BfhhV1ja
	 DHoSDXlHYe6AdE2CHCc62C1Yq4Ejm6M0fyppvR2QILpeiLA/XnXs2x7oHtU43oC9q4
	 77u5QxhDkt+JA==
From: Jakub Kicinski <kuba@kernel.org>
To: mkubecek@suse.cz
Cc: danieller@nvidia.com,
	idosch@idosch.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH ethtool 2/2] module_common: print loss / fault signals as bool
Date: Thu, 29 May 2025 07:20:33 -0700
Message-ID: <20250529142033.2308815-3-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529142033.2308815-1-kuba@kernel.org>
References: <20250529142033.2308815-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

JSON output is supposed to be easy to parse. We currently
output "Yes" / "No" for the per-lane signal loss / fault.
This forces user space to do string matching. Print bool.

Before:
  "rx_loss_of_signal": ["No", "No", "No", "No"],

After:
  "rx_loss_of_signal": [false, false, false, false],

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 module-common.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/module-common.c b/module-common.c
index ae500c62af89..11b71bdb6281 100644
--- a/module-common.c
+++ b/module-common.c
@@ -317,8 +317,7 @@ void module_show_lane_status(const char *name, unsigned int lane_cnt,
 		open_json_array(json_fn, "");
 
 		while (lane_cnt--) {
-			print_string(PRINT_JSON, NULL, "%s",
-				     value & 1 ? yes : no);
+			print_bool(PRINT_JSON, NULL, NULL, value & 1);
 			value >>= 1;
 		}
 		close_json_array("");
-- 
2.49.0


