Return-Path: <netdev+bounces-229086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E80EEBD8162
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 10:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE831923A32
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 08:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9982D9ED5;
	Tue, 14 Oct 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LTM8Q34Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB1246BDE
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 08:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760429050; cv=none; b=un/Ii9oIEQOflFWi6EVA1qOnYCtgstqEaAvCdT6d/ZXs6cI9ql9FtFpjZYxfDz1II5XKT1KY7rz/+5d8jKO4b7i13aTF+Rj9rCs4tFe1SmyiZlfV1Q4Y9O5SMJmoOA/+UEcWBSN9rC2K2spb9uQkIug/AM1PGPs1ZE5F5zAv/UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760429050; c=relaxed/simple;
	bh=aX14QYg1WWxupA33Q6qKl8zNmdlRV+8EA6RIf7QQl6s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rWUYcVkB2/h4g2f9FNZn1tGdx8GmwXDc8cmq9ZOMhYLyb40lF2MrUsyBdVAuX8+ECzRWkQAumjg7h3PEY4DeX1KEcwci/xl4FWPPHPx5n78VHFPqQUXgpXxDw+JLljNlyAP5PgW1r8FO8dDEGjwck/Kcs/Xmr1u1gIbElrVInto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LTM8Q34Z; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-77f343231fcso3077230b3a.3
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760429048; x=1761033848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mi7Th4y9l7uaTraSp/Z6NDmdhrKUxJgDI9LshZQNn90=;
        b=KqbXfWpW5wU6O8vUsWkBDmcCfFu6b2ASvyEbuY/d816PXdc4Gofelj7HtRpvr1pBmE
         JdfdseM78WSo3KBPzhIAP16Q3/Eo9yLoR+apTPp09mNaM10ZgqfBm56zx4SdYSb64NMw
         zFY4yVXNteYT5/ja4Z2+c0XfRyuZtBwDG+FCh8LMSwZGWzSjOcceAJqqDbDsoSG/2bZb
         56ct0GSLJD9SwEWVpFOfggJLeyGWoBa9CIHmB9nO1P7xe3O9NJ/Vn2vYbNZxdM6w7tig
         Ycd5SY8oM5DHTwIJnps46aHnNL9v9bvHLwmYp0V2v9RX2ilkJA9F/cmdxUezSsgzE9nT
         mMdw==
X-Forwarded-Encrypted: i=1; AJvYcCVNJ7ZlZiCJph2VDZFyNH7RVdKI4awL8igBwsRXzN75f60J5NHQqUz22VgvSa+mhmtRhBDQSuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIas3Rt9SX0o3LB6FuMO78gjucMls6pzcuQHIVxCot3YKuth80
	AO+D0hegHWcCeEqeb/Y44W5bgT+MYmAZ614D0zOUBJj8VLTfYN5cj9KB9OXm2zanTX8h32NKcRx
	YIy7LtJfYFAnOrvVzMFsfHhLmWYGabXJQkSt0cy6RBSIosEmqUOkKB41G0jM4MdCle7HIVA/D8Z
	fRRMTQYxpceE8CgOmTCW5dPwSISXteg7rWgFRtXkxlrbESepeB2uirmF+h9yEFAsQ818G35Sj9F
	N0QhDx8LQ37pw==
X-Gm-Gg: ASbGncuThB4/DCoy9nZsJfxleNOFdnrsmhqQE6AIC2mkXfsfW2RWYznGNdLFocAeSWq
	Scc6qJzDMikeZeRETKYXOpFdnMioFDYZtBcClux37p1StOrRWxXZnfGQV46RKiHSOBZNHsBFBeS
	dQij6fwhW5aEeys5hcrmLnoRG30GcgVNNUo1KA7/33GnERYGb8UuM9iiWtv/fymorq5qrsnKnfs
	N8rxwNXaj98t4ipBcSCrU05htpTiKol6SaCsNKPlZjQC92ft0Z1QczMR8id1JJJ843SuuqOI0qM
	bnSCDt/83L9efBkvBMuy2d1C3yMu9D21BOd9LkmoaLgRWu1Jeo0FXuFKdGegtQZiWjVYbcV56+G
	RzLtwHyNFrws68bXTzYUE7DXwB+RZR/Y4uVOoj9YEQStrjTmyytDB5+5m/3JsUIRezfZqcjy/7h
	MNqw==
