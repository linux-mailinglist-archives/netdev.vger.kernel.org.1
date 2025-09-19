Return-Path: <netdev+bounces-224810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D0BB8ACDB
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A62E3A01ECC
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2881526D4DE;
	Fri, 19 Sep 2025 17:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cb0B4LaA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BAE22F74F
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304095; cv=none; b=Pfbg+11EdLqgfUedB7Zu952qnXb/BFI9wz1uG1YvRjWOw/jXLn7faNXv5XjmBnjDAKxKLc8oIk1BQYg+hFvbEAQi2oMSsp3H5Jdt1v2W4K2WGIzWrmfdQNH5Elsotdi0JVLc3ThosUrERN+zbV9Jd83R+7kImHmFpbqt23jvYB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304095; c=relaxed/simple;
	bh=V6jKT+38G+cM94b40t9dw1NuZtwzytsckMLg4WY1PwM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DNoF/32HvoVDxh9JTcp6Mk5FPb3hyoFDVlOyik9BuNdyIxXDv8tgFLuLyBPDuy+0l4GtOw1YbWqwJKEq/cRpbNRNzr5p0r++tCRCann0klDOph0WVpZ6bpQl8BlYlDL8a33baDimMIKiK2SDjU+F+IC+7sJJPI5EVG6BBo9e1hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cb0B4LaA; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-71d605c6501so16930707b3.3
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304092; x=1758908892;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQdBnzkJ6XZr3h+JOYCkE5AzdDxHuHzROOLjBhUEp78=;
        b=wDRh8kIwA2SEVXL1y0E2nZf8oEBn2VAbaEQvCfZhia9BkM0R2XFbAJgrOfE0FrIPF2
         tF6spVu6Zke0biG10voBylQb9tBi2noJOo8oogM38mP4m6uHS1Me0tqMJdAgx+h94xwu
         rpP49Pxr2ptlkvN0jUGMa26J7jabYDGcsz95rL3Y3/0KDelWc4hajr286UMx7dszKIvV
         OW1NrJApoUJCS0K/C6bq6oLNTx72l3iWgxw6zDDdlXCYv/BtwTBmNnN/cf1hyC7gXhJR
         XDJAHIWFD/Pn4nx3t8xSR5VwJ2PNPaWJxyHNJG7+Jgn0euEAZ+Kfa7JFFfmXE0wRgrcB
         m2yg==
X-Gm-Message-State: AOJu0YzoBagOV+IW/GmYBVne9kqCcO44mjB7SPVj4fDwG90yj2whobOx
	YhjkHLLHfYrF/p9M7XHvkO6DxzwqbHigCWOO5fuqH/5mRWbJP+q8vdGr9HxEmq5nvCw8SHbD2pX
	fknKaPUe0X8S/9maAm1AK6WHmD2jy9x3LTPB0A6JWpABAY9z16XC9EJtMOBawVIMLWUe4+7be8W
	22/iotPZemI5rBhhEsx+5etz2O3rOG6nbxH8AUSiPagwCGyc/HNkNODVgW2OP/3arQF+RDmCQbq
	rIueL/dfnyavxBnJSfP
X-Gm-Gg: ASbGnctCT9U8k1lhvcxzinuzT2Pl5BqH3zw0NJ1+MnRcBKVij5JRysDmMmW4Gou+DaK
	sgeYZKsnUWhv4usyndbX9erV3GlzLBAkJuZ2s7NIWmLhJOLIVAM+Kbj95MojAtGcslR2KLKF9zT
	llhuFYjHZlnpD57Q3iMrVAEdDvlYYcbcVDni3sOpPCoBGzhkN3KzAfXACuS88ojIo8MZijsXiUd
	Wn2/Mip/Katu5AgB/0pSpC9RrNFpHnuc9DRvvpmA+0NwIPPXElSLcB2di2GdNuAeTwhUK3QK0Op
	CMVJDgSMdWkOjt6GYlPPuAlI31ot72jwhnWPsCuLe3XPT1ZlV2wOI9YmFti/R89tGWV5dxKL23p
	bGdCRTmoWLWLbJKJQ0tEOU6EbfLmiQh2ZCpa8PNqPZtktT0IDXvN2SWOMHFpd7qOHiXmxG99uba
	oX82oYlzUl
X-Google-Smtp-Source: AGHT+IFCMueA696C7dlUaKtfhn1KAXxZNY7KiB5C7+K++9K1fOfGmv8pdhKr53J+Bc2UGwFxC/ed/jYcn4uK
X-Received: by 2002:a05:690c:23c4:b0:722:6ab7:f657 with SMTP id 00721157ae682-73d3daf5c54mr33895597b3.38.1758304092059;
        Fri, 19 Sep 2025 10:48:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-739717a841fsm2639737b3.16.2025.09.19.10.48.11
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:48:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-77e13772b37so1042895b3a.0
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758304091; x=1758908891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SQdBnzkJ6XZr3h+JOYCkE5AzdDxHuHzROOLjBhUEp78=;
        b=cb0B4LaAJSnCsVHbCE5kEb4oPxkghDKbn83sQyBfJdnqOUdOroZcIqDrfnpodrT+CV
         aDFjT8rQF3EmxQFIySEKlGLfIkzBfz4xUgc7GyY9NoJEhWZ0bazRdrj64HvlaLIDIcP9
         YSiJIbIc4nOvBli9YZBg97KpAlSFJAU6IdvCU=
X-Received: by 2002:a05:6a21:6d89:b0:249:824c:c61d with SMTP id adf61e73a8af0-2925b42019amr6693388637.17.1758304090754;
        Fri, 19 Sep 2025 10:48:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d89:b0:249:824c:c61d with SMTP id adf61e73a8af0-2925b42019amr6693367637.17.1758304090319;
        Fri, 19 Sep 2025 10:48:10 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm3513119a12.26.2025.09.19.10.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:48:09 -0700 (PDT)
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
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [v8, net-next 00/10] Add more functionality to BNGE 
Date: Fri, 19 Sep 2025 23:17:31 +0530
Message-ID: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
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

v7->v8
Addressed comments from Jakub Kicinski
    - Ensured buffer post fails when minimum fill level isn't met. 
      Few functions related to buffer posting got impacted and 
      their return type for error handling.

Addressed comments from Simon Horman:
    - Fixed lack of error return when memory allocation fails.
    - Fixed max_t(int, ...) usage by switching to max() for unsigned data.

Addressed comments from Alok Tiwari
    - Fixed type of the variable ring_type.
    - Made the netdev pointer access more direct.

v6->v7
Addressed comments from Jakub Kicinski:
    - Removed NULL checks that are not applicable to the current patches but
      will be required when additional features are introduced in future.
    - Handled unwinding at a higher level rather than in the deep call stac

v5->v6
Addressed comments from Jakub Kicinski:
    - Add appropriate error handling in several functions
    - Enable device lock for bnge netdev ops

v4->v5
Addressed comments from Alok Tiwari
    - Remove the redundant `size` assignment

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

Bhargava Marreddy (10):
  bng_en: make bnge_alloc_ring() self-unwind on failure
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
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  482 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   31 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2217 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  250 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    6 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    2 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   67 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3140 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


