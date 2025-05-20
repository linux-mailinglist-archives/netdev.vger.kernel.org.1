Return-Path: <netdev+bounces-191764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 896DAABD202
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 10:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061CB4A3F75
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 08:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 804D0264A97;
	Tue, 20 May 2025 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="BXbqYbpD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8944825EF82
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729933; cv=none; b=f7DguhAJZlH0dghuvdbheY3k8tpwhZHRaygD7xYin0gaDSttWbVf6KJWpTgCFe5t0e9wKed07+b27IYLinbDVsECEn/F4s8TcYv02k2vBU/S8fxmRpTnhvj2tr7nlPJR1lHa2jpOTZNkYNI5VKM1AL2bnWdEut/YnikMjy6nJAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729933; c=relaxed/simple;
	bh=R0uyCfD9ee19hLdRbZIdNyn4JsBEXrni9lYZUNEAJBo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J78KtgW62HYh4Ey9FJ2xcFTSV7n7llBFsB2XGgAIH/T3SdPU7PK8GEm4M6t20iCC8RuhJAhmAJv0WfIqL71abnmHI5Ho5WM1EjJm2Y5D1ZVkV5jyJp7sYiw5pHvNdrLgccl7j2Cga8Ojm7Jwmu/M5MPP4PwhrXmXcsaVJYcERpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=BXbqYbpD; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DDEF040671
	for <netdev@vger.kernel.org>; Tue, 20 May 2025 08:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747729919;
	bh=UG+Gfq4wk+7rHPVUcE6WcDOxOs2F6wOE7UjEgZb39xo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=BXbqYbpDyKeyU5nQjC2HtLpXnLTGxYHL6PBNLp+PDDpBGVSjNRQSflqI9rWCeIGbR
	 OJuwYvtaqsHAm0Ev00haJi5wOv+SMcCJi18zsywUynQ7cmmFYXHLE1QW4tI8phsCSX
	 NL4GNT//43pX4CjdGj7+6VFsO636dMAOiJEYErSINg5E2CcDnt4hLHOwDuuONMssDC
	 XXuRS9SDIkuNgwQGXJHa2MpKjkG7VAadXyx1V/wgMvloHW7GdfMp9QT+xCahUM0yo6
	 vWwasekejj2o8kg79ULmvk1IIT/SbHxTI4T08mpotRPbJhECzU488tmCh2ADUldAho
	 B45EiUjbm2Ggw==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-601f1e8acc5so1596369a12.0
        for <netdev@vger.kernel.org>; Tue, 20 May 2025 01:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747729916; x=1748334716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UG+Gfq4wk+7rHPVUcE6WcDOxOs2F6wOE7UjEgZb39xo=;
        b=CVnge1G/yn6Q3w7i9lqq4D4UoHHW7wig+NvrFluxtfjFIT0t07cJu6z6dJnrvANzZJ
         +goDvUL1BSZ2TZBgCBbTFQ6NecdAmWA+VorNV5gzfd738alWbL0gBCVC0A69lNMK3YNA
         cD6ZZXENh/3FOkOdZJfC2bSp+eEcRSJYFW/NYF0ln01fv3jFft5yE0vIJ8yVFyjb0KOb
         nZa5QTF/d4nsstc8+YQIYtlqXGvosuHqkp6uDfb0/FkOfFsCcvD6B0p0QN2Ue79lQ3HO
         jUG0NWVwZNLx4SYZkJnI78JBx4cjb2qWtc6682RYQPGoQ5IDhYzvCbTXLKF8v7A60CjR
         ApWQ==
X-Gm-Message-State: AOJu0YzfcBGqw7NzIvtd21Iv4mmLKBjfwgdqL7gJdHLp1OV/whVY1uFG
	7Ft1+eFbgXW236eWqW44nh3pNM+1T9hAAcrO3oFKZkiQmxz+giKi4bleZoc2hadj/Tu1zmIi2u+
	OSsiz/lT+QH86flPm7tUfOSTY+csrNQ2URNWfyAnnOxA1DVnh3L1eiFtqIS28ijGWlVaVR83gLr
	KF+XCK+e1o
X-Gm-Gg: ASbGncvKE2TtHFNdpG/em8LoZxbM5tTi/SvbYaOgeVLI8s1f+mIgWE3JO2JwolAEOC8
	EB5/kDNU7A1YVLJTJU5uyx4gyBG8ikq0przkkmzRxOQXMYPwGoxTD+FwqmYJHHlqBdjoioEXygP
	geqD3mT9+Stb67fzfQkadJZAj5zO+wASeJcefmo7SZPen89r4LQOMjnH+5ojzi9ePFUqsqZVp4O
	Xb7025GG9gdv4JO0BuCmc3rr5eaLhnRUA55ioD/HK3iVszUHzhm0DtqnmF7gRDAVMEZORKH698N
	UkK7Z60ZJf4=
X-Received: by 2002:a05:6402:51c9:b0:600:1167:7333 with SMTP id 4fb4d7f45d1cf-60114099a62mr12345456a12.10.1747729915812;
        Tue, 20 May 2025 01:31:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIYx5ZBbx8i29wv+6hI1lmWOArIYxJak/BwCscuYI0qUpO6y+AnyWWSy7UutMwfLndkUZcQg==
X-Received: by 2002:a05:6402:51c9:b0:600:1167:7333 with SMTP id 4fb4d7f45d1cf-60114099a62mr12345438a12.10.1747729915371;
        Tue, 20 May 2025 01:31:55 -0700 (PDT)
Received: from rmalz.. ([89.64.24.203])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6005ae3b824sm6857875a12.79.2025.05.20.01.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 01:31:54 -0700 (PDT)
From: Robert Malz <robert.malz@canonical.com>
To: netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sylwesterx.dziedziuch@intel.com,
	mateusz.palczewski@intel.com,
	jacob.e.keller@intel.com
Subject: [PATCH v3 1/2] i40e: return false from i40e_reset_vf if reset is in progress
Date: Tue, 20 May 2025 10:31:51 +0200
Message-Id: <20250520083152.278979-2-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250520083152.278979-1-robert.malz@canonical.com>
References: <20250520083152.278979-1-robert.malz@canonical.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function i40e_vc_reset_vf attempts, up to 20 times, to handle a
VF reset request, using the return value of i40e_reset_vf as an indicator
of whether the reset was successfully triggered. Currently, i40e_reset_vf
always returns true, which causes new reset requests to be ignored if a
different VF reset is already in progress.

This patch updates the return value of i40e_reset_vf to reflect when
another VF reset is in progress, allowing the caller to properly use
the retry mechanism.

Fixes: 52424f974bc5 ("i40e: Fix VF hang when reset is triggered on another VF")
Signed-off-by: Robert Malz <robert.malz@canonical.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 1120f8e4bb67..22d5b1ec2289 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1546,8 +1546,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
  * @vf: pointer to the VF structure
  * @flr: VFLR was issued or not
  *
- * Returns true if the VF is in reset, resets successfully, or resets
- * are disabled and false otherwise.
+ * Return: True if reset was performed successfully or if resets are disabled.
+ * False if reset is already in progress.
  **/
 bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 {
@@ -1566,7 +1566,7 @@ bool i40e_reset_vf(struct i40e_vf *vf, bool flr)
 
 	/* If VF is being reset already we don't need to continue. */
 	if (test_and_set_bit(I40E_VF_STATE_RESETTING, &vf->vf_states))
-		return true;
+		return false;
 
 	i40e_trigger_vf_reset(vf, flr);
 
-- 
2.34.1


