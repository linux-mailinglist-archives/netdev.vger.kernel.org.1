Return-Path: <netdev+bounces-186459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3235A9F395
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 16:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DADD189FF07
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D98266EE8;
	Mon, 28 Apr 2025 14:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afurVaKN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9860F2AD04;
	Mon, 28 Apr 2025 14:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745851075; cv=none; b=aGjLxhWvotHRqTzV3w0iacfmS8rBhkNUahOAsF3SnqKmS49QBJ9Tv84uOHi+FZCwxnTr9WiZUKl+R5OClr1z8ExduDBSmgkQ7IIfawCYWVtfwBLJWy/dx/x7fwaepdUNvfVfwB0r+jnlQDYL8AKuqKhO51IICj5aTC+XpQU98II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745851075; c=relaxed/simple;
	bh=qhiJHmvq/h1O3rSh0hFmw9xUAqGBAw76cWWrdYXMcVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iWCZhk573spI88rhFHcR2UbVWJgzUFX7NJhmTHm73hNfZcy+QsmUZ00AARhJgSaHfNSxBSWDcz05d7SKrtSBEF9J8nA2cp6hhirZGVlRWn/8TNvjJmcdVMrs6wcMFQ0XAYtqj4aBhXXGpcxwcdBKz9/gv9Rpia5xjr1YpgXviAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afurVaKN; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-39c14016868so4789457f8f.1;
        Mon, 28 Apr 2025 07:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745851072; x=1746455872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yPsbDhWZfsOKqBhPh+jFl4b8m8zfI36AQ589ehHefDk=;
        b=afurVaKNtq9k70pJaCUcwol1DDezgLB+nTzTkDfzod7YjqnDzSlfIIOFAbnygczRKT
         jR+xoQSYRN6j+pjMwL4x4srgHp9lxUn0n2jdtsxaaVR8FFvRF/dTVXXgSpkp+BA3yxBa
         PRP0bwxBB8xFpJ075J0Z02QnhIfLeuOe9vMJX9xmpXoWXxsOsGzeSyxIt1UJ7Z1ENqBG
         pgo9FwdkICl0evLWODxuOODboo8lbllgz9qYdJZDxZkDVdyLIP4vcZh8RQi3dVX5PXau
         KDlIw1pDWOZa4/7jsq0ckNY0nalbMEZpZEe85qgr2BDIVaqV3W0zdBYNF8XHZiJIIJyE
         szZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745851072; x=1746455872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yPsbDhWZfsOKqBhPh+jFl4b8m8zfI36AQ589ehHefDk=;
        b=MCkR1uSzjjFRqOOYGYASmC9MySc+1oNTOo9S3fE/wvUYXIUDoECQu4sELEmgYqvh2a
         s5xy80ThhP3Hyra1V/H6c5RDq0UthXHAqZoUM+GWsXX+jWJ1uPtS6M1+nHtYGryix05E
         BczoT8BhEIRfVyCSBo6KPQWkiBJFTSuQcQXIkXNhaaodDmG+xT4XESMJwNDArpr+21T1
         yfTxi2mhlhI9DKjSIGVa2j4x10QKeQlPCVrm9ynTkYf5DGVHerDprA5MRTUPzQaXyCBk
         dysE5KY+S65Kfm4TovO1W6adZRlV1q3ZWbNzJdrKtgyaGaJHnVk7I3ZKxxHTtUpmbki8
         ie9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVFb/CSv/mQQ9pRDj8/To9pCFHBjorKtQ9kQWVFo5IWNwyPYJWLrO0gynv6v3xf1BFmX/LTsQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl8ogi89qwy1aj6eQ/BzXcYc+6wDB2bBJpDVVkfmX9b2xYMHWc
	4ZhzlgbxonafqlFBqRQGM5ARUP6DQLYfWdL3b16YrIiqs9oFqFHQ
X-Gm-Gg: ASbGncsrn7s4yyWiwTD3SQuGebbvQ5BoY1nP7CQqti3akvuNsoqWr3QodzbINE9IFJy
	NmL2oIrSb/6XfriSv44twB+ReaFC4ymJkDufu62WIrzoEwNr10HB6iDrypFY++Fko4jFUGCDP2K
	YzmFt1BvpTynKbDp0M0fWw2q/ERGh52odZTteXaT/CZjmSgd2NB4kr8rF+dHFcD4D0SXnlp5JWu
	mjP2/44Jm0xBDbkeVNVdJ1OqPvPeLIC+XnFZoX60ZGfKegp88qS/lnQnQ9C4tqSBf4mrOjYL1ut
	IiZVvKNkT0U8RiYmECPm2acCU9aAEmPGvNWk2dfpSdjNnUQ7B9xjusOl5U1DcRyc6gi4HIkpPD5
	GAR43SIsaWIc3
