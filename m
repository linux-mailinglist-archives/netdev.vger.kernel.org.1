Return-Path: <netdev+bounces-183881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA03A92A36
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 20:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E41434A53B7
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4549F1A3178;
	Thu, 17 Apr 2025 18:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJbuKdHe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CC256C8C
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 18:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744915664; cv=none; b=W5Bl8TVpTaUPszq9+bGJVECADmwk8wDXBPEiuRLVvvgBsQq77wsY7W6VuIiV6OHvwqL/Cxu5ZYVtA3yfN79g6zBOCn/NLQus3MnzXcVSHZg6tY/YxdIFSEAYv7VsVNsgd7V/GrHvuyepZ0qNOy9PEJmm70SZWazle70IXbhXsnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744915664; c=relaxed/simple;
	bh=EtYcr/pNo/80REHig4eEMCgqyHiaBo01q26fwelUQI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hkEMtH0/Qle36vBN/FCifIXOJShehsoPV0KCBte7NVAAvFznJKFUT0DMLTEOCg0uZIVAsoavfu2PBA0M53dt7KAsYztiVl2i2jnapY3P33tAzcUsncTlnB89/H6m1DrbkTBbL4updlBFeMxVGCyxhfWdYQ9jhNPCmRLsj47C5sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jJbuKdHe; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so1235787b3a.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 11:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744915661; x=1745520461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4B6dtqxdaQX+i9nFOfsQNTO/wk/Tvk+VM+ZByVM4Ss=;
        b=jJbuKdHewBCepE3H1Zb7EaxHJK2C3TO/0MJ3wsZyzwjWchvrAc0VCHAasRJoneVoXN
         u50vbHBEgG1FOvMCvra25zGAcGtkv6doIRrHFMA1Qqfh6JWyn/nWi/oH5xVF/fhZKGCq
         oQ6H0WLQjM8ol2D4JpVk43jG96Na97XluCOxpXKhbmuR1Rd7oQlKuOaVDv1zWJ1aCyPT
         p/AlCenVkNqRhxfSSPpF5XEUDcNDXNhFRQVX3B7FZUUhKMUTMuYOlergz14L/297pz6E
         EhrCVwefQQpDmDux4LfOQGCTDA6wAMJdkccf+yUc03fbxd6ljqxgtEv+681qHQ9iYPwB
         4gdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744915661; x=1745520461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z4B6dtqxdaQX+i9nFOfsQNTO/wk/Tvk+VM+ZByVM4Ss=;
        b=n2DF62qmG+Nh7grbjhuTr1ZmRPVB4Wma91p9CYXsvEb6/d9MMN8UwbwAXIvaayj6Rg
         vZO6MdWM8MJ2arJmVb2w+pMyvikORMMr1Mtvw/wjHZJsjdx0omUDdmK73B2/rPTuEfks
         dA0zL905r/R+rUJYObINtrL9Vp9FoK2/fyFuIoXiSyK+Rq5QuEGi85WCF8M/0DUVGn03
         6WsOZwwTdn//+//QYaa3gGoI1R/kUkOwUbs7ddpcIJtedqmAF9mSywPmQb/wWnTFf91P
         vzPSq3fH+y9IsuPwy1d9bMrxeTDVA4epQomZvZj4oFGH40+2EEDIzCNlh9sgRxFAyxYO
         qsrw==
X-Gm-Message-State: AOJu0YzR0P2TsDGvArw90VURFyddmbk53HdOZ1fbBrdUzb3+RChs8XbN
	T8/hu9fqRplUFLofniL0q6csqnMZXte85YJ4QpOqi2W3MOibHyQIF7WnSDuE
X-Gm-Gg: ASbGncsC+qEkeWS5ohnsk9UwP4DuySLy1KKk0/N7m44F0fz5iPWdJAeHig0lYtTLeCL
	kP2KpnYLtYMSSQaPpN3GXrGxAuTHuEmkHCAAR2ktjR8J7ekFqIxZo/2+TZaJRlMGCUnIh3P6gip
	MBch0IxUlMOI6yLvLOW2wsdmXOjPWCDY0IV+JxuL2nldbuifcXZ4O+V2qy4vbk2QSHCxv/uJXul
	mAFLBXN/9z5QhvWdhh3A3NWcFjzSgCdtc7vlhDF9E6hoq9GnVqERHF1liy3oetlcvYpzelG8hHU
	xvQy4P5DpfMD6JtmiPNdhL2ktadc+Y+RdIjLqubHH6tZ6RjbBvXePYXCqi7Bcg==
X-Google-Smtp-Source: AGHT+IEM4RhVl+Zz6PudZu5lFmEAbJPL0GrXoE1p0HVn4xv1eyQKsikJhspT9iblF+YY40pJEyrlxA==
X-Received: by 2002:a05:6a00:aa8d:b0:736:a973:748 with SMTP id d2e1a72fcca58-73c267f8ba4mr9885581b3a.22.1744915660514;
        Thu, 17 Apr 2025 11:47:40 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfaad645sm187773b3a.150.2025.04.17.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 11:47:39 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	gerrard.tai@starlabs.sg,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [Patch net v2 2/3] net_sched: hfsc: Fix a potential UAF in hfsc_dequeue() too
Date: Thu, 17 Apr 2025 11:47:31 -0700
Message-Id: <20250417184732.943057-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
References: <20250417184732.943057-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Similarly to the previous patch, we need to safe guard hfsc_dequeue()
too. But for this one, we don't have a reliable reproducer.

Fixes: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 ("Linux-2.6.12-rc2")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_hfsc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index b368ac0595d5..6c8ef826cec0 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1641,10 +1641,16 @@ hfsc_dequeue(struct Qdisc *sch)
 		if (cl->qdisc->q.qlen != 0) {
 			/* update ed */
 			next_len = qdisc_peek_len(cl->qdisc);
-			if (realtime)
-				update_ed(cl, next_len);
-			else
-				update_d(cl, next_len);
+			/* Check queue length again since some qdisc implementations
+			 * (e.g., netem/codel) might empty the queue during the peek
+			 * operation.
+			 */
+			if (cl->qdisc->q.qlen != 0) {
+				if (realtime)
+					update_ed(cl, next_len);
+				else
+					update_d(cl, next_len);
+			}
 		} else {
 			/* the class becomes passive */
 			eltree_remove(cl);
-- 
2.34.1


