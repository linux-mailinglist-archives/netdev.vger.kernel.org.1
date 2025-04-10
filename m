Return-Path: <netdev+bounces-181253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B54CA84330
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:34:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C9719E82C0
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EDF284B2D;
	Thu, 10 Apr 2025 12:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZa10pSB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127723A8C1;
	Thu, 10 Apr 2025 12:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288437; cv=none; b=SAzbLzuN/a6TAi+gdlmq5cGXctMxd8xY9DblZb22R6iu9Ll8pouhlWRLyoIiNJEtvBUY9NzC9LKX5p9NF2txJUuVQpgsbrO7xuvBhBLF4WUuhc0vTby26P6ie0hKf54wtWE+v/C5paFe4sUwaxM1XMJmaRrM0FJrQ3S1146aSGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288437; c=relaxed/simple;
	bh=/WszoMIP6EQYuRW+MTr7n2B9CJYeHTdfrFM3mSvNScE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DsO23tLAqRvj50nFEl3Wjp1L8NgTgYz12BVACj8ho7eKUmgl/1mFZovxv2vYiSeSwJZgnWsPt6SCx8sM6v4ck83hXAsfh8b7FbF3Yom5cEdAIVR3XXRXBxrOUcq4OV/tkhwmn6gAavC15R6+rKLZ4T+pa5uIibvjoMYdJDc62gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZa10pSB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227d6b530d8so6333785ad.3;
        Thu, 10 Apr 2025 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744288435; x=1744893235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fdhtisb7ONya5sQCeSv1FXg5FKXsjOsuUWxLEyWVkBw=;
        b=EZa10pSBU0QcNprpeYYnInrIBAwozpsx6sqGpsNJJ4Z0lbwW286ZD5xCqeQcXtjzPM
         1EQ+bXLWLfWA84lqYBUq2DmyCPdQSbHrXn8gf8PEyjNNxnEUyvhJtYgP6pmfpVCrYNq5
         f98kzlg+7YP98Eacpv8u/sg4AA11yBORGnHUgXF/jnVVchDEKMJx+S+sZB+rmX10Qhqa
         GNNGRKox/8HFIxGwowLzc81Vcd5kDHA9vCUvQPVr5coGU/gZ+CGdWLfLOqCbXuwpq1As
         W76veBqK6UvBhQjD0l6RJBLldJcK8arPzSCqM7SVlKxGGZf3dvdyGnrRh6syXsT1pPAj
         1JTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744288435; x=1744893235;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdhtisb7ONya5sQCeSv1FXg5FKXsjOsuUWxLEyWVkBw=;
        b=fq7R2vcOxoas5Up57JYLjja+AvN5pCDlN7ZUGyflMQuz4Tmf7AQ64PIi7C2qGcNEP2
         wTfNzlZSG2X6ABFJga6OcTHRps7NOLn+1iRL9DOhvDe3vM8vczlTbYXaWZXy25PaJI0m
         1lk1AldJX+2VqzhcZLgzRCI5/vy2mLdLT9FeSED039/FKmFL95GZNCuxhGA8f14luAI2
         n/Qez2bX92SxMKJgGlpcOYMtJqBULDSWSvqO3BOseklT2dz2G2+VfQoX460oCRTA0FSM
         opr39GBD7xyfumVLWT6z5Rza7L1BBbDfJWwTMBm5uvzNb7WZkit9bTOtrA4KpGaE95wZ
         blyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVf2HjYo7FgSRTkY4XA9geB/ryAd/envRfPcbeXJ28h3F6eUkv/oLc2uajDeypl5aNSJlKEC7S9A1j0Q8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOa76UdrUWptOIgwG3cz75Nomy5zQSGuGyvYhtJVcIlCJHSzYM
	0YkXaXMIK5T2Q7FZ8CZlOh+mE9Ub91YqY5dqXyQXhWRKI30r4J8U
X-Gm-Gg: ASbGncuD1DHz5haciWCz8bj6XhgSQ1uVvXDHX0jbhKziQzD1kcqAuphTK4MJYn1wu4w
	QV9vXf0U4pT5F5UrdiQKsNeCKN8ZUequyo2XIzqsNmyeIQ2SWZmvc5bfdGmng5z+pWWYcxheP1j
	YpUGsL1CHVc2IVe+zhISa4+p0UyU1Cp8jfpjNZHtmvnrGRQOQf4aXG6k8fDdy/29jX/aH4qMj9M
	hCMHg/f9PctnHHCt9JAko6gdJPb6s/ki2G2N51nMDo1dd9NtrUUUti3w49lc7XN8+MSVyxZpTTj
	QkvH0Fg65bUyvgI9qgoleTQ58fxSOKLh59XGre8bdyJQ0k1dBo3U1xHNj5Ic
X-Google-Smtp-Source: AGHT+IGWopa21TT5kCKlAgfcD/hVkByLHUMsaams5ryy0ih3QUKrE5F4Zs5cycX2GkjUTWzdwFtfAw==
X-Received: by 2002:a17:903:32c9:b0:224:1af1:87f4 with SMTP id d9443c01a7336-22b2ededeafmr47866165ad.22.1744288435078;
        Thu, 10 Apr 2025 05:33:55 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:4e2c:2a27:3898:b58d:494:6c50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d2b913sm3214645b3a.12.2025.04.10.05.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 05:33:54 -0700 (PDT)
From: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
To: jmaloy@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
Subject: [PATCH] Removing deprecated strncpy()
Date: Thu, 10 Apr 2025 18:02:50 +0530
Message-Id: <20250410123250.64993-1-kevinpaul468@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch suggests the replacement of strncpy with strscpy
as per Documentation/process/deprecated.
The strncpy() fails to guarntee NULL termination,
The function adds zero pads which isn't really convenient for short strings
as it may cause performce issues

strscpy() is a preffered replacement because
it overcomes the limitations of strncpy mentioned above

Compile Tested
Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
---
 net/tipc/link.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 50c2e0846ea4..4859b3ccc094 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -2227,7 +2227,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct sk_buff *skb,
 			break;
 		if (msg_data_sz(hdr) < TIPC_MAX_IF_NAME)
 			break;
-		strncpy(if_name, data, TIPC_MAX_IF_NAME);
+		strscpy(if_name, data, TIPC_MAX_IF_NAME);
 
 		/* Update own tolerance if peer indicates a non-zero value */
 		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL, TIPC_MAX_LINK_TOL)) {
-- 
2.39.5


