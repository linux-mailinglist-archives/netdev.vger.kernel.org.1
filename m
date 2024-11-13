Return-Path: <netdev+bounces-144313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A69C68C9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 06:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0CA61F23FA9
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 05:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183F816DEB2;
	Wed, 13 Nov 2024 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R6UZFyj9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4708E13C90A
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 05:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731476386; cv=none; b=saMf+pJp0rFlMlqvNMTQ7S0YCdmqBlFLsCXKyjB3notHak7I/Tdiqt0UVZ3kSVAEFRzJyCphoBYxEi/1e8jtwpTAxX5j3CIrodU9Hl3ud7IuE1rJCbCiB23oBhzoNBDzlHrgv8ZivjKO6RMPtQz27o4Fx4bwmquX6jUPBMu52Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731476386; c=relaxed/simple;
	bh=3Wv6cfaRisNA8rf5AGMN6HIvYLWL4IsiomvEJ1taSJE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7UfYkRrapDzf/briPa/ieHamu4Ls7uj5S/Wc3zoM/3Fb34MJD7nmiDCq0BAEECBUqrpUEyeADwBYKz5KxCigx9BIEGDTZdQZ6woImyTAn2R6rlW8FLUTx02Z/FE5x1arHSuW2TIF6L/zyT76KVbF+chVZRjmUKRfg01OHmse7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R6UZFyj9; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-85019a60523so2290061241.1
        for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 21:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1731476383; x=1732081183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I0zqwtVEIZwX93dvoVAvDQF79UDfj41U7Iasr+DKZFs=;
        b=R6UZFyj9vnwijRI/irlWgHyvdLONRYOjSJ16eiLKmUQD4SIzT4dlHKpoksMJt0pFHY
         WjW69Vedy/cWmPkugLZZblpemVutTrtzivDTfwaHyzz08E/K9R7h4Q4NNvGWK+c3MVki
         +PTS1+fQdP8qYSjKIdhSAjQNFf92IbmucnBh4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731476383; x=1732081183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I0zqwtVEIZwX93dvoVAvDQF79UDfj41U7Iasr+DKZFs=;
        b=FO1KTqHGUMcpwLM4BK3/HRQ1TL0/XPuVE5ghA2Y0cFjzy7HqiyDDsjLohqyULhei6c
         gONRoYAS8wYCywLHCjt37XPjvZzoR36BqoJIWISmFB04IshmXX2o0aOKQe41AxBsx/15
         GH7Yb7Q7apUaeqLGfIwSQEtA/AQ0TLSrke40kcOZg7ZY/rNsvDO7bnLl2EmBaGqHFaA3
         x/b3aTqdJrDp3bqVOZbe57S0sSMfQLSpHlTznLVBeP58KF46Ee8wCkeGYG+WVeES/3dk
         Wfp/Tt5TKY5XlcN0n6v71GEc7ZZg08yqic84ZnNCWLeL0+6qnAWOHT27PHGqKyizsFUS
         rR2A==
X-Gm-Message-State: AOJu0YxCWvEETGoAyW9rZ1w1gFwsCIRumkC6tJbMjwJj0kBnlXxtmXFt
	i5qbSyZqWJQ9rih2PZkzhALHQx16YJNr4jOKPbsu4EdcUtnxNSEmW3WsebkO8Q==
X-Google-Smtp-Source: AGHT+IHwB/AMH4LV19SsU5wyT2Y2P7t5q6itRgz0XpQvedW2hxqdXhBUPGqLpCQL1Sw3+IiJ16MRCA==
X-Received: by 2002:a05:6102:b09:b0:4a4:950a:cb1f with SMTP id ada2fe7eead31-4aae1653462mr18262901137.22.1731476383116;
        Tue, 12 Nov 2024 21:39:43 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-462ff5e14f9sm83457491cf.86.2024.11.12.21.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 21:39:42 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	hongguang.gao@broadcom.com,
	shruti.parab@broadcom.com
Subject: [PATCH net-next 00/11] bnxt_en: Add context memory dump to coredump
Date: Tue, 12 Nov 2024 21:36:38 -0800
Message-ID: <20241113053649.405407-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver currently supports Live FW dump and crashed FW dump.  On
the newer chips, the driver allocates host backing store context
memory for the chip and FW to store various states.  The content of
this context memory will be useful for debugging.  This patchset
adds the context memory contents to the ethtool -w coredump using
a new dump flag.

The first patch is the FW interface update, followed by some
refactoring of the context memory logic.  Next, we add support for
some new context memory types that contain various FW debug logs.
After that, we add a new dump flag and the code to dump all the
available context memory during ethtool -w coredump.

Hongguang Gao (3):
  bnxt_en: Refactor bnxt_free_ctx_mem()
  bnxt_en: Add a 'force' parameter to bnxt_free_ctx_mem()
  bnxt_en: Do not free FW log context memory

Michael Chan (2):
  bnxt_en: Update firmware interface spec to 1.10.3.85
  bnxt_en: Add a new ethtool -W dump flag

Shruti Parab (5):
  bnxt_en: Add mem_valid bit to struct bnxt_ctx_mem_type
  bnxt_en: Allocate backing store memory for FW trace logs
  bnxt_en: Manage the FW trace context memory
  bnxt_en: Add 2 parameters to bnxt_fill_coredump_seg_hdr()
  bnxt_en: Add FW trace coredump segments to the coredump

Sreekanth Reddy (1):
  bnxt_en: Add functions to copy host context memory

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 309 ++++++++++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  57 +++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 162 ++++++++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    |  43 +++
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hsi.h | 173 +++++++---
 7 files changed, 655 insertions(+), 95 deletions(-)

-- 
2.30.1


