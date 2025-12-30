Return-Path: <netdev+bounces-246389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92E0CEACAC
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 23:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 956D13016376
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 22:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BAD82BEC3F;
	Tue, 30 Dec 2025 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KjfpbM5v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E1223ABBF
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 22:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767134510; cv=none; b=TqbbZza1yEf3mZuc77ADDdikqKGeSHDNaHOGk/Qy4VoWj0dMgmddaemx5nCsMwmEpo6ztBJqDspX5bkSt9dtRASvy/jF2j9PzOxUmxgrPWg5vRrTMeTR2hsooW6eZXGuTl8xcBCW6RfuVsx99ds5Dm3qqwqI5ld2AsFIBnSnuqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767134510; c=relaxed/simple;
	bh=OWWomHk99HdeezC4OgdbDZeJCyIrSnuuMVxN2AgCZr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=t0pEudycbtDkKabpIEPZjIz4r4c2Gn+nIBgDc4OZYpTYoESMc+pcukEbFBPOBGmtaKpWxc/AbQVWYODw9oIxXHVzO4adc7oL1+VrBdpNPN8XvZ1u3irDOuBLRxS8+uuHCzvzNDhoIuw8V5Nn6NtNZ3yNmxbU+JSqblrD2ZB4qEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KjfpbM5v; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-64b92abe63aso17386884a12.0
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 14:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767134506; x=1767739306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=06dW1Ho7bV8eKHm9UgM3Iym6VDOMBdpFG2s9p/N9gyI=;
        b=KjfpbM5vQDTqZ7ZwGQZpjiDP0TSlIvTbhFN+Ws56vbgXZ2xIQ/G1P7snSbfbs+O31E
         LgF7O/vFTxpScBIamczQQ8TFDkF/NXdf+tLAHFThTO/CLX5dbpk6y8dgYntUu+4d267P
         xS+A/Yk1cE3KfA2mrB+nFv9YGGnCw7gIMlRlIaLjAQg6lrhpZCP0P2y9YjpJLfRH9jAi
         O3fHwZvmH6+gLKzS1hQaThqFJtokzYyOBDsR1EtpwUt97Ypgjqb6kLPNSmo1bi+BhiJI
         axV/x/el4tLQXcPMdq0l4jZlDkgKQA7T7rwEdFP/JymFv2vDgtjAw3yUTCdsKVZaG1SD
         es9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767134506; x=1767739306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06dW1Ho7bV8eKHm9UgM3Iym6VDOMBdpFG2s9p/N9gyI=;
        b=enpTo+ovpNQjyvGIHuJlEayhoqjwOrYUwh6UEYjpLQPMedkRCaNNkl2TgaHVdr7jK2
         2eYqD8XCm+N0UUq2LaD4LN8KskgSaoEcmsMfN+2rlgSAtnwidc2t09+cAihbqPKmBCRK
         i1hKBlG9TOnB5+dmGTdId+EpUgCTNKvxcC5N+BBf/HNKrYmPM+1r3nfdERI3VBFKZNMh
         ZF5BVGcwbB8XivbQg3uUp3YFwp1MJ2/pAeweTBj0zK62jue/coIko20mDedp1zANMamU
         sUVm7F80PGH4M4IThmn9QoLyudrehIfL8RtWYYpO5jjHNdwoEptYyxMaT8Q8xiiitGfc
         vBXQ==
X-Gm-Message-State: AOJu0YwP2RS6Pjeq2YFYegc2kmCD4+YONZPPlGoj8h54Up7BUnU2iA6k
	psMNjRJSgubJwGRpDLpTwWrKUktOLhWpItWqOzljIgNXKMZ5UZjZpC0rwBXuB4sN+5BDh+6ZPEO
	MEJ//th0wgSvybvpN1vZN2SLF0UQn9Co+I6Vd6rDf100RXd/4Gtwt/0ScY9wbKt6MD+LhExw2C3
	D+kKLVwbfX9mjZJPLNr/zRHZpeJnr1YHd58/MiNFg2KCsMeAS6og==
X-Gm-Gg: AY/fxX6jV6cOSGmQgU1dt2oO5t1NSIc3fVSSAIFOnn6u8TW+yZIT1ALLMsUG2NSZ0hk
	IrrmxNieMKICjOPh5pzR/n+p71LyaCKYrrtT5gOzkLT8zxSm0m/kwW2LxNiAW/Nw+ybKCHx1Bbc
	IQTgnvzlH9aEzVd3NXdnf1LFrLJcHr6UYXQ7Q8rVwyZs8qrSJqjiRVyXCj+Wan9tUIjnhLuzgRA
	HxPU/ibfDX//59fmyEPNxMgkTOEXjB0pTTpita2pXBvfZdiOxadt7bUU85wYWDHFSHn9Hfi+pn/
	qdhcTyEWfCkBJDrxsgZskrA8EiO1jA8HHLQEf7/Wa94PNHzxunQ87iM3GoR2eYHL2d7oow0rbst
	CEclhabBolFHMIrnS5zOv6LjyP4dm045lcXTxs/7GC++Mu/KgPd40LPFfi/oW8Q+7l7deVoHqOo
	KXalB1VpfKm8l3/ID+csHVQdyyDz7nYXAf0db4LTTEgWINFbUBfDZZt8AfWA==
X-Google-Smtp-Source: AGHT+IEnm+Td03B4FYGC71L5CtP6eykYA6dxr5iHliINpVIYBTK74eJNQeIX7ea8GVLZO4KH4qW3MA==
X-Received: by 2002:a50:fb18:0:b0:64d:d85:4c75 with SMTP id 4fb4d7f45d1cf-64d0d854e37mr21895579a12.12.1767134506451;
        Tue, 30 Dec 2025 14:41:46 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-64b91599844sm36214651a12.25.2025.12.30.14.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 14:41:45 -0800 (PST)
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
Subject: [PATCH net-next 0/2] tls: Add TLS 1.3 hardware offload support
Date: Tue, 30 Dec 2025 15:41:35 -0700
Message-Id: <20251230224137.3600355-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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

Rishikesh Jethwani (2):
  tls: TLS 1.3 hardware offload support
  mlx5: TLS 1.3 hardware offload support

 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls.h      |  8 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_txrx.c | 14 +++++++---
 net/tls/tls_device.c                                         | 48 +++++++++++++++++++++++++++++++++++++++++--- 
 3 files changed, 63 insertions(+), 7 deletions(-)

--
2.25.1

