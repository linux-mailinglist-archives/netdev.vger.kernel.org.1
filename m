Return-Path: <netdev+bounces-226614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6DDBA3035
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 10:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFB50165509
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 08:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD529A300;
	Fri, 26 Sep 2025 08:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="h32SFcYS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB22C299A84
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758876651; cv=none; b=cfEtk/qcwLAM5Be0ad+9Dzyu7PIEP9E54mybt6iNMnsF9M/JztL0kph7yFlPZjyR1rMgH2xWfH/qAiYWpcbKdbKWogk9oSHX0Wpzkqsjw3xCOqb7VCXvQv4/zqAlhwX1ky6RZkV/F6DEJ7pETSQILdJ9xlwVeXa+RB/p/efHrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758876651; c=relaxed/simple;
	bh=jc+9Mwnghg2l2bQRFJhPRIKyzBA30DKAzbGjmqZDRuY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N31xYwXvkxBCTTHTNZfr128NbPiXHIDVe0vGptZp4yYyXMgoWZZ/JUHW/Eed1MLs4v6dTKmhLQduOM0ZvQ1TEaHw4ZzD7nkDyHCZAtsjKgOEk4o1v+ZMTWxNPqxR0RuTa+6mWVAfFs2Pu9mrZHhoDBx9ZP3M07oDvSd7DXo6MBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=h32SFcYS; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-b550a522a49so1721650a12.2
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 01:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758876649; x=1759481449;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JGJWSmoM+8Phql35kYHgcLi2uTPHv9JlqBXehjilKJw=;
        b=KvEc/v4yLXmxSTkIAoOrzzBRrRHfuyRmbMbt3z+PADJvsOOFrtOPtICUTq8YYcsti/
         +gSsCh2uBOUog528BntMi4KjkFJ89CShVdahqAjLDq7iCtd9T175BnZ7Ghs7XDDTSJzw
         40jbFo+RBhWLo1eIl/lmwlV6M7mbqMVShJu/CQls2U5YgRDJEB7K7m9lD6EKMBenxdh5
         YlpGJrWpXyezOXfExeXEDerNTe52cht5a3jz+N0z0d6R/SrW3vKYWOCj1ZxNgPzXTI0k
         cvjIJWqcrVkNUOkqacmeWEsDuWzHMGSJ8joDnfKwc8ZrYb4eZFee7DaBHP69YriMR0rX
         JcVA==
X-Forwarded-Encrypted: i=1; AJvYcCURi3DJ1ezlfH/VYOezAYuBpdFgBPG1ER2QctNyezVgIxi/E2fhfFflWQrOOib3q0s6js/JhRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG3Ic7n2UfBjrNd9LOD8eqIyTwLs4fNoEewESd1/9c1yWRVrnR
	ItSbCOrGwNIEeBdXi4xFym9xstCAIJsAZjZ/qNB7ELtBhIAfWO2ESSvyNeWAo3iEEZlhjWxD+8T
	9SalU6BMaUlMwKAphJhDQrMavG30LKS7LOCaKmo6179SMGQQ+uyfRZvAcd6Q3Yt+UleJC+4azF4
	2AptNJnyymcSuHt3zKR/CoLiGkeCsdCiE5pG9yVWbQqgHBIohcYeWbx5pHp2HYLB7xe7sUPwzCH
	LJ1vv6KnI4=
X-Gm-Gg: ASbGnctUjBfaW59dowW4xC/o25wK96Zh+PgR8Ona+9t+++NzOhNW/LV6eqiLsHI4/02
	e2208933AZtM7xHdbmRMGbdBFRTmdO2apT+w8AK1/PW8uorL3Ih3XR/acJ6TqziNO8eCs3vu8vM
	4BhHa7nrRqyl7lg13V5zdpAxYkPW62dOzTILTBcO6M67Ll9x1bdJsaGvCW6ReLlgXOcXWnoYhoJ
	OYtH5g6v5/2DAQKKL70OizlL7Kl8wK+jFvpI2tBVQVx96v/RJJ3mYRTe0v89wwx4nlCIgDJ941s
	ZRMwaCVcnF/dkUjEhgTK0jm7CelYi+bDTs6UVU8+BiSym0Cxvuki0AROOeuitN5IIU0TGJdARGM
	aaJD+cI0DEjpTQvMtYc5H3JG6gCzv9rKcVjiDnms/5AvN+EKhJXLk1tmQ6wXeGelr1xeu6T76tO
	Psww==
