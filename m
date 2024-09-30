Return-Path: <netdev+bounces-130537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F46A98ABE8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 20:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 617761C211ED
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 18:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A604F199EBB;
	Mon, 30 Sep 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RaBp/pHi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38245199EAB;
	Mon, 30 Sep 2024 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727720308; cv=none; b=WYYygGZzFnD9GvYysgaqtdwF5tYjFXdXkLc4NFUNEpdMQdebFlDzrWo6FNU74JLJIoIUimUpVOq1PJ9Ul4spPhBWBD26qiV/76uGPWD701zdRTwgzhUaGe/fMijcimKf7lMHOO1acoh0WFP+beb6mFLp1ypdxs8GPq8ujHBnj4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727720308; c=relaxed/simple;
	bh=wRZ0dcm18ltYFxDEjyQc1ZWvsDXM6RHSS2gBLZZmkGM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCR9w/DsMnq0ltLKM+qqMceabqwgBz1lIMHPr3Z/q+rGMN3CWeY8KAiXjX0Mes0Lu2oPG4X58zpngZSG99v2/ZkF3XJQmrNob07G7DG8sLHofnjAyUsTERVUJ9rtU5flMHGAhfdVwdQDMlU22fQDY5hFisAQ6mhIViOmz8giXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RaBp/pHi; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20b01da232aso33326295ad.1;
        Mon, 30 Sep 2024 11:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727720305; x=1728325105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BdVmeNRSv6z/zhziXGJ7efQoC2ttjD5fXlH4Tzq2dn8=;
        b=RaBp/pHiLvq3UuyqWI0FpMANVVAyHqlX/Va/rj+JAJBfvveBwv8hFx70J/9l4TA3Pv
         PN8mpgK+d/ylGASgJoLCPy0cvc0BTAFmcQVCePH0tkXymPV9kM9LztTZqg5tiQHsak3h
         KeAz77BQFD4Q8PM6keQ0Zp6ARNDjGbEnTZGKOfEbBmMxj+TraCO1bRKnoZw5bVOdGhQ/
         F96ycUsgTUfKR/OVLcQpRKPjCQgX1+uzTnPsY4m5a0vjXxzEYaf/qDJCxeyFDMK0QQMl
         Mn6QsevsATmsxGmNReT603PJXpQc5O42iqpBZlWlH8dei5edroazWNRbRUamT3mNZcnT
         mCsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727720305; x=1728325105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdVmeNRSv6z/zhziXGJ7efQoC2ttjD5fXlH4Tzq2dn8=;
        b=LklsLLWCst4Vhs3WcnleESdgsGlqCGDGJgWv/0n79Bd6M09GVOAAqN5JSzzezMwDcU
         j4dA22bxN+NxuIRH9iW+njqlnPjXJi8L8irk4bCTLf0Bljr1SA+nysp2f8YOoJnc7Bgw
         NcDSEc4XReu7aXDDPHcborIxZkAG/vy1k8sHQV52rsZzUFRf1AmFhv7Bg8TZG9Afougo
         LQWTLitP1bNZuuHfJgRUQn0myrdr06NSWOZlgkX56ziK2XrYVeXImKUteif4YFcdpKkI
         ZPEEKb03SpAE6DnH0pJ5oMmEmaBRvfJyhNkLAvv8RXRc1/Kur9OlQ0SAL/X5uRqDDfvM
         W+iw==
X-Forwarded-Encrypted: i=1; AJvYcCUfjd+tXsqrrevlHuhIMiLKXy7Sckw6eE4y5EZLNpBQKFxjnJ1JKoF4XApdxWAk3rjSSOv6nYyLa41LnSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG+B0kvtWZt9yQx8ldJ1WuFYbxVcL1JCUrTq3kFsnKm3+61t/F
	WEUyzqn9R7g8wv5GSJbguzDYPJPMZr4FVCsKHyepUH8jRMujxbSkPiQcG3M2
X-Google-Smtp-Source: AGHT+IE+oLjcV1NX5aulYvGEYud3TghW+BSKm5pXy0vrnj6VW3joJZAaLAedIuZsJXuvZdBxka9iQQ==
X-Received: by 2002:a17:902:ecc2:b0:20b:831f:e905 with SMTP id d9443c01a7336-20ba9eccc71mr7426885ad.12.1727720305327;
        Mon, 30 Sep 2024 11:18:25 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20b37db029csm57444365ad.106.2024.09.30.11.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 11:18:24 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: [PATCH net-next 0/5] net: ag71xx: small cleanups
Date: Mon, 30 Sep 2024 11:18:18 -0700
Message-ID: <20240930181823.288892-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

More devm and some loose ends.

Rosen Penev (5):
  net: ag71xx: use devm_ioremap_resource
  net: ag71xx: use some dev_err_probe
  net: ag71xx: remove platform_set_drvdata
  net: ag71xx: replace INIT_LIST_HEAD
  net: ag71xx: move assignment into main loop

 drivers/net/ethernet/atheros/ag71xx.c | 37 ++++++++++-----------------
 1 file changed, 14 insertions(+), 23 deletions(-)

-- 
2.46.2


