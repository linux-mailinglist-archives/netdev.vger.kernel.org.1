Return-Path: <netdev+bounces-226452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E3CBA08F6
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 18:15:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3D0D3A649F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 16:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E427303CBD;
	Thu, 25 Sep 2025 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAURFMnm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA6F3596B
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816896; cv=none; b=IYJDYHE2Hymf3jnoaDtQdDaCJzdhT4za9sp6hr9ytL3IOdqZOPqOLLk77MwMbj9doX32YnHPBkCTe5U/yNeXz5G0W4qJ1CtLPnIzgE7buMuBW1n7Sx+Ms45tYfeNYb0+W6R++pkPwKggsrvDxqtV51Y5vyN17YoTAj2G8hoQVe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816896; c=relaxed/simple;
	bh=EEHslgxhV+3uof7tUSQV6LqlghG3tXhap2F1zIMfbxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpX7QyVAScHKchWfjoUiZ+yI8cweqN1E+w4Z4t6A+qikVaS2GAt6l5vTNRbOybybHg+uaCYG9i9R5rg0F0kqHuK2ljHMXgcLsX0rHEdSwjuIe/A/XYDzZpVq8CmobAh7ianhAAzFOSN46O9vdAed8WVFiy/aVE1tTzUdgIRRTCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAURFMnm; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b54a588ad96so939567a12.1
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758816894; x=1759421694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zu5VyRA42TLq+enKOi2L+NGXj17XBn9sK2pdEIz7rm0=;
        b=KAURFMnmcafVTCUhIut35FTRF61qq5jZlRfiIJSZ2tZpOWB/VyB391V54HDFqRNQNo
         0wWXKWjGJIG6Qd8R1xDLcrA+LT0jYzlifYk+te6Tvb6Gl4BtUwYYagpk27C3LPSXsgIK
         UF9/TjdAVaS9704eNmjDAXpM4Vg4i0E1x5slX3tzOm4rGOAAdt2bN2QquUkOUuho8xY+
         l3O4EVBlT247AwHAHtl3lC5ROs0ZXbTSFAtAH4qgwCKykbXd7/3SIRMtLbrmlV7ldmiD
         eEUhbQ1R5Q3iax4HVdNUB4WB1velegSbdFuhdA3rmG7YifG7dvTc3IlahSQXZdW73+Ck
         +nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816894; x=1759421694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zu5VyRA42TLq+enKOi2L+NGXj17XBn9sK2pdEIz7rm0=;
        b=gcz8zOJcJ6kIZdM9siUdgl5hj1ymhI4TcU4vEmB/61UX7p75mcTdxJivma6vjc0mb5
         3wMhq7fqEy8iCQpHzHC1K+Shg+ZdFRXe5zszWiSvpV/wHsX95WFVJwk1BVcQsfahyFCQ
         T4NE7SbTnNIgNrIvGuuSK8ju1ON/nqwhX6N+OPoEY6SAOh44W02vVsAGyi7TrHyDcGDJ
         ZcopNPZx0lEWpHFi65vb8SxYpZmSGijgZd+dy6J4aPppeQH9IxAOZqvELn1yVQabTPGz
         sqnID5KkXupzBzMv75B+vY+YiZB7FYOretG9CSUtPqW+8GlQSskrZk7qUsnVw8Uo4REd
         etqg==
X-Gm-Message-State: AOJu0YzIHfoGmAa8oN8Yg2EwIfRGd+ZgozcFe+XN70NRmoibIEA9TWsq
	tUYMUIYXuyiykTR0jZFaNbbkduLHiTVE4zc6gh4Wpr9gg+cWx+HgDf2VXH5vew==
