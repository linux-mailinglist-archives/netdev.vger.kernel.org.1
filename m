Return-Path: <netdev+bounces-166729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A1A37199
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 02:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48C971890A4F
	for <lists+netdev@lfdr.de>; Sun, 16 Feb 2025 01:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C311617E4;
	Sun, 16 Feb 2025 01:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PW9YxTY4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305717BBF
	for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 01:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739669525; cv=none; b=PYZTcFoUFW9i6EltFIDQH1AQjZAub2obVGYkFipid/K/k1CBF0JyIsjbW9PRW7wVrevBozShqRAUSsAUzIVwHx7k837hID7Yb4aOaoHgWbcj/pivGTiLpn0ktVsJnCaBbwyjlPfzxpNP0Cl1k09DZfwTOR+aSTq+7Nyu3kZnmXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739669525; c=relaxed/simple;
	bh=b2g8VOg+9PlKkIDwLGNPDbqTwGG0DWWwLiduaRMkpow=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zt8fFFGwV4RvOb0VHDYRJBdIu63GuWAuEqySQNR8Sy7dvd+zadmmVFScDWWhl8VHO8tBLLgDzRZt10E3b+shpr8zEmEY3GHkmhTNq6aQ5ee5aRR3bmUoZPc0SchqGpN1O8FPl+48S7GrO5AgAyF2B23d62QbutHZYsMg752oEog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PW9YxTY4; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30920855d5bso19498041fa.0
        for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 17:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739669522; x=1740274322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hDtfYAB6AaPmCCQemzqhVfvjKtn0/n4xLUAwYV2gFIQ=;
        b=PW9YxTY4tihv+q5H7BlaKCGXIbrDFtVFHEvB4HRPbHJJHt9UJ3U+6Y4v+Mr/5p6Xbq
         hVv4asdZI54kJRJGLA0KNJYvvQLLjqBEg//Uuun2wT2Ej89k/mB/Ds9H4ZFaHKqQiOxi
         p/v+lH4x5hpJHcoWQT/YZUXV3EFSyrZ1WUBcb6j662Io94zAVpjRczF/WApmu1Qh1DFc
         LfNNI7Oj51lQnhUw3dVyQ6BjUL7eb585Yz6TWffwvXoppvjaMf0n0O5LIaUQhiM7X4ec
         g5cCxZHc6l370kAjMQcR8dKDIgvLx4UOEMx+dQFMdoNDnkPmivXaMtFEkZ1u4Gu5D4JK
         0g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739669522; x=1740274322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDtfYAB6AaPmCCQemzqhVfvjKtn0/n4xLUAwYV2gFIQ=;
        b=SyETZUt2VUeM7VpeVcLQaHfmnC8pAZ+DvzEdXBRPCDzd7Zr70hqoJ5gXe5JwHUJ74r
         Eq6nGXpx/DekA0uvBtibRNezOcV8TFCjxmB0fK9ihr0y/iq2osqHWt2OFXWL76TgkhfH
         zc6ofiFipeLUtvV0oXyZXbtSVfzaHBP7TaDn/zIKj/SqHInIjzj7Q3fU/4RB/Sq5Yu4u
         jkzS4Mq75c/3CWxhJiFe3DjRSuWLq0z6xINfItpt7nlAhQ76l8BZ0V6JNfIfuNcXxgqI
         hEJvdOspknwSggNq4Ui+Lrb2/9NM1V7r3ITczQIrGGTLe6N9O2shL8sJLbcoL6DI7wzH
         fjQA==
X-Gm-Message-State: AOJu0YwUWhREUl+YmamoC4MQHDnKfZo5BJlz9xXp9puM7kJbe1oaaSVA
	J7xZCk4BD4Q0yFcJXs51Tcdy3z9oL6+cUDZOjeAPH3g0mJNMIsFd/GiHb1OMnTprAA==
X-Gm-Gg: ASbGncvlXHUVTdaOTomLGpKQmNUVAPasfEytBxRlBnu83tR93bpEc5mB3qWwmJ3yM81
	9DDOSwMMJhpVV7prNigdQKN22aYAPRUT6xY2BZiLJd8g+dtupIUEOA9HT3LMX+Z0K9gMop9dMw+
	NySV1Y66r0oXaUnwwbw3pisPiyYG6PRb6K8dRLoRIb0nWXarK7wNHAewx/MjpNhcIKEyjcimcQL
	DMrsg1K6c/CcyOAGr6LYvma/+tEQLxvQMm/+4v3X8r2v17MrVCB2WgfYA0CyltSuOjvNy/XMdBp
	qTCaKG5TdCMFgTC9RBMyQ6pvL0fJwpp1HHKEED/Y/efs32Zh0qECF2O3mvu9RsLnlnLkblHv4g=
	=
X-Google-Smtp-Source: AGHT+IFvLXb7y15j0sZQe5ckBHCeYw1RJLU2yS6Knk6hxU8CTbe/HTTAYbCK/xsu2LCnogGiWRTFKw==
X-Received: by 2002:a05:6512:10d3:b0:545:2b69:41a2 with SMTP id 2adb3069b0e04-5453030261dmr997024e87.4.1739669521569;
        Sat, 15 Feb 2025 17:32:01 -0800 (PST)
Received: from astra-student.rasu.local (109-252-121-101.nat.spd-mgts.ru. [109.252.121.101])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452c937745sm635976e87.243.2025.02.15.17.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Feb 2025 17:32:00 -0800 (PST)
From: Anton Moryakov <ant.v.moryakov@gmail.com>
To: netdev@vger.kernel.org
Cc: Anton Moryakov <ant.v.moryakov@gmail.com>
Subject: [PATCH] ip: remove duplicate condition in ila_csum_name2mode in
Date: Sun, 16 Feb 2025 04:31:55 +0300
Message-Id: <20250216013155.643127-1-ant.v.moryakov@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Static analyzer reported:
expression is identical to previous conditio

Corrections explained:
The condition checking for "neutral-map-auto" was duplicated in the
ila_csum_name2mode function. This commit removes the redundant check
to improve code readability and maintainability.

Triggers found by static analyzer Svace.

Signed-off-by: Anton Moryakov <ant.v.moryakov@gmail.com>

---
 ip/ila_common.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/ip/ila_common.h b/ip/ila_common.h
index f99c2672..cd3524d5 100644
--- a/ip/ila_common.h
+++ b/ip/ila_common.h
@@ -31,8 +31,6 @@ static inline int ila_csum_name2mode(char *name)
 		return ILA_CSUM_NEUTRAL_MAP_AUTO;
 	else if (strcmp(name, "no-action") == 0)
 		return ILA_CSUM_NO_ACTION;
-	else if (strcmp(name, "neutral-map-auto") == 0)
-		return ILA_CSUM_NEUTRAL_MAP_AUTO;
 	else
 		return -1;
 }
-- 
2.30.2


