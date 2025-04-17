Return-Path: <netdev+bounces-183856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9730AA923E9
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02EE93B1425
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC4D2550C0;
	Thu, 17 Apr 2025 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JRMDhF5C"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D86D1D63FF
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910729; cv=none; b=tKODKca3PmHw+H85xgvvFsCeSbizOQqfZAsvkPk6lSheeQ1MaZgQ8p1DDbO8Aolc0mqVNtmLzVaIg1eLIE4V5cOzf/utM8jb/qMXIPl7WyrWD4JCgBB818SMZQh+qxz5Az/i+ge0T/8a2l2+9PyjJPU+RGHeW/B9lZ8O9ESHmJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910729; c=relaxed/simple;
	bh=60dJ7Wg9b5Mcc9TVt8AP7YBd29W0hb2l+4DzmTNzLZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jd7KUHs+Ydjn2temEEOxx9dgFJg7s6sMB2eTmPG9/ONC61V7MIznjySercA5VCqKxEzvxm7ZQvgJ0l+NAu0h8FvFd51eS8XkO/reb1b/3tnTfS3q0MA3ahM99krh9Gd4nifiCySWyTiucuH676WVG3C3Bie+Drsik3Jy1TkDf6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JRMDhF5C; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-736c062b1f5so946163b3a.0
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744910728; x=1745515528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fDuLVmzWyKrSKq0a4Yn+78FSiUlUeGjuZFjsdc+JW/Q=;
        b=JRMDhF5C2qZNzhBZGdZjcZdPUDPldfnCNfxvdUKZtmYrHolmSD2t4whdScfGK5iE5w
         Y+25E4VpzjZ6j9X1RJ+vhLr1xUdeatQxzeJtL2ubdgC7oMaANsxitmKNk5f2uwzVBEO5
         9UdxDCJSDp4HSnz/wQ8HCZB6fHZBVOY06tiUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910728; x=1745515528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDuLVmzWyKrSKq0a4Yn+78FSiUlUeGjuZFjsdc+JW/Q=;
        b=IsciOD98oqIesnPAOTVakY1GZnY/9ni7gQDFZfDuxm/O1rsqixhs6lv7ZI1WXm6DX+
         Slvt0/0RbSBVspS4i/SIeN/yWfZjPZ9+H4RJn3Gj6r39vR3VQdDLcwjrHwxy2ABTh7tS
         v3RhaFLBN7BkFj2amsjgOyKG5JcGc9iGlFVJtRTHi71BDWCv2ZlO7+okmJgL/wpCmIXB
         xNYD+HoBP3eTujDd2LvkQX2O4Y7HLAPXajSNOhhxbUsOXbvG0GDITZ1Nt9nvCdxSqNzZ
         KKEfiTqsaGTK6SinCVNaDKWSt7oMyR+QI3Tvt/Ul7A+BxK9etZOk0GYcltiDEo1F5Rpr
         qapw==
X-Gm-Message-State: AOJu0Yx3RE6CTmAj4HoUSY/9hwADw9oaPUgqQ70TN1Fho7iL+xyiPaTG
	rFzAi4+Z3dr9TSBp3MWgRzPDEus2CPVuMogtx352DymGmhhY2lBHDUBzQkstiA==
X-Gm-Gg: ASbGncsuQVmrSpazMdErJDXafglVuzQAHKtqF0lndkkKNJKP5sbJQ1dV9uAAqFMLdS/
	ZyQ/MBTMdKBT5aiuxv7/fwpZMsOlL9D5qKSqf1TrIghleOrPNMF0wJSkbt4dzpts5WmYSjzwN15
	vzlyOeHZeNvnBseqIkLF77ITGmoPGBlJO3r41IB8pwIvYX+o894fWcpPfmZ+qd3Nh6XP8SA1gf4
	KE5EeSPMEJaMDXzLdUqLCLO0DmwgKgcBIWHCIEJ9eYdV0BVz6+Y4oX7vZ6tMkqk0q1iS4K0hsjR
	R8vzP2zgt6V9f7TVRVEdNx9nAlCod+IpqKFs61yD7s4GTToub6ZMxLzH8PAKPtvUmy6BRaFa86P
	sPtq+AtSXmRsYj3Xz
X-Google-Smtp-Source: AGHT+IGmb5rcQyMRrkBJK/ofh+Z1j4CtoWcJkgcY1d7bmH5ZlXj7XlQvmu+EDWsMDxTuz7mPUCUwLQ==
X-Received: by 2002:a05:6a00:2443:b0:736:50c4:3e0f with SMTP id d2e1a72fcca58-73c266df240mr8352376b3a.10.1744910727648;
        Thu, 17 Apr 2025 10:25:27 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8ea9a4sm109879b3a.41.2025.04.17.10.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:25:27 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 0/4] bnxt_en: Update for net-next
Date: Thu, 17 Apr 2025 10:24:44 -0700
Message-ID: <20250417172448.1206107-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch changes the FW message timeout threshold for a warning
message.  The second patch adjusts the ethtool -w coredump length to
suppress a warning.  The last 2 patches are small cleanup patches for
the bnxt_ulp RoCE auxbus code.

v2: Add check for CONFIG_DEFAULT_HUNG_TASK_TIMEOUT in patch #1

v1: https://lore.kernel.org/netdev/20250415174818.1088646-1-michael.chan@broadcom.com/

Kalesh AP (2):
  bnxt_en: Remove unused field "ref_count" in struct bnxt_ulp
  bnxt_en: Remove unused macros in bnxt_ulp.h

Michael Chan (1):
  bnxt_en: Change FW message timeout warning

Shruti Parab (1):
  bnxt_en: Report the ethtool coredump length after copying the coredump

 drivers/net/ethernet/broadcom/bnxt/bnxt.c          | 11 +++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c | 11 +++++++++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c      |  5 -----
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h      |  4 ----
 5 files changed, 17 insertions(+), 16 deletions(-)

-- 
2.30.1


