Return-Path: <netdev+bounces-235319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D515C2EAA2
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 01:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A1052349D70
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 00:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6031DC9B3;
	Tue,  4 Nov 2025 00:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cjvlN0VG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE40D1F63D9
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762217886; cv=none; b=dhxrPhtqagUzjvegGjM7rqJn70wttlEvQSvhQ8TZdAOL11s+bOv7NQ7t2IeoIj8UJ5O6gd0ZvBfACUXdS4sWPW0rLWMbDl2Q2GuKafyzn2LDHcNPjbgDOUbDGvm8DfuhOzq6JdamNFBrWCaNT4tY5oAevCKQqsfEkVcPdpL+BEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762217886; c=relaxed/simple;
	bh=TfQyCc6nTKujf7EMIuP54f9f9xe15WsOWZLHTqiFsM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqguQxyDB8CSRl0mwCGrddBm/6hBeUtGt33UFEpyZMqGOElnorqFhFD88Y0+CSqBeSwzc1/4UuW1gclYrjefUS1wGNTOI464IedROghZBhn4CeWiYEq4MNJIm0j4KzmOtjZeA3xGrCKAetqFDvE0o+w6+QSstRhL9HXzMWuujqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cjvlN0VG; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-87a092251eeso79931436d6.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762217884; x=1762822684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKYrTUNVMUUADj7pXRpiSFdYODz7DcE+sm+ktVDjvaY=;
        b=HVTnBv5RGttRg/yijOVxLbID8I1eR9C6UOCQueMNVP4hhukzQob46+TdxwwJkaBVyZ
         U4UTUV8SMaXfQRnhMHJdtM2gnQWS9yP3BTTt9IzVk4BDggjK3Y4B8vcDpNUwrupn42z8
         new8y3kCQo1G6bM6nRSbPrGc6MMadjGOyVAmrVCgm6W/oyxpqBUI2T6pepWeFu9QlsId
         L/BqhFlaQo0Q/n8FOP4LuEdBMrhfMaMjCQo9rbzbEX1Y+LtwsBaLU+kpb/KRscmG955E
         h9XzMn44dp9zrIZ9gWtVAWLE38Ju2/dB5nK9jvhIQF6/3IV8CWzqW9/VCavQVU8b+uvT
         9Jyg==
X-Gm-Message-State: AOJu0Yx4wHVrSSFU8EIz7kHyd0j4+Gpr1DopO0maVFst82OONg7uk362
	vb0EJzHZEUp+Psiq4XohirYC2R35ZDLeJyHMgGGZIVSC/v+i71FLDQz6q12bV4EWTP7HL/M4WwS
	jdamiZtjZzdZ61d27kmfsiczwpyap8miuhijoWYLy1dvxxhsoe0PFFnpSeoAYCIsk6hq/JGWTLO
	dT7/rhUJL98DvgND13fCr8uc6FGOA5u30SRHeuvUCswICrvwqSV21kk6o3NQjWZgUPWoz8gd1dp
	NBaWsQvrRQ=
X-Gm-Gg: ASbGncvpkcVDFxFuj3l4B3IAUMvBtrLgQ1KLGOS91byIHIJzI2zKA7Se4NQe9sswDTw
	q1bQW2RJ6TuHo2KJrA/S0hEDFSPyG/xXHHTIVx5pIOx5Y2i7pNYvxAtyyxtV8jKP5G9WAzAaTH6
	8mkYcC95p1KI78b121NsmLvTUUiGPGfQDJxKcigBO9tMT182Mt1kN2L72a36R/xPntjodyIEMsg
	1UGqqTyA8IUsYG96GuHjm8+A5oJwux4ezyv1kQoycM5Y1njB90aTgah+6Q+BPFbjNYC2KDksrIV
	sE9eg9vU9Hd7W7UiiPiXi22W9hGRMbYBHiEHuS6o0RsVaAIShmyQJ4fVO47ZfctUOrvy8Rdjx87
	lDKeS6R+Cg5TPCCVHsNSdPixs2B2pEHMhdQCEkfL1IBZDh9aZ12K2JywQB51+VWqMrs4eazJOkB
	m7WNfECCkfiDltr8aYhqRZJNiP1ndd/NjflA==
