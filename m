Return-Path: <netdev+bounces-216880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5A9B35B0B
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 13:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4026E3B1CED
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 11:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839F927AC3E;
	Tue, 26 Aug 2025 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="VfuSUeDJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC527299959
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207047; cv=none; b=C0XoP2sRVT7TKaHXVppRCifj/IEoOqZ508j7zn+de9tj7uF9yWRrTuCQDR1S7orfahewdisN9ND9nzIYCmtEhYFVERodwwZXuZ7KDRTURerePRXjes0aN8tC+HggmAbEt7M6dJTyGghq519tISViYWuJDs3kufwA3aBtxTryD5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207047; c=relaxed/simple;
	bh=riu+ZSSqC6hnX6c1iN4rk9AnA541mpnUr1tMc7KEwTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e8w9UUY6S2UW1k7SmCaY+l7TMxTzH7KAMo7HU6x+SfE5zlX8CjEf02T2fTEYP7WS5dFVroCczxpFtBgxIfBdiL1sL1074s7WUmMm6fCrSxcJgtNvUa0eQGezxjk8jhT6xksQag/fPqPnNSgsW+Ca7EjGMa69e2ikvVTfQ2ayLBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=VfuSUeDJ; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-70d903d0d59so22634786d6.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756207045; x=1756811845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2CPe9YQYoyEyzdF9vEiVB1Om4V8Yg6wNSz6wAP+t5EA=;
        b=tcl8ZaWHcFhhnyvctvjDOfbRzoqTXh/od78sKpLntKCxh2eK5W0rGrUJdvPuKNTh/l
         8T1bw8rvCAvvRQCEuclttbfI0G2A1inht91TP0JIx9G5mtMVDVyaFE9wBT294FlSKyKT
         uLz51+HQEZ7Tpjt9s59lsyUrPwR5pET8lXtnE/57C07fKnz1o6xm3jjaSpWB1U8CaKQx
         +J6ax7aGkpy41urFaC7YSAiD8OtoyK1YPahml0b4CbxUkciFW75C79dry2E4RFtXXNiX
         LzxFNw5wQEorRFEY/6/gOcyxTIs2p7V0To8O4PB8pAWw3GxGyDsyH2bPHW3cBK76iWaM
         Od+Q==
X-Gm-Message-State: AOJu0Yz8VE5hAMoGxGKkKXyK3yzuaN3PfkTlo9YhmOqB+skNvGlr+Zub
	ny0NYCTgfZNW3sgyoXq9cXkL+cvGUHD14+MY92WRdBv6JyLX2PvSc/ktY9YYhSDt6gfGHPsDn0u
	akphNIlLGjMfYytwMsgmSmjaUr9XDm/eKCHFgNK2709YI/NBYL5wVt0V5KJF7vZjw1FEQjHQ8/F
	rGGMPktJ0jeVly4H0q611wEzQbBVPvwcztJ+ZHwHQoVcbh9p4PZ2ezXHKls+ltAH3EGhDDvOdfe
	NfnvkD3j1YVDavQxZZt
X-Gm-Gg: ASbGncur6dFYYku2O31HvK5CsuLSLavdeG2B/HGFkaZEjczNmzolHBzUxFw0c1JLpDT
	2JSaR17V56GM1wVuzO5ncgaBoBBKauldRkawzF9O8J/hyT85gxxM7mTSTTuTOQnjUUVLkcTEPWW
	CVyPLNcV+5rb8nNQQsolCCsoipNAx+tSF0M7SsY3pKjUNKuS+1g3TBVyh81RmzZX9BiEQo18DW2
	DF7QaLNUGUR9j+dTrKSu6UWmC1VYUWNg701rt3+5L+BjdCKOk7QlfjrXnnl9w0IFhS+Bk9q9t44
	jPLmuQDkk5Gm7PXGDtAxC9VnaC+AU162389ZKQDs5U5+8ag2SrYLTfjwcWC9Utz7xmwqXrrFcWR
	8SEMn/Mmn6SyK46Of0V3LtW/fZ9ruMg==
X-Google-Smtp-Source: AGHT+IGmCN9SxFSNo0MnE7obF4SyatorJb8QrgAqCVOWkN3uVkGQfnb+zLnEqeZ1REJyJESKJjyu5lvGqguL
X-Received: by 2002:ad4:5d6a:0:b0:70d:95a9:6042 with SMTP id 6a1803df08f44-70d972fa85dmr173843936d6.29.1756207044477;
        Tue, 26 Aug 2025 04:17:24 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-70da6ff0b8bsm7069256d6.0.2025.08.26.04.17.24
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:17:24 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-771e2f5b5dcso2983410b3a.0
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 04:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756207043; x=1756811843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2CPe9YQYoyEyzdF9vEiVB1Om4V8Yg6wNSz6wAP+t5EA=;
        b=VfuSUeDJZE9Y5DUFFRXSbnSr5CIWb0o0ZZKim7oaCmJvtCl3oxxJi06ydVXpWUH+Vs
         x25yLnJ08l35O007LwLT4zYEleUpnu5q7av7nSvtf2IpI3wAD4bGXF5d+350ETfdrsCg
         3YBEb4sDEhJBTzui8wH+pl+U3mXT/DUnFlhLU=
X-Received: by 2002:a05:6a00:990:b0:736:a8db:93b4 with SMTP id d2e1a72fcca58-7702f9d24d5mr18463610b3a.2.1756207043210;
        Tue, 26 Aug 2025 04:17:23 -0700 (PDT)
X-Received: by 2002:a05:6a00:990:b0:736:a8db:93b4 with SMTP id d2e1a72fcca58-7702f9d24d5mr18463583b3a.2.1756207042787;
        Tue, 26 Aug 2025 04:17:22 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77054bb0c46sm7280339b3a.41.2025.08.26.04.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 04:17:22 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [v4, net-next 0/9] Add more functionality to BNGE
Date: Tue, 26 Aug 2025 16:44:03 +0000
Message-ID: <20250826164412.220565-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This patch series adds the infrastructure to make the netdevice
functional. It allocates data structures for core resources,
followed by their initialisation and registration with the firmware.
The core resources include the RX, TX, AGG, CMPL, and NQ rings,
as well as the VNIC. RX/TX functionality will be introduced in the
next patch series to keep this one at a reviewable size.

Changes from:

v3->v4
Addressed a comment from Jakub Kicinski:
    - To handle the page pool for both RX and AGG rings
    - Use the appropriate page allocation mechanism for the AGG ring
      when PAGE_SIZE is larger

v2->v3
Addressed a comment from Jakub Kicinski: 
    - Changed uses of atomic_t to refcount_t

v1->v2

Addressed warnings and errors in the patch series.

Thanks,

Bhargava Marreddy (9):
  bng_en: Add initial support for RX and TX rings
  bng_en: Add initial support for CP and NQ rings
  bng_en: Introduce VNIC
  bng_en: Initialise core resources
  bng_en: Allocate packet buffers
  bng_en: Allocate stat contexts
  bng_en: Register rings with the firmware
  bng_en: Register default VNIC
  bng_en: Configure default VNIC

 drivers/net/ethernet/broadcom/Kconfig         |    1 +
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   27 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   16 +
 drivers/net/ethernet/broadcom/bnge/bnge_db.h  |   34 +
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  485 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   31 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2202 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  252 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   58 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3122 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


