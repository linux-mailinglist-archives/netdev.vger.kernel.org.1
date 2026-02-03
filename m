Return-Path: <netdev+bounces-256154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO50BO6PgWl/HAMAu9opvQ
	(envelope-from <netdev+bounces-256154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 07:04:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A97CDD4F47
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 07:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFF9A300682F
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 06:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A0B36A016;
	Tue,  3 Feb 2026 06:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrQD9smM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FC92581
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 06:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098666; cv=none; b=WymwvfY3Ryy1PzXwgvWd2qMx7Fl00pGyG5fon/OwV+ipr4h86upfpaIO6euNPQG8qynuFfamoGIjwkFwd4DoOgl70xtzmrR9aJeQoFZk96de8JBcrNMT9Jx6NeDp4f83kdeDF1Rq49fZIjbjdzPpfBMnFkOAdk0Sd6pw5PriZps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098666; c=relaxed/simple;
	bh=RsmIEw4p7De5N9dD7XSk/r0wfcaiLMq0HvvuGze0Ozo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+VhGA+skZTgH7piKlqXqCcg8Rc6K48r+18Df7Kh+DhHGlQ6B8YSZdMN4xo8TxOrRInljQ0YV2Okx0zz0+31Vqd1IxLHSERjv9y93lbvsDz+2QvI0V24wfKR+Zm0jJ058HFoDUm8NDJ6kZky9S1brg3i4OHnw+dX5Ua6E5TdzIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrQD9smM; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-352f60d6c2fso3384581a91.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 22:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770098664; x=1770703464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH5PpPVjOvr4AWyQGZSO4TmeYvmDpJCxAxK2ZZbBypw=;
        b=UrQD9smMUHcgOTb7p89F3/Zok097MVze3BE/2+2h5suPiXpF1Q9JCqFAVEeSLfwH8d
         qPkGvTSXd3MZciui+JIAIZny9huKQ9KmYNe4rlTdPZne9sf6xulMNSfZoIWgiH3gTg+R
         L4WrNryq56V4TCpnQPP7cD6NVMM1StZPfrPcJyArgkmxsKNLB5wlzu+YvklS/dvUCias
         dbUfWcwLfAehh1d6hsK255CGF7dq1th68pQPyktAth2w+olFpyeSOAtb0M9lwjT5IiGo
         3uFTG15AHn0vKf3Xny2gzsIoBIwlkw7KZf9Lyo2FFCLngFgkBp33fC1VS3cRF0j3wQl5
         q3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770098664; x=1770703464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uH5PpPVjOvr4AWyQGZSO4TmeYvmDpJCxAxK2ZZbBypw=;
        b=dgoBP68RlMykz8J72txdf5sXj4yqCsUCz9gvMZYO7pQIJEYpLLMXpaEuHaLeqLOhfM
         cHRDtp7l50P1DNb1eHXlxGuoy8xSMEGjUk4HM7L28u1pDjwjd3h5OCzrufMDLXL5/V5r
         nz1wVSp78dQV+HbRZg0hHmL57B762t1vbizUAQpfjsDh29sygvqG6YpdrU6xCumrEE7r
         nDoqKX+XOU2ut3XN1dGgzdboiRg3gnnlhJeSRhWRleTTDDJbr0AwXnJnCK46DnjGAbYW
         85YTspicpu90N9Rns7R4nTDJhs2rNZwnB6JogESfoaChC/O0nL/78RRHwlhp3+BgVeBo
         eq1A==
X-Gm-Message-State: AOJu0Yx8o2prTAUpNeedzo4s3Jdvt+o5OB+Eh0+Fu1YFcqBY5mtqipYg
	GU/fPv+lOaxYCE9mnBITh+BnFq2uEZmY312yHBKJmH9ji77ye2vMocGJ25BU
X-Gm-Gg: AZuq6aKW43kbXVnECcenLY/ryWciWF877RbS9vF7ewd1Dya6AkcRom1FBJdJ7Q4BVmq
	ER1+zE8m+VUSqTK9M779LwLluY53fBoVVaaVFD+KHmUjBt6ESDqgBlTyAkhuvuD0EDQkatcNOW0
	Gl8DeKsLbEC8ziLza7OMfM9jQPE+gpf3xxH8g57BH1L+9LIclZ4pRx4ZCf4VKgc6AW6u/Q7FajI
	dyKk/RDhrbO6yPhDKczIVvueISvd8S5qZ6inkEz9LoHB2FX835lMvfTCSXWf/0XCwVSUDgfzuCf
	mc3bpnxFcdQcpoYSmnKLDqDiJliKQuLBBK+ieMfL05qx9fIXjgumv+wXQGpbIL8m9+Jyl6i8n7n
	rGb+ijzZh7O/7JN2ctJpsMBm/b10ZPCdFpJpyd2LbsLbXdvRAbb60zTQRvNAOv6y/gpGFkG3cqI
	nnc5w+3dyFtQvRKEmD35ifZ2YiR/wzUMhL0g6empSc
X-Received: by 2002:a17:90a:d88b:b0:353:38b3:dccf with SMTP id 98e67ed59e1d1-3543b3941fdmr14103998a91.23.1770098663814;
        Mon, 02 Feb 2026 22:04:23 -0800 (PST)
Received: from MURARI-LAPTOP.localdomain ([106.215.148.149])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35477763b81sm1431156a91.10.2026.02.02.22.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 22:04:23 -0800 (PST)
From: Murari Prasad Samal <murariprasadsamal57@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Murari Prasad Samal <murariprasadsamal57@gmail.com>
Subject: [PATCH v2] net: ifb: record drop reason when redirect device is missing
Date: Tue,  3 Feb 2026 06:04:15 +0000
Message-ID: <20260203060415.886-1-murariprasadsamal57@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260202191135.7668-1-murariprasadsamal57@gmail.com>
References: <20260202191135.7668-1-murariprasadsamal57@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256154-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[murariprasadsamal57@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A97CDD4F47
X-Rspamd-Action: no action

When redirecting packets in ifb_ri_tasklet(), the skb is dropped
if the original ingress device can no longer be found.

Use kfree_skb_reason() with SKB_DROP_REASON_DEV_DOWN so the drop
is properly attributed.

No functional change intended.

Signed-off-by: Murari Prasad Samal
---
 drivers/net/ifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index d3dc0914450a..689340ccf9c7 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -115,7 +115,7 @@ static void ifb_ri_tasklet(struct tasklet_struct *t)
 		skb->dev = dev_get_by_index_rcu(dev_net(txp->dev), skb->skb_iif);
 		if (!skb->dev) {
 			rcu_read_unlock();
-			dev_kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_NO_DEV);
 			txp->dev->stats.tx_dropped++;
 			if (skb_queue_len(&txp->tq) != 0)
 				goto resched;
-- 
2.43.0


