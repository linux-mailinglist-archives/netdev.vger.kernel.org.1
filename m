Return-Path: <netdev+bounces-222902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF39DB56EAA
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 05:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 365547ADEF7
	for <lists+netdev@lfdr.de>; Mon, 15 Sep 2025 03:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C422248A5;
	Mon, 15 Sep 2025 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="iRYD5eV4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f100.google.com (mail-io1-f100.google.com [209.85.166.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FF322127E
	for <netdev@vger.kernel.org>; Mon, 15 Sep 2025 03:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757905554; cv=none; b=VzPlp+/IQ353XHLBd8Fv+6tpiNrrD2PX9I31zIfBuDaEuJjjj3fh7ZN3wicNZV2iXRtLvjxWeBp88wRTr12UZlK5dzT/tAnMkK7qoPcbVsyaFsVmmybBkG3BepjDo+vi1EtenNXU/Ecu3g6olgwGIDj2G8Y89cLaKxxlJMsjUds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757905554; c=relaxed/simple;
	bh=EpcWq4Se+vvHPb355umfhYJACcTX5HSoNUbvkp1CtOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mMTRD5cDhXf/zHNcfD3RMEaLnVNhCmIGv9EKb86GgPolXcgzkfb8mMR1HSmmyO69lkudMmxYf/t+wp/U9vtnIaaKn2IIvDf0lic9f55jGtsAj80XyXLMag2yFYabPaQ1W3DDcDKT8jasiFBF+i1ItND42xSPqHld4ZqtUMMM5gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=iRYD5eV4; arc=none smtp.client-ip=209.85.166.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f100.google.com with SMTP id ca18e2360f4ac-88c347db574so118443839f.0
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757905552; x=1758510352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJr5DlvkvhNZDA0jVrL4jcJECp4mTtvZjTpPa0iAxz0=;
        b=XTeHgDW1l0VoiL8EQS/yh99TIYsRkWPcra3FZWKdKGg29cIAMFMLFexE7pephyEOzj
         hy2DWdNnslxk+qV92wbjvoIiU6AQU5x78FS/LKSTjEno5sZLe9mEJoEaNT0Hf7JMONy0
         9ncn9//fiUxHT+HEIC0AemWr9FOC7L+xNw+PrKh7BahIGPe3sJM3Vi/nQoIFYkifHTE0
         qdf47sVcx1a+Gbt55dniprDJvwSgZZ2kUjzp1Fl9iGmH5c7OhZ146CngzyT8l+OnaEBs
         TnHb4Enk/kPBNzQMx8bOqOmJJGcDNFUAzHjiiwsRqn3tkndNt/t5OFYNI9zUoedKSOx+
         kAAQ==
X-Gm-Message-State: AOJu0YwidQx2WW9PyjdNdVYaNsd1dcOWzoeHv7mUYlYmYQQjwIotqcLZ
	7tHShqq5HUB5wnk1aUhKDobSTEVhH8WhXmGZmyiKmv1NqYCZpl8WcLNSy4JGt+hhk0AXnJbCzqt
	fBNDX7i+d9EUsALA3lfAWVK+EdYC0yr4mumWvFgQdIC3icY/fdxhQkf6LHcPxd++dk2zsplLL+T
	Si4mbMrsWKJ9wpT9gUkfdUW9kYTl0SjFQGcDTMl++QFLyR9CdnoLPjGiUjqRFtixwGiAwGbKBxb
	yo0h5LsZDY=
