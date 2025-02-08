Return-Path: <netdev+bounces-164365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D41E5A2D898
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 21:30:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF22B3A7034
	for <lists+netdev@lfdr.de>; Sat,  8 Feb 2025 20:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AE619DF8D;
	Sat,  8 Feb 2025 20:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TnGPwJh3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809E19CC0A
	for <netdev@vger.kernel.org>; Sat,  8 Feb 2025 20:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739046597; cv=none; b=OPVttf9a5+nDDUOWUsuPp+xXnCg0fGbKcFZui4AxF0OqmQ6HZL0rwhMmdcJxnP5/9tUDoVvJRxBMBCpyZmmefIdId+nzcUQZw8tUgDCNs40LyKi2gN4Ur6aICc4ohNavw3vUHVFb+PMwVuffbRujYCj4CWrowKEcZIDpkFRct+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739046597; c=relaxed/simple;
	bh=7FU0jpfhMWeEuqTZct2LNNM7FFXZVGL10QrPIgutlnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YsaYaOEzZWwKT+/5/ABMaGjgSg+R128ADc7lKPKk+0npVOX2ipkAg1gU+gfHgRPLN1OFt5iIDWKbz8LIG7v0AEnBmBU0KGTm671oseWnwf4tYE1akIuDNXINtljPCTnd20VeAfu8EcrYox1PGzP1oMGGk6ZAse/c3cMc8oySmmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TnGPwJh3; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5fc0c7b391fso938163eaf.3
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 12:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739046594; x=1739651394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fRlwIStKfHkHJq3B4vYCn5taWofqQiLj0fgPcJXO3xs=;
        b=TnGPwJh3r7uHXGoHFw7xB7iwYJitkVp68R0lpZdWcUtQ2nronOX+44xz742CA1kdsY
         wtM7EgkpUryP1TpNdnWw1Z0Ywjq+crYg7nm5TLkOMHkXYYuUx+00UrC1ZGW+p5cJ6ljD
         m3TNlxP3BPcZxBVS1VLqceM0TmyGn8PzabSGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739046594; x=1739651394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fRlwIStKfHkHJq3B4vYCn5taWofqQiLj0fgPcJXO3xs=;
        b=rsf0y6ffwznQfkM/Hdy9kWtk+KIGa4EmDYYjuHRi1lH3cpfoSI/u/8s+I3YWh4WdvS
         QZO9uYm+DEsNrMVBAzo5YUEkY+XrVpD8B92Zf2DgSaVsJuLCxLyAaWXw9XOPwEceWB8L
         XniGq6cHDdJv09x5pEBVLJKVcpjUd53s+WRY3QooAwPx8WQeiewPQ2jVaCJm2+XWLyGH
         RduuNK+DW8AbpZMEWwMwu2UgwiRr8emlIMRMkv2Bz2xf++2Ouv4+GwKh7eIJ7vjqBoPY
         2M2x+gfMYzZYp2HwUCQn7kMOAYN1XSSzweJfVM58L2Pi6n1+K84IFD6iU8lExCQxEbxk
         cQUA==
X-Gm-Message-State: AOJu0Yzd3/Sjp8W2H9eZwG4McmsirdnLXW/94YkLQyQUwzXYzAgDt6ub
	YNzqsopYSGLOMITpCig0WlL8ULXcLjzExcClPa30kyuqV7o4tttu71T44VYD1A==
X-Gm-Gg: ASbGncsZGjcb35krHezGnw/A+nwBFqzJeSk1kfHaoXsAMP0Y/5Gb9OVPNL7OigysFHz
	PZSdYOgY0lFD1k4nRgaAD3LQTRsvgC2CfKmXq9f5j6eNTfgRrl3rlDAuKrfAPJFWtHPmBdVBkLQ
	yB/Y6AzSWVH199yoQ0fp6R8Mwb584742R9EpHTJot6jvkmIuZf6y8tA2FH9y9DPUIpeHjY3rgiE
	pU4NyA61w/C2uDIHWn/jQrAcU7UQTP8lLeChvqWv8gvHrBpxU9HO+3rm94yyrZFI3zqWtSRkBQF
	U8QHoz481e3CklXiBwPJcxJK9yd/4TIqvYjkNWJZ2GxtQb8JOkPEN3vZhecIceQzIHw=
X-Google-Smtp-Source: AGHT+IE0g6iCZEK0IytsAaTVpAmbGRebwWDTSMv0PI+SAOA+qfc78DRG0m8qQQs8EHlZa1CfUSpfEw==
X-Received: by 2002:a05:6820:134e:b0:5fa:61b9:3e7e with SMTP id 006d021491bc7-5fc5e6a7835mr4846366eaf.3.1739046593927;
        Sat, 08 Feb 2025 12:29:53 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-726af932f78sm1564130a34.18.2025.02.08.12.29.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 12:29:52 -0800 (PST)
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
Subject: [PATCH net-next v4 00/10] bnxt_en: Add NPAR 1.2 and TPH support
Date: Sat,  8 Feb 2025 12:29:06 -0800
Message-ID: <20250208202916.1391614-1-michael.chan@broadcom.com>
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

v4:
Fix NPAR typo in patch #1 and improve the description of NPAR

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
  bnxt_en: Set NPAR 1.2 support when registering with firmware
  bnxt_en: Refactor completion ring allocation logic for P5_PLUS chips
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


