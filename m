Return-Path: <netdev+bounces-130989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B81A098C564
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EADB71C2505D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D98661CF282;
	Tue,  1 Oct 2024 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7LqlfRD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C661CEE83;
	Tue,  1 Oct 2024 18:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727807369; cv=none; b=lJ3ojoeIo5+fG2Sl81GtHMUUie3F2C7+Qy7OSHZUO6PSUlA8sR9Uz8NsgZbXMj1J/2nUvVbKjN0qDnBWFrOIBQzevFIUfrUniOyVwu7AiMLG8BXizPoX7vMfaBg4K3QpGBuUq4B6Zn6AMuQrfRFN/UYOxPckhhHFFDLJFJs8+9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727807369; c=relaxed/simple;
	bh=PDXYm2utKtz7LGkMNyUJjDXaEuT47anuaBNZiCi4TBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR4vJOIifdq+amfacMdaG3K36EkZzVO0HQoJ3lmOJLx2rIPnRhqqMVk61jzGaFoXwlOdJj/XxqUCOKlZJ+4WR7HPzx9KicNEBDkoNTTQpHKL254Eh9Kj8w7xLoxAOR4BpQP36P8ad7/xFzX+KrvB67aFP7jkFbRHB5ujeI3xIuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7LqlfRD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-656d8b346d2so3666841a12.2;
        Tue, 01 Oct 2024 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727807368; x=1728412168; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=usyRTJ1DkSrlbIlzl9LbRK9K4nsTBzuR3bUK5KmITFc=;
        b=O7LqlfRDWvrfSOwpgdEzKzwYIhl7nAtdT4a8AZFyCb+vwCPzIwTSey+afrYikEYPKL
         e+5K8iw3hqYMqRPacqlv45nxcpTjpX8nCaiQUV6/Gc8uBWzS/g9Guu4ytY1lGxv2fmDI
         WscHMhZiTnXzN8Q1YwvFJNmmSKfrMNWSFrm6o7sohX+gS5G334OStIqO0ez7xUR/oPuZ
         1+N4rnEX5BM+q0pbjJfoF+0jDJavrVPeuwxDNbzN5uu965RmpMLVorik5tXod2TGk5lB
         ca3XTfU0XvWhEx+iDG8ttTwODlaCrUW78q3NfsDPN6jdHd9Wf52AidKp4BF5C9yy6o6/
         SQhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727807368; x=1728412168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=usyRTJ1DkSrlbIlzl9LbRK9K4nsTBzuR3bUK5KmITFc=;
        b=chaHxOH0lskMsNBZljLUbgUAoDjjgZH+EQHYEYiokd2Yl/LkValwND5W0J9uwyGIau
         0XRT9GnlhfRCFOHob5/kDApQysrdHOrgX74ES0R+FwadpLpAU8QMPmSv7tc4VT4k8b1x
         k7eZTKEzr+6BFkMGK/P7W7Sx48KTZLIzVYTZrHLs68HnDklADUrg+IhX2uLIaXhRJO70
         RBoDk1CYGkFjQh90JKT1sam0DZwTMP91FEEO1yaXGBQ1yo/DSBhYxZt7yHSKtYe29iF6
         qNalsRQ3HHh+XHrYRx2qv/yrcaXWokv/SlfvDIvmvQL579JN0BmgffJ3mbQRONUkQUDd
         lTKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXwvdcaDtRNlSV2bJUaTwczlANAuybZY5K9cS/qySZcW1Fkwq02oWy0a1BJtu611xkN83jGF6wpmSc5h8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94+WxeAFQDltoqRz2vXTHIPozi2p4h9G6Wijx4d5eHRur93SC
	v+gc+0GWBc+sb69mFKdfBwxDncrnvqhFLySbR0EbkXLoKwRp9sQ5EDlrI2ti
X-Google-Smtp-Source: AGHT+IFRQTphqlr/cKwpbAzWDIa8N2PRYNDHgTopk5GDJ8INBQRI2kngXlLQsYvsj1k+fpZaggM3VQ==
X-Received: by 2002:a05:6a20:9f8a:b0:1cf:4d4e:532b with SMTP id adf61e73a8af0-1d5e2d9e65fmr903495637.43.1727807367753;
        Tue, 01 Oct 2024 11:29:27 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26529d56sm8649467b3a.170.2024.10.01.11.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 11:29:27 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	steve.glendinning@shawell.net
Subject: [PATCHv2 net-next 7/9] net: smsc911x: remove pointless NULL checks
Date: Tue,  1 Oct 2024 11:29:14 -0700
Message-ID: <20241001182916.122259-8-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241001182916.122259-1-rosenp@gmail.com>
References: <20241001182916.122259-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ioaddr can never be NULL. Probe aborts in such a case.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/net/ethernet/smsc/smsc911x.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/net/ethernet/smsc/smsc911x.c b/drivers/net/ethernet/smsc/smsc911x.c
index e757c5825620..c4c6480c0ffe 100644
--- a/drivers/net/ethernet/smsc/smsc911x.c
+++ b/drivers/net/ethernet/smsc/smsc911x.c
@@ -2110,11 +2110,6 @@ static int smsc911x_init(struct net_device *dev)
 	spin_lock_init(&pdata->dev_lock);
 	spin_lock_init(&pdata->mac_lock);
 
-	if (pdata->ioaddr == NULL) {
-		SMSC_WARN(pdata, probe, "pdata->ioaddr: 0x00000000");
-		return -ENODEV;
-	}
-
 	/*
 	 * poll the READY bit in PMT_CTRL. Any other access to the device is
 	 * forbidden while this bit isn't set. Try for 100ms
@@ -2339,11 +2334,6 @@ static int smsc911x_drv_probe(struct platform_device *pdev)
 	if (retval)
 		return retval;
 
-	if (pdata->ioaddr == NULL) {
-		SMSC_WARN(pdata, probe, "Error smsc911x base address invalid");
-		return -ENOMEM;
-	}
-
 	retval = smsc911x_probe_config(&pdata->config, &pdev->dev);
 	if (retval && config) {
 		/* copy config parameters across to pdata */
-- 
2.46.2


