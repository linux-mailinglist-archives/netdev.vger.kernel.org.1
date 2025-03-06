Return-Path: <netdev+bounces-172428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E64B6A54933
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 12:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B382164F30
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 11:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A96922054E6;
	Thu,  6 Mar 2025 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7U1uxbZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90CF2040AB
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 11:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741260330; cv=none; b=Bq8vflfDoEDxhztUJnCe2pqglsKRmX9OLMqYt0cL6xDJ5lfsBameNDE+pxPQUA+5Gwe6d3lOvWCEJxyRgbugjzHUFEvMo8CSTidtigiAvqqnSGvLhdFsYSAl7LzMv5IxpHb7Um0GfNlw6aXMRV/wIprTauIth3ioaRrU+rUyvZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741260330; c=relaxed/simple;
	bh=rn5LfxxNJ3thiTELfrGuiD4PDx0EZeWDR4epXKiIA1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OmRUwExu8+51R6b2CsIyPjQdHkzfewqVLGgf7+P1Oq0ru5wG6srEangPn70OGTnId6pPuBA2pnpcMeDtKL58fu9pcyheHQHVcgufGKa1vylLKQkzKtFkL41CnPKRNEQAi7JnpSFvV1zUnqTV4YcIqAnqtjKy/Dc9VPUReqiQW8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7U1uxbZ; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-549662705ffso615800e87.0
        for <netdev@vger.kernel.org>; Thu, 06 Mar 2025 03:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741260327; x=1741865127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WuixkZKDahUNntKHDGJzWJgTMReGPlig0Xyv48uh0Lk=;
        b=M7U1uxbZl0nfwnTmWWY2J5ivuAug4g3WI1QmiFwlTFeQsNaODLR0kCzwzNb8PbJMZR
         umGDF+2K08WDBzeu0aPY2l0ZNGCQl9YOQYHfTkaAAFI3LOoqNH/yUCPbiOm2WKXQ2alH
         FwBKWpPmTPmjyECm2sjkdHvkQYdPNstYdXKr0t+aWred/s+Cxx4hmWaPxHY0LDJYD/29
         Isbcse2NR/b4S35rIcmul2ZS5Rtl4ejuLUd7Jo0aC7QW8gqQT0bYlP03LZBrNIMTDEeb
         LZxnPPQWocIgpC6mFpqg30YtHnOryM6D4IpZn6fdsz9FBfcW7VNuDTDd7zzuz02Bu/w6
         Yoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741260327; x=1741865127;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WuixkZKDahUNntKHDGJzWJgTMReGPlig0Xyv48uh0Lk=;
        b=e3BksjiuVYhX+36Nwa7d9eedNm3ruYJXkbEoSkeK+VvoGJAKgzSI4COv9B/f0ls1iK
         rt1bQcG77wvknd7LxkdDRSG+5Lt4jlxGx0Qg/nSnQwgIfx+sNFW1ZC+P9sDBH+m+bHqa
         CPw2NxKRiSjcdl+aAlz5HHQ/QyEINcxm1cCTxSHkmXSYQb2jh34SZv1p1VuxpbKRVnHs
         tQAeqJkK+pO235I1nX1l3ha+YTxGmaFfezY73GS1VfKqFv7FHrTPWHIKF/0a+7yJabqP
         7dc45xz9c8gvnadsAOgEuTqpLNPBOXvTXGbahgl+AJ2nhNCCm3jqBbtkjvnj0qH/lXsj
         dZxA==
X-Gm-Message-State: AOJu0Yx9LYKBT/l2Y4rEmhnxxUVpBdW1HUL9wegUy28L8AqrwhbGi5Aa
	Zqt4kK3pnKPbVaU3N1afquHJ4RcFp20a5U0QRxZYyIRcLfH/rePn9Le6LgA50bk=
X-Gm-Gg: ASbGncuk6q36MlcYRy3wRPgJx1BHc7JlSsgJXX130XIK8xTXwQD0PaNs/qx1zsK5DJz
	SWdSkW6rEmUYAhDJ2Qk/P5FDg5bQNBbmNb7+l3YZ27smVN0E/ceJbtYedw+q8CuAZHhn+PI4sjr
	XM8SSOffQn4TZiMDWTRTA3FOaE7fg9ioVyCbqdgyt3L0tOy7yDcg9W0VmHM1XirW7RksxP5nls1
	UauI4tBY39MknuBC1sH8YSBUc5ZjaxRhK9g2zcRN09xR6yc6kuRHYw5HQJUXi5AAMMeNh3ElX6W
	aFL4fuyHm6HSRZ/4+6EJ5zeZe6p+2jFMGPXRzg==
X-Google-Smtp-Source: AGHT+IFRNyo01+Gu+8zS7PtbggI3AJCvNaX9bUISme6v5O/+7E31dScOOYIY3ZgzxUF66D7Ua0sUdw==
X-Received: by 2002:ac2:4c0c:0:b0:549:8c86:740d with SMTP id 2adb3069b0e04-5498c86763bmr504005e87.18.1741260326476;
        Thu, 06 Mar 2025 03:25:26 -0800 (PST)
Received: from localhost ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5498b1c33a6sm146465e87.231.2025.03.06.03.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:25:25 -0800 (PST)
From: Torben Nielsen <t8927095@gmail.com>
X-Google-Original-From: Torben Nielsen <torben.nielsen@prevas.dk>
To: netdev@vger.kernel.org
Cc: Torben Nielsen <torben.nielsen@prevas.dk>
Subject: [PATCH iproute2-next] tc: nat: Fix mask calculation
Date: Thu,  6 Mar 2025 12:25:19 +0100
Message-ID: <20250306112520.188728-1-torben.nielsen@prevas.dk>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In parse_nat_args the network mask is calculated as

        sel->mask = htonl(~0u << (32 - addr.bitlen));

According to  ISO/IEC 9899:TC3 6.5.7 Bitwise shift operators:
The integer promotions are performed on each of the operands.
The type of the result is that of the promoted left operand.
If the value of the right operand is negative or is greater
than or equal to the width of the promoted left operand,
the behavior is undefined

Specifically this means that the mask is undefined for
addr.bitlen = 0
On x86_64 the result is 0xffffffff, on armv7l it is 0.

Promoting the left operand of the shift operator solves this issue.

Signed-off-by: Torben Nielsen <torben.nielsen@prevas.dk>
---
 tc/m_nat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tc/m_nat.c b/tc/m_nat.c
index 69d54c6f..da947aea 100644
--- a/tc/m_nat.c
+++ b/tc/m_nat.c
@@ -55,7 +55,7 @@ parse_nat_args(int *argc_p, char ***argv_p, struct tc_nat *sel)
 		goto bad_val;
 
 	sel->old_addr = addr.data[0];
-	sel->mask = htonl(~0u << (32 - addr.bitlen));
+	sel->mask = htonl(~(uint64_t)0 << (32 - addr.bitlen));
 
 	NEXT_ARG();
 
-- 
2.43.0


