Return-Path: <netdev+bounces-284882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJr1OAtT+2n+ZQMAu9opvQ
	(envelope-from <netdev+bounces-284882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:41:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B764DC67F
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:41:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 190A93124C45
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE768481A87;
	Wed,  6 May 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUx6JCdQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395A480DFE
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077653; cv=none; b=H/T2CCqwML6vZ2uQS39W9EKLcKrTbYs739Gd1CrCsr4W1t8LFxnl4RCt9z5yCKrbcTu3bVaZowUchAT3GNkXAF9Yo68kVyxRUqJKMEkak2NkJfi3MQnpwGH++aff8dK2Fy4CKBifh6TF68EPTRazVHVIiHrThbWch6H88iN1hDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077653; c=relaxed/simple;
	bh=p3fZL6NnpnyzCRu2Ry7ME0q8OWFksxB5L7EkIVk5Joc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quYCxaMwFB9hF88enFFvR5Sm1h8HejaMGOa+GsP/AdkRB4w91NqmihGH+eQV9gSr183IdOpkBwlDObh4gG4kN6p9mRjAXT8UhaLD4ZM7GhIX9cg1+/Hjx/v/0Kp+SRLXrESA1KbxD0Aiqx2usEo0yYnmdf7Yh08OgJ/AbUGBz5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mUx6JCdQ; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b6dd874471so53205046d6.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 07:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077647; x=1778682447; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGgd1BZuy22L7mS4HRnMmTNXaKG8bUWk6PNbl6sz2X8=;
        b=mUx6JCdQmR+9mLkWC1/Dn3G+5wk1Frklwur4qwiFC/XegoMRyw2UcAL7Uit4J8l5IB
         RRrWjAE86lTGwuYk3diRJzFGgAS7XvXtoEpDmiCP7h69JJFca1b+UjLcNKPwSDZEJXRf
         gEUSDbI7osPxQVuef2t0ymjcJVnfXHKXQ/p0p8+tH+F3JasemVT/s8C21UgFh6D2h/Kl
         rjdbS53bK2XOQkvir1NJCMWIHMBfCGLoGlH4QvJKP38vgkuq/J/Ks3zeAxA/GFowNdQc
         ZZ0K9EjM/faDDtRGEqydxIVNb8SbWKetBkAtg2fZwgq0QyngbGn3VGNibu2cc839Q0ci
         er8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077647; x=1778682447;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PGgd1BZuy22L7mS4HRnMmTNXaKG8bUWk6PNbl6sz2X8=;
        b=QIV9RPWMXKkIC0z9/CCnwZ27WGDSfNTB3T7dNB7gc2ZrLuTq9eWlHe9kuqmKb3gdGp
         cKE1QnszGMC30fOynE+HzwDyXIzP6lUR9oI3BShurqf2S6FU2e2X0tixOF8iUY2w4Dzk
         264XVfeHjSPFUNN2d7vLwGV53T1Sx43y+RkWmKup42L+me47QVtffDos9anDISvx3Cq6
         JB+XmrG5yxa8yCQ/xp6MS7qHdgP3SN4vlA8X9fDwtva78KJf4OIaxspCcmeyObWM4jEm
         dATr/upHjMxvnCWUGBUM4bkpipCAEyBsC74UhjcYmrd6nhEmgbcEU7JNmspCehZPrvJG
         YADw==
X-Gm-Message-State: AOJu0YxUqIf6Z4sxZBv8L6YNPxYf+sMN9AxUyhrXDFM+RLaed2dtlx5k
	TTqyXcWyPFK14gQ1mflb0rJ8Le+Q7OFgOCCM7iv0vhqWVyFg58xMQLX/
X-Gm-Gg: AeBDiesllhZTRqQK0F8J4mbPCfFDLkcQ16qAgdrXXjRbvtqGdZhqcRbeurSzNIR8kkr
	CGX8ULchXVlzoAMxGPPKgXGDLh1UnhTHzO42Rv/EcO2qCdwn6R0L2A8LMVvT1Ut0Yo+hKFLX+ag
	cBIS0wmIEuaGgwZ8w03ZBFW7Nb2YURpOz6uHwKvsdeorYMYAIzRg3dRMn8sdInkt3QdJEnYOedH
	gUQ608JI6Mqi+W971IkTEIEvB+LvufqrK6Z6nFcdh9uBov/voAwVq/E9JtDYa47KUs7/buxzq5F
	zH6qbTQh3tgYmIEszoa0QVSFeJDEFQSE557jYQCCD7dD5w1RQPR9ntY03A4FRq+SJW/wbroXOvw
	1rQyvnDJ+9tt/LpXttXMu4+/A2sHIyqRCuBn9y2CipDlKEpwQMj3uvB//RoQwDDHbkaN0NX2wcO
	uV0JRTe+OBQXBVsWSnZA9BzNKC
X-Received: by 2002:a05:6214:5544:b0:8b0:2017:958e with SMTP id 6a1803df08f44-8bc42a704b5mr51679576d6.13.1778077646900;
        Wed, 06 May 2026 07:27:26 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:70::])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538a293dbsm208737176d6.2.2026.05.06.07.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 07:27:26 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 09/12] selftests/bpf: Test creating dynptr from dynptr data and slice
Date: Wed,  6 May 2026 07:27:05 -0700
Message-ID: <20260506142709.2298255-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260506142709.2298255-1-ameryhung@gmail.com>
References: <20260506142709.2298255-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 45B764DC67F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-284882-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

The verifier currently does not allow creating dynptr from dynptr data
or slice. Add a selftest to test this explicitly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 60324d68b349..31962233bea1 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -705,6 +705,48 @@ int dynptr_from_mem_invalid_api(void *ctx)
 	return 0;
 }
 
+/* Cannot create dynptr from dynptr data */
+SEC("?raw_tp")
+__failure __msg("Unsupported reg type mem for bpf_dynptr_from_mem data")
+int dynptr_from_dynptr_data(void *ctx)
+{
+	struct bpf_dynptr ptr, ptr2;
+	__u8 *data;
+
+	if (get_map_val_dynptr(&ptr))
+		return 0;
+
+	data = bpf_dynptr_data(&ptr, 0, sizeof(__u32));
+	if (!data)
+		return 0;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(data, sizeof(__u32), 0, &ptr2);
+
+	return 0;
+}
+
+/* Cannot create dynptr from dynptr slice */
+SEC("?tc")
+__failure __msg("Unsupported reg type mem for bpf_dynptr_from_mem data")
+int dynptr_from_dynptr_slice(struct __sk_buff *skb)
+{
+	struct bpf_dynptr ptr, ptr2;
+	struct ethhdr *hdr;
+	char buffer[sizeof(*hdr)] = {};
+
+	bpf_dynptr_from_skb(skb, 0, &ptr);
+
+	hdr = bpf_dynptr_slice_rdwr(&ptr, 0, buffer, sizeof(buffer));
+	if (!hdr)
+		return SK_DROP;
+
+	/* this should fail */
+	bpf_dynptr_from_mem(hdr, sizeof(*hdr), 0, &ptr2);
+
+	return SK_PASS;
+}
+
 SEC("?tc")
 __failure __msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.") __log_level(2)
 int dynptr_pruning_overwrite(struct __sk_buff *ctx)
-- 
2.52.0


