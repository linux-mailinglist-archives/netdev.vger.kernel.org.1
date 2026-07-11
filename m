Return-Path: <netdev+bounces-306813-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZsUGA9wdUmqbMAMAu9opvQ
	(envelope-from <netdev+bounces-306813-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:41:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8A7741427
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:41:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=AttOGcVj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306813-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306813-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 46346300C32B
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0873BB120;
	Sat, 11 Jul 2026 10:41:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C303B7B84
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:41:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766464; cv=none; b=nDJukM1O7naiwTg3ffGsvfuFvm3gZCC2esw5gfTgYTI0E15Am14l1l6xZD1HCNMhReguO9wutO4FUtRfjsJc7o+MoZAKaanGHRWpdNE5gV3hGQePBH5wQMH/4RDDBOVNEh+zNM0+0lLa0HFGBFjsnRzUrhkP7vcrOj9Ut9M1Sqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766464; c=relaxed/simple;
	bh=V2IGT/K8yGUqp1JXHxJ3f4qnE8XDEMisHjgGH09AwF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kv1r6bCk80Ke4589Iq2GcJm0Pptc60u7vrFgmCHaVAbVRC5t/NfrUsUIfYXSKIDSqX/71cIpUmZSTv6Su8ieTrGEkqjaltYfdWYYiYusWmSYziJ2TqRc87Cz/ZA5IbTggN24zVnRwVAMguD+mR8AWNpPqi1dSOac5+Y66qXvzsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AttOGcVj; arc=none smtp.client-ip=209.85.208.45
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-698beff7178so3136995a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766461; x=1784371261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=edaLm3WR+Fb5O6dJt/wBHgk0B8eZBQJTOHLXheg92Oc=;
        b=AttOGcVj9vTk6BecAhg866vo7lhSLf45xap+HvsWQrW+sbIfspAFjKKkt9HRiWaKWe
         nI+MdyvXZM1A2wkeH4exUe+D4ttxP47wF0025X2NfQunpiALBt+KOhafkohAoGPPXoMY
         RqosBvVqNYU2AZ4AKdzX2CN1VqsEe+Jh9LgXPJR0QsPyuvtDIZCIZ/nyqWnQBtxK59Io
         dOzNdmrJ85ww7PZkPHObByw6nnOoIkGD+9KdOExmvBjcQDfYnavq547lEsBk+0bluTuQ
         9XcS44zK3d5i1Q1SAPLHii413leJ0nAkjNxqhgHGi0hdLXlyt8MlmTUy4uSKgr3NMWmh
         vXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766461; x=1784371261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=edaLm3WR+Fb5O6dJt/wBHgk0B8eZBQJTOHLXheg92Oc=;
        b=mL7uWiMWnoTOfzTsg/dE4UhzeeS46O8CVelXeNTfPMDTFksuproZWjMTVueKv1R2Y9
         zckXrtU+DmRjW70zhXWzl705sliGhT7928MkwrLyFjUFbJRZqI/c0TXocvi4hSOrcP0Q
         wAW+HCQftd9s8yf6s6+c/w3wOY0lFup2b36nr/cxm0Vnots+KKykQsld8o51ut0QWVQk
         GnnlePk4uJaIr30D4eEpw8NxQoowrfH1UfcU8elBv26uXbxpZcH2/Dxy2eNC4v33HDEr
         A/jdOT/dwsXB+OcdyY8KrGCV/t4DtydPntFlgL8bEbH9aHFSV8B3L8RcYvgU2JmhKvh3
         AS5Q==
X-Forwarded-Encrypted: i=1; AHgh+RowW8A3ANsvSX262XJcU0BF5kXY7GcJN0HOpI+zRYCWYhh7n/1m6btDlwlZf7Xq8+mlwNE1Z14=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqk6chRaydiz9ZDEndEnsVCbxdQjw9gfHgPq4BZDX/7hssMixu
	adGLpum99XVoFD7qePcEUtETY/BPYuK3pvn4hWesUgNx+HZ5RNJEoSjhZ+HC7w==
X-Gm-Gg: AfdE7cmVG6GUMovXOJWGgtXCwAytAIaWMAbqc5fjugIN3hnYP7bpMruDyeD3Wc8LQjm
	nT/3xSyTStpyYeZttZ1TuPWAyiUXtMrj4LlmMxK8rY5TZE6OfelC7iHeYWwoiLqcP7HN2oVBO0y
	h5F9snwR6I93Xw1koZ7CeX6TEvodbqj1JrC2G3irDm8vd4Ioq8zOIRAqk3sdqsezBvTRS5YM7xd
	CdDdnZZfb8QJSgoTb5WdTmktQAxYIBnaj74s7nHJWq9ObcdKLR4hmL1VnYAOm1miR57ZMtRd8v7
	IR0Wwd5JDvRghV367AUToGN5MzqB1rPf9Rfk0KjBiWqlRF+yqnYUUr5/0iGMbCYK0SKReo6tEEg
	Lp6cCQpdxVMBeCG7iGFROE6jW7vghaGa321H38rxQMChw7CDZ9xxvyNp9he+eOfabxL7cQaDGYl
	arN7r6lzUD0P0u9XVLIhAZfLqr96qCNuvzXpCYGTgLSD1rQCGd3UyzfQSvXhzWsoxfqnI8/n420
	IfU3ClVMBlYct4KX7flUVGD0qC4g0PvVEOZ+dxVSZDxSGD86Q==
X-Received: by 2002:a17:907:bac8:b0:c15:f6b6:18f4 with SMTP id a640c23a62f3a-c161ea5e6d2mr80976066b.24.1783766461630;
        Sat, 11 Jul 2026 03:41:01 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:40:58 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 10/17] io_uring/zcrx: unmap under netdev lock
