Return-Path: <netdev+bounces-127775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6878797667B
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101261F21DAA
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A321A3A87;
	Thu, 12 Sep 2024 10:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="xNsm4s59"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52961A3047
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 10:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726135717; cv=none; b=MeSxoJJqJvta2z7lwPZJ/0PXQDWuXvWTZkZNOnVvdgd7S/aVMhl0b67lfDapucJPOCwGRx0AoKkaPIpmZ9e4eQ+goWrGbWBC3YTDCo4fuiGrgGSXsi4aS4TK96FbmIoqblwZVPUr3vS7gpMPAv4g8M8vQZzOhou0HrqspihqoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726135717; c=relaxed/simple;
	bh=5OCb+7uKyLbZrs1Mj/coxUQ/9iBoUAlSrVa6LuBsIZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LswWZQ1QNNU/V3aA84eXXmge/GrTa7/zY+6V2tOSNdac9Mx+31M8CHQe5bada4iatH9zN2bOX/2sZR3fILYDg9AozWHVJHgyw+fI3EsAMjaKMG8zId8nHZ4Gn5+2aK5gWtIZLbedQJ9ORox0bQ767qA9/Fh9FRXGBkeOtZg/Lf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=xNsm4s59; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2054e22ce3fso8558005ad.2
        for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 03:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726135715; x=1726740515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5vZGBy03W9oJlJ/9i6GWdkzO4slhCr2TSdIbx3y7tGw=;
        b=xNsm4s5992Mg0YPU/I3voTMDELYF9IitwiYLBnMLFUfGYUNvbCT27GE+6oH0lsA6of
         4SV58yYVZ92XxAyu10iv/ahaWlJwkjoj1Sb0G+nLFs3slnA1YG/2izfsqcTD++W7lGVB
         bLf9mfjWljRkv46sCaMZU8jq3IWMbl0aZRM6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726135715; x=1726740515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5vZGBy03W9oJlJ/9i6GWdkzO4slhCr2TSdIbx3y7tGw=;
        b=LmSs8wVCAO4iOZ7w66MdX/C3lQd5nr18nQBMdD3pjizpCYKFiPA/bA0YjuWqeTtSuQ
         1XNfXX24ADu1HEzSFuhqYZOUNqLTrkS8xuyHqDZ18dCma+HXmo6FWoBgjp6zxbv3XMWk
         Xv/B2lN5b/MON/RUWRlCH0DOqSn/FmHKeStOVN5ydzHLm9tLSkBJjCn5+4kYNrOfXrkQ
         qslxK+CjgQ+htAObNogUC4g466KAXaHjPDUoqaLOl3/qbvbzp+xnFp1WU+H1s7JXFabR
         qhwEXzTqK71oozpP3h5LhJrmtwgbFKuKZizk6ZvVXMeZ8T0Gv240vJEaZ29gUMChsYLz
         4/Fg==
X-Gm-Message-State: AOJu0Yzg+4mctr8GBLPAEI12DCOMinh8nKFQMWooU4OfuljPE5vaPJfd
	QgXyNlMcXeti9pV+FnBi/1emojUwnNzEjIcfr9nwy5FViS6xJVySDk1rsPMfqYQU04465Q//2Fo
	db5sQhr3EeG4Jw6E4SGiO6oFGBAxTG1N6KxLYcuGukqoLc1vQ3QlWsYQHBtg/CV//cWwJGj1nJ4
	LsjNsI4xuJu8mXAYXgrcN/ip+Bw1cePSJMJNeqjw==
X-Google-Smtp-Source: AGHT+IGLql27bdRi5FlHr3ibf1RMiPqxAUiDsI9pQMEbvnCn7/LufTMCuEPbZL7jU6f3P6G3MlmXDw==
X-Received: by 2002:a17:902:f684:b0:207:1828:82fd with SMTP id d9443c01a7336-2076e37abf5mr30678565ad.28.1726135714688;
        Thu, 12 Sep 2024 03:08:34 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076afe9da3sm11583795ad.239.2024.09.12.03.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 03:08:34 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: netdev@vger.kernel.org
Cc: mkarsten@uwaterloo.ca,
	kuba@kernel.org,
	skhawaja@google.com,
	sdf@fomichev.me,
	bjorn@rivosinc.com,
	amritha.nambiar@intel.com,
	sridhar.samudrala@intel.com,
	Joe Damato <jdamato@fastly.com>,
	Michael Chan <michael.chan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC net-next v3 7/9] bnxt: Add support for napi storage
Date: Thu, 12 Sep 2024 10:07:15 +0000
Message-Id: <20240912100738.16567-8-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240912100738.16567-1-jdamato@fastly.com>
References: <20240912100738.16567-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use netif_napi_add_storage to assign per-NAPI storage when initializing
NAPIs.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 6e422e24750a..44fc38efff33 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -10986,7 +10986,8 @@ static void bnxt_init_napi(struct bnxt *bp)
 		cp_nr_rings--;
 	for (i = 0; i < cp_nr_rings; i++) {
 		bnapi = bp->bnapi[i];
-		netif_napi_add(bp->dev, &bnapi->napi, poll_fn);
+		netif_napi_add_storage(bp->dev, &bnapi->napi, poll_fn,
+				       bnapi->index);
 	}
 	if (BNXT_CHIP_TYPE_NITRO_A0(bp)) {
 		bnapi = bp->bnapi[cp_nr_rings];
-- 
2.25.1


