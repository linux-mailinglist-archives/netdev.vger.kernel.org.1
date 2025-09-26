Return-Path: <netdev+bounces-226746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258DDBA4B01
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 18:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B91D1C201B7
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 16:42:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C662FFFB9;
	Fri, 26 Sep 2025 16:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKuOSBgz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F24F2FFF97
	for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 16:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904906; cv=none; b=KqKY2zC06g5er90oAOzcRUR6MlY0U3pp/8s4pL3BgoplQEn3PM9NCNygOf0m5d1DYhpv7EMu3b9dSWZ9trmqT0ksF4YpN5P2iMvfXsOuhSHqkUnBvobUY5UST7CfLBrtmnZjyspCo/v83Gez9/zhEKWMy2gDErCjqTHwnnceLSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904906; c=relaxed/simple;
	bh=qyqX7t2D2AFwHTZ3eL7TWaKzkEfQ2PGisj1lvLkzWhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nen/OZBIO3UJgq4x/k7Yv0Kgvt/POMLBKMOk4NMieqIyjGhE34hKw2gyaqQUV6vUTiqLEbApfY3AXSO6wzddP/atbtdjGNXnhViCmgj62JDTvDhvJ91ftpo3t6UdPnQAM5QB6pQQb3alJkVO3HM9dGpDy6YuOk4fYcLELedYSbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKuOSBgz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781251eec51so94896b3a.3
        for <netdev@vger.kernel.org>; Fri, 26 Sep 2025 09:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758904904; x=1759509704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UNJOhq8VwuyFG50xZ7ZJPwq5CFAtDgJOVKFow8+S4rY=;
        b=fKuOSBgz42HeS5XEb3UdhDyMtDBqkKeiwrYp17fjpAVb36vVr3NZuwLdZWTceI/T6W
         KdQ7zIcdZxYgEe01gzLFjZwaxkZNifWo0Q3tWN/2Ec/B961PUJDm4IUEo2faDq12XmKN
         MWaN/wK0clrcpJghUvu7lq6tH0stpdj3UfnjZYlII8Pe/EbQoKqueaatNpcgLVhwz1zU
         qXTZmwJYreIUT9+iHKtULxL334/6FCvi6EGyYrWY38VQav+Nv0qQ71FZ+9TcUAAQoheP
         MXHH5nqtVHzhWx1QQXIxS4xeal1lbXNgrU0F96/M3H/8iz5Nf7HUAgjSPhX/n7WDaJBA
         dw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758904904; x=1759509704;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UNJOhq8VwuyFG50xZ7ZJPwq5CFAtDgJOVKFow8+S4rY=;
        b=Fu/Nq/rZL73XkfSny2TTvqJp4faF3UBwpL1Uoq7peDRFEoVHfeXp6ZCNW7oXMRKRk7
         Q/gBXkXuPtADiFxFeRyWquhCJ8RIYAf4qm6oSO6+6ql2Ul7d9Gmwmxi2hGydkpF/kueS
         S/2hwHiWzhUdpPAss0o736svOwfMS6Og1A80utgvMKzD7xKA46E0pl9MXA0xc/AK5uwb
         LbCJDmJe6QuwwxGyCUNPkthFykcdrhOt48laVukIb4mAXf36/BwFM+qJIX6y/d0Le+I/
         UjIwiixLP09meWOc+0ycgOMAXXkcSdWjNYrhjh6G1xvuhjB0GkKPa55CCm0+J8Fscbeg
         BOIw==
X-Gm-Message-State: AOJu0Yzp824SnD8Y4f7+6Wv1jL2NFYOBdejivf7JMKv6XXoUmGtlShtP
	E1R6aqPt3xD7rvT17LOSKbu31uLot4Jv/8cev1DffAs2LJc48Ax3+beB
X-Gm-Gg: ASbGncs4JDBGaHuTD+pb7DNhEHmkgDLOobTqF27sIByb++zLyRA4Aac7O4Z4roBpVZo
	8IN5kFk7v6sxycYLU6Mhnm4Xf+XpLYicds60oW/pzrFxL1KPPcFw3zlUaWDX/peh/hQirZKJ4um
	P+4R2hzn3PwewOTvDq6IiCWRyBGT0+PfXU8hfdmFpbW0XOiIdX5GkoIfxRiU0JcDLVF5PH+qifQ
	zYp1CEjNBdEu4LiHN9b171xfMggLXkayHdxOoX2WzJGd9WCx3nfVoVG8q8h5G3THxvqMMJspKGl
	S0s6AlGKQaZe7Nq6z0TDH+Us3Ha9iFYSuwwlL3DbWgHJ6A4A7RR4TCUSbUvwvcnCs1Iaj7Z1hoj
	8VQC5owHWk/YtkvonNj+ivzdN3qraxh+aXqA=
X-Google-Smtp-Source: AGHT+IEww0vtp8h9B9Mv9EQJ9duDPa9TOq2QShBdNfIFoOYK4H3EiTt/JKWMlUxAzRagqBnQQC3NJA==
X-Received: by 2002:a05:6a00:218c:b0:781:1f6c:1c59 with SMTP id d2e1a72fcca58-7811f6c1e7cmr1889760b3a.26.1758904903796;
        Fri, 26 Sep 2025 09:41:43 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238cab8sm4860221b3a.2.2025.09.26.09.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:41:43 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 1/1] selftests/bpf: Test changing packet data from kfunc
Date: Fri, 26 Sep 2025 09:41:42 -0700
Message-ID: <20250926164142.1850176-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_xdp_pull_data() is the first kfunc that changes packet data. Make
sure the verifier clear all packet pointers after calling packet data
changing kfunc.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_sock.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_sock.c b/tools/testing/selftests/bpf/progs/verifier_sock.c
index b4d31f10a976..2b4610b53382 100644
--- a/tools/testing/selftests/bpf/progs/verifier_sock.c
+++ b/tools/testing/selftests/bpf/progs/verifier_sock.c
@@ -1096,6 +1096,20 @@ int invalidate_xdp_pkt_pointers_from_global_func(struct xdp_md *x)
 	return XDP_PASS;
 }
 
+/* XDP packet changing kfunc calls invalidate packet pointers */
+SEC("xdp")
+__failure __msg("invalid mem access")
+int invalidate_xdp_pkt_pointers(struct xdp_md *x)
+{
+	int *p = (void *)(long)x->data;
+
+	if ((void *)(p + 1) > (void *)(long)x->data_end)
+		return XDP_DROP;
+	bpf_xdp_pull_data(x, 0);
+	*p = 42; /* this is unsafe */
+	return XDP_PASS;
+}
+
 __noinline
 int tail_call(struct __sk_buff *sk)
 {
-- 
2.47.3


