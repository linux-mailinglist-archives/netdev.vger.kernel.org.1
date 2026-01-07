Return-Path: <netdev+bounces-247601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AEBCFC41D
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 07:57:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6986B3032FE5
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 06:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB84D2D12ED;
	Wed,  7 Jan 2026 06:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DwTMbxd9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6913627587D
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 06:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767768364; cv=none; b=ocYUoIO4AH8vi6+dlkYpMV59iKgW3xS6eDPGwL4z4yhHgWRVOuMhToxaiM78rROeSwHgN8Nf6vjga1zRTk40STnSBVF9eySC697MYg6Cy/pQamE/mKFkJL3VeuPJtUxlONcRKORlf3PjoyKW9s5BzAcaAr6qpawneXGrwuFAbUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767768364; c=relaxed/simple;
	bh=agW6uKNys5gOeoTrVORTjBOaAxozAsYVc4VUeEIRBqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qksvv+tEXv8p3TdWIZJUCxAfKH8K45Lxq/Rwx4Z9ySgbSdjcb+U+2EYED4AFR3ZED25lsbGmVZH9z8VpTaaPoEJBWfB6FznLjR5yY0SFI/wdBjRK00OunTvNA6cEG+kECp+/1cNnkGJAI1lKp/ZUkiFlycNeY4aBajCmdvdm6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DwTMbxd9; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-78fc4425b6bso18426077b3.1
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 22:46:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767768362; x=1768373162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=DwTMbxd9IeAkkEfBrWzCeXpKfpwnwxgy4qvoLrA7f5okRsKRS6kCKXQWNhIWiYmYtb
         xi9AcqxJzqdTUJJZpsKrCA/IfJciYGjGdmJ/DJ0oRMlQVLmC97Ie7Qebw8Miq2iw6ZF5
         Ol5BpIRNaY4kOdOVMF5xLz4u8k+ymUYRV6nDRkJ8es9+hlZo4QgFntzN1K+oAYC8M6He
         9Jlres+ElBWns1U7IEJhSUs38m1gpd5Ym0c6VAN+Swdr0Xo4YVYtXnrekRgfSqmeEIuR
         KqaVy6ivG7+8oBbYUUa1c1LDt5iro/aiSs07/0Z5I41IB/xeol1ETzyWNBIVLAPd9ZbT
         HeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767768362; x=1768373162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=HzZqLCMdwmFHhz87W5sRJhI8L+XsrE+gPwXMOyfMlit8T9uLZw3e+t981rgO4EXlkG
         lBGDMAL2qXCq4cEchWHCmzSGnEoFu1Fh8PjMCu6LVotmIw89vrdJJ9DxcAylHSPOfh1I
         zN6dDI/PNr39lS+632OBAqUl+LnEzQQlBAOJE/Q8U9mxw/RqIThNd+nhP0BqslWwPioV
         gbu8mtaZYHxVYeimNWXEmX5IC3R/qfzlrkJPT6mD4AfEUk4Y+q9pJUlgETsRAjocfhCp
         8irocuZx+9WNLmwy/mi2pi6hRh1BwxRODphQo8g62DFt3XU8f/mqqd3NfVF/MrsRE2N3
         c1YA==
X-Forwarded-Encrypted: i=1; AJvYcCUmg5UUQluEYficB3D/vZRl9Uri8P9MifsyA8EX0lrqx5a6n38M7lNYa/RAQCahdqTh5e4pXlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx94fkKFFGxmyC8Lfob+qCny0WJb5N0H6VAvVaVFjrCghMAAiHA
	CaR490J6cnU/aaCgwMYOsw74HctPPWtj5OQnYFu5WruV7opHmuwRSZ5b
X-Gm-Gg: AY/fxX7Y3bv81GLGOZdJN84xBBNGwZSALBSAChgwkLShdX9MUZ2ZHl3YTu+KMJX+170
	kaZ1JP4o1BTst5sM4nUo2U4j2CIMBwyYY5viTk649mPxGj4s9SBQ6U+i0g2mTDLTIGfJiKX5u2B
	I+0rgvpUAGHKwbDAw/AeGjNDKJYA3aqxJht0+XuNwr2ml7eVIJdQ1HXuuYqM3Esu742kTd9ZqXJ
	MpkmZe7zMBEmXi9pRhsKZ6RuNf8Kxxs2+go38Mw9HFC6JPQQJAOJdtihugnw9ltz+W2x7P35iGf
	U8S+6G6C9cCAcX6ekTkf3d7ayqOXBbXv9Kb4F2UP1r6UpH2d7C+4vys703cESF9PAQqTV1ZlkCa
	Gwo79pF69y+UqBZY0UDa235vILR10M8rCNHpZQKg7XTRq6ZvMYo2NjGcwq2Y1HWJwh7cPY0AVIp
	qUbkRlC5g=
X-Google-Smtp-Source: AGHT+IFRwIpFYE8JW/BqV+Uh4FKDeGkj90yb3724hL0VZNUbVTJ7ud+xBiwCBD2KX8IWvAZdS1l7iw==
X-Received: by 2002:a05:690c:e21:b0:788:763:17bd with SMTP id 00721157ae682-790b57edc61mr16814257b3.60.1767768362444;
        Tue, 06 Jan 2026 22:46:02 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790b1be88dcsm9635047b3.47.2026.01.06.22.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 22:46:02 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	jiang.biao@linux.dev,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v7 11/11] selftests/bpf: test fsession mixed with fentry and fexit
Date: Wed,  7 Jan 2026 14:43:52 +0800
Message-ID: <20260107064352.291069-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107064352.291069-1-dongml2@chinatelecom.cn>
References: <20260107064352.291069-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test the fsession when it is used together with fentry, fexit.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 .../testing/selftests/bpf/progs/fsession_test.c  | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/fsession_test.c b/tools/testing/selftests/bpf/progs/fsession_test.c
index 85e89f7219a7..c14dc0ed28e9 100644
--- a/tools/testing/selftests/bpf/progs/fsession_test.c
+++ b/tools/testing/selftests/bpf/progs/fsession_test.c
@@ -180,3 +180,19 @@ int BPF_PROG(test11, int a, int ret)
 	*cookie = 0;
 	return 0;
 }
+
+__u64 test12_result = 0;
+SEC("fexit/bpf_fentry_test1")
+int BPF_PROG(test12, int a, int ret)
+{
+	test12_result = a == 1 && ret == 2;
+	return 0;
+}
+
+__u64 test13_result = 0;
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(test13, int a)
+{
+	test13_result = a == 1;
+	return 0;
+}
-- 
2.52.0


