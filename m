Return-Path: <netdev+bounces-225295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02E5BB9206A
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 17:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 673912A6E2B
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 15:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF3A2EB5A3;
	Mon, 22 Sep 2025 15:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dx5XclZ/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF742E7F2D
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 15:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555801; cv=none; b=i2+ro2m7z3gW1B8R/SXco8xuniH5wd9NLpTU4GfAYiXYRsydYFvGEHaBZ4sQbA7gI+D7mdBnEx39z8Ud6PI1hP3K4uuA4WwjeFvGbqCC+mp4N5ozEY/6AXQZGs70WvJdvSHx7lMbvFIEBd2y3pjb/+77UzgJPF6C/tp0XVSMFL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555801; c=relaxed/simple;
	bh=eT1q/ggLAI9PLCKRueICnDHYAAU6zPP6XchIZCEilWk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AE7ysfB6t4CdLHcl8lVPQ+ywC7F+tWFYao4pPC4mQO+iDI4A07MeEU12vmrbF8dsI0pOCcetaCyzA90jW0VgQeCENelyvvSFhMu23r0+lT9KeOFGc6TleV/16XUYqOOv/PGkQvDOOfIJQTBFxbcFxfzIZXGJ0N4Hv1XHO8MqAFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dx5XclZ/; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-30cce8c3afaso4202020fac.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555798; x=1759160598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e/1hUL2jvV8omMh0VOz9ss1Si9bOzTUncZ2FZRE+Kng=;
        b=Rz7HDon0au7rHpm5RPE5xbifColTzj6sZXPw3OY69+AX7UqwlOhyRy9WODIFevrdkC
         beJlwE2nQvsGnDWakB21+TL4+PUVm84UJobo+lSmt+7qjOfL++HgDTg/fQxei/p7qFYx
         uJt/xuWrPF4oi9pOo6d9uIXu5a28nvsy4pSvYESC/zG2gblcZhQ5V5KLdG8fuVaIH6lx
         4+MvTECIx57beUbg8vZfD8FkPgfWE55ACFXNNkkL2GLlJFzNaSF5x+dgh1iNagqJ9qyc
         bh2zqy1NID2VeADByh+jTlW2zlv2371dgDRZ2Np52uLB6Bnmaugkk1EQNQluNTsnHjsD
         o1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCjq3tMaih/OE51NsrbnaJSzpms1PDuVVifqnIMISEh0ZXVKnl0ki8/PqHbOV/gXPFQu45X48=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf/xavKFAnkZfHyCB8E1beTDBw7W6C80PfHarpWgo8JcvXkD9P
	0vARqerGtcXflh3X+cOdf0gCXegll07hsRUI/bXoh07pYooUeBIu46BORgDjD1RQFIeV8sbD9w3
	X95K9SfjleKppQq4E3b3zLHn2oyUJOjqQindRlHHy3Jc9BZycGoLBQKeuRQYTAfkLifwFWMwgqm
	dNWEPK/L5RIiik8aSLcNfRHQrmYVBbu4sAf80DJODMtQALnt9Rg8FAWYJMxg/owKsPxrQbgx6xq
	eeULRjJNkWw
X-Gm-Gg: ASbGncuWQYKJp+sB/xcgY2n/hx1TeNynpsFUHBHhnAQ435QJ2Dg3nUn701r/BTmfSIS
	EJ07JoZych9KX7/9oN16XvmJi6ogWcMeBmDK6saO5KX2W6Eu/NJGUCLLARPQMcf/dam+kxGxZui
	F3AZq4MmZAM04Vf73ewDfAGEOojm+vJmlmy9aZBc94wvyQFSnuuxbqKKq6VX3WF+kBpqOpzev5C
	YNeN790eLpH9/a5vLwVYqYsYTLIVEya39YToyNFo6lKD/7I1tFPmjg/iyb9IFeYCE51xL8QE2uO
	HEt6waRdO2bM9QT3cccwpTSjm9brKSTDqXOg/CGObS4vGroQHxdRYL/ZCd2eGXkFNftSwqzFovg
	IBKxrPaqz6amZR3rw5t7qiUpnyg12uc/ILVHAgi4R1TgsKjjdoNYJ+2tBYP6mZJ4h10vED2cnjf
	Ve
X-Google-Smtp-Source: AGHT+IFOOusK3dZYkpQAa7oPgF1RSOeFFqxlAFV4cJ82cq0WC5NRcmgXeNjwkljsLJRvO/va76MG1MWfGIvE
X-Received: by 2002:a05:6870:64a2:b0:30b:abec:23ff with SMTP id 586e51a60fabf-33bb4414ff3mr6700513fac.33.1758555798480;
        Mon, 22 Sep 2025 08:43:18 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-336e45522e2sm1064530fac.4.2025.09.22.08.43.18
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:43:18 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4b49666c8b8so79762131cf.3
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 08:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758555797; x=1759160597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e/1hUL2jvV8omMh0VOz9ss1Si9bOzTUncZ2FZRE+Kng=;
        b=dx5XclZ/kucp1bkoeA0YPbRNIWdZlC9gm24w28oca6E1cNvs/vbiDXUUSnvXWBJO6O
         KxosUCaTDF+xLEkORkacmpPwbFGVz900EVd9ImXUnlnPFCTCZQuCRIJD4r+W+vg1Q35W
         kZ3W2BRIv1PU1EfBpigflo0TnFJF+SQodq1fo=
X-Forwarded-Encrypted: i=1; AJvYcCVYRJmHJ/nMDcLuvCd5/g3F0x6j3UtNQBFWEaEO7Yzac4bD43dYMFIHtMGqzg3QhymkMPARqlo=@vger.kernel.org
X-Received: by 2002:a05:622a:198d:b0:4b4:9489:8ca9 with SMTP id d75a77b69052e-4c0720abc46mr145056151cf.54.1758555797420;
        Mon, 22 Sep 2025 08:43:17 -0700 (PDT)
X-Received: by 2002:a05:622a:198d:b0:4b4:9489:8ca9 with SMTP id d75a77b69052e-4c0720abc46mr145055741cf.54.1758555796819;
        Mon, 22 Sep 2025 08:43:16 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84ada77bb17sm179496785a.30.2025.09.22.08.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:43:16 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	usman.ansari@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH v2 0/8] Introducing Broadcom BNG_RE RoCE Driver
Date: Mon, 22 Sep 2025 15:42:55 +0000
Message-Id: <20250922154303.246809-1-siva.kallam@broadcom.com>
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
======================================================================
Changes from:
v1->v2
Addressed the following comments by Simon Horman and Leon Romanovsky:
Patch 2/8:
  - Remove rdev_to_dev check in bng_re_add_device.
Patch 5/8:
  - Remove uninitalized variable rc in bng_re_process_func_event.
  - Remove unused variable in creq bng_re_enable_fw_channel.
  - Modified the switch case as suggested by Leon in
    bng_re_process_func_event.
Patch 6/8:
  - Remove unused variable cctx in bng_re_get_dev_attr.

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
 drivers/infiniband/hw/bng_re/bng_fw.c         | 767 ++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_fw.h         | 211 +++++
 drivers/infiniband/hw/bng_re/bng_re.h         |  86 ++
 drivers/infiniband/hw/bng_re/bng_res.c        | 279 +++++++
 drivers/infiniband/hw/bng_re/bng_res.h        | 215 +++++
 drivers/infiniband/hw/bng_re/bng_sp.c         | 131 +++
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
 25 files changed, 2907 insertions(+), 2 deletions(-)
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