X-Gm-Gg: ASbGnctrt8oruQClsNx3dPY+LBYX8agcXtGsE6xELz7CR9vvu7GcXytaxctjc5GX6QR
	Qc1w76UB4eQyFqZ4WEOvLVBIcXVloawEWHgrbam2MUZzswrGUNQzABNY5GVs1iDMoql8vQ2TZy3
	QbAKAlQVh2XqdQZAZ1jgX7Vh6VYn6AzMib0DjSTGELk3qaD3Y9/CcZ7ffNnyef1cpdqqiww3Fqw
	1hjck7cbjUDT8VjqAgm/ssAQsYwI+6gWSA+TOQkENbQHP1f00AupbqazfcVi4eFweWOCqDQU4q4
	8QiyzLHMBolPjBu8XyP+MOzQbpvoca+ldI8kz103MDCwnp4Qzwof/LqtUfoWI1t+M4Pf+GJcpQ0
	Zx6wZt3aNy7paeFAQcdLSmg0Sq38QnzW7lpuTF6WjH0KCGfBJ9Kutek9sbkmdnsDc6FIrQHpn69
	2n5w==
X-Google-Smtp-Source: AGHT+IHw6mRPLybXBFeAqKFrwvPrWv3O3gcWOvq8iFneZOUXK4yZeFQxnO+pwDP3MgqZiq8V+5bsbS7FRldg
X-Received: by 2002:a05:6e02:2782:b0:418:3fac:71a2 with SMTP id e9e14a558f8ab-420a568c79amr119490055ab.29.1757905552345;
        Sun, 14 Sep 2025 20:05:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 8926c6da1cb9f-5121136311csm502807173.23.2025.09.14.20.05.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Sep 2025 20:05:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-25bdf8126ceso68881535ad.3
        for <netdev@vger.kernel.org>; Sun, 14 Sep 2025 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1757905550; x=1758510350; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJr5DlvkvhNZDA0jVrL4jcJECp4mTtvZjTpPa0iAxz0=;
        b=iRYD5eV433PXoIz/bt0XrCrkWP6Vfzl06kT/P1Vc/us3tSq586mLd2dFLhkf+t0Rmg
         Xx0qqoycRH946nSg+yRNdxiLsdnHY7QJ91h1h7hMdS0H8CWCXOsHUB7b6boSxcudSiir
         w23gHKhPfoaZKPiwYxsGNSscLjVLKiyz1ZbmQ=
X-Received: by 2002:a17:902:f612:b0:264:7a22:d06e with SMTP id d9443c01a7336-2647a22d36dmr52518825ad.1.1757905550332;
        Sun, 14 Sep 2025 20:05:50 -0700 (PDT)
X-Received: by 2002:a17:902:f612:b0:264:7a22:d06e with SMTP id d9443c01a7336-2647a22d36dmr52518505ad.1.1757905549884;
        Sun, 14 Sep 2025 20:05:49 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3b0219f9sm112723575ad.123.2025.09.14.20.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 20:05:49 -0700 (PDT)
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
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net-next 02/11] bnxt_en: Remove unnecessary VF check in bnxt_hwrm_nvm_req()
Date: Sun, 14 Sep 2025 20:04:56 -0700
Message-ID: <20250915030505.1803478-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.45.4
In-Reply-To: <20250915030505.1803478-1-michael.chan@broadcom.com>
References: <20250915030505.1803478-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

The driver registers the supported configuration parameters with the
devlink stack only on the PF using devlink_params_register().
Hence there is no need for a VF check inside bnxt_hwrm_nvm_req().

Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index d0f5507e85aa..02961d93ed35 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -1074,16 +1074,9 @@ static int __bnxt_hwrm_nvm_req(struct bnxt *bp,
 static int bnxt_hwrm_nvm_req(struct bnxt *bp, u32 param_id, void *msg,
 			     union devlink_param_value *val)
 {
-	struct hwrm_nvm_get_variable_input *req = msg;
 	const struct bnxt_dl_nvm_param *nvm_param;
 	int i;
 
-	/* Get/Set NVM CFG parameter is supported only on PFs */
-	if (BNXT_VF(bp)) {
-		hwrm_req_drop(bp, req);
-		return -EPERM;
-	}
-
 	for (i = 0; i < ARRAY_SIZE(nvm_params); i++) {
 		nvm_param = &nvm_params[i];
 		if (nvm_param->id == param_id)
-- 
2.51.0


