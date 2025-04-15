Return-Path: <netdev+bounces-182937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D83A8A604
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38E0016C8EA
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 17:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE4E4221F24;
	Tue, 15 Apr 2025 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dAfn01Uk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23899222578
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 17:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744739344; cv=none; b=HqoE5MOAf4N9ruC7ldoSMv4J5yGR+KJ0o+4B/Y7TQSZr5Z3BPqXQRKp2Gh0NhoTHXEse6KrhpNnqrriLd8wko7/cHAXusaySkAXVyOfIHPsuZSCJXSaGfx+RYy904dqpUPXZnh2KN6pRv8c+gv4vT3Z8MaTYMwA9942GN9qAFNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744739344; c=relaxed/simple;
	bh=dJxRfYEp2QuH4TryMHj3DfMxIJ06gv4yfAAKnOyob3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HWtUkBaTS1GtSWT0g4MfSRhzRBLIF/r2gdbBFmsvl/iZTii3zO7aaxiW84XoSwdqSc7sqImMfQv4Z5MtnKSPR4Q8llvuxroH6tt+tAZ6Ka7i9lzf+bFJKjhs6d03lZdDPOrsMSGHMT8985YtlHKnZNLQM6bD4oM8tWwvSgU78O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dAfn01Uk; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-60245c7309bso1428614eaf.3
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 10:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744739342; x=1745344142; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsBl+7evj4S3BwRvVEmsLlhXAkdHNshIeD4Nby9HkP0=;
        b=dAfn01UknO9PSfzRxjBEbPDdBr5QtdaWlBqwtQ7ObV8iy7tEX7AIqJDkwdCXKfJvgD
         I/k7zXRQ/qz3gYuHEaOIKXZGvlDFmu6ovx51q6Ur3VjRNbR8pY4IkvV8OVgFOVSy8eXG
         xT9A+Ls5/rt84f7yFpilGXgttknZvdd+juPig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744739342; x=1745344142;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsBl+7evj4S3BwRvVEmsLlhXAkdHNshIeD4Nby9HkP0=;
        b=HerYVxCYEYPdyQDW4SRl8mTLgvqdajPgBqlxrHKubX1s958N8h2L7HM5A+hZw3L5kU
         4J7blwlSozhbFc8L8AJArWqf/SZg31TUhO3w1VXjk8LCLsVS+G9Wqu5mBfHUE7k8/Rx2
         eGLPfWnA0EfJ5Mi98I0qyzsSsvwGt6dZi043GGSJfy1U90/1C6Q09s/la8tvN7HPnK7B
         aef34TfRfwGeTTJUiUc4E3Fkxt7KWX5F8vNaI1S7D/VPJ1SCNZCqGnkBmOFh3SI0WXal
         4D//vUE41bLdbB1MerkcPJ4EX1LLnFU5I9MmixmsDlMNT2zX9XGDl3cRt6YeAABvQuVe
         K3hQ==
X-Gm-Message-State: AOJu0Ywkap26PwqUCgRYnt4TKjod6ULPiIezsnyE4xahgG9PF6vlv9WI
	FNJleHdgba7NsyVaDMqMYwV3+ZO9pvL3+5bA+INxUhEJ5ANP5B61o+lCmK6pdA==
X-Gm-Gg: ASbGncvKlZxBltuT3GBRFjWyidvpiJ3MYQsVQeb6FSJl2VbB8UV5HUm6Ym7Hdwd5Yr5
	jm5ok/PTY9cNtxyx9TlEO36wthj0/uctUmpwyD3ynH5Gfqjc1dSYKrv84PpdK4TuDPliiipwKel
	NSFmvHQRfyuFUSsylCsrbsfJVhh4GGpb2G2nXT2+bFhiH/BzjoGj5O37SseLjVI52a4oKwFBho/
	6ZLNqv7+2SyHLhJPMq9hj0PhMdXsGBuXnulDpRDmFl+QezUQjvgDpdNIdVXXa6WkCfwnDlWG940
	RXIe0JQB1oCAQBQkDNwVWWJaku4djrbz2op6PaagGR/1d+rwDSuglzP3XuH42+8rpdic4UIR7uv
	saF1TX5xCcb85KQ4A
X-Google-Smtp-Source: AGHT+IFNcmbW7ktns5Jay6yqphO94w+ZT0e7wMbDZwii9eRNe04vOhW8Xmr7gJF/ZPy4r7tGmbpQLg==
X-Received: by 2002:a05:6820:1c8c:b0:603:f1b5:ca0e with SMTP id 006d021491bc7-6046f584d84mr8659999eaf.3.1744739342175;
        Tue, 15 Apr 2025 10:49:02 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6045f50ee87sm2457073eaf.7.2025.04.15.10.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 10:49:00 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Shruti Parab <shruti.parab@broadcom.com>
Subject: [PATCH net-next 4/4] bnxt_en: Remove unused macros in bnxt_ulp.h
Date: Tue, 15 Apr 2025 10:48:18 -0700
Message-ID: <20250415174818.1088646-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250415174818.1088646-1-michael.chan@broadcom.com>
References: <20250415174818.1088646-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

BNXT_ROCE_ULP and BNXT_MAX_ULP are no longer used.  Remove them to
clean up the code.

Reviewed-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
index f6b5efb5e775..7b9dd8ebe4bc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h
@@ -10,9 +10,6 @@
 #ifndef BNXT_ULP_H
 #define BNXT_ULP_H
 
-#define BNXT_ROCE_ULP	0
-#define BNXT_MAX_ULP	1
-
 #define BNXT_MIN_ROCE_CP_RINGS	2
 #define BNXT_MIN_ROCE_STAT_CTXS	1
 
-- 
2.30.1


