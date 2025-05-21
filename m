Return-Path: <netdev+bounces-192161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D92ABEB8A
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD91E3B671E
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 05:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5A222F770;
	Wed, 21 May 2025 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkktSvqc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4963C231C8D
	for <netdev@vger.kernel.org>; Wed, 21 May 2025 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747806870; cv=none; b=CcMHPpluS664aDTPSThxgJJ3JzOLm7mwdL7ef6OqM5toIwV4TG+nJJFm8v3gTNDuaoTnmykeQIQq65+mxSULL3XqnnDkb3T4D1GQupivmFrdZpEVH8qmvinfLyPD/p5SuDL52WBY+Aa2rpJHXwtWeiGJwH/DdV0V08JGqZ868KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747806870; c=relaxed/simple;
	bh=vcPq2MmXghJ4aAKiHFKJA9mCKv/Fq9noHFvdCb3yxLc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m/fdLbVekXhXNL8XQm3yj1VdtbaeI0j+3b18lWrlrWvncRi4+UMtXpthspqq7RkLCiDMj8AC/1c8Gg2EwjqH0uQnlN+zrxpsr6r8IGDOqSer3R/YR1B1ueCJcW28RMz9tVvDkmNY+w2OIEHdeWeZqU0JowpxNS9Or2610MfcVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkktSvqc; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23274dbcbc2so17512945ad.1
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 22:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747806868; x=1748411668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HaasjUIOiudZhpITTg/Ea1JpheK5Ok/woPqm3ve54VI=;
        b=kkktSvqcAwgoyGcXDjl8CfcSGsmb7lyfeTJ1vxOcP3yr55J+DHQ+8JopZ7qKC6OMNa
         SPuYYQthCl2xidNd5oqFXaZkEeuTubOfTlylxi8yh4rS7dVGf5tNsGOtUXq+P42pkhks
         rPdLz2k0J+Nom8nHhxWYXIcKBlkrHx6BI2kZ4b85NheVmeQ0yG405UYsgtTfLFCxE/KZ
         op0ARDk3l5ppBnd3Y1AHGDqLmVMj86rOhaN/zKFUP/0KXv7HAn9PGfmD3m5z2HNmpklv
         OxMz+UOxDy97zVh3o6dnFhy7NvwC08Kk8PV4ompfC8rlk4Zpk5jsZuRAMU666xZojlVA
         iA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747806868; x=1748411668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HaasjUIOiudZhpITTg/Ea1JpheK5Ok/woPqm3ve54VI=;
        b=lWsx85Ji83eChk//yI5yW2fXzOtVfSU2YMYHtFgEzz6JakCscXHM0Tyji9SqkFLHap
         hZpsNgg6tU6ulb6/OjixWgU4B57DLLiKWTlfh9ma6JfkPtHmOdyN0eP0bpGeMZmayJVp
         akR/EK6VTVldW1W0pX2b3w5yHcSyDIaeV4JU+jifdTuKDPkKYUstq2/bGmnE0lwxICio
         XCCByBAAvvOsQLGKE6Kra7NbRuJELyMmFnv5P92Ssj9ZIt9yT4u367TPgG7wuylr+8FF
         ygS+MFdMONxwkzYNqVTuMA2oob0YlERVML+TDizCr6UDIpFSzHw4U0zGeRjlQJTl0Ef7
         vhMA==
X-Gm-Message-State: AOJu0Yzjqp9f9JBhG47lmwv7D7j+ijKqlP0qjwR3di98tl5pCBy0I1Xw
	W7laupb4oRws+nkoHJQASJail6ViLLiT1U8FfJhXJ3mLuLx7CMN22sN0+Z61nW9u
X-Gm-Gg: ASbGncuVDnJOa6SLzgih8CaGj5gfycdsIelQz+/pj5zgy3+m2iwb3cHvxVVI5UQRpY2
	eklnLbb/2rVGoGNjPc86RGckkSRH8C+LXD1PJVZtLUPwIUjdIwPSdG1OiTeQ+PAmWTIYQd9uYJ3
	RaiqC5tzBBVv1nq5FyvxVzj9MqY3Fkzhc8aHtxffEpvqkO3Zv07RZnkQJvCs5/2x8aG7dQLBDNm
	gGO4skCzlngXpISDlBeDjW6qkcmtiZP3lnsTocWg4KSBfAIkDSS1R5PX7dEawV4OIdOtCvr2llo
	RGSYm+xrTef2zwjtEH5xsAeRhtRAPeNT4biKDDf6rAnz2YZtlo1oDbcv5OHfRin+4KQ=
X-Google-Smtp-Source: AGHT+IGyubQCq+X27QB+E75Qspepddqo0qxhh9yKufMqQJmiQsngpfI1yDKSl2Vuqp0udRGwq71L2A==
X-Received: by 2002:a17:903:26c7:b0:231:cb38:8d0b with SMTP id d9443c01a7336-231de35f319mr219058835ad.15.1747806868024;
        Tue, 20 May 2025 22:54:28 -0700 (PDT)
Received: from shankari-IdeaPad.. ([103.24.60.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4aca130sm85338145ad.18.2025.05.20.22.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 22:54:27 -0700 (PDT)
From: Shankari Anand <shankari.ak0208@gmail.com>
To: netdev@vger.kernel.org
Cc: allison.henderson@oracle.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Shankari02 <shankari.ak0208@gmail.com>
Subject: [PATCH v3] net: rds: Replace strncpy with strscpy in connection setup
Date: Wed, 21 May 2025 11:24:17 +0530
Message-Id: <20250521055417.3091176-1-shankari.ak0208@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250430181657.GW3339421@horms.kernel.org>
References: <20250430181657.GW3339421@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shankari02 <shankari.ak0208@gmail.com>

Replaces strncpy() with strscpy_pad() for copying the transport field.
Unlike strscpy(), strscpy_pad() ensures the destination buffer is fully padded with null bytes, avoiding garbage data.
This is safer for struct copies and comparisons. As strncpy() is deprecated (see: kernel.org/doc/html/latest/process/deprecated.html#strcpy),
this change improves correctness and adheres to kernel guidelines for safe, bounded string handling.

Signed-off-by: Shankari Anand <shankari.ak0208@gmail.com>
---
 net/rds/connection.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index c749c5525b40..fb2f14a1279a 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -749,7 +749,7 @@ static int rds_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo->laddr = conn->c_laddr.s6_addr32[3];
 	cinfo->faddr = conn->c_faddr.s6_addr32[3];
 	cinfo->tos = conn->c_tos;
-	strncpy(cinfo->transport, conn->c_trans->t_name,
+	strscpy_pad(cinfo->transport, conn->c_trans->t_name,
 		sizeof(cinfo->transport));
 	cinfo->flags = 0;
 
@@ -775,7 +775,7 @@ static int rds6_conn_info_visitor(struct rds_conn_path *cp, void *buffer)
 	cinfo6->next_rx_seq = cp->cp_next_rx_seq;
 	cinfo6->laddr = conn->c_laddr;
 	cinfo6->faddr = conn->c_faddr;
-	strncpy(cinfo6->transport, conn->c_trans->t_name,
+	strscpy_pad(cinfo6->transport, conn->c_trans->t_name,
 		sizeof(cinfo6->transport));
 	cinfo6->flags = 0;
 
-- 
2.34.1


