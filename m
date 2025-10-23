Return-Path: <netdev+bounces-232122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C6C0174A
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 15:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31AF188F72B
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E91320391;
	Thu, 23 Oct 2025 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O9105PBM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534C531BCAB
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226033; cv=none; b=d2ZymTn628g3NF+Q68b+G4kMy7HgyE0dvt/wCyNpQzz5IyVkiuexoytmOOXhANgESzF6zZZCDStNYAzpp8/1dsFZKXxNne329Zq+0tJJ6fK+ayVaMmfifeC+4Y80Lm+tybYaKZ19qtDP3FlZL72Eik196fr/fIn45Is4blZ67qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226033; c=relaxed/simple;
	bh=ep8fhLyuGrAcfV5jfSM/Wn0CDxtlRo3rdJq3h65NU4M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oGuLJs6xoQ36OYBGNQVFm1gUe3G1+KcgI5CXeeqW0uHGI2ReuwOk2cAey/aVvKIlfHFUgIVsGX/xm04npzPaWnfLRaiRvXbbwuSl+OvgYKDO4y/IKO8IpchDizwc3Y9aQSzi/8SZaLLirIl9PTve8R5eAI+14MT+zytEMUYlc54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O9105PBM; arc=none smtp.client-ip=209.85.214.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-27c369f8986so6694605ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 06:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761226030; x=1761830830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdEwlf4lZgfKN/2rvuQzkYwSMC8ltz7SUViQK3FN+oQ=;
        b=oNPURf2dD+Wni6i7rqKy9oaEQObh30jlRElXZo6TF1x8MGyZvGHixKfK356+/mpo5A
         e2jUcKoAPTL/REcDv45UslnZXnQ4s/R6yG8SqKh8slhiG/o1cNYJ4c4y8SZEcAlQqvvA
         RAtq5tV2kT6UqHKD1Y9HICqfrx3ds1tuH9oRfujFPV+uB19N5W4HYRXFrb2G5dTlGBWs
         fICh70rak/1Vb1Du8Y1Cuoo4O2+mp2egwliMyQ6cOH1BTFy5SDkCmazoLF4Do5bVivlU
         h5jK8t+2cjZE/0lWTLvirKau6IR6+TP6T4a5cnAbBCuP9d+S/1F4/4zyxrAoc8YrOJyM
         Cc6g==
X-Gm-Message-State: AOJu0YyfhgMA6qjmVlnhZF7zuHhpPZGtKj3UyH6TyGrn7GTeeHDVF9PP
	uh+uIvrgQtHk+By76Aid2dO6Sr8K90huS4drfrQQ6AdnJNep6sXbxIME0cEVZ5hsiSLRGgSiW9d
	7blcOmeUcIbYY1sNs4oYosRK6wfnRenlGFTYjcfDRX5j2LpdA5hToUeC1PhsK38BdmJlecGmfIS
	77K9slvpSi7t7R394D9xKB7ZxsmHqYN7D/wGr3Iwf6wTAQlx3WbZL2DM0tuvXMdhMMdsiZ2yXKM
	/jtpnwg
X-Gm-Gg: ASbGncuZee+ZrMyltByJSFdBOMqZqcWZ4vIENvCVvqJeaSMqm26CIIWVbY5HQyqnzDf
	aJfoHCrlgDTudsg11ifqXCQUQmmfz57oh5Sxr+W73YHWa7WVxV+R4ifCg62z8LnlfTJ4c9w+Hs5
	BNAQNybaSlo00pFygU7lMaGSpQJ8TqnDuwu/3mtyAcaRg5i7xngOI4YLYjzntntNaVTpouUZs4U
	jgt+mlYmtZoRdR2vsU+yl3iI3dJEtACakoOl1vq5IkLUgV56q46rP+P+JLPZdbJN2LeZAYhspFk
	FTsP0OKPk+pIpWcpZeO+AHivgjXM6rZ+6APxSsOShDjHKaXESm7wAylxESn9Ybu7h57o47GyCzn
	OO2vPfujctim09O6pDor3r7IeTeZCi3I4pGDNimYEbB0sPoiy7m+A4Y4fbYJvpNfo8WIQ0XGsJZ
	LJzOADGjAXPUDEO5QmW4OJkw+Y4F1OgnYh4w==
