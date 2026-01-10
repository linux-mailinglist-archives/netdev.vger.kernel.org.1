Return-Path: <netdev+bounces-248682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FD9D0D33A
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 09:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BC5A3046998
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 08:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4452DCF7D;
	Sat, 10 Jan 2026 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a0LUyyGp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD462EAD09
	for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768033564; cv=none; b=WmirRjFWNpN/QsjrzJkb5RVezm0za8Yxf4VMN0H7PWZKKkqME7oDE597xgBCHrLc4TM7xRPzvvcN0NnT7ng0tjr+8nduIlpuhVeFUYuNdoNiFpG3YRZAdNjXYncU+whQQVlCFXAGEl1ZXJjaC492EVmmJ471bi9VgB5A1VDjZbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768033564; c=relaxed/simple;
	bh=RBrjhm4+4Jiaj85vSZsjK0QkF6TyPfp4BVqBMhLxtnU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aDo8UbVbL04tdo+0HeZuPDFevlzWY6On7lMYTqpJnP1NSF8lqu7Y+4F75cdakqCoXDpImwwzwsCs8zWag8vbO2t66ObAxbe3pDFD1Ex+elzitvKPiLTrj/gK3kvnCOOoxhN0lcvv0cVvxsUMKlytbedd777FDKUat4BlFwQQowc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a0LUyyGp; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2ae26a77b76so5281387eec.0
        for <netdev@vger.kernel.org>; Sat, 10 Jan 2026 00:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768033558; x=1768638358; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o0bY835EK0LGkX/hoGkquZtOPtlX0pdafRbSWsGphjk=;
        b=a0LUyyGpuOtr/kpGyxATeZ+/ZIM/1vLvd6tFBWpQi0hT95Tvn7Qt+V9aSVnClBxKCm
         c0+KORV4eabUAmCTZATleRo8SFvjCxd0pDEGgo8AL99QeMVNB2B0WV56Ob2JdVLc1S7x
         QSHYyBLqLJoePfR/TC5stAYqJsygNE5z0o5ebUEz8o6j0WxWEah6Be/JYtFqiZdMwQiT
         hVej7rqSG6Nud6XhFtrp9IuU0oUBoeT0GZiXbUsJ3+O7qC2ypJskTFIH5p31l1mF3SO+
         BIx8Vj5dn4+OtDbYRunnZht9NUUY0qtpGR9CKAuBZxH2g8uvu7LNMZm10/FvTZMaQsIC
         4t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768033558; x=1768638358;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o0bY835EK0LGkX/hoGkquZtOPtlX0pdafRbSWsGphjk=;
        b=QaegVtWXHiUregVuxSWgy8xGY946A+9cUe8dQ9yFtsy3f3CdPEmTjMKWeY1PDwZEP6
         PSXaXT2Jy/sLIjACr7wWB0YEOWXDX4LKSTtsNyWW5OOdjytpuXONgcD6ghk5OoZLoGhg
         oQtlolTQ6C9yppw/0AAjT4hAdL+QMH6ig+B9hvzsm6ZdijmIJDyeeA4rlX+CWH0LOBpu
         Hd5lIpgRz5wUcRoKc6jvpnXPVTcswnKrb7ejHo0qcurZiXeqZaNMnQuHKRgZwqjVeD7O
         ewG7Wmm47PcKtzwDcObIJzHwfNNNRCG7on8xyh816Fdc2/XeOj0m/fZt0gYmT4XLpFA+
         aKbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVmBKXNmqHLeJDictGlCMl0WHuEOX/KMKM3qXJeUnhi0CuwE5FkLyQ7YY9uvH3M9BZA6RLOADk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0GWdSZ82o6LsBVJjNvG402kdvLeLHV57TctICjyVKyClw9n15
	BoUeo2+F5Sc2Hb7TTN0y8Xi1GEtr8FrjTegwVfNhR/pdOblafsFUkxep9YzeFF7On9TOQtiBSUm
	2leRFzVFYJc6Iq9eXlcl/SBAiX52Edw==
X-Google-Smtp-Source: AGHT+IEdcJWR4YOxzDo/NKDA6fPe/N9NLHlDvsILubDvbMVZVeq/7iKvCaYf/wOLOjsHjs6CFpc094XqH7BWVgqvs10=
X-Received: from dlbeq5.prod.google.com ([2002:a05:7022:2605:b0:123:171f:e390])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7022:6b8d:b0:119:e569:f60b with SMTP id a92af1059eb24-121f8afc1e3mr10377485c88.4.1768033558494;
 Sat, 10 Jan 2026 00:25:58 -0800 (PST)
Date: Sat, 10 Jan 2026 08:25:51 +0000
In-Reply-To: <20260110082548.113748-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260110082548.113748-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1442; i=samitolvanen@google.com;
 h=from:subject; bh=RBrjhm4+4Jiaj85vSZsjK0QkF6TyPfp4BVqBMhLxtnU=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDJlJvHw3K1dx39tx5gGXQc6c3c9Od9Tr+kysmbamaJ3lu
 +OHy2tXdpSyMIhxMciKKbK0fF29dfd3p9RXn4skYOawMoEMYeDiFICJrORi+B9wLjq9j2VB6Snt
 CFHv8MMnUnlrPz8R2tXscdh1UdCBIDVGht9T7p4KeRv9//iENDZbY4lz3/fI3Zna++Zv7qKZBXx 9b3kA
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260110082548.113748-8-samitolvanen@google.com>
Subject: [PATCH bpf-next v5 2/4] bpf: net_sched: Use the correct destructor
 kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	Viktor Malik <vmalik@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI enabled, the kernel strictly enforces that indirect
function calls use a function pointer type that matches the
target function. As bpf_kfree_skb() signature differs from the
btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
---
 net/sched/bpf_qdisc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index b9771788b9b3..098ca02aed89 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -202,6 +202,12 @@ __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+__bpf_kfunc void bpf_kfree_skb_dtor(void *skb)
+{
+	bpf_kfree_skb(skb);
+}
+CFI_NOSEAL(bpf_kfree_skb_dtor);
+
 /* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
  * @skb: The skb whose reference to be released and dropped.
  * @to_free_list: The list of skbs to be dropped.
@@ -449,7 +455,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
-BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb)
+BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb_dtor)
 
 static int __init bpf_qdisc_kfunc_init(void)
 {
-- 
2.52.0.457.g6b5491de43-goog


