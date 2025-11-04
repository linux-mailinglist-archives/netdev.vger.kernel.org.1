Return-Path: <netdev+bounces-235316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD35FC2EAA9
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 01:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7EB3B934B
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 00:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC41F63D9;
	Tue,  4 Nov 2025 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HKMQ0p5D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f226.google.com (mail-qt1-f226.google.com [209.85.160.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62B21F5834
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 00:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762217877; cv=none; b=N1tzOfsHlzj62BBBACTV6/k69YaTbXMmJ2FP+1GCBidr8tz4Yp/wD6T0Qg1T9WMe6ZaAlXQfflQ0xvqHYa+b1h6pG8p7oOU8IeiXBdSDvgVwl1aP+swi+7M6pl3QmvWHcZZSDTx+v0ok9d/kqP/Omc2helDBmIEL7eKBoFeWB/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762217877; c=relaxed/simple;
	bh=T/cO0cxaJBZp3eVxlv2WP4kWwbIPYy7+Xw2B8o9Tlbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB2h8PwAt35Avfz8+RARWMNA5B/09PYse4Ms7avCFjpQ26Fx1hvMT1F6fmGOfYlFbG1+9cA8Ji1ilDDZXDukmp6ebM7MKPptkx8y+vabaZ97+SDMlWYrfvOIcXqxzNykbkrjZ4PC7sM8Ke/4eC2YuBcn6yiRfZ+DnzQPSw3E6Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HKMQ0p5D; arc=none smtp.client-ip=209.85.160.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f226.google.com with SMTP id d75a77b69052e-4ed59386345so6460231cf.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:57:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762217875; x=1762822675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNpaXLX3eC4XDe2FCjJu3+uDuKhdwnQfprNf1q0bud4=;
        b=bZ/RLTikofmKWRceGMIcqRUe9IQFHk40K5GA10IHXKR/eyXBRoxvWz0JdseEjGHmiP
         ExgJ63E+EULuIiBhuPKJjJLOgUrAuLeJR2PHyE/pWOKKP1PYnwHFqfvttjsbqkAhjq1t
         FqMlKSnfQ0Jf7biIV3PoFuL2I4imXsfRlFtPXb7PV3HZkU75ZRhAMch9B6nGwnMLxpQC
         LNIZ3Ov3AV0GBm62tIHIvcHiyct4Qyt+LiIedb/omS6Bc3nYhBtGhaf/LdeSH1NPsZzn
         zDHXl/v6eaqGpv1kDrgsvYw+8tR7bEqT+CNg2YtvLojFOrbCQ1pj+RdcDlUSSyv39jNv
         Rblw==
X-Gm-Message-State: AOJu0YyJab++3vOClxd8Uc8kaimOBg/KVWNexeYc8nAmKwll7zBf1PXX
	uoziwy97zQBIETi5gkYZM5HMZWUVi0hppddD4yix0FfKPgpAs/Yl26+DU3mcHCIVDTlhW+qlOWo
	O3HeHXBoyeroaHVoUIit4bjfBWlIkh0qH0KJ9oxjWkB23ANOrlK14yZUtg+n/e6dsLXIauo16lI
	kuRQDaaN8D6AdYb4fVGROIm6zVb1Sk9LXG7n5kqNKQF+xxR8z+FFaKkYYnDr4GhOqpj4n9VGQn4
	EMVWmGoVz8=
X-Gm-Gg: ASbGncuPTRXhqBnBOQQ4ozAu04efLvt6bgKqME1ToFeTU+IAxPd2GfXNtMP+inG6IV8
	CWbElJwkQZ+K7Bh9jeV2ldSErkM7alaLbHo2G38MNXPtEYdrNnSe3fLmLIoJ4T57oJu+RYT1rLl
	AGgsEEQZSfZ5/LR+bT7XbHZ2qZZuiJf4rFaoSezPfIjhMrIXDeIZmGg+DIfHtG7SrNXZDmYHnlW
	dK3w4dJo9liykQhLNiqsdcoXmGrMz61yLQIBXSs4liDzmJOGnF8MKbgv7OnlajoOEWiSyHH+MbZ
	6T6lEh5JQXfKR/mHaicKa9AqH/oC69Mt4M40GPWOLVu75AapVzBKwYcLgoQx0uoxwBFcMCBPktd
	ShrgfyvoCLzcR/FbGi8OvHBHKNcM8TuGk9qXTDSmoXRAlpfnL8LMHVPTAaxT65qCrI20AArtC1Y
	+txmXHNmt0J+7MeswiqWFZOquJyDGBp7X4dA==
X-Google-Smtp-Source: AGHT+IHsvcsrqdgI9TItuQ9PdTaey1oiKeNy/CFfoowIOIZ4k0zqiIU+hTYuew+eJmxtrnmrlC+QocBSjJAb
X-Received: by 2002:a05:622a:4a19:b0:4eb:a3fb:2864 with SMTP id d75a77b69052e-4ed31077a68mr191920871cf.69.1762217874435;
        Mon, 03 Nov 2025 16:57:54 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-14.dlp.protect.broadcom.com. [144.49.247.14])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88060e6d66asm1475766d6.33.2025.11.03.16.57.53
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Nov 2025 16:57:54 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33da1f30fdfso12907461a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 16:57:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762217873; x=1762822673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qNpaXLX3eC4XDe2FCjJu3+uDuKhdwnQfprNf1q0bud4=;
        b=HKMQ0p5D+B5SKDZIWqeYZbmVOCANRu9E86y3yIIQ3lGbkkgsV+QTzOU9xA8l9Sllg1
         9lQslwJe0tjNpFUad1w7E+rs8VDdkjZ7nF/C7cf1dcWrOfjWSp8hKpL0cYdLAtz2onmc
         j35ycGWwbcVVl4u7XQusqTKOH8AGkRe6M7hxI=
X-Received: by 2002:a17:90b:55c4:b0:341:315:f4ec with SMTP id 98e67ed59e1d1-3410315f670mr8780620a91.7.1762217872840;
        Mon, 03 Nov 2025 16:57:52 -0800 (PST)
X-Received: by 2002:a17:90b:55c4:b0:341:315:f4ec with SMTP id 98e67ed59e1d1-3410315f670mr8780598a91.7.1762217872471;
        Mon, 03 Nov 2025 16:57:52 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599f14bbsm2474553a91.13.2025.11.03.16.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 16:57:51 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Gautam R A <gautam-r.a@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Shruti Parab <shruti.parab@broadcom.com>
Subject: [PATCH net 3/5] bnxt_en: Fix null pointer dereference in bnxt_bs_trace_check_wrap()
Date: Mon,  3 Nov 2025 16:56:57 -0800
Message-ID: <20251104005700.542174-4-michael.chan@broadcom.com>
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

From: Gautam R A <gautam-r.a@broadcom.com>

With older FW, we may get the ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER
for FW trace data type that has not been initialized.  This will result
in a crash in bnxt_bs_trace_type_wrap().  Add a guard to check for a
valid magic_byte pointer before proceeding.

Fixes: 84fcd9449fd7 ("bnxt_en: Manage the FW trace context memory")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Shruti Parab <shruti.parab@broadcom.com>
Signed-off-by: Gautam R A <gautam-r.a@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 741b2d854789..7df46a21dd18 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2149,7 +2149,7 @@ struct bnxt_bs_trace_info {
 static inline void bnxt_bs_trace_check_wrap(struct bnxt_bs_trace_info *bs_trace,
 					    u32 offset)
 {
-	if (!bs_trace->wrapped &&
+	if (!bs_trace->wrapped && bs_trace->magic_byte &&
 	    *bs_trace->magic_byte != BNXT_TRACE_BUF_MAGIC_BYTE)
 		bs_trace->wrapped = 1;
 	bs_trace->last_offset = offset;
-- 
2.51.0


