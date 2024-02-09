Return-Path: <netdev+bounces-70556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 351B184F86F
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 350561C22DA9
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 15:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754DA7319C;
	Fri,  9 Feb 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ifuf/i8J"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906276D1D2
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 15:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707492368; cv=none; b=EuzZIYqsDJSix+8hE5n/e6A6qQTuXfu9FUDcT25VlI35YuOgctJv68qJe9jv7A3iTOg7NsLBAr9joAuBxMvr8/nFaYHSh+ZAMaZZR/55T/QrPK16RsXAsV57+dRFLEY/Ubq3uQCg49Wyf7HJrnB/ZXNpyJu1W+nu64wDdQOOdKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707492368; c=relaxed/simple;
	bh=CoB3iBJYK1PjUDr37uWEZdCVSZ1UxCeCCr7sPezHIIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUzFaQA8J84EffSyp69sSgtwV5PP4qROnHJ0brCh5fQ7x90SbS31Im+eyXU8nAkTnMReIt/cfvTqEvqG68b89uHYF8JxDrvvJC8tTZi0PcQl+4fjEPCoBjnn5ZhBQX6UAdlX+eAk6OJluIJ/hd7I8H1NrMPkUNXH9q6Q3yegV1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ifuf/i8J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707492365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4SZJ79y3tf9cvye+6fKSS8Ex1Xn6UrP697qgF48MJEg=;
	b=ifuf/i8JFH/lgn01t2S3nVSSmhsoW+wjtobOZa/r7eHhhgps6Z7kS3e4rSU11m0f+sUK+5
	bAzDTqTDGffnw6J8wOQUq4ikuBt6HAYn3E2BGbyv0nc/TndMSgyNeYbe80IKNP6Ichkr0E
	jsoogjbkD+oV2K/p8nf8eYPoH6phisA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-KwL_FwgKPWWXTwK2gsCnGg-1; Fri, 09 Feb 2024 10:26:03 -0500
X-MC-Unique: KwL_FwgKPWWXTwK2gsCnGg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0F21106D0C6;
	Fri,  9 Feb 2024 15:26:03 +0000 (UTC)
Received: from renaissance-vector.redhat.com (unknown [10.39.194.214])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 909F11103A;
	Fri,  9 Feb 2024 15:26:02 +0000 (UTC)
From: Andrea Claudi <aclaudi@redhat.com>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@gmail.com>
Subject: [PATCH iproute2 v2 1/2] treewide: fix typos in various comments
Date: Fri,  9 Feb 2024 16:25:45 +0100
Message-ID: <262252270eabfb4b3fb30266427e5d3a1b185992.1707492043.git.aclaudi@redhat.com>
In-Reply-To: <cover.1707492043.git.aclaudi@redhat.com>
References: <cover.1707492043.git.aclaudi@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Fix various typos and spelling errors in some iproute2 comments.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Andrea Claudi <aclaudi@redhat.com>
---
 include/bpf_api.h     | 2 +-
 include/xt-internal.h | 2 +-
 tc/q_netem.c          | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/bpf_api.h b/include/bpf_api.h
index 5887d3a8..287f96b6 100644
--- a/include/bpf_api.h
+++ b/include/bpf_api.h
@@ -253,7 +253,7 @@ static int BPF_FUNC(skb_set_tunnel_opt, struct __sk_buff *skb,
 # define memmove(d, s, n)	__builtin_memmove((d), (s), (n))
 #endif
 
-/* FIXME: __builtin_memcmp() is not yet fully useable unless llvm bug
+/* FIXME: __builtin_memcmp() is not yet fully usable unless llvm bug
  * https://llvm.org/bugs/show_bug.cgi?id=26218 gets resolved. Also
  * this one would generate a reloc entry (non-map), otherwise.
  */
diff --git a/include/xt-internal.h b/include/xt-internal.h
index 89c73e4f..07216140 100644
--- a/include/xt-internal.h
+++ b/include/xt-internal.h
@@ -6,7 +6,7 @@
 #	define XT_LIB_DIR "/lib/xtables"
 #endif
 
-/* protocol family dependent informations */
+/* protocol family dependent information */
 struct afinfo {
 	/* protocol family */
 	int family;
diff --git a/tc/q_netem.c b/tc/q_netem.c
index 5d5aad80..4ce9ab6e 100644
--- a/tc/q_netem.c
+++ b/tc/q_netem.c
@@ -117,7 +117,7 @@ static void print_corr(bool present, __u32 value)
 }
 
 /*
- * Simplistic file parser for distrbution data.
+ * Simplistic file parser for distribution data.
  * Format is:
  *	# comment line(s)
  *	data0 data1 ...
-- 
2.43.0