X-Google-Smtp-Source: AGHT+IGfMLfpl1r8UiOuXJhqCZKSnETB6Ur9TnXbCm+CykLqr6gyLIAkyrO9TZvesxjupxdXUbloLXWp8eaT
X-Received: by 2002:a17:902:f54c:b0:271:479d:3de3 with SMTP id d9443c01a7336-27ed49c7763mr74298605ad.12.1758876649203;
        Fri, 26 Sep 2025 01:50:49 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-27ed6845576sm3296075ad.69.2025.09.26.01.50.48
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Sep 2025 01:50:49 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7810af03a63so2541113b3a.3
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 01:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758876647; x=1759481447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JGJWSmoM+8Phql35kYHgcLi2uTPHv9JlqBXehjilKJw=;
        b=h32SFcYSXoa5FD2mRlZigB4KV4nvTnN5Bb79xkb7BBkHgZasZw+ChCNtxmg4hDx3Xo
         SJz7jc/EQYaW03IjvmbJ83phXzn27inZ5NCtT82ClT87Ewh+EcIb6dzD9tDSS08aua09
         T7qdAStZacBkTg9IdotFlR2BpnPKJa6uyUJKk=
X-Forwarded-Encrypted: i=1; AJvYcCW3eAB9UJcQ5jbBU/3VjlBOSRjtc1E/i9M68FbR6m6xddN2j+fzwhR3mqTQjMFnmmvE+ta7QKY=@vger.kernel.org
X-Received: by 2002:a05:6a00:2e98:b0:77f:620f:45bd with SMTP id d2e1a72fcca58-780fcdd2201mr7038497b3a.7.1758876647291;
        Fri, 26 Sep 2025 01:50:47 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e98:b0:77f:620f:45bd with SMTP id d2e1a72fcca58-780fcdd2201mr7038470b3a.7.1758876646907;
        Fri, 26 Sep 2025 01:50:46 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c1203fsm3959896b3a.92.2025.09.26.01.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 01:50:46 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/5] bnxt_fwctl: fwctl for Broadcom Netxtreme devices
Date: Fri, 26 Sep 2025 01:59:06 -0700
Message-Id: <20250926085911.354947-1-pavan.chebbi@broadcom.com>
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

v3: Addressed the review comments as below
Patch #1: Removed redundant common.h [thanks Saeed]
Patch #2 and #3 merged into a single patch [thanks Jonathan]
Patch #3: Addressed comments from Jonathan
Patch #4 and #5: Addressed comments from Jonathan and Dave

v2: In patch #5, fixed a sparse warning where a __le16 was
degraded to an integer. Also addressed kdoc warnings for
include/uapi/fwctl/bnxt.h in the same patch.

v1: https://lore.kernel.org/netdev/20250922090851.719913-1-pavan.chebbi@broadcom.com/

The following are changes since commit 4ff71af020ae59ae2d83b174646fc2ad9fcd4dc4:
  Merge tag 'net-6.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
and are available in the git repository at:
  https://github.com/pavanchebbi/linux/tree/bnxt_fwctl_v3

Pavan Chebbi (5):
  bnxt_en: Move common definitions to include/linux/bnxt/
  bnxt_en: Refactor aux bus functions to be more generic
  bnxt_en: Create an aux device for fwctl
  bnxt_fwctl: Add bnxt fwctl device
  bnxt_fwctl: Add documentation entries

 .../userspace-api/fwctl/bnxt_fwctl.rst        |  38 ++
 Documentation/userspace-api/fwctl/fwctl.rst   |   1 +
 Documentation/userspace-api/fwctl/index.rst   |   1 +
 MAINTAINERS                                   |   6 +
 drivers/fwctl/Kconfig                         |  11 +
 drivers/fwctl/Makefile                        |   1 +
 drivers/fwctl/bnxt/Makefile                   |   4 +
 drivers/fwctl/bnxt/main.c                     | 452 ++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/debugfs.c       |   2 +-
 drivers/infiniband/hw/bnxt_re/main.c          |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_fp.c      |   2 +-
 drivers/infiniband/hw/bnxt_re/qplib_res.h     |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  30 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  12 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |   2 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |   4 +-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |   2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c | 245 +++++++---
 .../bnxt_ulp.h => include/linux/bnxt/ulp.h    |  22 +-
 include/uapi/fwctl/bnxt.h                     |  64 +++
 include/uapi/fwctl/fwctl.h                    |   1 +
 21 files changed, 816 insertions(+), 88 deletions(-)
 create mode 100644 Documentation/userspace-api/fwctl/bnxt_fwctl.rst
 create mode 100644 drivers/fwctl/bnxt/Makefile
 create mode 100644 drivers/fwctl/bnxt/main.c
 rename drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.h => include/linux/bnxt/ulp.h (87%)
 create mode 100644 include/uapi/fwctl/bnxt.h

-- 
2.39.1


