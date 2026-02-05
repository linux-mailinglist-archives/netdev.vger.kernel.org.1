Return-Path: <netdev+bounces-257001-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIdsOrFBhGng1wMAu9opvQ
	(envelope-from <netdev+bounces-257001-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:07:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DF0EF45A
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 08:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56ED9304F210
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177D535D604;
	Thu,  5 Feb 2026 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LcGiwmNp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD13235B620
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 07:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274944; cv=none; b=j+GOwR2dkW3bU3dDfb4drOnptyOKZHoQVEbZsd0OTOpIvb65I9YjedrOnq0DqtuyuqTxRSz6RMvYLybemEtUPphsvf85Q6EQBcMra9phyA5qUXSSz7H708fJEuFbIaKfZkySqfVf3RUei7pX2/xPr3Zsj+tgttoakrMhbPxKhJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274944; c=relaxed/simple;
	bh=3iS/7iavCieY0vGjt3CSw+m+ZHXLXWxjaSalApUkmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=caoo9iq0BHCfRrX6hBDRi5chA+QA+IfOOoHZCT8ID3GDsgbBCHO6PtLLCJ8KtTFWzmhr5oEfNxzhBmlPew0wJu8qjq3W+DcmEZTeoJWXrgBBaZG2xwUnTLIDRKoWMcKOe0abc+hWq0yo0POHx9hNqwB5fAykGyfCs5K6BVMM7j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LcGiwmNp; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-823f9f81da5so338344b3a.1
        for <netdev@vger.kernel.org>; Wed, 04 Feb 2026 23:02:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770274943; x=1770879743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=LcGiwmNpLLMOqVK3PAxbVWuV+cBzwsZ/KZwXXE+HEtZI6S6VnIFMqlmNihPnm/UGw2
         f11OF1w96HFHl5XeMZ/PjCVpvmsci80+BmfaJkSG2pXHzmVkmuxdu3H3i8sbt4oAoL8e
         AZoc3OtSXFU9g41qCd7Wh2bftqzXM5NUY1FfbVTMxmoLFgdXfcbXvTnvjsAd/3gsbosv
         9eZrLQdsGJn0vsdcTr3HtscLwxNG/3+DaWm4h/WTNtdvCsLPZQFGMNOFRHtlkgQQVkMw
         EVk5Uv3Kto433W7e+VeiD9LFeMKRsAiGRGJ4Bao6whTodvgTu5NL+dvIM51ZpSUKWY9G
         OFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770274943; x=1770879743;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=RnHhv///jc77OLK8x7tT8+5FJtZpUu1DUbDUNlF3TKV++jsKj+ciuyBBOwC/KWFJUP
         XPlpN9dx7q1j3Q8R1MN79TXWJ3YHb0w3Lyhny7jS0RPrnxRsYOxOEDbcbjhL1y+RbcWG
         r8dfL2M4UiaG0YsAaNoWFh2a6Y+XsEdZhABeNuYXOnBdsKK85whabtyvhXin3ghHfntB
         P36xHSNqzCMTDaB2BnbXgKeJa+fdjfsU7ACtfGAGX/yLd38pGDwXNgUsvngt4qrBpu2x
         0xmaI5adR4dFUpTkWoDCkjMKcm4ZUnYtytl6xg/jGCVE1WgxMJ4Ahmti2TFXFpWMwsHH
         qyjQ==
X-Gm-Message-State: AOJu0Yw6helHk7sLkxIlfPrptmwAxUKOLjW0sgp5WR07K0xxpomGwQHD
	XWXeluDEHuQNuijKJwIdyTj8lDFrBrkSIaxeZ5xCqNsL+ah/j1KzTOW/
X-Gm-Gg: AZuq6aIdZI95j8Mw2wnayS81wEGUq2d9jlNXaYAJILKVFVWZjkr6E6ZhWbYuQfx+yXb
	QMwm4g9RevSwt80EC+SCf9tvR+i3bx8BPtf5YocEgKXbibOfA70WBgTjz5gy0ewruvEK/13tznQ
	L7ZjTyaEXtHFW10OkIdizVQVyOCQc4fn6WUKPcfOetp4s6eapEIuam/5jKqMGSkEfCBibV6M84t
	65PqH1esDnUSFsDqIYIn0npE1enhRZyd1bnX5dkj5iC/0Ow6uHsKsXLjWkpRfUuYtPRqwuI0kic
	5uA3StyFyYES4I9hR0HLrRMh1+G/B/6YC769rulkewp1jj1fE1QjK6atiQF1S+Wb0DvdJEkXJw3
	K3jdwfy2o4HX8wlTV5ly9RiPHgK+eTkyvDZZPDxvvqK5WP34cJ2lBXuF8poMx/S4aZ/5XDIqLUu
	1A
X-Received: by 2002:a05:6a00:1949:b0:822:30e:d15f with SMTP id d2e1a72fcca58-8241c1ad117mr5121907b3a.6.1770274943191;
        Wed, 04 Feb 2026 23:02:23 -0800 (PST)
Received: from localhost ([2a03:2880:ff:a::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d4ba97dsm5254454b3a.68.2026.02.04.23.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 23:02:22 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 12/17] selftests/bpf: Update sk_storage_omem_uncharge test
Date: Wed,  4 Feb 2026 23:02:01 -0800
Message-ID: <20260205070208.186382-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205070208.186382-1-ameryhung@gmail.com>
References: <20260205070208.186382-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257001-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 94DF0EF45A
X-Rspamd-Action: no action

Check sk_omem_alloc when the caller of bpf_local_storage_destroy()
returns. bpf_local_storage_destroy() now returns the memory to uncharge
to the caller instead of directly uncharge. Therefore, in the
sk_storage_omem_uncharge, check sk_omem_alloc when bpf_sk_storage_free()
returns instead of bpf_local_storage_destroy().

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/sk_storage_omem_uncharge.c   | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
index 46d6eb2a3b17..c8f4815c8dfb 100644
--- a/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
+++ b/tools/testing/selftests/bpf/progs/sk_storage_omem_uncharge.c
@@ -6,7 +6,6 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_core_read.h>
 
-void *local_storage_ptr = NULL;
 void *sk_ptr = NULL;
 int cookie_found = 0;
 __u64 cookie = 0;
@@ -19,21 +18,17 @@ struct {
 	__type(value, int);
 } sk_storage SEC(".maps");
 
-SEC("fexit/bpf_local_storage_destroy")
-int BPF_PROG(bpf_local_storage_destroy, struct bpf_local_storage *local_storage)
+SEC("fexit/bpf_sk_storage_free")
+int BPF_PROG(bpf_sk_storage_free, struct sock *sk)
 {
-	struct sock *sk;
-
-	if (local_storage_ptr != local_storage)
+	if (sk_ptr != sk)
 		return 0;
 
-	sk = bpf_core_cast(sk_ptr, struct sock);
 	if (sk->sk_cookie.counter != cookie)
 		return 0;
 
 	cookie_found++;
 	omem = sk->sk_omem_alloc.counter;
-	local_storage_ptr = NULL;
 
 	return 0;
 }
@@ -50,7 +45,6 @@ int BPF_PROG(inet6_sock_destruct, struct sock *sk)
 	if (value && *value == 0xdeadbeef) {
 		cookie_found++;
 		sk_ptr = sk;
-		local_storage_ptr = sk->sk_bpf_storage;
 	}
 
 	return 0;
-- 
2.47.3


