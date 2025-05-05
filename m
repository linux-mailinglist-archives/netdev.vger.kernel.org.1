Return-Path: <netdev+bounces-187695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5FBAA8F02
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 11:10:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 836D11897803
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 09:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 917061F4261;
	Mon,  5 May 2025 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6yuBXwh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050151F3D20;
	Mon,  5 May 2025 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746436253; cv=none; b=LqJmdlDmK7fMKL9KiAFUSkALiFfu2wI6ppk5YUnFB//qfXg7VgfllCEAgx5Fgl5iVcG+5xHtCTtqjD3VTcTqXSDRWS8xGhj9vRUepDT46WkE6DO5EJUOfdUY+6pYQVJjWfjZf74pCvUFUs1wQRMwmixJXqYYPOWS73Er4SJ2RTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746436253; c=relaxed/simple;
	bh=W1UhMgLjVd2n2XGiQWxnLIrYjuUTOOTZ7SjWfHY102Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtnHVEC9ucf2v5gBNy4LERUHcx2rkiBit2LuQzxEh9DgcRwtpSlpAIRMJRHOW7o3fzVQ1jZdugGFAOBiccn6lGrDKfJ/S/Mz8+5QCp9K71UODIe3lqrjrBxQ6wGUZjSBMRtQNJD/kRNWPQeXmZQWxRVRKFe7N7GGOHTNV0uC6Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6yuBXwh; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-22423adf751so47127495ad.2;
        Mon, 05 May 2025 02:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746436251; x=1747041051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E/zvdg2/U/i/qCcOe+f7vAEo8dPot4Sa76Am+x0kALM=;
        b=S6yuBXwht2gLJOl1zmis/Ukdeg/HniBoa0QTe9NFEvpq4ffa53yHWTc9IgEYSzfP8B
         npSU4aRqzXop+D3OnxJR74GHOWXmEdwn3vGdf/MrGcXnuyXaZ6OJRArFUYUSJ1C/yMEP
         nIqY43LMqqooyIr8pn2T126EUenJ5OitEnjXyiUpQvqYD32LNMUWARJCCrnupH/4u0aB
         913LNb9g25pCxEyzqDkft9wx+GKXq2j06WO6luoxZ3iGuYqfPSQ5QSp+Q28UygeJgNks
         JdyUpeOL2fMaVf2xGy5H91KBzew76wvq+U58eoEk8Y0TC75L9XwbHEGETSCGegwSOgm8
         NKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746436251; x=1747041051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E/zvdg2/U/i/qCcOe+f7vAEo8dPot4Sa76Am+x0kALM=;
        b=slyTKTvBje3rLtDN8r5KytXUptCq/zck+Z+wz5T9apJuh/7EUm5h9Cwl5yU7u07lcL
         rsTTmwO+z5d8qt9rlHBzJtVK83zKg2iIbZfK3qiiRSZfuUYQvIOv4hsLFz7xsf0f+2j0
         /KOQwISlyyh+Zu+Ep9pRqAtif5PsW1AfPs+p3fm5+E5OnvRS/klmPDzius52kNb+FEsr
         NMOuszFi0cKbB0L3CyLa+SWDkvU8HgnwQ3XGSBQTxotW66Mi/l3eJvjVIcC7llb2SN4g
         5ghOYE2x/y8ptePZlOql2vISLhSKwogTKWm/CHBTE3hfsF3R+Elc33uht5mUoRHDw1BG
         tF6w==
X-Forwarded-Encrypted: i=1; AJvYcCViPR/iCklktso6QnCRr/qe1T7zc5Zp1XhmD8spX/m84aRPwO7xd0Sq8IlHq2gMbvCwSMSWBa1HFnYhusQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDPXgwzRHoAUiT0uQ3ifnTTo03wMz8g9d8CvCoc3RM0QWn+ocT
	8NXC/pyoakUtkSzo5Ob4fxHkw9u2HItVH5nj6vHdFwtvJOuvw5Yy
X-Gm-Gg: ASbGncuj7SoPcfmEUT1aKzAItPAY7X0HCdlU278IkjplCZVX/hJSjlf/x3sqHm+11Ac
	S4gLhGVTbPow41fLlX+WIs0Bb+2NLOT8b0TJI1l8/PdVHAA1nMBa5roRAXGIw772uSXZhe7GabJ
	iaaqs0ZCdjKizy5qyu2hpg6KA26AZ077yHfPpTXtogk1lbv0H0NuhXVcm69umaxvVycgwBnWpxu
	HfEICsMxASqTIFqEsx+RjAkOsgRcpZcio0aMQ0WvAURs+1+UhCuz3jpDyJAtle6eEB57S3rIMDt
	RPKiztyXnk3kuw4TqUPkAjzh8SdNQF65KSZrsxrkPzn5UQ2Qp87gn86q/ig=
X-Google-Smtp-Source: AGHT+IHLbxeGLjT/TswtMt+x7j48HKYYWzeEqiEchK77MOzKnnrmbYjxUgmkxglRUnq2YBocQ1/WiA==
X-Received: by 2002:a17:903:3c25:b0:22c:3609:97ed with SMTP id d9443c01a7336-22e1031f6femr176430255ad.30.1746436251199;
        Mon, 05 May 2025 02:10:51 -0700 (PDT)
Received: from sid-Inspiron-15-3525.. ([106.222.229.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020fe7sm6435377b3a.102.2025.05.05.02.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 02:10:50 -0700 (PDT)
From: Siddarth G <siddarthsgml@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Siddarth G <siddarthsgml@gmail.com>
Subject: [PATCH] fddi/skfp: fix null pointer dereference in smt.c
Date: Mon,  5 May 2025 14:40:25 +0530
Message-ID: <20250505091025.27368-1-siddarthsgml@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In smt_string_swap(), when a closing bracket ']' is encountered
before any opening bracket '[' open_paren would be NULL,
and assigning it to format would lead to a null pointer being
dereferenced in the format++ statement.

Add a check to verify open_paren is non-NULL before assigning
it to format

Fixes: CID 100271 (Coverity Scan)

Signed-off-by: Siddarth G <siddarthsgml@gmail.com>
---
 drivers/net/fddi/skfp/smt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/fddi/skfp/smt.c b/drivers/net/fddi/skfp/smt.c
index dd15af4e98c2..174f279b89ac 100644
--- a/drivers/net/fddi/skfp/smt.c
+++ b/drivers/net/fddi/skfp/smt.c
@@ -1857,7 +1857,8 @@ static void smt_string_swap(char *data, const char *format, int len)
 			open_paren = format ;
 			break ;
 		case ']' :
-			format = open_paren ;
+			if (open_paren)
+				format = open_paren ;
 			break ;
 		case '1' :
 		case '2' :
-- 
2.43.0


