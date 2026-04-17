Return-Path: <netdev+bounces-279246-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JAqCzLZ4WkuywAAu9opvQ
	(envelope-from <netdev+bounces-279246-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:54:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE919417972
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 08:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0EC93301C5C3
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 06:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69E336CDEB;
	Fri, 17 Apr 2026 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLOwRKbP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C614537104F
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 06:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776408879; cv=none; b=pJaJYyEG/0EkfX9NiXKpUIzCvpsxpQLD/64s1k8L87yN1INx0ZhBQLCk1P3mvaVzDxMPder6irYUS9ez8N9s32oYZNGgM5aF1P20Jh4S3+5R4k/rD83PzLvdxOrTZxGVykvaHf5tgPk3vz7RFKeYNqjDUYihpCkBzqd5/TY267M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776408879; c=relaxed/simple;
	bh=UdyI0MLqzaqJUekJ8644S6ZTpHQmBZWss+KW7Oq1u9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fZgXAxbRl//PNzCmiRJS7EiovXqf06EJTZecM4y/Qpq6MbRYGykusSC7gxe84ThpW4Paxk8tjHiV3SS1fIwVSI979UL4qfa5utjB0Fbdr7CXJsj94JLv9ZQypeinObsrJGHCZXCmAf7a3QKwRXpdKfLp8HNf0uiBim4Vg7A8ttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLOwRKbP; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8d4f78fc9f6so40326585a.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 23:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776408876; x=1777013676; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l+U16PxstDR4L4OQVQNTIksMWdGsxQeNQ1RCa7J7x8Y=;
        b=HLOwRKbP7AwKrJeApv3KVfsLN6J5FEOZH9nJKLKZCuTjD8jugIK2a/Y2zHP/11kiHv
         Ile1yPrE6kMl49epVH/HnTLEx2N5x5AhD+eW7QCgQ9NjZA9j1/e+Z8mDFsukkvvMpyl7
         UEOn4cIExCzdes+iBHiBOCSwtYONLBAOvFLPBu0ioobdfeBIyAWFti+pakXy7XeILgB7
         6VjS28+Qa1VUe+igbM5ahtsnvh7nQOtyv9P8uXYIDWe++Zfe9jDrqrLF0XSaj80KS+Ns
         NPu3R/1pBKbXYLw79/cFoxoQAknGRJeSjM0bRnG5e07W+Jakwx3CYEH8PtbdKCMF6sPn
         m6/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776408876; x=1777013676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l+U16PxstDR4L4OQVQNTIksMWdGsxQeNQ1RCa7J7x8Y=;
        b=BuUueMKlqFxZFJRrnBfgzv6yI3q/LR0plDImnu9KMkzDjhNlXKfgONgpKZLCgNE+c0
         UO4C9NEVaVX88/luUD9dkSNjtLAPA6ZJkTNL0i9ULoI7m2wdAvLgjTjYPZGgB04AfLvA
         NX8zxCX+Suqs8Y5Itdj2rZry38u2wsFVVRhBj9g4UolOgdB/6mdDAGZj5ukHBOTrVBe+
         ArTP3cRoF+mEJR5LDfogewPqR37k+jgGryaVbrKHgwJDKWzbdIdoCe//qJXJGlc8zal1
         Yo7v1x27u9fuCaKV6R0za0Cozlqt04vD9BYMwpX3YxtbbaPGg6XtD6U6WX9E3ylqh0KY
         ss4Q==
X-Gm-Message-State: AOJu0YxtDf2wMptWVF/w5pQs9c9DO3fz9OqcGpgSBdqXwi4a1FUio5wV
	ZNJYsEcdXfcHiM+u5rLicx+FZeUvLDBobz9DvqAgASAGC/gK1BmMiQ+eI2iLLoz10eOcUQ==
X-Gm-Gg: AeBDiesn3LX7MmBHwZxRvHOVrPULHCSATwq3hswy8xIxjfEvFp01ieZrnD/yRkqUHmP
	RoeGH7NzBMH6aVwaVz7WaEX2Xh71v+qg3m9EvpLBBGUZ9s7EkGetDdHTfYzgK4qgpdIzs93HaPM
	n0PtgvGS2/MLSBM/oJPR7x6ULteShp4i4VzPC111UyjCsCWQ+Clj0VyMxm2rEEATkzl8mVEOaVJ
	hHhIJPdRK087AkdIbB2Tmtsdt+ZOYNH6rLTpn4Az5oswU+GLC83QuLFWPrDWQn+CcPgJvdIkmvn
	SdnHO8Z4PuBER506mx44POx35J1+23WHIQVS+gPrs9OyT2LLvdwlCoXTl2YxCIYQpqbzAuq/sYZ
	KyM5BwfH24MTOcdfX3Td/9f9OLvy0W+dCF/ZaFqrFhR+tdK4qkLpmiczuwUgK3HIfV0hVFfrysX
	IOMxE4nS8sLdXni7B/aO2aGiuDg/vJ2PCSz8pJkrMJ8am2ip3AD/SVtvbABDX7Xb2reaTZlKXVm
	htsu3TwLZrlunCps+7SECmSp7JquR/CBkmsKk8=
X-Received: by 2002:a05:620a:28d1:b0:8d7:3f45:b95f with SMTP id af79cd13be357-8e78fb18dc2mr206676185a.16.1776408876364;
        Thu, 16 Apr 2026 23:54:36 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8e7d6ba19c3sm46771285a.21.2026.04.16.23.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 23:54:35 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-hams@vger.kernel.org,
	jreuter@yaina.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v4 net] ax25: fix OOB read after address header strip in ax25_rcv()
