Return-Path: <netdev+bounces-65975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B8A83CC0C
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 20:19:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F38B8B21314
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FFDA1350CE;
	Thu, 25 Jan 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xkGoTpsB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A589E111AA
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210336; cv=none; b=XvMlWroGhlJ5LPmXM2/jrtcwQ5X8QiwdHD0aSEVbwxh474dYFiA6JQdgisx58Sn4qV8+cLU0ayMTXu4Cgxrp4x8a4kx4uj/nVI4V7sgRA/zlxGkF10JDMTdr2234BKsEWibXv3uMOwBoaXL1HDgPj/d6Htf7bZlXAD3pEEjMrT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210336; c=relaxed/simple;
	bh=lab1cc/BnvmVMoI/6a4oqJtvBk6zbJgk82AeHiJrUN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NCHgw4yPWCsGVi69up/sXV+ypqzDZ8MIObykgdKZdM/DbwlNlo8YiMaBj1yF3TRMepvlbgf+jnHScoK21dMsjeYqNPaIk6KUlYjVEVlRX3Ky3dLdaydNwoTnVyOzsDQFFGFDb2bmb6pAjTSuXqag3URiXk4zytyoCA7a/df0iSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xkGoTpsB; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d71b62fa87so6949085ad.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 11:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1706210334; x=1706815134; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgDFOq40XBBKNZXci2Ggytp+MQppzv/horYrfyyqlNM=;
        b=xkGoTpsBKSeyMiBumtKh4wbRn2VTmJ1RYiyrJLR7wPRmja9/pDT16gqTYuRPzZqLJJ
         1AocFj8myQJxoMvETzs9Wuumq+GTjvmmeUyMwcpZ6rdds9WTH+GOAL4vdXZFdjmk2dIx
         kWYpwuQpBl8ZAs5S+MWDc9TVTVaB1WQQvHhnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706210334; x=1706815134;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgDFOq40XBBKNZXci2Ggytp+MQppzv/horYrfyyqlNM=;
        b=mwtmvB4+Ald67fwOyud22/45VvTg6rJZ3rwCYJFmBzSTG6mla1dyB8VmYl5c/xrU+5
         gQHMFfgHEtnEWk6eH7NRE95173weeCSqhQY8KQ3swW1TAJVFDjBr8nqrA3heHjCrA4H5
         bd1urH2CwiJVmF+fWpCjtxv/rb9X6R1nWG1qjdZBHrvd/r0glUJ0qcnEHkvP/HdmeuVj
         hpar50QKbz7tpx1lkkB1ZXIw7HBIc7x3f5HJpbc8v+mTE7Wmz6A0D6bhLKWCVsMQbZmY
         JsF6CPsl77Bx3Bv4yPShiqGh9RzumSBQqLJfUsV/oW2tzjv0arutJFU2si4HKtpAzhdg
         UMdQ==
X-Gm-Message-State: AOJu0YxljtHxI6y0VChtJe2KAVWIoOW9pyMEtMWfYnKIugp/UrVn0fhn
	U6h4uyVd5tAmSCae8Plu4R+qdiTdHtrU5GAPUcQqdkZydvH51QBhxmksqp6rnP4=
X-Google-Smtp-Source: AGHT+IHdKHB94OhPgZOVY77ABy+eW7S+fOS7rs6rmsVrvHAqW+Nt5DJrWXeJyflcQ9xYvVmNTGX+MA==
X-Received: by 2002:a17:902:ced0:b0:1d4:bd1f:e4b7 with SMTP id d16-20020a170902ced000b001d4bd1fe4b7mr29761plg.24.1706210334003;
        Thu, 25 Jan 2024 11:18:54 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c018:0:ea8:be91:8d1:f59b])
        by smtp.gmail.com with ESMTPSA id n9-20020a170902d0c900b001d706c17af2sm12215017pln.268.2024.01.25.11.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 11:18:53 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	alexander@mihalicyn.com,
	leitao@debian.org,
	wuyun.abel@bytedance.com,
	kuniyu@amazon.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	edumazet@google.com,
	davem@davemloft.net,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next] net: print error if SO_BUSY_POLL_BUDGET is large
Date: Thu, 25 Jan 2024 19:18:40 +0000
Message-Id: <20240125191840.6740-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
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