X-Google-Smtp-Source: AGHT+IFsEg3iSLbebt0Ha0yUnmsiCrako1wf21djjoZNjBidT8Hw7gkmi843dPNqhz6XRnSY3nGSxZXvh3RM
X-Received: by 2002:a17:903:2990:b0:264:8a8d:92e8 with SMTP id d9443c01a7336-290ccab59b1mr313516315ad.59.1761226030359;
        Thu, 23 Oct 2025 06:27:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2946df82ba5sm2246945ad.52.2025.10.23.06.27.09
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Oct 2025 06:27:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-28c58e009d1so20801715ad.3
        for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 06:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1761226028; x=1761830828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DdEwlf4lZgfKN/2rvuQzkYwSMC8ltz7SUViQK3FN+oQ=;
        b=O9105PBMaao7gkWMnFJmCn+6FdDnCerCtBP7/+rSyFiIQhvDuB1dJ+faSZ11serRxH
         8A9W09p2ayJYBfNzqmxQNUSqoLrXh7susxcdSANv1PkRv+f6jpZvlrJw+YmbBGjHLAUi
         EB7iHsoz3ZQfsPVEUgArcxe1vWXbDspe5BJbo=
X-Received: by 2002:a17:903:1a0b:b0:290:b14c:4f37 with SMTP id d9443c01a7336-290cb9475cfmr317695775ad.30.1761226028133;
        Thu, 23 Oct 2025 06:27:08 -0700 (PDT)
X-Received: by 2002:a17:903:1a0b:b0:290:b14c:4f37 with SMTP id d9443c01a7336-290cb9475cfmr317695185ad.30.1761226027582;
        Thu, 23 Oct 2025 06:27:07 -0700 (PDT)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfc204fsm23739785ad.60.2025.10.23.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 06:27:07 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: vadim.fedorenko@linux.dev,
	kuba@kernel.org,
	davem@davemloft.net,
	richardcochran@gmail.com,
	nick.shi@broadcom.com,
	alexey.makhalov@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	jiashengjiangcool@gmail.com,
	andrew@lunn.ch,
	viswanathiyyappan@gmail.com,
	wei.fang@nxp.com,
	rmk+kernel@armlinux.org.uk,
	vladimir.oltean@nxp.com,
	cjubran@nvidia.com,
	dtatulea@nvidia.com,
	tariqt@nvidia.com
Cc: netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	florian.fainelli@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com,
	tapas.kundu@broadcom.com,
	shubham-sg.gupta@broadcom.com,
	karen.wang@broadcom.com,
	hari-krishna.ginka@broadcom.com,
	ajay.kaher@broadcom.com
Subject: [PATCH v3 0/2] ptp/ptp_vmw: enhancements to ptp_vmw
Date: Thu, 23 Oct 2025 13:10:46 +0000
Message-Id: <20251023131048.3718441-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series provides:

- implementation of PTP clock adjustments ops for ptp_vmw driver to
adjust its time and frequency, allowing time transfer from a virtual
machine to the underlying hypervisor.

- add a module parameter probe_hv_port that allows ptp_vmw driver to
be loaded even when ACPI is disabled, by directly probing for the
device using VMware hypervisor port commands.

v3:
- [PATCH 1/2]: reverting back the changes of ptp_vmw_pclk_read()
- [PATCH 2/2]: calling ptp_vmw_pclk_read() without cmd

v2:
- [PATCH 2/2]: remove blank line in ptp_vmw_init()

v2 link:
https://lore.kernel.org/lkml/20251022105128.3679902-1-ajay.kaher@broadcom.com/

v1 link:
https://lore.kernel.org/lkml/20250821110323.974367-1-ajay.kaher@broadcom.com/

Ajay Kaher (2):
  ptp/ptp_vmw: Implement PTP clock adjustments ops
  ptp/ptp_vmw: load ptp_vmw driver by directly probing the device

 drivers/ptp/ptp_vmw.c | 99 +++++++++++++++++++++++++++++++++++--------
 1 file changed, 82 insertions(+), 17 deletions(-)

-- 
2.40.4


