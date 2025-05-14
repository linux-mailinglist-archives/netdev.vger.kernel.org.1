Return-Path: <netdev+bounces-190480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A699AB6EA3
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:57:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB347AD975
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 14:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68C31B4F15;
	Wed, 14 May 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="bw2fPUsm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B069B1AD403
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234653; cv=none; b=sxEdBO49wt1NI/ghDBk96mnH+g8VQwKVM4pR7KXPthLGUi0io7IGA3Rz8sjkh90vHM2oOxaf1gZSZme44NLV7RnX+L0DyXbF+dPIACAt8FW7ynb3n0y39Vw4DwJGS+RSCQt8Whc752FRWGCHBv8VVJmFmRwDOD0hqPpl+v1swIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234653; c=relaxed/simple;
	bh=/QBMqLf/vuuSytRpFydmcO8hzt+5Eyt1jxHawYVIojo=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Kj2gG6k9xCWqM/xgPJMEVsZ+d+ELdvlcZ+haXwL3ZkDfKEicmp8pnbuhwalT4WThygYbjR9MnyfmvoEGxUIQYt3DU/FsHR7XYqIN+yulHPBTyenV+IvO33b/Vbw6KqxUq20ZzUEsbzYYY+Mo6uCzIiJJapoacregDB2MBgO0bk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=bw2fPUsm; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 623143FB4F
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 14:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747234644;
	bh=7+7k1tpsS3eWwO2wsFgDxbEabEFibI3m3NNh5VfQoPs=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=bw2fPUsmDylmqUJZ75Jo4/oeFHjdkoW46bGtvcA7RQmzcxcT/uBDtrfDQGqaXyHTQ
	 y1STq08bwXBTmLwDkdBj1DPlUTjM/Rajeq9tigsyEFGVBuzYWTI34U9rHr1bVRMiBh
	 4JQ27HuDDb4J7hITz9ETxaS6rzHi1KY0ROq4mi4YCe1TLScRWLhe194nPp04/JFDCJ
	 P7DkBsapx92nIQzkJhJv1QUVjM21eNGR8Lvjm/JMMZjbeL8bm++XTtd+ziPSC2GLq0
	 PSpd6bnz5uTgyQA0ZBlKWXSySWS7IJzdLW5XIt2ggnCqYUnHqgUpRKKR/nrzfB2Z3D
	 xjlkO5CefyvVw==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a0db717b55so3705387f8f.3
        for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747234643; x=1747839443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+7k1tpsS3eWwO2wsFgDxbEabEFibI3m3NNh5VfQoPs=;
        b=R2xu6R6qh6gRC0v0jypMRhdnhl4S0wNzlQfytaCq5FDbLUWXUc26ztCMKpNB69+zyA
         VOXcwVGbiY7x3rpXNmzc496H4C/ds9tvyNskL+AnPRPk7seohqpoFS1BDR6R9TK/k/6m
         +B2FMyZm4rJRabucvNlny3/9Ch6k9CpLZOkHUK6/WZ63c4M3M6k77qaY/0o3HYsl+EH3
         Bj22ncyTWTPlIbdg8LwoAdocvA+4hGj/WSWnhqYDxHqr3ALcT23XZO+QT0ISinjZ9cTt
         JoHyllAGZqJAIhzoAJIoSp9U3YwRGVdN/iDXZQWw4ulrAQZVSQSFRjhBLKJXgO/hb9l9
         5xag==
X-Gm-Message-State: AOJu0YwW/vGVQaKn60Pe+9Ck8qQO+Kd5LB8mxN7+04F2GUXZ27NbNHsl
	W4Z/Z1N7BgJnb8wdQialfsWnZv83/vJc9HeOqugXH5aBWF7PqOij3eJBX/wF37Dze00Udpzmhyx
	LUcTevLMlwtbYxL3f9ZiDJ0CMh5cpLmx0hKFrMQWKhjVKZWkE5iOXfuvUuypCM7ZJjl/TBLkV4i
	8+y+FrohM=
X-Gm-Gg: ASbGncvQA0JMakH1IfA5/NgF6xSNoT2SVbkcUoQsQKIMKJI4SUX6+tH/LWwS6X8vwOz
	zEMoCNF1lpneDecFUIkiYyn6SUhXRypNePrBxY+TKz/1+ae+gMgp7N/i/v2s6Ofu5pHFczhplXg
	fUuI9JTUCCRfZv5IpRJeLi6Th2AYrw7T5Go7YlIsPt3497U5FnHaB8Lk1b3UmOdak3FyrmhHb5d
	Xdt6O4G5flgrVjogj9+u3KJPHvYX69Gb/JnqgsYbakxTFDzT5h6WVp7Hp7EPnAKNpoD57B4+ne1
	NepA2gmAgZ/PqA==
X-Received: by 2002:a05:6000:40dc:b0:3a2:561a:41f1 with SMTP id ffacd0b85a97d-3a349694f8dmr3043166f8f.12.1747234642766;
        Wed, 14 May 2025 07:57:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHminhm62LGKa+8/9+h6U7bzvFx00HLLSMbMxtl8md8kiB2vmbRohsStRKKdb1jsuX7VdAa8A==
X-Received: by 2002:a05:6000:40dc:b0:3a2:561a:41f1 with SMTP id ffacd0b85a97d-3a349694f8dmr3043141f8f.12.1747234642367;
        Wed, 14 May 2025 07:57:22 -0700 (PDT)
Received: from rmalz.. ([213.157.19.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3369293sm34512765e9.6.2025.05.14.07.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 May 2025 07:57:22 -0700 (PDT)
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
Subject: [PATCH 1/2] i40e: return false from i40e_reset_vf if reset is in progress
Date: Wed, 14 May 2025 16:57:19 +0200
Message-Id: <20250514145720.91675-2-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514145720.91675-1-robert.malz@canonical.com>
References: <20250514145720.91675-1-robert.malz@canonical.com>
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
index 1120f8e4bb67..abd72ab36af7 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1546,8 +1546,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
  * @vf: pointer to the VF structure
  * @flr: VFLR was issued or not
  *
- * Returns true if the VF is in reset, resets successfully, or resets
- * are disabled and false otherwise.
+ * Returns true if resets are disabled or was performed successfully,
+ * false if reset is already in progress.
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