X-Google-Smtp-Source: AGHT+IFjMKIIfJrw/2qaLf9wv6IIaeO2EogZDMQCS64XHvs0mQJBT3kUhWfnJTg7YjzuK76RX4jOlJD0rfy7
X-Received: by 2002:a05:6214:1306:b0:880:519f:ceb4 with SMTP id 6a1803df08f44-880623121bbmr20408876d6.7.1762217883821;
        Mon, 03 Nov 2025 16:58:03 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-12.dlp.protect.broadcom.com. [144.49.247.12])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88060dd2e61sm1404886d6.13.2025.11.03.16.58.02
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 16:58:03 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-33dadf7c5c0so6122808a91.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762217874; x=1762822674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKYrTUNVMUUADj7pXRpiSFdYODz7DcE+sm+ktVDjvaY=;
        b=cjvlN0VGoB9XBuobnRShn6fwaUQIpYvNXTz/1YoM+plEgq1HHgkhQsn6zoS98Ja0Dg
         K6aS5luyYTo/2nxdRfa3IeWuSQTw5t0KLgJI2lBEKb4ElJVHLNe3jjsdMvAcd4dDN81A
         pxlRCFtqc4rFVRe+C//i82DcfyPkQEYJ/9Q/Q=
X-Received: by 2002:a17:90b:2d8e:b0:32e:72bd:6d5a with SMTP id 98e67ed59e1d1-3417185c450mr1633180a91.1.1762217874682;
        Mon, 03 Nov 2025 16:57:54 -0800 (PST)
X-Received: by 2002:a17:90b:2d8e:b0:32e:72bd:6d5a with SMTP id 98e67ed59e1d1-3417185c450mr1633147a91.1.1762217874317;
        Mon, 03 Nov 2025 16:57:54 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14bbsm2474553a91.13.2025.11.03.16.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:57:53 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Shruti Parab <shruti.parab@broadcom.com>
Subject: [PATCH net 4/5] bnxt_en: Always provide max entry and entry size in coredump segments
Date: Mon,  3 Nov 2025 16:56:58 -0800
Message-ID: <20251104005700.542174-5-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20251104005700.542174-1-michael.chan@broadcom.com>
References: <20251104005700.542174-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kashyap Desai <kashyap.desai@broadcom.com>

While populating firmware host logging segments for the coredump, it is
possible for the FW command that flushes the segment to fail.  When that
happens, the existing code will not update the max entry and entry size
in the segment header and this causes software that decodes the coredump
to skip the segment.

The segment most likely has already collected some DMA data, so always
update these 2 segment fields in the header to allow the decoder to
decode any data in the segment.

Fixes: 3c2179e66355 ("bnxt_en: Add FW trace coredump segments to the coredump")
Reviewed-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
index 0181ab1f2dfd..ccb8b509662d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_coredump.c
@@ -333,13 +333,14 @@ static void bnxt_fill_drv_seg_record(struct bnxt *bp,
 	u32 offset = 0;
 	int rc = 0;
 
+	record->max_entries = cpu_to_le32(ctxm->max_entries);
+	record->entry_size = cpu_to_le32(ctxm->entry_size);
+
 	rc = bnxt_dbg_hwrm_log_buffer_flush(bp, type, 0, &offset);
 	if (rc)
 		return;
 
 	bnxt_bs_trace_check_wrap(bs_trace, offset);
-	record->max_entries = cpu_to_le32(ctxm->max_entries);
-	record->entry_size = cpu_to_le32(ctxm->entry_size);
 	record->offset = cpu_to_le32(bs_trace->last_offset);
 	record->wrapped = bs_trace->wrapped;
 }
-- 
2.51.0


