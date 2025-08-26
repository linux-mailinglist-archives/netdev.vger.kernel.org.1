Return-Path: <netdev+bounces-216799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E50BB35458
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 08:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28821B65A8A
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 06:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE99C2F60D6;
	Tue, 26 Aug 2025 06:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dSU7ZBrJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476CA2882D7
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189235; cv=none; b=gcfoeC/TPHRNtyA9Mn/vdIWgLzlseD/J5RN4vQlQtuuM8KzCo3wYabK5bNyK0t29UAprVtdJ88RyNXMtXPI7hoCmHgUsB63DUpzNCrORe+oyRn0Tr1MzzmtAYHQs19dI9+/BWTD49XHhPYjdBAbdsXLGC+QisdBfzUuBA1NAW+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189235; c=relaxed/simple;
	bh=4+QtwmqqdSoA2OHoNbqSk7MafkqjBrM2m4ocl+VyIAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HbQXMdgzdrytiSHPDw4vGvd5wzkRJScuoRF0KdI1oS3MlXnR3/XsXFnm/JrOp2lgvKtUb/XjANv0/2x3qzlJEYaYdvr5F4EJ5P9bHepUblPc8oZr05pKU6rRmnaREdoI2w3KKMP7bvl+p2SHkwfwrxXdRCn/9cS9aWNkD6eUEF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dSU7ZBrJ; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-71d71bcab69so41931427b3.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189233; x=1756794033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d86HF9eSYw5UzbRxdfVxFLEbL9A3yFfnZEambMky0vM=;
        b=sz2Y2tqEVb9dhjyNlbXJcOpB2DXaJEnsF7xpU5BOkywdjrlc1UnN064a6azHUa33Si
         78DWc7IlXxOQjjvDt7ltDDZH1QOAbPfnAQ1dCM7MJpLMgj4JFV+7X4XEvMCDDClN4k+E
         eK60RgQcuTQHXlHIAmyqMFgwZt+zwxB5r0gftcWrClusGuLbzGKh7FfWc2WcGZaJkhXE
         KS93xCluFzLSxh2Sl7Ky6Shnc0fsN2+naUvNKnA+dpouTNUZ8WwEwx0stNjA4T09ii7A
         K2TnMct4ezgaE8SKuvyc85UMntoZ6RVimOUZG642oEemi4BM/0pL0s7CWxkPHU6Hi+9p
         3TnQ==
X-Forwarded-Encrypted: i=1; AJvYcCVA6FVcimzQ+AW8kN0e4N+dD1nduH6tKkvmSqWa8gDl7ODPp4bQr4eGAT0sITFPyOBH+iKYAvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVoHR/81UTqe4+imyARo5D3en9jlEpN1SDNIKLyVNxn7nvM4nr
	LDBX99YtH0n4pao7pImIvrWfHxVMyPW078LvDb1VRplU44QAfxuojHprj/NPk2JKyrkzBw6t4Cy
	TDnsyWhkO2KTuFpfdhhEwJ+luDNGKnKo0X6reb8QcjOJKf6Ljdo9LHE3AXbEHv+fkCZ4h1o4i1P
	LgwtcucXohQpVbtyhEwN4IWE5h+0sbA7v2m/gYu3CDW6aaaTfq7AkivvtVTQy/zpgo5oqY0O7vc
	qYLiKXpgVK7VKqDRDP0Ltfh
X-Gm-Gg: ASbGnctkazMhuYxC47ruDAIKi1o3Zy7kJNQgoojtVBYZCdSPK9s/a/0/b/ficRD7cTC
	JJeLthPfXJEWk/PgO1enapBKA60KW/KFYD4cBzYHro1AVmPEkWflkKVGvPyh+WPGCsQv7TUeZpV
	LdxuW878d85KQRmYniJnbGARbqp2wbRgQxjQneuCUd4PQKSb6LKSle4AP6XnHqm7DssehL8g8pT
	8p+QL1h+WhrccPTPlnUhjffRbvMKf2xTIKL2GzKooiIh2/BXgEbGEHzOmj18HDhFshL9JxxqgXf
	dUJ8zFS+fipAwQZCApnRRv1pxQjKzavor7E/C1jUhTVEKU/G0yVy0rTgMhYlOvvi1K+mXIT++XX
	hQ+jp0ovCHk7JGU+JbQm4ceMlV8Vg0VpTlh20GPKWwyTt+LfhenIZOszJFByUlH6DjUDFvkl5/u
	MWeRupbKc+zIDx
X-Google-Smtp-Source: AGHT+IEpyxVERliyZOL8Bc5yrFLPAJy3AamSEK7SpA6k8ThnmTLr3me2qzj8NzuZZsK/FKCpOfNOfZHpfni4
X-Received: by 2002:a05:690c:ecf:b0:720:d27:5d0 with SMTP id 00721157ae682-7200d270acfmr84072957b3.0.1756189233139;
        Mon, 25 Aug 2025 23:20:33 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71ff18286f2sm4687657b3.26.2025.08.25.23.20.32
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:33 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4c3547bd78so109699a12.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 23:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189231; x=1756794031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d86HF9eSYw5UzbRxdfVxFLEbL9A3yFfnZEambMky0vM=;
        b=dSU7ZBrJt3Z1CaOdpT6IPpPHdo1w9t3+sCGyRLayj9+ewYnuqk2d2kNsnZZYg1UdN8
         2KTTywZpPA34WJinZpxTyw6C/JRWFreoGFuFlk0XXafW6Ny7P4vlB+sfrDGVjuziQNrc
         Ts3S4RLXjxPyVr/8b7GAb0I+nFXUGcIDoYuM0=
X-Forwarded-Encrypted: i=1; AJvYcCXPlAmfxfjaR9dPy51OKFJnsd81AjZyZ+K3p+TltjUhH14SnboRk14RuEIv/nxZe6Tx2fPyFsg=@vger.kernel.org
X-Received: by 2002:a05:6a20:4320:b0:23f:fa6e:912c with SMTP id adf61e73a8af0-24340b8da90mr23186468637.2.1756189231090;
        Mon, 25 Aug 2025 23:20:31 -0700 (PDT)
X-Received: by 2002:a05:6a20:4320:b0:23f:fa6e:912c with SMTP id adf61e73a8af0-24340b8da90mr23186443637.2.1756189230652;
        Mon, 25 Aug 2025 23:20:30 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:30 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH V2 rdma-next 00/10] RDMA/bnxt_re: Add receive flow steering support
Date: Tue, 26 Aug 2025 11:55:12 +0530
Message-ID: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
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

V1->V2: Fixed an issue in Patch#10
V1: https://lore.kernel.org/linux-rdma/20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com/T/#mfb0a80be2fbd68d595e22ae0c0f1403ef9bc5ba6

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


