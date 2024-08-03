Return-Path: <netdev+bounces-115499-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AFA946AD3
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 20:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A9901F215BB
	for <lists+netdev@lfdr.de>; Sat,  3 Aug 2024 18:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47FE1BDDC;
	Sat,  3 Aug 2024 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y6isJzkM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE0134AB
	for <netdev@vger.kernel.org>; Sat,  3 Aug 2024 18:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722709555; cv=none; b=d5StinqT1/oDK91vr0cbDkqr0FQu3D8UaMmyi1k5Pd/bFgJRXvmshh17QEzIYhZb2Sg3V7KDJRny+maw2/Xdjp2jIyMteO67eJKzpuQXQnsUxPZsv3BNmZMjzgqqT3KEsIoNsOJmRuo8AnfW7Yds3TXy38Paasfdf9lFHm8S6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722709555; c=relaxed/simple;
	bh=CYEMquPpM5HiwNnRriYC2jCjJ4nXI+Mmr0Mm8HHv+Rc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Ho4cxcrrE2xbkfR0wE055jKze7Og+Hu8Rxj9l/jftQuJ60Y1MgUpKHvsjWargdc8Am0uljHSgxzw9F6KliuXTa5d6N+gd95fADgGq1gIG/cGQerI2m0GvexswRzOU+VDE91RPj9Kq3SNadGVuLAh44yGAQD1gg581BakqdBPxr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y6isJzkM; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--manojvishy.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5e4df21f22dso4183085a12.0
        for <netdev@vger.kernel.org>; Sat, 03 Aug 2024 11:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722709553; x=1723314353; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BH7TThbnnegkjaOojrrx2d8L5L525Fkrr+r8KP5JObU=;
        b=Y6isJzkMnlsPwlrbvRqJqGSgXeE/ZvICp7Cgt1uw+k3sFbpSgZKWFgHUYoj/6atukK
         pnFoVk4MGcMRmNMf7Es3LrRm3bmwX5PRkk8ulWke9lGI0gM6HuhLwEPMVcFwUjZqFCDR
         h56hyKDc9cP4GPa84tRTg3Xn25J2s21syK91ACs5llksL7I99KE0UvGJ1MwxCPy5Ka7y
         XOIeg/xlAOZmVdFyRrbWIrnAM4KaNOPCkm735Eb1/nke5XBAa4KTqotu3rs02UJeVxd4
         JbJVFCwZWvu3XLp0wKHjxBscj8xUb9at6Dzg2AIAdCCVmFJO1yI4vb0I6JX30yFNpBFd
         UWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722709553; x=1723314353;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BH7TThbnnegkjaOojrrx2d8L5L525Fkrr+r8KP5JObU=;
        b=v+ZyxqwXeXUnRULohIjS8r2QjfK6y0jJzBT9LCz/ny4lTQZEfpgQvfnw8QqSOubE14
         0cgLsvi13SQtjY7jrCECS0fuyUBlTUy25m3ziDaUkIPSy3RbJ9fjCWco/X7wYqkINyd2
         57DdfL3AApIOLABVclznAhjsXXa0Z4zKd3YQYtPX0hApuCQqB6b/UKjncoXGezpCWXE1
         ExXSc1yLTsfFmMDqfdgnU8N43KkfdJaLvcPv0ZYiwQUFZARIVbnqzNzmavpqifFNX74K
         G127mwmk3CITM2fI/4iiXscIcaXRI2v8m77uryPMoGQTl8lkRlXbKMUWj+QR/sw6FSjW
         crDw==
X-Gm-Message-State: AOJu0YwsI7+cZpJzK8NuF2VAywGrG5hMf8caxz59V5qvWw+l5if78XM+
	f8brqkuRZzOdfq292ChaVUavUY3mGR/ReyY48V5+oKncdGNn0Gm+BvUbcuT9WAGudbyu8zTD8tm
	3boq90XwJ7G8JY3ED/Q==
X-Google-Smtp-Source: AGHT+IHSIDEbxPmrzSc/pjlYK4UMHUzINsnlYy7PNW5MWeJ9ziiR25nb3zUlEws/rVyc2hSZI00CJMWWoyO5wg4u
X-Received: from manojvishy.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:413f])
 (user=manojvishy job=sendgmr) by 2002:a63:25c7:0:b0:7a0:b292:47cb with SMTP
 id 41be03b00d2f7-7b6bb6842ffmr19853a12.0.1722709552310; Sat, 03 Aug 2024
 11:25:52 -0700 (PDT)
Date: Sat,  3 Aug 2024 18:25:48 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.rc2.264.g509ed76dc8-goog
Message-ID: <20240803182548.2932270-1-manojvishy@google.com>
Subject: [PATCH] idpf: Acquire the lock before accessing the xn->salt
From: Manoj Vishwanathan <manojvishy@google.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	David Decotigny <decot@google.com>, Manoj Vishwanathan <manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"

The transaction salt was being accessed
before acquiring the idpf_vc_xn_lock when idpf has to forward the
virtchnl reply

Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 70986e12da28..30eec674d594 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -612,14 +612,15 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 		return -EINVAL;
 	}
 	xn = &adapter->vcxn_mngr->ring[xn_idx];
+	idpf_vc_xn_lock(xn);
 	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt != salt) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
 				    xn->salt, salt);
+		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
 
-	idpf_vc_xn_lock(xn);
 	switch (xn->state) {
 	case IDPF_VC_XN_WAITING:
 		/* success */
-- 
2.46.0.rc2.264.g509ed76dc8-goog


