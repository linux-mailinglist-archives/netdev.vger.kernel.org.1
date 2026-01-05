Return-Path: <netdev+bounces-247122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C591CF4CE5
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F2EC31F8AF1
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87690335571;
	Mon,  5 Jan 2026 16:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAT9gPRS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Aikw7r01"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D42D3009CB
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 16:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630551; cv=none; b=dgpq9jqohd8bfTrubr5mEt4WRFuvLu7sWJYe/jRyE/AojAAHqwja0UZVb5kAMXc/rQm9q007riH94+pBFQZYgxAyaZUyyo+vdVP2l+FeVs8fBpXmhfNj7aIwpkkllUrxhyNcdAjWPuCqzAwamrAfBS2qWgLrcDtOgABVp1R8+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630551; c=relaxed/simple;
	bh=6v7ICEfyWETimbEhiE9gWlM7y+5+qK+6EUDmzBwo/ko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImHTb/Ra7KtjVDwQdz9kNaf5Hq1tiI1hbZxpnkP6FZWlK6DryhV13a+HwCncFtAUiZ5CZtpqyZUiV69k+XgDiMFq3APDCVu7DVrYFfqFN9FePFtSq8AYdcMXN9bn2XnzKVAxXWHR7/FwgSOSt9XkEi+YOa4wKilNW/0VT35c9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAT9gPRS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Aikw7r01; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767630548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jsAc/bONA9tdp1k/CuShXKoLCToI+eJCXlXPyUDtek8=;
	b=SAT9gPRSvfUYrvK9+wFIvuy7VHkkV4ViJoIDREZM09OuPEu5bkAzFcrPFVgPrYgktoDFfm
	HgVSblvzicbPN/O//jtovR7kvmq754V44z+dhv3wVqSqWkABWvyElnaAx5RjCxwFpdmkZv
	+m0Gr8Sxy7EOvcW+65Hs22YCKRYhvfI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-xKLQH7-kPLWY3yM19AfsUQ-1; Mon, 05 Jan 2026 11:29:07 -0500
X-MC-Unique: xKLQH7-kPLWY3yM19AfsUQ-1
X-Mimecast-MFC-AGG-ID: xKLQH7-kPLWY3yM19AfsUQ_1767630546
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-64d589a5799so109553a12.1
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 08:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767630545; x=1768235345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsAc/bONA9tdp1k/CuShXKoLCToI+eJCXlXPyUDtek8=;
        b=Aikw7r01H/pun5/7iZIs06gai6ENO62ycChLCRUOkoyHo7rKap6RH1oqLlmdUbUE+b
         XrMqfpfGKKxatqPPVRewam5tdyzWul7CAh8X5KwJ1fMEUV2MxuvbSTDWS6vmLPCEewFE
         iM+mhkHlsddOu7BU9dAVENpOtlzM1nOZKDP0JPa6rTQM3S7ML6gM4qmbckA0d2O62tlr
         0c8mG6CjD1p+rCm152+3eAB1FJGz4nIcrVJV1uFBr8fKrXWZV+HLTiktyLj569ISOb0+
         AIs5FGEerjNo+kJEW3Cyy9R/3FBiQ6g0flW+vE2cdYEdkaocAbOGzlH1v7Vc8AVJWw7I
         rLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767630545; x=1768235345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jsAc/bONA9tdp1k/CuShXKoLCToI+eJCXlXPyUDtek8=;
        b=gsyn9eKs7Aj1sJzld7BUeLSxgiAggGoE6NNzITvkah0lcaYwxhPJa25r2CVf8r2xsN
         s+jd4OCx6cVlEnpNryQzN0wpYhVw4EShZdFv8rYGUHex9/+2GqxRu7TxHD3+qLQxfPqt
         5+zxqYEDXhKsNKy/Ieh5vcYqBq5Yrl4FKV5fCc5HZR0lnlWtAgZEpN8IOPD2gKKViAS7
         JzFtyvllnJZ6KsY5SiPZ9xxT1EaVkB+2Emvmlxn3dpoYL1G2sosag0nBVkK+jYPRTV4V
         cLo8pxEsybq8sxx3x+r2gatBWu5FvlgbYwLCUswtrSIEZDEFMy2P6GmSeO4c7j4+eD7x
         UAFQ==
