Return-Path: <netdev+bounces-197666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 127CEAD9893
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0BC717AD68
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575B828D85A;
	Fri, 13 Jun 2025 23:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Su6NoXwl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06202E11AE
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 23:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856788; cv=none; b=YPM12SbEzO0PEXXe091SRYAI2+fzeY0eLgPi6sbzKFqLtUmLnfE4E/ZM2TnfZEGY1C6iqgPrZP6i7OvTq7X0I7zX3tAQvfEGVEYQdbU3WIT08xd0CENUOTJfpUX9J+qKfvCbdpdKE4z9HL5XnIHhK1IX0DYJkGJj1SRT6AcJkNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856788; c=relaxed/simple;
	bh=PBMk4v+MABNb25XOc4UU9r2Sor9YdcCBQiqjI1u7RK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m4JGK7LcQ/Wg3MWN7+XD39QvMUhY2A+A7IsHKjd3Nrw94NB0SNl4BMIGKs7jkA/pmbnVKcn1S7yR0qPpgmM3SxEsnHOnqxKMFR6u6ddal+E/AYkIcWkIioRiWeXkkO/6G5A/FitiabvdbWjDtvkazOI43CF+abH054wL2AkcgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Su6NoXwl; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3139027b825so1917845a91.0
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749856786; x=1750461586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eNTdkQvhDh9SZXRamvxZ5ihCkLPHbC2WTDKqW+zh64s=;
        b=Su6NoXwl4erQ9MZ0hOXOuFm95qxNu3BJVjg3U+tDiDtH2GMlQMsRKesMWqPmkyKzr5
         GP4NKR2Rvb3ZI2i7DWq/ansj2hRPMd/EVB2JnKtpriJOi7vgPQYuKPXunwA77H7lWsQO
         b41V1oJF4R7UfoGSSUo6QpOSZb7DmuzPjR+Wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749856786; x=1750461586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eNTdkQvhDh9SZXRamvxZ5ihCkLPHbC2WTDKqW+zh64s=;
        b=R0ex/epNZYeKk5YQfar3kFHp1naHvLoUD5ZNEplHQ9kOz9OlKkwRac/z5/Zus41afK
         xDNnSnujtFeESmhQLe8P7pf4gWwHNkFLFIIFHQjgA3RxYHxakZHT7Ew6aRm4EqD8an5y
         ZgWnmrKJ6Jk9sHZwbhvgnp4li/HVM14CIXwi5Kl9td05SYZQEkZmcKe9Usa0in2SI+OH
         SUY0DdEtOfG8TarGmRtDMM7XWSWQ6znqLrCpkMPI6/25II2UTtEnev0ihgaZdO8k3Gmu
         mAWT8igEu5lqJXF+aRYt5P56DhNFg5evJ/klPmSuKjUHAghdwUq68WDiXJUoOSEPLzFT
         ibGA==
X-Gm-Message-State: AOJu0Yxxi6OyqDI3XFvDh0VCNXJocPi7Ep0beB6oGAQhy5LGiLrTW2Da
	QU2msnOGdxqlST7hEx+XmBFBTm45b/gkA0XAjmPTdfdfWUwjcF+MzMDaB/4MW+ZYvg==
X-Gm-Gg: ASbGncu2SRAinnrel5YFE9FL6s69/Bnx9rnWtjoYBKjACBEI44GWxbj5O6Q8CTdPVK7
	0HDyU8CGrWsdJSxqKhSKChlqVOCp3WOdveXkTitU7Rlh2Nlur9Oq27kVU/6+KGowYHxTwMGWwHu
	d1PouFwFh8PGj6n0h8T1uxVGyFEhtJ1KAKmF0AhQXRs4B7l2EWRcm7GrH5/jsm19DFXr+Biw3Fg
	K5GdVYfcyXV64lM8e8lLrN3QqdaGtNLiv1PoYCWoVwgV4zjYp7FAFt2vNAVDp42c4jIUksRq6Cg
	6Uj+xk+UM5UDWf4VoRXjeLtxOWDzAnzS1tYNc6T1Xdv9HqwKJfd5jUgwPMSd4kTXc411lV1fGVK
	sVU4C4wyzMmB8WXyJvFPHrLtpVirg64V7P0d8yw==
X-Google-Smtp-Source: AGHT+IFUFL8fvRC1VGHAEkolJ56RFEHzKqH9J+QUE0WV2qrowggFB9tutSM++njn4EiU+Xvn7SirNw==
X-Received: by 2002:a17:90b:1cc3:b0:311:d05c:936 with SMTP id 98e67ed59e1d1-313f1daa6a7mr2404136a91.17.1749856785984;
        Fri, 13 Jun 2025 16:19:45 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365de7832asm20165105ad.140.2025.06.13.16.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 16:19:45 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net 0/3] bnxt_en: Bug fixes
Date: Fri, 13 Jun 2025 16:18:38 -0700
Message-ID: <20250613231841.377988-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thie first patch fixes a crash during PCIe AER when the bnxt_re RoCE
driver is loaded.  The second patch is a refactor patch needed by
patch 3.  Patch 3 fixes a packet drop issue if queue restart is done
on a ring belonging to a non-default RSS context.  Patch 2 and 3 are
version 2 that has addressed the v1 issue by reducing the scope of
the traffic disruptions:

https://lore.kernel.org/netdev/CACKFLi=P9xYHVF4h2Ovjd-8DaoyzFAHnY6Y6H+1b7eGq+BQZzA@mail.gmail.com/

Kalesh AP (1):
  bnxt_en: Fix double invocation of bnxt_ulp_stop()/bnxt_ulp_start()

Pavan Chebbi (2):
  bnxt_en: Add a helper function to configure MRU and RSS
  bnxt_en: Update MRU and RSS table of RSS contexts on queue reset

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 87 ++++++++++++++++---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 24 +++--
 2 files changed, 84 insertions(+), 27 deletions(-)

-- 
2.30.1


