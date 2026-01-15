Return-Path: <netdev+bounces-249978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4E65D21DD5
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 01:35:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B1E81302D52D
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 00:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7323077F39;
	Thu, 15 Jan 2026 00:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR+hR3S0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FAD1917F1
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768437251; cv=none; b=nKSMICjRkXMhnigtn+qwhcQEavzI1CGWcxvg6qK6QBGv3XgddlMMIUvvESaprXqNHpc7u2IM2hec0zgy5IdxvEcXtLJmAjmpNHuDvFw1nAV4YqQLXcucJRyxULFiFqOTDFAsVYhIxmRkURmimqdjtyg7XBeyA3ZiLHFI0aLfVDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768437251; c=relaxed/simple;
	bh=qYOiDTIdh2R4iAfKIO1cUOiHn2w+ovZih3iE4D/RLYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCCpnR6XFF00A5zZX+dS+jj3tRHGIlBJrkKHUQ8SCZxUECVupPFBx/r8K3KWdXDAVCUkPfFA8hQlUcniFDcn6jkKzIp6F6LSgp5UlJnrgrgKhkTvv2Kh5XnNECQ1ZXLm0KCiOISgd61eKpT4aPU4RD0j96DG4iFDPLtsWmsITio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR+hR3S0; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47edffe5540so3759175e9.0
        for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 16:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768437248; x=1769042048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbM4c1VxeVlAMbqGWBUodouxCbGi1/XsofzJxDkI3Zk=;
        b=NR+hR3S0vDIefp0r/uS1pz1PJwl3YYnfA/G4t96V37A4BopXhCSjOfH0xw7mCvLRqW
         MricP4xAFTXwbr1YNHETQxCpHcJ80brjdjXqL03XITsBZmqEnqHTdDNfcW5zSw3qgRZh
         ZNs8fcDzCQx0MdbsHJKOo5OtnsmDw/HwG0sl1irsM6XVh6n5OZu+Q3I+8rO5EnpDHyPt
         r4Z/rWL2mUhZNombXYpYe6z6cQbxeDUrXik2Q4O4jWmeRi36Bdfr4aOHeTsf7RreHbA4
         0Bna2q7svXe/eaDgEqy52uv4Z3nWY0M3/VjJhOIlj+ZNg9SVAt1SEDeSThD7N1hWIRZ2
         NPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768437248; x=1769042048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TbM4c1VxeVlAMbqGWBUodouxCbGi1/XsofzJxDkI3Zk=;
        b=kfFftVXuRe1sPfsh7tgmE+BEsAm6/aDliLSEKEZeyJxeCNVyB2FaJlGKOttboXCetQ
         KTnAIhH7J4h8///6lhq43xf2kYrI/cCUO9nJ3Bbi0LOQUW0TUiLwnJ34mjk6ZDGAc1+j
         bfiG9j2rXPn7PxZsf/rVnYxSOUG5IWt1wajipEELW+MRZQqyQpfY5kf0tUqV5t3Ls1vw
         ooUU4MGcX/1vAY3YdKBqt2ldCUVUskq3E6kFrB8W/Jr2Ir75Wi2IBUTUL3h4NMlXJnJR
         2QTpysNYuJ3rdA9b1NACbHsSaNQb2qciGp8EFcJxCy2QoIBODQtq3gaNsifwa+oYIheD
         KLAA==
X-Gm-Message-State: AOJu0Yxn3yNzXAcVR4tJhpWDeQ7tIZzde10Yjnh0SlCWwkVOJ01ivabK
	sP7ZXX9rNUhLeGc0aVz/Q1WZg0+1DznNBZk8Nwi29/KNyrPYBnpANRDmMayy461f
X-Gm-Gg: AY/fxX6wwbLSjD7qsJLOyqRcUNE8s2zt253RDiSL78twtKiuhKWBHWVrvlzrFPPFdWy
	yjes4zvFiO9IAxInFL3KK9tfzH5sdficxJabibUnkJpm3s2RZuAhyQBn8pOwAbERo7yCBxik48p
	0w6khuGmv5GLigCp4YG1W9ZQXXRBqLAULJVeAB8r/BF6shubX3kNHKB3gO5zpnr7h/ZXnvoRHO5
	6QiKF7LKLeCAoK4NgNsIuHPAAOmLWgq+xmWorZS/1/rnNFRagRjMF8HuzgIkRdaOK3IHZSVjy7k
	ZPySwmihbdq3LWN9I8lpSr5RJVslXhqYDW708IukdK8Iaw60JLUqYyqgUd2uui+uqRHS1Jry2tO
	OcEYuA2gTUb4iLz9bKo/qn4jVoXqnPEiffvhkWkGpBEHN7fsiF5/7BlRKvtOvB5H/Vh7thiqTqc
	iVwwIj6byW
X-Received: by 2002:a05:600c:314f:b0:47a:80f8:82ab with SMTP id 5b1f17b1804b1-47ee335e701mr47054855e9.24.1768437247678;
        Wed, 14 Jan 2026 16:34:07 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:4e::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428acd0csm16181105e9.6.2026.01.14.16.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 16:34:07 -0800 (PST)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	kernel-team@meta.com,
	kuba@kernel.org,
	lee@trager.us,
	mohsin.bashr@gmail.com,
	pabeni@redhat.com,
	sanman.p211993@gmail.com
Subject: [PATCH net-next V2 4/5] eth: fbnic: Remove retry support
Date: Wed, 14 Jan 2026 16:33:52 -0800
Message-ID: <20260115003353.4150771-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
References: <20260115003353.4150771-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver retries sensor read requests from firmware, but this is
unnecessary. A functioning firmware should respond to each request
within the timeout period. Remove the retry logic and set the timeout
to the sum of all retry timeouts.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c | 24 +++++----------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index fc7abea4ef5b..9d0e4b2cc9ac 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -835,7 +835,7 @@ static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,
 				     long *val)
 {
 	struct fbnic_fw_completion *fw_cmpl;
-	int err = 0, retries = 5;
+	int err = 0;
 	s32 *sensor;
 
 	fw_cmpl = fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_TSENE_READ_RESP);
@@ -862,24 +862,10 @@ static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,
 		goto exit_free;
 	}
 
-	/* Allow 2 seconds for reply, resend and try up to 5 times */
-	while (!wait_for_completion_timeout(&fw_cmpl->done, 2 * HZ)) {
-		retries--;
-
-		if (retries == 0) {
-			dev_err(fbd->dev,
-				"Timed out waiting for TSENE read\n");
-			err = -ETIMEDOUT;
-			goto exit_cleanup;
-		}
-
-		err = fbnic_fw_xmit_tsene_read_msg(fbd, NULL);
-		if (err) {
-			dev_err(fbd->dev,
-				"Failed to transmit TSENE read msg, err %d\n",
-				err);
-			goto exit_cleanup;
-		}
+	if (!wait_for_completion_timeout(&fw_cmpl->done, 10 * HZ)) {
+		dev_err(fbd->dev, "Timed out waiting for TSENE read\n");
+		err = -ETIMEDOUT;
+		goto exit_cleanup;
 	}
 
 	/* Handle error returned by firmware */
-- 
2.47.3


