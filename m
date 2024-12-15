Return-Path: <netdev+bounces-152013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF469F2622
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A65B188546B
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EFC1925AE;
	Sun, 15 Dec 2024 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PdXyb41s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2B1A47
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734296426; cv=none; b=ZevuD+ty8PE6gHpG4r5fOQYtmyTGfllk4Lm32mZjnXTCGbDxS57R4gHkdx7/bP9CoExD6nxBJ5kpoNeQPGZ4+pModJH+jVDx7fDkGb07I8Ut0jn77ncdveOKsBl2RwhUV7dj/r3QqNg2h+kcrIQcWWHTTqjB6AXGWMq9otsYt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734296426; c=relaxed/simple;
	bh=jjO23OB3IzzduRquc/FuvDkCyj5dyzfmEE2op3JJvNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K0b0NOCDrueEbJRVsDrulCfMEZmpcYI6FmEwNBvER3A4xhiMVjZSK/d3qFK+jnwtsy2zU6aQSodRm1K+DnK1Uy3/wfeK3xGukn1UXp4fgmHacqg2jw5hi8+TSMTxsI7Dk7mMPJl+UPFdmQUbyoUNYqzH64cKE6Ufy0Ze7qzkD4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PdXyb41s; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fd4998b0dbso2768109a12.0
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 13:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734296424; x=1734901224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gpD5FksS9WK6d8J5e7+mcUY0sjsB+le13mUuJdjpKFM=;
        b=PdXyb41sH/2SaBNCPfnKzHOPH7xK+QhejP8qp8bXkK+2TwZzv8nwKF4Kbfv/TUOZtR
         CMZyM2LOF7lQNLbyb4WNq9mc7BMztuqP60J/O33QmHwJY6pauP2w2FGcHwlmdYBdyV9J
         zcboswlyEzKUOba9z93JGm8wpa4tZ0L0/l+rI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734296424; x=1734901224;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gpD5FksS9WK6d8J5e7+mcUY0sjsB+le13mUuJdjpKFM=;
        b=MzeGVnoveN57NNauFNED0gmPBaR6L9JaRNL632yvpiAdNr2tPh3YdlYtB8dPUUnQuz
         /DxhPr4aPgUxw7PQYYam9YQVDP2MtvbSAI1nbHZMwqkfvD8w3XlseBfdmeVXrWvUdo1V
         aeLBpKJ8rRLA7sTBCL44Ws63uQUAgux+Yh2aiiPCou8oN6q2uPMNY/wywTKjCBrV1KHb
         QsnPtiwBhfh81xPWldSwv4uOJwYjcZT4RD6sbxSN47WYfm+JPnnglv6uc53b4wItXCat
         C9Lgi1JzwOmvCtaIPPU75j9SeVZY8YhO3HMUzB0jKrmPjm/dMaqU1/lAqPB/siv8k6hf
         qSxg==
X-Gm-Message-State: AOJu0YwmHTsksSj11UXd6Ydx7tcbuHxk4HX9d9PVYivyeHpkCBoSQ9mf
	Sr4mjrVTYxxPte0pCfv+JYAfvcMxjARv4tD0DrLeBa/qpU0leHq+o4ycTzGRww==
X-Gm-Gg: ASbGncu1MzpJh5LY5NS6q3ipGZ+d9M3TfUqvw+tLPiux3f2YebC6SC7LCtBrVzywz3P
	i8Dv5ZZJiirVjNs/aRbtvNmAJVaYvCYfo1EvVGRnhL1tHXmHmi/72yuCywT46KbGVwobwrsINfv
	2eLo9drE3S5QVVQkebVIna3JB2TcDRC6zRUoUMvOR/HDqpU5FEIIZYx7O3yM/Wlp1zVfKKKR0by
	CnITusQ0aurWKZfLWScay2NwwPRTOvUUQ1c70lKYRiGhTdTh/zxxysGR3caaa+JT4QIlPC+9qmG
	9C509d4QVRH+VvbYpeO7Kv4HoeqT0vgz
X-Google-Smtp-Source: AGHT+IEgDEnCZ6VxWPw//k9uqzMETcpIkIQAxOW5ShtHvdKtATydYQ03zsjo+zArMHAyesgsbZ2LGQ==
X-Received: by 2002:a17:90b:4a0a:b0:2ee:3cc1:793e with SMTP id 98e67ed59e1d1-2f2903a2d1cmr13277508a91.32.1734296424024;
        Sun, 15 Dec 2024 13:00:24 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc308csm6682717a91.50.2024.12.15.13.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 13:00:23 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 0/6] bnxt_en: Driver update
Date: Sun, 15 Dec 2024 12:59:37 -0800
Message-ID: <20241215205943.2341612-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch configures context memory for RoCE resources based
on FW limits.  The next 4 patches restrict certain ethtool
operations when they are not supported.  The last patch adds Pavan
Chebbi as co-maintainer of the driver.

Hongguang Gao (1):
  bnxt_en: Use FW defined resource limits for RoCE

Michael Chan (5):
  bnxt_en: Do not allow ethtool -m on an untrusted VF
  bnxt_en: Skip PHY loopback ethtool selftest if unsupported by FW
  bnxt_en: Skip MAC loopback selftest if it is unsupported by FW
  bnxt_en: Skip reading PXP registers during ethtool -d if unsupported
  MAINTAINERS: bnxt_en: Add Pavan Chebbi as co-maintainer

 MAINTAINERS                                   |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 74 ++++++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 13 ++++
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 41 +++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  2 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |  2 +
 6 files changed, 110 insertions(+), 23 deletions(-)

-- 
2.30.1


