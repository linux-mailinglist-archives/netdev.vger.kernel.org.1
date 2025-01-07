Return-Path: <netdev+bounces-155693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356C8A0357F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 03:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28FF164B4E
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 02:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCCC15ADA6;
	Tue,  7 Jan 2025 02:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="esfqPPE4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949921553BC
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 02:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218403; cv=none; b=px2gVdlctZoZipFYVo7QecOxC6IIFN6d/50GeZl0krm7hFxo2Kzphhc/kebHSDUutJyobO1oBKVzta+1Jih/PSOBoCoIQoIUuComuICADsPD7V6EN0CzVbZpNZwr72j7pm01G14S6PijQxROAMiB5YQFSzWnLG4yWHR+1OpK424=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218403; c=relaxed/simple;
	bh=94O8qKTwwvHnAgFhvXzYekp0zM4Sc9l3IWmo16wIJFc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rQvigCQq2IATW3Ay9GqBnyTzSE4jMs9GNGzP2uvbGIaZehOQF92o60fIpCnUcgNdu36f8xqlFtBeu/fPTYoWVB7OX86CECBvxsDVC1QlxTOBAWGZVlVM41c53kjsJmFTGHLGLmDwMi1wyRhFIbB3AK+EF4Z06W6erq5dcSN/1+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=esfqPPE4; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2165cb60719so222066875ad.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 18:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1736218401; x=1736823201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zz6eVpMGPhHLrEjcgPVe2+TCtBLXv2a4MY1G0a/lYOo=;
        b=esfqPPE4aHTZaADYvt5HyJgBWWVF5lUmfXtZR2p01FtdyabtIqei0RdAY5Z5b39td/
         1vFKfknLNTK3jBMVoItLmC+WpF3fbjzIXtHWPKLhvttgeGv7Gaz4y4jpoKi2KOdmaiTf
         Gywja1uov0FgUS+yw462J75y9r59FdK6Bs8fs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736218401; x=1736823201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zz6eVpMGPhHLrEjcgPVe2+TCtBLXv2a4MY1G0a/lYOo=;
        b=tnhC+v+DCimFv0Vj3K6/lm9GEw7XP4CpOx8sCZ74VGbowDxgGp9+8zKjUzeZQTihCS
         Vtc+2c27LTXuLdZjAwcWNuOVyDDdAYuu7xPIZiD0O/NwDUcLCA0NNc3A1vA3rXWaA1xN
         kLkGZqnq7cEhNJzzZeQYWO1oz+E9bZebnKm0HTBddvPfw4aMyG7LPc1jg35skBRXyT3T
         MBLHRIf5SIeIrs1jXBgBrdxZ50HvSHGW+zryhlkdRCJuQzlxIZCjWijWi2zEY02ueBy6
         bsivxKpshdRpouZnoNhBu5r1S8/fyVmyhmBq1RBHHWbwKlZ7WdFxQey1YEDm0hPbwt+c
         yQVA==
X-Forwarded-Encrypted: i=1; AJvYcCVEoJYRp5W3Icb9i/iJC4VMVMJadQaar2pRGfij1LWjCa5elHMkGvHVXvpAPWT7RxVi6mWRkxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgZf1I75HCm/I7GYmMvbWMPsEvgt/oXsl4ywaENWXMSwxHBxbu
	MAb+XQwGO0CCXViYZFY/iC6p5PNLJhZ5ABJuyPLcbwhAgz4VCM2q7O+UscOvKw==
X-Gm-Gg: ASbGncsFVooqdatOSetbX1zf3Wowh5suGhzqE/R74U0IsQNzE38ImgEbH/y/sLkH7y+
	dKQJVHpT49LhLU2oJnmaf6d6yZT8r8vg9ZGPQ4RgfZUCX2ICyedXILEk3VduvUA+A+HEb6cy9vM
	fm2Qs7aq9rfUK/QNA4/reraqnFsCvdjozODd+f9+v1aEmhIuc+aMFCpHwSWVL51y6WA+6+5vx/y
	Ytqo06P6QcVpqkvRQTS77t4LLy6Bfg3kvRzTO4O0D8N9ScYiYNWE27fuOYU881UVq95RolreS6P
	/U3PbxmhjICSWjhsdt1T+da+bMjcPqd3E4EI4IHPnU6ecK98p26qRyDwIOo=
X-Google-Smtp-Source: AGHT+IEQeDQnGeNZmlDCRHGP3QulMLReIB+3aKySgyGiJWsZRED+79OjQ2GJWTk37KijSk7WvcYNsw==
X-Received: by 2002:a17:902:f612:b0:216:526a:53df with SMTP id d9443c01a7336-219e6f25cb2mr928815835ad.54.1736218400922;
        Mon, 06 Jan 2025 18:53:20 -0800 (PST)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f692fsm300093285ad.216.2025.01.06.18.53.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 18:53:20 -0800 (PST)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next v2 RESEND 0/4] RDMA/bnxt_re: Support for FW async event handling
Date: Tue,  7 Jan 2025 08:15:48 +0530
Message-ID: <20250107024553.2926983-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for FW async event handling
in the bnxt_re driver.

V1->V2:
1. Rebased on top of the latest "for-next" tree.
2. Split Patch#1 into 2 - one for Ethernet driver changes and
   another one for RDMA driver changes.
3. Addressed Leon's comments on Patch#1 and Patch #3.
V1: https://lore.kernel.org/linux-rdma/1725363051-19268-1-git-send-email-selvin.xavier@broadcom.com/T/#t

Patch #1:
1. Removed BNXT_EN_FLAG_ULP_STOPPED state check from bnxt_ulp_async_events().
   The ulp_ops are protected by RCU. This means that during bnxt_unregister_dev(),
   Ethernet driver set the ulp_ops pointer to NULL and do RCU sync before return
   to the RDMA driver.
   So ulp_ops and the pointers in ulp_ops are always valid or NULL when the
   Ethernet driver references ulp_ops. ULP_STOPPED is a state and should be
   unrelated to async events. It should not affect whether async events should
   or should not be passed to the RDMA driver.
2. Changed Author of Ethernet driver changes to Michael Chan.
3. Removed unnecessary export of function bnxt_ulp_async_events.

Patch #3:
1. Removed unnecessary flush_workqueue() before destroy_workqueue()
2. Removed unnecessary NULL assignment after free.
3. Changed to use "ibdev_xxx" and reduce level of couple of logs to debug.

Please review and apply.

Regards,
Kalesh


Kalesh AP (3):
  RDMA/bnxt_re: Add Async event handling support
  RDMA/bnxt_re: Query firmware defaults of CC params during probe
  RDMA/bnxt_re: Add support to handle DCB_CONFIG_CHANGE event

Michael Chan (1):
  bnxt_en: Add ULP call to notify async events

 drivers/infiniband/hw/bnxt_re/bnxt_re.h       |   3 +
 drivers/infiniband/hw/bnxt_re/main.c          | 156 ++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_fp.h      |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_sp.c      | 113 +++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h      |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |  28 ++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h |   2 +
 8 files changed, 307 insertions(+)

-- 
2.43.5


