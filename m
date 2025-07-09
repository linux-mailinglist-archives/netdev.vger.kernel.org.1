Return-Path: <netdev+bounces-205579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F79AFF528
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:04:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520D95A0ADE
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8484A24DCEB;
	Wed,  9 Jul 2025 23:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="2pziJtfJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055E8248F6A
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 23:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102227; cv=none; b=AdVJXgI/tIpgHbPk8kzk0uj3OGKRG4UsjgETUp3AdMr0/KEl5QnHitnSfQF+9T7InMqeDH2oM6vPffnkMU7vUpS1vxZWhW+inrt7vVp8agsfQrY7SiW7mU5/Znv9aTjNPHex2nRpk5rrHVBNn/UewgmEFiARX1J8YkUKCXy1Gvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102227; c=relaxed/simple;
	bh=foepoQWthtqzAO/amSXmA+Ijs1+fWhMG2CBZ9t6Tz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bANo5FgwKVR7KQGL0b4vgLUEiOJvgjyWR/JzsCw6xBw4RDmVjwEyfjjm8jkKhGde/o92fEw0YdtK7xL3NKYyjfuc1ZOlPo+b0ajIxSEkOA1Z2L2IJ8KuNyluj83ZwoPamWRwBIhbfiODkSt4oE22isDqVpdq8sNIdcYKbJR1F48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=2pziJtfJ; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-313290ea247so77970a91.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 16:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102225; x=1752707025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=2pziJtfJ8TIGwjK1F7yoSU+YJ9rfDG5m5xIPehi0woGSUog3GUWb/fPH/V4uy9Jei9
         EidfBM+llmVsrayVSQJgzzG2Me5NfqxJwGsnfXssYPrxy0QEx49xt4bKti/T5S7MwA/m
         MzXES9PtgLps74geBNZQ0ix5AVOickFaeJPX2hmeVI0fRA8OV7c80hXM3IojJqzNGItu
         BpgINwLWMK83wZV4me2TRUf7ZWr9VPX3hUCrtvrqAro+Zx/hi1CS40uEZbXbiJ3xftGW
         MFfhtfvQt/qguK+FAKUuqaIN0LjlaCcDePSUx3E3j1FKLvjE+tjopmryaftz80LPKoc6
         TEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102225; x=1752707025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=Cr4jx9LXvKN5DJBYDqs7TuwEtAd2Nsb51LLNMdmQafzjqm240E2vXcj04gTx7057E4
         l2iO4BZ4wFbcBh2LAZ1uZHZpAcduOIFHWScgkJ8FO+HLwr3Xd8d/Tccq39erPosVz9P/
         paLAVWK2kpnglw+u4ZQBCmtB4ljo3hOR4OVdr0qzjcK+IvnzaK6hKmX4T2GVJ2U21DWl
         0989cDZmjxgQJYmO8eHZExlEPynobH+SD2t161QG2yy/+41sJ0JQzDSvg/fRhUW2eQ0n
         l4U7s4BVqG9Use1AWlfrLFgKsD2qi+xfuVB78Uphr0Nq5riWQnElPLL4TXcGWULPBe9n
         +wFQ==
X-Gm-Message-State: AOJu0YwXv/eJndL7EhKwcPGywJy74KVDCVvv6SGAnO0S0L3ZwVktrbW5
	vnySEgz2APgi6HkQ91fE3WA7QlJG+8eooI7lAH03QPLmD+zA1QK2uReWce+d/hs9moXyFDeaQyu
	/3kmM
X-Gm-Gg: ASbGncsuB7951wW8UeWIqbIY3NkAyXqNbLO/H0Q5rC3WFOUe8Or3ZRlU69uu+YlJy3+
	vSGckojW3wPh0vJCfEaxsVZEflBV77/uThNxkkdCXz+5ld72E6YcPh4ZsbbTsm+4fDT/WvfsJQT
	DUTE1wmQgfcWzIKlMEZCIssQlj0wd21xfQlHUR2MfshUFxvg8uTxCYbQdluDh7my4rRdyhxiZ1E
	D5VPYQ8uQI6sPaCVoik9ugLCmEzAawgpj0TJXcw+7Ll+P1wmmRN+L5KHry4nCRjAmmiDSxFc+ix
	WI2zuC1O+54KTfGhEs1SdMLbvNASBsCfSg5xDUicsKt9GEfn9EM=
X-Google-Smtp-Source: AGHT+IFeY7Zsi3A+vEOdmhZLWKnHpNXusHBbXBV7bufwK9cgRgfCCIydt2ZZb+XiqumJQ0FfrwgsLQ==
X-Received: by 2002:a17:902:e547:b0:235:f45f:ed35 with SMTP id d9443c01a7336-23ddb192debmr24284585ad.2.1752102225121;
        Wed, 09 Jul 2025 16:03:45 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:44 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 06/12] selftests/bpf: Add tests for bucket resume logic in listening sockets
Date: Wed,  9 Jul 2025 16:03:26 -0700
Message-ID: <20250709230333.926222-7-jordan@jrife.io>
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

Replicate the set of test cases used for UDP socket iterators to test
similar scenarios for TCP listening sockets.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index a4517bee34d5..2adacd91fdf8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -358,6 +358,53 @@ static struct test_case resume_tests[] = {
 		.family = AF_INET6,
 		.test = force_realloc,
 	},
+	{
+		.description = "tcp: resume after removing a seen socket (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_seen,
+	},
+	{
+		.description = "tcp: resume after removing one unseen socket (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_unseen,
+	},
+	{
+		.description = "tcp: resume after removing all unseen sockets (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_all,
+	},
+	{
+		.description = "tcp: resume after adding a few sockets (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		/* Use AF_INET so that new sockets are added to the head of the
+		 * bucket's list.
+		 */
+		.family = AF_INET,
+		.test = add_some,
+	},
+	{
+		.description = "tcp: force a realloc to occur (listening)",
+		.init_socks = init_batch_size,
+		.max_socks = init_batch_size * 2,
+		.sock_type = SOCK_STREAM,
+		/* Use AF_INET6 so that new sockets are added to the tail of the
+		 * bucket's list, needing to be added to the next batch to force
+		 * a realloc.
+		 */
+		.family = AF_INET6,
+		.test = force_realloc,
+	},
 };
 
 static void do_resume_test(struct test_case *tc)
-- 
2.43.0


