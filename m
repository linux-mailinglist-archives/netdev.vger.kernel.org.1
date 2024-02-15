Return-Path: <netdev+bounces-71898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFE28558A8
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7E56287952
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 01:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2D515A7;
	Thu, 15 Feb 2024 01:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TPL28IZt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 052F515D1
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 01:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707960047; cv=none; b=asN4Y6Yn/mAtxp9OaB8x/wI6Df4Ib8JP13aiq2fn6tr4ae7IyE62C81YAzzZWOtiiUN8lJz1jeDCzrVjHUuReq1/wsO1M+PsWC+rQSAFAbXSRrEcZ3BhgxBvabsW1sYTxyigcKSGeX3rwwtQtN7bHTSh41iHojIJ/Fi11kQWKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707960047; c=relaxed/simple;
	bh=dvNmvEihLgd/TOG/cZ5FyX4XLusRZmEmsLYGwkOemnU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e4CoqSwbOIXkm41ECck2o3ZoW6c0EuRA5YScf5M60WftOh/ZgssPUI3NDLftPQjS6l7jApNHLwKLem1wDpHzqZQie6jW6tF9+MsqZpaGdoAhap4Yivcv260IkeuaWX0VddsgThNO0gopvRxa2DYsYY/T4LbQ2bTfmMVzv0W4lV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TPL28IZt; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e10ac45684so302221b3a.3
        for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707960045; x=1708564845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vepiKC8QDUMnFcRy8EKHCiRB88KWrRcYdSU49clz+5Q=;
        b=TPL28IZtcgh5fBLcWdiLaTWs3TFSeXASLLPzQKkRgB0edbQEoXLt7aEvSnbU75mI3y
         mFBMYLk8hNBJ3uzN5ZSkDO0LmOl2YdmtVtlX+xS8pOyYKneTm3/NQ3Z5mQA6wLxEWaP8
         CG8bEDvA22B8+yq6z2YdvdJd9SNP/ICog1h0rJiL+dn17SbmF0xQMTSU6QTciXTd4Lbh
         PezcYGOkuaMuGYZ8SDpmu4yoaQBb1/MW/EM153awse7vN45OSJF4kTT3xIZCpw1PPEc4
         83h/yEjpX8gSexfb6LZg02Pk9ECMKy5+L9Qqv7R3ZTN0Hh9rI39gv3hyLTesDRrAnKXU
         71VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707960045; x=1708564845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vepiKC8QDUMnFcRy8EKHCiRB88KWrRcYdSU49clz+5Q=;
        b=J50E5FS9tiH5/ELsp+r5aBViwKRqc3xDzbZb8sfSLIhkutnV0gHGHAdRDhQrJQJ0kn
         ii/KYZJYxbt/6ykFGtnRHCp4cyqE8U2E7H1i5Rhp7fn1aYJnuHNcf1OMULHKGkQ/cQLI
         V2twzAUGfPErD+K59X//3W5mKIGVQ85jzyy3YDoS0d0svb0alQQLEspjgVKvYm21jJgx
         ORGlsTzeiZN8P3wqDtiG/lNvrI0pUWzHKxSeBvGADn2E9nnNhza3T91znWdAODjMuIOY
         aPL7/Az5+BOac+Fi3TCxNSimR45n2G1UkPWxeJG/mGFSyk9Z7f30KnWVV3YJt1qxgH6t
         y/sg==
X-Gm-Message-State: AOJu0YwYZJXGffhMsFg8x1lIejmuEY+/4MZlQ79kZZa4+FLJma+z5cSn
	+VmEF5A87BPaJiJqDIweQuac5qibm2jEfV+n42Mbn5IhObFk6sV6
X-Google-Smtp-Source: AGHT+IGjfThFkxEFXkCZ7S0Hk7BvQ1YGtSQ7ZxH8HwT4p0+hajNTnkTOevr7O7UL8cSv2yzykAjkyw==
X-Received: by 2002:a05:6a20:9f08:b0:19e:3a94:6309 with SMTP id mk8-20020a056a209f0800b0019e3a946309mr744223pzb.5.1707960045171;
        Wed, 14 Feb 2024 17:20:45 -0800 (PST)
Received: from KERNELXING-MB0.tencent.com ([114.253.33.234])
        by smtp.gmail.com with ESMTPSA id x2-20020a17090a6c0200b00298ae12699csm163417pjj.12.2024.02.14.17.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 17:20:44 -0800 (PST)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	kuniyu@amazon.com
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v5 01/11] tcp: add a dropreason definitions and prepare for cookie check
Date: Thu, 15 Feb 2024 09:20:17 +0800
Message-Id: <20240215012027.11467-2-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240215012027.11467-1-kerneljasonxing@gmail.com>
References: <20240215012027.11467-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

Only add one drop reason to detect the condition of skb dropped
because of hook points in cookie check for later use.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
--
v5
Link: https://lore.kernel.org/netdev/CANn89i+iELpsoea6+C-08m6+=JkneEEM=nAj-28eNtcOCkwQjw@mail.gmail.com/
Link: https://lore.kernel.org/netdev/632c6fd4-e060-4b8e-a80e-5d545a6c6b6c@kernel.org/
1. Use SKB_DROP_REASON_IP_OUTNOROUTES instead of introducing a new one (Eric, David)
2. Reuse SKB_DROP_REASON_NOMEM to handle failure of request socket allocation (Eric)
3. Reuse NO_SOCKET instead of introducing COOKIE_NOCHILD
4. Reuse IP_OUTNOROUTES instead of INVALID_DST (Eric)
5. adjust the title and description.

v4
Link: https://lore.kernel.org/netdev/20240212172302.3f95e454@kernel.org/
1. fix misspelled name in kdoc as Jakub said
---
 include/net/dropreason-core.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index 6d3a20163260..3aaccad4eb20 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -54,6 +54,7 @@
 	FN(NEIGH_QUEUEFULL)		\
 	FN(NEIGH_DEAD)			\
 	FN(TC_EGRESS)			\
+	FN(SECURITY_HOOK)		\
 	FN(QDISC_DROP)			\
 	FN(CPU_BACKLOG)			\
 	FN(XDP)				\
@@ -271,6 +272,8 @@ enum skb_drop_reason {
 	SKB_DROP_REASON_NEIGH_DEAD,
 	/** @SKB_DROP_REASON_TC_EGRESS: dropped in TC egress HOOK */
 	SKB_DROP_REASON_TC_EGRESS,
+	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
+	SKB_DROP_REASON_SECURITY_HOOK,
 	/**
 	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputting (
 	 * failed to enqueue to current qdisc)
-- 
2.37.3


