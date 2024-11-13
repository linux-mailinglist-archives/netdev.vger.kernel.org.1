Return-Path: <netdev+bounces-144561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6A79C7C88
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 21:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B1A4B26807
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 20:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BA7205E22;
	Wed, 13 Nov 2024 20:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJNGa8QR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B868E201023;
	Wed, 13 Nov 2024 20:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731528013; cv=none; b=sh9A72xbktEXDEvxf59vkI8SGT7mD+MPrmlpnjkRy/eVRiNs6KAgpA8mFxEqGDpyb/6casr/fJtG3aJQnoYycc0fB52JHykOIdJTKpMQ6OCx6+4062idhJ68K1M4XuFC3AQLMnUqDxGnP8+nHXJTYAdMaEy+f6/kgw0tMTh7KlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731528013; c=relaxed/simple;
	bh=EGx+hjepWkuT0xz+vGvitPo8qWrAe03/rl5d8mdP7Fs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SiH2A3CJ6gj64KpRit31i9TEG+sUbAzwVvVCiM+d74vTRCDa2YObs4POjN9S+oizM9blD26OxReVNzRJBudlDZCjGB74y5XhIY3VJtV4SGwkoFfgo6znQswu0/ih6M7pwXEXCsgX9DdemNUQ74fLr3T9RC76EcLhe/3Ze05PN1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJNGa8QR; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2fb51e00c05so89200391fa.0;
        Wed, 13 Nov 2024 12:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731528009; x=1732132809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=em7pHCK+pfXfvbFznPRzYFPWaZYrbemxeG25K25rgkI=;
        b=GJNGa8QRcl7GSPbyy+rE3tdRNuxbqMdGVpt3znHIF7N1BN+UOruBIRubFtHAEWMaEf
         Dv3Gb57JDzikqBREAr8hFPyJDPyENp5mSE0CUaK9B1MdAwS+pGwLLoL/qKKtQdaYxD6b
         gtjZ1MJ14QEIw7SBD3zMTYPHT+U/K4JRt9VXFyAKwwYOjQuxhDrWmSIl/UnNuJuRarym
         l8y2AxAzpotP+zNXfqEtTOg1d9U/F4ckXaGjvG0aBFl1FgB2Hk4J3FHJMdxMtE9W6CtF
         45fWHhrehyB0KZLgzT3GhO/pDlGf8qx6kVnwDOhVo15u0KoDDG5zP1tKSL/uNu2X6TFi
         uOtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731528009; x=1732132809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=em7pHCK+pfXfvbFznPRzYFPWaZYrbemxeG25K25rgkI=;
        b=FSbYqoooPfD9lKEG6iuR/cYjAgfF5ZC8baQIoj++zrI8sMpxNeYko1pLSAm9Btsq5E
         aQqmzGLtyW1xGnnsMagdTlEOUkCDr1fRt5HMbGEo4a2gq1JfsWskzcUIcVw0tqi21ACb
         SyFdbqzNUnX0PsAjOUNclZDqX9jfkuxCrsf9zFMQukL9zkGjWyUxJZUXpkc8TdD43OD5
         YlTmFLjX5GPDHSGaWb/b7A84eKM5VVH0slcI971XLfJdPJeoELKes0YMKc18+cGW7Hmp
         yCewzRmotZd63N8al8C2zQYBWXojpxusq3YOHs+QI2k+2W9cyLbMThQ4WkZkD5RuWWBY
         KxVg==
X-Forwarded-Encrypted: i=1; AJvYcCUScKAbEzZRD5xafBSZwW2zx7VJUDt2jtJOzDmfM1IxDLy/lGO8BzMdclDrwGx3ztJSy1eMLh29GJKV9sg=@vger.kernel.org, AJvYcCVmT64AyEBpt6EsiQr+VdLPbq0AliOEY5b4mLK2dBkvoBIhfEkpL1DYU3xpLhMdOnc5o7yBI8tp@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt5C6s1uoXYA8o8JVd19lm221/oeOPyjLI15MSeVupPLDWzphh
	Q7PnTssoqh37TL838v/3Cbp5ZvDTJOWoVzNYR3qonMzRcxr0qCvX
X-Google-Smtp-Source: AGHT+IFIr+9bphzpHBCHYHAZPRqIIE4QXTnnSbNM5YE2iObMcXLGKrcV/mvHC6/+4+fRCGdf1mUTSA==
X-Received: by 2002:a2e:b896:0:b0:2fa:fdd1:be23 with SMTP id 38308e7fff4ca-2ff2028aadamr164679381fa.28.1731528008380;
        Wed, 13 Nov 2024 12:00:08 -0800 (PST)
Received: from rex.hwlab.vusec.net (lab-4.lab.cs.vu.nl. [192.33.36.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9efd2fe9fdsm675016066b.132.2024.11.13.12.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 12:00:07 -0800 (PST)
From: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
To: Ronak Doshi <ronak.doshi@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andy King <acking@vmware.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
	Raphael Isemann <teemperor@gmail.com>
Subject: [PATCH 0/2] vmxnet3: Fix inconsistent DMA accesses
Date: Wed, 13 Nov 2024 20:59:59 +0100
Message-Id: <20241113200001.3567479-1-bjohannesmeyer@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

We found hundreds of inconsistent DMA accesses in the VMXNET3 driver. This
patch series aims to fix them. (For a nice summary of the rules around
accessing streaming DMA --- which, if violated, result in inconsistent
accesses --- see Figure 4a of this paper [0]).

The inconsistent accesses occur because the `adapter` object is mapped into
streaming DMA. However, when it is mapped into streaming DMA, it is then
"owned" by the device. Hence, any access to `adapter` thereafter, if not
preceded by a CPU-synchronization operation (e.g.,
`dma_sync_single_for_cpu()`), may cause unexpected hardware behaviors.

This patch series consists of two patches:
- Patch 1 adds synchronization operations into `vmxnet3_probe_device()`, to
  mitigate the inconsistent accesses when `adapter` is initialized.
However, this unfortunately does not mitigate all inconsistent accesses to
it, because `adapter` is accessed elsewhere in the driver without proper
synchronization.
- Patch 2 removes `adapter` from streaming DMA, which entirely mitigates
  the inconsistent accesses to it. It is not clear to me why `adapter` was
mapped into DMA in the first place (in [1]), because it seems that before
[1], it was not mapped into DMA. (However, I am not very familiar with the
VMXNET3 internals, so someone is welcome to correct me here). Alternatively
--- if `adapter` should indeed remain mapped in DMA --- then
synchronization operations should be added throughout the driver code (as
Patch 1 begins to do).

[0] Link: https://www.usenix.org/system/files/sec21-bai.pdf
[1] commit b0eb57cb97e7837ebb746404c2c58c6f536f23fa ("VMXNET3: Add support
for virtual IOMMU")

Brian Johannesmeyer (2):
  vmxnet3: Fix inconsistent DMA accesses in vmxnet3_probe_device()
  vmxnet3: Remove adapter from DMA region

 drivers/net/vmxnet3/vmxnet3_drv.c | 17 ++---------------
 drivers/net/vmxnet3/vmxnet3_int.h |  1 -
 2 files changed, 2 insertions(+), 16 deletions(-)

-- 
2.34.1


