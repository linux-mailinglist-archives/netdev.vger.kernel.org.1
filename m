Return-Path: <netdev+bounces-215896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C2112B30D1E
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 06:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 953645E8791
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727A3221F06;
	Fri, 22 Aug 2025 04:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PeFwcHv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBAD18C91F
	for <netdev@vger.kernel.org>; Fri, 22 Aug 2025 04:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835368; cv=none; b=QW5kFu1gW6jlQrlYem+stGA/rEFtnuDSOeyGWZ6bbHmBIrg5TTmN3OI5SjqmthLn0CBh4zSZKsueB49OpS4oCleQm3gfoyqLcLGGa5NHg6J4ksNqJRyGTGhLKuFZb/PUoMPxRQbDAvITWAJszF3vcw5XuQBL9fyz9w1apQHPemo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835368; c=relaxed/simple;
	bh=ljgXtCbMutgZoiP95fUzEdlrtbyCvK47QZbot9u60JY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UiuGj1LoPJl75aWUXE+HLqDMMRb6CYvpi8okL+886aAWrIkgDoyWoxgL0QFQLimVriNbACDDDH43S6MH/BRpatwOhhDbucqs+ZDEHp8q6W/0AbRuyn4LtQ3mdCTjpE+peesQ+IQ2X0tdUqg9NFYfeZEuancCG4KBIISKwkQDf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PeFwcHv1; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3e67d83ed72so15896565ab.0
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835365; x=1756440165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4iLTbNCQWmFelHo92CQb3hcDOCGRqAUjKsZcLfgPSU=;
        b=K/1HkpoecM28G0rnBChD5E/pCeEkUvD0D/jTxYu5XMTqdJJkyMC4hfmfdTn0Rt8Ccu
         Syf9p1j7vJaq5Cc1GNyEJWMZ8kXOgSFtXq8sCRktMh4RKoMTbOP1rAE5R1hdg/TIA+aZ
         DS/3QowYlNByoZ8ev9b7B42levSP1ihEv56mZ6BrVt7QgqKpqy5/XD1kiw6WXDu2rVxO
         WAF8GJ80ixFLJfCsYLe+/iUkPnphE8VuYJDcTR4jQUq6cNmWVVpjR8p2Hs7yYsMjIdpL
         FkPwmtkX9Bm2LTw+rijCcIrroVeKlZ0w2QWIVlBfKtlvODql5rkSKD5lQ0rTo07bctY7
         +cjA==
X-Forwarded-Encrypted: i=1; AJvYcCUXdYkfKtpEATJYYMOFy1Kxv4W/as3NrffM+TxLjdeyc4HOTSRmPQciaQFe0J/VD9CSD5EdKOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyhWci6veCsrFwXiTSY8pQ7dTpGtZ5t2cnd3eKgGywXWWCO9PG
	06/AuC1u6HeBNf+JsIL8twCRScB0sRO4d6O/1j+x+I0QmO8LZUaWFyKDvPqHvtnMtJz7rDx06P0
	TcXKf4jbLXLCaKdAsbNv+hyFI0cAOhUsSdf6TK/KRkdVsIYnglyC8eShdiho7mTKwE6a7DV67NV
	pBhB+XOW4zAbcvmf1UAQvDS2+LRfNnFD0gmzqyABzK/PJhprdJToMqCkLp7ybjNoMb3rBuR/lcE
	X1RpVMJUF6n9pdgTubX826o
X-Gm-Gg: ASbGncsdEJioRYxO5NbGUKhvvrQrv9dwC3mHgTIPCMYzMxNGMRSHTtZvqHZNry7IZGG
	KefQPmr6eg5IPVed03UOEr7NT7C5GXENRc8qHWJ7hPZRvzSVyaaZsR9ZdziqDyNN5CwkTO0+lG9
	c9c0y4eY9bbFTFrTpF1+ayil7eWrYgmWoVz6MkQsyIzsQ59vNEx5W/iJpeKbgQGe3MTC0ZqdSPL
	QMpTtkaqALqxA/VpLUrlNJjWXIPjaDN/oTeP4cCINfwEEY6doBV/Q2E+PCnVfyhi7JzI5GhUWS+
	ReAJDah8ZdQUGw4Vy+0ji/06pHZmi0fm3TBIkHE5JDMg7epvqMwFQzGQAsaF97+TnDSiUeu1ugi
	q0YLLihDX0H51OyrQnUmqVk6J6n99MWOn9fx5BT/1CziyUCZZS4towNuJdoCwOl6G0i9tkKcUn/
	vETOUItUbWpXUv
