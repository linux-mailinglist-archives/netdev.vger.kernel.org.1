Return-Path: <netdev+bounces-233576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 04972C15B3E
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 17:12:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CECD54E8B29
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145DC342141;
	Tue, 28 Oct 2025 16:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b="NC1KV/ga"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F20341AAE
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 16:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761667746; cv=none; b=eEWb1LKHTOauxtBV7w97m/QIS5wFLrMKt7Ikl8OIMKIR4u53zNYFBZmtlP/wLYIlviL9UnK4ccfCRtQ16Jkkq6g48JGCEQZt9VPalcrp/slfWj3zMyyURCHTHQeJR9yWt1d1eHZZIW1R9FK9/PIW1OsfJWxe0Tq4PIxoOQFfTTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761667746; c=relaxed/simple;
	bh=uKru//0VQi4ASSMxc7mTC8Gha4EFBzhbzVqnz9jdgZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sHbHjmr9tyDrBdxkcxSDv5NEUMwQySB2UYP+3VbR7nQ67VRoDdNcfcXYvazqb2Z5kQu7nUQ2PpUivs752kHGEgmgP1Hi6/k+4KCiy3an6ScK1XPivEs0t9rpsNzVFW1toY3paKGd9lsp41hkPM8Vz8h8bpk8mcSImO9s4htlfkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in; spf=pass smtp.mailfrom=cse.iitm.ac.in; dkim=pass (2048-bit key) header.d=cse-iitm-ac-in.20230601.gappssmtp.com header.i=@cse-iitm-ac-in.20230601.gappssmtp.com header.b=NC1KV/ga; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.iitm.ac.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.iitm.ac.in
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-782e93932ffso4653540b3a.3
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 09:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cse-iitm-ac-in.20230601.gappssmtp.com; s=20230601; t=1761667742; x=1762272542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LW9OsLXnsz6ESKwP6hNF8dP8JhMECKTtQ8QnPSKrIms=;
        b=NC1KV/gao/Qk1W5ZLKJuGPeQXsVRZOo3KkED0xaunQ5jdB6XrbZMOXX8A98M55im4N
         2bdFcM7b9TmIesiuQjOrfPYFq3ungSAA/V/9zuj5nkmwCO34Qc9efvXKk4Kupr/eiKNv
         KEBY39gdgfDgyb1mXY/6wpdCDxgBsMgyzRSEKhY5FiikZOeOZcnlyAGIJ/n+xLKjR4+c
         8woS6LEWZ4y0futUDecu42SiMFY8zLWmUiqyjXBL62BktL+lCnnRX8EtQ4TVHlV/opBj
         9t22flZ7VfUdVHzRGryYRV9smCMrR78twTkEVqOK9cdaqBXu8yRWsXhi5dTmqdSotfhq
         dx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761667742; x=1762272542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LW9OsLXnsz6ESKwP6hNF8dP8JhMECKTtQ8QnPSKrIms=;
        b=eHGEBM0tqYmYi8b++x7C7+xm0mPmXUezwZB+bZZn9ZSUvCKaYOvRly0A0B+X+fMZ6/
         JTrtQbzzscdTdVlE6fDjvHRwirq+mY5hhu1gyklmR+RHS06a7OhNFuTyMWhxxz7epCMo
         cWA3TaKO0RCA8sTTpoF6CRCxsdnAA7qZe55sPBxGz69hNcNX8hPoPeANvhjLUqNXVr4u
         xf6HlCb6UjyiYsjHEyB+ZonStufGJDIEPL1pO9KLb1SywVsKncEpz7gJZgICdV2A2Qg7
         IUw5rmCnku6EVHmigO5/QeH3Ipnw+tCFlFXdhtGwkSa4tR5kleyekySCsmQhTlmhfzmB
         TQ0A==
