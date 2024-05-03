Return-Path: <netdev+bounces-93221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A431E8BAA9B
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 12:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8B3DB21943
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10BC215098B;
	Fri,  3 May 2024 10:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qsp5u4qo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD714F9F8
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 10:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714731523; cv=none; b=VF6KceP2k9Tbt4ezdZoSLjPpyyQW9T21+bKHbwfmyGw1tftP6HMzGVa42oZVbwAACaTtN+jvQAdtMs7k/qF2zYhNEJfWMwimaU2kYjNvbDH+2g3twq1YKwMfLbbPvCvnJkSRdzm4XJ51t2Jw/LVEhdr1BUrJrJ+hGJk8C5hvho4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714731523; c=relaxed/simple;
	bh=DElX5LUe3OoaRwas6ikDj3cSBM05kNwuPrdkFmiH1nw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X/ayBoXcRUZt+5fbVG8XJl8BC4EPSMbKj0xYtu3vW8IDDRwxZf9wF2N+z1vLOvl4SPXVtC44i10aq8MQxqZCwKZaphN77fpjreBFmI6Ll5XXBzXB0wURPrPkM+7PqyH0tAKjaqvTdDbjHLk4Ol80zIXptD6Vqa+gS5eCgp/AoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=qsp5u4qo; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 95A8F3F722
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 10:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1714731511;
	bh=jjRe6xajUkbmK1YsugK7qDg3PV7FRVVruktd97oIQNA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=qsp5u4qoEiTXPzjm7pS8SBRwo6eS5tk7WAYtJXJ4ObCsP4ZUUujGhPOPNHBJotopI
	 EbgG7y+MLr3BJQCHD6ehegLqF12nnIqjPpVd21uzq1N/Nla0FR7jemlpA30kwl4hLe
	 YyL+eqQYoM3eQm9K7plYQtOZgb0TuO0LE9TsvkhMBnw3ycryu1M3p1lpH8jieKDSro
	 KuLd2SlSCb9G7yH+KEcpnohSTFIlLqOF2JwBzNy+nTx3Ie0/U0VQFRKeodQZqp8C9C
	 1PO/nKl7wq1+pPM8Qo45V4rvy21JWr/5rZ9MHwQFHK2ygxZfdQMCPFLH36LRxRq75D
	 R/F9F87IRFSEA==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cfd6ba1c11so8530744a12.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 03:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714731510; x=1715336310;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jjRe6xajUkbmK1YsugK7qDg3PV7FRVVruktd97oIQNA=;
        b=mtVi8ii3RGqA7lat9Uklqj3gQpskx2D0fL65gyh+twydTaOcpMspUlRocJ6Pcw6DVi
         pYZwYiAhe2VfCw0AHQSWcSEI59zGo04/zgaV+lKcSpQbA2ByuHgVJ62CTTSixy2Dg2pc
         OqXh0AWOD6U/YAmUhaNr3Ta3xN5hw2Dt2rmN6iXUxfBKeRNO1Xaiv4zOuG6KZ+UfPuhP
         5J4wT0lL40Cagon2rUVltwWsV1i2G60Zr/fsRFrHVvvuyAu0LPGH1SIxVEdEcaVHviWZ
         9OSq2H9j9vKIAhsTN70u3lvwo5qnNYJ0P4LDrTZPAo3IQykeqEEAMKOcrDzH12lE7bLG
         vD8g==
X-Forwarded-Encrypted: i=1; AJvYcCU2KkNZPyJ3d6rLgvmIx1TLVB6cnfTXKom/5K95sXI3wmfywRveYixoRyk/56fsC/cQqa4sop/MGVddAJKGauy9TM8nX0IM
X-Gm-Message-State: AOJu0Yz+rWzEq8vZuNFLBOTfYsbM6XuigudCqcWCI5y2HpZ7myyVuR8S
	nIWcrHWmB9HjtgHIcXu+FbaTz0mZTK5V9QzfGXezCvwSrkOw8bqDG/v11JdBPGRQHjkrSVEIPlb
	RSdBah8Y43o4Yv8t+ytkc5kd/q7/vBkiafmgiq/uzXhuCPPrvSL9FvX6sbNz7e8mh5+Avtg==
X-Received: by 2002:a05:6a21:33a6:b0:1ac:4272:5f88 with SMTP id yy38-20020a056a2133a600b001ac42725f88mr2589345pzb.17.1714731510169;
        Fri, 03 May 2024 03:18:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJIBpRvU4F9VMM0s2VJG699R/KuRERA+E2lxptDmXVTDVYDFnjQPQXw+wlQEB0fPnDSPcQrA==
X-Received: by 2002:a05:6a21:33a6:b0:1ac:4272:5f88 with SMTP id yy38-20020a056a2133a600b001ac42725f88mr2589323pzb.17.1714731509849;
        Fri, 03 May 2024 03:18:29 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (2001-b400-e23f-5745-953d-200f-4ef8-798c.emome-ip6.hinet.net. [2001:b400:e23f:5745:953d:200f:4ef8:798c])
        by smtp.gmail.com with ESMTPSA id p23-20020a1709027ed700b001ec379d8167sm2926259plb.115.2024.05.03.03.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:18:29 -0700 (PDT)
From: Ricky Wu <en-wei.wu@canonical.com>
To: jesse.brandeburg@intel.com
Cc: anthony.l.nguyen@intel.com,
	intel-wired-lan@lists.osuosl.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rickywu0421@gmail.com,
	en-wei.wu@canonical.com
Subject: [PATCH v2 1/2] e1000e: let the sleep codes run every time
Date: Fri,  3 May 2024 18:18:24 +0800
Message-Id: <20240503101824.32717-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Originally, the sleep codes being moved forward only
ran if we met some conditions (e.g. BMSR_LSTATUS bit
not set in phy_status). Moving these sleep codes forward
makes the usec_interval take effect every time.

Signed-off-by: Ricky Wu <en-wei.wu@canonical.com>
---

In v2:
* Split the sleep codes into this patch

 drivers/net/ethernet/intel/e1000e/phy.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/phy.c b/drivers/net/ethernet/intel/e1000e/phy.c
index 93544f1cc2a5..4a58d56679c9 100644
--- a/drivers/net/ethernet/intel/e1000e/phy.c
+++ b/drivers/net/ethernet/intel/e1000e/phy.c
@@ -1777,6 +1777,11 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
 
 	*success = false;
 	for (i = 0; i < iterations; i++) {
+		if (usec_interval >= 1000)
+			msleep(usec_interval / 1000);
+		else
+			udelay(usec_interval);
+
 		/* Some PHYs require the MII_BMSR register to be read
 		 * twice due to the link bit being sticky.  No harm doing
 		 * it across the board.
@@ -1799,10 +1804,6 @@ s32 e1000e_phy_has_link_generic(struct e1000_hw *hw, u32 iterations,
 			*success = true;
 			break;
 		}
-		if (usec_interval >= 1000)
-			msleep(usec_interval / 1000);
-		else
-			udelay(usec_interval);
 	}
 
 	return ret_val;
-- 
2.40.1