X-Google-Smtp-Source: AGHT+IH6ewReNB0gouq+D8/P++ycsHe/r1pl/VgDzx/c44ZH54t9pAZzsyIRK5+AH6P+GzKWHOTOOmaKuEMY
X-Received: by 2002:a05:6e02:2781:b0:3e5:5ac7:d8e2 with SMTP id e9e14a558f8ab-3e921c4aacbmr27993505ab.17.1755835364746;
        Thu, 21 Aug 2025 21:02:44 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3e57e7739e8sm13155475ab.47.2025.08.21.21.02.44
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:02:44 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2eac5c63so1602596b3a.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 21:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835363; x=1756440163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a4iLTbNCQWmFelHo92CQb3hcDOCGRqAUjKsZcLfgPSU=;
        b=PeFwcHv1rEWYdv+1OG0waLOneG1wr0OcIQK1qOWgX03dE04jeIsbCkroeteUwX/Djd
         n21TQImAmzvRnsp08vV42M1APwb42UVx6kfo0kgsenEWRHkT0YkMjX/8sA1XlSYsaJ6v
         IaWMQdEEVV+G+bJ3qttEsPccgYSxA69V5LHtg=
X-Forwarded-Encrypted: i=1; AJvYcCWfv/J9fNPkCSyDLJ+WhoTyI/rYRVLPoDW3O/78vtvdA92W5R4pIB/bxh8NdRpt0b8Qcne1Vdc=@vger.kernel.org
X-Received: by 2002:a05:6a00:9288:b0:76b:d67b:2ee0 with SMTP id d2e1a72fcca58-7702f9d7f70mr2458291b3a.6.1755835362753;
        Thu, 21 Aug 2025 21:02:42 -0700 (PDT)
X-Received: by 2002:a05:6a00:9288:b0:76b:d67b:2ee0 with SMTP id d2e1a72fcca58-7702f9d7f70mr2458253b3a.6.1755835362264;
        Thu, 21 Aug 2025 21:02:42 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:02:41 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 00/10] RDMA/bnxt_re: Add receive flow steering support
Date: Fri, 22 Aug 2025 09:37:51 +0530
Message-ID: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

The RDMA stack allows for applications to create IB_QPT_RAW_PACKET
QPs, which receive plain Ethernet packets. This patch adds ib_create_flow()
and ib_destroy_flow() support in the bnxt_re driver. For now, only the
sniffer rule is supported to receive all port traffic. This is to support
tcpdump over the RDMA devices to capture the packets.

Patch#1 is Ethernet driver change to reserve more stats context to RDMA device.
Patch#2, #3 and #4 are code refactoring changes in preparation for subsequent patches.
Patch#5 adds support for unique GID.
Patch#6 adds support for mirror vnic.
Patch#7 adds support for flow create/destroy.
Patch#8 enables the feature by initializing FW with roce_mirror support.
Patch#9 is to improve the timeout value for the commands by using firmware provided message timeout value.
Patch#10 is another related cleanup patch to remove unnecessary checks.

This patch series is created on top of the below series posted on 08/14/2025:

[PATCH rdma-next 0/9] bnxt_re enhancements

Please review and apply.


Kalesh AP (3):
  RDMA/bnxt_re: Refactor hw context memory allocation
  RDMA/bnxt_re: Refactor stats context memory allocation
  RDMA/bnxt_re: Remove unnecessary condition checks

Saravanan Vajravel (7):
  bnxt_en: Enhance stats context reservation logic
  RDMA/bnxt_re: Add data structures for RoCE mirror support
  RDMA/bnxt_re: Add support for unique GID
  RDMA/bnxt_re: Add support for mirror vnic
  RDMA/bnxt_re: Add support for flow create/destroy
  RDMA/bnxt_re: Initialize fw with roce_mirror support
  RDMA/bnxt_re: Use firmware provided message timeout value

 drivers/infiniband/hw/bnxt_re/bnxt_re.h       |  13 ++
 drivers/infiniband/hw/bnxt_re/ib_verbs.c      | 146 +++++++++++-
 drivers/infiniband/hw/bnxt_re/ib_verbs.h      |  10 +
 drivers/infiniband/hw/bnxt_re/main.c          | 221 ++++++++++++++----
 drivers/infiniband/hw/bnxt_re/qplib_fp.c      |  12 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.h      |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c    |   4 +
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h    |   1 +
 drivers/infiniband/hw/bnxt_re/qplib_res.c     |  38 +--
 drivers/infiniband/hw/bnxt_re/qplib_res.h     |  21 +-
 drivers/infiniband/hw/bnxt_re/qplib_sp.c      |  43 +++-
 drivers/infiniband/hw/bnxt_re/qplib_sp.h      |   5 +-
 drivers/infiniband/hw/bnxt_re/roce_hsi.h      |  41 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |   8 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   3 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c |   6 +
 16 files changed, 486 insertions(+), 87 deletions(-)

-- 
2.43.5


