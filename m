Return-Path: <netdev+bounces-140346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E41E49B61D7
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 12:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86272842E5
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 052631E9081;
	Wed, 30 Oct 2024 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dr2/OAeO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DAB1E907D;
	Wed, 30 Oct 2024 11:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730287872; cv=none; b=CRVNe7dqoEmMM1sIM4B3Ea0VkYbleL1qW925gf8N4T1wcA34ugc+ajg00vTPyl5MtFFtbE8vKIRFXl/G7L3BhzqjjEzYCeyeJKMqTVcTw/uIODrLmdatf7fFpXAECAXNX7gaF0NGIT0b8LItxbFoUxhzdShcY2swDs9C2o7wPrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730287872; c=relaxed/simple;
	bh=TuQA7dPpS8bAGcKBW+pbPNP714DcJshUvyM1zp01fAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ik9i1uKjtEjvWwrVEh/z5Zb5rxCYXue9jp01n1xiNERq5tEsXM26siSAPGv4icQjZvU40+FfTd5tzb4YA4IQQbpa5GmQpUpA9VJ/y2vJSjaR1OxZuCwi+yAPekPU1bAt7esE5WsDODSxm38Y6QWm87QhksGXieaYQ7X7wC7Ly4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dr2/OAeO; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-2e2bd0e2c4fso5253099a91.3;
        Wed, 30 Oct 2024 04:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730287870; x=1730892670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I2pAE1nQgw4jbrmDxYeWEQDTLjgIt/Rez86CyuKC0C0=;
        b=Dr2/OAeOhyr1OXsxeeFVzxRn2D7FWUJK3wUF8cquJLg0ajlT70er+oL2bIg17XhxGy
         syZgJfyTrcd826WZau8/9Dfypuj9ipi2JGjBAJ9W0gTGg+1rNAFGHN9mCUdNtS3Z4qPY
         Hbpz1cHsL/hGoOprpsWlzFm8KNcu+C5zu4C+49L3QGPTSVm5qMsbQ3A64o3UAvs5hJsz
         F1HvEnuQWCIqcqF9orNo0igITtzBrchykTmEf39VxiR4JfWHXh5ds8zbkjVU7ichtf5U
         e26U92OfjUlytgdcwhfKQt2MzWGsRKdjqe12l2Sn7y5UkhgurHY+3XvTuhm5ootZw3zB
         oyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730287870; x=1730892670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I2pAE1nQgw4jbrmDxYeWEQDTLjgIt/Rez86CyuKC0C0=;
        b=RA9jCwumfhzTdsCDYTZq/m0izJG2MynA7QEDTsQv+r1Byf593TYk7VTCjxVGt05tdR
         P8KnnRhU6X1GxuOW+A6dhnh0CnF6AFVHcPu+5VsYISn8vCOWqKFHB+whB1v16lwV/oAA
         FMbI6IBJFfkFYKwkwxi42eC2w4Vth39KR1WwhxNL9EN7Viw6Nerqo8+oOOaV5D8FvNs2
         jHNemUWLloaVJ4qxThaGEmlNOaEgmn4XhxokBn21rnR3GqxTOacJaKdOV7GB0QdwSb0B
         XPzLr84U8bRvJHmta2dwOW3tkkYe2Q4nhOhecA0Ona+AeKRlQpqndyda+mn/kg80Tew7
         dcVg==
X-Forwarded-Encrypted: i=1; AJvYcCVsVznEEq8zgWLuCfzDo6lkSI5jh1IadvIlBX1Xgpo0CUy7Ad1f4hJjYRxJku/L/1oIqrrAwCM71qbeC4Y=@vger.kernel.org, AJvYcCWvtdXBDM6ZADaTUAqbddOFQdxFACsDYJEUdGITj3l57UWy5G0pOmIgY7cCFJoRZ1+TEZnDiDrC@vger.kernel.org
X-Gm-Message-State: AOJu0YydBieOdBFV71Pd7DhTx1oCMkrC0glov3JodihrT/2efdY59HEh
	SW65hGGneqN3iLEZs/3GVKFC1RRTB6W++WXZcmE8bWYr+6hy32zu
X-Google-Smtp-Source: AGHT+IGpGVKCN90xhTpFCl08VSNFLJNn75cfSQEFN34QoTDwpHEjyS9RmsB2fFr3lggR73yEGDVL0Q==
X-Received: by 2002:a17:90a:ba8f:b0:2d8:a744:a820 with SMTP id 98e67ed59e1d1-2e8f11b96a2mr17442528a91.36.1730287870112;
        Wed, 30 Oct 2024 04:31:10 -0700 (PDT)
Received: from localhost.localdomain ([43.129.25.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e92fa63967sm1435129a91.32.2024.10.30.04.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 04:31:09 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: edumazet@google.com,
	lixiaoyan@google.com
Cc: dsahern@kernel.org,
	kuba@kernel.org,
	weiwan@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH RESEND net-next] net: tcp: replace the document for "lsndtime" in tcp_sock
Date: Wed, 30 Oct 2024 19:31:08 +0800
Message-Id: <20241030113108.2277758-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The document for "lsndtime" in struct tcp_sock is placed in the wrong
place, so let's replace it in the proper place.

Fixes: d5fed5addb2b ("tcp: reorganize tcp_sock fast path variables")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/tcp.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 6a5e08b937b3..f88daaa76d83 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -200,7 +200,6 @@ struct tcp_sock {
 
 	/* TX read-mostly hotpath cache lines */
 	__cacheline_group_begin(tcp_sock_read_tx);
-	/* timestamp of last sent data packet (for restart window) */
 	u32	max_window;	/* Maximal window ever seen from peer	*/
 	u32	rcv_ssthresh;	/* Current window clamp			*/
 	u32	reordering;	/* Packet reordering metric.		*/
@@ -263,7 +262,7 @@ struct tcp_sock {
 	u32	chrono_stat[3];	/* Time in jiffies for chrono_stat stats */
 	u32	write_seq;	/* Tail(+1) of data held in tcp send buffer */
 	u32	pushed_seq;	/* Last pushed seq, required to talk to windows */
-	u32	lsndtime;
+	u32	lsndtime;	/* timestamp of last sent data packet (for restart window) */
 	u32	mdev_us;	/* medium deviation			*/
 	u32	rtt_seq;	/* sequence number to update rttvar	*/
 	u64	tcp_wstamp_ns;	/* departure time for next sent data packet */
-- 
2.39.5


