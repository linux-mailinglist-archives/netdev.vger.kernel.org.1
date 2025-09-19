Return-Path: <netdev+bounces-224811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE578B8ACE1
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8559858521F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 17:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36D8A322C71;
	Fri, 19 Sep 2025 17:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DjYPDON/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C38322A2E
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 17:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304099; cv=none; b=t671yMu24fVl+LGgxes5c+MFnKjKc8v9KssrbhyU1rS/C35f3ACe2qbCvimsz0mHTZPViR96S5+0QS4JIcHC5LFXX1QhyQHli2Sn2EyWVBg1geFuWYRnUbC5Ppj1pAtDTUSjZ2m+MBA7HU/ALniGOJ/yrwMc6QF8STE/eoqidhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304099; c=relaxed/simple;
	bh=G1NiFDz8oZhTB5nWROQ4ml+rvTNq7sXuFIg0das2/hA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTM626nerVkq+HuxPC56DOIyWHwAhw2HQAdsWi0WNrh+fJG+gxlujzB/kz+gPVRq1qrHYwubb/UsjEUOQzenVOTF+bXds2ZgrAtclubea8OnL4ImFvqlQm9qDI38uB1sF4HO6AxLPAe+2ssDNg8EV8OGP3L3O13fdyb5+xUy6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=DjYPDON/; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-32b8919e7c7so2732778a91.2
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758304097; x=1758908897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=sL714jYmO4WQHYowI2PpywEf9WjbEpW7wYOl7jL4lcVkRlz69k5lyvBcmjbSj2Or67
         HcZ3vNz3Wm+AlJk/kMNU3ttr7xhpLYmIj3gsjH0+lhOLw4fZ2l8bjJfzM2FwWA0V43oI
         yb3RC89OjNpCyrvgBW3NUYjLLLFXnPbn9l4f91I1Gnlk7cnBwIFvV+RTBHy2IhBIIygw
         HNjC2qp6Kg44FVgdaDtdP3Y7WjjG9hihDBcudAv/6swi9WlM04w/Eqj46PDzPV5X+3Lu
         NgQ4tbb+0X8UXIFzGomS161DJQF9rLAAML3QmgGN5pBoVk6ttPpuDg8QqnfuQWP4wXBL
         XOOA==
X-Gm-Message-State: AOJu0YyB/khtc4uAp6DXKMq0wzgt7VLBEH0pBlfJdsnvK7xDFI9hLdIs
	UiI2Q82+b0sE9th+rERnCyJvJ+hEMZPA2ppdri1WQQhtMPVAUWyxuHF/QJZwiPzjJZM0C1UWY04
	uBWqDLDafKYz8HYZFCxyz8Yo1DP1daaTa/G0NWXJJHOLk3S1fOvVfU5qlCtQbbCPzW0C8Ji28We
	w173F/0nxcve/4oJhcfJLmNkvudbAc3RPCyvRevdkyMZX+EcJbw3iybTcGiBUFEiZpigYSc4ZhN
	k2UnT4IsAKW2/vCvud7
X-Gm-Gg: ASbGncsAIUv97rT+E/mvrjyEgPcprwvUqTwJQdrIttD03dv2NGhSlAqosEaMWhy9f+H
	5+8vJ3HW79QjGq1wPyseA/OOSyMH3ZWuu7qr+9KqbHQ+hgcIZl+NwuQfEX5QdMpJgu4T7c1h17Q
	pdMsA/6h3QuvtNjz4Yng4rukXpGg+Mv72mNASb7z7k7pt06VTO05+qGdhbUwqrDMI1b4jMbcdng
	2fxkTaxx+iI4rFq5yh7E3W1yQUhEJKlcbikIZzZJHkA1/ID3lMhjBOYC1dRQDs47CKLwrm30j7g
	wfpUgUGZR3TE30tXO4BUTftvUrfU6tFlaNlbtfhdugCR1TAMI4+Z01S38NzngBjm5ZzzAHNn2B5
	XH7d1KdqKfnFZ9qD/atizTPSSrE7C+cZiTCoruNbSj8JX3WTbCqk6j4lUm7X+eaql/Ip28q9Amj
	LvRnKUruXg
X-Google-Smtp-Source: AGHT+IF3z6vMY69yMl3Hj90dHz2OZOxMzFhunl0dWs/T7/lOpgazbVYsMmnZN0Q5kS11xSVV5KRRkUKbEBRt
X-Received: by 2002:a17:90b:5109:b0:32e:38b0:15f4 with SMTP id 98e67ed59e1d1-33097fdc40fmr4938265a91.7.1758304096912;
        Fri, 19 Sep 2025 10:48:16 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-330607e9aa0sm399309a91.8.2025.09.19.10.48.16
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 19 Sep 2025 10:48:16 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-25d21fddb85so42027935ad.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758304095; x=1758908895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IUECdZ3lR6R7TzQiSPdeZzqdUGndQHKhb6XoefEvstI=;
        b=DjYPDON/9WC3qYN/pMI9IbVrR1dgMMHtl5odkKYlVNesngznbmm4ha2nTiV3x3krEn
         CG+b7RgglE8CcqrJVmYt+QArt7wnEaJEmIvplM9YlVeUGW40ON94gR86JWF2BxxSF6uB
         HTMp+n4qDXATwhLSWMbkS/cyWHBY6mphYKzds=
X-Received: by 2002:a17:902:d511:b0:24c:ce43:e60b with SMTP id d9443c01a7336-269ba45c0a8mr65982335ad.18.1758304095000;
        Fri, 19 Sep 2025 10:48:15 -0700 (PDT)
X-Received: by 2002:a17:902:d511:b0:24c:ce43:e60b with SMTP id d9443c01a7336-269ba45c0a8mr65982075ad.18.1758304094681;
        Fri, 19 Sep 2025 10:48:14 -0700 (PDT)
Received: from hyd-csg-thor2-h1-server2.dhcp.broadcom.net ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b55138043b6sm3513119a12.26.2025.09.19.10.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 10:48:14 -0700 (PDT)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v8, net-next 01/10] bng_en: make bnge_alloc_ring() self-unwind on failure
Date: Fri, 19 Sep 2025 23:17:32 +0530
Message-ID: <20250919174742.24969-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
References: <20250919174742.24969-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Ensure bnge_alloc_ring() frees any intermediate allocations
when it fails. This enables later patches to rely on this
self-unwinding behavior.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/bnge_rmem.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
index 52ada65943a..98b4e9f55bc 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_rmem.c
@@ -95,7 +95,7 @@ int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
 						     &rmem->dma_arr[i],
 						     GFP_KERNEL);
 		if (!rmem->pg_arr[i])
-			return -ENOMEM;
+			goto err_free_ring;
 
 		if (rmem->ctx_mem)
 			bnge_init_ctx_mem(rmem->ctx_mem, rmem->pg_arr[i],
@@ -116,10 +116,13 @@ int bnge_alloc_ring(struct bnge_dev *bd, struct bnge_ring_mem_info *rmem)
 	if (rmem->vmem_size) {
 		*rmem->vmem = vzalloc(rmem->vmem_size);
 		if (!(*rmem->vmem))
-			return -ENOMEM;
+			goto err_free_ring;
 	}
-
 	return 0;
+
+err_free_ring:
+	bnge_free_ring(bd, rmem);
+	return -ENOMEM;
 }
 
 static int bnge_alloc_ctx_one_lvl(struct bnge_dev *bd,
-- 
2.47.3


