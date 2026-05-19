Return-Path: <netdev+bounces-289573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPA7JGqpDGoIkgUAu9opvQ
	(envelope-from <netdev+bounces-289573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:18:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F020F5838A4
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 20:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA13A30E805C
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 18:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6445E344024;
	Tue, 19 May 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IqUxy2iv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B4B33F8D9
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 18:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779214416; cv=none; b=t12TrRYMWVQ35RHx6ybXwHsxbPiqsrrX3r+bGQ4hKqyBv6Tfke62/V0In67dYFaYuM2jtCkB2/D3zAhDDWu3fUI1/Sl5vJtLdqpDDxRCI2vVPMEmgvJk4UztR7lScndHhKAkkEy1bRL5Kv3NPz0ltfhureTe1xBr3CMnCsRTOv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779214416; c=relaxed/simple;
	bh=Yy9nxMqDxlsi2eFEMJmHQMFtl2AvZuZ2+2rqjXag50s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mll8y9Sw35wwe77mXv6uDQlEKafnO5V03gRJN1bG6kB39xViVSzB33yM+n5RxuDnwGlpTD3oEkinqx0Y3TjmxbjJ6TXHX12pDOoeIlh3RbMNNcrxVnCoNT6wXxRhDxvseXOsZXVJdztiHtRwzopWTijYqeXLmO4v7czzEMkpbeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IqUxy2iv; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6530287803cso4050642d50.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 11:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779214413; x=1779819213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QecDNGP+w/3sDQd+DHV0ny1tRHbDSeV8L549ZYAjJFY=;
        b=IqUxy2ivVqWQlIh8U14l6Wt3IFO537beLmbTWFhp+Ju2t33nx1CxZ6fLVI/8leTcli
         VOqrmsvZfGnwtYTCBKPsV2NE0HLzkWdMxTucso4KtoDTVtZoiDLc6FeEXlky+UkT/meg
         VT5zEVSb6EMQvzK2AqW+YzmF6IJPxQQwG5QNgf1Ipx/wF+RptbGgz71P4w6lGSlb92SS
         SOf9tyT48lMSBZgSo6aiIOKENzx0zYnykf0s4EBvuF5xaW3wgN0Z32rab/T7gveYuZyV
         tEQJlh3GxhFQQ6SVcK7KfQXSQaHAQfjpGF79mz+c13+M6uCP9dvfhbWEQXgavze+kTuh
         3xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779214413; x=1779819213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QecDNGP+w/3sDQd+DHV0ny1tRHbDSeV8L549ZYAjJFY=;
        b=QO4kuZvT8wwRiBa49W8P5vWY+ycpM1lkTvw4p+D6VAVn5gEUfG1G1hzL4IJtD28Rcb
         EkfatK2NejNlwWmQSTV9ao5+xUjy6tq+bS73vvVmEn8uvTcLrSTG2pDXq0mLmpVJnYrL
         vSYvRRFu8w8ynERWzoZoSbSMoc2y6TMG5jmWO05qdwsNSKV+j8bCJNAURB6Zf5giYyNQ
         NeK4XeiVV30jckaCd8uOSGcFqZi9e/56j2eYe2GcjInbuhhhKEcibMJyQpzLLnpUW2Yd
         /ZwMKwnZPe3PPv9voQelsSE2+dhoMDUAUybOPOLnAAPHPQ1hTqofsfTtbmPcOmJy4u3h
         npjg==
X-Gm-Message-State: AOJu0YxEPU47yKjAlcb8el3j8oP0Pyc5ERfuwkDHxNS82TgAPI9FSpx+
	uLuDaB/mHCSV8RhgKoCbiWswnQbA7YEkCHQxgRmm2nlCY/iIOVu8Qq0e
X-Gm-Gg: Acq92OEEtzYbf3M5ps0blb4o3LHfUXE9y3TG73aBI6fvRFm63hoqZAFp9DR0n368JA9
	BLD3jgSMc7jwN0V1UYFOP6gDIl43r6oElvkm8WBTqlJnmhhvI3Ob2a6q40pBEuoEhhtLw2Y8eri
	63wXgbZHrDCA1apgF32l+Ht7AF7UT30JpXu6ZxATp0KZcU0lBjV943VWIwgPQwNbIhS0DOZ6Twv
	Q8iBx+GNfOgrBQIID3e4tuTEhBPxe8kDDVoegzeHPZcxgEF2MHU5qrksnJs2DyT28HWH2OfNO9Z
	jzBAQDkCMB3NEmXpH1gdRp2izPzQNlnk66xndckuRRDEuJaYORTl1da/bYJi8sQEwHDJuiWk7en
	n5zJQ9T4ud6QfxZqL7v8sw+N2iVWWDc9wHFFxKYrky7/smp9RegqJDUCcN4NbCVfUa7zYFkfiZM
	pBAZhy6effB8kEL1fTJLVMszJ6jg==
X-Received: by 2002:a05:690e:4082:b0:65e:412e:681b with SMTP id 956f58d0204a3-65e412e68a9mr13850054d50.55.1779214412933;
        Tue, 19 May 2026 11:13:32 -0700 (PDT)
Received: from localhost ([2a03:2880:f806:5::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0d8e701fsm8211829d50.8.2026.05.19.11.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 11:13:32 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 11/14] selftests/bpf: Test creating dynptr from dynptr data and slice
Date: Tue, 19 May 2026 11:13:09 -0700
Message-ID: <20260519181314.2731658-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260519181314.2731658-1-ameryhung@gmail.com>
References: <20260519181314.2731658-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289573-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F020F5838A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The verifier currently does not allow creating dynptr from dynptr data
or slice. Add a selftest to test this explicitly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 40a14a5174a5..344fb2aa0813 100644
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
 __failure __msg("cannot overwrite referenced dynptr") __log_level(2)
 int dynptr_pruning_overwrite(struct __sk_buff *ctx)
-- 
2.53.0-Meta


