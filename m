Return-Path: <netdev+bounces-246610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E828CEF33E
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 19:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CE5E3015EEB
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 18:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2B02EA156;
	Fri,  2 Jan 2026 18:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="LBTgPCCY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C4E1E515
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767379691; cv=none; b=YnPdOZO+imMup7OJTadxqYAycV5s7UCt9j4yEOgpEXyfyb+TH69BKqZ7QHW0SIGUTqg/d3T/cF85CkRJQqVH6DqsY9Ci5CXGWepfMo4bxjlpHQjirIibwkqZ6EX4SA8Hg056N77oa9NU/wJ4+K5xM7QFStZ0fBRAOcbWPvfZpZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767379691; c=relaxed/simple;
	bh=Hs5B3ifeCXeSNNMDYIe+7eC9Q3WwDtJe3srqhrhBgCg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ShdZTYjKcPaNFvszFr1zZj1SRCB49JHbxrzurgKTXUx1evLFndZ0iWMsYvInVNPeQg9Rxf4v4RRE2GmQcbW9Qo8M5xLM98FGoz5ckTsMQtDoYkUh2uQ7R69xmpKnMCS0dnWTsSl8E6Tjvwhbi/5vx6/M29K+7SRVIObcCjwb15E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=LBTgPCCY; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64b4f730a02so20436575a12.0
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 10:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767379687; x=1767984487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K9LXW+MF3D8Ix03gr4Ncasdbb3572tAnqSzx1OCYANc=;
        b=LBTgPCCYjGXc2aMm8/Mm4B6d6hi2+UKkGouGgX2ZcW6Vj84u5kOfizi3Axg6gJ7dIk
         DdDHG5+qR3mMGilBwNTNhCg3SwipkQuvuPBRsIx636k5gCSzNxmTWcTviTeBEPNrLA5/
         1zpQ6qRISPhLhvLeq5sqPnan3x7ZAdwf0QJA9vUfB4vhfp1UVqj6AUBBS+yDO02y7+Kr
         8TpBBKA/nSxpZ3EiEq461Ghl6YKyhywo6E2mHIbcmXW0Gptu391k8Pt3een28W3pSSzD
         TtNR5B8+udoUQREOZGoUPfEpdAoqb/SkR7U0YHZ0+lg9x/szxB7/G344zPW8QKfQiHeO
         xXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767379687; x=1767984487;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9LXW+MF3D8Ix03gr4Ncasdbb3572tAnqSzx1OCYANc=;
        b=Oqufon9T/mjUfzfqlpHrA0dAwVml09tAZr68zjTibrMIaaBWW/FDCLi6WC8ZkBIZax
         ZmW2Ug7M97NjSqEkduq+t8/veD4pE5EPfZy9NJkqWgFxFDHQT3xZenqFqt1P36tNm+zQ
         DFHo83g5gf69DGpI/BhPptnmw88PWuI0zkTWo4dPDI0Aj/gjYl28hpq/VS9m8Zg5Tn/l
         TNxm+do456qFMWDdi8qSlwlkOVOtctgXES4ceMDc2yDdWGHVZOUKZRRRSYjA5+PqkFFe
         Xl76kWWZ9dK23PP84LC6GeoV7AeJbqTrDFB8vTX3OGQVonrsf8k7PCFIPFnOgLJEQ9SP
         NEPQ==
X-Gm-Message-State: AOJu0Yx7mQsJ2vc804amYuUkGpEsyHyj3S/PybYFA+/VST0eInPN5ZAH
	q4eTGOeGq8P6O5gxDz8D4f0HKF497QyeePPVgF5OX2QCRnJnKVL4VR4jvibVNhKkeETuS8Hm046
	I8hNKNiDoPWm0nZoJ0f/VzOVdP55jlC7TUXeBVz1rBIbP40MUJoGUZY8WQqwXysvm3z8Z+NuUHG
	TqgS05EhvjBHSKRw5wRN1qEZIkMYwoZdhpxnOJ00fF7SUGER0=
X-Gm-Gg: AY/fxX4V5M8oOfxODV7q2YymNHWvh3XyuF+VFIbV1773z+Z2mCFceQ/Zcs+SZsvGTyF
	7XpAJ6oc1js4B4NhVcGS2kd8hc7uo3eHII2Jr47y9cYN7wqkzmHVCUD5HChEmggXhKEv2vi2piQ
	S9771st7M5U60qxtyrWWSoB5GXCw959cXGjie3O8t6TbvFGCeslZI0S1cIMXRVT5PzXlcC7PFdn
	VW2sQbb6C2a0NMuPHdsWz59JBSnrXDpH+WVKyItf6FVjZW6gjlXtDE/Pnk1KxAuolPOiEikDnwC
	dkwVKa0xPK42t6qfJEOOelJKGRzZ4U6z75DRssooUByl6rgvllw2j/H9eFafX8/QLtLjbWqA1Pe
	XgZkqd9m5JagkJhRhe1KN9sarho97XBZ9ZBbkHQY6nuLiD43KTZt5KA8gtw442+dt04RKhyrcA4
	/EoeDq23eKFKsGjO0sRYBV9M3oTj3iThcH0XBr
X-Google-Smtp-Source: AGHT+IHdtJ01j16kbJqR0S3B+AvOqcW62+C4RGxcIlJ14vLJBd4FxtOhY7jARJQ5HI+ZUn8jXHgLTw==
X-Received: by 2002:a05:6402:42d0:b0:64e:f6e1:e519 with SMTP id 4fb4d7f45d1cf-64ef6e1e772mr13287580a12.19.1767379687379;
        Fri, 02 Jan 2026 10:48:07 -0800 (PST)
Received: from dev-rjethwani.dev.purestorage.com ([2620:125:9007:640:ffff::71f8])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-64b91494c03sm44625214a12.18.2026.01.02.10.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 10:48:07 -0800 (PST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v3 0/2] tls: Add TLS 1.3 hardware offload support
Date: Fri,  2 Jan 2026 11:47:06 -0700
Message-Id: <20260102184708.24618-1-rjethwani@purestorage.com>
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

v3:
  - Added note about Broadcom bnxt_en out-of-tree driver used for testing (updated commit message, no code changes)
  - Link to v2: https://lore.kernel.org/netdev/20251231192322.3791912-1-rjethwani@purestorage.com/

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


