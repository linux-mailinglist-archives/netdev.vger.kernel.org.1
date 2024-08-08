Return-Path: <netdev+bounces-116696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3062994B621
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 07:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61E381C21AFE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B141422D2;
	Thu,  8 Aug 2024 05:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Z+dxus7k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F8013D8A2
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094127; cv=none; b=Ay4yfdE3DetK+055ktS7uOUXAD7DsjwmN/aG9nDlJxcRyvUzzS7LFkILHIOOtSl7TgKRXs6nW8basJ0YeMg2GBBzPnjIcMagf8Yloh1kR2e6VeeLx1VHStiqVZq/qG0FaQ6bQaLegvZW08CnxuqUAUGQj91y1RWGwSCB1MmHygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094127; c=relaxed/simple;
	bh=nWeXJhWIMKlEjPceIUZvFB6QKvuQLOssu1SHM6sTgDM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uAm20GsXiN3QgySVkjX1MSY41HvKS+BpecHPHzKofVvKluc1nbUmiXousgXpWbFqDRskuY++rlZAxJCQXcRz5TrRagyjmAwuOQdlzFU67zpxbAl3yfLhG79hVpk2KeASM49toPxoHx90aZmDUZfKpKXbCWHsKe+U0zr3VBgqsUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Z+dxus7k; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3d9e13ef8edso454323b6e.2
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1723094124; x=1723698924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rKPN+22znihD7cTkiWTsHDWSpQaoAnn+Kmif5bdwIi4=;
        b=Z+dxus7k6cyarh2gnbwVsREs42Bj2AfxGLe+u4AHSd2jlCfe/kcnZ1bnKlWVbfuX7f
         Bo1NjQbuC0Iqh3DRUkCCZ3Y3KN+5oyHnAL6gFYScMsNIYLbwQk2sowliiOBoRjLyeyNq
         SIPE3tqlpwLeNL1Bnf7blwKT81qjGwGkEjDD1+yO9OjTu3hEG4nqJeNUfbl71WVUvZDA
         9bf2gKipKqG2P5SRi88D6RoRY4V+HCD80yGaPwC1zvbbKwtT2qPmWUkp6d6cMpF945FK
         zE/AipQO6B+fV7dMgLMfoXT5dq+c5r2kUCj0G6DeuzhMbF31bm4oJC5ZXU7oHZvzseZb
         K8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723094124; x=1723698924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKPN+22znihD7cTkiWTsHDWSpQaoAnn+Kmif5bdwIi4=;
        b=Y5iDGFPei1KH1uLMezt7/36CPKtgoSn0kv5nmdMtFx5wskTrnw9pNeDktPqM7FjD+c
         GmiAsHYJhPJB90kJTKD7M3lF5peCW/coUg4vJvJlH0fk7NOHUyZAQ+m5Ux09Rw1jTZLC
         XlHd0WvLoRU93YAtlkoObr8P070WX2NHilnKNf5DJGUPctngvR14i8onXMzOl7Gh9Dff
         h4cxX55LrZJT5Na8lf/q37pCsvlLkvPsflahhSgrWzBe0LFqeKhh7mgUrHz+gGr2ENO2
         KH6GPHy9p5nkwFMDKEtEq023ddJY4TtiL0KQMPI7Ebw7fbjb+pYAsnkFIhhr0li64qj9
         en1Q==
X-Gm-Message-State: AOJu0Yw7lpnk8TpxeNNZZTvsoKxpD9x+iNUlsu71Nc9MP7z84NFSSgMH
	D2UVHZubI4vBm/GLkJxxeFK+1V9mI28as7LJ3PkuI85i/+tZ4bWndKIcK61dB+I5maf/ufRV7LV
	P
X-Google-Smtp-Source: AGHT+IHQVaV5pXThpFSGsEZR43sdRteOeGhoy9CqayLzZh2u/vB+//29+nHsL+/NibBhddFI/8qY/w==
X-Received: by 2002:a05:6808:1986:b0:3d9:de1e:c24c with SMTP id 5614622812f47-3dc3b4085c3mr782285b6e.3.1723094124649;
        Wed, 07 Aug 2024 22:15:24 -0700 (PDT)
Received: from localhost (fwdproxy-prn-032.fbsv.net. [2a03:2880:ff:20::face:b00c])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b76346b7f5sm7723644a12.21.2024.08.07.22.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 22:15:24 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	David Wei <dw@davidwei.uk>
Subject: [PATCH net-next v3 3/6] bnxt_en: Check the FW's VNIC flush capability
Date: Wed,  7 Aug 2024 22:15:15 -0700
Message-ID: <20240808051518.3580248-4-dw@davidwei.uk>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240808051518.3580248-1-dw@davidwei.uk>
References: <20240808051518.3580248-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Chan <michael.chan@broadcom.com>

Check the HWRM_VNIC_QCAPS FW response for the receive engine flush
capability.  This capability indicates that we can reliably support
RX ring restart when calling HWRM_VNIC_UPDATE with MRU set to 0.

Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David Wei <dw@davidwei.uk>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 93d377ce48cb..97fb570679f2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -6715,6 +6715,8 @@ static int bnxt_hwrm_vnic_qcaps(struct bnxt *bp)
 			bp->rss_cap |= BNXT_RSS_CAP_ESP_V4_RSS_CAP;
 		if (flags & VNIC_QCAPS_RESP_FLAGS_RSS_IPSEC_ESP_SPI_IPV6_CAP)
 			bp->rss_cap |= BNXT_RSS_CAP_ESP_V6_RSS_CAP;
+		if (flags & VNIC_QCAPS_RESP_FLAGS_RE_FLUSH_CAP)
+			bp->fw_cap |= BNXT_FW_CAP_VNIC_RE_FLUSH;
 	}
 	hwrm_req_drop(bp, req);
 	return rc;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 5de67f718993..a2233b2d9329 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2438,6 +2438,7 @@ struct bnxt {
 	#define BNXT_FW_CAP_VNIC_TUNNEL_TPA		BIT_ULL(37)
 	#define BNXT_FW_CAP_CFA_NTUPLE_RX_EXT_IP_PROTO	BIT_ULL(38)
 	#define BNXT_FW_CAP_CFA_RFS_RING_TBL_IDX_V3	BIT_ULL(39)
+	#define BNXT_FW_CAP_VNIC_RE_FLUSH		BIT_ULL(40)
 
 	u32			fw_dbg_cap;
 
-- 
2.43.5


