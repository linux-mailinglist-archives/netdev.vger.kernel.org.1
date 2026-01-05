Return-Path: <netdev+bounces-246997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D009FCF3571
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 12:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6FDEC3015122
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 11:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4990E333441;
	Mon,  5 Jan 2026 11:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CBtImg1N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uq/gqoWu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4C31987E
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 11:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767613682; cv=none; b=Qzls/HoqHustUnmGCX6FzB9aFf3mDuELGO94AIQSr08c8nT0ExyFuDKk8hlpeUmxpG4erFfWy3mGymLS6+RGED8hTTx3U9WT6yoG3llQo4qwz5hhyoIDw0ltaaLrmiLlCOCc4AUshaSwj1NhILoBdfbeOS0kQ+CPzoctUvcPBY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767613682; c=relaxed/simple;
	bh=sZVZYXKGi6x0/cNomEW7NL3LhpGZjdik2+xI/ZdAt6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0qFbg5X2fMkAOSVH2s+ih+mgZCD2qqY3P7cXJe/3X2CyGdYogI4ReLrq1Qzb6gjbF+eFzVKuifvmLgtcl2Vk+lQBLaDDIutEbyzNdqp3Y/lpyr9hAxtyyYw5dwBLw2buRHdWPca6yjatI9k+HkHdY/p2iq/k+l3Y5RMMPN2O+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CBtImg1N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Uq/gqoWu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767613678;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4yVc7Fv6KTjwK4Gtk6iZcVFGv62TYxn7ujD99PvmsPk=;
	b=CBtImg1N9b7D0gq4DcCK7I03eHnJ//kp4F4hkeRadWwoB2JCyBLZ+J0z/tAaxg2263MY3N
	zFPg/gj0ibTUSWbF6AQnr6YN8bHylBr1Gta6nsSZ0sntoBmFYb9Paw9i5XmrVMKquBb0ll
	2Nrb1JDmoCG2WkpW4Z1VBlPB1mYD8ic=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-Q-5YMvvuML6_CsU-ubWolg-1; Mon, 05 Jan 2026 06:47:56 -0500
X-MC-Unique: Q-5YMvvuML6_CsU-ubWolg-1
X-Mimecast-MFC-AGG-ID: Q-5YMvvuML6_CsU-ubWolg_1767613675
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b73599315adso1087413366b.2
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 03:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767613675; x=1768218475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4yVc7Fv6KTjwK4Gtk6iZcVFGv62TYxn7ujD99PvmsPk=;
        b=Uq/gqoWu5sz0+kM0gQ2AKZLImyqocLSMwvGdj01wCLkxw7mUBET96VM7Xuevdj0Apg
         QwzB6o/e2vBtebblp4Gcnb/A9dw2Al37TselWVwaTp6SpIXh7gib4fagZBbhf/lWpzua
         GyjbPzT5V0E9OP4qIf0Vh7ofiPMceSfCl9NLnNsWY/UmChgMqZQML1N/o0PhSmJMW3vn
         ZlUnRPMmOjRwsrEwweaPJ+Fkof8HhAENLpppyLcD5sirU6vlyxmYoYpNfEFljHC3aLhq
         b8Jz7uoS0I2jRwQhk5oXWfIXkK04dEWvPTS8spWeHS6i5vzSQTpfRETreDDmUx35yA06
         /APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767613675; x=1768218475;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4yVc7Fv6KTjwK4Gtk6iZcVFGv62TYxn7ujD99PvmsPk=;
        b=J0OSM5eqspNOI6AuzOmGC/VoN5J9ZF9a+U/KDE8aTU9nzgDd5hogobhSsd3D0Xi8lq
         H5CHaz/3wJwfVKlVwrcx2KmJDbGM4ZryJksX6KtDKHQrVUCNAnM+lTg6Q33sg+1JliM2
         ckkglJIdUisLubg4nJ44EoQiZMrYaEq82VU9yo50arsT0LNON5my704GjV8+ZC884pjl
         NJ8+A0eUoaOTjwR4I2U2w7sNhdCV9XybEm3xSYGfcQJm/bXy+rcGM+9n3HdeWo4DxGyk
         ywaURrXmroZcNNCuMbCQigHtLiWtbZYsI6aZWJWD92FlK5kp5K7kSjXIiZ2VFGlXWPgx
         MrUQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvsfF4M5Nh4VGqqbsL5Kcn6FgPRmgQTfebG4i3rdUUVedI8DputONzdp1CGuTtl/oenb4R9ro=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz99ZNLDxg/RalIn+61l7vqacpA1aoEQbmRp+7v+doAhfy4IRKO
	D3AUTt3a+n/Rq5ZySUPIb1dYuM36I49rpLDxymu40Xki5oRJmT+wv7alrTfipCv5/3lrQayEduV
	7NSt3BjUySujxbPrdZldNQ7E7wUZdwiBc7Xx12v9stl9kqj+Fh1lGbF+38g==
