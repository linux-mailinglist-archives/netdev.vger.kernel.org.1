Return-Path: <netdev+bounces-247940-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F933D00AF3
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 03:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0629930164DA
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 02:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B3E2BEFE7;
	Thu,  8 Jan 2026 02:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+gxs4JB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B162773F7
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 02:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767839215; cv=none; b=KpAeX8u7aRrmwbC3v8EUS/XYdA0PWnXfQVdIzIsw4tQVEbAnWNXCzadrWQGwOlW6mpTtxUJcR8gH9mjrTg356PF98eYN63y0eWmtt7GqCtKiX5bCHsOVWv6pYMNoVyDFf7ALbJ7Fme5dKuhisFa81Tz0+5719E/txSTswIihO7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767839215; c=relaxed/simple;
	bh=agW6uKNys5gOeoTrVORTjBOaAxozAsYVc4VUeEIRBqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kU/8RswQSHk2ovF/OjuvVQgTnBzsT5wbeCHB2I7CUp+eZOh3qvdIt00yx29ixYeCoKHVXqisDAFqPfwiDxB9psnbmrpd19N2A+CwYm71ARvyDn3I/4hGn2e7szwZZ6CRKyrZNg5J2nuRItSckQu55rfZ9Ak5vfa+b/SbPzBbuE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D+gxs4JB; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-78f99901ed5so29913767b3.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 18:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767839213; x=1768444013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=D+gxs4JBvmPohLOa6xu+ek9dPGh0LUhzNzFdNUgnNa0a7WUf/hKIlxq7lWziQIzJTG
         +36N2C6K6TWODC4YakBQfQvN4Jqmza1UmsB5rn8O4iLBpmQPvkBQM7iZWSckkpRbGGTp
         D6k7R3vRny/Fw0wj1QqjEmxLKqytBwUb+KP4APYecMNDSaYIFoccw4pZqln8sWTucRgs
         UcpKIsOrTWVHhAMRvOYpxZ4FZa0fwAxBTIZVDnvq/KFci/5HenC0d81+1YytnBNUZPkC
         bMOtcBWV1E/R8Vv0SY70JVZgsQI7iB3Xqt9KVvmy+aeEBxjDGRelbPXrIq/HJLetJ86W
         T2RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767839213; x=1768444013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ft9yy1vLUwNJD7u+x5LfWhJWNGjlertbzF816wc1jaU=;
        b=gdkE0oyo6jr0HZ7dVt1WfodVuv5zBN1XXdjFZOoCSV+mHnQti2eK3v64qrXmbx7SB3
         xLJewTb9Sn76kaiQcjORkZ1fPetO09mnKvD/gsWjdYBl6rnVCn4qS7jvA5l+LKywWWPO
         2MrMD01ydEv/BT5qh/XY0RuwW2AWtTfbFxBHHpOJYcqmLbcqh2zw5oUWHn2dxjc39Zn3
         0kZ0hfiRoSkbSzd6xY4j/DLOF7LlN0b36sTpWmxas20fp/Da9iinxmX9O0gPk0jXpIZU
         7rwmaBlFApFf9QgvOA4toFkxn4YHH1CPdbIdcAufWGsSbCLbPLnq9y1gJf1WhnG4sdtn
         aNwQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUh2DD6zMILTOEIBHgYNpEqEy3lZBhLUC6oTnkxSZNrmprD8uqd5d2fPDmOSvMz2LZzYq/T90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAeH0BihVfB/owsXlF5WYW9iVpilJbUTQojhL4UQ3DSD5ppB8f
	UJ0lNuwY8/+RAU9PFrqM+05C47UsZG2IgMIEDu37HWnDWcd48eGOOxEk
X-Gm-Gg: AY/fxX64QSXm//KL+MqC8Jj63BxXtf+s9RE0WCUM5N7k9HC3qLUPKM9vRwvqKLDyY8a
	kHRP6+gc68wSyFBD9KvMmR//kETLjr1GSjDMAesIfDEFqzaS/mkqYINu+l3uX7sDEbwBP1KPUid
	sxshFytzcQq0viCrD695pj0/H5ZBggS/e1Fl53RPVoDD4ci+mi5KmLDaUlf03H3BFeKOZ01Tdx/
	5OZPsJW1+pjMA+k5xLCZ01lY0JnK4nb2nwXRnaTW7x/cBfRhUzXY/4fra7agmLcOMklGEzeIUXz
	W2eU3DBu6HH1DBI+mg6izTFQ1eBcobczT2IecfLr5jXPsePG1tCQvaD3j6waSqTakQTCXA8X/WV
	rMHU2Tg82dXJ4pp6njlBgZP3Z3mEF62y0LfunsOAQ4RIyVQdRjUHqiZRNaBSDYUBMS8BBUAYA54
	ARTkU9nV8=
X-Google-Smtp-Source: AGHT+IHzDlEVf8/d6QbnaKBb4bXfG6njhvfNqB2OjCcNdUEx2bLbQR8avY4Ht9YmtBQ9rseOaNNR2A==
X-Received: by 2002:a05:690e:1c1b:b0:647:101f:cc90 with SMTP id 956f58d0204a3-64716c392f0mr4161680d50.53.1767839212841;
        Wed, 07 Jan 2026 18:26:52 -0800 (PST)
Received: from 7940hx ([23.94.188.235])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa57deacsm24855027b3.20.2026.01.07.18.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 18:26:52 -0800 (PST)
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
Subject: [PATCH bpf-next v8 11/11] selftests/bpf: test fsession mixed with fentry and fexit
Date: Thu,  8 Jan 2026 10:24:50 +0800
Message-ID: <20260108022450.88086-12-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108022450.88086-1-dongml2@chinatelecom.cn>
References: <20260108022450.88086-1-dongml2@chinatelecom.cn>
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


