Return-Path: <netdev+bounces-277046-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAvzDZrE12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277046-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:24:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCA23CC962
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD54F300D44A
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E80D33DCD91;
	Thu,  9 Apr 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnooKcP8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05FD3DD50F
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747950; cv=none; b=WfNE26ANQ6VNpqxUpnm1rwjjufk5vBJr9WY2aHF8es1ymZtI1pICG+k1bDPhvYi0wXScotNBWfsa8zulAYLaYYaWBCGfKZhnlnigvzRF1XBkrBeHu4l7bT7Xt8xUyArQvzwVNOVuJlRlatBZiyACoM5Mqw3Dx37k/rBBxuNgQEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747950; c=relaxed/simple;
	bh=T/erxDjW9UFZzf7bm2hBpPwN8nVpBgLLyvaiBrM62xU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XAQqafCbOwNxEnI3G/UN86wcxOAnI1cmJWu+/NAxj2hHK0h+HjE4OMu6axmrEhYjIe5ueOKgZUgBR8wQM5c2zRccukO1+YGlIyCFM2aX40aTrX7mlcXXwNFfOg0ExHxIrcbypj2msqHdsvbXJMk5GBhT44/DSGU8eHxwjltm9N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnooKcP8; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-605048a9c94so278617137.0
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775747948; x=1776352748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ht4C6Q0Frr+SWXmDtcQM792Kd3ZqmaPaKjBBDdw6zT0=;
        b=HnooKcP8Jh6f/JkmAkEhuzSmgCeHeKCjUNtCrPAQ7SbYaFC2OgU1Q6Il4hfjnN4ME4
         ht/s4Rw0+2W5Fuf2uKd3O2bF0tl3XDLv0KWvUQLcgKm9++9NxHmgYVMIQtq7C+oP+86J
         oi4e9BYwiErJki7TE/fouAjZLDo70MTCgtuL9jWCWEmoWBcHX79B5IKAZD45+x/y96yX
         ka7gaD9pyaUbxver4bl8TT5QgWzZNnE5YUXW2fK4RD19Nc9Ezt2SzfSE/oUDzvfGJwZn
         xbY5KgX5vhYRPKc9hudluIW/Pvp5s0LogO6fQjmXRJtmYd7yVEMoXPqtMAXBIbRx6vxs
         DDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775747948; x=1776352748;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ht4C6Q0Frr+SWXmDtcQM792Kd3ZqmaPaKjBBDdw6zT0=;
        b=oL5I1X28iio9IVsSoIlfYLFINsVyYrra6MCCfPW0KFSK7BNtGUikgJl4FRgm8VrTOI
         cxSN5prt9fxgFPtKZpa8HEcaQtBCLwkB9hNEMSt3PkhO4S2b++NtPCozYeU1yJzxtZWK
         nWlUFk6YEerOZR1zNkWPi/ac0+x3XpUCvhErZ5gqSEQJj12QSKOkTC1IYlQ+zzvFl9ME
         lljMuV8j3WKvSAYMxtohMn51+bNjVsSh4e5fOolz33EBUFsWrgvCnrPwjxdFqvZNHkAB
         7VLwSgFIkjWScBtkoWpCa5DRAbW7I6tG0cotYwfQGdNOfdyVwSzznZaPYPxddZqtnawg
         OvYA==
X-Gm-Message-State: AOJu0YykyGHrn7Fo4dGdF1Uo8udRXsNUDy+gGxuPL9fu4id6FgWyIt2O
	bx+RXco7EaNfcpuGIsPR/r4Z4d0eful9JJTguXaANBUsYlspsYN5p/fALWNbszZCEUyV7A==
