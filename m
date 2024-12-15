Return-Path: <netdev+bounces-152019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 100D99F2628
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 22:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2DB0188628D
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 21:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E831C548D;
	Sun, 15 Dec 2024 21:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Q+kz8pGu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426981991DD
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 21:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734296435; cv=none; b=Dp22uMo9BebF7J2fDcx8EeBWGP3GTtJW/OLZwgzjqov1hD74Jeh/xtnQ4lgQXCQtgyUpaCsWQNSNo9ltwDeNsxXsUg7ACa6tG/W3UfTtph1rIu/2n5gg7yxMVWKw3VtJja+Yqvfe18YVISkh9k0LmURkPEHJU1zne1VKzodT3Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734296435; c=relaxed/simple;
	bh=3CBZBlfh+56QfJJs99uRlQZjombPvTGum3x0MjVt7pY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0a1karKCp/xZTDWiKEqsGyXW2Da+wu12qh5NwRnfJN0710oX0797uMqCuzEs/PyKpXQDvz1pDmgo2tCVa+EioLipxQVR0lhIWymsFfowPQs7I1uIqTPvPuCMiFCbvHQ6G9b05x48fPN3cdoiTXRAROf6CbqTtrAH+Ha0cCOgTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Q+kz8pGu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7fd2ff40782so3051861a12.2
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 13:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1734296433; x=1734901233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P0XQDitWKVq4eNGE0XYTq4nsJajScvFqTYG5pnFykTI=;
        b=Q+kz8pGuv/3ULs1UCOZS0OUWLXGxgHDNF0viwaXUDI+G2o4ibiistIAUTa60qKxaam
         oDEV7n0dG1kcGmVcxIhol1DTkRackejLtJfknyfzcgD8a7eLPo8W3KC4Gj957EPKUw80
         IP/4NNj5iSSM4v4qP25hULEoBhDQRbZWd0z3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734296433; x=1734901233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P0XQDitWKVq4eNGE0XYTq4nsJajScvFqTYG5pnFykTI=;
        b=OEC+dyQZjkJ9bdw7hNfx3kBtljN4pLdI/WWi43Kwy2uYG8Ud/APzpfIpWS+eVTa0V8
         YMBypJduM18l8ry7tMeV3ZQiE2KYXnFGyUKkMgQ0qN4o3BqZotlV+hKijNsT3fSY8dXh
         q5Rw2deZ+nZhrR32vJ6J22uKsGgfTdaXEgZreBI8uRO/Rs+d35rhuO85BYKwz5mYkLWb
         wNytLIOWQS1q24/ZdT8dv+wM/7ojjDz7zfIMTqXDR8jgFvpMCpj54RGyWX3bGU8QWy2Q
         W+jy23DtGxAe0RDrwORV3XXkPmsb9A4BL3MDDBPHEvoWSK1iYE+vHuqT/e5X96d48RYr
         tGhg==
X-Gm-Message-State: AOJu0Yyy6kBkzgqrjWNXeqHPClqmYIdA0bqEmikHDdpM0SaEYd4gQ/Rb
	LoT+eSR2fzOe9Dm0o2ScfrKandH3/L27vyZACHUDW61VIMDVcbF2PXQnWgGnO79+0NuPDOlt3Ew
	=
X-Gm-Gg: ASbGncsVFGK85GCAhw9kGnIeKmnx6Wpx2jQr7Do04wPMkmvs9pcTpxW4s8Ph5uq72Lk
	pcEHwQ+2RdugRftADe4UxF9IgDcOgHkETQJgQJ0Dn1oOuxlwSmzqmq13J56TUxF7DkCEMuSYesn
	/GF4QJtSfwOhWYKeg3Q/Ypj2NjBz1yPi20qBXUnNgITqsaeAHUpbH+Gv3jIG65oQrk909fHtVEZ
	b+21ybfcOXJ/IaUsCtM9O3Ql5JHdU74fbTbym9h/QknegrJbfoT4dazBJqW/xqBlkHxi0XpYfAr
	qYpES+eh+mlRM6GGapVe9Ke54Gvaf7EF
X-Google-Smtp-Source: AGHT+IG+frHYYaCsgN3JwArBgAN3KkRVTrDzzLt0/d2kze6ZjRhYQ6+2ApllcPw65dULG3tYKIKi3A==
X-Received: by 2002:a17:902:d50c:b0:215:b74c:d7ad with SMTP id d9443c01a7336-21892ab8264mr160964315ad.36.1734296433460;
        Sun, 15 Dec 2024 13:00:33 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142fc308csm6682717a91.50.2024.12.15.13.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Dec 2024 13:00:33 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next 6/6] MAINTAINERS: bnxt_en: Add Pavan Chebbi as co-maintainer
Date: Sun, 15 Dec 2024 12:59:43 -0800
Message-ID: <20241215205943.2341612-7-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241215205943.2341612-1-michael.chan@broadcom.com>
References: <20241215205943.2341612-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6cced90772fc..2c73a3aacafb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4611,6 +4611,7 @@ F:	drivers/net/ethernet/broadcom/bnx2x/
 
 BROADCOM BNXT_EN 50 GIGABIT ETHERNET DRIVER
 M:	Michael Chan <michael.chan@broadcom.com>
+M:	Pavan Chebbi <pavan.chebbi@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/firmware/broadcom/tee_bnxt_fw.c
-- 
2.30.1


