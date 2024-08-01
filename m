Return-Path: <netdev+bounces-115106-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1EE9452D6
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 20:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6868289225
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D131D144D00;
	Thu,  1 Aug 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d56OxhyY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA6013E04C
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 18:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537367; cv=none; b=kUIjs2nc/Er3vQFXA/zLnkiWCFW0EA3h8Uq0hoTWno0h4SMTmwdLKRAYtxGn3vf8lhw2+jaikEpvMQlOdtHnuCJ3p7BByFKAqFXmBhDdNbs0nK3T+f52Mc1PqcBhc02/T6cWOu0RsHr0uVXmMX8+qu/NDeDpDW//M9bLXDq06v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537367; c=relaxed/simple;
	bh=RjRTWMLuV0Wx+hm5p0y1+jgvBz9RlrQvllRNtT+BGOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Amm2LNYGjWhn2uhfbGAWUQBkpiOH4gNiEhiR1rtqU+X+Iwwevjmsqm2kul0uZc8Xg023HNwZ1WLH6OML3rVUSDu3lGkjDgyajDelaEaqB0Y3qvvyS2Z59O36rPUqlpqcY9y3tcWpKXi8rLrSSnorgvZphU1sM/lO4F06XEFN/JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d56OxhyY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9526DC4AF09;
	Thu,  1 Aug 2024 18:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722537367;
	bh=RjRTWMLuV0Wx+hm5p0y1+jgvBz9RlrQvllRNtT+BGOg=;
	h=From:Date:Subject:To:Cc:From;
	b=d56OxhyYrlGUPz+u4ElyuDBqI6er4DzkQylyDDPR5CwcuYQQepPskm7eVPpsJa5Ql
	 bIpbOUyRHOSe0V0q5P33DQRbwZRhYsfy2hRg7XmvCFDv8DQoEeUk6Dhv05uFUM0l7a
	 vxSqh0QHoC52js/bJ+hHmKeivjBvOWACXJt8XWTUmsSWAILG/kL7fCMJ6oAmR0LBGg
	 m1ykwXZdGiMB+WS6lacvqKiK/UMjAbtY720mVrh+E6f53DtmiiSKXiGdgroT6QWDTa
	 CRlQ882SJ9W1QAA2j4vCujtx95DEDPYtYvrODkhabldPFXEucXUFcTwGyJVPWPrYXs
	 MTSQDpcJDVK7A==
From: Simon Horman <horms@kernel.org>
Date: Thu, 01 Aug 2024 19:35:37 +0100
Subject: [PATCH net-next v2] tipc: guard against string buffer overrun
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-tipic-overrun-v2-1-c5b869d1f074@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHjVq2YC/3WNwQrCMBBEf6Xs2ZUkbY315H9IDxLXdlGSsomhU
 vrvhtw9zjzmzQaRhCnCpdlAKHPk4EswhwbcfPcTIT9KBqNMp2yrMfHCDkMmkY9HO/S29LqzJwd
 lswg9ea2+G3hK6GlNMBYyc0xBvvUo68r/OLNGja1x1Kvh7Foari8ST+9jkAnGfd9/I5/8bbUAA
 AA=
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

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Simon Horman <horms@kernel.org>
---
I am not marking this as a fix for net as I am not aware of this
actually breaking anything in practice. Thus, at this point I consider
it more of a clean-up than a bug fix.
---
Changes in v2:
- Correct formatting and typo in subject (Thanks Jakub)
  + The formatting problem was caused by tooling (b4)
    so I reworded the subject as a work-around
- Added Acked-by tag from Jakub
- Link to v1: https://lore.kernel.org/r/20240731-tipic-overrun-v1-1-32ce5098c3e9@kernel.org
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