X-Gm-Message-State: AOJu0YyOVUQRe5S1EmPr5ssedeyw7GL+f/0nRDFDWU1CgySChUlgKfFR
	A+IBt+XtNzzpmemUBttYIha/kf8/ZIbUOHSDJ+fKGc/QMhRj4+aHNTt4OVFb50jRg3HF4BwTjDc
	cAfU5BtMtBEiaxqHY0dIxVv7uFt19ENROdZp0z9ELYWchh/idCcVmi8kGIMlArwPGQw==
X-Gm-Gg: AY/fxX5ug0amvKMQCvKB9ItDxcLbm5LxE8L4Vz0NyI40f277JErt6MoSeBl9Mt1glCQ
	g9Jmm4mbpN7zqo/xXTwTPP3OTAmj4X12+Lycj8nDh6qmrbx3/eHFId+bbWeIEgXhLm5V75/tzoT
	oWVSdXQJwtTS/ED4YuY3soIFzy6OSClRAjSs8L4X+aGwfnn+Kyd74OJMPzuTemWHz6sbkW+m/GI
	4vTuSoq1mMaMeFoXjOe55/GUN5TOlimZj1JDCkw8XbwVdmNWmks3BJ2M1rS+HOM61dGqQqfCguD
	Obnw8ZuutQ5KgpQKicuFZKQM4IokjHDOxz+0Z6cKEqSc0Zf3+VlxNGPGQ7lmfWAlfbcwBF7fAqt
	0FepxwMMu7Gemx5fFxLz6+0lH8mQrUEab8jAv
X-Received: by 2002:a05:6402:51cc:b0:64b:a1e6:8018 with SMTP id 4fb4d7f45d1cf-64ba1e6832dmr44826989a12.31.1767630545517;
        Mon, 05 Jan 2026 08:29:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyWAHn+JH/ToqBN6Ej9qPP35zTq9YRIX4kwt0d0LzrOTUSBmtnvxix2yQKZOXfle5+4gztPA==
X-Received: by 2002:a05:6402:51cc:b0:64b:a1e6:8018 with SMTP id 4fb4d7f45d1cf-64ba1e6832dmr44826973a12.31.1767630545081;
        Mon, 05 Jan 2026 08:29:05 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-650762a13efsm172976a12.31.2026.01.05.08.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 08:29:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 42CE3407ED9; Mon, 05 Jan 2026 17:29:03 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH iproute2 2/2] tc: cake: add cake_mq support
Date: Mon,  5 Jan 2026 17:29:02 +0100
Message-ID: <20260105162902.1432940-2-toke@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
References: <20260105-mq-cake-sub-qdisc-v5-0-8a99b9db05e6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jonas Köppeler <j.koeppeler@tu-berlin.de>

This adds support for the cake_mq variant of sch_cake to tc.

Signed-off-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tc/q_cake.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tc/q_cake.c b/tc/q_cake.c
index e2b8de55e5a2..250cc8b60147 100644
--- a/tc/q_cake.c
+++ b/tc/q_cake.c
@@ -667,6 +667,11 @@ static int cake_print_xstats(const struct qdisc_util *qu, FILE *f,
 			   " /%8u\n", GET_STAT_U32(MAX_ADJLEN));
 	}
 
+	if (st[TCA_CAKE_STATS_ACTIVE_QUEUES])
+		print_uint(PRINT_ANY, "active_queues",
+			   " active queues: %25u\n",
+			   GET_STAT_U32(ACTIVE_QUEUES));
+
 	if (st[TCA_CAKE_STATS_AVG_NETOFF])
 		print_uint(PRINT_ANY, "avg_hdr_offset",
 			   " average network hdr offset: %12u\n\n",
@@ -827,3 +832,10 @@ struct qdisc_util cake_qdisc_util = {
 	.print_qopt	= cake_print_opt,
 	.print_xstats	= cake_print_xstats,
 };
+
+struct qdisc_util cake_mq_qdisc_util = {
+	.id		= "cake_mq",
+	.parse_qopt	= cake_parse_opt,
+	.print_qopt	= cake_print_opt,
+	.print_xstats	= cake_print_xstats,
+};
-- 
2.52.0


