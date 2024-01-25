Return-Path: <netdev+bounces-65696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE183B616
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 01:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E291C22169
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 00:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53977848D;
	Thu, 25 Jan 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="wdCQHqEF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0AA6FB6
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706142629; cv=none; b=p8WXOIj/JuXJnojXgyZvc2DeSzsp/E1MMzpbZhvbeXcOq+Ikn2Phb0ren61anfdUniSwLZWFT6uDlOiD22/CS4+yXoByLCj1PRmFKrhUeR2GURDr8tu4JLc2ez1AwiNjNete5suoahrvkqK8AAHW5WJibgi23RM2sBqDHrDcQbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706142629; c=relaxed/simple;
	bh=lab1cc/BnvmVMoI/6a4oqJtvBk6zbJgk82AeHiJrUN8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XD4vxJ/yX1Lf2E1jrjjpN7HG6+4H2Lbb1CvaJ5Wmv7UESWKNDHiEezsuRUF2d7QgpiAyzD6fadOGTt6kFK1TVn0nmb5hDUj47ifds7nuXNqXb3pJs9FkjWYfk9w9z7ZYFJE8TGpZtxZu7dOwggnK8m0TsSE7RRF5NScxVdEegvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=wdCQHqEF; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3627e9f1b80so12200885ab.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 16:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706142626; x=1706747426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vgDFOq40XBBKNZXci2Ggytp+MQppzv/horYrfyyqlNM=;
        b=wdCQHqEFj1fELd8jMSd1CTQLr6eZnzKB40m2nzPPjLQCZtci8aSyRLSuQjKZy9gT21
         4DvQ9s+Ijra/BYPrcmyDDIzAN3lmuPPAbQTZTJsbE4567XCk3CZX8PoFmOxt6b/o1zBb
         Mbp7YovlQ8q5/7ZE0oQy7vnrHLAiWXyW482mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706142626; x=1706747426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vgDFOq40XBBKNZXci2Ggytp+MQppzv/horYrfyyqlNM=;
        b=jENnDc6MJxEeWS5QeCssYAHoyEBXluABp2pbT5OPvYg49sVUjmIjwUNuNZTs9SIajp
         3j7JbwHImMDQIiC+nAxzhtA71h92vhpHDIjNekcyZ8qpJKYPFjAYpGfetGDPKI0YeIrO
         6Gp7al6fokIfK9IgZ7Z2OPokyW9X5Jj/U9bpuvhNL+akEbgElNSmP5XadZs+NgfQ6Jm+
         CuDx8dYvD7I2cmoq/0OVlPnU5iAIdVgt79ujQTuXVrvctAjUhw5BnsJQu4n0y4P1xlhO
         GweT5LU0yBbqs9ImcXJCB/tfVHlT6UYBl01tZqt2BJN3jbE44CStCJrzRdVShpsRYeZ9
         ofsw==
X-Gm-Message-State: AOJu0YwMt7v73CDYEEC+zy2Bln4WmfLoRwV8ek9WAPTfLCtmztafwsZb
	DLOLoMSk4XIuAdNVLgtm4+G2eGiwSwxw0u1DGGXQDwN6Ws4cdIkddezjQEHnZnj3BCj8Yznw+5c
	ylCobGmC1RcX171VO32v8/W1onEmn56ckCocQRhm7UPbMsw6xdxvD4z6C4FcNAdTA/1rr1s6zm2
	e9UyJX6RNKURV4fGfMLSFHmzcNtYEvFdIrwzQ=
X-Google-Smtp-Source: AGHT+IE9OMBwdVUF2LOwcQ/6fsfVNS4gRrjXRfy15GDSSC7Tq5Amb3vaXx8NekmcMrDZP656URMpnw==
X-Received: by 2002:a92:b751:0:b0:361:abba:a7a4 with SMTP id c17-20020a92b751000000b00361abbaa7a4mr270859ilm.14.1706142626425;
        Wed, 24 Jan 2024 16:30:26 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id w10-20020a63d74a000000b005cd945c0399sm12550486pgi.80.2024.01.24.16.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 16:30:26 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: chuck.lever@oracle.com,
	jlayton@kernel.org,
	linux-api@vger.kernel.org,
	brauner@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	alexander.duyck@gmail.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	weiwan@google.com,
	Joe Damato <jdamato@fastly.com>
Subject: [net-next v2 4/4] net: print error if SO_BUSY_POLL_BUDGET is large
Date: Thu, 25 Jan 2024 00:30:14 +0000
Message-Id: <20240125003014.43103-5-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125003014.43103-1-jdamato@fastly.com>
References: <20240125003014.43103-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When drivers call netif_napi_add_weight with a weight that is larger
than NAPI_POLL_WEIGHT, the networking code allows the larger weight, but
prints an error.

Replicate this check for SO_BUSY_POLL_BUDGET; check if the user
specified amount exceeds NAPI_POLL_WEIGHT, allow it anyway, but print an
error.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 net/core/sock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 158dbdebce6a..ed243bd0dd77 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1153,6 +1153,9 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 			return -EPERM;
 		if (val < 0 || val > U16_MAX)
 			return -EINVAL;
+		if (val > NAPI_POLL_WEIGHT)
+			pr_err("SO_BUSY_POLL_BUDGET %u exceeds suggested maximum %u\n", val,
+			       NAPI_POLL_WEIGHT);
 		WRITE_ONCE(sk->sk_busy_poll_budget, val);
 		return 0;
 #endif
-- 
2.25.1


