Return-Path: <netdev+bounces-128223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F38C978900
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 21:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9F9A1F2603B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 19:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E055145B38;
	Fri, 13 Sep 2024 19:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMrBm0T5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CAE12DD90;
	Fri, 13 Sep 2024 19:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726256068; cv=none; b=YLuw2XpA+wOIeJb+Ni6v0RDmZk5mR0YnXVHEJ4ynEG2sbqTWqvWP6AhTEum+4MZQpNleTldAt6qgxwnsCW43w36mD70rHhhNq+Co3rKv1KDj7G/f/sy2I0kVeCUs4IgjNj+4xUsnrO1oQEC403jH0t5oNG89PFP1J7ngTybQJIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726256068; c=relaxed/simple;
	bh=58xEeBUkLGAvA3YTBf8guodbomstYwW1DUFe8yFZ6EA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QM/kCRvwTzIYIsaYRMDjmZWYWciNNdbe5LbAmVBHw5DQo476pOPDL1EW9kKLsPI7xMkKrDVdcLHIPuiqhAtxaCJFSg979svhZLPwk8w/0xhxF9Idss6KcGqqbnlGS7D0aHPYuyKo18TXCzgcnlTFLiPIocTHCnYOhd4tVRWeCYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMrBm0T5; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-718d91eef2eso1657803b3a.1;
        Fri, 13 Sep 2024 12:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726256067; x=1726860867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1LSaQHVbC+YpoJ3RozOP+5aECp20xDoqhwrpbiQ2wDM=;
        b=gMrBm0T5BMl46tl008+sUJASKyGnEWt85VL/pbD1Zncf9hnP/yEQ7xBgXkFv1xdBmI
         xNUIYuz/1wImJzjpdS2ZdEUYPzZopFWhYtn+GUSzlQ3TnmJ3zYsIBGGkgeav9VTWH30S
         M8VrQSbmrcgX/SIKSFTrq9b9jAD0lrWMxH7VhtmF0O2Ek9Dn53qH5NhYZIHda7L/tKFA
         O0SOdF/d2irTY7rbcczhhCmqdgEaCHocluJ97c/KXOUyRlXssai6yyCVob3BA/Czo5hK
         IW649jMhWoOsWUvFwzA6493ue8CFqS31qVn+Klwg/yejuY47Kg0UJPdEFXxnXnbWRvlB
         juTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726256067; x=1726860867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1LSaQHVbC+YpoJ3RozOP+5aECp20xDoqhwrpbiQ2wDM=;
        b=YF1t3HH6Q33M5h//jhU1RbixaUe/vfQ/H3CvyDAkiUWa3Pvg6/+oxHIV/W0rn4QetR
         wvka7j0vo8fyQhJNyQyXkplniAxgFh9eGmaTQ68dugXCKR3FtCqs+T3hdpEiICPFUflb
         EOJjSLQZdxg2AwDM5LCcvdX3EqkyuACJYOXbir68t55kazwI+GeVbDW72t17cKuJMICd
         CTdscLFdM+N1ijDME8TF81pmMI57Ik8CMis9jfZxzSb/yjuPy4fzyRYLmkUxGTg2NmdS
         R+dp1qHRq+6Aqme6vh7jO/vAxrXXI11xCFP8qh5DU+A6uViw6BybTmPyzgaRJKlLzCCt
         yJrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVH7U+0XTtaLCbBQj9gXRPEyG0yvyh6izJtR2M6NZg55/RUhy8110zY8wYmA5IWbfLAPWHlDM5dXcA9HUA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdbSIy8Om8q3RftCpCZyU5fI0RPTfuUnsvO6IbLzrv+hNG/noK
	FioHoTHiEeA5ILdfC54GID4Af+zX5kmlG5qQg7IePVpAIFyqOyrOilFzVABk
X-Google-Smtp-Source: AGHT+IFfjtobqQPMkb9OKLlg1I5PWajndb+eLtuLMdvhxBWmOQ4JJ0fKh+2FCmn3asUIzAuiLIKtnw==
X-Received: by 2002:a05:6a00:2d05:b0:706:aa39:d5c1 with SMTP id d2e1a72fcca58-719263eab2cmr11149885b3a.8.1726256066430;
        Fri, 13 Sep 2024 12:34:26 -0700 (PDT)
Received: from amenon-us-dl.hsd1.ca.comcast.net ([2601:646:a002:44b0:385b:1e44:bb9b:db08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090d08a5sm6407832b3a.212.2024.09.13.12.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 12:34:25 -0700 (PDT)
From: Aakash Menon <aakash.r.menon@gmail.com>
X-Google-Original-From: Aakash Menon <aakash.menon@protempis.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lars.povlsen@microchip.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	aakash.menon@protempis.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: sparx5: Fix invalid timestamps
Date: Fri, 13 Sep 2024 12:33:57 -0700
Message-ID: <20240913193357.21899-1-aakash.menon@protempis.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bit 270-271 are occasionally unexpectedly set by the hardware.

This issue was observed with 10G SFPs causing huge time errors (> 30ms) in PTP.

Only 30 bits are needed for the nanosecond part of the timestamp, clear 2 most significant bits before extracting timestamp from the internal frame header.

Signed-off-by: Aakash Menon <aakash.menon@protempis.com>
---
 drivers/net/ethernet/microchip/sparx5/sparx5_packet.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
index f3f5fb420468..a05263488851 100644
--- a/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
+++ b/drivers/net/ethernet/microchip/sparx5/sparx5_packet.c
@@ -45,8 +45,12 @@ void sparx5_ifh_parse(u32 *ifh, struct frame_info *info)
 	fwd = (fwd >> 5);
 	info->src_port = FIELD_GET(GENMASK(7, 1), fwd);
 
+	/*
+	 * Bit 270-271 are occasionally unexpectedly set by the hardware,
+	 * clear bits before extracting timestamp
+	 */
 	info->timestamp =
-		((u64)xtr_hdr[2] << 24) |
+		((u64)(xtr_hdr[2] & 0x3F) << 24) |
 		((u64)xtr_hdr[3] << 16) |
 		((u64)xtr_hdr[4] <<  8) |
 		((u64)xtr_hdr[5] <<  0);
-- 
2.46.0