X-Forwarded-Encrypted: i=1; AJvYcCVTBa11WIPZzsM7gmBRpBawzu36wxLY6XIaWnkq1DInSUb/de3t1VJLNkpKZDReIyRwBAuIXS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOHEqmwKB8Wku/9jhnav3a1NgeicKAuJ1lYzWytdKuEWHGN4AJ
	PWlNe1v7IgcTW0GB/HqxjXHcHrXLI/+OS++Ch/7ytywDlnONbZzagpFvSUmjsstt3uk=
X-Gm-Gg: ASbGncv/G5lRi8M/RfVhtEMLQByBsh4T7d3m0eUDs2TqjcSjhe6I9c8NIQA7yduEasX
	vcd1UveKrwemrmL+wtYsp/65rbBtWtiFJMuOkdYx7Gq+FcKd/J54PRMFHAlKzdwXqZ8mrQpGhvO
	70a2MSAWq4/fQscEHpYLGohTU/kXLbKG6f0QWXrJwyvS990npCqu/t4Y8ybPsf3JZ4Xu7xSLJrJ
	1oIjOHl0zJptYn2dFtp0jwKW68X/2NTmcyxmiY1H3bP3lLS6aQEPKjsjsP7GTyWPBSpG4QcpnvM
	7I3Grx4atl68EtIi+LmkuNVXYE2CDbFU0p3uTH/EdxLJ4YJPCCoyF8jOdtop1ktmmg5hqzCDp5y
	+dE3fpZaFshZV+ob7XXxjcp6qe1DcJyedirCAUXorPNIvNPJf3W5DgSBolL2X2R4+vr29Cps5Fw
	J55yJLIg9TnUAT
X-Google-Smtp-Source: AGHT+IGe3tFN1gphFBUjZXPd9OJZ1HjB7mWf55osHZpxQwESJNdZoVeXL2KpEYWRTA1tLGoUZmVqHw==
X-Received: by 2002:a05:6a00:1caa:b0:7a4:460e:f86a with SMTP id d2e1a72fcca58-7a4460efe29mr2876540b3a.25.1761667741436;
        Tue, 28 Oct 2025 09:09:01 -0700 (PDT)
Received: from localhost.localdomain ([49.37.217.46])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7a41402ec82sm12317675b3a.21.2025.10.28.09.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 09:09:00 -0700 (PDT)
From: Abdun Nihaal <nihaal@cse.iitm.ac.in>
To: kuba@kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	oss-drivers@corigine.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] nfp: xsk: fix memory leak in nfp_net_alloc()
Date: Tue, 28 Oct 2025 21:38:41 +0530
Message-ID: <20251028160845.126919-1-nihaal@cse.iitm.ac.in>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nfp_net_alloc(), the memory allocated for xsk_pools is not freed in
the subsequent error paths, leading to a memory leak. Fix that by
freeing it in the error path.

Fixes: 6402528b7a0b ("nfp: xsk: add AF_XDP zero-copy Rx and Tx support")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
---
Compile tested only. Found using static analysis.

v1->v2
- Used dedicated jump labels to free the xsk_pools 
  as suggested by Jakub Kicinski

Link to v1:
- https://patchwork.kernel.org/project/netdevbpf/patch/20251024152528.275533-1-nihaal@cse.iitm.ac.in/

 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 132626a3f9f7..9ef72f294117 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2557,14 +2557,16 @@ nfp_net_alloc(struct pci_dev *pdev, const struct nfp_dev_info *dev_info,
 	err = nfp_net_tlv_caps_parse(&nn->pdev->dev, nn->dp.ctrl_bar,
 				     &nn->tlv_caps);
 	if (err)
-		goto err_free_nn;
+		goto err_free_xsk_pools;
 
 	err = nfp_ccm_mbox_alloc(nn);
 	if (err)
-		goto err_free_nn;
+		goto err_free_xsk_pools;
 
 	return nn;
 
+err_free_xsk_pools:
+	kfree(nn->dp.xsk_pools);
 err_free_nn:
 	if (nn->dp.netdev)
 		free_netdev(nn->dp.netdev);
-- 
2.43.0


