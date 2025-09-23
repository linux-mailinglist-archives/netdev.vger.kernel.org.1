Return-Path: <netdev+bounces-225547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2215AB95514
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 11:49:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BBF3B5F84
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 09:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046C8277CA5;
	Tue, 23 Sep 2025 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Rgs0681c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3311946DF
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 09:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620988; cv=none; b=n9BcFcWZXYI4Af9OAPvSg/mT4F74W5hqcg5i8YBaRdtMmPybuPeXlkDlbC3/6WGOhdJayMdyedndgfECUaYt7v2iWnT8xumnKT6zrNt2ii1070AdCWicP6vzBbUvv1NJ/xBcNhgXsQDcLUIEzf2mbsELeQzdBLvy5dG/Avu9d+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620988; c=relaxed/simple;
	bh=vcTS44DcjyuWD9QQxgLxCLugiXIfQQT6oZh/CTYWCBI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GFZWI1jBB5Ke7tcLNyoKhy+1yVL158sa2OV+mZX0FhZ5c18QCH5MOaSt4GruzG98EY0UFAOmIWtzB66segUc23pCrIjEUfqogLFhbjzm2x3kaOVhjYD+kPGIkNSIWGKHGTcTVZdczhNae8RfSTtvjhDjpvQMb+9TvTZBtVPH6HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Rgs0681c; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-78f75b0a058so45708516d6.0
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:49:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620986; x=1759225786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rVBwfIrGxQV1nhM9NbyzDjoxdVuU4nQ14B2cbTK8+w8=;
        b=kFyf5vG9dlLTzTo+qi2IESalhFW4cOeA2LF0JsEPOLdKhQLY8SOGTfh5RazkbPTEKS
         KxU2H5pQrUeITvW5Hv8208zhBqiE3wKVPPvGCuSHvPX4Or9PH/vSPZN8ybY+KJRx60Nf
         jaGhrNYLbxuwngE2P+cSnb6Be7FwlnR4GcRV2dmsCFSqXx0JsdNfMZ4+2AWeAjB263lF
         xll9HR/4aU6zalAYILPSLplOS9+t3z2pNjXxaFWVARvK9BXE7gOTRrh82KVbdHqjGpSw
         +SbCi1zehJRWFPLxx8fpSKS59eqPxzGImO3bTCZQpMUEU/mKcjJuoLTonZes3zRXO+Jn
         pAwA==
X-Forwarded-Encrypted: i=1; AJvYcCXMvFPnbQYD1A/rGs29MS2InRoE4WYrZMRyrhTTKU3LLqnVC+pwGjAifTH0lqNjIf43eB72p+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW4bLn35Oa97FfpFvIUFcV31He6hk0qdNyuL7Mf2wCKt6AfDO4
	HOF6yelvsMdWRMU28kikEKg7+QpHb21qEJ3UHFOgYuMWjDesg1+VhzQ6BZkIFDAqP2txDd90UWD
	fVNERMZVW44a3ZkxuzZuCWx8He+MO53rTCfNmXGh/0rw+KKL4by3/a/6q1a46ogfjTf78KdVpSo
	NTs0C+mw6+GI8HvNGotHZnGjev4cYv3KH+HTQ4+NaF8wZGjt9xtFGHH5yH+T8VrQrkWZSN38enF
	m+cU7DE/ow=
X-Gm-Gg: ASbGncuj05in9wLdwneJkApEpbNpysAhm0PWGepAdNUsk1p5DksqRMcY+B0fqQ7mcwS
	m3RtSTA0AAbFPuCecvvcuco9zX0hWh1zjyXF3j3g9PK3xlsFrh4RWrXsHe3yPY/Q09xf7Yqv+C2
	ZFtnf6n46kJaYEzvxTZT8zEFHVD3IgVa96a1I2FIpEp+popwsIRLi44Xsq9m+8PQ11tdZYjiYS4
	CnJg/NCFP+r/d1WRZfGmaFPOyOWoK+7HOpD/N6wlYHdnIydw6oz6yh9Axo+j5bC3szDIaXBQeSN
	L0prtucTOQp0C5jrfHq2/ZPAEyKCW25Sw8u9TKBrUuBnnlWPLpapoQHwQr3BPDQJkGXDW807O0A
	nnCinB4JKAiAHLTfav/7F23NAYM1rHcLo/tXC/tlAlCoycUt6qTKWRdwuUT0bNhwig4KNhPaAjI
	4=
