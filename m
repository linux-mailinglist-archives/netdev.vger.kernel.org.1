Return-Path: <netdev+bounces-198573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB60CADCBAE
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 14:35:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D4813A554F
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 12:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397CE22FF2D;
	Tue, 17 Jun 2025 12:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xcf/IrDm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D82DE1F7;
	Tue, 17 Jun 2025 12:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750163749; cv=none; b=ZNQVVHtT0XM598FBiyscUMSbgHN9OqBWwcDclfrQGfa3oCiekZ8tfjupfR1JDf+wfagrmhhUiHOhEtRfa2IXwr8H9pRBFQjW95cZY6HnnMfEQ/a/ppqF8xngqvh7uyjETEn1bV/ozqyE7X2w0oFSn57W5zhLvZde8GZ8WWFvB2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750163749; c=relaxed/simple;
	bh=nWRYgfaKlsF505nHtld/MVEDNx9upmVyjOrnhDtYlE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXdTY3QsCPUaMVPetNbiddEsTyeodDbFsjTce2xux8NLDnz2H7qUpZfqlyMhGd9zIF8CYjtXP5OyHfqzBUD8D1DTirJW58E3m7MVZapOzvDDlOlIaJBhyjyJi+BiTAKWOcUhF+cTkxasBpI3g/RjA+qOm9VfdPi8iuxGmUZMB4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xcf/IrDm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-747c2cc3419so4362136b3a.2;
        Tue, 17 Jun 2025 05:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750163747; x=1750768547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rPdLItsX7RHmXg4yVyLzvYJu8Fzx16jAp/CJmZOuNrc=;
        b=Xcf/IrDm9RjCAtKsQG1mcWNuVK9HzNvqf83Ap1lNFdpoHQqw1GdT5RUIe0DXBpdYDG
         RIr6WmHfL6m4Ur10biYZIHJCKXYTj94BDCpbbOcFj0U4Y+Kni5Qokvnq+AN3Uj+9Xol5
         4ZhDFNcE+lhY8tXrVXs9whW+4vSjRfzutCXSFVhZ7qply7Io3XNkBW1zPGTf/eMISuBO
         L8VdxbntwmRB5QcVqyowQPVUGHbl1YxjdmtjSQa8OsEOassrdyJt69fbGFtP7MZbL6Ab
         YusTJ0zV+phi04NkJ5S5n/iyjfKVUFpVQtWdy1Gkkjh5I/1+FZtPUinWsqVKqPVHtsty
         /iXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750163747; x=1750768547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rPdLItsX7RHmXg4yVyLzvYJu8Fzx16jAp/CJmZOuNrc=;
        b=pRSfPBkku+x7Cz43Ee64Sff0jM4HjArDeuq+BA8W/yv2ANAquU3NdEMoiU2jzrPuZs
         XbYVHW6oysxShaLI1L7P3h0/R9QAYNsIfY2qF1R5BXXxVz+ml1yl+C5Vt0sRrsh1nhom
         EeKuZNaUGxkK/zDwRX2sFDh1FPWASJN98PWaWlE7Dt90T4FECQlYdiDO7jPFksLVJooU
         8LJZ3D8E/IsRj/qMepxwX4FT4oA1ZpzusiwiwH2RVSQeJm8HODt6nqLX+Tk6IO37LZCZ
         BNROIbU8VWFLo30vYOx4pAAg9Ekv75YOK2DwN7xEPF75og/y7LtLQQTtAoJD1LD5wOSb
         e+Tg==
X-Forwarded-Encrypted: i=1; AJvYcCUqyTvXdxSeHJ3j5WJyQaYPvRGIH2jjsiyRzwUvtv6fRLHEMyV4T7lQWjgAsoYnnL+JWeSxO1oA@vger.kernel.org, AJvYcCX13+IL84dZEee4Uplu2hifLQV20OOtPrrvsnvLBfU19DJ6jxWAFZrm1BM/DDsXkjMeWaO+Laww8POG3qo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXjjPxwHNztjRluRgvObPHqu8cg4yNu+0iTBcaRyM2WBdWQsz
	BSr1oP1+RprVCz30D05576aIKznN11h6RfyH7P7rRX9vQMu+t5j9PgJZ
X-Gm-Gg: ASbGncvU4RtcrNkhFqC9aulfCrReYncEnNYAoSq5ExYQ/5IsEA2OBXZYTG+Sdsw4VkJ
	fOYvW4/Gt4jxY8z3C1CjSfTFel8gAldeYg0aP1rH49cUPwUa4ZoM9wH9OvQj+LlLzcwPwyDEhJq
	s8hec1qJ36m30GcyLi5j0RcDeBMtl+inX8es30KI0Hvdy7tBX7R7xcsZE0HPxppWJezI9jhbRif
	uXrqgLsR5rWWb18hjVmkxd0UwhOzupJduJXn8Wp/+HZqdL14i48LfDEYcqkB5wgGu7dG8zWX7eu
	KoREoOIKBJPVcS/w9khwGGtYk3AvaaU26npmegIwpKq6THlogzYk0LBeaLt6sMhHE1gVcB34dWO
	wvdUSX/U=
X-Google-Smtp-Source: AGHT+IFYdZkwNqRYC3dNff02C5ous/zkB5D1vK+ftcPom4E7DbGsbzTemLZYAS6JOCz8DlVgk7S7fg==
X-Received: by 2002:a05:6a00:1994:b0:725:96f2:9e63 with SMTP id d2e1a72fcca58-7489d050f48mr20902995b3a.24.1750163746791;
        Tue, 17 Jun 2025 05:35:46 -0700 (PDT)
Received: from manjaro.domain.name ([2401:4900:1c68:884c:5800:7324:c411:408d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b2c1asm8944267b3a.143.2025.06.17.05.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 05:35:46 -0700 (PDT)
From: Pranav Tyagi <pranav.tyagi03@gmail.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	Pranav Tyagi <pranav.tyagi03@gmail.com>
Subject: [PATCH net-next] net/sched: replace strncpy with strscpy
Date: Tue, 17 Jun 2025 18:05:31 +0530
Message-ID: <20250617123531.23523-1-pranav.tyagi03@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated strncpy() with strscpy() as the destination
buffer should be NUL-terminated and does not require any trailing
NUL-padding. Also, since NUL-termination is guaranteed,
use sizeof(conf.algo) in place of sizeof(conf.algo) - 1
as the size parameter.

Signed-off-by: Pranav Tyagi <pranav.tyagi03@gmail.com>
---
 net/sched/em_text.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/em_text.c b/net/sched/em_text.c
index 420c66203b17..1d0debfd62e5 100644
--- a/net/sched/em_text.c
+++ b/net/sched/em_text.c
@@ -108,7 +108,7 @@ static int em_text_dump(struct sk_buff *skb, struct tcf_ematch *m)
 	struct text_match *tm = EM_TEXT_PRIV(m);
 	struct tcf_em_text conf;
 
-	strncpy(conf.algo, tm->config->ops->name, sizeof(conf.algo) - 1);
+	strscpy(conf.algo, tm->config->ops->name, sizeof(conf.algo));
 	conf.from_offset = tm->from_offset;
 	conf.to_offset = tm->to_offset;
 	conf.from_layer = tm->from_layer;
-- 
2.49.0


