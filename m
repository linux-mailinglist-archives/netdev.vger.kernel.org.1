Return-Path: <netdev+bounces-256156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MBmLtWRgWl/HAMAu9opvQ
	(envelope-from <netdev+bounces-256156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 07:12:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF435D5109
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 07:12:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BB2E33006934
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 06:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB808214204;
	Tue,  3 Feb 2026 06:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k15ya3ul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE0625333F
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 06:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770098957; cv=none; b=X7Lvx5nsP5KHZOTOvQntixrEnApcaGCikRGrHKiuQ0XdwinnHiQmJvve/7cMv17AGR0w8NanZr8N8wNXGNEpET3bpcsEMKuF7KtTjgqcRC6oekYIXczW2pGJEcguDtuyKF4MsWJFXWAhAbCjnhtt5p8Z7AnaQYbxzqVd8wp2ozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770098957; c=relaxed/simple;
	bh=RsmIEw4p7De5N9dD7XSk/r0wfcaiLMq0HvvuGze0Ozo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ivZQgFxZTo/M1Ku61zfFjrjud6d2sGqInPQeo/1ZmtELYxPAekAQjnOYyGKWZn1KE9hULpM+BqnKJ60bI3XJeSHJmU/PinXCyv1e6AZXaqYs3+a8+PdlIIOnr9bz1OT3b1UQfWj53kXg83oHLqYtUOaM5q3b32+JgtEqogdU/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k15ya3ul; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82310b74496so3034725b3a.3
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 22:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770098955; x=1770703755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uH5PpPVjOvr4AWyQGZSO4TmeYvmDpJCxAxK2ZZbBypw=;
        b=k15ya3ulvWRKXQJcG1KneB4ngGSAm9LevEx7M2nikL0g1ne4ara4tD3Tta9pL1wk2n
         5vloqF/iGABO5aLTXrTE6cqkYfvnRXrZKY/Phfv+2PoqJHE34sH3lbjBJkF/j8Yggl7N
         8TnKkYkDRB9A2ElSyBFBDFMdWM5MGNfECXqRtgm/xvZ212Sa0SICQhJ4sduEqhC0w7K3
         6ojJGNZYJHCSZ90Nlpf0mc5AJIrAd5zt0uteVBeHyB41Om+LemKlbc3oyE4pqXZ32mCn
         gnEzD/DyM0+jvUS50TH0bYAWKR9/6ltsXauuxITH3JXij3IGv8gCqPeHY7yH7hll49H0
         4Y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770098955; x=1770703755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uH5PpPVjOvr4AWyQGZSO4TmeYvmDpJCxAxK2ZZbBypw=;
        b=hhm/St8ITJrbo70nP9C7zKYGmyDR2axgym/u0gcmuskCAVASQBsB/p7KqRbX1Cfb+L
         ldIWlrQ+bvTrXaSYOpXIigKvlGlUBTc9vGJMm2jyroaxa2XbRzR1feVisJ6DOFXpY0SR
         2aZzUic7hrXKFT0T9C6g2b46Ej3ZtHhlS2TlpTxj7m4RSUENwE5t4li7uu/KoLg3ufgI
         7x0g/MdQxPJQnEigMBZrQ7u1f2GZv7nIC5CBRgvula2Xi723EIsE3sMIu7gJLnuusfWF
         5X56ULgb24C4JyDbB3slOvRLAtRGE4fKUp1Da39FmfH3DOHEHDJaDsEFovMXG8QtGuPb
         y4dw==
X-Gm-Message-State: AOJu0Yzx5qrwQtR9OkAnlHCyW6wOQrW/7uWSgFS7tzTKblIP3MOQ9v26
	RYWhox4Ugi6PkuqkFzfkxu1OTB6QYjolQl6IXbgzIK1EeSm95eOAR99lBQpw
X-Gm-Gg: AZuq6aKGRG9tBuZysBrpy47k+/mAYqhE1sfjSHnJicO/0USvb5ycXs9tDsYvPdiGIdi
	a3yChGc4JFdq9OyBKeULTEAXdBEART+lmrm0TUzsigfG0botNpfDRWOPLvDd5D5NcEpngBnZW9V
	hIZC6e2cfRrwBYNRxSoT38QBqpEzeIvIB8HFGplAp3DD3TjN7LMj9eazXVXLNBYgAcQIVuhI+U+
	X6uv0Aa6OWKWKWsZynPsFjDrCptEysJLaRjLCXskHFIuXjKFgVutsrvGrrDbAyJON9Vb5vhpA/z
	N8sWORpVznqAwUh80L3mgvYKWSfpfs5b5ItGjihYLnFgtfjXT1CRTdZDySmxwMqPawzKre9sVe7
	uh8YhwfrF1f3JQSsY6+Iu6J7K0M3Y5KMOmXLy6czPMNzwmX2F6nGyFVIF9A5qzMwEuNL7DKe2Q4
	86kRsUkkGRBEkplLIEViSORrlLUbJnaw7uOq0KJ84V
X-Received: by 2002:a05:6a00:428b:b0:7f6:4922:89c4 with SMTP id d2e1a72fcca58-823ab7492a6mr13403122b3a.55.1770098955250;
        Mon, 02 Feb 2026 22:09:15 -0800 (PST)
Received: from MURARI-LAPTOP.localdomain ([106.215.148.149])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379b23020sm17609290b3a.1.2026.02.02.22.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 22:09:14 -0800 (PST)
From: Murari Prasad Samal <murariprasadsamal57@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Murari Prasad Samal <murariprasadsamal57@gmail.com>
Subject: [PATCH v3] net: ifb: record drop reason when redirect device is missing
Date: Tue,  3 Feb 2026 06:09:07 +0000
Message-ID: <20260203060907.993-1-murariprasadsamal57@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256156-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EF435D5109
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


