Return-Path: <netdev+bounces-218256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD09B3BB4C
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 14:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F281858652D
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 12:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8D031578E;
	Fri, 29 Aug 2025 12:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ZMUQgMkl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f225.google.com (mail-il1-f225.google.com [209.85.166.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63811D5CD1
	for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 12:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470655; cv=none; b=M6ouw0J2qnZvMTmNpBlsZ2IEtSKB/V+Kd41njXh/t40EP+3QEtS46L9AYpSi7uIHdSULiCqNEU/YoDb1XjyjdrdaAWv8Zf2g2n1EFeF7OEC+Gti7x/pRZoOeuL+Ml5Dc89UOCA/knnGaYm+7wWqzZwqnuxG8r8N43prj0S51mB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470655; c=relaxed/simple;
	bh=lar5Fqgne8dQ9mMEZnq4D4ForA5Ob5wZBJIiZjhgN1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SrDNOhmD//BQIGrvY2Zl6eoYr41kVe4csCrHSW9UNAgIw+Sg3/4560jCAM7Wfx09NRHjZr1G72JSZP75pjSW5IipPe5i2OqLqk4mRdsmmpU19Pjk4UxzFaCqshtdEbSENX79u5SeaR00/bSNO/HT8mgLImmMXo2QsjcnENeMids=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ZMUQgMkl; arc=none smtp.client-ip=209.85.166.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-il1-f225.google.com with SMTP id e9e14a558f8ab-3ea8b3a64c7so8402335ab.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 05:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470653; x=1757075453;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5GnqKOnW5BpFyiRDa52fECtVjd022u+EygDiNyg3D4=;
        b=C3rKK1fByZgmWFgCja0kIzKwR9fDlnubRUdsoDusJE5hoeYF7nmZuE1loZIyHFwKpY
         N9t4xNsLqQbfYwCNbQoGSe7C0C9Kv6wa5zh/AISmIqt7l0TzCwgUHFI4rzZOCTgE8jwi
         9cG+dBFl1TUv+YqJVnhdCcoj2fBzfBiqt6dMcfKqiXpq/+p3E5WgaOmqjf/OwCuWjPSB
         RXtD98i4ToxyjaY1lGYrj3C6dqBnJM28LXck9Q59/1KD9FOElWnVNNdrviwkgE62qxHM
         JvzJueFWZ68/98+zGre/o2IwwV5tdVd0cj7sPfrG6KVMbv90IjCJ1d4kuZSvOoPJ04Xi
         +Ybw==
X-Forwarded-Encrypted: i=1; AJvYcCVlrdAIQPfm2bqwRDaZAyKPX+km9U3yRgN+RjA6At9TvKNb+mhT05Wo0CVjDIJAg5VctCGCmM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJqAcq4I1im5wTKhRebHKE4BTBi8hkOAJvoUILUk0SpeD3mB+c
	nAg5srsMRjm7flVe3I7BqPJiYllB038TUWaK+DarHu2KUVPOhMlyiHufgXAi0w1mn1wK7Gwbe3T
	eP4AYHbNhuxrpPFhqmkoFptogVnqds+76rZhSsskXKleNusda1UxdczGd4A4jJyEx7xbyrfumG6
	Rz9nNY8uVZdYExhnrIysITXq1qR9vUcEFqtz1+tztT6ZaqyIa+ZI7ulfqDPyeqthrRd3HdFTRs7
	KCOcaMbtC1g
X-Gm-Gg: ASbGncsl/dDHPIC4KI2NzZ8kJTsAWmBmn/m1lJd5RoNu/YUOEJ2YTfB5Aj27l+PL0Uv
	iD3Zlfjqc2YmuAaM8gYb0JTsosxj5SSrr9Y8VsGPhA1kE/u2cbLQtyisCyqIYt7CUWYep2Z9JdF
	jWFcwMsAKgKjLTGSnsuXlrOuw+9aPmPxLwN12JPa30OURREUJHX6cUi1InnjqG+90vf3fIN/H9q
	rAbn/opjBiInpgsgmplu+/+3neHosecuP+f9EOi/YC9DZr7C2eU9rJdhI2Qd9N70SZa6SIb7PKt
	DzWyWoJe8UFgiwLWW2HMMRBclWfqlRbRrYLkiOH54PdWG+qY+q2v+gyLtZlISNG8+BTOTnpp2bq
	15uLjNBXTJyZzEZoXVuqr6ZEcTtetHKDY9xcIWKZ/5VjKInjYani4kWIhZTzSc9qn3eNSCVh2FH
	bw
X-Google-Smtp-Source: AGHT+IH3qw8C54t+jH8IDt2QU0ZZiqL4aEuAOuppEMKPV2g6u1f38b8wmPnCzAT7u8bFPlHEXi5zgUaHe5KR
X-Received: by 2002:a05:6e02:b26:b0:3ed:2399:5109 with SMTP id e9e14a558f8ab-3ed2399545bmr243837455ab.20.1756470652640;
        Fri, 29 Aug 2025 05:30:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3f2a159db7bsm1429885ab.38.2025.08.29.05.30.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:30:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e870315c98so686778185a.0
        for <netdev@vger.kernel.org>; Fri, 29 Aug 2025 05:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756470652; x=1757075452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5GnqKOnW5BpFyiRDa52fECtVjd022u+EygDiNyg3D4=;
        b=ZMUQgMklyTX88abAIsJBTQ9Fj0/aWssUt2HoIipMBRvr3rOOG/rUj9TYdBbf8gHkw1
         n6pd1cFOUK/eYmVDfOwxJTB8wmbNkGq+GNbleoaxSTXX3p1+/OCaiiM2TrKPD3mcwg13
         6hUBPMgkzFVurobnokPjfnf+3n3UvL/9GLOlY=
X-Forwarded-Encrypted: i=1; AJvYcCXlQDmZEQ7arh9PO98nvUEHZszJ/RGYHlK39EjGLLu5cQPOIsLfLi5XedepQzgsYOi915kFnRo=@vger.kernel.org
X-Received: by 2002:a05:620a:1990:b0:7e9:f81f:ce94 with SMTP id af79cd13be357-7ea110a9e21mr3035700485a.86.1756470651602;
        Fri, 29 Aug 2025 05:30:51 -0700 (PDT)
X-Received: by 2002:a05:620a:1990:b0:7e9:f81f:ce94 with SMTP id af79cd13be357-7ea110a9e21mr3035695485a.86.1756470651022;
        Fri, 29 Aug 2025 05:30:51 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm162384585a.66.2025.08.29.05.30.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:30:50 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH 0/8] Introducing Broadcom BNG_RE RoCE Driver
Date: Fri, 29 Aug 2025 12:30:34 +0000
Message-Id: <20250829123042.44459-1-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=all
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This patch series introduces the Next generation RoCE driver for
Broadcom’s BCM5770X chip family, which supports 50/100/200/400/800G
link speeds. The driver is built as the bng_re.ko kernel module.

To keep the series within a reviewable size (~3.5K lines of code),
this initial submission focuses on the core infrastructure and
hardware initialization, including:

1) bng_en: Auxiliary device support
2) Auxiliary device support (probe/remove)
3) Get the required resources from bng_en
4) Firmware communication mechanism
5) Allocation of ib device
6) Basic debugfs infrastructure support
7) Get the device capability (QPs, CQs, SRQs, etc.)
8) Initialize the Hardware

