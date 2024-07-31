Return-Path: <netdev+bounces-114427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4592F9428EB
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:12:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AB991C20A5A
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 08:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F201A7F73;
	Wed, 31 Jul 2024 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWlLsGaH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4EC1A4F1C
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 08:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722413526; cv=none; b=OUXKT01/ZbI3aMRkq/SBGQUf7uzdtXqbNHNU1wN6G0XGb6PfuLywsRUzOC/QRFabJW2uDgWicLEnRnz8mFjkfsG0J1cYWsPgs+APlMgit2FUofk4oNEyDLimf8VJjBnzrxxdNO3sgj63l/bbRcbuJ26f+nUoKTGUUeqJFtitd9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722413526; c=relaxed/simple;
	bh=58+cNfwaVUwDZC9vezPCvGDwpK09WuR8+9veH97y1jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q28jo+YYM/VhML5lLq3nQaAtPMff93rsXLlVGo79yPpNKc/vXU3lodvVEkVWNWITCw0uRJu6gohVskC6HlvQv78mwMh3qF+X/p63EvmSxqABJukf7JlBn+lzCxiugK8eZf1wtkCCoOo/hzUHdhngl2XVTDRICaKG++xPHpipjAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWlLsGaH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA87C116B1;
	Wed, 31 Jul 2024 08:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722413525;
	bh=58+cNfwaVUwDZC9vezPCvGDwpK09WuR8+9veH97y1jg=;
	h=From:Date:Subject:To:Cc:From;
	b=kWlLsGaHW9wBFqb648AyAB+bbfeHKmuBeUzJcia//4/SkSrPZXlspKZXs++Am+Vq7
	 CLHEkaLOq+gUrtp2B4RDBowXWfZb5hqgNvZJqVX7wZpLJLrzTXGDBtB2P4OuW3Azxj
	 aVrny7l4wgmTChbW0iSofZfeb/TNTkheEIoULRGZagWQZSPtn42Imk+l2N2gIBFBy2
	 252nytOUt8wF3vTil7QRMDsF0u+c6B9IqdDz948+A3beVmBTcI+kkdUDMh19AD8cbu
	 iwmeNWiYZVJXPefEv2388mynzQcj5jJODAPZyP9Z57VGmHc8DibnQhKDOI6INivjMo
	 6nWeKuaNdAMVQ==
From: Simon Horman <horms@kernel.org>
Date: Wed, 31 Jul 2024 09:11:50 +0100
Subject: [PATCH net-next] tipic: guard against buffer overrun in
 bearer_name_validate()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240731-tipic-overrun-v1-1-32ce5098c3e9@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMXxqWYC/x2MSQqAMAwAvyI5G2jdin5FPEiNmkuUtIog/bvF4
 wzMvBBImQIMxQtKNwc+JIMtC/D7LBshL5mhMlVjXG0x8skej5tUL0HXty5727jOQ25OpZWf/ze
 CUEShJ8KU0gec9ebfaQAAAA==
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Jon Maloy <jmaloy@redhat.com>, Ying Xue <ying.xue@windriver.com>, 
 Per Liden <per.liden@nospam.ericsson.com>, netdev@vger.kernel.org, 
 tipc-discussion@lists.sourceforge.net
X-Mailer: b4 0.14.0

Smatch reports that copying media_name and if_name to name_parts may
overwrite the destination.

 .../bearer.c:166 bearer_name_validate() error: strcpy() 'media_name' too large for 'name_parts->media_name' (32 vs 16)
 .../bearer.c:167 bearer_name_validate() error: strcpy() 'if_name' too large for 'name_parts->if_name' (1010102 vs 16)

This does seem to be the case so guard against this possibility by using
strscpy() and failing if truncation occurs.

Introduced by commit b97bf3fd8f6a ("[TIPC] Initial merge")

Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
I am not marking this as a fix for net as I am not aware of this
actually breaking anything in practice. Thus, at this point I consider
it more of a clean-up than a bug fix.
---
 net/tipc/bearer.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/tipc/bearer.c b/net/tipc/bearer.c
index 5a526ebafeb4..3c9e25f6a1d2 100644
--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -163,8 +163,12 @@ static int bearer_name_validate(const char *name,
 
 	/* return bearer name components, if necessary */
 	if (name_parts) {
-		strcpy(name_parts->media_name, media_name);
-		strcpy(name_parts->if_name, if_name);
+		if (strscpy(name_parts->media_name, media_name,
+			    TIPC_MAX_MEDIA_NAME) < 0)
+			return 0;
+		if (strscpy(name_parts->if_name, if_name,
+			    TIPC_MAX_IF_NAME) < 0)
+			return 0;
 	}
 	return 1;
 }


