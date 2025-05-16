Return-Path: <netdev+bounces-190987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 597D9AB9946
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 11:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA40A167E80
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 09:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A14522F768;
	Fri, 16 May 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="j8ghrWHN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FEF217F34
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747388855; cv=none; b=HEf1tl//nKt3XWf+bG/pSHgjJiErdNALkSxfHlle1bZQhN7u6kR5W0vs6rlqRtkjvibr0q1xehM0Pytbzlt4KabzDpk1wNqvhaARNGZ3wWQsU5EzGl3DuKUA8CcjZhUZFIYCjWN6Au6LUBaUKc7FAh/6BPVf3LRaR8Th5B1X1bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747388855; c=relaxed/simple;
	bh=Q0A7Pg88li+liP71pyE7Ta1/+0MofX+fn4pwAf26zh8=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sz9wMadjxcCajiWzVPrHsr6KHl4vMX1gFy4ZjjfYp1uzsNeer6Baw1ksUIqw3G7hMR71wWxK+ab9TkT6WBNl6z+6/kAh7juJEEUpz0kJYpPiZTKC90PRMRJY+NjWZ42LMPYMhll5tuY9sqMIZzzEd3F907vB78zJ8VWT6ec7vhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=j8ghrWHN; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 734B83FD42
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 09:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1747388851;
	bh=ROE8L3YaWta5ImjYVCCqyUOCXfZoeYQlhcOMX8bYzao=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=j8ghrWHNyi62mPjLzrq9zfbDCQHOYc8bHORgole06swKVPRujAuvMueVAaoFTEDrk
	 Hx5X3OnmLWZh2ytfu+7hTxGzOTiIvOIMerB8boF3M/1lY84BofAKlcAgvawZGvZZ1m
	 AimUnRMgVNlrIEuPF884Svo/gpCZasa3hQYRPuUhufY+r0Yys44oVA18s4AIRsDuim
	 hpCTyq9zHYU7UZw1a55gOfZxQjbApvmtAxLqlvng+5DVPBGBuk5pmQDR+1D/RIAgul
	 9OU4CFz3hXEF55d82PwY2ibZ5v8HfcfWUQuQSp8FQGm4u7la/7lsKD4OyrZ6cO5MwV
	 lX9l2azFQs4Fw==
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a36416aef2so10534f8f.1
        for <netdev@vger.kernel.org>; Fri, 16 May 2025 02:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747388850; x=1747993650;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ROE8L3YaWta5ImjYVCCqyUOCXfZoeYQlhcOMX8bYzao=;
        b=Biu+uEj49e39hYA6+5UFWrfZV5vdlcTRD93/IyGGDRwS0n1sn3AQ5WeQDhArV1+H9J
         DQ1sRVeiyi35DAwbLEbGlY9TscV+O1/XtIkIGNRyKI9TNCn0ig0c8DDTzZDvqVviRyC3
         qX3QwhwRqYEF1HtI1R1mb6Nq0+OvYIRNJw6qdbPAHjAOhT2Sm8ZDqQHHplgnJQQ2/8xH
         zIwTTI6Gn40JvWA0gokY4cXny2qb0nTTWSgGapyLydwNwS0/XtYtZH/s4HTixfyIy6bc
         mBkNnBNWpOJNfeXIhIE51lH+Ua1zSYlLF9nGNCuxDAiv4yGXgz/PlOujNPtFzEF4bJJK
         sTJA==
X-Gm-Message-State: AOJu0YzBcYjAc3V15w7y9iE+dRCb5qjSVegqluGrVaaM7Ed6E8SOIrS5
	S1JUwklCTwxBdxm0aAar7u/J28Vt1ndZ4U396I+IhQrNlxDJ88PKAqOn2TLdj92YOEImtnYg/ZN
	Dt0RTRBvnkzZej2AroKiZgPATLVfwD6VRGTu+5p/rbDiOp8kRHDz7sckKHAKjoUYVP51Tv/IZJI
	CZdjb5pTEXvt0=
X-Gm-Gg: ASbGnctzEY9vrnIPxOF8T5I4cGozfEXabWqn+kMb6QdYUghuI7qOyO33SPxVAGUzLB/
	PXTBVZPWBzPK98cbI+KdYGNDEUm2PIiwi4nPMX0qxnckR60BQA+plc0HGupXKSkry0jDAEICN0J
	+l1AnMo55x63PvsGDUUMcmpBgyGC5RJC6wevzzTFnH/TXefoGF5dGkdrFOL1Jk+q+eYIZLKG2HP
	aBIP1r2DZasPHZGyF5A5JtltjtWcn/zNmBWpAPxel8UoKGJTw14hdu13Pzf8CBsfcQu/s+5oAzf
	F2BKtJU4cxX8bg==
X-Received: by 2002:a5d:64eb:0:b0:39c:12ce:6a0 with SMTP id ffacd0b85a97d-3a35c826787mr2935613f8f.21.1747388850424;
        Fri, 16 May 2025 02:47:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGW/68AiiOfI1CjkEDC7SYJUC5vYNSXoFLVliIrOwpfKxrpS5HsEpGo+p0XvRgVvW/f68cNeg==
X-Received: by 2002:a5d:64eb:0:b0:39c:12ce:6a0 with SMTP id ffacd0b85a97d-3a35c826787mr2935593f8f.21.1747388850077;
        Fri, 16 May 2025 02:47:30 -0700 (PDT)
Received: from rmalz.. ([213.157.19.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca88990sm2329962f8f.68.2025.05.16.02.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 02:47:28 -0700 (PDT)
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
Subject: [PATCH v2 1/2] i40e: return false from i40e_reset_vf if reset is in progress
Date: Fri, 16 May 2025 11:47:25 +0200
Message-Id: <20250516094726.20613-2-robert.malz@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250516094726.20613-1-robert.malz@canonical.com>
References: <20250516094726.20613-1-robert.malz@canonical.com>
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
index 1120f8e4bb67..2f1aa18bcfb8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -1546,8 +1546,8 @@ static void i40e_cleanup_reset_vf(struct i40e_vf *vf)
  * @vf: pointer to the VF structure
  * @flr: VFLR was issued or not
  *
- * Returns true if the VF is in reset, resets successfully, or resets
- * are disabled and false otherwise.
+ * Returns true if reset was performed successfully or if resets are
+ * disabled. False if reset is already in progress.
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


