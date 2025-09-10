Return-Path: <netdev+bounces-221563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29ACFB50E07
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 08:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DD1B7A8021
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 06:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3B62D3740;
	Wed, 10 Sep 2025 06:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NoXZ/DDP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC2D2248BD;
	Wed, 10 Sep 2025 06:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757485794; cv=none; b=c+j2aayflA6Ozqw3zk7E99NIWOkt+0+StswIx8bOJRfG6qnqJSWuBEPu9GvLR8Vg5o6DRcvqmagK6bIpFzg2Ock/ACFIhLDDovoM4DRR8ebcq519u5/vdp5hkVA97KEa56Pasa+CUNKeYRG92o25drM3TPmMwdm0Xcl0bw+E79g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757485794; c=relaxed/simple;
	bh=Dibl/kQKaHorGgBtFOaZ+szvArwC/81oVD0cUkuxExk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEGQUnT/avDKXDMZy7KIwF8c9nFrAVe2qMc7nM0R5IjSxT0ZTikn+MzpIzYEI1bvY/nqeWD5GlWqld7G78UHLuJKT7LDD9PhCNQJnDrJOERzgsyGMJ5y/qewZiZ91kdjouvhtB8f+cf/sqaQYUfpTvBbuS7JMEhye6pfwyyBfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NoXZ/DDP; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3df35a67434so4003559f8f.3;
        Tue, 09 Sep 2025 23:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757485791; x=1758090591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XKP313wOh9DVVumYpdxBRg57U3LWJuOfY6g/8BKP5Aw=;
        b=NoXZ/DDPhdymrbBIwP/N/C566y4RlYPUk193vv5F1wyqt1b2sr7/DnDgidtNI7HylV
         hPo/8UAfWZl7lVDWDuF/HKEJx57v3Bjca/O7gieNBS98p5uBNT5wmEiWo6ohZfjqrDEM
         yLcFk9vuTHMx4T1w/cyPp6QfZBdcUGQh03qFi1B2YPAii0xfy3AjTXcqb5ZhH3drLZQs
         rBaABULmsFULHL3kvwX6ZtVm2ZAj5l/hms8pUN2Nzju0IvNtdQ3fN6wIg1448/7OAYXH
         K/J/6RyQD+Sj3bFELFuM2LD5suvXx2leue4eEhS3Y7HAmJN95HgFzfgYDKh/MRgigV4t
         w9Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757485791; x=1758090591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XKP313wOh9DVVumYpdxBRg57U3LWJuOfY6g/8BKP5Aw=;
        b=GUQ/OuJZMqB8WADs8rxT1ETEYKN9XrXS9S/YuNs4T7CiWwwo80vEawLhRfeFxwK6F4
         Ct0ki6MzsPMmJeKLFd+rDgJOubyNYiKlv4TkJ2BZD+MLg2jFs/WnBVLSk/ezLvJXA78G
         KNLEJGTc7pyCA3w+VPXc8uYZCBMts3xKLDqmepK3hIIKHtaNx/mmuNClorCm2UWgIhob
         LgXeRl3y31f17i2NaWKzxYTNiIH0agBn7sLTZLn/TnoCnH1jhz1Fgd59SL6KZdi9XBae
         SGJILpQfovs0SwakHq0pGp1nr5UbiSmXHLEOzRtW7GSJD2gEQwaBEzqR4jOX6gjSkxZo
         GmNg==
X-Forwarded-Encrypted: i=1; AJvYcCVh3k0iN06EJLv7mz96RXdTFOvrnQdYirngHL7WQbqsAnQUOwyn2kQBLT1mQ36tmCFvMnzd/zU2vy9Dedg=@vger.kernel.org, AJvYcCWi7NSl08+FcUl1cpQ4P0+vTQWexVrzYdS/qd+6/O4HjWSmceUI0lNcWCWl6edZ6iAoZwZH2akJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ucmBbc4x1udWvlle4Oyd/IsYvV4IsSK2L/KKodnhSPyeetUF
	NDJ40gItTI0GVCkcEGiV1gmD9nq24SxN35Of5MDlDcVxY9Zt1eL+sGNP
X-Gm-Gg: ASbGncsvqiGH36XN+p3R3nXg2BwVxFbgkvER2yMrB2ndHVjGKepLJPT7Czv9JN16lVs
	VP7jnf3VefkCTNhAvwi3wIsF477zSrGzKQW+MfpB0+20F5p436h9UdqpIowFS1Q187L7si1x+he
	LCEboANbkQ5R1M2mB4welS6korF4HwkOnYTSZ2XZ4LYlRaYmPL2XY9NXiGMXhkl1Xb3LTVcVxUm
	sWj9I53aBxczAdgGVpeXFyHY0uKYokGiFtaMk6m6F9MkK4N/UQ9Y8Gv4Iei20YsHEBftcS9SUb1
	qZOJxNEul9srQmPt3SOcbG2QgEMW4+OlvGnG6/vxuIDssZTIqAVN+L1ZI8D9BEIMkA5Seg+XECF
	+E8cEkL9+Lwfk86d3d9MnLQ8aTMYv9OVq9OuTHpp1rGc=
