Return-Path: <netdev+bounces-281166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kA6wLqIk7mn0qwAAu9opvQ
	(envelope-from <netdev+bounces-281166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:43:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2137C46A64A
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 16:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0201E301A710
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 14:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25491367F3D;
	Sun, 26 Apr 2026 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kLZgChtG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99643365A18
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 14:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777214591; cv=none; b=L5Se4VAlreawEEPpKjUAVccVb4+RFJoCd78gexIP/BV7uQ5o+dyF0Ybm/769JF8G1o1qQ0w166uibxu7YsQsgImJhhIezfIxPlCb3l/jIz35gUGMttGJ5s3+oqoj/EPTcwVe0pGMI6wNWM+64y7J/WDDLRQJkKyeC1Rks4LE3ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777214591; c=relaxed/simple;
	bh=r6IW2Vxqif4eP3VQmis8+qHG2ez7xshZW7LUio3QdpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aiwyp2CDKdA/wm69vVtULQXo5HiTO+zb1Y1q8qEBwzG0mCcr02MZnO4JyvoFoPU4JLxma9Fc04KzlgJXVUax9eMFfGBnbcqb3E+msx6tmicWbFvoENl5cnQ55oGGvhr9ZdNl6fp3CFk5665h6/PXZbx/4EcJCpV5Nxi+4EpmlQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kLZgChtG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so116942995e9.2
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 07:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777214588; x=1777819388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9s1WYxPrrvK/oJoRsHuHHnoI8/Jk8XB2HAvh4QuaKcQ=;
        b=kLZgChtGfuoe/1fxADWQr+ppuBG7DmX7oteFEIwJ2kQFt0g9FTasPFEpkMVd12FB1p
         FGo+EWVzli5rhzCWArXoBgXMvSoR0MYk5IMAy7soAj5B0jeHQ2fVdy9q0JusJk0Lllp2
         3LVYyiuCr8+f9wgifaFQ0r3Q7FbOCzIFuce6t5eAn6u1XuYuV+0bqqWUmPbs3CEYIEnq
         83l3uhLtuwd6Nt8ImkVTKxlOExHgWuOyjSxCTEePMuDRzpbQl0CtJ2vauN5jn5hxxILs
         0GffxVEzUrB+z4WERTpFAHPKNE/yF85A6BTG9I3o+oG8ARKNmi2mGOp9cfdIMvs+OIq0
         PNcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777214588; x=1777819388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9s1WYxPrrvK/oJoRsHuHHnoI8/Jk8XB2HAvh4QuaKcQ=;
        b=Gr32M1bJKaKh92txDDs1y2FEq66ZQKwtF32GZ9x1c2WyzkmtkCvP376PX6HPKM/CSy
         xzoVD6TK2uKFv/lltLJKCMYshEZ/2bczl8+fVug8MCEA+lJkyqok1otgCtZHnZR92wII
         YGvdtPLDm9nWvwso0T/uBqKTiR46eowlw+Fy2r/MVZISgofgjtgXwH87TTKo4UXJ8Y0B
         i6tGzOp9hajtTGODzPd/fqADdBV2lJVFN9yctYbRHN9e/3gQfM5amLH5DXFi8BGDuNTk
         VLVctPAQDLWCVJKxjG+ujO/wPIN4A7bIWyfjhZ4etjxcjRywLZySA1gjwfHrYwGRblD3
         jN/Q==
X-Gm-Message-State: AOJu0YxYEocGdfsqsyTNtHRrRbqsqboXiwYrFO5nGsI5mgBc/ERVODMt
	JF6dk0zaH8Y2yLAztKwPh1ylhjePPA871ozJq2q8VOy6ykAVCRs7ID+ZOnU6yA==
X-Gm-Gg: AeBDievgwVCzeEaxymsH/Uy96JjAmfnCOfvOSOV//zQLZetmeTAfdRFY6lL2Auv1uJE
	sOQf8ifddk2tmOZrAN4gcPC4uFL3wDOM7hzt+kFeUdVWivq48iOBP3K5Sr1Kfcw8jqkYWS6rMUZ
	f/kUao1POfc03A7+nxa1I/BODcQALGxSIfbNMcuCFuNAarZwmox2uCNJ1KDtPB5tJ1iX4ZOS6pH
	pE4mmevThqsXdH+FcHQDeh8E1wxp+UmhzxboXFPCsQZgSrT87KuzCf/kPVMHtNidtJa3jzzTtsf
	lRElB1SXPb5tAo+qj91wJ5+aWRlFXCupK9y0L24bKqRdAHtcOAo/eAUBfI4ezhCId+r6G223Y0d
	qKIKy/GswkEMyB2pBfVIILJ5GN+Zgt5dMD6RNFtTh2J+HNJPEgup1RuEDA+Vt9hLi2GeORDGgRU
	nIP5koH8CXH3eb04pv73LVKMUqyPipTbDmUoSuMNB+La4gxKFW7g2FiPn1tkwIsoJqJ1xpuZCUd
	bK0HecpRUvaFSw=
X-Received: by 2002:a05:600c:c10a:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-488fb771613mr428687215e9.18.1777214587716;
        Sun, 26 Apr 2026 07:43:07 -0700 (PDT)
Received: from ubuntu-f6bvp (lfbn-idf1-1-366-193.w86-195.abo.wanadoo.fr. [86.195.82.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc18bccfsm658230335e9.8.2026.04.26.07.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 07:43:07 -0700 (PDT)
From: Bernard Pidoux <bernard.f6bvp@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: [PATCH net 1/5] rose: fix dev_put() leak in rose_loopback_timer()
Date: Sun, 26 Apr 2026 16:43:01 +0200
Message-ID: <20260426144305.984349-2-bernard.f6bvp@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260426144305.984349-1-bernard.f6bvp@gmail.com>
References: <20260426144305.984349-1-bernard.f6bvp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2137C46A64A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-281166-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernardf6bvp@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

rose_rx_call_request() always consumes or returns the skb but never
releases the device reference obtained from rose_dev_get().  When
rose_rx_call_request() succeeds (returns non-zero) dev_put() was never
called, leaking one reference per loopback CALL_REQUEST.

Move dev_put() outside the conditional so it is called unconditionally
after rose_rx_call_request() in all cases.

Also remove the dead check (!rose_loopback_neigh->dev &&
!rose_loopback_neigh->loopback) that immediately precedes it: the
loopback neighbour always has loopback=1 so this condition can never
be true.

Fixes: 0453c6824595 ("net/rose: fix unbound loop in rose_loopback_timer()")
Tested-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
Signed-off-by: Bernard Pidoux <bernard.f6bvp@gmail.com>
---
 net/rose/rose_loopback.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/rose/rose_loopback.c b/net/rose/rose_loopback.c
index b538e39b3df5..914c8f453a1d 100644
--- a/net/rose/rose_loopback.c
+++ b/net/rose/rose_loopback.c
@@ -96,22 +96,15 @@ static void rose_loopback_timer(struct timer_list *unused)
 		}
 
 		if (frametype == ROSE_CALL_REQUEST) {
-			if (!rose_loopback_neigh->dev &&
-			    !rose_loopback_neigh->loopback) {
-				kfree_skb(skb);
-				continue;
-			}
-
 			dev = rose_dev_get(dest);
 			if (!dev) {
 				kfree_skb(skb);
 				continue;
 			}
 
-			if (rose_rx_call_request(skb, dev, rose_loopback_neigh, lci_o) == 0) {
-				dev_put(dev);
+			if (rose_rx_call_request(skb, dev, rose_loopback_neigh, lci_o) == 0)
 				kfree_skb(skb);
-			}
+			dev_put(dev);
 		} else {
 			kfree_skb(skb);
 		}
-- 
2.51.0


