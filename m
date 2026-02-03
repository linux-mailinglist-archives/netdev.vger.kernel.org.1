Return-Path: <netdev+bounces-256125-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oMq/FkmGgWmzGwMAu9opvQ
	(envelope-from <netdev+bounces-256125-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:23:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABFCED49CC
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 06:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BBDB3077BB3
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 05:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8D366058;
	Tue,  3 Feb 2026 05:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3ebY4Hw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1CC36605E
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 05:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770096138; cv=none; b=WYI5eJ/HHMDMheZcWyzIZKCmdHNviCUSsJfDBxm2svxQPDeNepCXgOWbq20PkWY/0USxwsT4qADUZwp0UOMkaFln9ajNrrq/4qB7QpLczu8Tl7j/Mg/ZyJXRAIu3x35z9bx/nfCTSZ1aEt+yns1CSmIYiNIKHemiPRz0eM2egnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770096138; c=relaxed/simple;
	bh=hl2HmiOOaSYGqIX+kAKga88D8+ScQRfufaprRm4PW8g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=klIKxHgm/GqUaVvx0JOI1ZoBrAfBwe8A5Jhnst7tEUSvg8F+9WKIPIIrc2S+7rNl0xJ8T2NeVKusSbdkSELYEynMayw/aZXD1vP/aw1cXMrRGmGb+QZH8pR7rlvTmEekYeh18TofS4O4KUv5Y34gTnrBNfOoh+m9XTjfd3t44+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t3ebY4Hw; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-503915b0a88so136044531cf.1
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 21:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770096136; x=1770700936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=XsT9iRhns3gNiAj7IwTQTZuJnPUsgc4dbSiD7QKDP6E=;
        b=t3ebY4Hwc1/+iuIbgoNA91jDT9fDiEYc4/vAGf+4kOHwtQE8jpWsBUw6porTIrImY9
         YSwuHBLAPMQpU7QMVfQCzr7njaDJPEFMMBv/pYAj1kI5c//HPCDLtywjtavFqVmt3K2V
         jnDAQWaltyZWj/h852wOtPg1LQDK3+vwMD9qjxvn6FHD7tl6CH8y6tEX+s+RdGO9f2Eh
         tssO0c5fqkFZ/3YbCCx2agU9Sw6PieblhiWWOZgAjRZOOEPrP30cS5bBsyUgNHk1CX4d
         X3wFT/SBZQrQr+R7VG1eTX09Bv62FvbomuSk6gt42p7e3grDa25Duo9Ahrh2hSqKR6KB
         t9tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770096136; x=1770700936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XsT9iRhns3gNiAj7IwTQTZuJnPUsgc4dbSiD7QKDP6E=;
        b=FVJ9wInS2Ki3Xiwr0xeCeGizLR3XT2ub/XgpTOlrVRjgWHCuqjm1RwJsd2hv3XFd0a
         UpFua4bj6tpJh+vl5vAqO8IcFG7FB5lJu2a9D6yPt9sKy/FYqBExB9BqZnhHBpFurfIh
         sUqeTa+8F+vd/S4qwXqvEmVUMcdvjkOsSCH/dptkwjYaW6PxeaXy2wRt8uXbJ5YCnlt6
         Bi+J+29cwLitFJEcNtiE3+TmxqjTJEkF2Lu7s01VcSEeQoDOTx/taKECvN6bajetFADM
         Oanz5tT5Xdvw/U6Yj3bSiwvZrXnWXr3be9ellp1eS5o9HtvO3j8ag7XQhG/cPvlj7YP5
         8pRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWCbB4ModcoTYq/aUhU8/lUApgpYzc82UQUklftvLRm6UXy95smdl/VxvMvSTB2+OywhjU4GWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkBRXipjOe7LZU9GtrXQqxdlOQpbwI64ZPa+DrUdIme32G1v85
	1y1n2aDRTMyd8opjGQI4ex+d9ArcpWM8xF759L87WK/7QbIYfbgo2PV/krOohFfCQdXvZMdZjs/
	+g1CJLdfvEuQNOg==
X-Received: from qtcs28.prod.google.com ([2002:a05:622a:1a9c:b0:503:3485:315e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:ca:b0:4ed:b441:d866 with SMTP id d75a77b69052e-505d22ac1d6mr193938151cf.65.1770096136006;
 Mon, 02 Feb 2026 21:22:16 -0800 (PST)
Date: Tue,  3 Feb 2026 05:22:09 +0000
In-Reply-To: <20260203052210.3684125-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260203052210.3684125-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc1.225.gd81095ad13-goog
Message-ID: <20260203052210.3684125-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/4] net: get rid of net/core/request_sock.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256125-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,conectiva.com.br:email]
X-Rspamd-Queue-Id: ABFCED49CC
X-Rspamd-Action: no action

After DCCP removal, this file was not needed any more.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/Makefile       |  2 +-
 net/core/request_sock.c | 18 ------------------
 2 files changed, 1 insertion(+), 19 deletions(-)
 delete mode 100644 net/core/request_sock.c

diff --git a/net/core/Makefile b/net/core/Makefile
index d643a5a7fd18..dc17c5a61e9a 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -3,7 +3,7 @@
 # Makefile for the Linux networking core.
 #
 
-obj-y := sock.o request_sock.o skbuff.o datagram.o stream.o scm.o \
+obj-y := sock.o skbuff.o datagram.o stream.o scm.o \
 	 gen_stats.o gen_estimator.o net_namespace.o secure_seq.o \
 	 flow_dissector.o
 
diff --git a/net/core/request_sock.c b/net/core/request_sock.c
deleted file mode 100644
index e6c451e549ce..000000000000
--- a/net/core/request_sock.c
+++ /dev/null
@@ -1,18 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * NET		Generic infrastructure for Network protocols.
- *
- * Authors:	Arnaldo Carvalho de Melo <acme@conectiva.com.br>
- *
- * 		From code originally in include/net/tcp.h
- */
-
-#include <linux/module.h>
-#include <linux/random.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/tcp.h>
-#include <linux/vmalloc.h>
-
-#include <net/request_sock.h>
-
-- 
2.53.0.rc1.225.gd81095ad13-goog


