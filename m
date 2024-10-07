Return-Path: <netdev+bounces-132852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 765DD993868
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 22:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25C531F22CA0
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 20:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BA61DE4E9;
	Mon,  7 Oct 2024 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5bGq9Ak"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C5381D31A0;
	Mon,  7 Oct 2024 20:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728333568; cv=none; b=PKWnaxsKgZo3UdjsHFHIPS9vx1iGtnOoA8qLtoyyHI6cUaZ4iEPld53CNjk0KuzGnLzbWeQW+/lO/YFgMtRC746ToLLPA2zLZyqDai4fOfvRebSg0mS+sK9bmP9ftwgCC7/zrmZceQ7q2+hFowOcOrjH+J7rLWOzMDbRlG8NoPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728333568; c=relaxed/simple;
	bh=5TT17y3RjAcT06/ywoplkLucZ8ruotI+ZhLh6wB2mxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tnAVs/ujODqoIZCRdsgu42s65nHqkigJ7LtfJfCIVLLM8Ki2XYPbIT5oSC0bkIVrqS80WJ2urnGuhsMsz9qVXTPy0sZrYRA7Kac8K+YwdqZfqUe4GV84dygjWlqBcX7bDO0bmTC8uvGELUiSRo65FQ4QcVkHX9nqYN9FhObnNaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5bGq9Ak; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e0c7eaf159so3786939a91.1;
        Mon, 07 Oct 2024 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728333566; x=1728938366; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J+WTgadYP/jr9gAydYiukIu6hRrw9XfPtLwLH3kbWpw=;
        b=m5bGq9AkI1mAfo/jI+0w6fyS2M+oWQj0DiToNzbzqDqNetqOyad6vW+JEoCAz1el3W
         HcvmKk8uui2HMY2RLGLZ33RqKoQruAgD3f54dFYzPooiySCI5axaYRDVky6wbL7TNUja
         lDHoIC72yHYMwvzHXOewVd4gCJHeOHnfzg+NElygsvY7sxkyyB03Imh3g6g2RIpeAE84
         cQetsiZAQZkOrRKBskpb+8y/h5+aWb9mXjiw0w8daslAhWzmPuoeMj6KBgLWjSwxFjW0
         lynAlr/qhg7b0yGZxfvkHIoAPUFEZrWFBLSY4Rap3TG5Bh5uxbJlsCX6jnSQYytnXlGK
         YI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728333566; x=1728938366;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J+WTgadYP/jr9gAydYiukIu6hRrw9XfPtLwLH3kbWpw=;
        b=CGHgCOIlsjs2hBwOe+gDCFx7qh3rg0VJUpfc1u3ZF3s+jMR/tQpDt10cjDzIVbj9fO
         iPlg4iBhZQqf3vP5IykNSSzNjLUPM0mCvfO2kVHNriDRREDqZ/vSwxO1fLTQc/hmazQw
         pvsFKJlYbLwWdNiELHu38s/HCEWH/i4IAEv563qemHkWaNxWLRDn2jPs1gQL1Wce/Sar
         RfYTWfDQG2ACqtmr/k9FFGcZiSAyKiCMI89FfEJPEyTVPIUxtcnG8IPrfRpzbpYeclsX
         XgFTAsRz0DAHp95FVDXMY97pw4ovrGc3Jb/FRoO8XVGR9dYnhXCTOm58qVBY6a1kBnYe
         k/NQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/wyXbD9tVIsbie/rpUuh2sVtEgBb91cmcy6KHd/7t74RuszPZOhUKplp6Su6d3nMIp0TbyGCayO8C+5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWsknHn+XgbS/8ndlTvk3eKXTgNLt/bVYQb4JoNkrqSXG3YMnM
	tFrrwqHhVvqF8KS2R7ekCirruQbHkZFokWKAMdvZIlU7meVh7a0wK2kSIw==
X-Google-Smtp-Source: AGHT+IEdPceQvCoPhguVFHp2GuqFzM7wgm3in8NUX6mhioQSetBuRqjEeqW+AKeJo3i1U9aRmSPpLw==
X-Received: by 2002:a17:90a:fd87:b0:2da:6812:c1bd with SMTP id 98e67ed59e1d1-2e1e621f1e7mr14095494a91.15.1728333566480;
        Mon, 07 Oct 2024 13:39:26 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e281aee517sm84544a91.0.2024.10.07.13.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 13:39:26 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	jacob.e.keller@intel.com,
	horms@kernel.org,
	sd@queasysnail.net,
	chunkeey@gmail.com
Subject: [PATCH net] net: ibm: emac: mal: add dcr_unmap to _remove
Date: Mon,  7 Oct 2024 13:39:23 -0700
Message-ID: <20241007203923.15544-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's done in probe so it should be done in remove.

Fixes: 1ff0fcfcb1a6 ("ibm_newemac: Fix new MAL feature handling")

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/mal.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ibm/emac/mal.c b/drivers/net/ethernet/ibm/emac/mal.c
index 1e1860ddc363..b1a32070f03a 100644
--- a/drivers/net/ethernet/ibm/emac/mal.c
+++ b/drivers/net/ethernet/ibm/emac/mal.c
@@ -715,6 +715,8 @@ static void mal_remove(struct platform_device *ofdev)
 
 	free_netdev(mal->dummy_dev);
 
+	dcr_unmap(mal->dcr_host, 0x100);
+
 	dma_free_coherent(&ofdev->dev,
 			  sizeof(struct mal_descriptor) *
 				  (NUM_TX_BUFF * mal->num_tx_chans +
-- 
2.46.2


