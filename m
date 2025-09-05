Return-Path: <netdev+bounces-220422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCABB45F7A
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B1894E45E0
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE31309F1C;
	Fri,  5 Sep 2025 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pK6Qaml4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF9531328D
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091508; cv=none; b=oc0kyNmy89JNBynPZSY8FPtxQOWSAoSrIvpNrQhQMBR0DRAAUR4l0CYsFsfGBTszjewK4JJ3cS/tX+5SouAkAz0si8QNr2n/sKD+Ok2mDq6OlXdjbSpRrMQCSAMz4EdpxAnWEN8f1Bbr8Rle6P8pqD1bYye9h5v6iD0FvFdHxOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091508; c=relaxed/simple;
	bh=O5wSIJGFV4VRNo5skmz50+Vyku1DKkqoZiyzk7qvVgI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bQnYGP8+9R76jiUDGi5nPM0OsfD4UmLPoIHUXjYjZrRqraeqqxz6FdcS+LVtWnFbQyOWTnqt6xxOg3vrKKgYg1q7A3BUQga52hknFbeC4hVRo+Bhk3vd71l+sSXAyJx3aNsjFHY3qjDYopmtt09u5FNvdukgJOVR2egHqmbFZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pK6Qaml4; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8031e10621aso536431785a.0
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757091506; x=1757696306; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Td3SN2iWxsxcHdyrw4kio4OPHk+6r71Sk35krS1OK4o=;
        b=pK6Qaml4H/7jnFYJB1prex7WmXVs6GrKQgoDgSKeZ2r9wJISkWT7VMQPizukWhPV/X
         OOepXJM0r8/Bbw1aziQN7MeInI1W/KtZXSwztJdjv/VeqNdsE8h1AJBjL/w5XZbwlDxl
         iFmv2RZoFYqhNif1YrLsOqNhYPxnEe61yOW85m+Lt8KCUo9OmnftOBrF6a+uUuuLK/MS
         WEA7QXR/jpC5EIAfS8g3L7BQiclWYtdps9K++BNc5sG849cBj8YCTW1qVKAaTWgfMuVZ
         +0r06BQGkdJwBILv/VsxaN4ylwtRJ2qspcvSw4fO28yS+S0ZWW80zddHj7H11Ffp+Fjb
         uaHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091506; x=1757696306;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Td3SN2iWxsxcHdyrw4kio4OPHk+6r71Sk35krS1OK4o=;
        b=WcoS+cFBzcloeZfoUh2mgkzouTAAhJNk+eceaTQWpgcPsVXEAUYLK1Z7SJiMirA5Ih
         L31cCyxD7InId/UCMk8Qg/nZs2KRicAFWZbVP7TIB8+s7Zr6Tqb9NlbLsU+avsAWQYvB
         Tum0mfvTUAV5cN4qZTl2VNlouOD7T3dLGLbKTfpavYSHGpyuuEQoLGRizrjyDAubxeCG
         vHhovX5ASAOxtQX7Vt1pb65jIUpUEQApsc9c5ArIqflXGw3bA70+6uhXVoBaOulyw1rk
         TUdRF0WsgS6b8Z3a0ItwYOus1dgb4DNd3gETGcpTJhCUz67DSqS1z4+BZKiNCd0vY64i
         bjww==
X-Forwarded-Encrypted: i=1; AJvYcCU/GckaEh6o0AToZtknb3yl9nUHU2toQB56J/CWBitw3skWhTccEVkrFy94PuJhA5YFY5AaTrI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4T0m7c/RoYbV22grM9rWLPuxEVJxMoyWgEil2uXDLdaluxyp9
	uDhhuTBx3kItWXp8LZRyNP7B8xWBsHCfXqgN3SNfrOGL40zueZcNhea3vXGlhpo8nzTUAR2xLJl
	QLCa7oTu3MBQ2lg==
X-Google-Smtp-Source: AGHT+IH9FW0rvCbuX5vKnWJSfBwSfscunOfdpK+yy7SCUUMhjNLHO5cuHuw2CFgUWjXtzWDRf7a6a1f32rQbzg==
X-Received: from qknuc4.prod.google.com ([2002:a05:620a:6a04:b0:7fb:99fd:1071])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2944:b0:811:6aff:d410 with SMTP id af79cd13be357-8116affd4ffmr306181385a.43.1757091505759;
 Fri, 05 Sep 2025 09:58:25 -0700 (PDT)
Date: Fri,  5 Sep 2025 16:58:11 +0000
In-Reply-To: <20250905165813.1470708-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905165813.1470708-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905165813.1470708-8-edumazet@google.com>
Subject: [PATCH v2 net-next 7/9] tls: snmp: do not use SNMP_MIB_SENTINEL anymore
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"

Use ARRAY_SIZE(), so that we know the limit at compile time.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls_proc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/tls/tls_proc.c b/net/tls/tls_proc.c
index 367666aa07b8..4012c4372d4c 100644
--- a/net/tls/tls_proc.c
+++ b/net/tls/tls_proc.c
@@ -27,17 +27,19 @@ static const struct snmp_mib tls_mib_list[] = {
 	SNMP_MIB_ITEM("TlsTxRekeyOk", LINUX_MIB_TLSTXREKEYOK),
 	SNMP_MIB_ITEM("TlsTxRekeyError", LINUX_MIB_TLSTXREKEYERROR),
 	SNMP_MIB_ITEM("TlsRxRekeyReceived", LINUX_MIB_TLSRXREKEYRECEIVED),
-	SNMP_MIB_SENTINEL
 };
 
 static int tls_statistics_seq_show(struct seq_file *seq, void *v)
 {
-	unsigned long buf[LINUX_MIB_TLSMAX] = {};
+	unsigned long buf[ARRAY_SIZE(tls_mib_list)];
+	const int cnt = ARRAY_SIZE(tls_mib_list);
 	struct net *net = seq->private;
 	int i;
 
-	snmp_get_cpu_field_batch(buf, tls_mib_list, net->mib.tls_statistics);
-	for (i = 0; tls_mib_list[i].name; i++)
+	memset(buf, 0, sizeof(buf));
+	snmp_get_cpu_field_batch_cnt(buf, tls_mib_list, cnt,
+				     net->mib.tls_statistics);
+	for (i = 0; i < cnt; i++)
 		seq_printf(seq, "%-32s\t%lu\n", tls_mib_list[i].name, buf[i]);
 
 	return 0;
-- 
2.51.0.355.g5224444f11-goog


