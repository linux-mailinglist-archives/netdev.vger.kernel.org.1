Return-Path: <netdev+bounces-109061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AFD926BF1
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13E4AB21978
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0114D194A61;
	Wed,  3 Jul 2024 22:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="fb8EMmPb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FE0194A54
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047025; cv=none; b=NSDDiBSqkJOgV3vrD9kcsLuzvPeEDdPt+Rv0y5vangiFaK1N/DH3jBce7xsdsUKO7z4PMrZO5AEJPkPLOlipGF0qcsvyYA1T1e7n1FYT3xGryP5c2eRZ8QLQT8/enUuB0CIywHmzVrFcY9S6+e8Cn2JbL+nDcgZJP6a0BKvw8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047025; c=relaxed/simple;
	bh=Z1edd+LljZkJgJp6YW2lR15kGEgaERpfIlOgVunUs0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hU1aThhM14JN1I7YtBrZPodMuxwtEuw2mSZX71GfGY9iKO7x0T9o+fEvCYVk70t9NfpQOK5QSpt2UIN4SOaL3gD5teOl32YQXp2hl4XYpYronUGEUz4IIBM7+7qL9KTRDk0huTYAMLl2eH8pPWtCRzLi1+hhBpOFz0ZtqbDbdcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=fb8EMmPb; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb0d7e4ee9so12322105ad.3
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720047024; x=1720651824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+4t3ndr+pFBvnapLOjw8+L3ToUWBxuomlkfDw+qPrq4=;
        b=fb8EMmPb/HC66m7qm7HoE3Nhqq2+dEIEJ5vvoKaIjjxC+dGi63KUHnO+Xg/U+vRQZc
         twdRav8jucJBPeSgREyBm+o/yaOlAEV/D4mxyDsLyYabjEYOzccq/3vmzlx647BKXGc7
         PlMuHrTiZ7sQIZv8Nqo21eMkh0PedO2J6tFKCQ+4SaEf0wrLatJsYH0i6dFwTWqWQbE0
         1n/mbGx6t4A7KTWW5XF5PTjstjUcweZiOakGEd2gxZhCWAPs6AHK9pxiVN5iZSFWOmF4
         pezmioODV4wJM0A/XrK8KE/yF2s8IKKdzmyHCldBT9cF8Dv0tmRf0NCDbAaNLghfq9Ne
         pMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047024; x=1720651824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+4t3ndr+pFBvnapLOjw8+L3ToUWBxuomlkfDw+qPrq4=;
        b=BiiwmnbdLAZSoH05fM2cjzXsAwRnLhZq3tkeD3uoYU2tP9r1HLszUJSiJ973jiB1q2
         ApbBMmMd5iumZGcHq8nn+xYwuonGmUBj04Cdn4SM9Y5Y7R0eF4nu2wGkN9KSsm+6365y
         1Et8iKNvKv+vOi9yWJIC+AXM3jKPUvidJk5y9kbE/5IrwmPtmr8tUkH5rZMqt62XD+07
         1oM91Cik9GBLSrxDvZsI7aDJfeBW6dE2Q0TBISE6LpWpvQEOiK0kzas7Wj3mgqTbN8yX
         lNiuCHffxI/CN0m4zIgMnzC2SR3RYbczgbphNWTZ3fqQ5eSzjH2OxTqrn2xSq6QbJe9X
         8PnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIa67KFERvNT/8gjg6hQIkog5wwpgBMQoRovKzEL3yXBWoNOa7354zfq+DQMvkZ+2FJv8Q95xpn4fWOiGUkztk+UmixvH6
X-Gm-Message-State: AOJu0Yw6ULG1qllij5iF9OQrqEHOInYXHE4UFijKqeEwv+BKbRQRGiGV
	xeg+0FhGtvblDTYfA2kdig1KzY51ce+O7yeW4MKzj7cYUx75RNRA50S7bpJ+Ag==
X-Google-Smtp-Source: AGHT+IHTwp+HIAJSYEPZvRxk8HsKBhCj5fqJEV/VWzeWBtx5I08EDKLYMmY1PJtG+2MiOg3WEUojPQ==
X-Received: by 2002:a17:902:c945:b0:1fb:29e1:7635 with SMTP id d9443c01a7336-1fb33e053a4mr82525ad.13.1720047023849;
        Wed, 03 Jul 2024 15:50:23 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:af8e:aa48:5140:2b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf75b3407sm40242185ad.85.2024.07.03.15.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:50:23 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [RFC net-next 04/10] fcoe: Call skb_csum_crc32_unnecessary
Date: Wed,  3 Jul 2024 15:48:44 -0700
Message-Id: <20240703224850.1226697-5-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703224850.1226697-1-tom@herbertland.com>
References: <20240703224850.1226697-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of checking for CHECKSUM_UNNECESSARY, call
skb_csum_crc32_unnecessary to see if the FCOE CRC has been
validated. If it is, then call skb_reset_csum_crc32_unnecessary
to clear the flag

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/scsi/fcoe/fcoe.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe.c b/drivers/scsi/fcoe/fcoe.c
index f1429f270170..9444bf973234 100644
--- a/drivers/scsi/fcoe/fcoe.c
+++ b/drivers/scsi/fcoe/fcoe.c
@@ -1612,10 +1612,12 @@ static inline int fcoe_filter_frames(struct fc_lport *lport,
 	 * it's solicited data, in which case, the FCP layer would
 	 * check it during the copy.
 	 */
-	if (lport->crc_offload && skb->ip_summed == CHECKSUM_UNNECESSARY)
+	if (lport->crc_offload && skb_csum_crc32_unnecessary(skb)) {
 		fr_flags(fp) &= ~FCPHF_CRC_UNCHECKED;
-	else
+		skb_reset_csum_crc32_unnecessary(skb);
+	} else {
 		fr_flags(fp) |= FCPHF_CRC_UNCHECKED;
+	}
 
 	fh = fc_frame_header_get(fp);
 	if (fh->fh_r_ctl == FC_RCTL_DD_SOL_DATA && fh->fh_type == FC_TYPE_FCP)
-- 
2.34.1