X-Google-Smtp-Source: AGHT+IFfntNktdRd8CwwMBeEQhy7wRP4s5cqglUULBxqzShP6dIfvoAMRL0fKgGew7yHEFPB4KebuA==
X-Received: by 2002:a5d:50c8:0:b0:39e:f89b:85e2 with SMTP id ffacd0b85a97d-3a0891abd99mr44703f8f.26.1745851071598;
        Mon, 28 Apr 2025 07:37:51 -0700 (PDT)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073cbdb78sm11128465f8f.41.2025.04.28.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 07:37:51 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sagi Maimon <sagi.maimon@adtran.com>
Subject: [PATCH v1] ptp: ocp: Fix NULL dereference in Adva board SMA sysfs operations
Date: Mon, 28 Apr 2025 17:37:48 +0300
Message-ID: <20250428143748.23729-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sagi Maimon <sagi.maimon@adtran.com>

On Adva boards, SMA sysfs store/get operations can call
__handle_signal_outputs() or __handle_signal_inputs() while the `irig`
and `dcf` pointers are uninitialized, leading to a NULL pointer
dereference in __handle_signal() and causing a kernel crash. Add
Adva-specific callbacks ptp_ocp_sma_adva_set_outputs() and
ptp_ocp_sma_adva_set_inputs() to the ptp_ocp driver, and include NULL
checks for `irig` and `dcf` to prevent crashes.

Fixes: ef61f5528fca ("ptp: ocp: add Adva timecard support")
Signed-off-by: Sagi Maimon <sagi.maimon@adtran.com>
---
 drivers/ptp/ptp_ocp.c | 62 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index faf6e027f89a..3eaa2005b3b2 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -2578,12 +2578,70 @@ static const struct ocp_sma_op ocp_fb_sma_op = {
 	.set_output	= ptp_ocp_sma_fb_set_output,
 };
 
+static int
+ptp_ocp_sma_adva_set_output(struct ptp_ocp *bp, int sma_nr, u32 val)
+{
+	u32 reg, mask, shift;
+	unsigned long flags;
+	u32 __iomem *gpio;
+
+	gpio = sma_nr > 2 ? &bp->sma_map1->gpio2 : &bp->sma_map2->gpio2;
+	shift = sma_nr & 1 ? 0 : 16;
+
+	mask = 0xffff << (16 - shift);
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	reg = ioread32(gpio);
+	reg = (reg & mask) | (val << shift);
+
+	if (bp->irig_out)
+		ptp_ocp_irig_out(bp, reg & 0x00100010);
+	if (bp->dcf_out)
+		ptp_ocp_dcf_out(bp, reg & 0x00200020);
+
+	iowrite32(reg, gpio);
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	return 0;
+}
+
+static int
+ptp_ocp_sma_adva_set_inputs(struct ptp_ocp *bp, int sma_nr, u32 val)
+{
+	u32 reg, mask, shift;
+	unsigned long flags;
+	u32 __iomem *gpio;
+
+	gpio = sma_nr > 2 ? &bp->sma_map2->gpio1 : &bp->sma_map1->gpio1;
+	shift = sma_nr & 1 ? 0 : 16;
+
+	mask = 0xffff << (16 - shift);
+
+	spin_lock_irqsave(&bp->lock, flags);
+
+	reg = ioread32(gpio);
+	reg = (reg & mask) | (val << shift);
+
+	if (bp->irig_in)
+		ptp_ocp_irig_in(bp, reg & 0x00100010);
+	if (bp->dcf_in)
+		ptp_ocp_dcf_in(bp, reg & 0x00200020);
+
+	iowrite32(reg, gpio);
+
+	spin_unlock_irqrestore(&bp->lock, flags);
+
+	return 0;
+}
+
 static const struct ocp_sma_op ocp_adva_sma_op = {
 	.tbl		= { ptp_ocp_adva_sma_in, ptp_ocp_adva_sma_out },
 	.init		= ptp_ocp_sma_fb_init,
 	.get		= ptp_ocp_sma_fb_get,
-	.set_inputs	= ptp_ocp_sma_fb_set_inputs,
-	.set_output	= ptp_ocp_sma_fb_set_output,
+	.set_inputs	= ptp_ocp_sma_adva_set_inputs,
+	.set_output	= ptp_ocp_sma_adva_set_output,
 };
 
 static int
-- 
2.47.0


