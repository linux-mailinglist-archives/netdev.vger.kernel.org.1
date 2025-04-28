Return-Path: <netdev+bounces-186592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F141A9FD5C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E49035A77F9
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8F8214A80;
	Mon, 28 Apr 2025 22:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AC/559cd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6992135C7
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881189; cv=none; b=mvUvY0LNdw503LSBRGGL1adUAWrEqZ4ZY2+IluOeqeBieVGHLeaEcGMUXnZEEuRT5L1TRR0jEhZvhkHu3zcnBOUtZzrHNpkSRqfj+BhnBwoGT+nCaxkfSVqZZUGyVnQLpPf6XisysV4OC1ZE4265EB6/vbTHEXhQuXzlRkJ7EV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881189; c=relaxed/simple;
	bh=7O70ijGT7BXdVM75nVfgPXf4sAs/ME/kMPlDnMTe+1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=InRb+tGC9VCSlPyTWar583Acn4suX11Z6jUy2r1zW5FDvvje9kTcIA4T3g7eeUWOPsv7JHzKXmK5mhlA5QaGm+Oy0vi2Z4LW5LOm1WZJoePfG5vo7VFiBcLJhy7T6oGigsVJLrzz5U3Bt97XOmLpLNkX11SiTVbPwbdnkvvQU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AC/559cd; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-73c17c770a7so7238442b3a.2
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 15:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745881187; x=1746485987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/TxMvEtNNouQHU5pMFa+5eVuSdgdhsbs/PBCKbOKVw=;
        b=AC/559cdZb/BElx/OTB7OE3YFg+Obo1GXZf08XuBJ2uCja6bnC7hWg7w96z9FckfvP
         9n0njxCzcRmHC6nmmibvCAT4+OviXngs/GWhabRWcwxGx9BQmwy974BV96pO2xyVK2G5
         mNPoxO/n1clTKPn6iR9T+s9gRoZEAAUeQMLKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881187; x=1746485987;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/TxMvEtNNouQHU5pMFa+5eVuSdgdhsbs/PBCKbOKVw=;
        b=Xev6gXS757dQsVnutuIBuI5PH8+i8f/Ex39uOuzXq0YP9J9x6tXQWLt7nep5Ow2sKN
         52TSNu1jvp7Rzq+gMCVfidiNWqR1A/MUFKP2nPEItPAvVqRtxuupPl+Y00T6kul+fCFq
         /GTSk6u+qcNocfiIZM51qUaRKFT+cFCIhfaoP7br7c80fu1b3dZAV74RPCe0Qh/h0Toy
         LJ7yyBcZ/FsdBGgOkLG1E9clwqfslDyquT7PjFSdqhWqziO10oiM/CXcmxYoc/vmRaav
         wCrehBye7XPF0073bVuceI0JZyWHVdB4uJCaDotA5P2m2iOKucOGu+KAJq5vppp5NZ2e
         NODA==
X-Gm-Message-State: AOJu0YwGjIJdDRrovG4nlwyjjMUHdTcpc7SaeUdNh8itgSs4XDgMjrk8
	m1wkWG1KX9ZIKu+cQkPN2nNjHsemKu7MB/XBhYZBZygspvTFOT4d1FMjgRywtQ==
X-Gm-Gg: ASbGncswvkE8DsJdYkGuEW9i/pGY2lfvjiBSIkPQAhjbXKQAskEJwkulVhDPxSUdOgZ
	vy8No2GluOCos59ya6Olj2+jaXZGig0jNgv54/QtUNR1hKo6cQGg/OV2MKtc6ZAws1d3ChZay50
	oQ+xSIFeEh82/x58ZtpxkCkJX/jjzmDHH1Dfx6AdCnYF1uJkGqCuX4TslUmd8S/3YhIjK0ncR/7
	XxzaxeaMucw6Bd18ey+ewP/pzcqF17slXQmTPvcLHeZNfo78G24usKgwCSDL1PGytb8ZXqPA/+u
	CAJMOuBHrJU8PPqdVHha4MtnFOq1BoA4W4FeMZ5mz42AWdFXqcKl2PyJqFvsgFTNkdSQ/lb62Qs
	SWc1fFyG2zcZkzxiN
