Return-Path: <netdev+bounces-246459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 754B5CEC7E3
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 20:25:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BFAE300CBB9
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 19:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83025309DC5;
	Wed, 31 Dec 2025 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="NvyuZTyr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BB62DC35A
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767209113; cv=none; b=oLbjpAdXHg1P1JzMjirwnM8gUhykAg6dPAQEHxvtbhcdY3tHSQViqM3GqbZGrF+muxmFn6500W2yK+VWB0fDPS6UsRH84jAGb/hCvTYpwUCz1l4678CPazXBc3wQyufsOGlcsCmFg/5fmI46aaicCAuI1ZMVHFXgo+w9jSV6zDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767209113; c=relaxed/simple;
	bh=OHhqeIFf57MbMaPf4s+6Np8yQGOgSRZAkLrtpJt1Yes=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=V0bld8YqFBoVvrQ9gkxBfM2ZCdk64qMTHyQlKreK38VtbfUvzpsmT77hoSmQNU2SpwMvAyikiqbR4M1MfwT9ReTaibw08Ac88xohDx6CvDQBcMcCTfUTVzblj9YEIcCViYoEqdlWhU+JXeg170DqZMENV/qIrPujhGWylFoN0yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=NvyuZTyr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-64b7a38f07eso14874525a12.0
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 11:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767209109; x=1767813909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WQvfyx7NYeUmPzZLPw8NgOUAQ2rSJAXwiVOTSPFXMiU=;
        b=NvyuZTyrtA5i7RiBLS2R4oz2kmlceJqXxHBvyKRTaL9uto8cnwr3N65Vj5loHPeG9L
         +kCWmtg7aysLWfDf++oXocNwKN6zaanGR4+kW64uc0P90Rdwd8bnB4FZAOANskR/wnNS
         Gg1oWKiRRHcF5Vz5o8Eb6MljWuSC3mmRQ1gBDvRD4h/fnm63sh6P9CHLqNle4M+0Kcwr
         o2HJ2ht7SXxPAlNwHHcLxYlTpm9AG/DyVZmq89bEdR5B5w+VN5in7kFWsyIFNbiJpoAw
         dvtjjmLcNmR+dr1vLPWbMOlIaqJtVG/OKQxn2koYA6z2tqh0lxqxcuZrSJNsKfFfV2yg
         0RNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767209109; x=1767813909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WQvfyx7NYeUmPzZLPw8NgOUAQ2rSJAXwiVOTSPFXMiU=;
        b=PNfFr8BOVxzdi/bp5eVxds3tpQbWN0rxZtLoRUtnmhWZSqMFMSBDyLCeN8ybe/DKgu
         5ieftmCqvlE3R7U95y3M0npmNelIJKaCTCVI/Wfdn+WXfg19Rsw9rSwwGS9agjRFHc1v
         UEkUVFJi9mpugupxzvlpWMq0+dv6AY1s3GTKgTlX5Ywy/+h/kTm9tEUBAkixYxkvclJz
         f+i3H/hTCL/NY4hzpwJ4Jh8Ea5WkFQ35fdY5NhjzdtHwABm6PBCz2TNz9f0j7jERigkM
         zPQDGhV2r9Ptxp1zc+Kb4NknXLX7ncFDgSA1n5vKhn7ZwpV98el5i+vu6uWIt1WSC8q2
         qPyw==
X-Gm-Message-State: AOJu0YyQeMrDZR/owBeEBwvlTALCBC6p8VJGhDw82k4C7L72szj4lE49
	fIKmCX3+Xsl4345yCU9EhE3VgpDgP4D9MGYHXO5UeXvuz7b+Sm0wSQX/i2OeGRCCZ9DR1VwRcRh
	LaIj4NFzStFxRqBqwz4V6bC2CTdQ9wBZiLnrMCwNxaKaC2tbg7p/ESE3dhal9ccD74AukikIc7Z
	l50lW52wy+wvFvTahApLm/sM9KpEwssKPbvZNmZPX4GFXzT6A=
