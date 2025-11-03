Return-Path: <netdev+bounces-234918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D28C29D30
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 02:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FBC43B4160
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 01:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8D0283FEA;
	Mon,  3 Nov 2025 01:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcOMsllB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639A28032D
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 01:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762134669; cv=none; b=hmwSOkD2BcnMTRAjfgfLtCYmH3OkeRsz4rjPmdS5OELg4+Tu6tFh6giUUDwxptAkE8QhKQjk2Ajd3u5ED/67fPiQTMdzZMsdgP4+vf4tMuJdB+D1G7zyXeyi6qTY+/jUr3OI8b2rmlkLhECLkt5UynB7d+Dqpba5l7ZjIn2TZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762134669; c=relaxed/simple;
	bh=JgWKdvcJvzVSKPKbVkwTpRFKNunmCel1aIpuFYtAqbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hkTzkkobrG1ypcQO7qYS78/p8iu/Zf1cm9L93ye5i/9NNl/YwRFvRzcl26ylcQ6KX5koxf1gp6qaKoyiSN9VxcJNa93Af9W068E0p2rHPPBg0Ek85HvNFNSfB8PZJk/aqHiivlsCzUuNrhOy+qB+5LKxWED1Y1IAOta73KVv/CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcOMsllB; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7abe8442103so14322b3a.1
        for <netdev@vger.kernel.org>; Sun, 02 Nov 2025 17:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762134667; x=1762739467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdMfHyt22jO9oNsfKfRQneP/eHVIzzFGDxzlaqt91u0=;
        b=fcOMsllBoSxFLcrw0bhBQeE1o8UyaHgdLU+4Eqawv56q/xsZn96TxTBOLoOR8RsEm3
         /LyhIq59Cli5PeowcWb/L3ESjkt/GVGckKpw44chP9FKuJPWZMNKPyvGeqjurD8NiG/9
         2UJv5r/CfWbgT29hzex+L4edKGx48HF8VaNjkfo2CFXfKpCOYcsofzF3vmIHePnyn4Ev
         XL/g6OseJYOrypQ8a3t4bL6bIchS/7P+y+aS7XcPpcPTmPvnokZxXYvT/sWhky1iKF2K
         nq7FeQjnv+ireJQaSfejjf3WVQ7fqahT5vBZfvDEeJuwm8pO59S4RP4JLgrJhjFJdU8D
         I9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762134667; x=1762739467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zdMfHyt22jO9oNsfKfRQneP/eHVIzzFGDxzlaqt91u0=;
        b=dVS0yhZO/e+FqCZhj4btgW1sZNf1R1UFdA/XErNPoQCyvUhAdVzap1RsI+d9ONV2oT
         XfBiZs6tuYLBs+muj1rU9aGSLfoBXCRAT2kZeX8MOBxaNvaYqfF5yO+SU2pI02MvRcaU
         xXhaMJnZ5PNAsayeQzdAysrKHiMLRjhImMr0FsSz8tm03vdcS/Vbrubwu1aQVk55+c/D
         XFANDDxjSWzYue7rHy0p+hXydhg0s7Il4O5rrBBQ8P6offtjia4c00/95kgw9t7bXXM/
         b0Np04nUKfmNA+Ou6PDKDjXbjBn+FngFF3OjiY9O9NqCibK8tnNrOFFWqpFSkuQnEuxk
         9pBA==
X-Forwarded-Encrypted: i=1; AJvYcCX5RJiks6jmfNrxkVvDO0fBomb0wQ9638ZfdIbDRaa2rtdCznO+xflfPiA9fcRXK7CDlrSIQPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWIIroMhHBIf5gq0KcTmqancXqSPF41EOEshKRl7Xs91oJVsPy
	ynFPwQrvRzYpXmhyLmhdbntuAaaeTSPdDoBd0khbLTc0gLwVPs0zED+m
X-Gm-Gg: ASbGncsUathY7mZdiNyuO3dBov1daBiWd6lULmcPlN1GyAA4YUfY6kC9tf7gHXL4Y/z
	PHjWdlZ6Gy4WyLHkqwxNrbLKPoJ4gBQhFiTq+f1j50FOsmcGT66ZjUVXYmVZE336P+chC5HKfUW
	f1AzcsMzXXixdg2CsGYFt+qKPqPXqQzTVJ+I8m941EJ+AZhbJJEl0vhRUix9lAoLDSZy9pAcb+a
	Hx+n1URR8NVE+wKDzLmmXLQU1blrkhzgSKhcwIlmgviQV+Pz/zCrv2hwfWEjCNRFMNdjgFexdVF
	FhKT8u/Zj9l2le1oTzCSFONv7rS+88ngrlOB7O8D4QjFK8OhZlxGGNGKYwecP1heVJ6TIqG5vZz
	8oJGwA2FO8MSCF/9vjlRRWmnYLrj8OYzn/7SNpKPgnvYnkni0qXvgXeYYWO0HSFi58XsyVNp9ij
	cHH2+wdTGlRws=
X-Google-Smtp-Source: AGHT+IGtPDnXRLhodOzWjKVorBLmZZArqq6WrtuVpT1PUyswb5XRTNwPthjwi7QHLJB2VwQx55kp+A==
X-Received: by 2002:a17:903:2348:b0:272:c95c:866 with SMTP id d9443c01a7336-2951a3b6b8amr157826915ad.20.1762134667238;
        Sun, 02 Nov 2025 17:51:07 -0800 (PST)
Received: from archie.me ([210.87.74.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2952699b785sm99883215ad.78.2025.11.02.17.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 17:51:05 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 50982426D9DE; Mon, 03 Nov 2025 08:50:59 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH net-next v3 7/9] Documentation: xfrm_sync: Number the fifth section
Date: Mon,  3 Nov 2025 08:50:28 +0700
Message-ID: <20251103015029.17018-9-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251103015029.17018-2-bagasdotme@gmail.com>
References: <20251103015029.17018-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1196; i=bagasdotme@gmail.com; h=from:subject; bh=JgWKdvcJvzVSKPKbVkwTpRFKNunmCel1aIpuFYtAqbI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDJkcnJXLzFoSvTxdT4tf5Gt8qq61wtnvZvDSB8WNEfuTw 7b1v1/TUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIkU1zIy3Nr86VWXxiSxXIXP KU/l/ph3F+y+KCJolzZtt2PJvVqh4wz/a6STl/YFPtXpOMDksGpRzOwTbLmPTI+Y967UnhnxJWY pHwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Number the fifth section ("Exception to threshold settings") to be
consistent with the rest of sections.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/networking/xfrm_sync.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm_sync.rst b/Documentation/networking/xfrm_sync.rst
index de4da4707037ea..112f7c102ad043 100644
--- a/Documentation/networking/xfrm_sync.rst
+++ b/Documentation/networking/xfrm_sync.rst
@@ -179,8 +179,8 @@ happened) is set to inform the user what happened.
 Note the two flags are mutually exclusive.
 The message will always have XFRMA_LTIME_VAL and XFRMA_REPLAY_VAL TLVs.
 
-Exceptions to threshold settings
---------------------------------
+5) Exceptions to threshold settings
+-----------------------------------
 
 If you have an SA that is getting hit by traffic in bursts such that
 there is a period where the timer threshold expires with no packets
-- 
An old man doll... just what I always wanted! - Clara


