Return-Path: <netdev+bounces-182964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D0A8A73B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F033BE906
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A7623958C;
	Tue, 15 Apr 2025 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EI65kYFD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E97623957F;
	Tue, 15 Apr 2025 18:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743029; cv=none; b=eSf79OjLlWcuAO6Irob0rhPz4Gopo7wnRoHNCBBruE5RG2WoRrLCTmfd1pruFYVYsCQblqzE+BT0EsYdJqc93wjii79v4ceiWVcj5Qoeb6RAUelSW4byrp6ZhXq7XOmNY1IrRy86aIuCAAXDHEb3JbcBitEwsDSeeTYUP2uG5xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743029; c=relaxed/simple;
	bh=GUxWClb2p560YPhhqW30ElRrwqIgB8V99LnyxuA4BEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qusGegePVwa3SJjgACe73p5WCIOztZ750c5Lo8+PPvtsdxtHGOszOEESU2paoJo7EEr7HbAvIi0rcwDlxvJtW8bk57R5RIORi2v03YyfJF2KuVUAJU3vMLvqwq9h+I478tPIND1ajFQMQW7raGJH6Q2BlWo9QRoPLZNTbwbyl6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EI65kYFD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076CCC4CEEB;
	Tue, 15 Apr 2025 18:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744743029;
	bh=GUxWClb2p560YPhhqW30ElRrwqIgB8V99LnyxuA4BEU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EI65kYFDUb7skoZvuo3+NCVhsAKSvtLTrK1kGqkmBXmldGubpMjyHMQdz+U3u1Hs5
	 tnEKJ9ZpEYTh/XaBv8eV9BzQWo6AA8YHCP9STW2rJS9vmf8J8fRR6dhNdq9QQdvPJv
	 K7Ig77oCP4L38BsHZ4gHLi+6YuSUZXQHiAKvWXlt2tADYOhO+N65N//MTIEF4WLGQH
	 XZ4ar16UOp94VNd1m2FjCeXHSCytCPg6nSWO3Gy//DXDA0UfnU0M2fXvpnyo91drRL
	 OtS2SefIZdBJuJL2p500ObCacHRJen/tMTS+dX/3v4gHIg9mFrgpFtJ8eIvpQ0qic+
	 bf7Qt6JXq30ww==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 15 Apr 2025 14:49:45 -0400
Subject: [PATCH v2 7/8] ref_tracker: widen the ref_tracker_dir.name field
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-reftrack-dbgfs-v2-7-b18c4abd122f@kernel.org>
References: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
In-Reply-To: <20250415-reftrack-dbgfs-v2-0-b18c4abd122f@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=696; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=GUxWClb2p560YPhhqW30ElRrwqIgB8V99LnyxuA4BEU=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBn/qppXPDCs9+jWOKGKY9T6cY2KifjDeb9uiA0M
 Y93TKREGS+JAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCZ/6qaQAKCRAADmhBGVaC
 FV4RD/95RrzXlJECwkM8G6ZYl+uwki7wa0ugi/6t+MtEACoCnHy4ceXvya9zbVFkmwR5EyfmMss
 ArRr1eo3GWhlIuz5KBNwbeJsyzl8ss+kGYXQCqKS3ESWSfUTpLLH03qL/fx8R3UcGASRsGviHDt
 TkR3Cw6DIozKK2zf9zNeMazmtlRpnRTJk83IgdKtLsjKabiDRPo/QA+PRjDPX88zN42/G1QU1Co
 V/aUvbEN5iidFu3BJveD7g8YN3VqQjb7sQfsTdNJj+uOpJjJoOT6bYrjTPzK0tUjMK9CTaokhL4
 0bg6N3O1ZE2eswL/MjBsSWFS9njYxM3Cit5jt6RhFswd46ZKFT3ccCm6PbOGziKbznhPsc8fx1M
 wWdYonxL1HP5mKUWXWLXdtRKa3R5vTVEaCTKfj/4do3/ArP88RDA/tKsMwwjU73iPl+4VPjmfT0
 eLYiFlDDhWRX35TzQ99PqOe9YSQTji5U7y2f4c6sEpV2Fmk94SkMYfiX9l0PgM2NpEbpAvXhAKz
 iNnNGoISTgMRGWdZWMrtVvPiuwB25dotUfe9go6hyFPKhnRNe9Lf5YgouyJrWtLCkSG20qOVi9E
 EuJR2Jv2+40IblBh7uiabJr2g+ALFnHqzjkmqo8EOxYn3du8rRaWF7LrhFA09MP7/7wUVJpTORx
 Qvu5neeCPwMGzXQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Currently it's 32 bytes, but with the need to move to unique names for
debugfs files, that's inadequate. Move to a 64 byte name field.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/ref_tracker.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
index 77a55a32c067216fa02ba349498f53bd289aee0c..be3e43127843f710c22aadb47612e07ce9eeeacd 100644
--- a/include/linux/ref_tracker.h
+++ b/include/linux/ref_tracker.h
@@ -21,7 +21,7 @@ struct ref_tracker_dir {
 #ifdef CONFIG_DEBUG_FS
 	struct dentry		*dentry;
 #endif
-	char			name[32];
+	char			name[64];
 #endif
 };
 

-- 
2.49.0


