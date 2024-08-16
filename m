Return-Path: <netdev+bounces-119317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9076E955257
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1671BB23425
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCD71C460C;
	Fri, 16 Aug 2024 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CvC61lUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07FE1BF32F
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843749; cv=none; b=DtpJr7GU7Ly2vGIIiND1mwrPR/AgxqlSF36BT6bYZX3SDxmjwY1kunzNg2cys70VxEivcchhdA+E8UHgnJId17qgZPlGY0tsEuwpJEbokrXmV+ZyMZhGaHziEgrJmlPBUdcNnbW/ffveac/diFmKwJ1n/N4D4YIDBQMCtGzRLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843749; c=relaxed/simple;
	bh=/DFmtm8E/H362VPDb73vb4W6DxYJJvS7yWO3m8bwUTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fzsnjgVJpA5iCCDrCTShaBK50Y74ARLbu1YRGeGQ0PMKe6krAZCqQC/AkaJiOseOElyDWtfOLrxGddTHDne+oLDylb9WecDKc3Dzwc42zE9QqKa0YSehxeg4IEGZlWTUfc0t44giit/FzGsOGZZnQKfDAuHAVz8heTjC/06HRHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CvC61lUU; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-44fea44f725so19763201cf.1
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723843746; x=1724448546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh1ekE6QgxAcVA+h/c9C/EyvAn9mH6XI2ngwaD+SMM4=;
        b=CvC61lUU5tIhD9IstCSjp3B1/a+hCO4OQaUeX8vhCDwl5r/gcDeZlzsZC1TAh5F2vr
         rxfchtYCsfCTQ63Twdt3qp+KbsAdITEhKdNJc2BwOAnUUnFKdgClyGJaUL1ifJDqk+1G
         FeTi+Xfmj+tUqyZAj6P7+eLwCHnTesnfakUww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723843746; x=1724448546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vh1ekE6QgxAcVA+h/c9C/EyvAn9mH6XI2ngwaD+SMM4=;
        b=KhgdL0Q2FTjp0Y1aNn7UsGAqXEH/cM4nM00Wne2kwG6aLjYI7O16HjAFv7teCk9OYe
         XB+vHDJ2Tzq9Bru27XN74nwePvid7PPhJs71LMj4S8yAaqpwYoG9tgumqqcSxoE2ZJ5b
         j6+09AsQehvnATGDkzV0LgLqMVirnoAIxx2MxgHf7x9PHnbgWveNSLo7jLsg7qtvbvJg
         f74QhjczrEgQ4eUNT2mUxutOsAYbBGnPaSXFsgvNj74TggVXdb+R97GObJpJvciuswjh
         3OraX35sHpSq3+KSMy/mzcWco+ZArwBHGK3cELBuQb0TqyjmntucvppJwayU9aVLS7Ea
         uo+w==
X-Gm-Message-State: AOJu0Ywk4dcur09qHxTuJlQ6ovz8KISI2/Czh9nGavf/z5KZWOVoBinD
	AuGuu6GAQSFershT1Gq4EFDvJIaW22ciH6kWOkxSfV1ua7Vz1K0NqPEEQL7y2g==
X-Google-Smtp-Source: AGHT+IFnpRIqEqIwLEXDvsj0CyX3dY0TpUR2ky8LmBLmg8mDuLfh8DOFiT2e59F2PPs8T5PYt1+dLw==
X-Received: by 2002:a05:622a:148a:b0:446:54f5:3181 with SMTP id d75a77b69052e-453678d7116mr146282181cf.24.1723843746408;
        Fri, 16 Aug 2024 14:29:06 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd72aasm20752221cf.9.2024.08.16.14.29.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 14:29:06 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org,
	helgaas@kernel.org
Subject: [PATCH net-next v2 0/9] bnxt_en: Update for net-next
Date: Fri, 16 Aug 2024 14:28:23 -0700
Message-ID: <20240816212832.185379-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series starts with 2 patches to support firmware crash dump.  The
driver allocates the required DMA memory ahead of time for firmware to
store the crash dump if and when it crashes.  Patch 3 adds priority and
TPID for the .ndo_set_vf_vlan() callback.  Note that this was rejected
and reverted last year and it is being re-submitted after recent changes
in the guidelines.  The remaining patches are MSIX related.  Legacy
interrupt is no longer supported by firmware so we remove the support
in the driver.  We then convert to use the newer kernel APIs to
allocate and enable MSIX vectors.  The last patch adds support for
dynamic MSIX.

v2:
Only patch #4 is updated to fix a memory leakage reported by Simon.
The changelog of some of the MSIX patches have been updated based on
feedback from Bjorn Helgaas.

Link to v1:
https://lore.kernel.org/netdev/20240713234339.70293-1-michael.chan@broadcom.com/

Michael Chan (6):
  bnxt_en: Deprecate support for legacy INTX mode
  bnxt_en: Remove BNXT_FLAG_USING_MSIX flag
  bnxt_en: Remove register mapping to support INTX
  bnxt_en: Replace deprecated PCI MSIX APIs
  bnxt_en: Allocate the max bp->irq_tbl size for dynamic msix allocation
  bnxt_en: Support dynamic MSIX

Sreekanth Reddy (1):
  bnxt_en: Support QOS and TPID settings for the SRIOV VLAN

Vikas Gupta (2):
  bnxt_en: add support for storing crash dump into host memory
  bnxt_en: add support for retrieving crash dump using ethtool

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 331 ++++++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |   8 +-
 .../ethernet/broadcom/bnxt/bnxt_coredump.c    | 101 +++++-
 .../ethernet/broadcom/bnxt/bnxt_coredump.h    |   8 +
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  13 +-
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   |  29 +-
 6 files changed, 303 insertions(+), 187 deletions(-)

-- 
2.30.1