X-Gm-Gg: AY/fxX5up+cWWrEosCAfqgetY6kprYIG5+8ISMf3i7pvcNuzh9sQ+QN5SEkbosbxKX1
	BTiwSt+FvnWxMDmGoOdZn89mR16N+RRpwysDHWLjvHG6Nx0oOWdeuZnG5iU1K6oy82nh/p80TWj
	mDtqDZioru26qX9wcgbHTelcf+QtuKCOeqDQyvVE9/PPbfbYqHzDgeT7lO0eNUHTdIlMiGtCzTI
	KVO1qGBqzYkJlBNzLuFueHwnWkgmrs4pV5BTsXEY6GF43ZUL+CeKy5Puj7Pe4ppYjRZdKW0qTNV
	QLykCdeyr0cDy9pZHD45v6kCNfgo6EEiBZmCzkWLvBsOfg+G2W874ZYu5MsHHGu+6AAjk9Qtddh
	rEcdnbcPAISQvA7vQZqSytvXVs725P8J3GZYjvl6vqya0YePYDDwMt2pU2oOi8rAawnTQwVUgy/
	OaVmNsWSD2qvHPy/kRaxWKAtVmNLgbHox6LjTe
X-Google-Smtp-Source: AGHT+IGvs3t2Af5+2sv1CIHeyeQhiGJRI7JesHoEwav0TK4Es1FSlmNIoKAjvi1U1zHVkRurxIldQw==
X-Received: by 2002:a17:906:730f:b0:b80:b7f:aa10 with SMTP id a640c23a62f3a-b80371d8c5cmr3973162066b.59.1767209108883;
        Wed, 31 Dec 2025 11:25:08 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f5400bsm38680736a12.4.2025.12.31.11.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 11:25:08 -0800 (PST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v2 0/2] tls: Add TLS 1.3 hardware offload support
Date: Wed, 31 Dec 2025 12:23:20 -0700
Message-Id: <20251231192322.3791912-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This patch series adds TLS 1.3 support to the kernel TLS hardware offload
infrastructure, enabling hardware acceleration for TLS 1.3 connections.

Background
==========
Currently, the kernel TLS device offload only supports TLS 1.2. With
TLS 1.3 being the current standard and widely deployed, there is a
growing need to extend hardware offload support to TLS 1.3 connections.

TLS 1.3 differs from TLS 1.2 in its record format:

  TLS 1.2: [Header (5)] + [Explicit IV (8)] + [Ciphertext] + [Tag (16)]
  TLS 1.3: [Header (5)] + [Ciphertext + ContentType (1)] + [Tag (16)]

The key difference is that TLS 1.3 eliminates the explicit IV and
instead appends the content type byte to the plaintext before
encryption. This content type byte must be encrypted along with the
payload for proper authentication tag computation per RFC 8446.

Patch 1: Core TLS infrastructure (tls_device.c)
================================================
- Extended version validation to accept TLS_1_3_VERSION in both
  tls_set_device_offload() and tls_set_device_offload_rx()
- Modified tls_device_record_close() to append the content type
  byte before the authentication tag for TLS 1.3 records
- Pre-populated dummy_page with valid record types for memory
  allocation failure fallback path

Patch 2: mlx5 driver enablement
===============================
- TLS 1.3 version detection and validation with proper capability checking
- TLS 1.3 crypto context configuration using MLX5E_STATIC_PARAMS_CONTEXT_TLS_1_3
- Correct IV handling for TLS 1.3 (12-byte IV vs TLS 1.2's 4-byte salt)
- Hardware offload for both TLS 1.3 AES-GCM-128 and AES-GCM-256

Testing
=======
Tested on the following hardware:
- Broadcom BCM957608 (Thor 2)
- Mellanox ConnectX-6 Dx (Crypto Enabled)

Both TX and RX hardware offload verified working with:
- TLS 1.3 AES-GCM-128
- TLS 1.3 AES-GCM-256

Test methodology: ktls_test : https://github.com/insanum/ktls_test/tree/master

Please review and provide feedback.

Thanks,
Rishikesh

v2:
  - Fixed reverse Christmas tree ordering in variable declarations
  - Combined 'err' and 'i' declarations (reviewer feedback)
  - Link to v1: https://lore.kernel.org/netdev/20251230224137.3600355-1-rjethwani@purestorage.com/

Rishikesh Jethwani (2):
  tls: TLS 1.3 hardware offload support
  mlx5: TLS 1.3 hardware offload support

 .../mellanox/mlx5/core/en_accel/ktls.h        |  8 ++-
 .../mellanox/mlx5/core/en_accel/ktls_txrx.c   | 14 ++++--
 net/tls/tls_device.c                          | 49 +++++++++++++++++--
 3 files changed, 63 insertions(+), 8 deletions(-)

-- 
2.25.1