Support for Verbs, User library and additional features will be
built on top of this patchset. hence, they will be introduced in
the subsequent patch series.

The bng_re driver shares the roce_hsi.h file with the bnxt_re
driver, as the bng_re driver leverages the hardware communication
protocol used by the bnxt_re driver.

Thanks,
Siva

Siva Reddy Kallam (7):
  RDMA/bng_re: Add Auxiliary interface
  RDMA/bng_re: Register and get the resources from bnge driver
  RDMA/bng_re: Allocate required memory resources for Firmware channel
  RDMA/bng_re: Add infrastructure for enabling Firmware channel
  RDMA/bng_re: Enable Firmware channel and query device attributes
  RDMA/bng_re: Add basic debugfs infrastructure
  RDMA/bng_re: Initialize the Firmware and Hardware

Vikas Gupta (1):
  bng_en: Add RoCE aux device support

 MAINTAINERS                                   |   7 +
 drivers/infiniband/Kconfig                    |   1 +
 drivers/infiniband/hw/Makefile                |   1 +
 drivers/infiniband/hw/bng_re/Kconfig          |  10 +
 drivers/infiniband/hw/bng_re/Makefile         |   8 +
 drivers/infiniband/hw/bng_re/bng_debugfs.c    |  39 +
 drivers/infiniband/hw/bng_re/bng_debugfs.h    |  12 +
 drivers/infiniband/hw/bng_re/bng_dev.c        | 539 ++++++++++++
 drivers/infiniband/hw/bng_re/bng_fw.c         | 786 ++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_fw.h         | 211 +++++
 drivers/infiniband/hw/bng_re/bng_re.h         |  86 ++
 drivers/infiniband/hw/bng_re/bng_res.c        | 279 +++++++
 drivers/infiniband/hw/bng_re/bng_res.h        | 215 +++++
 drivers/infiniband/hw/bng_re/bng_sp.c         | 133 +++
 drivers/infiniband/hw/bng_re/bng_sp.h         |  47 ++
 drivers/infiniband/hw/bng_re/bng_tlv.h        | 128 +++
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  10 +
 .../net/ethernet/broadcom/bnge/bnge_auxr.c    | 258 ++++++
 .../net/ethernet/broadcom/bnge/bnge_auxr.h    |  84 ++
 .../net/ethernet/broadcom/bnge/bnge_core.c    |  18 +-
 .../net/ethernet/broadcom/bnge/bnge_hwrm.c    |  40 +
 .../net/ethernet/broadcom/bnge/bnge_hwrm.h    |   2 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  12 +
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |   1 +
 25 files changed, 2928 insertions(+), 2 deletions(-)
 create mode 100644 drivers/infiniband/hw/bng_re/Kconfig
 create mode 100644 drivers/infiniband/hw/bng_re/Makefile
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_debugfs.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_dev.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_re.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_sp.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_tlv.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_auxr.h

-- 
2.34.1