Date: Fri, 17 Apr 2026 06:54:07 +0000
Message-Id: <20260417065407.206499-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,yaina.de,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-279246-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BE919417972
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

A crafted AX.25 frame with a valid address header but no control or PID
bytes causes skb->len to drop to zero after skb_pull() strips the
address header. The subsequent reads of skb->data[0] and skb->data[1]
are then out of bounds.

Linearize the skb at entry to ax25_rcv() so all subsequent accesses to
skb->data are safe. Then check skb->len before reading the control and
PID bytes, discarding frames that are too short.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
v4: linearize skb at entry to ax25_rcv(); replace pskb_may_pull() with
    skb->len check
v3: remove incorrect Suggested-by; add symptom, Fixes, Cc stable
v2: use pskb_may_pull(skb, 2) instead of skb->len < 2

Link to v3: https://lore.kernel.org/netdev/20260415063654.3831353-1-ashutoshdesai993@gmail.com/
Link to v2: https://lore.kernel.org/netdev/20260409152400.2219716-1-ashutoshdesai993@gmail.com/
Link to v1: https://lore.kernel.org/netdev/20260409012235.2049389-1-ashutoshdesai993@gmail.com/

 net/ax25/ax25_in.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ax25/ax25_in.c b/net/ax25/ax25_in.c
index d75b3e9ed93d..d14ccebf9cdd 100644
--- a/net/ax25/ax25_in.c
+++ b/net/ax25/ax25_in.c
@@ -190,6 +190,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	ax25_cb *ax25;
 	ax25_dev *ax25_dev;
 
+	if (skb_linearize(skb))
+		goto free;
+
 	/*
 	 *	Process the AX.25/LAPB frame.
 	 */
@@ -217,6 +220,9 @@ static int ax25_rcv(struct sk_buff *skb, struct net_device *dev,
 	 */
 	skb_pull(skb, ax25_addr_size(&dp));
 
+	if (skb->len < 2)
+		goto free;
+
 	/* For our port addresses ? */
 	if (ax25cmp(&dest, dev_addr) == 0 && dp.lastrepeat + 1 == dp.ndigi)
 		mine = 1;
-- 
2.34.1


