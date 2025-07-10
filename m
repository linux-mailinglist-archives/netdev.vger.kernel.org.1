Return-Path: <netdev+bounces-205939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D317B00DF7
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 23:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E74DA581E5C
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 21:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEA22749E4;
	Thu, 10 Jul 2025 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bfli38AP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3671E520B
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752183617; cv=none; b=b3mdNP124ok9uk8ys6Mj/U7NDZxrt9XTvyMS6OqN7S4iBdQbt0qzKgbVvbh50UywH8DyuXyOrCjg+K1Lqw3JT1msJ+6qsXUERdmiBFJNY8XezPPnY3YNs95xbcbQw9C+R7VrsNDkW7O3wkBGE/OoNv2PX0/og6xgZE32f213VKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752183617; c=relaxed/simple;
	bh=sYq/ATlHPYRZVJdh1YeFTnoGYByyhM+mSL/Qo7Xm9yw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wt7nYluCLoM+isBTuz73M+uOb6KNxDCm2Yb2GY7UhN1vcAcZgQFsDj/5QO/eF1NaXFUQJDc6AV8aIOIMEYk4893UxYOS431u7oQTbhpmFgmVK7P90HWwWIsQUzIIDjRA4kWEnRjsijW28+ORGjiiIlp0vCFCLuSVB5fmOJBdXV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bfli38AP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-313eeb77b1fso1374530a91.1
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 14:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1752183614; x=1752788414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fb1JcEcQJCXD4IaYIO26+EzuQdQT87yeWYpc0OwKlzM=;
        b=bfli38APX9w3fLu/pSRm+6vtiMRjAsJDblbgELPHdMN2UVmZjiHRJ5+MonqKZjp/R4
         xIcbLJTfzhhfwhXaSWPZef4f3Qbl8dS4DHFYi4Ss5NrD/kBWh0jOkhmg/8BZytihoXZT
         +QbTTTJuEVQBvs336O8aqiR3kEscOXSOnbU3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752183614; x=1752788414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fb1JcEcQJCXD4IaYIO26+EzuQdQT87yeWYpc0OwKlzM=;
        b=By7aBkjktqOqcCdbrAZX2pczbHunKqrqKp+ArVdTDI5s3bxoZgusQZwMH2cljkCT8D
         IKtshETswrcXhtqVS79y2yXxOkC4t1+pbASAwaS8d7mkB6pQSWg3DovyKac1NMzHuYKk
         DQYVQwgjvgolrY9oFyaa3MoZcm1zQqYtH9ZKz9CIZouofpZXWK5VRGMj+CnttX1IsGUC
         bArJ5VncP+u1LpyJpmbf87DZrL2EsJCJzw1ir04vVQ+emnoP2Xbc98cwHWQYcKKsRh/f
         FK4a1JzXxQdRtjytEQF0LtZpDIBhDpfLiNoFo+0GD76BcBByM0yVY22qm7JrBrYd+5yV
         cFIg==
X-Gm-Message-State: AOJu0YwdXKgmRXP1S/NeKprYQvZIHSEi5mxEr6H+jvOEcdmpOEQ5lUEW
	MWOpTJMEctuvb3rOFJdZoGtaaqZys6lrBkkEYQfypGIKeB2VeOgYYo8LlWp1UYeZHQ==
X-Gm-Gg: ASbGncujuHvSCbb+8Jyip63T4smGl5F1ke/Ls0u21jCrmaqRDDtr2aIrQ6eVe4fD9Uw
	cs3xVV66uYCKrznEY1h+yQZAsy7/O/hKgdeuLFK2DVBVZcZu7c6Ns+YYKZMi89cZ6yrvMbZ+w59
	XOiCiSQkqVZJpy1YQEL4ulg0zADt0V1eAspCkeF2GqJEKNtNl85rUA3TnJEknzYNIx+GG6GmzaU
	QORomck8pRdtfqfSGGwPbuMdjOsoT5XjjlAxW5hlf79nIBEDpclssZpuakUgDaTArIq+pSJJoi+
	pMHCegSx6DZI6ZnmrDt2NOx4enTO5jdZPcMqpIQ64/jaawu+XDXNZ+QjQ/sdhtbTa5Njip9wWwX
	hJGsfxS6WTryVnFOdIykJoghTRi7+MNZ1cihg0w==
X-Google-Smtp-Source: AGHT+IGhZ5ODTMfiNEjDEERzCX5j96+0DzhhXS8RuYfWae8Bxlh60KDS+gtN4iQf+hB/u6m/PVyiTQ==
X-Received: by 2002:a17:90b:1d84:b0:312:def0:e2dc with SMTP id 98e67ed59e1d1-31c4f49ea8amr246592a91.7.1752183614438;
        Thu, 10 Jul 2025 14:40:14 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3e9581d8sm3358208a91.6.2025.07.10.14.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:40:14 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/3] bnxt_en: 3 bug fixes
Date: Thu, 10 Jul 2025 14:39:35 -0700
Message-ID: <20250710213938.1959625-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first one fixes a possible failure when setting DCB ETS.  The
second one fixes the ethtool coredump (-W 2) not containing all the FW
traces.  The third one fixes the DMA unmap length when transmitting
XDP_REDIRECT packets.

Shravya KN (1):
  bnxt_en: Fix DCB ETS validation

Shruti Parab (1):
  bnxt_en: Flush FW trace before copying to the coredump

Somnath Kotur (1):
  bnxt_en: Set DMA unmap len correctly for XDP_REDIRECT

 .../net/ethernet/broadcom/bnxt/bnxt_coredump.c | 18 +++++++++++-------
 drivers/net/ethernet/broadcom/bnxt/bnxt_dcb.c  |  2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c  |  2 +-
 3 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.30.1


