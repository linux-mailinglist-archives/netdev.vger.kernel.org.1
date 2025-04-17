Return-Path: <netdev+bounces-183858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC60A923EB
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8CE4416D4
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9AF25525F;
	Thu, 17 Apr 2025 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="NihIWnC5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4574D255244
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910732; cv=none; b=K7s+hy7zeubDIA8yK8riTD3YqPsHwVZvoQUq7xrGrARwJJIQotfnQgKPkpNQfCu/kOhA723xfaRJLbQHSJzAgFOLZPDg/i4iOnP2xN7yzykEyDyK7mDIyhwaf6VurkQhkd61Co/7GoWdBY18DcGq47X08o1Q9RIMCh7QX5cYq7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910732; c=relaxed/simple;
	bh=P4grIgMcFBx6uX0VhGtxuvQCENvc2Rsj2FroJKBMbDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EpfClhLHawwk6NnScnG5bbriQBjjFPm/tGsdH7duV8GB3cjMbYqTgQ3gPDI6IGPahWM4aMYHJDdsB6ILcN95AbaBdTWL7scLW3jIBrwNsqRUoVc6RpitIGKflUaHG4CrkvbOILlxz00s4Z3eG53Yx21Wq7/BgmDVXXsqF+8Fe3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=NihIWnC5; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7376dd56f60so867628b3a.3
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1744910730; x=1745515530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YgSwWLJCnsmrTM6Kf/YHkuzpzYvCE+MfEaXp8mEkXW0=;
        b=NihIWnC5CovRi6FW9hbpl5vmYOo5CNTLXbLpZyQqKv3jzkbfMsLb4Dccw8X47kwLAM
         qi418byHKRlrNYqB6OI7Xk8LMxMTfSWPki06uuiDxtV2c0Kx2MWzbBnbbA8RoY39taDS
         RSrbIDFP9THvAMdamLkHPsSrdcjUnEKqYh1RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744910730; x=1745515530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YgSwWLJCnsmrTM6Kf/YHkuzpzYvCE+MfEaXp8mEkXW0=;
        b=C6ZKkwAWLV8T8D2gGYcPeaqpRb4Ab2AwQBSB2rUAywQW8ZQVQO1HV+aI+Iy+eb4uYK
         QgHt9q35bqfkSig1Qy2Dw2J3SIcH6Qdzj0ZhaTF0BqASf2t6u06uOQ1itEvLPJd1qSzF
         UrPXyoJHE3G7cTeB6SW5h44K//NbvfWQ38EUmT5oXBPFamRaW9KGteWU6ECNVCyaBtsF
         dfM6INQtkA5Yvnsj6IaBOiwz8u/WZepmDpzQTdvRTevvYHae68pFN+LtbeNcuv/2KNiM
         AbDnXnIhgbsgp/hbaUTWoxmcY5vL4PJgxhGwoboN/lAr7Z3l6PPSomkYbyDdGouzz42L
         2EJQ==
X-Gm-Message-State: AOJu0YzViWUSza7jr4h8/UaVho9ROAdaKJAmzjMAmOgDo3lPcau163rp
	UAn0RDkF0eX6SwTu76X+sIN886KIgNQjX0//Bb9iewfPFf01iFZ43lS69F8KIA==
X-Gm-Gg: ASbGncvI8iWziHU30jqsI8nbBxT7HD7JFXv4dFeb7T+hNbSqRxxpxVHK4ZRhRyRyFyN
	nWgcbkITV/3CyBV8CiOIhwQ1ixABvUWX0DGMQ+EzflCk+QPVOscN1JAHX3mi3CjK/JJfFhdtIAX
	z2AKt73yLzcMEyhsXVvLbqr2IMbOagXjoVelH0t8J1XmIg50B54NfTC1+ngEh9C8lCy14e6+SOS
	MEhk+HPlCd3rzihFiaJ9kdznm8i59hhBQNxl3p0MtWzi/r+6Jv4rtHXE3AdBs9R45S0rWFNMpJk
	YI1NPIaxsi1DTMF4oCr9smxqO0mljj/7L9SIhj1n8ESXIdqGFus04ayGgYODfnaVy3JLkk3I+95
	gkCC9Y2zbSSRPzqg+v9HuOuXxen8=
X-Google-Smtp-Source: AGHT+IHYGyJuMXA4G4Gwt4hZEjxzc9Kb1hN/hhhnpUtu2ZLQBfdinuXX4/Io7u/iV4dJL28+8bdaUw==
X-Received: by 2002:a05:6a00:1da6:b0:739:3f55:b23f with SMTP id d2e1a72fcca58-73c2671803fmr8951472b3a.14.1744910730451;
        Thu, 17 Apr 2025 10:25:30 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbf8ea9a4sm109879b3a.41.2025.04.17.10.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Apr 2025 10:25:30 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Shruti Parab <shruti.parab@broadcom.com>,
	Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Subject: [PATCH net-next v2 2/4] bnxt_en: Report the ethtool coredump length after copying the coredump
Date: Thu, 17 Apr 2025 10:24:46 -0700
Message-ID: <20250417172448.1206107-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250417172448.1206107-1-michael.chan@broadcom.com>
References: <20250417172448.1206107-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shruti Parab <shruti.parab@broadcom.com>

ethtool first calls .get_dump_flags() to get the dump length.  For
coredump, the driver calls the FW to get the coredump length (L1).  The
min. of L1 and the user specified length is then passed to
.get_dump_data() (L2) to get the coredump.  The actual coredump length
retrieved by the FW (L3) during .get_dump_data() may be smaller than L1.
This length discrepancy will trigger a WARN_ON() in
ethtool_get_dump_data().

ethtool has already vzalloc'ed a buffer with size L1.  Just report
the coredump length as L2 even though the actual coredump length L3
may be smaller.  The extra zero padding does not matter.  This will
prevent the warning that may alarm the user.

For correctness, only do the final length update if there is no error.

Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Reviewed-by: Damodharam Ammepalli <damodharam.ammepalli@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 5576e7cf8463..9b6489e417fc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -496,9 +496,16 @@ static int __bnxt_get_coredump(struct bnxt *bp, u16 dump_type, void *buf,
 					  start_utc, coredump.total_segs + 1,
 					  rc);
 	kfree(coredump.data);
-	*dump_len += sizeof(struct bnxt_coredump_record);
-	if (rc == -ENOBUFS)
+	if (!rc) {
+		*dump_len += sizeof(struct bnxt_coredump_record);
+		/* The actual coredump length can be smaller than the FW
+		 * reported length earlier.  Use the ethtool provided length.
+		 */
+		if (buf_len)
+			*dump_len = buf_len;
+	} else if (rc == -ENOBUFS) {
 		netdev_err(bp->dev, "Firmware returned large coredump buffer\n");
+	}
 	return rc;
 }
 
-- 
2.30.1