X-Google-Smtp-Source: AGHT+IGfkl1VsEHG4xYFNA8fyVS5P23eR2fkFr5O94gfIDZOV3/Zvvn6M87KoREm44l+yvw5rLunxg==
X-Received: by 2002:a05:6a20:3954:b0:1f5:9024:324f with SMTP id adf61e73a8af0-2093e120fbamr1592842637.31.1745881187446;
        Mon, 28 Apr 2025 15:59:47 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca4e8sm8534344b3a.162.2025.04.28.15.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:59:46 -0700 (PDT)
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
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 7/8] bnxt_en: Fix out-of-bound memcpy() during ethtool -w
Date: Mon, 28 Apr 2025 15:59:02 -0700
Message-ID: <20250428225903.1867675-8-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250428225903.1867675-1-michael.chan@broadcom.com>
References: <20250428225903.1867675-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shruti Parab <shruti.parab@broadcom.com>

When retrieving the FW coredump using ethtool, it can sometimes cause
memory corruption:

BUG: KFENCE: memory corruption in __bnxt_get_coredump+0x3ef/0x670 [bnxt_en]
Corrupted memory at 0x000000008f0f30e8 [ ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ! ] (in kfence-#45):
__bnxt_get_coredump+0x3ef/0x670 [bnxt_en]
ethtool_get_dump_data+0xdc/0x1a0
__dev_ethtool+0xa1e/0x1af0
dev_ethtool+0xa8/0x170
dev_ioctl+0x1b5/0x580
sock_do_ioctl+0xab/0xf0
sock_ioctl+0x1ce/0x2e0
__x64_sys_ioctl+0x87/0xc0
do_syscall_64+0x5c/0xf0
entry_SYSCALL_64_after_hwframe+0x78/0x80

...

This happens when copying the coredump segment list in
bnxt_hwrm_dbg_dma_data() with the HWRM_DBG_COREDUMP_LIST FW command.
The info->dest_buf buffer is allocated based on the number of coredump
segments returned by the FW.  The segment list is then DMA'ed by
the FW and the length of the DMA is returned by FW.  The driver then
copies this DMA'ed segment list to info->dest_buf.

In some cases, this DMA length may exceed the info->dest_buf length
and cause the above BUG condition.  Fix it by capping the copy
length to not exceed the length of info->dest_buf.  The extra
DMA data contains no useful information.

This code path is shared for the HWRM_DBG_COREDUMP_LIST and the
HWRM_DBG_COREDUMP_RETRIEVE FW commands.  The buffering is different
for these 2 FW commands.  To simplify the logic, we need to move
the line to adjust the buffer length for HWRM_DBG_COREDUMP_RETRIEVE
up, so that the new check to cap the copy length will work for both
commands.

Fixes: c74751f4c392 ("bnxt_en: Return error if FW returns more data than dump length")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 .../net/ethernet/broadcom/bnxt/bnxt_coredump.c    | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 9a74793648f6..a000d3f630bd 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -110,10 +110,19 @@ static int bnxt_hwrm_dbg_dma_data(struct bnxt *bp, void *msg,
 			}
 		}
 
+		if (cmn_req->req_type ==
+				cpu_to_le16(HWRM_DBG_COREDUMP_RETRIEVE))
+			info->dest_buf_size += len;
+
 		if (info->dest_buf) {
 			if ((info->seg_start + off + len) <=
 			    BNXT_COREDUMP_BUF_LEN(info->buf_len)) {
-				memcpy(info->dest_buf + off, dma_buf, len);
+				u16 copylen = min_t(u16, len,
+						    info->dest_buf_size - off);
+
+				memcpy(info->dest_buf + off, dma_buf, copylen);
+				if (copylen < len)
+					break;
 			} else {
 				rc = -ENOBUFS;
 				if (cmn_req->req_type ==
@@ -125,10 +134,6 @@ static int bnxt_hwrm_dbg_dma_data(struct bnxt *bp, void *msg,
 			}
 		}
 
-		if (cmn_req->req_type ==
-				cpu_to_le16(HWRM_DBG_COREDUMP_RETRIEVE))
-			info->dest_buf_size += len;
-
 		if (!(cmn_resp->flags & HWRM_DBG_CMN_FLAGS_MORE))
 			break;
 
-- 
2.30.1


