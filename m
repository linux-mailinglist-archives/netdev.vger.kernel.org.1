Return-Path: <netdev+bounces-145009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9249C918C
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 19:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0FF7B27B9A
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AD718C90E;
	Thu, 14 Nov 2024 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Uxe3sKLu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAA3188708
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731606969; cv=none; b=uwE6+UGDbKbarCCL7dExnI9EIJsqjTpy/c1nPGaLXiuaq8OBd6Q5nEo1F/5VFqUZo0r7hZqAxU7m5+pTMEg5GmpPNTGPOuB8zzIH3wBWL0QCh/a37Vnd6N/0JJaLVXEXKcC3+QQUiAsYI1V4kbz/pD27SBJHOEhRR+W9H/WU8A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731606969; c=relaxed/simple;
	bh=a18bloeDgmbabrEfyemWCGBcVgDCL6htsjoCG3FBQgI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YY00d3OFmPFHkO2/zHm7atMqzo+E7WjOjg0W+BuPz+mKPwKl6+2S2gcjd/W3QwRaOyrT6D+F2kMRySD62myqLox3ijZCLCe1205YP+g3MnHAcZtyelkD6GRNhQHPCZXzoUhvBLqxsF/zsr86o6z1ynRdDYfOlrv2Q3XAyLsDWFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Uxe3sKLu; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e467c3996so743423b3a.2
        for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 09:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1731606967; x=1732211767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0rFRWVx3LslY9qSH/fAEwnbhBEiZK8M467+4/DvUO8=;
        b=Uxe3sKLuCBNrvMr7J0+Qkg/5rM1D0vNUG+PdRlOuZ0OV/Zc6iOUhpbU5uk7/LAUVlc
         wSQPas1OnDfbksn3yHJ4RUN+N00NY4+ztgOzMEbcRoTk2EdRMJxGVIAvG8MR8aNu/22q
         W9f27C6y2kezV/ftfqSk9f5gCYVLBwS91qoHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731606967; x=1732211767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0rFRWVx3LslY9qSH/fAEwnbhBEiZK8M467+4/DvUO8=;
        b=M9qURNzPoAK2cncaR1VI0EHkNUjdpiZb3FqRKmPOR7SNxm8v+aiYD3sYzSuBEKg2Rv
         81lD3QHgMQdZEyAK0ht4whg5q3H3yPuQsnYNWaCrsGf0tbJDxdMSxoiHtA6ytNwvTkdq
         QmgLjopSepJ4SGYJSOVTx3H4df8TgsmAJv4nUEUgV6X6Qvv6ARbZbPDcbxHFSPU24gYL
         0J2e2/403jd/5j3gnlAk8DvJ6+DL/2rdrsmY7KApF4MzDMlgatqgfwB/0mmxNC9xuZBB
         55wnHTSecev0Y/k6qeZZGX05XTkYObgRkX51rrzqk6iJiBijNjApmuiBiGo6AONAn69h
         K8CA==
X-Gm-Message-State: AOJu0YyQHMp4g9cnvJY8QZaUSWqFhO7+CXLjSWd455WzmD789aGvtcH8
	Ph/7D/wTBdxVzFZH4MET74ZbcaL0jTZJkZeNIrThNLT+BfTTUhjEnwkVRxdz6lLLkKMzsqM3P8K
	NVJWDbe+wlTJ/PNE/eODIPSY+J/WjVjbdDA05BYZ5wuXyFZAtzHlLU2OAD4HJThEfO3iuxZL7ed
	XWjqJe5La1BdOqrUgq0SUoD7IW1gEivZK7wfw=
X-Google-Smtp-Source: AGHT+IFYY+VrNTPuPdK4I8AHu60ZhAPAfkbxD/OtbItH8rmF2X8DhCf+Nm8/W41TAqFO9s46Y9mkIg==
X-Received: by 2002:a05:6a00:803:b0:717:9154:b5d6 with SMTP id d2e1a72fcca58-7241338b585mr33554020b3a.22.1731606966501;
        Thu, 14 Nov 2024 09:56:06 -0800 (PST)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9d3813sm1569336b3a.184.2024.11.14.09.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 09:56:06 -0800 (PST)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: pabeni@redhat.com,
	edumazet@google.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	kuba@kernel.org,
	mkarsten@uwaterloo.ca,
	Joe Damato <jdamato@fastly.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v3] netdev-genl: Hold rcu_read_lock in napi_set
Date: Thu, 14 Nov 2024 17:55:59 +0000
Message-Id: <20241114175600.18882-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hold rcu_read_lock during netdev_nl_napi_set_doit, which calls
napi_by_id and requires rcu_read_lock to be held.

Closes: https://lore.kernel.org/netdev/719083c2-e277-447b-b6ea-ca3acb293a03@redhat.com/
Fixes: 1287c1ae0fc2 ("netdev-genl: Support setting per-NAPI config values")
Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 v3:
   - Separate the patches that were a series in v2 (and earlier) as
     they target different trees.
 v2:
   - Simplified by adding rcu_read_lock/unlock instead of using the
     helper proposed in the RFC.
 net/core/netdev-genl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 765ce7c9d73b..fa119ff68698 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -346,6 +346,7 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_ID]);
 
 	rtnl_lock();
+	rcu_read_lock();
 
 	napi = napi_by_id(napi_id);
 	if (napi) {
@@ -355,6 +356,7 @@ int netdev_nl_napi_set_doit(struct sk_buff *skb, struct genl_info *info)
 		err = -ENOENT;
 	}
 
+	rcu_read_unlock();
 	rtnl_unlock();
 
 	return err;

base-commit: 3d12862b216d39670500f6bd44b8be312b2ee4fb
-- 
2.25.1


