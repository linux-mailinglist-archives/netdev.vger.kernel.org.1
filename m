Return-Path: <netdev+bounces-306809-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nB0oMfEdUmqiMAMAu9opvQ
	(envelope-from <netdev+bounces-306809-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:41:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6839874143F
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 12:41:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gptpNEyh;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306809-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-306809-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 043AB3042C4A
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 10:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14833BB9E3;
	Sat, 11 Jul 2026 10:40:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4913BB684
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 10:40:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783766448; cv=none; b=EpcPUZdiVNnmzQXI2xv3na9/Tr1KfI0eUlEpRLGJhq+MmUZig6clDdIoFkHbgM0V0RUtoHTEcjYuT/xm86xD3vpw39eL9mdmG8m7bYGPuPtwoJ5cgj5elRoNQe1aH4Ie/uuTu9YMMc4lhFNFnU7nr9688GcCsgqOaQ+nqWkrh5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783766448; c=relaxed/simple;
	bh=7ymV105ZmGGl8uhZGojt5WY8AiecF8ThAvKoxYEWg6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJFO482iLla52d8GZLsdc+scWOkPGxvE3ecr3XLVXPMlXPfTTV5FVoJp3EuTJBrFyQKIBAFsoEAJahlUdyfaoBDE16QsIfgL0REQqbbmMv3dsM82zhkc/m5smC2Rfbwk02tdHvLwIHortENyHf1gUclNGqVcxObRLCpWGsMV0vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gptpNEyh; arc=none smtp.client-ip=209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15e3141d02so203275866b.2
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 03:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783766446; x=1784371246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kn8FUFZkw8BUpz/Wxz48LtuZ9xzNk4cNG4d+dWzPPVE=;
        b=gptpNEyhE+uGgbJe6OxjGk6EO3+PgRCCd08/RescpF8E2LB6Qw3iOkjoD+O08PxOHp
         mqd6iBmhSPXAPvq0noIhtLRhwiMjTBZKfNiJxxTJiANcfworgkxqCmU6Bqpt2B9pFSr8
         fUKX/foiiM2ObHICUlvcrLV3l33AgpekYOuq2pCKnRu4USl2CMNgv/BvTrkI6Of6aO5c
         nGk5o2jsuitmFzPdcO93JqhtXkZDs2Dm7ID0d7vxJW1D7W4XL9qTs57Ajn/YdGuqNEmj
         HP/m1pvPsteFUa2j9Hb7wIp/OLAyc705lyUjfNhg4HP2+KQTwLpw9U5WXiqjy7xKm2gP
         b+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783766446; x=1784371246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kn8FUFZkw8BUpz/Wxz48LtuZ9xzNk4cNG4d+dWzPPVE=;
        b=EnPRKBmQdQy52Ed8aHo2DDOhSDtreCca0xJ7eMjWgjD0gwFSOW7xh7Saee4b0FZzyA
         1FuGghowEtO16MYhOIthlvYxvTBWzMJU34VIEJAhCHUbt1ffcDvCeLeGN9N15MKyOFiu
         Nh3OKTh+2Dgdhd/MzSSeCor1/WlyHcoWQ3uNKtb/M5qG8hlN9FroD7kvVmCyXiFuCY/c
         IMBZLNDgoZGE6PIlMUQzBPWjhAPlsOfXlNV3Mx9JAYlXg8wSNc0EnPDNHW7N4mPzjVxU
         WZ7JPG4lj0ymMFE97XIHXy7f/ua11Rs42IoyPLRgGW41mfTbJQh3OFSPAEwfxeVkVWWe
         dWSg==
X-Forwarded-Encrypted: i=1; AHgh+Rp6VLmdQyMOIFSM5gRP4I+vBsfVRFtzTx49jvDT7WE2xWOSm8OJDM8cIeWxYoCu4HCU5ZVWnB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4hSlDqE/eK/P5GTTWT0de6JLj2wmUe3BOYapqUSMKysfRyogZ
	p0+eDqCVmQgtune2KXn7AZmy9/tcCuMRFvSxwpx16TSJlpZK0XBSMq82
X-Gm-Gg: AfdE7cnImgQyA8dicZRpqG4f+jqDvqm3iE+ndDdWZ/f3DOis0dWLYYiVjJsmzSGrPBR
	tbVVszbTsiyRpvR0GtNjgVQmipM45NmQIRsSEXn18vaIyf9vqCoE3UYNYjeCZQnEN7mK/NF5Tdu
	X7Ex2MpA9HhVJU3TBABq2kIvW+An5C7L786A9q02Lxs58pOwm/7bw0WI/76to6BGYlTMgy/TOcx
	8FII7LqsQ3V8FZ70VhZ/ACXv7fsMB7o0+fWlb/EFMMlxLKGUswo1bPCC63fI3FhIa2PJLzAhOqu
	jG6PnjEZYduXtAyEue0iVSkv1FVmLesMTrJS9vkMzRO2naAYC6/r+P+hkx+igdzcCR70dgkSFhk
	gGsDvRiUknR48tSrH+Ihi4GliIax5D2dM783nsPSIXgKEOV+HqLZdd5zIkQk/oHyGbdMpgVpitx
	xZRZi3X19ozYb0A2m/ekUmou0crS2qve2yFEsUbCZFOqeAX+kBzDdR85bzHXl6dna4luITGSZ3J
	dxt1lIrbbek5myVp/r339YnUawd+54GSkYQTvRayzBoiWa6N4wi/gtxP1q3
X-Received: by 2002:a17:906:2a09:b0:c12:a5fb:ff22 with SMTP id a640c23a62f3a-c161f442fcdmr64377966b.50.1783766445969;
        Sat, 11 Jul 2026 03:40:45 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-222-132.dab.02.net. [82.132.222.132])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15d5de95e6sm483041566b.39.2026.07.11.03.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 03:40:44 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 06/17] io_uring/zcrx: constify area_reg on import
Date: Sat, 11 Jul 2026 11:39:59 +0100
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306809-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6839874143F

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


