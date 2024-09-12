Return-Path: <netdev+bounces-127640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B70A8975F24
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 04:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78EAE28567A
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 02:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC55524D7;
	Thu, 12 Sep 2024 02:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEBW6Fut"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38AE81E4A2;
	Thu, 12 Sep 2024 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726109348; cv=none; b=TboeKrZ4/XH/ElG1c/lgfGcxpPdBbefWsMhLR6HhMuT4zg1bvrQKGU/ien/VgaHCaJl+Rxii4LbwMWxfV7XI4QrD1mPwd/LBclA8DXdKsJhgSU5y4llLNWfwUiT8svJwlwFJXByrMQs5fLwEwUCXedqs2WqTg/dVZKdiTxuMRn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726109348; c=relaxed/simple;
	bh=tAM95XGTzbapPftXsftKEV3TNf2Al+BWzAnhD70VsNM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TA4/LkM0M8ILD7lFXNPgHtGoNVIvF1zfw+iZSKC0XQMnKwgqT2ZWnYwX+RYZk0UAlV6dOMHMQNP35UA0v9wLuUXJUsQ5fNEEOPs1yy3sDtY0SZL5pQlk2yV5vBRpEOzivxg1zwJRIiFLWskn4nZLBXP7l/uLbu3C/DOIW/tYCh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEBW6Fut; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2053f6b8201so4559105ad.2;
        Wed, 11 Sep 2024 19:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726109346; x=1726714146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fkjJuBXsGdganvltri3POVXvXTvnOSAc4m3VYvsJR4=;
        b=IEBW6FutdzjfPwYLleEUxLDfaqqDIHMUVN+pEQ3pO0c2KU6duOeio79jgN9R12LTHl
         /1UolEGhtOt9RoKLhByVmMkBpDJFkr7hHpE98jd+xaJH1g6J2g+0stewARv2SwxjB+s7
         34ZN153oCoWvrgdIKjdAmn/Nir0YAMuR3gltJRMfdQQ/26puvEE/Z4iLqjBRPxlaWw5d
         shijYlWWkCi50PgfiEkRV/FOke4gCNeS1RWd4xoDM1KYgIyoQjIUQADIyKm+1mFNlV3+
         QYI9nrq7oq2pEVUe0C+Rv0bA8adEggxoix79JM9SVaTTK67pGWZ2ACqptCC+rCvsnB7U
         0IPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726109346; x=1726714146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fkjJuBXsGdganvltri3POVXvXTvnOSAc4m3VYvsJR4=;
        b=JkLyhkPj1SqwcnmH0M1XQ5iFypkA6AHI2Di90ATOAEuSKvfLlgmFoSgVzMQ7pmnfPd
         i4xK7ILyZUQejWfJw8UuFVrH/6foXr9eQzEpZEEDVWrYzUZ7E3dRh7sCSK6AsYQQWp5I
         /2vmSE1x47YA5hM3z7fNpqXVDRAhm0irik3XW8ae/BnhHzNDdO6fF7D18qUCVCin9PFr
         AMDejOLTzSNfBoVKpUz17miHj2t154SbHzv6CQzrUyV40qpteUPYicDh2D8zRjlUzYeK
         6ZkJE6aZEk1hqHS6D2KLKXkvJGcZRVUeDDdW1ql91mm/zMxmJGekUtDGaTAwStO11KT6
         gXhw==
X-Forwarded-Encrypted: i=1; AJvYcCXUucwB2BgO9qU1l2mjfZHTFnw/6Oc7HUqxmpts65xQYd9hOIhlijm4FDx9s6fDlmoSDee1WUJquAMI/Mw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmAXdep/5CGEWH/YhcTB4XSZEsTFYOrWoFcyN/S9MLV+vN+FZw
	twxicf8wjQqd1YwKAVR/5u7/WZT7KzFAcy6xl0uSrDEw5FJHkkkyj+/EGNA6
X-Google-Smtp-Source: AGHT+IHA8DfiFFRviUD4f3bxvHEivYR9Io0vIEajbxKVVrUJBB58GqHng4vf8V7gdxeBA4alu50lFw==
X-Received: by 2002:a17:90b:4b45:b0:2da:5347:b0fa with SMTP id 98e67ed59e1d1-2db9ffb137dmr1703060a91.18.1726109346308;
        Wed, 11 Sep 2024 19:49:06 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dadbfe4897sm11457868a91.7.2024.09.11.19.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 19:49:05 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCHv5 net-next 0/9] net: ibm: emac: modernize a bit
Date: Wed, 11 Sep 2024 19:48:54 -0700
Message-ID: <20240912024903.6201-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v2: removed the waiting code in favor of EPROBE_DEFER.
v3: reverse xmas order fix, unnecessary assignment fix, wrong usage of
EPROBE_DEFER fix.
v4: fixed line length warnings and unused goto.
v5: Add back accidentally left out commit

Rosen Penev (9):
  net: ibm: emac: use devm for alloc_etherdev
  net: ibm: emac: manage emac_irq with devm
  net: ibm: emac: use devm for of_iomap
  net: ibm: emac: remove mii_bus with devm
  net: ibm: emac: use devm for register_netdev
  net: ibm: emac: use netdev's phydev directly
  net: ibm: emac: replace of_get_property
  net: ibm: emac: remove all waiting code
  net: ibm: emac: get rid of wol_irq

 drivers/net/ethernet/ibm/emac/core.c | 219 +++++++++------------------
 drivers/net/ethernet/ibm/emac/core.h |   4 -
 2 files changed, 71 insertions(+), 152 deletions(-)

-- 
2.46.0


