Return-Path: <netdev+bounces-162318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D66A268D3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 01:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB6E8162585
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 00:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48705CA5A;
	Tue,  4 Feb 2025 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="H3fflOZg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7493125A642
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 00:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630014; cv=none; b=IOS2kM3wwTfKyn2Naht/ioCFratQvgmJldqYG1LUSH+aZ2vgaBAdZ8rqaY7OQWv8+0kpWkGbtPVeZNDJecRU+X+l37YMeWHe8nDIQIRiLwvujepO/pOsZz4lX8ESBv6bWbN2Yff92OjRr8QBim3OIN8tIDA+Zzk1kFT6/YNpXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630014; c=relaxed/simple;
	bh=8hvFcz0h9aPss/yAfhkzK6boVO6t6JUffrE61kWQzag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gqiPvwrKDHSaWhQrdmeR7Nx0zPLk023x2SYMIf1u5BOnUQEa7upOOAEQbOch+nheLJc2C4ZKOGXB5d/Hsvj+00NhkWtlqOclTKTgEQgUH8qfItERcFM3iNTp5tpAhfxBxpljCclJBrlMaXP01Gg0YZYA9dKHxJ41+HIxbXOJQi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=H3fflOZg; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-29f7b5fbc9aso1305510fac.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 16:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738630011; x=1739234811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PQvGOFRTKbGvSHyZA872PPkqa79teymgbTIROMMPZxA=;
        b=H3fflOZgD80eUNNByTMpBtnzP2MmaOWjwPkxcNvLfacA75qYtfqgOg48UgokYH7ivG
         KnOfbkL2BwrJfSDByWQ+Ko3uXk9I1OJHsJWBvLSdn4PmeDj0qbJtBnltfuKRBWh9m8Oi
         KBnnOCIuxcButflYglROCBwz+6N52lZ6ZjXp4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738630011; x=1739234811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQvGOFRTKbGvSHyZA872PPkqa79teymgbTIROMMPZxA=;
        b=exc7ZBm8brJUXjQCya+SO3VfsyveQEqU91ajLIvVQg8mrWu9PCVnVR0WkZVdhCxTBg
         Fwa2Eukat01FhTFR8eMPCC/733UEayHj9ucOp207ZuywAh3Cy7g3v9VeU9jmGyC7tHhq
         iGxwyJkcpfT/ppuEHY4IRjktsOXmbCSwuqCdebaSeRn/TMkDWnw7jiR5yn3OpcFI1hNF
         duqf4Wa7MiDpFkaurTcPyi2BYqmk922Ax8Vnf9X/BTxeSjjnSDkzakbw5QymXlscoeq9
         I/wKQc/48xpg++uZHZ6QMNRPagAOAPfehPBke3Fw7L5/dfDwNJrP+ZopqFxRFnQqm2KX
         tqyQ==
X-Gm-Message-State: AOJu0YwAq0k2CerYsOcMaviR0zGrZiFm+PoocmGZc1s7g41nkLgZezo6
	5XAqJ9gWYX9EVb1nWeBNlzqyYcbreJGmp/9RWzUUBkrRFue+V+UaUkCljmRM7A==
X-Gm-Gg: ASbGncsrcs/G1im1wEY9PaxnnSIanJMt4LgRuc90Lk9JVCcUFh7b8fJVSvF+nW1pXPF
	vvUyvWzymUL+f2eVT1C5QnGTKKNKAzXIQfnke6u8i+lFGOcwvjGC6RKy0hmgxW6fYZ0RfLsnGpI
	4HvzY2QBLAEp/EAhm2IwrPs92Q6/U/zPm/DtZcZa9zefAxPPpigbCfFTiKuo0Bh3RHPepf2pqGS
	K3B3WdGVBQMCMKlup2bJJ9kHjOdBePO4DdRXt8/YT0wFtyds9/MueCX3xmvfwb0xY7DyZ9drHwK
	g6LRVarRvWTblCeKAeRR+ARSSzUzVDxDYx1++VRLtAj3MY3lqX36ajHn3mWRhYMcgeg=
X-Google-Smtp-Source: AGHT+IEe3m5VY7FAMgD2w8HErsHScfAC/7RhWCQnmQ8OKTeS7PwsWlv1OOlTR8RxCd0MEAgDRDJCsg==
X-Received: by 2002:a05:6870:2f01:b0:29e:14ff:2f9c with SMTP id 586e51a60fabf-2b32f0939b8mr13447242fac.18.1738630011431;
        Mon, 03 Feb 2025 16:46:51 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b356658291sm3680495fac.46.2025.02.03.16.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 16:46:50 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	michal.swiatkowski@linux.intel.com,
	helgaas@kernel.org,
	horms@kernel.org
Subject: [PATCH net-next v3 00/10] bnxt_en: Add NPAR 1.2 and TPH support
Date: Mon,  3 Feb 2025 16:45:59 -0800
Message-ID: <20250204004609.1107078-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch adds NPAR 1.2 support.  Patches 2 to 10 add TPH
(TLP Processing Hints) support.  These TPH driver patches are new
revisions originally posted as part of the TPH PCI patch series.
Additional driver refactoring has been done so that we can free
and allocate RX completion ring and the TX rings if the channel is
a combined channel.  We also add napi_disable() and napi_enable()
during queue_stop() and queue_start() respectively, and reset for
error handling in queue_start().

v3:
Fix build bot warning in patch #9
Add MODULE_IMPORT_NS("NETDEV_INTERNAL") to patch #10
Optimize ring operations when TPH is not enabled in patch #8 and #9

v2:
Major change is error handling in patch #9.

https://lore.kernel.org/netdev/20250116192343.34535-1-michael.chan@broadcom.com/

v1: 
https://lore.kernel.org/netdev/20250113063927.4017173-1-michael.chan@broadcom.com/

Discussion about adding napi_disable()/napi_enable():

https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.uk/#t

Previous driver series fixing rtnl_lock and empty release function:

https://lore.kernel.org/netdev/20241115200412.1340286-1-wei.huang2@amd.com/

v5 of the PCI series using netdev_rx_queue_restart():

https://lore.kernel.org/netdev/20240916205103.3882081-5-wei.huang2@amd.com/

v1 of the PCI series using open/close:

https://lore.kernel.org/netdev/20240509162741.1937586-9-wei.huang2@amd.com/

Manoj Panicker (1):
  bnxt_en: Add TPH support in BNXT driver

Michael Chan (5):
  bnxt_en: Set NAPR 1.2 support when registering with firmware
  bnxt_en Refactor completion ring allocation logic for P5_PLUS chips
  bnxt_en: Refactor TX ring allocation logic
  bnxt_en: Refactor RX/RX AGG ring parameters setup for P5_PLUS
  bnxt_en: Pass NQ ID to the FW when allocating RX/RX AGG rings

Somnath Kotur (4):
  bnxt_en: Refactor completion ring free routine
  bnxt_en: Refactor bnxt_free_tx_rings() to free per TX ring
  bnxt_en: Reallocate RX completion ring for TPH support
  bnxt_en: Extend queue stop/start for TX rings

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 531 ++++++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   8 +
 2 files changed, 408 insertions(+), 131 deletions(-)

-- 
2.30.1


