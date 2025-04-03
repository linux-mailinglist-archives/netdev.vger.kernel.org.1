Return-Path: <netdev+bounces-179177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2206AA7B0C0
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:23:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB2973B0844
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736B31ACEBB;
	Thu,  3 Apr 2025 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp7QzFqT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F18171E49
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743714651; cv=none; b=bnWkOkokMPHurKRGyCCX1u2mDrnM73dg7VbR4QqLgVPo8rEu+lE8ir5dkrUz9EfJknxJ99+9kcxn/EWyP52q8hZ9MwLFbJA5NpSeu0RGbu6PP1rIbhdTPvv0JnoNurAHPnG4P7/YmRXLPpd9mBJ5zSX+cHXEcTRmSZANJBmFOFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743714651; c=relaxed/simple;
	bh=6xAT4FZ8Ia/GP5RFqG5qSyy+IR7iqZyT79R9PR8fpLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nUKD7yzLtc5ZYKJ5mzO/DcTO0Xouph9uKHVhP6r/YN/GGSY6kkDxnr/RMcr9mSLbb4t84IGLDgqdPmLvloi58sJ0a+SELUcivp4BO0OGSxAc7CHRUF3N9eu7bbQkG2P/jZY48GAyvY3gsACacHc3DYcYhtCt/nVoIPpZ4anOdtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dp7QzFqT; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2264aefc45dso19388675ad.0
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743714648; x=1744319448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COCG/9OD/BcO1OKsCfXyutvS4gXhQL9GdK8U1ubq8lQ=;
        b=Dp7QzFqTDLgNIzKvNhpXb2q6jTB/OZ5i/Ts5uwW6rygairecy29u7aJcLjAVG3Lyra
         pJtMFP70QKU3dqw2vShh3mkyZz9NfHmq0RAzizBt3K3rFSKMnizhMF8KeDYpp7Y7AijH
         KLdPt46nT2QKBmUz7Qr5QfpSAEYxVP5u/K4S+1i+i/KxDqqU9u/u7U/QP7AkPXsH4lki
         GrimYQQWbFDlNEJTIvHMJbU8dOTTxLrieckLtUa5LtRr22Mnl+mNpeL085oXF7AGkJBk
         GsyrFfgP46H9/nFGeuTnQBV0n1a1MD2zuUX6UPzPlP4vi5HQTZNA99nsy9pM9I809vGn
         2O6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743714648; x=1744319448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COCG/9OD/BcO1OKsCfXyutvS4gXhQL9GdK8U1ubq8lQ=;
        b=mP9mBlc6tZCU6lv9iJcSaBYUUeAePU70SsNWOg4vGbSMNSyqpqQMBPLnj6x2U3Jovr
         BqAQJYAJlSHLQ4AKeHxwkDDf/PTlOU1rxMTPTVAiluPx0nDp8ufwYnK31cw3apczJkcN
         so9lFrWq2TKXgGCCITNvQ0+hjYupAGdQaQ9/DXUIv88CTeRM3xStFr8onIjx8I/Q4LGg
         tCsnheYCMY38teJENhcEhag54KRtZ6Ms0RmHDBc5jMrRSxkTS6qoOCNCh8sviNCtFJ9R
         sKJNnm85DnlT+I2bkb4FgvChD+gWBr0YemSXDnN6TqvePvnaduG916/KW3pBhhKtb43c
         Gciw==
X-Gm-Message-State: AOJu0YybyMTX0hikKfbiqCdl0QRZyyrAN7qzRLr2E67M9njKFI6hEsLL
	FtGVWvR0uJ5mbRM6D5wccQNfP20kVspM5qEfI+LXqkWuI/FpGrs/8L5oVg==
X-Gm-Gg: ASbGncsdmrh1Lk+zc9NNUOX+rqIEcYhfF8QE0Khj4VqVUF6R8gDMubgNoPydCHe2uN6
	0fCaKJRXlSy2vQjpyESkHQXbo81wnEPwigsMj30MHX+3jnfQmx4gvYxryAD0bhepQkal+L7Z83G
	pixS8m3JLKdFHrv3bMIMtS0eDt8EcEiTMZ4nezcoynq+LOS/zwl8vfsqWMelswLaTqKgvkoSKVx
	43nC+ZqneguZ/XvOCPTNSufpZ3iZm1xHlnUJeOYZ8hqYz6TKCwELRPJYi37IKNK35Ty68PSQTRU
	FsF9VknFlmeYOYxhfga37aWGk8LFjV0o9g0T4/yW+V8p4I841q7zljQ=
X-Google-Smtp-Source: AGHT+IHS8S9ue0dtYw1z/gxBfkpCpBoqPE+wVy/3ycbw2NPwhIgA49u7ty/QY0XFDt/aKvafGF8+eg==
X-Received: by 2002:a17:902:e749:b0:224:1074:638e with SMTP id d9443c01a7336-22a8a8d3167mr5248955ad.52.1743714648557;
        Thu, 03 Apr 2025 14:10:48 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785ad831sm19367645ad.11.2025.04.03.14.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:10:48 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: [Patch net v2 01/11] sch_htb: make htb_qlen_notify() idempotent
Date: Thu,  3 Apr 2025 14:10:23 -0700
Message-Id: <20250403211033.166059-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

htb_qlen_notify() always deactivates the HTB class and in fact could
trigger a warning if it is already deactivated. Therefore, it is not
idempotent and not friendly to its callers, like fq_codel_dequeue().

Let's make it idempotent to ease qdisc_tree_reduce_backlog() callers'
life.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_htb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index c31bc5489bdd..4b9a639b642e 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -1485,6 +1485,8 @@ static void htb_qlen_notify(struct Qdisc *sch, unsigned long arg)
 {
 	struct htb_class *cl = (struct htb_class *)arg;
 
+	if (!cl->prio_activity)
+		return;
 	htb_deactivate(qdisc_priv(sch), cl);
 }
 
-- 
2.34.1


