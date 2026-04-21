Return-Path: <netdev+bounces-280009-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNjQL0YP52ms3QEAu9opvQ
	(envelope-from <netdev+bounces-280009-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:46:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6707B4368A6
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 07:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C64E300493D
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 05:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831233346A8;
	Tue, 21 Apr 2026 05:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NDZmYboU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154471E885A
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 05:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776750404; cv=none; b=YgqdWxYOWimZvq4R6W2Iri4Xytsu4no+Bh5OAQl1XCniwEmuBXbS07JS2zIOCOwrHOR6NLAc+jQgy0gw1DdxlAiscAV672Cw80/59AI+s/NvS425yrUUfqGvnkSA+KMhzwXNvHpEZ0al5logxWSG1ilULyCo0qJFk8rmyex3QAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776750404; c=relaxed/simple;
	bh=Ub2/CujAcX3WFWcxCD/i+N7vpumJ3LeFtAn0W3AHdL4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzF7AfGhSgS8C8I81lHlPGMiuZdIUCiGO0KS83IdB3mM/AGVpNipYOP1/yW+FspfwTObg1l4y5ojQ0usS/LjctzYMvSid6sImmPUSwhvCxRVBGU6KhT1s6Tp2xhnqtiw8hiC6w3piM+umh2d8aQzJNNdD/VREXbvafh2QLQctPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NDZmYboU; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8a151012558so42895866d6.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 22:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776750402; x=1777355202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwVOqviN0nRLq3+r1rz1vZYdV1pHIllY/x32ovYOlAo=;
        b=NDZmYboUdWSfSe+3MRBunxCTO4RXxFGjJMDbeFsPGXul2ZASg3Dk7uEjertgiabLk8
         53RICCXDztWaW9sNZs/DIHU3bopo/0OITO4zkkjSXbFXgK/+jGR6Z2ugZLuWWRowCMED
         rd7Kuw1HzfK6rprvU5kVqxmQyMcRUubApCFPbWUzSPqj21sMgpgvPgXu6joJNntnr5NB
         sKlkVqFfWFB42uvn1TjF6IEBCmjCWVqrY6Ss6j6wVP/3KQsRR54BTivGD3CHjQa1r02g
         fVyYHDzs2iIs1SeWRjbRAjoGDYOKpq7v2E21tRFIK0rQE32F9ncKAVB37mQDVAhlyQOn
         OLrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776750402; x=1777355202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cwVOqviN0nRLq3+r1rz1vZYdV1pHIllY/x32ovYOlAo=;
        b=F7/GlAoJ8cMVlkcK42x/4K2oGLWGoN2GC0rLwRHLJVexPsvm7HQ1+hocucPLMLQkeg
         5UVE484pv/HUH7LiWZw9xku3HCHuui1nFAa9yTJugrFPA0/7yp5JQNlvWwODmlxaepIF
         ivs4U8lRVDmH+PUHHTM4nTKmNEG9MXzGiPVav9TMUv1hl7IPaBu7aURR4b1QuT68B1iG
         Vew39PjvRiG5UX5DLor0Az+6eH+kzKmit0Hn2bEKWTPZl6e6tNW4r778BGl2Bj5A6bXC
         2fB7zzMcnxdVLGYeRAK+9O4VDeFBeBPcBmvauPRKhIMjYmPYEB2s8X4ea9hZTauzNwtK
         dS8w==
X-Gm-Message-State: AOJu0YxJ2CEzthnJZbqwGVekM+gQT0l5fTTK/utzN2lS2vSnf6xY02HS
	/9kDz53y2G/vbKS95rXRMXvOw3+l7aAx8hSCSD0zxUHqDUiqXsQMh0IVHYvJbJX+Jcni3Q==
X-Gm-Gg: AeBDieuswZl6peFS3mZPm3f3YaYJfWzPTbhawW4MEWmTBkeESV2vcDBg77ezImVyg8g
	jgG3uYfzAK86AAUfp05g5FwnyEe8g2vKVUkj+/Ak+tyDuWuRufGaz/UDpipsAaornYGAmcM706T
	Bpb3fa3QKbipCmcLTbZfggDr0yTllzOB22K/z5+eSv/N/JAAXx3Jls4+xLiOmKcq05J5lxRiVgN
	Enf6Z49dpeGQs1f0OiE/aZEBUB1c0Rt8C5qceLQAQ1YtK8I3elV8DmrVNhPxVex/R1ewQCcq+cY
	Vogtg04Wv7WNps3y3AnZpRxHQuEZf5GrWNtykBRADADauc3BgH8n5M6UJForjxr1r5cFOz8OYfD
	1r/YsBAoVH7t4Q5/qyVoV8haLtiGH0lvnldRghopWBcjHbMLBwKJdrO5nuw7f3zzuWeZ9SJXJ0I
	m0xJ5t/rcqYDfmtjtfeEVaCUuTxTum9K+lr0pZ0LscbETZrzTypfOHciY51F/0EjKH4MStXmKCo
	NxRgKo0bLe6FNZnSAbSdTgzot3rPudJ8mSjj1U=
X-Received: by 2002:ad4:5eca:0:b0:8ae:6380:8f97 with SMTP id 6a1803df08f44-8b027ff9ec0mr283807226d6.9.1776750401954;
        Mon, 20 Apr 2026 22:46:41 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac462d9sm96508256d6.7.2026.04.20.22.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 22:46:41 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org,
	linux-hams@vger.kernel.org
Cc: jreuter@yaina.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v5 net] ax25: fix OOB read after address header strip in ax25_rcv()
Date: Tue, 21 Apr 2026 05:46:26 +0000
Message-Id: <20260421054626.732399-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417065407.206499-1-ashutoshdesai993@gmail.com>
References: <20260417065407.206499-1-ashutoshdesai993@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[yaina.de,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280009-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 6707B4368A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A crafted AX.25 frame with a valid address header but no control byte
causes skb->len to reach zero after skb_pull() strips the header.
The subsequent reads of skb->data[0] (control) and skb->data[1] (PID)
are then out of bounds.

Linearize the skb after confirming the device is an AX.25 interface.
Guard with skb->len < 1 after the pull - one byte suffices for LAPB
control frames which have no PID byte. Add a separate skb->len < 2
check inside the UI branch before accessing the PID byte.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
v5:
- Move skb_linearize() to after ax25_dev_ax25dev() check; avoids
  unnecessary allocation for frames on non-AX.25 interfaces
- Lower general guard from skb->len < 2 to skb->len < 1; the stricter
  limit incorrectly dropped valid 1-byte LAPB control frames (SABM,
  DISC, UA, DM, RR) which carry no PID byte
- Add explicit skb->len < 2 check inside UI branch before the PID
  byte (skb->data[1]) access
v4:
- Linearize skb at entry to ax25_rcv(); replace pskb_may_pull() with
  skb->len < 2 check (per David Laight review)
v3:
- Remove incorrect Suggested-by; add Fixes:, Cc: stable@
v2:
- Replace skb->len check with pskb_may_pull(skb, 2)

Link to v4: https://lore.kernel.org/netdev/20260417065407.206499-1-ashutoshdesai993@gmail.com/
Link to v3: https://lore.kernel.org/netdev/20260415063654.3831353-1-ashutoshdesai993@gmail.com/
Link to v2: https://lore.kernel.org/netdev/20260409152400.2219716-1-ashutoshdesai993@gmail.com/
Link to v1: https://lore.kernel.org/netdev/20260409012235.2049389-1-ashutoshdesai993@gmail.com/

 net/ax25/ax25_in.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index d75b3e9ed93d..c81d6830af48 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -199,6 +199,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	if ((ax25_dev = ax25_dev_ax25dev(dev)) == NULL)
 		goto free;
 
+	if (skb_linearize(skb))
+		goto free;
+
 	/*
 	 *	Parse the address header.
 	 */
@@ -217,6 +220,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	 */
 	skb_pull(skb, ax25_addr_size(&dp));
 
+	if (skb->len < 1)
+		goto free;
+
 	/* For our port addresses ? */
 	if (ax25cmp(&dest, dev_addr) == 0 && dp.lastrepeat + 1 == dp.ndigi)
 		mine = 1;
@@ -227,6 +233,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 
 	/* UI frame - bypass LAPB processing */
 	if ((*skb->data & ~0x10) == AX25_UI && dp.lastrepeat + 1 == dp.ndigi) {
+		if (skb->len < 2)
+			goto free;
+
 		skb_set_transport_header(skb, 2); /* skip control and pid */
 
 		ax25_send_to_raw(&dest, skb, skb->data[1]);
-- 
2.34.1


