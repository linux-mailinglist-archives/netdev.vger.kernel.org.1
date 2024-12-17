Return-Path: <netdev+bounces-152685-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31BFF9F5627
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E3881713B9
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D18F1F9411;
	Tue, 17 Dec 2024 18:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RBrmzJqv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69131F892B
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 18:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734460030; cv=none; b=JnGpn5hgn+GeVonc5ZD/HOSer7FIbxy1TVH5WMRV4FKrRUA8AhVLb8XnIoV4AYoaiKx3AtNIBVp77U0mJIzqX4tm6U1M2iuvR4lWNI3hcA5+s5BWeFaW1M0W93D9CUjk+HAfH1PXGTXzv16fPGrF+jC7f49QUZtlMNo0hZMxgao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734460030; c=relaxed/simple;
	bh=2/2D6SYyrfBeV3rR6vMTI1duBJixL/23ePkZ4eexaZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UHNMGAXbmylVhEA+Q7bxzZf9Nri0OpGweT7NAh7CXhV4uCVC1zsguh6ti3gnpxhAJ/nFzAmwHXzY2hCQ0eAIPDstv4BkfvYsbVBSx+f73j53y+/xLQsgjrFoLELJlXrE6V0bK0g8rDVb2DNT5OoWB/sz7cW4Pcp98U+iFe3/80I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RBrmzJqv; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-21644e6140cso53535855ad.1
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 10:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734460028; x=1735064828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elwQOCg8tZXlgYKyqP8AcNa3TLlHrfV7/DBuEBwpCF4=;
        b=RBrmzJqvg5CaeUCqcbXKdltQ2MENqYmsYBoeNXKf8Rjoj4G8Aq2PjciPLLO4tTssFE
         53I20ckmaTeAcEKUsS4CWRmzuPZOmvlHFDJOMV/xbJoJziXulwKxbrm3TNE+kpt0jp6+
         Vnjpb/MZSjSHKwtH/d7Txa5QEUBC6+mWaR/OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734460028; x=1735064828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=elwQOCg8tZXlgYKyqP8AcNa3TLlHrfV7/DBuEBwpCF4=;
        b=cjQGhfEsv/J+T+NBDPluFe2lXcIAKMuFQrRpxhrtZgwCaEsRva/a70rbn+mny+F2xn
         /OanDC1xx+B8O18mrOB8ZSi94Mffi7KcRM/HalTuaSMRXqThvKVkLHUTpbY8bw6KBLse
         mY53aQ/SbRjrnGwcVrUJvH6DV9sWYpw7qj7rkpPrsN4T0rJmdPXkH59viJZ6Bc4ojVh1
         CGGUHPJkQMtPpeWKPn+ynu+dTG9SC4IewjjcPlRQ2z2bI2KLCggrFJ/Iz/uN150fusMy
         yvQ/BA4LwXiw/Y1aNUdvnkCuD8XjwgGscXjgzzkDgRUIJQG71gWqbm3N8oMHYen4nk0f
         /hVQ==
X-Gm-Message-State: AOJu0YzG8wCHoKF5G5pRyNRQ80e7Ztb7TfNxjkpmDQ3SH/j3tfSn0gy1
	ZCSqUEHdGaafLuXPvGbE+u/GlAsGlh4cJ86SKWSFdpnNGqIPRKCl3vlVixW7bQ==
X-Gm-Gg: ASbGnctciUbTofSzL6QoW/Mr/s8ETvp7RsKhvrrfvwqEwAkZoTX7YCWjvZXmaELJ4XT
	nwT73Wo1wY4s7d5hDJ+17Cd3OtqWw9ByxfGUOFI3QsyDgLccvLoD5aC7muIzblbvb97CS0+092N
	XxVaygtY768eeYliJU1z3KSJjuM5QksqwZAH9EFdBWcaXSQnhBTht0ANeTnfJcoJDvk7fxrXOaf
	SQvokBk9UJoJFuVzajCgfGVlmguVqg/yJsRvIoZaNV54iFjzgKjmcUKuzBuRuj5/eT66kI+uTan
	nYt7aQsFMvsvLWiRPkT3FMERlHlb3o+k
X-Google-Smtp-Source: AGHT+IHMXId/otyMXvNUNa9cT3TCAQyKK4fwK8hxUvpN7vL0wu6Kpbuh6YRbGqGZOJNtxO98wTDnSg==
X-Received: by 2002:a17:902:d481:b0:216:5854:1062 with SMTP id d9443c01a7336-218d52d28cbmr5825715ad.57.1734460028030;
        Tue, 17 Dec 2024 10:27:08 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e63af1sm62496595ad.226.2024.12.17.10.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:27:07 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next v2 5/6] bnxt_en: Skip reading PXP registers during ethtool -d if unsupported
Date: Tue, 17 Dec 2024 10:26:19 -0800
Message-ID: <20241217182620.2454075-6-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241217182620.2454075-1-michael.chan@broadcom.com>
References: <20241217182620.2454075-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer firmware does not allow reading the PXP registers during
ethtool -d, so skip the firmware call in that case.  Userspace
(bnxt.c) always expects the register block to be populated so
zeroes will be returned instead.

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index c094abfa1ebc..75a59dd72bce 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -2050,7 +2050,8 @@ static void bnxt_get_regs(struct net_device *dev, struct ethtool_regs *regs,
 	int rc;
 
 	regs->version = 0;
-	bnxt_dbg_hwrm_rd_reg(bp, 0, BNXT_PXP_REG_LEN / 4, _p);
+	if (!(bp->fw_dbg_cap & DBG_QCAPS_RESP_FLAGS_REG_ACCESS_RESTRICTED))
+		bnxt_dbg_hwrm_rd_reg(bp, 0, BNXT_PXP_REG_LEN / 4, _p);
 
 	if (!(bp->fw_cap & BNXT_FW_CAP_PCIE_STATS_SUPPORTED))
 		return;
-- 
2.30.1


