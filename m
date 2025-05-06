Return-Path: <netdev+bounces-188389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCD9AACA44
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 17:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BF153B26E9
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 15:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85405281523;
	Tue,  6 May 2025 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPRZjDP8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D874FA32
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 15:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547183; cv=none; b=X0UH0OJOEmwNT3zIKR4EYzbr3Tj3SJaaoDsyjepS2rLmvkyB35MbiMqrpbCldfstuJcVWPCdNwccEclvkQTmDxGsr8LC1qBe+xaPgD61gB1pEp8gb1IFCP78fvTp1t1fRBld+418ZtpXUIBSqyjmlCPzrHtH4poH6JdNFGzs0Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547183; c=relaxed/simple;
	bh=fwbC1Jz+jSLU1VuXZs+McQi8dguggClRoTB4+clflWY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=agGSJp+IqWkMaPOTKlGkLWOd3giKhVy94D/qjRD1+i8olL+XqzBoOaxjk7VhQjvwue9w/ENLLwRO6S8onT0iasVrkROuX9NUDnFqcXXDQkhOj3Iy4f1PUB83ZfWxo9156nJWapSLWqlTGVWAfb+Iz5J92ofTa3ACkmh9euB6D1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPRZjDP8; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e033a3a07so62313645ad.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 08:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746547181; x=1747151981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3vhDxncPNnkBpBQstt4bHHRORrShHGdW9wcdY1tC7ss=;
        b=hPRZjDP8p/klN3jAv6GgZBRx8vkAG9m1Pvv6P1xjQnm9mOXOou3FAImbZHrY1ebNZQ
         uEoJ1yU5ombd65Jb6FrGIQzLMyT/RtFZkhFbYqM0hfZ7JgIgd6W+97WKpHDOjJ/eKM65
         3V4n5b/dz1PPQX4EENmzOcatJ3nIsYxIKSqKgrcd1YAow0WMrGGgmHR4xU5geKtV7e9p
         QOPrSycigcQs6iHMTNFN8uWmatPeHSEwkr7mqUppBAE0LRYvKSDz/RpKnMWJOoY79a5A
         T1yv3hkEFifs8QF2YjDQcP8xHWqPIDadpda/biGGngRJD3xxIoH6KTvQOhcOqlViqZ3p
         Sthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746547181; x=1747151981;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3vhDxncPNnkBpBQstt4bHHRORrShHGdW9wcdY1tC7ss=;
        b=FjxANVwxYN5UxcSKj6rKNO8avsY+F/qTgJiXXQbvs3pc6EU7+syX+/kdA5oGo0CiQr
         Ch9cagBIW19emOp2QQNpmiV0IkAMw6xL4Guk6/mnlW2zIpfHPwJEs9y1Izital2vbrNM
         LyD3qGvPJ/M8FTPsL3r4Ngayz0me70G143GZcVJXg8g8cid7+rDHEGQaZFXNa0AbrLrj
         eln/BwKIwN75wuX9MOE67E9/6X62f7wFzVQ+IVjuAye+vlGMJPolOeSwmZWDHP9Urjl5
         Yvhq72mMbpoLA8LLfnM0fTqZwIvTfh7s/iyKrmxSYcqTEMC48Lh7z0AsiPkzFf4O2LG8
         +HKg==
X-Gm-Message-State: AOJu0Yz0eSTVOoWYSqx9HfYdNo55WixUXE/2q9cNtIIvl+P/Fnilp7vo
	XljjQ744sChjdVuN8HBeohfVPqjJfrXXo9WNEM6499zsH+F5tWUo
X-Gm-Gg: ASbGncuBPLwPPWa+YUEVGwlA99KARTQHsFoAZOjS/Y62JgXZnWvUYRi1NQyKENTpcgm
	Z4nsD7ude3u2G+LasL/7Jtjq392VrMxqV6T14/HAhQDGHsDPUDDH7HLcBerzrEcMbe+7Ny01MGe
	ShVyPKtPDYUVJO96d4XgXXW/cT9kIaXDxf4V8QbtsUMxGAM0tAJqbb5oAiMzcT2hfsX0nccujXv
	jek0kXLD9m1HY3aDbaF+yG6VbX0wfNxYnA84kjW53sNC4u4jHZo72e2EX2gyUI41FooylFC1vw4
	UtRBrnfOYGiVhjl2Yk+MQd+yPy2j6lCXO0WymUw1fTjB+QvTP/CqR5475bOn1cncVKIWuOZwh+Y
	=
