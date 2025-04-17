Return-Path: <netdev+bounces-183860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED3EA923ED
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3908D3B785B
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9BF2561C5;
	Thu, 17 Apr 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cjdJ3BDc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F82F2561A0
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910735; cv=none; b=fTy3mwqPFK4P814Qk/R+v4WgDKZuYbYKUlDG6Q8np+fQPN/5dpAgVpFDTAiFcFs6MmGCncU4fpBZ/XffRIANUIZJKdn2li9BFY5bKbdYfKnSjq654cPftIx6Z0uz3xvY0BEQq7xwrh50ONEKj2ASVSe5s5DtDmk8fz2NkwzRpDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910735; c=relaxed/simple;
	bh=dJxRfYEp2QuH4TryMHj3DfMxIJ06gv4yfAAKnOyob3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PsWXpeU9KXOR3+0qIYCJl3RmW/eO+q/+v/9Xk3ZUWcM8OfC5A8o/HUN04F3FDZcwNtBsPcBoMC7FYO7NokNTyG3SGjpXCBSSpLdTtJSNnLbANVGECHHS0GLlKoZnyDROXZyYVmN/rpdPJrutkeP5xY3IZ/yah1vp8dU+ABcpApw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cjdJ3BDc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-73bf1cef6ceso1049587b3a.0
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744910733; x=1745515533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsBl+7evj4S3BwRvVEmsLlhXAkdHNshIeD4Nby9HkP0=;
        b=cjdJ3BDcX6Wg/4peYjhBsB9oVbYakZ7EosV5M77uwbNVnD6d0pbjx5FzBhk6lrG1eE
         b1X017Rer+1jp3b6+AEoYQQoK1bGzFDH4K3YdOooWwUjbnj5l0cBlYmLQKluefQKqK2L
         Wx7C8Cbw/9aCmNjY/H98/h6UW/Yfht8Bbph3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910733; x=1745515533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tsBl+7evj4S3BwRvVEmsLlhXAkdHNshIeD4Nby9HkP0=;
        b=ph6dadZQmE9xWHdSdxUmI0Bb+VFZeJLeZtfTJgKTZCf7S4WrJf/uHuOJUMT/8FoZ8O
         C0vdnYvWJTuJThHkjvVGRN8p5r4VOFroIsZxjP0t5VIezVOWAYBQaZO7USV0U2AGDMoc
         pETgfClEsiLB53ATKhOjxqZ0NtZEifMPuOPhQCqmu24PXJ9Qw8hGPNQNX01bPhoco2jO
         HWObmYqmTN4vxziTBQNNVYLWhnFwt0Zv5U2BaMUSFFiL5AaDnHW9cZNeluMN8i6RIOGJ
         8VdxorfrzVmNZxbpMQ+ReCZ784i3AmuBf6g/gosIRZMG4hUaJIO0dCYW7YeDC1rdkm4+
         eTGA==
X-Gm-Message-State: AOJu0YzWrSgY4mflIPt+gNAOKlUwVYwsImnHuM5L2Y+hN1yrlqyV0/Eo
	q/I0LbYfFXPNLVLACcyeGp6u3BB/FUYJbbAEwHXercz6yCtRuktw07zJwnhKBA==
X-Gm-Gg: ASbGncvnoWzzlGyutRLSjxweR05q6+MiI9/UCS/npeBbrZNnyyKQ1aVMenaj/XBuIu0
	3NP7s5ITCmelMnHmQu81jkQn82sXTaw7dGLFekMtfo1jlmd3AeJzNWaIbjhnBr5o7LNd82dQ448
	eNr7U8KMbusGz6GI/jxTn1Di94ZETwQrWf2FF7LQEmAbZimItrEDAEGLVP/ZqKDL4FL8oyvVdlL
	8wrCeEndbLRN4uwwmOhmFZjeThaBN3hymbPwgirN5gOjM6L9QvQCZtS1mkceM98lQeE8XlGFtEh
	nvu4A+PG+9UppFxAvM/b8bVfS/V6SrUTcqX2bh8u5z/Fk68hhVCxL8seQgsTqKd6olo0o0MPq/l
	2rCJPyt+p1I/WDL2J
X-Google-Smtp-Source: AGHT+IEQ2LUOidIoR0KfQGr2KXkDUFN1wC5LDgNuIt7vbrDjVHrSK79cTTPScWJHNU6Adn70J4jqHw==
X-Received: by 2002:a05:6a00:3001:b0:736:5753:12fd with SMTP id d2e1a72fcca58-73c266b5da4mr9123992b3a.4.1744910733231;
        Thu, 17 Apr 2025 10:25:33 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8ea9a4sm109879b3a.41.2025.04.17.10.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:25:32 -0700 (PDT)
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
Subject: [PATCH net-next v2 4/4] bnxt_en: Remove unused macros in bnxt_ulp.h
Date: Thu, 17 Apr 2025 10:24:48 -0700
Message-ID: <20250417172448.1206107-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250417172448.1206107-1-michael.chan@broadcom.com>
References: <20250417172448.1206107-1-michael.chan@broadcom.com>
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


