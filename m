Return-Path: <netdev+bounces-157598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DAEA0AF60
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD94A7A037F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 06:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C844231A2A;
	Mon, 13 Jan 2025 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DL/68LbB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC47D1B4236
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 06:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736750409; cv=none; b=WdIihgFtXYatgesse/VqeYgIvNeEK1p5wAP3yomXvsq6X15jq7Zy0G/lJOGDLNNW3sS6akq+099cYBcdd4tLsTV4MmLPQKrgH1HA8vxIZ4G+M7XOwl3KQ7oeMO6xzK/HkNsUXzR77+5nsBGnrOMm5URjG6XuuydnU9YT/bh5HWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736750409; c=relaxed/simple;
	bh=5Td0hp06syJ4rpz2cZ9RxmKi48CjPprOPE04rsJVaDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FnPCP9ujC7KIE6udDfKq+kooAqRrROAFdqpN/EYW6yuFC4umn+7iNcOn6+7Iog2hs9jcFB+a3i+8mU68g5/WjPWCqIQkrPaS9YvbFbjfj5/pUQftJqMcmljim6/VpPx1N9UmYQ0lvCfGGHMh5S+8AEYVYeaAYR2Z4GGdMXU2HPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DL/68LbB; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-21669fd5c7cso68090385ad.3
        for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 22:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736750407; x=1737355207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1PFSpJU2Fd4B+ey1jAHF1zHrQS16tsPSfz0Xl8SwtoM=;
        b=DL/68LbBd6nWxSUncCYbzLxIqMgwo2LFwJ5H7YSvqFMcIfAVRrNCEV6C/IsBwYJqoX
         Dq2SsdKP8QPUj2e2GIIfLdzFkiNP6u3D6PMaw+PxWKQihL+SjPA9nPZhwCsbcr/uy8p8
         8MeY9mLeNDUO5OSwCfKSt27I6l0YXu4z+B2xk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736750407; x=1737355207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1PFSpJU2Fd4B+ey1jAHF1zHrQS16tsPSfz0Xl8SwtoM=;
        b=YyoUCihZyVTeQ24kL2Bt4dISnp32rUkLxm8oYBlS5JbhEhhgto1yJB8HIvgrPNjQ1h
         JWh/ohfZQsWhMFkt4N/b3ROtMAve6bVyiXsaBkwP5iYHO2Qss7hO/j7eUqRA1b2TPgVh
         lcDwrxBrPWyV9bTRJuLxiyfMr1p40OjN+MSrbBbfm8xq1U56I5EzgtGXZ7PQCkFdgwCa
         R94V3CazIZXRRRdzkBYRaIZPAYo2LYSjKTgspSlrxyLF37cFkgntgUxN5BwY0Z9RrJ08
         dJ5G9d/GPtMWTznt14ji3rMd8X9lW8VhX+zSRw3c5MIlqbBGAISIUBuT98+ePaNkrDPZ
         Aq3A==
X-Gm-Message-State: AOJu0YyXJiraTUVZg9TJ9mCcYKSHxWTyy0NxlALW+CcHSN1qadIrcZ3/
	VYO+/witxQ5zC2UAwuK0MUBPs/d70quH71eUhcsEB3CcMn52fN7qYRmfPzDqKLhuXBB39P7Ymew
	=
X-Gm-Gg: ASbGncs9TcMzD161dT0xCvH3lRDusfBHqqy003KizroTjUSHB6Ku+bE9grg4NlZ8ZC1
	rIyFKKNm0BmIy/uAGdP1wcVuCj/Xeani8TOLgGC5ZbXFOk0uAJYgltPjFPqF1WflGwx3P8YROKU
	7keE1D4sNkDRDc1f0wuuA1dOHVsKHkxQRIBjXzTXecENxuZ+pUWTEwKLp35YYhhEUMkBsFKlyZr
	95BVV4PX65vrDBD79kL97orpchCB5moCQXWNfKmicOGaq3vbGSfSgYOI5ioWMBOjJnCJHJweR5D
	86l0DKRiA1K2goiyt1D9aTpfppxQwpi9
X-Google-Smtp-Source: AGHT+IGLu93+Nl0whKdj+mMgJG60zpKdpOvNOWoKCgS7kdWU4RIdU+XWrOc1i6brxeBo9gEuoM5f8w==
X-Received: by 2002:a17:903:22c1:b0:216:554a:2127 with SMTP id d9443c01a7336-21a83fde33fmr283965205ad.41.1736750407117;
        Sun, 12 Jan 2025 22:40:07 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f254264sm46488165ad.233.2025.01.12.22.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 22:40:06 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com
Subject: [PATCH net-next 00/10] bnxt_en: Add NPAR 1.2 and TPH support
Date: Sun, 12 Jan 2025 22:39:17 -0800
Message-ID: <20250113063927.4017173-1-michael.chan@broadcom.com>
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
during queue_stop() and queue_start() respectively.

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
  bnxt_en: Refactor bnxt_free_tx_rings() to free per Tx ring
  bnxt_en: Reallocate Rx completion ring for TPH support
  bnxt_en: Extend queue stop/start for Tx rings

 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 502 ++++++++++++++++------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |   8 +
 2 files changed, 383 insertions(+), 127 deletions(-)

-- 
2.30.1