X-Gm-Gg: AY/fxX5NFp3ehnwyNIZNm2e1UB7dy+Ozhdq5BI42LRZv4FHOcMLV07c/LUbcFceMTxS
	69LLRPVUTy+CMGWMXcRm/6oYU0LWgnjoPBGfulMB25lVAiuAGDMY2qRNmK1EEHzHSONPceiep7s
	aRPMhf1plg2tARf6ka4JyanZWsP6P/MnA08AyLJGH6qR1os/i81at04y7KRHhsJ+7UYar01nwA3
	8hGV6J7NL9jGOtLvbwGFCJWyiDa6Cpe829dOhHH19NDc3ZDpaDqY7+dTDAC7zIV6WyjLMU+Yl/7
	dD9YvgSM5xGmhJBkq9PzudP0VsGP+6qwnggSaWptaKypEOq5YTlP6KwGevGWkfOon7gj1Ak5ZjS
	S701RypAKiuKjStCmCTP2aOJt+8WMEHIfCBV/
X-Received: by 2002:a17:907:7b9e:b0:b83:f03a:664 with SMTP id a640c23a62f3a-b83f03a080dmr523519566b.49.1767613675485;
        Mon, 05 Jan 2026 03:47:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHxl5eOZaA5tkb0SiXmLtUqZuvDTKDYvvMC2EjLr6KOiOyt8Eqh0XpS42ZrtvKeQMhJx1p6cw==
X-Received: by 2002:a17:907:7b9e:b0:b83:f03a:664 with SMTP id a640c23a62f3a-b83f03a080dmr523515866b.49.1767613675017;
        Mon, 05 Jan 2026 03:47:55 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b80426fc164sm5336443066b.30.2026.01.05.03.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 03:47:54 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A4FDF407E7F; Mon, 05 Jan 2026 12:47:53 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf 2/2] selftests/bpf: Update xdp_context_test_run test to check maximum metadata size
Date: Mon,  5 Jan 2026 12:47:46 +0100
Message-ID: <20260105114747.1358750-2-toke@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105114747.1358750-1-toke@redhat.com>
References: <20260105114747.1358750-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update the selftest to check that the metadata size check takes the
xdp_frame size into account in bpf_prog_test_run. The original
check (for meta size 256) was broken because the data frame supplied was
smaller than this, triggering a different EINVAL return. So supply a
larger data frame for this test to make sure we actually exercise the
check we think we are.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 .../bpf/prog_tests/xdp_context_test_run.c          | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
index ee94c281888a..24d7d6d8fea1 100644
--- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
+++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
@@ -47,6 +47,7 @@ void test_xdp_context_test_run(void)
 	struct test_xdp_context_test_run *skel = NULL;
 	char data[sizeof(pkt_v4) + sizeof(__u32)];
 	char bad_ctx[sizeof(struct xdp_md) + 1];
+	char large_data[256];
 	struct xdp_md ctx_in, ctx_out;
 	DECLARE_LIBBPF_OPTS(bpf_test_run_opts, opts,
 			    .data_in = &data,
@@ -94,9 +95,6 @@ void test_xdp_context_test_run(void)
 	test_xdp_context_error(prog_fd, opts, 4, sizeof(__u32), sizeof(data),
 			       0, 0, 0);
 
-	/* Meta data must be 255 bytes or smaller */
-	test_xdp_context_error(prog_fd, opts, 0, 256, sizeof(data), 0, 0, 0);
-
 	/* Total size of data must be data_end - data_meta or larger */
 	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32),
 			       sizeof(data) + 1, 0, 0, 0);
@@ -116,6 +114,16 @@ void test_xdp_context_test_run(void)
 	test_xdp_context_error(prog_fd, opts, 0, sizeof(__u32), sizeof(data),
 			       0, 0, 1);
 
+	/* Meta data must be 216 bytes or smaller (256 - sizeof(struct
+	 * xdp_frame)). Test both nearest invalid size and nearest invalid
+	 * 4-byte-aligned size, and make sure data_in is large enough that we
+	 * actually hit the cheeck on metadata length
+	 */
+	opts.data_in = large_data;
+	opts.data_size_in = sizeof(large_data);
+	test_xdp_context_error(prog_fd, opts, 0, 217, sizeof(large_data), 0, 0, 0);
+	test_xdp_context_error(prog_fd, opts, 0, 220, sizeof(large_data), 0, 0, 0);
+
 	test_xdp_context_test_run__destroy(skel);
 }
 
-- 
2.52.0


