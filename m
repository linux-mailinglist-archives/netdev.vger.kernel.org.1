Return-Path: <netdev+bounces-280263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EgjDAz252kVDgIAu9opvQ
	(envelope-from <netdev+bounces-280263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:11:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E397344003D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3234F303A833
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7ECC3A6B8A;
	Tue, 21 Apr 2026 22:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POmhLuc9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991AC392C5F
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809426; cv=none; b=NgJunOK3vADWSUM5r/vocDZU55QuAY1rHwtd9x/GzYkjlAVb6FkAHAV2Qz0Qo2ncSIybLTu+rbI3gnleA3ayckkhY2aV4W/SCLi0dhixAuJXvvxkwz4OxxPICpjVL9QSxsTO68pKvlPD03Pu4RYq/gE1v2XprJ5zprAf3W3Jkaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809426; c=relaxed/simple;
	bh=RJIEnh+ncrKhS9Zfj9AKVCBCjGPA6hfvAlQUo5fkHmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvjo/zYCL9IxErNXxhVjG6OTL7rIkKmpHfNe+LoQOyqXiTIhFxBNpv2Vo9xot1ZB8pRmKB+Q8lUvs7hpLxkV3K/WKcCYuhwYDaR7fz6IOzBnkcB1++QmyzfJoSpPxyGG+imVrh2MYFBUSERDHBlsdfN+EhAwfGkGgbgQ2SUcV+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POmhLuc9; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82f33d28c1dso2623163b3a.3
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809425; x=1777414225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NmpRMKFXGig/q+WEycTJ71DgP7kfhR+H5PanaAOVwv8=;
        b=POmhLuc9StBAQrjWl0TKuvisfcTXJKQz810snpuSMWT1/oWGHIhsOpzpK62KKicRVW
         MZ91OI9ZVJ1IuUqL1S/3l3FAxgUF38PkcMnQQbGlp1lueqyS8NnM8/yMVzyiI1NCBpue
         BfYlybuhDWNDDIzfspDo00V99AlFb7QTatu+6zWOn93JOIMrS929e1InHwITuzXGO59+
         RlbtkjS7k3qbggcQVxNRDk6xRSMCfLMOLUw6yl9k0sxwLJAGNWEZUls0yBO+x9vLRZBq
         JvovMXNhUYfkwRpdfUsvbqXb3Q3jssrUfArUFBM+XeIN2JRmJjw/wvwyLfUJ+jAQ5dvt
         6m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809425; x=1777414225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NmpRMKFXGig/q+WEycTJ71DgP7kfhR+H5PanaAOVwv8=;
        b=PwHfMqemQJGFcm8bWfLaB4qiSMwJR45mE+IPTZmx2h1zxghKG/ACIrVWBEC6eWUTSB
         BvDM84cg/GXN/uO7qsBZHRW/W3DZdTGxBMCxt7OFyM8dOS395GSoiq9/zKjzoIP5Rm47
         5+7ator41zsn0DZ1viD6go7Gu0B7khuFSHMEb2rk2wodsLlfMrqNL3iT3iawthF9nzzz
         Z8H9yrzzJJErT4FRSrjCCBgyFbIlvqtss3ZktiWvRcrxC51FJFNJUK7OM1eOnhSQvNsW
         iOJkSKKKu6vkNyR63jdnY7nMCqDDbDfL2b9B8KmEvAJVhKnYwzDjLQOO+UwmwQCi5EaA
         nOiw==
X-Gm-Message-State: AOJu0YwjkVUE422C6Abl5ZssGh9srjIQAcFK+j99gABeLLKfJuUZ4VGZ
	ZD+D90UR3EzbmgXFg2aHhUpADuvMtJ7BTCp1F3xtVv2cmyO4xX1+pTPI
X-Gm-Gg: AeBDiesnafNoX3VnsUrR92F1cx9Ap2kR4RIM4+AUvQzu/3b941RcwVkYty6aj4waN/s
	ewIXqIldpbytCi7lQ0fR+PtENnAC7/UvcRw7/uXbRE1if2hd847dyfc07iWD0aoUzXD5ohO+4Ul
	r1bE3kG5M/kSF7Dx54lrs5OZgZaymMfT2nYLEsD4Ry8pX6r98wJVsO4qj930YRseXfxQPQfzIsV
	HiuACc9lQh1RG8IGH4BUKQ5x/qYuQSjLa4V3Lh6Nn70H1FWIlFq7HpSol8RFe4E5hD3noLPWZxD
	5Ia9LSZ8xkcTjMtkfK/hnQwjIlziGuexUWT57emvsdBEZLU8dP++t5O16faPCfupJtHIEKGpNym
	SjKZV+Bwnos+5cZ4c8km6Po+HxqftnZzB1dHU55GURd3w4PbnFFqtAi1rjOcI19D/+gFzQUnc/e
	QJl9Gh1syuePTG2Jx7PtOGzh4=
X-Received: by 2002:a05:6a00:91d6:b0:82f:9985:d4a1 with SMTP id d2e1a72fcca58-82f9985d570mr15232404b3a.24.1776809424952;
        Tue, 21 Apr 2026 15:10:24 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:1::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981d00sm14541222b3a.5.2026.04.21.15.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:24 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 6/9] selftests/bpf: Test creating dynptr from dynptr data and slice
Date: Tue, 21 Apr 2026 15:10:13 -0700
Message-ID: <20260421221016.2967924-7-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280263-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E397344003D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The verifier currently does not allow creating dynptr from dynptr data
or slice. Add a selftest to test this explicitly.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/progs/dynptr_fail.c | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index b5fbc9b5c484..43beb70f50ee 100644
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
2.52.0


