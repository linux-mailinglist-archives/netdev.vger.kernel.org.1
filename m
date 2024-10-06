Return-Path: <netdev+bounces-132518-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EB9991FB2
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 18:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98405281697
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 16:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D200189913;
	Sun,  6 Oct 2024 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdDtNwJw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3837013BAF1;
	Sun,  6 Oct 2024 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728233186; cv=none; b=gfQ+QOpUodgcGsbuHCkFIZKi2QBZ6cR+Oq+2+Mym6qGcwGRjK2zdq1yNa9U2xjmZhkMo2yKHNB8fjqobONKfEPNo9i9hy7NEPpBjHseNPUYoKVTIJOPLKAMX30fa36thAZ04wVsKuvdLbupc3MmDtN/xTLcUgsH0P9DNzT70T2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728233186; c=relaxed/simple;
	bh=idDuaJFxhvKUm/JPk8hcN5sN3CIqA0/zNhff5+G+Dbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFiN6dBwhIU2IUh6K1ZHxh2KSP3FeTZtFWukuA2hJWUdQ4l7e4HDVpF0ilvDooNVkybXvt9bfMAlfuVEIWafAqBedBImdNHNpDQaE2oXdIPYP/Ejw3963RcinxSq8jEkiuI10iTFSSCLdWnjTYCMS746vdE+NThsGO8fm6WFiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdDtNwJw; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71dfc1124cdso471721b3a.1;
        Sun, 06 Oct 2024 09:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728233184; x=1728837984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tFQsXFlFPeoxFKDhANXjQZ1y6bTyuC9Jy0Iq/wXyfKE=;
        b=fdDtNwJwY5HRRHJZQWYzfuqumUP+YzTyyBxAK+9og9QMtje6Lsnp/utmZcuhxVc2Ad
         kTkkEmMtqvNfEy3tEYfaiAyOEuGUByUlSbWH/1OpSogL0lPE/Zbo9lCD4rtcf/AeNBI9
         4bVAczYMVLvNJcoB0cTlBgEVwQP+crZhk4WBQgKDIu6thsGUooy5BruiQvSryi/j+kgA
         ENlOyW0mFQY3JK6Izc/E6qDUFVC007u5wX/sRGGDeSFL4YjWo9e3+/as7L2jKq92J3xz
         dozqwNndrQDJtAimXNnQtYTazBWOkcJi6b+HBmR4ACTIL64LwW3njJUGcJjK+Adf8vv7
         SRkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728233184; x=1728837984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tFQsXFlFPeoxFKDhANXjQZ1y6bTyuC9Jy0Iq/wXyfKE=;
        b=WiL9Ec637HKTTfiIUy4IoY1NsOuKuaFBZV3Ges+M08RLHKh7sxG4zIgV4NEI6kbpJH
         yKTDkTgmzFKs403r8dOkMoNQHJFymBDpCa6Bm+w/yRepee4kVrHg+Z4FDhcZiJ97Plef
         5xRPuIC2TprRDPXr1n/ZAj51cs6MkVs7Eop0X+NIbVFz7AgWFDU+heR/pRSMDa9PY9vd
         hpvL17BEur1qDgTqOpCXB2PPBgasla9YZSw9a0aaP9FtAnvuMZ5M68zg+x4oKppqTKTo
         T5gt0KE1KIrPs45yP6OI8RcgjAKJhwJu1639lO5Tj0F+eNcxYIoXNT4jaeF+fRUHFTGs
         CGug==
X-Forwarded-Encrypted: i=1; AJvYcCUcwOp0EuWI49PiDv95I2YFc9NgTaIDz0iMYv73vujUItUdSJWyX1QmxFz0dG8UC1hluR7L6xIsOR5A+L4=@vger.kernel.org, AJvYcCVCDTGymeZiuf2Qn67i8Gl8bn2vup2Gm9WNCo0TePGtpcBlO8cw+l8SkIhLXuaFfRKI2+KU+dBr@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb+uC1XPaJypCoNeVvvo+oyiaYErXKvybgYnJQp8DbpPHFVUdD
	3q1R62C4uxtKTPbhj+gZgvfcrcSP2VJ3p1kLFk5whCJDOe/DTwgu
X-Google-Smtp-Source: AGHT+IG/JHVArR6hcR5pQL33OYj5ExdQPlXvf9LyKYVmdjMnbc+lcGV3uJl4fqDpWek8zWYvs+qygw==
X-Received: by 2002:a05:6a00:17a7:b0:708:41c4:8849 with SMTP id d2e1a72fcca58-71de234fd22mr13942535b3a.9.1728233184543;
        Sun, 06 Oct 2024 09:46:24 -0700 (PDT)
Received: from ubuntu.. ([27.34.65.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71df0d7cf37sm2957497b3a.198.2024.10.06.09.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 09:46:24 -0700 (PDT)
From: Dipendra Khadka <kdipendra88@gmail.com>
To: sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	hkelam@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: Dipendra Khadka <kdipendra88@gmail.com>,
	maxime.chevallier@bootlin.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 5/6] octeontx2-pf: handle otx2_mbox_get_rsp errors in otx2_dmac_flt.c
Date: Sun,  6 Oct 2024 16:46:16 +0000
Message-ID: <20241006164617.2134-1-kdipendra88@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add error pointer checks after calling otx2_mbox_get_rsp().

Fixes: 79d2be385e9e ("octeontx2-pf: offload DMAC filters to CGX/RPM block")
Fixes: fa5e0ccb8f3a ("octeontx2-pf: Add support for exact match table.")
Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
---
 .../net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c   | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c
index 80d853b343f9..2046dd0da00d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_dmac_flt.c
@@ -28,6 +28,11 @@ static int otx2_dmacflt_do_add(struct otx2_nic *pf, const u8 *mac,
 	if (!err) {
 		rsp = (struct cgx_mac_addr_add_rsp *)
 			 otx2_mbox_get_rsp(&pf->mbox.mbox, 0, &req->hdr);
+		if (IS_ERR(rsp)) {
+			mutex_unlock(&pf->mbox.lock);
+			return PTR_ERR(rsp);
+		}
+
 		*dmac_index = rsp->index;
 	}

@@ -200,6 +205,10 @@ int otx2_dmacflt_update(struct otx2_nic *pf, u8 *mac, u32 bit_pos)

 	rsp = (struct cgx_mac_addr_update_rsp *)
 		otx2_mbox_get_rsp(&pf->mbox.mbox, 0, &req->hdr);
+	if (IS_ERR(rsp)) {
+		rc = PTR_ERR(rsp);
+		goto out;
+	}

 	pf->flow_cfg->bmap_to_dmacindex[bit_pos] = rsp->index;

--
2.43.0


