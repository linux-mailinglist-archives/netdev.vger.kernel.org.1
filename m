Return-Path: <netdev+bounces-255658-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNtLEUSTf2lotwIAu9opvQ
	(envelope-from <netdev+bounces-255658-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:54:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F037C6D33
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 18:54:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B3393038A77
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 17:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63484284B54;
	Sun,  1 Feb 2026 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eKmW2As9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D127E074
	for <netdev@vger.kernel.org>; Sun,  1 Feb 2026 17:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769968268; cv=none; b=KpBRio6Owm8URtLlU1brCvnK1DKyzilP4mh6Zpazbn3nMUmnKmPkyw/0cuXvj5iuH21eFFRInpgXlocwX8GKQ7GM4COhPn2dqkzNLu1g0bQRw+KJbjYYleSicZVl4Xix4/cdwAaqBHdql3LIuER9xYsk87zW4tURg2/9pZjRibE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769968268; c=relaxed/simple;
	bh=3iS/7iavCieY0vGjt3CSw+m+ZHXLXWxjaSalApUkmvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYWJCkIlKUk1G1goG0ULkzX0HO0d4eGVt+FGXwqqk8FlY8l556gXhJ895nRQeb8Fyj4iblyJ2+ux+O6Qfb92m7f3H+grqOUfE7+aOkM8PJ+ReK/IfHFzTjqWwroI73/D2XJPTRS6gVWnjr4przI9MjCJL9jVMUpHqtjAV3ckNdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eKmW2As9; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8230f8f27cfso1876218b3a.0
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 09:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769968266; x=1770573066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=eKmW2As9OjOf6JCyNfm10Eg8ftIOOMpoVAtxqX69Y2reXIr5CJbJw2WuiWb+Xd5jmh
         0CJskERJj6QdAYLg3qDyb3KEt4OLfICxfbO4wWZ/hF1DyQUCssMwVCqos0yh6m0lWvBh
         4/h5gL4DhegrZoYLZKVKioXH7pbd467wYXCykU9yG3uqob2uNj1Kaz5nuwb+vRmaUkgN
         iP496TU18ks5Qs1wLgEDbr4eRnLj50iyxl2ajlcmp+NfkeUndgwKyAwVg+jO6wqMic5w
         VAU9j++UfaetZ/xpt101q84Gj2/Xh9nbpMT73k/25jW/TRnsDQBRGgkIyujAE32y+9hb
         YYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769968266; x=1770573066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QVecu991SVFveWbBZhAv7g6YYbwLWhpF7kmZTPpREKw=;
        b=rCcX1fuVUOg+67Hj1+ZaHgxmsSzMe11kgp9AI0rkHwEBm2rSsdwkt2vcyJGJn9HFk5
         D2mXUv+xBR/VI9MMsMFiEhesOF+jZ9Q7NSCldCgrcAMg7R6hfW3MOXE21ICRQrbGbzCg
         gnGm+9LFTaVlN/A5eJrL0ixLXd/OZ0ytF/8+x8jWlxvvwWYAZa/32udbebFYFgHeYB5U
         AOlb1jWfUTCFgu7pOz+5jXzNv5x8unXJlt1D8VsOnizUqIPZgasKey5Y37VlPj80d8tR
         4gdaXFnvcTbUxrMEA5bIDD5+s/MPPEX7oR9AMKqfwq2Hx26vsMaLst7SOW002bb6IcIU
         RVBQ==
X-Gm-Message-State: AOJu0Yx3G6UFw5WKT0jas/eSD66b2hGZ9iHu1Ieja4YYJ7fOwihV8z30
	S1piy5bRPbB0kZ+ZD7LA17glpoMNu38/2ETX86l0D52WVdoci76o5J/c
X-Gm-Gg: AZuq6aJVYsLLxKNrfwEbXQxHFFqYYH42MDANIBwZ7za1SR3v2CxyviQkc+O8FEhe2yZ
	PL1vftGt/TY+qXxCV4t7Ct/ExINvNG6fxYEno/aL0Eb1siBbeVddmGYHq2vRfSTTtlybUa3KISj
	Cy11az3FAyBjvNTV227XOz5AVBJVbjZQ222AUhswgbWaMFaZXeLXbWBQXhyznZYUaULqnIBNank
	3mtSQTUU/Ewz5WoBrmPm1mo8dRUYtLlujOWPAfkqfuL1aEEY/wzMYr6trjip3PgvluSwGyKo1d2
	iu+xTRxoJmj/fnfJI63rnxZFqRI8fRKNaqcwwWG08NLWGeekeC4bK0dN0yg9tlCjjqwAP6unOkI
	z1leDvbRYPNjt6+MTV1N+Szykzz+VYhbqNjci6xVmBbf3pxMys5G4iBY2Mwgqan7PtH75tXoNt0
	4XJw==
X-Received: by 2002:a17:90b:3f85:b0:341:8b2b:43c with SMTP id 98e67ed59e1d1-3543b3d65e2mr9511884a91.18.1769968266006;
        Sun, 01 Feb 2026 09:51:06 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c6428371715sm12318496a12.13.2026.02.01.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:51:05 -0800 (PST)
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
Subject: [PATCH bpf-next v5 12/16] selftests/bpf: Update sk_storage_omem_uncharge test
Date: Sun,  1 Feb 2026 09:50:45 -0800
Message-ID: <20260201175050.468601-13-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260201175050.468601-1-ameryhung@gmail.com>
References: <20260201175050.468601-1-ameryhung@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255658-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9F037C6D33
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


