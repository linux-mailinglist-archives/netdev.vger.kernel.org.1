Return-Path: <netdev+bounces-186588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A71DA9FD57
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 00:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6E27AC25C
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 22:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0398214222;
	Mon, 28 Apr 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="R7HMM5sS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278AD2139D8
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745881184; cv=none; b=RLy61ejSWgZBFECBQ0tJ0w5OoLxexdQ5tN/xy9vQTpFfvu6IeyVsu+iz2LcYK5p9ZATxpEKtJsuH/TA3ickmNGX1nqbNjnQnRu1dv5QBl3d0R84OULL8n9rNcwLmNICHleoPdI0fKHuzHsVcls4DDwtECnfWRAEP8KxMPY0OQzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745881184; c=relaxed/simple;
	bh=5dHtQzp/HQzjYlCATRyTfX1wm3c/k8PWS+8xx38ghL4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5uPGoP4qgPQVbkX/5XmxMXYubbJ/sSAcivoiNNlTVl0SqLJ5abNF2ZL8k/ifJzBXULiRN1U4afrElPfVgHYwpTZhsqEGSuLNSGbzhBu1wMjmv3m2UTdrqQDQZcCcMM9WgH/McUgi637ZZbPLSRiRK9GX5xiV7pSmVfgO8TF3cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=R7HMM5sS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7376e311086so7222778b3a.3
        for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1745881182; x=1746485982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H1JC3SB6bg3Kh1Lc6Ix7cDLCL9x47C7m4BGLH5riut0=;
        b=R7HMM5sSVe2KE69MuArlTNX9ahEjgi1EQxlW7i1QKaGL3XV+bmtvjkZblfAmvQbosQ
         qmdpQsl/AzNNTwFwHkIXHgu+Hg5xEjkZCJa1+LpCUU8/xprV/RWqirawii/pRgKGoShh
         XnQLBBwFdR/su201FGHXW7XBG+0/MZ1fU+1PU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745881182; x=1746485982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H1JC3SB6bg3Kh1Lc6Ix7cDLCL9x47C7m4BGLH5riut0=;
        b=TuqcyySPLYeCi/bz02E1ymWFgPHdWEF23JRLXptTspvvRDFGEZtWtpQ4MRz8Jw3LGU
         VTkF1xvPBX+US4FpfNo4gOM99Z0N8AZEn/l44B1UBdbYiXFbQcBs1HyvHzonuWskqgpS
         8Q4WtEEKKZR7ktT4Dmxq4Odq3r1L+qzDGrm0bleHeM/8RkUa8yY0PUHsgs/k2//NhgWf
         62BODvweImJ4iUq1FqVHJ28gO/EYkFF1JEPknfRiEjW1Ar7/RakcFKhA6s17Y1rllDGh
         mNMusHPU5E6WnSFghn9SwxAa7wqX0WmuMcHj8KEM3W/zp5qYajJ46wn7QtdjmGJ6shM2
         HlBw==
X-Gm-Message-State: AOJu0YxYBYzq4X1FQ6GlzSiIQarQ5qz0rOKwaDOhc1TLRaqX8t+JcQIp
	2NrC2YvprtMwqsghnzkTTrdXv+KDnJ6UX8NC7O3KTbLKsm0a5Z7S/eqm9i1P5w==
X-Gm-Gg: ASbGncvzmcvXo7pzjTHhql5nZpBTUdYi3gZfNgo5QVqRVKq1nE4L4c04M3HcfJB3DrS
	MRIFSIG4yEJWxRKyZT60NpC6GZ+Ag3nlwBHARvMLG+uNA3/Z8vCkTMUvnwFoRsHWYYx8aGxRSBN
	8ztbPuPUbkP/YBgp4xTtrOSOkHhus76AyD8UyOP+ZT3sq+lh30S3EHNweMSYUUrGKCE0fnKMWL7
	jo5gaAkdEHC71sXeh3laBmFK/cUdGS5KQvcTzog5XOSp53atDBJW1wn72s81ERPjcLreFdKv1br
	7jPKZt3oa+lF5YR55X51KK0Y/XW2GRdzLImJpBbuA2iz+y6H0XZWZe6VI0ImTj/Mt8Hfmt9eX9w
	vGEjeDXgqmGgIDPgS
X-Google-Smtp-Source: AGHT+IHhodef4RRVpBpSPOv4QOhKCNI63Si+SGt08Dy3k4gdQ6RceTW694teY93VD9MQloStZGAYuQ==
X-Received: by 2002:a05:6a00:398d:b0:736:35d4:f03f with SMTP id d2e1a72fcca58-740271352a8mr2109697b3a.6.1745881182405;
        Mon, 28 Apr 2025 15:59:42 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25aca4e8sm8534344b3a.162.2025.04.28.15.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Apr 2025 15:59:42 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 3/8] bnxt_en: Add missing skb_mark_for_recycle() in bnxt_rx_vlan()
Date: Mon, 28 Apr 2025 15:58:58 -0700
Message-ID: <20250428225903.1867675-4-michael.chan@broadcom.com>
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

From: Somnath Kotur <somnath.kotur@broadcom.com>

If bnxt_rx_vlan() fails because the VLAN protocol ID is invalid,
the SKB is freed but we're missing the call to recycle it.  This
may cause the warning:

"page_pool_release_retry() stalled pool shutdown"

Add the missing skb_mark_for_recycle() in bnxt_rx_vlan().

Fixes: 86b05508f775 ("bnxt_en: Use the unified RX page pool buffers for XDP and non-XDP")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Pavan Chebbi <pavan.chebbi@broadcom.com>
Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c4bccc683597..cfc9ccab39bf 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -2015,6 +2015,7 @@ static struct sk_buff *bnxt_rx_vlan(struct sk_buff *skb, u8 cmp_type,
 	}
 	return skb;
 vlan_err:
+	skb_mark_for_recycle(skb);
 	dev_kfree_skb(skb);
 	return NULL;
 }
-- 
2.30.1


