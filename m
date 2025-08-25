Return-Path: <netdev+bounces-216576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47A5B3498B
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 20:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FD875E7954
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA9F3093BC;
	Mon, 25 Aug 2025 18:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NpJJFjax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f226.google.com (mail-pf1-f226.google.com [209.85.210.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A63093BD
	for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 18:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756144807; cv=none; b=P8O0YpNSjM9VyUwrSA12HJpA29nSo7WlmmVuYwgL16w/kuCbJydjcL7oIVp1rE0NFCvr53apvZO0V3BVJDK1ymoikCrqjRWYwIMVeEyqMK+m8WcjzEMooD6Xpoc9wBQRn5FAkkc+QUEN70vB5nCf+0ZTRFFBh2Irjgvz2hGZH/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756144807; c=relaxed/simple;
	bh=110meE4xIs17bwXKo3MIshkvEezBzr6WKcPXdP5acEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjdv4Ubh1zDOfutOj8Of0BXflmLrATH79273yQErsopI+0sjJ6RXTQVP1rj+hHufYc7KEN1ZbiEacKplc70Z8TVZ06bBmAtKtbJ3de84G5WPR7jQlCwrz1bUA4XiBCmGFTwnmF1lIoqrHghEUJUmmTEhZJ6h27ljuE3ersZr60c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NpJJFjax; arc=none smtp.client-ip=209.85.210.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f226.google.com with SMTP id d2e1a72fcca58-771e4378263so1033962b3a.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:00:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756144805; x=1756749605;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6FDa8hLaeoqdDwcnSLNZcIf3wHnofiQaaKFvh5IgfBI=;
        b=a83bq93Pk4D0HJlTQHO0GCkxVrInIjyYrm2+QfqxLem/n1wm18vKN7ACHCkcbekj72
         HH/OKC+B3GZ//eF091RiRNrrZA/ZCgorctn9AtxcbOIcySGTCCe4PQ04LhOJa3ePmt8c
         hYbctH5/AQ5CqdRMslUe2h5uRyxVsM2iYYrA6Tli4SyhDoOMgqMmUjPKOJ/jZkwg/jdb
         P9w6hL/LL+72C6gMQl7j+PcyPO8Q9Gy+9Iw2cnTTqYdcBcjKjqAry1dj9UeZ5IxtBLr2
         W2BOC198YHYeR3NwwU0tW6puqN1bREzWh6EcbN49kW8y7ghGa7pMNDyh8qdpmwfMaQz6
         uo5w==
X-Gm-Message-State: AOJu0YxT6+pSZ4af3bWbFZRDGvmCS786/6aVg0jCMjheGy83WP5+6LUi
	6+MxrzByn0I7Y99v13nNfhfAeMIo9dAwaCziuHAgPIipGrfTmEBgjAa7U2F5t0xK4pIrsn2wrrW
	mfAtNrhjiqELuYgWOLZP9jI6i959c47Bf4V8dt/nAvfZvW+l0w/fLXPcRqThPSzr7FBqmB/OeLc
	aJPkgXSk+iRhFpk3YywAHDOJyiwOuOhncZii3ilBr/pFtEpSYypH3goXswuA18eA5yYeFHSo+kT
	JKIKYSwgmc=
X-Gm-Gg: ASbGnctmAYwnAl7Od+jGXdB3E/evL17p/scbdUuG1Iu+SoOYEVA1DyLmZawSVG3n9UZ
	jyA2TI5LYyl7iiNAAHI9QAHcXxds6EEocTm6KgthqTzOxRRJ78nWHjW61Xc9nqsAa1M9OH6q1j2
	kYl/F9sV6aO6+p7cuVTmx4cV92OvNWeQcVYFU9JmJ5jxZuOu1zVEs/NaiShxfzg/9XHWTxqKB+s
	IpbzA/mSzti+9GDForCJwvUBQPf/f9WSZOFqb69SPmQnubaP3jv6BC5sBVeN+ph3iUFXd8vPagG
	0i7Owu2BwDwxvsnlBM1LuTH8ev7MZffgLW7RRaPXJP3eyNUXipJ4Qkieb2r56erfniU8RN1M/Zp
	sa1/TEBLHEuEXNWolO9Kh3U2UyPFJP6gxGw09l/B4CoVPVKNFpyF1cbnq8T9JKJISXwKY6LjVV5
	Q5tg==
X-Google-Smtp-Source: AGHT+IEsLysl4vCf28BDJfaqMRl6oz8uSn2/HLXeVPIQ/A6vbN5183CCvlk8VyO0w1aIGfsPWDiksH5dRndn
X-Received: by 2002:a05:6a20:9189:b0:243:7beb:8424 with SMTP id adf61e73a8af0-2437beb8edbmr4514982637.46.1756144805033;
        Mon, 25 Aug 2025 11:00:05 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-771df8aa4c0sm257597b3a.1.2025.08.25.11.00.04
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 11:00:05 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e870315c98so1710541385a.0
        for <netdev@vger.kernel.org>; Mon, 25 Aug 2025 11:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756144804; x=1756749604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FDa8hLaeoqdDwcnSLNZcIf3wHnofiQaaKFvh5IgfBI=;
        b=NpJJFjax8DmXWWK7sjwBfWV3j6d5rnzuooU8eYOdgu7z9IaJSEehfB/mdlNUzLut1a
         0WnxFTJDDfk0NJIFYVzVGKHkWHSdmrpcKt2GWr9P0rjDD+BMzA72IEvR23FI/uJhch4d
         7fBy/HYHIrK9nfqSpGcPKcgZZ5+1wDBKGPaCE=
X-Received: by 2002:a05:620a:4709:b0:7f1:f616:1190 with SMTP id af79cd13be357-7f1f616182bmr348507385a.26.1756144803585;
        Mon, 25 Aug 2025 11:00:03 -0700 (PDT)
X-Received: by 2002:a05:620a:4709:b0:7f1:f616:1190 with SMTP id af79cd13be357-7f1f616182bmr348499885a.26.1756144802720;
        Mon, 25 Aug 2025 11:00:02 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ebf36e7640sm527498585a.59.2025.08.25.11.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 11:00:01 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net 2/3] bnxt_en: Adjust TX rings if reservation is less than requested
Date: Mon, 25 Aug 2025 10:59:26 -0700
Message-ID: <20250825175927.459987-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250825175927.459987-1-michael.chan@broadcom.com>
References: <20250825175927.459987-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Before we accept an ethtool request to increase a resource (such as
rings), we call the FW to check that the requested resource is likely
available first before we commit.  But it is still possible that
the actual reservation or allocation can fail.  The existing code
is missing the logic to adjust the TX rings in case the reserved
TX rings are less than requested.  Add a warning message (a similar
message for RX rings already exists) and add the logic to adjust
the TX rings.  Without this fix, the number of TX rings reported
to the stack can exceed the actual TX rings and ethtool -l will
report more than the actual TX rings.

Fixes: 674f50a5b026 ("bnxt_en: Implement new method to reserve rings.")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 1f5c06f1296b..86fc9d340dab 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -8024,6 +8024,11 @@ static int __bnxt_reserve_rings(struct bnxt *bp)
 		hwr.rx = rx_rings << 1;
 	tx_cp = bnxt_num_tx_to_cp(bp, hwr.tx);
 	hwr.cp = sh ? max_t(int, tx_cp, rx_rings) : tx_cp + rx_rings;
+	if (hwr.tx != bp->tx_nr_rings) {
+		netdev_warn(bp->dev,
+			    "Able to reserve only %d out of %d requested TX rings\n",
+			    hwr.tx, bp->tx_nr_rings);
+	}
 	bp->tx_nr_rings = hwr.tx;
 
 	/* If we cannot reserve all the RX rings, reset the RSS map only
@@ -12879,6 +12884,13 @@ static int __bnxt_open_nic(struct bnxt *bp, bool irq_re_init, bool link_re_init)
 	if (rc)
 		return rc;
 
+	/* Make adjustments if reserved TX rings are less than requested */
+	bp->tx_nr_rings -= bp->tx_nr_rings_xdp;
+	bp->tx_nr_rings_per_tc = bnxt_tx_nr_rings_per_tc(bp);
+	if (bp->tx_nr_rings_xdp) {
+		bp->tx_nr_rings_xdp = bp->tx_nr_rings_per_tc;
+		bp->tx_nr_rings += bp->tx_nr_rings_xdp;
+	}
 	rc = bnxt_alloc_mem(bp, irq_re_init);
 	if (rc) {
 		netdev_err(bp->dev, "bnxt_alloc_mem err: %x\n", rc);
-- 
2.30.1


