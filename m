Return-Path: <netdev+bounces-220424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0584BB45F7C
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 18:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99B19A07F16
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 16:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3206931B825;
	Fri,  5 Sep 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XDSx8N/i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C0130B533
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757091512; cv=none; b=HowCyojP0iWNI0LSJOssPTuf4xDS+D0ECEYnRDKsi6LUBYPY5/LsYQJTEAIx/i6CLGJrevDnV2dzNmG4Tf2jgy4dmpa2EmhJeQYpAkE/8ytX1D0RvAgWYFE4qccXMvLhwZJxJWsncMJJtRGobz4m8LmbQJSlpp1o/NBqrxJuMcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757091512; c=relaxed/simple;
	bh=vCPPCbYkpWoepFCaRUXjlfAjXQwbw9910DufzH/2FTw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fA0jbd7x9bZIgJ5xcrbeyepDhy/Ctv9LjyFsXmG3JhMmdedvxnnn1PxuHFeWaPpQ1lpcdKAtK3Tc66yTVMF2tmwpqeenJX3Up20CJoWkB89Q3p7Uz9XytcrBO6NPURNjcb4qzo/P+d7CwtLoz1Ebtl4IHyezVO0nWjH9ahGdINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XDSx8N/i; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8063443ef8cso791208385a.1
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 09:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1757091509; x=1757696309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EcjLzgMd4qbDwpnU0E77VHdVbc0CwWbA9SiP329+MQ4=;
        b=XDSx8N/i6i2N/pWF+Wgdwjjh8k89IKErS98aopx75RQNRksKLyWjvfewsGxjmGFnWI
         h3d9F77yHjqEtggOkGt84Z0YlsbOy18xj8oLUgL8tCMqp5Kl8B+PJXNAJuoqPFsCt1nq
         3dIrKa8SALwc1uCA3jEx7ZuA32xR/wz8L9hLRYxi1+LxwPJYW5CZgLsDwqon7KUqR/Es
         5n9aetJozUHREusHe9ox/ABOxVlsUHJohKrRlF2ALKGLy/bIcxIR2tm6iYcsZaNv5ezV
         6GEoCiF/GtKBhLb60en0vVuWAphKHWPTXY7gLJSSeNXd01vXdZFVYPn1McNS2J9RIW5U
         OU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757091509; x=1757696309;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EcjLzgMd4qbDwpnU0E77VHdVbc0CwWbA9SiP329+MQ4=;
        b=cYf0YEIXyuqsJK+vNglIAHl7HuIanfcdMJrXap5lumNri6WaP8TK09uvg1EH3wZSEL
         7wAENl9mlZAl18kI8fnlL7wgpAVPCL7yeANEnpvtIen5Drts7+aZoVQNTE6Z2z3UnSAY
         0i4SYIIwUJRiZUgu/XNwZQi+QJ1Yiq6an+Wm+twO02yn2YHGgUIzRFI6fUiAK+BmwdJq
         5SonxhuDSOxQgunEPEXsylDubGi57/haVoYHAVPAU70ZzgP0Bygb2ZiMY7RZrS4I9eVE
         cXRzhxlf3Ek61fKzj4HXYollPFSqq7J6kcewNIVcN/2A2XUozBMYWzx2XNgducM/GDkJ
         3cpw==
X-Forwarded-Encrypted: i=1; AJvYcCU6aq47p+qOM6jMaVE1jJ6XTSx9C7KIwyFP1UDm7rdADu253k28dE7/ex7kOD37str/XhsZ40I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqd5IhGBFTZtvCIQv5y3432ANk5EptfidnUxmY+Rpvsx8lkPnJ
	vLzB+ZibgD3s9uneKZ8SBRc+CsyStMYO71o+D0gSxP2JkRSLnMs2ketdAEJYO4ZCY2LrTJKqgQu
	XiL2ctG96XR1n9A==
X-Google-Smtp-Source: AGHT+IHlAPSWVqBI2US4kMycSX9LDj4BiDvtqHDW+I/rssBui9cVWvT610x04UlpEJrVI9qwVM3GOgVROzxa6w==
X-Received: from qkpg9.prod.google.com ([2002:a05:620a:2789:b0:7f9:16dd:d235])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4514:b0:80e:ed61:7de with SMTP id af79cd13be357-80eed6109d2mr714400685a.70.1757091509064;
 Fri, 05 Sep 2025 09:58:29 -0700 (PDT)
Date: Fri,  5 Sep 2025 16:58:13 +0000
In-Reply-To: <20250905165813.1470708-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250905165813.1470708-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.355.g5224444f11-goog
Message-ID: <20250905165813.1470708-10-edumazet@google.com>
Subject: [PATCH v2 net-next 9/9] net: snmp: remove SNMP_MIB_SENTINEL
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Jamie Bainbridge <jamie.bainbridge@gmail.com>, Abhishek Rawal <rawal.abhishek92@gmail.com>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

No more user of SNMP_MIB_SENTINEL, we can remove it.

Also remove snmp_get_cpu_field[64]_batch() helpers.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip.h   | 23 -----------------------
 include/net/snmp.h |  5 -----
 2 files changed, 28 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index a1624e8db1ab..380afb691c41 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -326,18 +326,6 @@ static inline u64 snmp_fold_field64(void __percpu *mib, int offt, size_t syncp_o
 }
 #endif
 
-#define snmp_get_cpu_field64_batch(buff64, stats_list, mib_statistic, offset) \
-{ \
-	int i, c; \
-	for_each_possible_cpu(c) { \
-		for (i = 0; stats_list[i].name; i++) \
-			buff64[i] += snmp_get_cpu_field64( \
-					mib_statistic, \
-					c, stats_list[i].entry, \
-					offset); \
-	} \
-}
-
 #define snmp_get_cpu_field64_batch_cnt(buff64, stats_list, cnt,	\
 				       mib_statistic, offset)	\
 { \
@@ -351,17 +339,6 @@ static inline u64 snmp_fold_field64(void __percpu *mib, int offt, size_t syncp_o
 	} \
 }
 
-#define snmp_get_cpu_field_batch(buff, stats_list, mib_statistic) \
-{ \
-	int i, c; \
-	for_each_possible_cpu(c) { \
-		for (i = 0; stats_list[i].name; i++) \
-			buff[i] += snmp_get_cpu_field( \
-						mib_statistic, \
-						c, stats_list[i].entry); \
-	} \
-}
-
 #define snmp_get_cpu_field_batch_cnt(buff, stats_list, cnt, mib_statistic) \
 { \
 	int i, c; \
diff --git a/include/net/snmp.h b/include/net/snmp.h
index 4cb4326dfebe..584e70742e9b 100644
--- a/include/net/snmp.h
+++ b/include/net/snmp.h
@@ -36,11 +36,6 @@ struct snmp_mib {
 	.entry = _entry,			\
 }
 
-#define SNMP_MIB_SENTINEL {	\
-	.name = NULL,		\
-	.entry = 0,		\
-}
-
 /*
  * We use unsigned longs for most mibs but u64 for ipstats.
  */
-- 
2.51.0.355.g5224444f11-goog