X-Google-Smtp-Source: AGHT+IH4xjeDI7BMGYFkTG+1E5nlBu48fC0/KJ/xYPASFL1LXZ2TrP6ZQFypKRu94cbojkyCom0C2w==
X-Received: by 2002:a05:6000:4022:b0:3db:b975:dba with SMTP id ffacd0b85a97d-3e64bfd7047mr11281874f8f.63.1757485790700;
        Tue, 09 Sep 2025 23:29:50 -0700 (PDT)
Received: from localhost.localdomain ([159.196.197.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521c9cdbsm5832477f8f.16.2025.09.09.23.29.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 23:29:50 -0700 (PDT)
From: Jamie Bainbridge <jamie.bainbridge@gmail.com>
To: Nimal Prabudoss <nprabudoss@marvell.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Manish Rangankar <manish.rangankar@cavium.com>,
	Michal Kalderon <Michal.Kalderon@cavium.com>,
	Ariel Elior <Ariel.Elior@cavium.com>
Cc: Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] qed: Don't collect too many protection override GRC elements
Date: Wed, 10 Sep 2025 16:29:16 +1000
Message-ID: <f8e1182934aa274c18d0682a12dbaf347595469c.1757485536.git.jamie.bainbridge@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the protection override dump path, the firmware can return far too
many GRC elements, resulting in attempting to write past the end of the
previously-kmalloc'ed dump buffer.

This will result in a kernel panic with reason:

 BUG: unable to handle kernel paging request at ADDRESS

where "ADDRESS" is just past the end of the protection override dump
buffer. The start address of the buffer is:
 p_hwfn->cdev->dbg_features[DBG_FEATURE_PROTECTION_OVERRIDE].dump_buf
and the size of the buffer is buf_size in the same data structure.

The panic can be arrived at from either the qede Ethernet driver path:

    [exception RIP: qed_grc_dump_addr_range+0x108]
 qed_protection_override_dump at ffffffffc02662ed [qed]
 qed_dbg_protection_override_dump at ffffffffc0267792 [qed]
 qed_dbg_feature at ffffffffc026aa8f [qed]
 qed_dbg_all_data at ffffffffc026b211 [qed]
 qed_fw_fatal_reporter_dump at ffffffffc027298a [qed]
 devlink_health_do_dump at ffffffff82497f61
 devlink_health_report at ffffffff8249cf29
 qed_report_fatal_error at ffffffffc0272baf [qed]
 qede_sp_task at ffffffffc045ed32 [qede]
 process_one_work at ffffffff81d19783

or the qedf storage driver path:

    [exception RIP: qed_grc_dump_addr_range+0x108]
 qed_protection_override_dump at ffffffffc068b2ed [qed]
 qed_dbg_protection_override_dump at ffffffffc068c792 [qed]
 qed_dbg_feature at ffffffffc068fa8f [qed]
 qed_dbg_all_data at ffffffffc0690211 [qed]
 qed_fw_fatal_reporter_dump at ffffffffc069798a [qed]
 devlink_health_do_dump at ffffffff8aa95e51
 devlink_health_report at ffffffff8aa9ae19
 qed_report_fatal_error at ffffffffc0697baf [qed]
 qed_hw_err_notify at ffffffffc06d32d7 [qed]
 qed_spq_post at ffffffffc06b1011 [qed]
 qed_fcoe_destroy_conn at ffffffffc06b2e91 [qed]
 qedf_cleanup_fcport at ffffffffc05e7597 [qedf]
 qedf_rport_event_handler at ffffffffc05e7bf7 [qedf]
 fc_rport_work at ffffffffc02da715 [libfc]
 process_one_work at ffffffff8a319663

Resolve this by clamping the firmware's return value to the maximum
number of legal elements the firmware should return.

Fixes: d52c89f120de8 ("qed*: Utilize FW 8.37.2.0")
Signed-off-by: Jamie Bainbridge <jamie.bainbridge@gmail.com>
---
v2: Move the check to the correct place after discussion with Jakub
    Kicinski and more debugging.
    Add more detail about error symptoms to the commit description
    also suggested by Jakub.
---
 drivers/net/ethernet/qlogic/qed/qed_debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index 9c3d3dd2f84753100d3c639505677bd53e3ca543..1f0cea3cae92f542e0213af87e885406599980a9 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -4462,10 +4462,11 @@ static enum dbg_status qed_protection_override_dump(struct qed_hwfn *p_hwfn,
 		goto out;
 	}
 
-	/* Add override window info to buffer */
+	/* Add override window info to buffer, preventing buffer overflow */
 	override_window_dwords =
-		qed_rd(p_hwfn, p_ptt, GRC_REG_NUMBER_VALID_OVERRIDE_WINDOW) *
-		PROTECTION_OVERRIDE_ELEMENT_DWORDS;
+		min(qed_rd(p_hwfn, p_ptt, GRC_REG_NUMBER_VALID_OVERRIDE_WINDOW) *
+		PROTECTION_OVERRIDE_ELEMENT_DWORDS,
+		PROTECTION_OVERRIDE_DEPTH_DWORDS);
 	if (override_window_dwords) {
 		addr = BYTES_TO_DWORDS(GRC_REG_PROTECTION_OVERRIDE_WINDOW);
 		offset += qed_grc_dump_addr_range(p_hwfn,
-- 
2.47.3