X-Gm-Gg: ASbGncvAqMBsj8nhZYkBfVjb+nusJZ168V37KOkzxDS8SbQFJUrkC22u8LLQEeXdUDX
	Hm21LcIfIIKzvRADaUDGNPJRa0pJKo3dUsLY9fuOO6GLvbnoj1S4SfyX+oILliHtovnQuf0ZWp7
	zCe/e+itKdQrjxXGvC8Guz6SRP+pYqfLZ8XROtj6PgezNO7DYvqVr1hv47tB4cD0y+7Y9AP2V9o
	o5l2EWP2zv5x0sEtc8re+GGuczzi8jhmCV9Mw24Vjj4tMMquaBV04HTh2v4ewQtnE70e0+JxttM
	mg+N0eVMCfd+VOnmYQVRthMcE32YdMlqbaKgr89uWttQHUtk2NEvN+e6z7HIb7l7jeqUmO/6Swy
	p15UIWIbdqvUx4Q==
X-Google-Smtp-Source: AGHT+IF1G4EW92h4oYMvNkFLseuKn3GV8PGa6gXiBXkSmVu1nfKJuA3SyrVbXx+SjKggXaVgUlQE8Q==
X-Received: by 2002:a05:6a20:3949:b0:2c3:a04d:288a with SMTP id adf61e73a8af0-2e9abb1c468mr3967119637.24.1758816894039;
        Thu, 25 Sep 2025 09:14:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c26d4sm2347331b3a.37.2025.09.25.09.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:14:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	stfomichev@gmail.com,
	kernel-team@meta.com
Subject: [PATCH net-next 1/1] selftests: drv-net: Reload pkt pointer after calling filter_udphdr
Date: Thu, 25 Sep 2025 09:14:52 -0700
Message-ID: <20250925161452.1290694-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a verification failure. filter_udphdr() calls bpf_xdp_pull_data(),
which will invalidate all pkt pointers. Therefore, all ctx->data loaded
before filter_udphdr() cannot be used. Reload it to prevent verification
errors.

The error may not appear on some compiler versions if they decide to
load ctx->data after filter_udphdr() when it is first used.

Fixes: efec2e55bdef ("selftests: drv-net: Pull data before parsing headers")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/net/lib/xdp_native.bpf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index df4eea5c192b..c368fc045f4b 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -420,7 +420,6 @@ static int xdp_adjst_tail_grow_data(struct xdp_md *ctx, __u16 offset)
 
 static int xdp_adjst_tail(struct xdp_md *ctx, __u16 port)
 {
-	void *data = (void *)(long)ctx->data;
 	struct udphdr *udph = NULL;
 	__s32 *adjust_offset, *val;
 	__u32 key, hdr_len;
@@ -432,7 +431,8 @@ static int xdp_adjst_tail(struct xdp_md *ctx, __u16 port)
 	if (!udph)
 		return XDP_PASS;
 
-	hdr_len = (void *)udph - data + sizeof(struct udphdr);
+	hdr_len = (void *)udph - (void *)(long)ctx->data +
+		  sizeof(struct udphdr);
 	key = XDP_ADJST_OFFSET;
 	adjust_offset = bpf_map_lookup_elem(&map_xdp_setup, &key);
 	if (!adjust_offset)
@@ -572,8 +572,6 @@ static int xdp_adjst_head_grow_data(struct xdp_md *ctx, __u64 hdr_len,
 
 static int xdp_head_adjst(struct xdp_md *ctx, __u16 port)
 {
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
 	struct udphdr *udph_ptr = NULL;
 	__u32 key, size, hdr_len;
 	__s32 *val;
@@ -584,7 +582,8 @@ static int xdp_head_adjst(struct xdp_md *ctx, __u16 port)
 	if (!udph_ptr)
 		return XDP_PASS;
 
-	hdr_len = (void *)udph_ptr - data + sizeof(struct udphdr);
+	hdr_len = (void *)udph_ptr - (void *)(long)ctx->data +
+		  sizeof(struct udphdr);
 
 	key = XDP_ADJST_OFFSET;
 	val = bpf_map_lookup_elem(&map_xdp_setup, &key);
-- 
2.47.3


