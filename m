Return-Path: <netdev+bounces-186589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F88BA9FD59
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 01:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07E681A87C71
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 23:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67432144DD;
	Mon, 28 Apr 2025 22:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ebozQUbQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EB9213E7E
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881185; cv=none; b=tpU6iMrJEURJgwNQxhyoN2dUoiXd2+wwaYJLXDr4d3dzKoZEC/5G4E/kiCGhSrFhlOh9u3nA/NvKSSYw+jXysD9v00aoVzexABTlWOnVm08GV2G5qygTQ3qtKR8yJbmNc0s6rhODamVddfubVHyWQLfYYqGS1Eqj9gH8tiEw6xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881185; c=relaxed/simple;
	bh=f4t4TKJlNpYkqk7ehL7tBnOY98/Qu6Z8p38RJIuv0S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UBGEgML6VoN37LHOoJFCESrecgv5le+motWcqKSJ114qykYf4B8Soon1bgtgcgQcSFnTHqzqqczq1kyZ6PClgKvAclB5ePI0NxwofPn98a8ndJ5dE7MEWa6/CQLEppwCGICeswcH1cU9FSyNuLwrzdiCBVGEDYCPFr094vVr1Co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ebozQUbQ; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7396f13b750so5952991b3a.1
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 15:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745881183; x=1746485983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iSWwfqmUXunE76n4urBHfhNwMzZjjmoFWMuTQWI0bTc=;
        b=ebozQUbQES2usX4OnNgHNCxGLKSnXXIV3m7E5yI5gAbjEZUcbePJiU7LWiuzXOyEG4
         UP4bCIpW6cZRPHy+2LQlJbf4VywwJh4KdGppm+UBAQoJyWSrixzWPodYy78blh/rv9+P
         D1C+oRvCQnFfgfTisSnLilmlR2paBHa4rLzvw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881183; x=1746485983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iSWwfqmUXunE76n4urBHfhNwMzZjjmoFWMuTQWI0bTc=;
        b=YliJER82p0PR/YecX3uvVY4HdB0+EHKufpzuY1Ce1+g78fWmPglogbwuvcGhGsAjB+
         ZoFq8C9AVbpJNyluupcDAeyZGXRePHcbsOTTRO29OH56Q9aqzkPgAH7hvyJzlZxHVMkz
         ft6LsDTURqq8xVqErI9rgIO9qDOEmMlkTLzbmssdy5vtw6cRWPkpXi5ZEMRzVhafHJWD
         kHWVKYSYlGUlYfBEKJcC33dwHc/nWDJBoxGsnUPps7Nx1Q/nrZp0mT9ogwQjb4UJEm98
         peZZcE9OEefgow+X8j87ZI0M1U/C5Lo/lq/8C4fbDug1cTHwjLtmGgTBpNUOevio62k5
         y5Jw==
X-Gm-Message-State: AOJu0YyQwB28CPIQ8Lsu23pSbqpEuFDfZlzWdMVSmskrNrbYFw+LWfUo
	8zeiPO7EtSNrmYIv0iZ+R+L8qYAG7GO0oj/3fPDbibnossDEBZULBRs/Yiv5LQ==
X-Gm-Gg: ASbGncvDMDEEiXW1kmZBDh/GKf5d7Sg1MkbEX2INpFuglc8MYk841q1vq3J2/usDVQq
	6P6RVJnfZdq9VAjCjmXpP/nUQd+EJxL4lGgFODXYnOVhSflhktTt2Aw4TewjW0tSzlJV3ZmbdRA
	vlHIiZyUq4ChFe2S9YcMLMWdsz3C647ANm/ZeTlsitKg5alTc8/tXKhXGCONFUH9KuXgNc+nML2
	rez9URb+5DdLQR9Ih2OS6D9SHxp5Ivow3+EPaJmu343zlM8Xcp0JOGJF0a/NWVjLTSxswTKr5FH
	8yyUvtOm3aGrEquVXI/i3mD9GAvoptKzLXjqAwoKk0WIwned2h4Rxlg7aR5lRPrwMzkjjQcIXc1
	86hMHYbzFArdH0A0L
X-Google-Smtp-Source: AGHT+IHowHADbrW3+jryVDOKkhOspEJcX5pv9I8rGMLLEE+5sX59ak95C0+tpoI6pBGsPRWYkVSrOw==
X-Received: by 2002:a05:6a00:2303:b0:72d:9cbc:730d with SMTP id d2e1a72fcca58-7402929fdc3mr1137310b3a.11.1745881183478;
        Mon, 28 Apr 2025 15:59:43 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca4e8sm8534344b3a.162.2025.04.28.15.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:59:43 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>
Subject: [PATCH net 4/8] bnxt_en: call pci_alloc_irq_vectors() after bnxt_reserve_rings()
Date: Mon, 28 Apr 2025 15:58:59 -0700
Message-ID: <20250428225903.1867675-5-michael.chan@broadcom.com>
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

From: Kashyap Desai <kashyap.desai@broadcom.com>

On some architectures (e.g. ARM), calling pci_alloc_irq_vectors()
will immediately cause the MSIX table to be written.  This will not
work if we haven't called bnxt_reserve_rings() to properly map
the MSIX table to the MSIX vectors reserved by FW.

Fix the FW error recovery path to delay the bnxt_init_int_mode() ->
pci_alloc_irq_vectors() call by removing it from bnxt_hwrm_if_change().
bnxt_request_irq() later in the code path will call it and by then the
MSIX table is properly mapped.

Fixes: 4343838ca5eb ("bnxt_en: Replace deprecated PCI MSIX APIs")
Suggested-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index cfc9ccab39bf..3b2ea36f25a2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -12399,13 +12399,8 @@ static int bnxt_hwrm_if_change(struct bnxt *bp, bool up)
 				set_bit(BNXT_STATE_ABORT_ERR, &bp->state);
 				return rc;
 			}
+			/* IRQ will be initialized later in bnxt_request_irq()*/
 			bnxt_clear_int_mode(bp);
-			rc = bnxt_init_int_mode(bp);
-			if (rc) {
-				clear_bit(BNXT_STATE_FW_RESET_DET, &bp->state);
-				netdev_err(bp->dev, "init int mode failed\n");
-				return rc;
-			}
 		}
 		rc = bnxt_cancel_reservations(bp, fw_reset);
 	}
-- 
2.30.1


