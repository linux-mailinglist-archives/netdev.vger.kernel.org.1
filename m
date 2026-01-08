Return-Path: <netdev+bounces-248238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93636D05995
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:37:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAEB830499C1
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 18:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A7E3002B3;
	Thu,  8 Jan 2026 18:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="P+MurTRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f97.google.com (mail-qv1-f97.google.com [209.85.219.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC46230DEC0
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 18:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897366; cv=none; b=jh0RFdSRllKJVWcycMbu3NnCo3CgGfvGwXn0xmDnKeMkfTCvpHJiM8n3o7bpCguSV8oPCS+znDBWzI9n3pSXsVAFSnNNIkOt2A8XgvpB6kDy4pw6F6mM37vB/58oxoKTiYn+gXbLV+2I0Socf3eQh+QuNFWZkvpWcuRHtie4AWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897366; c=relaxed/simple;
	bh=ZTLO03p16aWLmOdMN72apXY6oZhEjPbAIScTDR/RgQc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o3K0IRc9vqxRrVmfjT5jytwM05aoEb49OpAHY4pxR1F/+aUE2O9gQZVgDdXu+WdQKqaAXQheka9bIov8bxMyzZUmBRXqP2mdvpfmDE4v4/T5XGogFKHqLNt3i9GmP3yE2/CPwKY9uRh4BHMLlcvtmNCXrZA7wJWht6l+EDnKA5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=P+MurTRk; arc=none smtp.client-ip=209.85.219.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f97.google.com with SMTP id 6a1803df08f44-88a35a00502so30843676d6.0
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767897364; x=1768502164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbQt0nkY7cuDBU6IlU5BH2FTOYcZDlt7u+HO8OFr9ok=;
        b=ZoFabwmkvStM3WsMWWT2dKjGzb+qLa1piYj69p0xsqy/BUwRFS9KmOllfiwUp6Z/9/
         dBdJxWdoRoHTVA/29Spu4eoyFQka1mooYA9pMutahrqItf9c//LAUCOyRW3gQVLKGbKa
         oQM3a2TrfPin1qBbzf23NJmCvzUaUyeGKFChbX+eSnhgzHTXY6M4CZSEhH0mb7sKS14m
         u/8x+qfIVo1a7n/atEPxc3rPh0itQphs4JW64BX3ulO8KALQ4elggQm2/8pSG/ebm5Kr
         1jLPCSHNFt2XDOBq3vJCDZrwXTLbCOk3B2TBefPHaIWN+mRwqmNqyRPaZuWC43Fl/d0K
         0Tgw==
X-Gm-Message-State: AOJu0Yw9acGLwT3PH784vSxcENyu+i/REVDNB2gcgWBTmSAaTj5BIHkn
	FZOPNesQTi/jiYS7f4s8gbBHZ+5NWA09vchY9+8O5+Bc3QtP4uC71WVtb5/2HvmewMd30vLbxbF
	wIktdBEAQSsxhFWvtJ5KYHaAWbnUBif/aEPpELIzjONNZ8wMt9ljjKgpHC4ler9q14ESylSFLqu
	/nf6d9nZLy0SxzN3c5ucJpNGxQBYVyQp6rc8M1drtSwAJE9UKRaXjV9f3IcMJ7InGgAEcJ0v2ok
	4JtqIvGZQU=
X-Gm-Gg: AY/fxX5BWNjTKpfI6UND89tGMI3uLsWNC/JAzN2IMVQN3dyHIOud6cfPqLG7xxVtc3e
	irjkAPGqKxlxspWrn4OwKNm7AxkZ5ebkRSaEF95pSDS4L1nWo/fqdbWWJQ7rvzvKn5gl3L/merF
	l7A6MAZcY2nLUSDX7PDj193cZDs8bHufcbZG/eTsrLPDM9kP5qlZnU80I8zNFWc3aGwMcQ6fDHY
	VgXpOdPIMszuoBYIzC0ThJzJKykLVy+K9fGwRXWo+XfrbUH+eR6zW/3S2rW7kAxFlVMgKoVGykb
	vX38bB07mcJtLWLu9970s3UQ+xbVdqvHfEIuZ04JYx1hUwfD4B2eOmWW//HgPojo+ep8PMyoMsz
	MG/sW9dVCvSwZ6mlPMnj/hZ50anQ45N9C5jAb6cd0mEDzWdXHrTs+AeAuoJkkv9SnbUa4dLouSL
	sNz3CicDnra7gqAXuCQapvY0AHOYNoZbpJYBrssZDKWmLjRJU=
