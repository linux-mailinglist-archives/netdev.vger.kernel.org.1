Return-Path: <netdev+bounces-249203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB938D15692
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 22:20:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7813E3026AE6
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 21:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A33242CF;
	Mon, 12 Jan 2026 21:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNB25uxW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5985330324
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 21:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768252788; cv=none; b=B2hqlX9/k2G+Dy9ZNRWL3ApSV1JPWXkoZa6kGI5G9UeaC0hdZyzi7zbazQaLy/DCC4kAaP0uA4zOR7lbUT9pAkYWxTTrPA5vQQPdaQ04jtMzb9aUCKfUVtQgyKZJi3pJ1R5xJzIMXuNO1cdXSYX/sWlDbGc+AMDDdycN+ZhLgak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768252788; c=relaxed/simple;
	bh=qYOiDTIdh2R4iAfKIO1cUOiHn2w+ovZih3iE4D/RLYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knIAMc1u9teVI7LFs9eJ4+tg61Fdi3Oy3MXkcnb+AxsLbbybx6c2KCVkBouFCO4J6Qn3izE4o8wvcwg8g4gjc9zMPJNxGKmUnE+B7a5+QhJVBjFaSeZDufF1NhQK97H1oH21kxPJVMiBKwg2ERVNPvqoy22JZv+f4uf7wGMAtAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNB25uxW; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so57509895e9.2
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 13:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768252785; x=1768857585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbM4c1VxeVlAMbqGWBUodouxCbGi1/XsofzJxDkI3Zk=;
        b=kNB25uxWQGQP9jauyVw/AABbqDDQolPJ4GyEnd+v3Hk5DI18kmKlKYJ+/jEdjuCYss
         qC+BiX/2/yTaeJ7ZQolqlDDQ8vLdOy/v+3JJFuP5pNR1D8aeIhfzvqPXPsJTnb4XC31h
         USf982Ttu8C1FOxzA+BszoQfEqV029I0ElGpsCHiZOdwOhIaBDf3Vv3yKAm9iBue/K2x
         C3GkWq7dcSTwQpvHkS5fdKdMnvqpklR7e09bIO+T/Pr81LPZOMmhK4hoRs3KnncyB3hM
         oZ6O94S0xK2TGh6BAPpoogi0zRAH5Bd4h51LHzQpj6RZOCNUMGNk62U/pCYdGByqAdif
         4L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768252785; x=1768857585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TbM4c1VxeVlAMbqGWBUodouxCbGi1/XsofzJxDkI3Zk=;
        b=b/jBzi/JFx+NKpaPawcfTjiKFc2nPQOUqI/6tlbjoOMlCyW//u9Ls8b9Jh45/2wtGG
         d0bKaH4LtcOhlYi4IgEfKsmO2LIEHZxVbvdoP9ZF4534IqAKw4HL2EYtxLxiaFwy500n
         7c00Ry2SX1pUsnHob2kWTNMch7VqNyrWR9Bu+KPGi6R8ugDGuk/Hrg6Qn0oB7zL2sILS
         UUAmqmbbX6N3KlhBBgzysgUHWOw4UV0r2gMs3A9/0KGkolMgE/VN0uX7Bei70db2rpVn
         NvJSDagTJA0ZoxJvxC1Lc+uW8p0t3JDxRP8TIaafl9x5K1Kofs0MWMFdwmQctBkxhkdb
         9N7Q==
X-Gm-Message-State: AOJu0YwQJu172tcABqkJWVIryngsw2unpMuju10HqTBl2be2QlBdevGk
	mkeDJZVlNcb2Xf7fM7uiKEHjBpo+PMuk0wsDLwh2k4vf6Etrz987xH9iu4JOoYeP
X-Gm-Gg: AY/fxX6RXXeqp7GMRy6gaItdkQbCtGEAAgHLCPsPdMJJU//SkIpyOtQY5o+TlBBt3EY
	5YOEBKJn2EOje0OH2xyTYRjYHsqDRF2uux3xVo0xZWdGi3brvBANB4dfxrPTk3OwUksy8xgW3xp
	cWTUuqUX5FKADJM9OXm9QX+bJREZQ3ngc/ebtH+DTVKTHXwRacBKxqsumcU87LA+PaHus5iZVOP
	JNvB5LLWhgmDJ+IwRESwq2lQVSZQaNnbBI8Mm+XLJb0YWBpmacfkyY/o28wMP34PeT+HPWYEWC0
	oC0JLAYfUZ/g6qxqNiM11e02Lkk6m9qtNf/pZoXeoDwu/4dZV+BtqMS8f3p80OzoCo29YSrghpb
	AryZUtzUcj6dwBAXQC9xy57iIxF3YAPr8S9VMfU9MFvLc4xaHgz2Uz0aKw9ld5jkzcFv1OV4QyK
	QJcsg0rPJV
X-Google-Smtp-Source: AGHT+IGuvkNYYHBfuF+THqVJJlrFeMtFrWEzHOJW48xWcEq8Wz8tRz+IrhGr8sO+UoPu6kkMtnpwmA==
X-Received: by 2002:a05:600c:4fc3:b0:477:569c:34e9 with SMTP id 5b1f17b1804b1-47d84b3b9e6mr247062025e9.23.1768252784649;
        Mon, 12 Jan 2026 13:19:44 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:42::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f390a69sm367803735e9.0.2026.01.12.13.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 13:19:44 -0800 (PST)
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
Subject: [PATCH net-next V0.5 4/5] eth: fbnic: Remove retry support
Date: Mon, 12 Jan 2026 13:19:24 -0800
Message-ID: <20260112211925.2551576-5-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
References: <20260112211925.2551576-1-mohsin.bashr@gmail.com>
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


