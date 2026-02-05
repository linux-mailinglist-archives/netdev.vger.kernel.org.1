Return-Path: <netdev+bounces-257340-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iF5gIs4ahWne8QMAu9opvQ
	(envelope-from <netdev+bounces-257340-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:33:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2993BF81F5
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 23:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6A633019F1A
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 22:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CB833A6F2;
	Thu,  5 Feb 2026 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJGxtCyW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC360336EFE
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770330571; cv=none; b=XoabT1aW7sgl/Co1btQw45t06INK1eTszp5D+foVUNSL0KiiUpj8OKPBOrOyvwhLtJfutwpBkwjg3OejxX0uU1WBh2aHG4XcqQ/g4WjqHHU5v6MmVS1SiLvHaRw68PMx416VpRbjFoZyy7PznQTS5jiVLPPU69ttJJobh9+WSZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770330571; c=relaxed/simple;
	bh=3iS/7iavCieY0vGjt3CSw+m+ZHXLXWxjaSalApUkmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ix1xcf1lwknCqzlaDOEToCspC/wXxr3iIlFyIzQldzEHdqrFyqirIt1PSgtOVhljrosqqX8ULQ+6mCLGcUb4HEFTs8Io18/HAgt1hruuAWHm3r80HTOeDUZ6Eu1d369+IWn9TnpQs7XVahx4nKgQBuZy2hK5GB7JoD0yI9d1GNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MJGxtCyW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81f4f4d4822so799813b3a.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 14:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770330571; x=1770935371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=MJGxtCyW6xnguzTcqQ3culzDnGyItZdscqdGzseaB5kr5eN4EUv6sdTmKkkV/vBLDQ
         NKLecIAX+eGFMWrHEj+kErNUOpSbN1f17paMW/rzSK/R9Y5HKcB50gnqmwVoy3KXUd7A
         G069neyaaKa/+TqLnLK/M2M+fBT66TqmeZwOC3i4dvNYUIxJkkJNLYEHimZny0Mw2YF1
         AQPrnB02LP8iYUg/6NFT5u4O5byTH3a9oICSQBHQIyauNURSxkem/BE+2lCWzQ0+6UQ0
         bEqYb6CA3yqrBiFUHHmzgU8BVRn14a3V9Uxa1Wja0boaRrMRkfiYjJWRlOqLygxzSdoK
         92Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770330571; x=1770935371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=CsS6jvOOzDD7VABseBJL1nbbDqPGspYieMybcrd/zaInuS8vONop4KkiWhctC0cPka
         j3FJaUERz+BJpLvwoZzht67QUDD/lLscm8XyT0bwO0xACQYBUKlvDl4/fKXcBg7bj9zP
         2fwUktUE5RignQHrUQVE/hkT3LF1VLf3jnG4HGXgZNfOUYJo7akYZAaV5JGQkP3UKU7e
         21ckc2IE5sDR3izGdQp9anITLnqtVSKWaP8v2Z5mt62wTlv91YeAtwsy68k/DEipU1a9
         A3pR1cVwMQAxfQ/hQrVh+41H/k+ED2BxTRyVdZjicOzOjctldFluKwHdMyQ9QENRoUjd
         3Zbw==
X-Gm-Message-State: AOJu0Yy45sM7cs6G6LubP2sTbchVop/vgCQWHDzK4Vg4iMQSGbR4aZyv
	UkyAVd+sjKjJCNmK5TL2Cbo1i7BBGPoCwtCgvsiPOlHBsFhRPlz5YeYN
X-Gm-Gg: AZuq6aLAJlwwE5gJfebw/wT+um9aBlJsGgbG2RjY7vlNoePQp4TzsEJXo8ZqcAOPB+j
	jSTK2EG7jmDQIMsfh9wlEpBektoIRZ9xArq/T1MpXvS9l9Loout3cuus8+06eloCM1gNxLQFKl7
	SGwGaBMAAo5EUNxIWSba1Apgn6J4cKPTZYIIB+PzBXuxfy0y1NN1yCXkyXm/LuOlmcVg+ieyX7y
	pYXj2zywcOnx5ZBKyYmHneIJ9sAjsG3L+DVR/aNzTRRm/vWi9LhdNCu/KCC/fc8IU++aRXajKIz
	K5Z6ILLqFCeidj/mCeynHEqCVTMEfCiWZDsJbbzfPhuSNS+NOwHdC7o2qA/WWBQTzYZ4BHYUgBq
	/o2X9eQORGejBS9ELb2q8fNr24EFYX+4lEesI9Kp3OJRM7/n1Gm22aTcnUzrKgA0lwM7yb76imr
	bB+aNmqyxog1Ee
X-Received: by 2002:a05:6a21:4a98:b0:366:584c:62ea with SMTP id adf61e73a8af0-393acff8861mr726161637.20.1770330571143;
        Thu, 05 Feb 2026 14:29:31 -0800 (PST)
Received: from localhost ([2a03:2880:ff:21::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6dcb3cb742sm427513a12.0.2026.02.05.14.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 14:29:30 -0800 (PST)
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
Subject: [PATCH bpf-next v7 12/17] selftests/bpf: Update sk_storage_omem_uncharge test
Date: Thu,  5 Feb 2026 14:29:10 -0800
Message-ID: <20260205222916.1788211-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260205222916.1788211-1-ameryhung@gmail.com>
References: <20260205222916.1788211-1-ameryhung@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257340-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2993BF81F5
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