Date: Sat, 11 Jul 2026 11:40:03 +0100
Message-ID: <cf52185c92e3099d805d9a0e9b1af13b30776aa1.1783616211.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783616211.git.asml.silence@gmail.com>
References: <cover.1783616211.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306813-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:netdev@vger.kernel.org,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF8A7741427

Make sure we unmap areas while closing a queue.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index 86e8046e98c4..4936d92f6339 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -311,6 +311,9 @@ static void io_zcrx_unmap_area(struct io_zcrx_ifq *ifq,
 {
 	int i;
 
+	if (!area)
+		return;
+
 	guard(mutex)(&ifq->pp_lock);
 	if (!area->is_mapped)
 		return;
@@ -438,7 +441,8 @@ static void io_free_rbuf_ring(struct io_zcrx_ifq *ifq)
 static void io_zcrx_free_area(struct io_zcrx_ifq *ifq,
 			      struct io_zcrx_area *area)
 {
-	io_zcrx_unmap_area(ifq, area);
+	if (WARN_ON_ONCE(area->is_mapped))
+		return;
 	io_release_area_mem(&area->mem);
 
 	if (area->mem.account_pages)
@@ -545,8 +549,10 @@ static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 	if (!ret)
 		return 0;
 err:
-	if (area)
+	if (area) {
+		io_zcrx_unmap_area(ifq, area);
 		io_zcrx_free_area(ifq, area);
+	}
 	return ret;
 }
 
@@ -600,11 +606,12 @@ static void io_close_queue(struct io_zcrx_ifq *ifq)
 	}
 
 	if (netdev) {
-		if (ifq->if_rxq != -1) {
-			netdev_lock(netdev);
+		netdev_lock(netdev);
+		if (ifq->if_rxq != -1)
 			netif_mp_close_rxq(netdev, ifq->if_rxq, &p);
-			netdev_unlock(netdev);
-		}
+
+		io_zcrx_unmap_area(ifq, ifq->area);
+		netdev_unlock(netdev);
 		netdev_put(netdev, &netdev_tracker);
 	}
 	ifq->if_rxq = -1;
@@ -1389,8 +1396,7 @@ static void io_pp_uninstall(void *mp_priv, struct netdev_rx_queue *rxq)
 	struct io_zcrx_ifq *ifq = mp_priv;
 
 	io_zcrx_drop_netdev(ifq);
-	if (ifq->area)
-		io_zcrx_unmap_area(ifq, ifq->area);
+	io_zcrx_unmap_area(ifq, ifq->area);
 
 	p->mp_ops = NULL;
 	p->mp_priv = NULL;
-- 
2.54.0