X-Google-Smtp-Source: AGHT+IHrJRQI2Shhn3V51/iUd7DxGnuZpw07pcJibLUMa7Lr93PSJ7Bw3955/3zzHajVfn0sEcu2661kmkI1
X-Received: by 2002:a05:6a20:3d93:b0:2f6:ec69:d448 with SMTP id adf61e73a8af0-32da83e389bmr33118825637.31.1760429047731;
        Tue, 14 Oct 2025 01:04:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-b678df0fd68sm715752a12.11.2025.10.14.01.04.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Oct 2025 01:04:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b632471eda1so8946824a12.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1760429046; x=1761033846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mi7Th4y9l7uaTraSp/Z6NDmdhrKUxJgDI9LshZQNn90=;
        b=LTM8Q34Zt6a0PNzOXoN2ShMP0EUeVVNZpfQy9KUt4d5gVgfW0WxSVDFScYDdasSWvC
         kJ2iZcZloBg3JxO0ucp9Ofo+PAz4pS+Q196YhSA0GzSrB3g4tXEo4VflI0XfyNzcsoiu
         SJwYfFeqzBwUlV0U+Qlg8fZZ1AobPI23mpNOc=
X-Forwarded-Encrypted: i=1; AJvYcCWI8fiI+HAqQgb6aGsHsQISiTGT9BgZ+IlW8gBV+keihrmyB2Z3WF1/s7zYo8lvg6t/mQp3kvE=@vger.kernel.org
X-Received: by 2002:a05:6300:218f:b0:2e2:3e68:6e45 with SMTP id adf61e73a8af0-32da8462901mr33356431637.51.1760429045890;
        Tue, 14 Oct 2025 01:04:05 -0700 (PDT)
X-Received: by 2002:a05:6300:218f:b0:2e2:3e68:6e45 with SMTP id adf61e73a8af0-32da8462901mr33356395637.51.1760429045488;
        Tue, 14 Oct 2025 01:04:05 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-799283c1a14sm14329716b3a.0.2025.10.14.01.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 01:04:05 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/5] bnxt_fwctl: fwctl for Broadcom Netxtreme devices
Date: Tue, 14 Oct 2025 01:10:28 -0700
Message-Id: <20251014081033.1175053-1-pavan.chebbi@broadcom.com>
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

v5: Addressed the v4's review comments as below:
Patch #2 and #3: Simplified aux bus device creation logic by
having the core maintain arrays of pointers to aux devices and
their contexts, thereby avoiding function calls from aux dev.
[thanks Leon]
Patch #4: Used memdup_user() as suggested by cocci. Addressed
additional review comments from Jonathon and Dave. Collected
Rb tags from Dave.

v4: In patch #4, added the missing kfree on error for response
buffer. Improved documentation in patch #5 based on comments
from Dave.

v3: Addressed the review comments as below
Patch #1: Removed redundant common.h [thanks Saeed]
Patch #2 and #3 merged into a single patch [thanks Jonathan]
Patch #3: Addressed comments from Jonathan
Patch #4 and #5: Addressed comments from Jonathan and Dave

v2: In patch #5, fixed a sparse warning where a __le16 was
degraded to an integer. Also addressed kdoc warnings for
include/uapi/fwctl/bnxt.h in the same patch.

v1: https://lore.kernel.org/netdev/20250922090851.719913-1-pavan.chebbi@broadcom.com/

The following are changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:
  Linux 6.18-rc1
and are available in the git repository at:
  https://github.com/pavanchebbi/linux/tree/bnxt_fwctl_v5

Pavan Chebbi (5):
  bnxt_en: Move common definitions to include/linux/bnxt/
  bnxt_en: Refactor aux bus functions to be more generic
  bnxt_en: Create an aux device for fwctl
  bnxt_fwctl: Add bnxt fwctl device
  bnxt_fwctl: Add documentation entries

 .../userspace-api/fwctl/bnxt_fwctl.rst        |  78 +++
 Documentation/userspace-api/fwctl/fwctl.rst   |   1 +
 Documentation/userspace-api/fwctl/index.rst   |   1 +
 MAINTAINERS                                   |   6 +
 drivers/fwctl/Kconfig                         |  11 +
 drivers/fwctl/Makefile                        |   1 +
 drivers/fwctl/bnxt/Makefile                   |   4 +
 drivers/fwctl/bnxt/main.c                     | 453 ++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/debugfs.c       |   2 +-
 drivers/infiniband/hw/bnxt_re/main.c          |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c      |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h     |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  37 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  13 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 250 ++++++----
 .../bnxt_ulp.h => include/linux/bnxt/ulp.h    |  24 +-
 include/uapi/fwctl/bnxt.h                     |  64 +++
 include/uapi/fwctl/fwctl.h                    |   1 +
 21 files changed, 826 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst
 create mode 100644 drivers/fwctl/bnxt/Makefile
 create mode 100644 drivers/fwctl/bnxt/main.c
 rename drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h (85%)
 create mode 100644 include/uapi/fwctl/bnxt.h

-- 
2.39.1