X-Google-Smtp-Source: AGHT+IHEsIbCs0l/CpVi3fp1IvtziZDVLuvlCP1GWc/lVKFPNPNzMdfgavVgpMNhFxl3mu4IILBALJ0fX+F9
X-Received: by 2002:ad4:596f:0:b0:7e5:abbf:f268 with SMTP id 6a1803df08f44-7e71986080amr17731906d6.57.1758620985825;
        Tue, 23 Sep 2025 02:49:45 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-793456fe307sm9222446d6.14.2025.09.23.02.49.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Sep 2025 02:49:45 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-27c62320f16so11697545ad.1
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 02:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758620984; x=1759225784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rVBwfIrGxQV1nhM9NbyzDjoxdVuU4nQ14B2cbTK8+w8=;
        b=Rgs0681ca1raftWbdxz727m32znPEDomuEMA2+j8DlJUi2+NbmUgPebJ/6DAJn9kOt
         B5jq0R9eaFRt8IWMkO0uV5PhC3nrEKGxLnBW/DhIoc9Nl40X0yST1S9AwjXwzYgbXaa3
         jhzziOHemE0n8Hi1kydpdTx/t2KignWRVqEYs=
X-Forwarded-Encrypted: i=1; AJvYcCVA/3KhrH4QOup2UAXE6/jR49IphfiU+mdxsgCw6Aiqd1NyL2MxUSjd6RDmRtQgPhiMTw8qfJ4=@vger.kernel.org
X-Received: by 2002:a17:903:985:b0:25c:e2c:6653 with SMTP id d9443c01a7336-27cc8f01f45mr23297345ad.48.1758620984581;
        Tue, 23 Sep 2025 02:49:44 -0700 (PDT)
X-Received: by 2002:a17:903:985:b0:25c:e2c:6653 with SMTP id d9443c01a7336-27cc8f01f45mr23297165ad.48.1758620984175;
        Tue, 23 Sep 2025 02:49:44 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269a75d63eesm139105945ad.100.2025.09.23.02.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:49:43 -0700 (PDT)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: jgg@ziepe.ca,
	michael.chan@broadcom.com
Cc: dave.jiang@intel.com,
	saeedm@nvidia.com,
	Jonathan.Cameron@huawei.com,
	davem@davemloft.net,
	corbet@lwn.net,
	edumazet@google.com,
	gospo@broadcom.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	selvin.xavier@broadcom.com,
	leon@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next v2 0/6] bnxt_fwctl: fwctl for Broadcom Netxtreme devices
Date: Tue, 23 Sep 2025 02:58:19 -0700
Message-Id: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Introducing bnxt_fwctl which follows along Jason's work [1].
It is an aux bus driver that enables fwctl for Broadcom
NetXtreme 574xx, 575xx and 576xx series chipsets by using
bnxt driver's capability to talk to devices' firmware.

The first patch moves the ULP definitions to a common place
inside include/linux/bnxt/. The second and third patches
refactor and extend the existing bnxt aux bus functions to
be able to add more than one auxiliary device. The last three
patches create an additional bnxt aux device, add bnxt_fwctl,
and the documentation.

[1] https://lore.kernel.org/netdev/0-v5-642aa0c94070+4447f-fwctl_jgg@nvidia.com/

v2: In patch #5, fixed a sparse warning where a __le16 was
degraded to an integer. Also addressed kdoc warnings for 
include/uapi/fwctl/bnxt.h in the same patch.

v1: https://lore.kernel.org/netdev/20250922090851.719913-1-pavan.chebbi@broadcom.com/

Pavan Chebbi (6):
  bnxt_en: Move common definitions to include/linux/bnxt/
  bnxt_en: Refactor aux bus functions to be generic
  bnxt_en: Make a lookup table for supported aux bus devices
  bnxt_en: Create an aux device for fwctl
  bnxt_fwctl: Add bnxt fwctl device
  bnxt_fwctl: Add documentation entries

 .../userspace-api/fwctl/bnxt_fwctl.rst        |  27 ++
 Documentation/userspace-api/fwctl/fwctl.rst   |   1 +
 Documentation/userspace-api/fwctl/index.rst   |   1 +
 MAINTAINERS                                   |   6 +
 drivers/fwctl/Kconfig                         |  11 +
 drivers/fwctl/Makefile                        |   1 +
 drivers/fwctl/bnxt/Makefile                   |   4 +
 drivers/fwctl/bnxt/main.c                     | 297 ++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/debugfs.c       |   2 +-
 drivers/infiniband/hw/bnxt_re/main.c          |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c      |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h     |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  30 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  13 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 266 ++++++++++++----
 include/linux/bnxt/common.h                   |  20 ++
 .../bnxt_ulp.h => include/linux/bnxt/ulp.h    |  14 +-
 include/uapi/fwctl/bnxt.h                     |  63 ++++
 include/uapi/fwctl/fwctl.h                    |   1 +
 22 files changed, 683 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst
 create mode 100644 drivers/fwctl/bnxt/Makefile
 create mode 100644 drivers/fwctl/bnxt/main.c
 create mode 100644 include/linux/bnxt/common.h
 rename drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h (90%)
 create mode 100644 include/uapi/fwctl/bnxt.h

-- 
2.39.1


