Return-Path: <netdev+bounces-220433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ED1B45FDB
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 19:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 600781C20FD8
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 17:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DA3259C83;
	Fri,  5 Sep 2025 17:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cF43RVlX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f97.google.com (mail-oa1-f97.google.com [209.85.160.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8B024EA9D
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757092816; cv=none; b=U5rPCaecMtb0Gw9/bgSGEJU0eiClA4NZry5stg6KqoThRxgaYAQ6oLlw7S5MfJNlPnRztC50kcEY46zKA5gIHnrPbeW5xyaU1dZOVru27+gQ1F3YeuAiEvJDFbJ0J4IYVmbpTqxbOtnAsjX11PbOXbne8SPnfubK8nLDy0Xbouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757092816; c=relaxed/simple;
	bh=0AT7APgm8B0/OQcxue2jUmcVmW2/EJobNbH376ZH6JA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SlQDA2lh6SEoA2XAfM98viIn/ns6boPDaprLSIV4zstt7JkjrueMd3AmtabCxdMqBkgsxUIZ+V6249srYZdMtLXRT+SR103KegsgmPQsdZ5g3ITMM0jFaWjhm90Jyz/eiPGx7bruVh3Ds/xuh678jboNYail9AhkNft1gLBtM3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cF43RVlX; arc=none smtp.client-ip=209.85.160.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oa1-f97.google.com with SMTP id 586e51a60fabf-3158a9ccc52so1236618fac.3
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757092813; x=1757697613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLFW2g+f2TuwLyM0X1O85UbfIsEt5ZueedBLU5KTuv0=;
        b=grNBuW7+7cWy+jTuHHHIH+tGUjk+XDr6/C3xni0YrzZ5LcHSAgJSdeQbY9zAhQFdMl
         0Ax37DhspkhRuBpj6UIobJO+B5nJnmp5WusAhltSAOEQqEzKCGzcYXIrT1ndEvkIYB8D
         KJxMUQByvhrYwLf7dti2qpyLx8VYeMorauxU39slsARGbokMZ0hrRVvG3xyo1Ex4OObt
         zALUy02KNW6+BdDk9hWXaAQLcH3ChwS0at8FDDRIOc4WHRWfLznvn9h1KMXIO72J1dgs
         o+mr4BsKJm8bdFX0HKxHbaPcyMa+xKLGSbWC6smBgxLcLzP6xUq+lkTg9aAPGQ5pORom
         vmQw==
X-Gm-Message-State: AOJu0Yyr2kuTunLmMvCGB2JMTXnWJzntBbmzWaTtkNj6ksysg60gxJIB
	WJJRzBoAj/e+uh2LfCBNRM85qyErRADiONCJRJPviAtE9Z3fDjnCp1U58IL/miqtb44Tsq0oRd1
	X9CepghBnRtyL2vQbwnO9GPQjWwSJ6eLRlGQcJaD5oMGKyVX3ulz8gt8aoKEAI4iKk+fvWZadZT
	77TOEdtQ40c2odMKoNIb1LBmsTA14Wse3+Lvy/BgKmvPUoe/qjFpeuWduN+uaobv9YV5LeidtVx
	T176tnGUD0/ioh5q12J
X-Gm-Gg: ASbGncvKjG+nuJ7FpRCOGKWmMhDL5Vuy0xlHZCdcl6Uyqq/YT1b5L9dt/YnfhT0VL4a
	IeGa9x+EyXDKiSFizOmLz7NJLxTyVc3KpZlUpeZDj7wHBDk2d7GpQaCVWKZE/ZRE9DXm6GFx6G+
	uBx9D7/R57pL5WliucV/rD1LCXdJAlYobtbWz7Rwyq8sTi7doge5i3ZrsjkkiNMUJiHNWmVRsig
	1KOpbveBfE599tlGxJaAkcAOhRREBOrnCUM31qOqM5MjQb8phUiWnVr9EnQPNxlsq46IpcxHN64
	8IbjzRsEiLVa7TY6U8kRKBoyYyqu61BWNGPUq895D3Ik3ilQd04bLmM0uw2EHTQt8iUGw9hQfKK
	ulTzsZDmxEKkd7muVogX9ueUaO8AVOH90PYNJfQ4ch/eAyPGA4077cusJspEYK+dU0YcCVAGmYw
	1o1+FqWw==
X-Google-Smtp-Source: AGHT+IGAoAdIHZg/abI0ESTWx4V6ht1MjUoIppBvu1xdgYTmRh4neCH9D5m4lc0/99226xLINgv+eJ+UO1Mu
X-Received: by 2002:a05:687c:2f86:b0:319:cad9:c6f1 with SMTP id 586e51a60fabf-319cad9d36amr6199326fac.36.1757092813376;
        Fri, 05 Sep 2025 10:20:13 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-746d7d6e5c8sm268551a34.6.2025.09.05.10.20.13
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Sep 2025 10:20:13 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-772537d9f4aso2168841b3a.2
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 10:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757092812; x=1757697612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xLFW2g+f2TuwLyM0X1O85UbfIsEt5ZueedBLU5KTuv0=;
        b=cF43RVlXklU60/pSByrESmFvAJtZb94tYG5DZWqcmkHnUgQ2kJJjGERVkzWtfAzZg3
         Zb1J9jUstPX5deALDjoREMoX+JOyuPWclOcyc7nGug3W8tnhJMh4tEQFcB8fExW98eHy
         jyUak3Ny4HVXukPIRk6FuWaso3UXeaK0ejoOc=
X-Received: by 2002:a05:6a00:240c:b0:771:f8b5:d93 with SMTP id d2e1a72fcca58-7723e38c01dmr26589999b3a.27.1757092811449;
        Fri, 05 Sep 2025 10:20:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:240c:b0:771:f8b5:d93 with SMTP id d2e1a72fcca58-7723e38c01dmr26589971b3a.27.1757092810976;
        Fri, 05 Sep 2025 10:20:10 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a2b78d7sm22678001b3a.30.2025.09.05.10.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 10:20:10 -0700 (PDT)
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
Subject: [v6, net-next 00/10] Add more functionality to BNGE 
Date: Fri,  5 Sep 2025 22:46:42 +0000
Message-ID: <20250905224652.48692-1-bhargava.marreddy@broadcom.com>
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
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  485 ++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   31 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 2211 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  251 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |    4 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |   67 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   14 +
 12 files changed, 3136 insertions(+), 6 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_db.h

-- 
2.47.3