X-Google-Smtp-Source: AGHT+IHL82SC8REOtj+tz96wNVS8jz5kECjWvUtwk6kZTcBlcwOIVek+eAn/Jtv3fklDpgfznYztNg==
X-Received: by 2002:a17:902:f381:b0:22e:566f:bca7 with SMTP id d9443c01a7336-22e566fbeaemr10372295ad.17.1746547181032;
        Tue, 06 May 2025 08:59:41 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e15232648sm75315465ad.258.2025.05.06.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 08:59:40 -0700 (PDT)
Subject: [net PATCH v2 1/8] fbnic: Fix initialization of mailbox descriptor
 rings
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Date: Tue, 06 May 2025 08:59:39 -0700
Message-ID: 
 <174654717972.499179.8083789731819297034.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <174654659243.499179.11194817277075480209.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Address to issues with the FW mailbox descriptor initialization.

We need to reverse the order of accesses when we invalidate an entry versus
writing an entry. When writing an entry we write upper and then lower as
the lower 32b contain the valid bit that makes the entire address valid.
However for invalidation we should write it in the reverse order so that
the upper is marked invalid before we update it.

Without this change we may see FW attempt to access pages with the upper
32b of the address set to 0 which will likely result in DMAR faults due to
write access failures on mailbox shutdown.

Fixes: da3cde08209e ("eth: fbnic: Add FW communication mechanism")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c |   32 ++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 88db3dacb940..c4956f0a741e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -17,11 +17,29 @@ static void __fbnic_mbx_wr_desc(struct fbnic_dev *fbd, int mbx_idx,
 {
 	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
 
+	/* Write the upper 32b and then the lower 32b. Doing this the
+	 * FW can then read lower, upper, lower to verify that the state
+	 * of the descriptor wasn't changed mid-transaction.
+	 */
 	fw_wr32(fbd, desc_offset + 1, upper_32_bits(desc));
 	fw_wrfl(fbd);
 	fw_wr32(fbd, desc_offset, lower_32_bits(desc));
 }
 
+static void __fbnic_mbx_invalidate_desc(struct fbnic_dev *fbd, int mbx_idx,
+					int desc_idx, u32 desc)
+{
+	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
+
+	/* For initialization we write the lower 32b of the descriptor first.
+	 * This way we can set the state to mark it invalid before we clear the
+	 * upper 32b.
+	 */
+	fw_wr32(fbd, desc_offset, desc);
+	fw_wrfl(fbd);
+	fw_wr32(fbd, desc_offset + 1, 0);
+}
+
 static u64 __fbnic_mbx_rd_desc(struct fbnic_dev *fbd, int mbx_idx, int desc_idx)
 {
 	u32 desc_offset = FBNIC_IPC_MBX(mbx_idx, desc_idx);
@@ -41,21 +59,17 @@ static void fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 	 * solid stop for the firmware to hit when it is done looping
 	 * through the ring.
 	 */
-	__fbnic_mbx_wr_desc(fbd, mbx_idx, 0, 0);
-
-	fw_wrfl(fbd);
+	__fbnic_mbx_invalidate_desc(fbd, mbx_idx, 0, 0);
 
 	/* We then fill the rest of the ring starting at the end and moving
 	 * back toward descriptor 0 with skip descriptors that have no
 	 * length nor address, and tell the firmware that they can skip
 	 * them and just move past them to the one we initialized to 0.
 	 */
-	for (desc_idx = FBNIC_IPC_MBX_DESC_LEN; --desc_idx;) {
-		__fbnic_mbx_wr_desc(fbd, mbx_idx, desc_idx,
-				    FBNIC_IPC_MBX_DESC_FW_CMPL |
-				    FBNIC_IPC_MBX_DESC_HOST_CMPL);
-		fw_wrfl(fbd);
-	}
+	for (desc_idx = FBNIC_IPC_MBX_DESC_LEN; --desc_idx;)
+		__fbnic_mbx_invalidate_desc(fbd, mbx_idx, desc_idx,
+					    FBNIC_IPC_MBX_DESC_FW_CMPL |
+					    FBNIC_IPC_MBX_DESC_HOST_CMPL);
 }
 
 void fbnic_mbx_init(struct fbnic_dev *fbd)