X-Google-Smtp-Source: AGHT+IEUxL+QEen5jF+JTlUXU/NcB+/F0ghDZXE1OaryYs/+K84A75uikcbP1q4dAVYLTd6m+YQRlCGbAe2+
X-Received: by 2002:a05:6214:1ccc:b0:88f:a4a1:bc96 with SMTP id 6a1803df08f44-890841e45f3mr102211196d6.1.1767897363572;
        Thu, 08 Jan 2026 10:36:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89077093d8esm10490756d6.7.2026.01.08.10.36.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Jan 2026 10:36:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8b24a25cff5so1045563885a.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 10:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1767897363; x=1768502163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbQt0nkY7cuDBU6IlU5BH2FTOYcZDlt7u+HO8OFr9ok=;
        b=P+MurTRk/Q08OjkfKT4X/L30kfewUjX7tRHazW+Vh4D2GCE5f0Ers6ANdKMro05pFz
         0TI/tINWZ55UjpiEj3BiER4m0AQsEHG8s2eqfFxEK8BRtr2bUMgw7Wnj0Anlq5dPRvRj
         bg2IrEMNExPWAqUpgFVpe2hg2kM5qmivMrRJg=
X-Received: by 2002:ac8:5d02:0:b0:4ed:ee58:215 with SMTP id d75a77b69052e-4ffb48c654fmr102503171cf.35.1767897362699;
        Thu, 08 Jan 2026 10:36:02 -0800 (PST)
X-Received: by 2002:ac8:5d02:0:b0:4ed:ee58:215 with SMTP id d75a77b69052e-4ffb48c654fmr102502761cf.35.1767897362302;
        Thu, 08 Jan 2026 10:36:02 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ffc17c2897sm15973721cf.32.2026.01.08.10.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 10:36:01 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v2 0/6] bnxt_en: Updates for net-next
Date: Thu,  8 Jan 2026 10:35:15 -0800
Message-ID: <20260108183521.215610-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patchset updates the driver with a FW interface update to support
FEC stats histogram and NVRAM defragmentation.  Patch #2 adds PTP
cross timestamps [1].  Patch #3 adds FEC histogram stats.  Patch #4 adds
NVRAM defragmentation support that prevents FW update failure when NVRAM
is fragmented.  Patch #5 improves RSS distribution accuracy when certain
number of rings is in use.  The last patch adds ethtool
.get_link_ext_state() support.

v2: Updated patches #4 and #6

v1 of the patchset:
https://lore.kernel.org/netdev/20260105215833.46125-1-michael.chan@broadcom.com/

[1] v1 of patch #3 posted earlier:
https://lore.kernel.org/netdev/20251126215648.1885936-8-michael.chan@broadcom.com/

Michael Chan (4):
  bnxt_en: Update FW interface to 1.10.3.151
  bnxt_en: Add support for FEC bin histograms
  bnxt_en: Use a larger RSS indirection table on P5_PLUS chips
  bnxt_en: Implement ethtool_ops -> get_link_ext_state()

Pavan Chebbi (2):
  bnxt_en: Add PTP .getcrosststamp() interface to get device/host times
  bnxt_en: Defrag the NVRAM region when resizing UPDATE region fails

 drivers/infiniband/hw/bnxt_re/main.c          |   4 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  39 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   6 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 118 ++++++++++++-
 drivers/net/ethernet/broadcom/bnxt/bnxt_ptp.c |  47 +++++
 include/linux/bnxt/hsi.h                      | 167 ++++++++++++++++--
 include/uapi/linux/ethtool.h                  |   2 +
 7 files changed, 361 insertions(+), 22 deletions(-)

-- 
2.51.0


