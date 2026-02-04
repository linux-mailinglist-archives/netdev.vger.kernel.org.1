Return-Path: <netdev+bounces-256587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJr2NrnegmnfdgMAu9opvQ
	(envelope-from <netdev+bounces-256587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:52:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3A6E21FC
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 06:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FA27300E63C
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 05:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2877B36A00F;
	Wed,  4 Feb 2026 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="plUtXLS0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6260364E81
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770184315; cv=none; b=EsimPrFkrgYd6GMNthmpCIvPU7p6cvrJYd+9SxJQAxA7RBkZLoC9wBc+o+8sUgXA2zwRBxMdI42rceHu6bUTV1HIRWh89PoKaYFYuzpNJBbqY/WiNWuv52Jt5EhysuDMNFCjczCc/byPLssVtPmyI7yjPFJVNsNAJS6S5y4SqK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770184315; c=relaxed/simple;
	bh=vxVPw74y0EjkgH7aonTztv0exKQqGM83o/D92OMTWGM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Flnmv8NVrkxq0WLso4eD4BLwfz1I1+g4Asqkk4+/2/nN37uOFH9WWWIXPXkAQsoK0gazLbMGMsMFjp57GayFpodH/bDLxPgk71b9znZHpC+fldVboC05AaPSVgOjvp5Wau9cziqnhNixYFlqHdz7dEXaW0w7jguFk2VzDEdttz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=plUtXLS0; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8bb9f029f31so2062756285a.2
        for <netdev@vger.kernel.org>; Tue, 03 Feb 2026 21:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770184314; x=1770789114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=x5Mxb3u33CzGK4TA326Kwha86SCyhpkJEXx0nQEKJFA=;
        b=plUtXLS0tPRWmFCWWm02BVjJG3XBtzzwGT7nKoQc8qLjbZjsKKItrk9K0kmQ3ryh4b
         fUny7O0+KXb0PSplXmDPANAVUW+VCbhnGC6T5icVF7BNkaBN/rFdFvkHclB95RnK+eT9
         cHXo+nU6QbCMzKtKq9V05bakvqpwvW0yVjLHRmTPhDMe2fZ/jbYzgN8bEK+JujVPeeZG
         3kwPjesKWPjKgWWGrGDX+KJ5ZS/UMgJInX9ibGdCC9MRaW0zYKQEHR1K12AEGbaW+bz5
         QJxR9c7O9GYjJBHNNvGiEkFgAo/rVPKdqmn+GJzfRHngWnK2FqdIorJdD2QGsTNXkwa4
         B13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770184314; x=1770789114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x5Mxb3u33CzGK4TA326Kwha86SCyhpkJEXx0nQEKJFA=;
        b=SlzY9DO7t/f11nn6f4xEYvjsgBHxRwh9Kn+niaFUn4CiTNNKLw/HN0N/3j5pqhfOvb
         BSwywsQFxCdp0N9vkp0ONB6f2xEsIqaTKp+LTwCPAanUHKE3FovB2qbybChCK8S/qvY2
         oS5t6veMdwzjL0MxJ+TMnNYVfwwX/PZu1ZXmBC/ymStrjLb2q3VCHFtgNqEwFk6A208Q
         V14BtDE7CPGkWyUVw+DNNgTiKJn0FwcTnQvWUaOaGqQ5NjE5uCMvT1OoUISjkoVX4B+M
         xeNCXYKAgpdfHKfNIKHQvC72Jo7Thktxn/tZNmzLVrwVyGnrEKE4cqTmSDQR+/2PSOlC
         7eCg==
X-Forwarded-Encrypted: i=1; AJvYcCXprrZGoqzkOYt7aFZfcO9rX/oWtuFGyaReSp4FJTyp73SwERK+LLzByC/6fRIUa1I4pNqi+s4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYDaHsoVHq1IE1akecywRCG3Bcg2jhuwj9W7RguT5w3Cn2eRtp
	4NbNttF1pghBR3dGA0bd16goYSLeJzcyhEdGBA+QD7wWyyY0A/mTdvJJQrneUk7143S7dJXikxX
	v2rlSM/iR0Wqm2g==
X-Received: from qkpg3.prod.google.com ([2002:a05:620a:2783:b0:8c5:2f45:1544])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:c50:b0:8c7:fdc:e879 with SMTP id af79cd13be357-8ca2f9b72c7mr247961685a.57.1770184313821;
 Tue, 03 Feb 2026 21:51:53 -0800 (PST)
Date: Wed,  4 Feb 2026 05:51:46 +0000
In-Reply-To: <20260204055147.1682705-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260204055147.1682705-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260204055147.1682705-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/4] net: get rid of net/core/request_sock.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256587-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A3A6E21FC
X-Rspamd-Action: no action

After DCCP removal, this file was not needed any more.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/Makefile       |  2 +-
 net/core/request_sock.c | 18 ------------------
 2 files changed, 1 insertion(+), 19 deletions(-)
 delete mode 100644 net/core/request_sock.c

diff --git a/net/core/Makefile b/net/core/Makefile
index d643a5a7fd18bd22ba8f62593f6bf0e99f9ccd2b..dc17c5a61e9a4ab2231bc7ccbd447ed206e449fc 100644
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
index e6c451e549ce4fb316b1afc0b40dff68b66e0a0f..0000000000000000000000000000000000000000
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
2.53.0.rc2.204.g2597b5adb4-goog


