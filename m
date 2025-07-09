Return-Path: <netdev+bounces-205573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41964AFF51F
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A668C7A95D8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4B723D2AD;
	Wed,  9 Jul 2025 23:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="XkYdVV2n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D742264CF
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 23:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102221; cv=none; b=tB/EhpqhiZOlIR9tWs5lDOfU46hrHMpQdLqBiGV34FDYUXT+Lezqfie/NFq4aEGggGSToXj6iCKkD8QsaKF8tibJN223W/9bsnh+Ghh02IIOVGGalrkO3Hee8FhNF6oVmePglNJAiAM+M1GG9zGs4R8wLawWx0qa+BvuyIjbi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102221; c=relaxed/simple;
	bh=P2TM48kjMxPSr7YwvwYsCNfh+euwlg0K2KRkqviR9cM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rwp6zV1VaMNOokSXGsLLM0QJwlWrpJrqG3KQmoKQ5l00qP5JIEMR3U14pA5FUbCuPnt89DF4ga9lTi7XL1fJcPeZOZwrWduCvLyoE3wKyZZlzjTT8X+u3yyG9ZKXjhwOcmFkm0VVpm3Uow9oF/JAx+yzrPmSeaebmrvSB1/SUGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=XkYdVV2n; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2369da67bacso397205ad.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102219; x=1752707019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=XkYdVV2ndl0iF1gZhqYWBO980A7Ixp6GDuhoto0pHyZDCn3GvKztZFHtx/7uUXCOW8
         /1WE0CU7TC+V8Dt0NQgNNT4LtJj7YJXXYWbVfbBhYqi7D0I6jkhyEiBAvlL1mi2/geVg
         oxXcF9mYI88c44xM8CU08nAMLXz2cwkXT7NdI6gOhaMoyK72a3EO1IgbTB0OvlLtsH+u
         O3hpJqCDSvfdE2YlcKKphCP3KfMDQdW85kKQved1wazBzita3O0T+B/DfUvgdxOdrh1S
         xC1ZbsZFYSPnsjoQl50p68lkY8ZcNZwsLf6XdLU63goqHbbPV3M3s7XKB3Cf+qlG+4Jx
         f/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102219; x=1752707019;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=imTCW/X3yNchRElFuavT2VHyvLPxQFd7uC5iHjhIYP0=;
        b=guuZ3aWj9wd1ajHlePKHqFBcQPDHgnlOTx1yvQ/gCuAhWSTqofaCn8QaPz9AplLpBG
         oMOTEuGFVSx74Fb/MH6ljDJbQBZdXR16PcHsQg5afKGuORBtKQzpmwuKlEOTROjC1Jn0
         iey5XbSdR2fgbclR7r0AXGO/ZBctl4Z+WiWiH5NaoIFPd4Et0abNnV8CVVzWJiQ/6kzC
         S8cTgjo44rylspfek9AIkUTbM20by3JBPn7U7qbTmrJEG+0u85ylmHD/gINfkrzfDCCM
         RGVM1Dc63bwDo7nFHFT1AkSZtKFR9dr9MAgUdK7GHBlX0HCtIawwBNoQwCpzH/A4CeEb
         aCWA==
X-Gm-Message-State: AOJu0Yx2shYVYYWB+Qk8v/pS2z6yc50AaWSJSSjiRaVO4j4eSEihiqkE
	up6uN30gtQoClSb65PaH4TWwcm3zVne26xkR2Qe6vMmkcXxFXEFkBoisa9FP+EVu/h1dDJV7iYT
	iIVvT
X-Gm-Gg: ASbGnctQmbzR+lJOn50X42ijKm7Ay6xnPoIkh65qkVZS0Q+4d9N2GjDjSvz64tHtzwe
	UMwqQUbLDdoVDj9SYyYxDJJGLUgCuea8w25rO2BerxV/DyP1IXCbRPJQ6rruuZXAihzlC0sm4Kp
	RGKMpFA1AC/DliUBzWOOP+d4tDdBJruBI9G5xETIZoJoU6RX2OH4I2nA2kZbJ7w+cCERMYnevpa
	ms8TBtKfrbWV1PXAs2VBa5aTDzD3i3hJfAqhEJ/9G6XPXtTO2fQRLujuHm7EAmM0b0Pbzo0XoJ1
	SAyyC3N417NkRh3Cjcan70ovTO/qY0FfIdBaufbtpNPlmaVhyy8=
X-Google-Smtp-Source: AGHT+IG3VDOjJQ7/ydj4NTL7TeB/TBwJ9CmnRlJ1GQSUfgSW+FxhDDXSpzpQhCpkvcuLT8z4MjdxIA==
X-Received: by 2002:a17:902:c408:b0:236:6f37:8da6 with SMTP id d9443c01a7336-23ddb1a6c60mr26239645ad.5.1752102219017;
        Wed, 09 Jul 2025 16:03:39 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:38 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v5 bpf-next 01/12] bpf: tcp: Make mem flags configurable through bpf_iter_tcp_realloc_batch
Date: Wed,  9 Jul 2025 16:03:21 -0700
Message-ID: <20250709230333.926222-2-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for the next patch which needs to be able to choose either
GFP_USER or GFP_NOWAIT for calls to bpf_iter_tcp_realloc_batch.

Signed-off-by: Jordan Rife <jordan@jrife.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/tcp_ipv4.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 6a14f9e6fef6..2e40af6aff37 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3048,12 +3048,12 @@ static void bpf_iter_tcp_put_batch(struct bpf_tcp_iter_state *iter)
 }
 
 static int bpf_iter_tcp_realloc_batch(struct bpf_tcp_iter_state *iter,
-				      unsigned int new_batch_sz)
+				      unsigned int new_batch_sz, gfp_t flags)
 {
 	struct sock **new_batch;
 
 	new_batch = kvmalloc(sizeof(*new_batch) * new_batch_sz,
-			     GFP_USER | __GFP_NOWARN);
+			     flags | __GFP_NOWARN);
 	if (!new_batch)
 		return -ENOMEM;
 
@@ -3165,7 +3165,8 @@ static struct sock *bpf_iter_tcp_batch(struct seq_file *seq)
 		return sk;
 	}
 
-	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2)) {
+	if (!resized && !bpf_iter_tcp_realloc_batch(iter, expected * 3 / 2,
+						    GFP_USER)) {
 		resized = true;
 		goto again;
 	}
@@ -3596,7 +3597,7 @@ static int bpf_iter_init_tcp(void *priv_data, struct bpf_iter_aux_info *aux)
 	if (err)
 		return err;
 
-	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ);
+	err = bpf_iter_tcp_realloc_batch(iter, INIT_BATCH_SZ, GFP_USER);
 	if (err) {
 		bpf_iter_fini_seq_net(priv_data);
 		return err;
-- 
2.43.0


