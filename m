Return-Path: <netdev+bounces-225161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B27EFB8FAB8
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 11:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9A0E14E1E0F
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 09:01:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0CF27B329;
	Mon, 22 Sep 2025 09:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XwOyaCoD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875C26A0A7
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 09:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531641; cv=none; b=kMvzX+7HLoBrKk/LlnSFZztiNGBTakNdLf1mXir6FP9IH07N3EYZaetBWOoVjPqBOXbZPbDNoc1ldACNUnkJucj1NLrfaor1JpWIV+MBbQkxlvHJLfemCP/qnJAok5b0fhBSZsS6LjMKutpY+UDq8eMeGp9l3GO4ZUa+vDMTP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531641; c=relaxed/simple;
	bh=xHooe+aXKKBgH1xRLPS0a+CtwJXvOdYiq3DoX1Q7wZs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z6gE3Olytg5pInHTpf+QYKT+2xyryvs2nDpUk695JXMkyDmJjSWXTT3k3g9xlZTgf5xuCu3yh7uke/eFWd2exRnhFAeLxax2xdzr5hYpX5B7QZJ4Uqs/rb9iKyqthq6SbEAgz4Zs0AR1Q8syI/SOmYo1Pj00B7iiPrNIgueAxl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=XwOyaCoD; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-273a0aeed57so12880435ad.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:00:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758531639; x=1759136439;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZbdRzHu+d1LjTmhEPu9M8RgCgzBe6v7ITaizKaAhxg=;
        b=I04ftkuVSOGW6F8a5ASTFbNtft8jPNpfp9v+hjwSia9WwnEs3YWmmRqaZZD0ZQuZXt
         beAHt9GXpwZZa9XE660uT7sgJkUqDhpHLKYt5BK08OxrUIYHgiNPZk5ae7+Axu2RAjrD
         Hvw+Jfm1ixUQh9XZgUvQnvEioBBBSmJLNl5aZQUI8E1yN82PJL27KKr0FhhiMBvFhsXZ
         duY9ciugGY5QWl/11MeK7IxtXnOL+YtzjIauQkJAvspJp1+RmQmYFRxci23geGAGiu3g
         QUYa0eNiW8iwl0UDeZxY9hqdocJUfFe0np1IyPURwyLGdDmkgWN6wR7zJ/DcKZFJ79p9
         agPw==
X-Forwarded-Encrypted: i=1; AJvYcCU/6AhtOhEqgPyc1KEHLVQq6FNYw7svpQvNXGyPDS6rGLfgoQ6XxyrJhZyAkbxXyN4+4kAhQjI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxahiCMov8r2hm1Sqfs4vhAMCQMZNj7/rCEmkXpJC6+jhkR5Wum
	9mYq2+8kNetnArETFpwcsEH0+rLvMYWPDBjxEP0LznffzovWKRrD/c8i+eRIcsKuJS5Nxz982FN
	KKpirOU3pg3CKDUcpz0esl9wqlXj2GwE7RC6A15I7RMSWDruAQd0Nu2x85ZMMT4cUR1GWa6aGYm
	vCVYDuCgwgu1wSun6az5Q07OcWNmLIisVKjHCeEGQDmHcD1JvekoyqmEW6uri1sPOYunRtM+4tY
	IdKIy4W7kM=
X-Gm-Gg: ASbGncse6x5et2bFBbRr3n2g2EfJSi0sIbivjP/FBvMUmMM5vWE7vNAjndZcsXR16cL
	GFqEIUisSf+CpON2HcRtQP1Qyb5SjnmBOc4n9rNLn9tLpiHEKgYCbTg8k+1l+Ai7I1hSfCiYjsl
	7z1hrKIvCohdOHxEjF8mDP+cvR7sK/qpdgyFlrdRYmy2mSaQeRWrk9B8Vvrua1vtk+/HDHCLej5
	dZmEPb2SsrMC5ALZPxuJoEJb5m1dBzcB7s0TGaalWWFyTsZGKyDFAb537/oOluBm3pBmMy7tlal
	KXv9qYwJlMQnA+SONFBwiHNJ0CIpejYk9fsXye4PSAnWFHqR6MHNTZLXoltx40TiIYstCFBRocX
	+5fCHpLplHTDJxJF4X4IiHmfcKD4hNx5c5qxZUnNHV+tLHfy7f2visFCva+eT9a1mnh0IqXnQOZ
	K2Yw==
X-Google-Smtp-Source: AGHT+IH8RRJNcH66OTeAwQIPynrKkqZg/Gb0o5QgngAujtys8NZXtZCThG81KpX+strqVIhfshFpQG2HVpTJ
X-Received: by 2002:a17:902:ebc6:b0:272:d27d:48de with SMTP id d9443c01a7336-272d2ab2a79mr91262905ad.18.1758531638696;
        Mon, 22 Sep 2025 02:00:38 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269802767c3sm8289295ad.44.2025.09.22.02.00.38
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 02:00:38 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b55443b4110so748845a12.1
        for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 02:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758531637; x=1759136437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vZbdRzHu+d1LjTmhEPu9M8RgCgzBe6v7ITaizKaAhxg=;
        b=XwOyaCoDcSXHFQrcN0whiMkrEraaJwAVK6urBlHs1ri6wBE39JnQitC5X7SEwOxI1X
         IrVoT3HvJxSouV0PsKujFthFZ2sQsVsWgRoWyhrhPstzqfj2AsGZDE2Nblz5T2Bs+LhK
         uw0KYS+CvwHhyaZb+BNPp5qFwqW4lHnMsl6Lk=
X-Forwarded-Encrypted: i=1; AJvYcCWkk5NfI+IeIWi8Ji62dbZgKcbvJaHzVvzAjiLi4L84if9ispp+QStZje2XHKmCumGNfsZI5as=@vger.kernel.org
X-Received: by 2002:a17:903:2983:b0:242:5f6c:6b4e with SMTP id d9443c01a7336-269b785e4f1mr168713505ad.7.1758531636754;
        Mon, 22 Sep 2025 02:00:36 -0700 (PDT)
X-Received: by 2002:a17:903:2983:b0:242:5f6c:6b4e with SMTP id d9443c01a7336-269b785e4f1mr168713095ad.7.1758531636182;
        Mon, 22 Sep 2025 02:00:36 -0700 (PDT)
Received: from PC-MID-R740.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269803416a2sm123309615ad.134.2025.09.22.02.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:00:35 -0700 (PDT)
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
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net-next 0/6] bnxt_fwctl: fwctl for Broadcom Netxtreme devices
Date: Mon, 22 Sep 2025 02:08:45 -0700
Message-Id: <20250922090851.719913-1-pavan.chebbi@broadcom.com>
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


