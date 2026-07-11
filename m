Return-Path: <netdev+bounces-306775-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GO/FFbEJUmrSLQMAu9opvQ
	(envelope-from <netdev+bounces-306775-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:15:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5D5740FFE
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:15:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CULqOQOq;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306775-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306775-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 367D4304C045
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:12:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A393859CE;
	Sat, 11 Jul 2026 09:12:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1876384CD1
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:12:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761153; cv=none; b=bzT9vN68MKKhIoEhUtcQxSsKfAedZz89L5Oc4G2U2vjnbfYWf0wumn32P0/JPM4yVremseErxYEzqX2HuXjB/r0XDHE6ffXWwIAmrfMKwgxiEz/9rz0yNhEbRg8F6iFh9jE9VnbIE/32K7nrlKxsW3xOKUyRfPRBtVrutH3cwQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761153; c=relaxed/simple;
	bh=7ymV105ZmGGl8uhZGojt5WY8AiecF8ThAvKoxYEWg6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j917LDHtML5WTea2v6enrU6gGHdxVyAZIW5Mma6bquG3kP83LunDAFtvWA5Pmz7x7pN2ypn0nruKJejN61bQcNW6iVYVHdC72rrWwTZbsNMGrRpSLdDTVlURDAQcec0NjnMcQjNQQ90YsXHwAjvwLqzjmOlShoENVfqjV4Ab67g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CULqOQOq; arc=none smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-698beff7178so3053978a12.3
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761150; x=1784365950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kn8FUFZkw8BUpz/Wxz48LtuZ9xzNk4cNG4d+dWzPPVE=;
        b=CULqOQOqe4kbohz646BQwqDnRl2ZGqBgxO4AvL3TXjxFJZ0hbvE29yA34L0id/1iBA
         zwFdTYLledUqL32m0jGUsHTCzpr/fO/XUEXoMpUsAHqine0/guq88Mpl9Stz9pDfQ0Wx
         HSoQdw6/ZlWMGOaznCwu6ThGQKi8nHqhW4ys6BGLqmeEcpC5L3peEI9hB1B4OWqnX5dy
         f/jchu+KiLS07p2HLkqlKIe77RM5lOwJpbHmsYeQVPRYkDFeSZM8Ab0PtUMC04d6m5r3
         UhYuzt46N7FipdSKcVxxicICzKkRt0c/8uwy/d2FV9RG8ygjTUr1/3YzPZYOCYw6e82s
         PqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761150; x=1784365950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kn8FUFZkw8BUpz/Wxz48LtuZ9xzNk4cNG4d+dWzPPVE=;
        b=VkwiXSIAGDq+zLMW8aHwH7LDNw1NhDu6wEzo4EsvjrHLMQpp9G/Hy4+ChwNjfI7/vE
         LjrAq7wE3kXtwwPpt4RW3MTEREYq8a/FSy0tL+sFglFJiLCYYZoqA7eQseDegqfFziMa
         Q7JLuzPlmOFJdfQbUfe+EzIVu1HDoTCF51BtbXCFecG1MFgJdGNBc6aCZ6q/KUx0DyPH
         V3D8WSGCrTu6hr0V23b8s6Ob1TnmaDp6vW50qZrhh7fpnd3EGvDF+MklcgJq2TWFLBa6
         CztLJ8kVCUL/An+JeYIIKoCz3iMPFOldoHM09Bm5qJTOLRBqGlgovEFQ3wgfLE3daN0O
         8bnA==
X-Forwarded-Encrypted: i=1; AHgh+RrMurhNb8ueoK1xjm+btf3lh9W7tMQ28IygtIKk1nzyBhBGp74abnzqN2i1AM1DbBSEVnTx8rE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAKg1gBXmDm3t/x9hkFkx5HuQFPKu43mY2fiPYMCb2Md8u62+Z
	NNKGzbu4+eKiIXkGKQS++ihbBnWzaz70ptXz3c5ptuvn+uK8sI9KVpUbUqOGHg==
X-Gm-Gg: AfdE7ckHahLosKyU9tCe3czo9U6GW2GU+HUZNEqQcMBjF++ajnSjnGOuSKPoP58J7va
	R1gnI9Aj3kyMk0iouoy19NS2VcCnL9NJnZGzr7tcHB77UEgN3tZ4Ya7rDB0DF9XaI0T41dOEXp3
	PZi0+d0/WArCxEj8ef1dT+iBymfhT4weSwFwaHiKqkjfxC1yrXHyoTlCn4/jJngeO0+SgyFXQAX
	EgYmt+01nfgG1UeoNK0ODEGRBt1gCLtrfYccrZuGrs/jKHzgST17JzbIU8PsiwTCosT9WU93MyO
	K195kzfZyHrGSMMwtjhzaxpM1PIRB1ZnPjrAKswvwR21WrQFUVkRfHrdW+SOvVCd11/yPkQ+a4K
	8/v7krNZD0e6QxrfHcEu9aZ6ffzVk0F7MxEHNIC5mIzWxbw4TPeuCRXsrg/LfI+wXI6xxCjEIVD
	PuSGcmq9oimbxQ5H9kOv6R+lUZjFGsejn+/lrgT/STAoTfxM0ahQPQ+AU4D7MPDYxx3BMIbIEJ0
	Zu8CQ7yBNlcHcNCnoPdp8ZZkMW/EoJhpaQdKEx6kfmJa18=
X-Received: by 2002:a05:6402:1ec6:b0:698:e595:a5c with SMTP id 4fb4d7f45d1cf-69c5f0c7963mr1075220a12.6.1783761145236;
        Sat, 11 Jul 2026 02:12:25 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c60d47188sm681191a12.27.2026.07.11.02.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:12:24 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 06/17] io_uring/zcrx: constify area_reg on import
Date: Sat, 11 Jul 2026 10:11:29 +0100
Message-ID: <a9f68c5d19cba8243062c5eb15afd0eefede6ade.1783616211.git.asml.silence@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306775-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F5D5740FFE

io_import_area() doesn't modify its struct io_uring_zcrx_area_reg
argument, add const to enforce that, it'll make later modifications
easier.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index cb73dca3c1ee..9f21ae61b862 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -136,7 +136,7 @@ static void io_release_dmabuf(struct io_zcrx_mem *mem)
 
 static int io_import_dmabuf(struct io_zcrx_ifq *ifq,
 			    struct io_zcrx_mem *mem,
-			    struct io_uring_zcrx_area_reg *area_reg)
+			    const struct io_uring_zcrx_area_reg *area_reg)
 {
 	unsigned long off = (unsigned long)area_reg->addr;
 	unsigned long len = (unsigned long)area_reg->len;
@@ -208,7 +208,7 @@ static unsigned long io_count_account_pages(struct page **pages, unsigned nr_pag
 
 static int io_import_umem(struct io_zcrx_ifq *ifq,
 			  struct io_zcrx_mem *mem,
-			  struct io_uring_zcrx_area_reg *area_reg)
+			  const struct io_uring_zcrx_area_reg *area_reg)
 {
 	struct page **pages;
 	int nr_pages, ret;
@@ -274,7 +274,7 @@ static void io_release_area_mem(struct io_zcrx_mem *mem)
 
 static int io_import_area(struct io_zcrx_ifq *ifq,
 			  struct io_zcrx_mem *mem,
-			  struct io_uring_zcrx_area_reg *area_reg)
+			  const struct io_uring_zcrx_area_reg *area_reg)
 {
 	int ret;
 
-- 
2.54.0


