Return-Path: <netdev+bounces-246066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD4DCDE0B6
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 19:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 16B90300940B
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 18:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0CB266B72;
	Thu, 25 Dec 2025 18:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d5nmP5I5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D02634CDD
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 18:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766688953; cv=none; b=VJUkzucxmKoZ5Mcj4eQw2L+Kk5TFePGGt972ZbZzb5qC9q0dNEvUb+XxUjBQX62U3kg7zE0zVWvvUMk4nbBrUROpZx1snMA/R78EwUPKt9Hn5VMhoF/TR9ugLed0fsSdakBDthB+N8oo1gnG9wqkJni2q3Ij/IjssnqlPPIvlsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766688953; c=relaxed/simple;
	bh=Wphvw0z1Ex7aZGjyRHayCfQWSM1WYoBXehAxery+yYg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSXhAstDFbsHyAFJUvS+8mFmEmD+2gQKnXIrlTg4CVR70HgrBZiwYi84bjqihcsm7SFo6JcbuEqAV8uQSFoSNdiLQmBNXoQGg/dALNsxwxR4AAexyfYZoppJV40zYeIbpHqezF31JbXwLgGMx/6CWb5DWHIelQnqEHchU0HmTNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d5nmP5I5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-595819064cdso10871889e87.0
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 10:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766688950; x=1767293750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EHqbsSuY3l0hoFQxIvjFiLAZ1GUEsVxDZU1QG/baXzY=;
        b=d5nmP5I5v3Xw9hzBzb9gHct2IWUt+kS2T9JKutPCdSEV/yssVEnZ8AuUaJJRmm9wFG
         9Qi/DYzRZ69V+3SBT2Gv1rhXgqn97Vne1+PTPPBftwtN6nZinJN8/aC0x74XyooMwDdk
         GxYYl9S/rFvCPK7JZgbJ49w2ja9hczhIMok0eaQfCFQwDd7q5U14iMQXsgEhUVLkIAT9
         ln1yce5sXvSVfP3IKgJDoexkbqErS6FKqt2EY6IeWlN5GzcqxQ8vMdwvovkTdHNtlCEG
         saYCfzqFaw0WmVVLq1c4Sinaq5lhxegiLIspw01+5aN2pYSWSaXx2t77WyMdFlRfuR6I
         ikcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766688950; x=1767293750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EHqbsSuY3l0hoFQxIvjFiLAZ1GUEsVxDZU1QG/baXzY=;
        b=v9lywhpz4O8pqVdw39uT9CGV8Tb99Ho8hH989HxzDWucR2O7Q2919OKWD8H0y3WOik
         3Llxw/DsIrZfQCJrBi8sKlA1rhlU8bvg+DyDftPAW1pEN+/HC87d/jxp/syN1kl0qpLX
         SQS/7cscmaIhBmD/9ljZrFHI6+8m+zomWZYJybXMYyuc2HZg9n+WvjJEL/HGJ5b4qSkg
         aj+RMvcyoiyq6n4Lf1ODv2L8O9ceywEfj25jGtIRxzZuslK2EHgwxC+dEfgYfuLXqEiF
         K93bgA6pZ9+nvt89zzo/qTtKKoKR9slSq5wQGXUfQvH3T1PRTEktVTLOPHxDMu/SxEjK
         SWvw==
X-Gm-Message-State: AOJu0YxkNxmj3RQ28rNcPIko+8TQtrlkDuJMEod+QUKs5yI3mjMEhTJt
	DZJtqPxA7eQ9zGjVF5ajpS2GgJtY9Z6gjThA04UBp5mIKdidQMRN1MVtQYRAEUs6WDY=
X-Gm-Gg: AY/fxX7JlClhDSbo8SjZpu/7lHItXva+RLMSY978NhFNnZM7AXbGu+DM4Joz2Ko/8hg
	OiLTyKoWfHFohnap/7MoaKoUVNtbS2GA+ZBMqQddjj6EW2fyxaM9iM2sx7Q5YwuloB+tBAI0HxU
	6F/6L7Zpr1Q7cAjtQefnMryzQgKCytfmnSWU999Ks/5xV2Zkt5DO+IshdhBuPCCaavjG80ozdBv
	Voe4ZEn7NgGlTkNp2OJn5UdUllc/+USiScTr1Ol5t4p7Mn1giLG2z6qBG5KRCvlLi59cx91Ou1m
	kLREl8/Jaur4vtJxqA1mEPzYlzaoock2xX+iZpfTnVYQPF+zw6ZhO7w6urIN1QTqmNIzXjrBUFp
	ZBeKWZkDJQCkPpbiw9WDJCInj9oIx5cARVAmA+t1uMdlOF/lNlFcCCnw5y1xT4Q5siKosbhzVQs
	YqbYaCZLzI2KWF9GY49p4Cy8kVsiIMXymW+XQKYIxS5Xqe0FShHaxvG5kUhZ42+s3D3VTayCvAm
	nVH2g==
X-Google-Smtp-Source: AGHT+IHkdwrkbM2HMh4GrBt+YDazmY/VbZ3BAKixHkK4Tj+V8jzvrHlZDCTvW5Bt4vDo2V07vUGdNg==
X-Received: by 2002:a05:6512:1587:b0:598:f6a5:2d5c with SMTP id 2adb3069b0e04-59a126f6dd1mr8150982e87.26.1766688949509;
        Thu, 25 Dec 2025 10:55:49 -0800 (PST)
Received: from huawei-System-Product-Name.. ([159.138.216.22])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185ddd78sm6057675e87.39.2025.12.25.10.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 10:55:49 -0800 (PST)
From: Dmitry Skorodumov <dskr99@gmail.com>
X-Google-Original-From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: netdev@vger.kernel.org
Cc: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Subject: [PATCH v3 net 0/2] ipvlan: addrs_lock made per port
Date: Thu, 25 Dec 2025 21:55:32 +0300
Message-ID: <20251225185543.1459044-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

First patch fixes a rather minor issues that sometimes
ipvlan-addrs are modified without lock (because
for IPv6 addr can be sometimes added without RTNL)

diff from v2:
- Added a small self-test
- added early return in ipvlan_find_addr()
- the iterations over ipvlans in ipvlan_addr_busy()
must be protected by RCU
- Added simple self-test. I haven't invented anything
more sophisticated that this.

Dmitry Skorodumov (2):
  ipvlan: Make the addrs_lock be per port
  selftests: net: simple selftest for ipvtap

 drivers/net/ipvlan/ipvlan.h                |   2 +-
 drivers/net/ipvlan/ipvlan_core.c           |  16 +-
 drivers/net/ipvlan/ipvlan_main.c           |  49 +++---
 tools/testing/selftests/net/Makefile       |   1 +
 tools/testing/selftests/net/config         |   2 +
 tools/testing/selftests/net/ipvtap_test.sh | 167 +++++++++++++++++++++
 6 files changed, 207 insertions(+), 30 deletions(-)
 create mode 100755 tools/testing/selftests/net/ipvtap_test.sh

-- 
2.43.0


