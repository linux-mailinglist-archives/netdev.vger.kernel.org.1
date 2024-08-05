Return-Path: <netdev+bounces-115817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C364E947E18
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A5281A4A
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 15:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35D015B0EE;
	Mon,  5 Aug 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4Uvnx6F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8691D15B0E4;
	Mon,  5 Aug 2024 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722871829; cv=none; b=PJjIJ24RNKkus/CbA1itAD9Q6xmxpMF5xujzM35pO2zdbZjSvf4nk6xKIZ9hKtSasTIGCL6jSGVw3aIh1UC58LbOVJZTateJ8nQZ8fUemDfD7k13DnNtWKGKfSVGzQ2NLF6wmosQP+J+gwSmVaVdET5jC52OFm3WtBtYZCTdQWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722871829; c=relaxed/simple;
	bh=peBQ98KXfacRhQluvjgXxaG87AzukXha4hCAxLqzhVA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lumfMaTIdNjsVbw7jZEIrFxWJfooBcyK/OJAfGsWNHnK/sRG2Kq8r35g1o7Hy5Z7RnkuKLqn1eBbvvZ6hWggUuM3idqURHfjbWG3TmFA9SScX7eQgQM6arcYEBw1KrCywWQO9740tbNZlnIJw2pcQ5NnhPecAvocTsl+Rn+63Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4Uvnx6F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF0EC32782;
	Mon,  5 Aug 2024 15:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722871829;
	bh=peBQ98KXfacRhQluvjgXxaG87AzukXha4hCAxLqzhVA=;
	h=Date:From:To:Cc:Subject:From;
	b=S4Uvnx6FEL15lstaD0QiGDZI+EZqKQPKLClumUYJvof8HnwxEp67OPewW3PXok27k
	 Eat14suYfm/mEKFcxIN91bs1gnJJ34F7L9Do+fzH1/2c+Yl/Ag7QD/C2BuAtLFFWb8
	 qkrYLhTgt3zeORUjEFu21b3vPw0vrsEj+Rdyo9EOZ3yL5HdKUKhNPqFy5eCcyxr/GB
	 VUe1aNURQSQ4HQopn6F9ThVYT61nRlZG/fCYdODWYaTeG87s1LEGfaiU5ft9234jeG
	 1nNYSKh8CxcMvrcaz8DmMf2GOHx07IaDOALj95yo0g+0LqRWaEoESTXXxC1/VHlVLt
	 qd3fhjPs2B3TQ==
Date: Mon, 5 Aug 2024 09:30:26 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Dimitris Michailidis <dmichail@fungible.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] net/fungible: Avoid -Wflex-array-member-not-at-end
 warning
Message-ID: <ZrDwEugW7DR/FlP5@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
a flexible structure where the size of the flexible-array member
is known at compile-time, and refactor the rest of the code,
accordingly.

So, with these changes, fix the following warning:
drivers/net/ethernet/fungible/funcore/fun_dev.c:550:43: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/net/ethernet/fungible/funcore/fun_dev.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/fungible/funcore/fun_dev.c b/drivers/net/ethernet/fungible/funcore/fun_dev.c
index a7fbd4cd560a..ce97b76f9ae0 100644
--- a/drivers/net/ethernet/fungible/funcore/fun_dev.c
+++ b/drivers/net/ethernet/fungible/funcore/fun_dev.c
@@ -546,17 +546,14 @@ int fun_bind(struct fun_dev *fdev, enum fun_admin_bind_type type0,
 	     unsigned int id0, enum fun_admin_bind_type type1,
 	     unsigned int id1)
 {
-	struct {
-		struct fun_admin_bind_req req;
-		struct fun_admin_bind_entry entry[2];
-	} cmd = {
-		.req.common = FUN_ADMIN_REQ_COMMON_INIT2(FUN_ADMIN_OP_BIND,
-							 sizeof(cmd)),
-		.entry[0] = FUN_ADMIN_BIND_ENTRY_INIT(type0, id0),
-		.entry[1] = FUN_ADMIN_BIND_ENTRY_INIT(type1, id1),
-	};
+	DEFINE_RAW_FLEX(struct fun_admin_bind_req, cmd, entry, 2);
+
+	cmd->common = FUN_ADMIN_REQ_COMMON_INIT2(FUN_ADMIN_OP_BIND,
+						 __struct_size(cmd));
+	cmd->entry[0] = FUN_ADMIN_BIND_ENTRY_INIT(type0, id0);
+	cmd->entry[1] = FUN_ADMIN_BIND_ENTRY_INIT(type1, id1);
 
-	return fun_submit_admin_sync_cmd(fdev, &cmd.req.common, NULL, 0, 0);
+	return fun_submit_admin_sync_cmd(fdev, &cmd->common, NULL, 0, 0);
 }
 EXPORT_SYMBOL_GPL(fun_bind);
 
-- 
2.34.1