X-Gm-Gg: AeBDieu5cjwCrysWrSVpl3nptjN55p3rOCNE/SSsbopaXhiiCEKbTJ4CJUqcQ7zGWZx
	D8mZJBHrgr3e73ZPlIDSKuF+BSC3bxMB1oNBqUeoSlNb+/FvJuxxIpAN6w8Z6hXoBSB23P84NLP
	GWhALv8yY7+CVmEDke7IF6c1VzsDQ1RvTARzHYEGhP+M07WECRXZ1n8jbRiBXiYr/sWcqZ+LOU2
	30iCsGeXvtZWAUxIDuXxoI+ZKT7YfAIT5oCbwAe7Aktw10WaE/zxNGooAq00uCBKuLwyR3V0T82
	cTHHWksoTTfVA8Mo6g3umKFE6QHbmThUXOVqCRnH2jysWSUf+opEYPPJCSpkJxh/w+NSg2oaHiK
	Y1r2BAaKU6Td54dJCnH4QCX+2nE0bTlj09GiFMLK5iAzLIiKLp4J42vcNcXPoYHfuWWjBoPKaPn
	MK7/g0qIqJvLZe62m0lOGVMSfdN0atvBmXmd3oRRfyOznF2lkmsbh3SWx5nadis7fOD/x2lKTDm
	R7MXgXKmF1jNt8tr4P+kzmcK6BOaa+OL3BCAFI=
X-Received: by 2002:a67:e113:0:b0:5f5:4d9b:bd67 with SMTP id ada2fe7eead31-605a4e20b60mr8913640137.6.1775747948440;
        Thu, 09 Apr 2026 08:19:08 -0700 (PDT)
Received: from TDC4045031631.e0cglfehwr0e5gttmepj3hi3hf.ux.internal.cloudapp.net ([20.63.37.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8a5969156d3sm202318526d6.31.2026.04.09.08.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:19:08 -0700 (PDT)
From: Ashutosh Desai <ashutoshdesai993@gmail.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	linux-hams@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	Ashutosh Desai <ashutoshdesai993@gmail.com>
Subject: [PATCH v2] rose: fix OOB reads on short CLEAR REQUEST frames.
Date: Thu,  9 Apr 2026 15:19:06 +0000
Message-Id: <20260409151906.2218957-1-ashutoshdesai993@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CANn89iK7bzV0VpPsP5nu0mV3GCsN5MOZJgc_s8a3B2X6Ui6mxg@mail.gmail.com>
References: <CANn89iK7bzV0VpPsP5nu0mV3GCsN5MOZJgc_s8a3B2X6Ui6mxg@mail.gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-277046-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ashutoshdesai993@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8BCA23CC962
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

rose_process_rx_frame() passes skb directly to rose_decode(), which
reads skb->data[2] without any prior length check. For CLEAR REQUEST
frames the state machines then read skb->data[3] and skb->data[4] as
the cause and diagnostic bytes.

The original fix checked skb->len after the rose_decode() call, which
was wrong for two reasons: rose_decode() already accessed skb->data[2]
before the check ran, and skb->len counts bytes across non-linear
fragments while skb->data only covers the linear head - so even a
passing len check doesn't guarantee the bytes are safe to read directly.

Eric Dumazet pointed out that pskb_may_pull() is the right approach
here. Add a pskb_may_pull(skb, 3) check before rose_decode() to cover
its frame[2] access, and a pskb_may_pull(skb, 5) check afterwards for
the CLEAR REQUEST path to cover the cause and diagnostic reads.

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
---
 net/rose/rose_in.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/rose/rose_in.c b/net/rose/rose_in.c
index 0276b393f..b9f01a11e 100644
--- a/net/rose/rose_in.c
+++ b/net/rose/rose_in.c
@@ -269,8 +269,18 @@ int rose_process_rx_frame(struct sock *sk, struct sk_buff *skb)
 	if (rose->state == ROSE_STATE_0)
 		return 0;
 
+	if (!pskb_may_pull(skb, 3)) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	frametype = rose_decode(skb, &ns, &nr, &q, &d, &m);
 
+	if (frametype == ROSE_CLEAR_REQUEST && !pskb_may_pull(skb, 5)) {
+		kfree_skb(skb);
+		return 0;
+	}
+
 	switch (rose->state) {
 	case ROSE_STATE_1:
 		queued = rose_state1_machine(sk, skb, frametype);
-- 
2.34.1


