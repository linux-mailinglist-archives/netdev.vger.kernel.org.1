Return-Path: <netdev+bounces-210211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6EAB12635
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 23:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2013F1C27E52
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 21:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7500F25E828;
	Fri, 25 Jul 2025 21:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1jZ41/pu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63A92571A9
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 21:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753479862; cv=none; b=cuB3lQt83n6TD7u1Kz/LSNWbYp/HF1dWn4th4ccuOiXuBHMx169B+qpa6cNbwXVYOUppEcY3mX7ifj40GQXqoQPpJER7tw9fWbjhn65fiDjGY9ef2HTVKDsgvCBxUc40TlpGZwVb6hPUyubAMLyiCOYyCVOX9DnZeZ38rW/n/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753479862; c=relaxed/simple;
	bh=GO7ImXEAOuMIOar1IsdVoRKFJVlSFfW0FE673eTteVo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OZKZU4UJJu3vuaNITJSBbPhDrKFLXcK+cOkkCPeVbNTBTfPuTJM7vZKZOfmgAeaXIJ2bAwm38SNTZLPlfL+DzTit0PLiF28QHenvISFbSA9ipKHCkLtN0FjvtpTCApUMVos5eNrdSiuZZEcFGnhd+yx5abpn3LxNXltrMzAC5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1jZ41/pu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samitolvanen.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-31215090074so3932840a91.0
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753479860; x=1754084660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nh1FjbfwBquX1aOlAjtnfCEBWUtfAe9dDsJi1MAAp54=;
        b=1jZ41/puEnQyncoRjo+wVUnALmMTTw2u2FMwXTrdEs1AaZHu2E2Fe30pJBLmAQD82C
         /dklmGfUJMsnVOGEYuZUSXZK0imys2heXE9UXOwmpFgdf/54DoSZ2Fj9VK0xRZqnKsAg
         MFfBYhOT8ClpC7Hlb9GuUjFr6IUK+yFOH5LwhnAsH4hUG/4InyCH6LhtpOi7+pQqHM+e
         BHZPjC++loUi8EOUTPNxhCokt8jF1ifRMVa3IRiiElQIQGClWIKWvLk2prqvW8FMsuUs
         2/ww0SbPXMeL5W1nwzncVz8XeCjMlpmECr3Gf027NIBScU6Lw7NjqjBdq7IP7D/j/P5H
         ysQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753479860; x=1754084660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nh1FjbfwBquX1aOlAjtnfCEBWUtfAe9dDsJi1MAAp54=;
        b=IP6cs0Jjtgn7j3zxDJt8vIiJi1r8W64s3kzXMfMAdYcIQdCHNnNy9yuobABl2b18ln
         zeizKarXVXx7k0PxOB4csY+UcOdX5u/40H7g9+C9UZ9Rdubka+XSJ3sx1ZXN0slqQ9Z/
         RHskNqldrv2acfudDFWDqQYkhvXeRnCaSHv9Dwnu4qpROGsPc0EPj8tBvBrIacAaZVE2
         nArI2EUPKPo7nO4UCbWkoDS6HdMB98cdpvcvs8ugG26p920I5bfTzAH16UdnNF4RT2q9
         vrIzD0p3UmywAykw5wEj5uQn5y12U+HOJPieDSvmPh7n/k/Nl8q4vqr8WvkDnT1Sgup2
         W5FQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyG9szvJvEtBXInZNmI0uWR81C+ytQUEBz3eQHhjAfMGVihOpPbbLxPM8jw6pPaw3qYOp2ots=@vger.kernel.org
X-Gm-Message-State: AOJu0YznumjkV4LHZ0alLLraYh8MkHrrHmmoUY+pgtQsCRZS62T/slxd
	FvTkLkGlojfuAbYpXsyCeVETXAMbNVb8LdAMmzm9F/vnTLHF3QPy92aPQrr6rNT5sDa2+w0kIw6
	2x6pI3jMLtp4QecqXDA5BeTuryTe+Zg==
X-Google-Smtp-Source: AGHT+IFWY6iwqFym08uHjYBP6xmNfO0fYcS3owVwCfauSHVtUhoNQHns8E0XueGZKuuJciKWYVtKZeSTTNiiVsdsE7Y=
X-Received: from pjboe10.prod.google.com ([2002:a17:90b:394a:b0:311:ef56:7694])
 (user=samitolvanen job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:134e:b0:31c:23f2:d2ae with SMTP id 98e67ed59e1d1-31e77a59e53mr4606952a91.15.1753479860240;
 Fri, 25 Jul 2025 14:44:20 -0700 (PDT)
Date: Fri, 25 Jul 2025 21:44:04 +0000
In-Reply-To: <20250725214401.1475224-6-samitolvanen@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250725214401.1475224-6-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=1396; i=samitolvanen@google.com;
 h=from:subject; bh=GO7ImXEAOuMIOar1IsdVoRKFJVlSFfW0FE673eTteVo=;
 b=owGbwMvMwCUWxa662nLh8irG02pJDBnNvxat8TpTKKnffUPxza2IUNVVXzTefJ4ifLQ8Mqfgn
 8SmeZtaO0pZGMS4GGTFFFlavq7euvu7U+qrz0USMHNYmUCGMHBxCsBEcrUY/qmlqW+v+bIzq8wz
 ozFnE/euaI5naVU/L90MiHQ9E7rR9Rsjw5/Zxtcm9mqYVmjLfl9U+OlQo/aElZMiBPUvCiX8srn FwA8A
X-Mailer: git-send-email 2.50.1.470.g6ba607880d-goog
Message-ID: <20250725214401.1475224-8-samitolvanen@google.com>
Subject: [PATCH bpf-next v2 2/4] bpf: net_sched: Use the correct destructor
 kfunc type
From: Sami Tolvanen <samitolvanen@google.com>
To: bpf@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"

With CONFIG_CFI_CLANG enabled, the kernel strictly enforces that
indirect function calls use a function pointer type that matches
the target function. As bpf_kfree_skb() signature differs from the
btf_dtor_kfunc_t pointer type used for the destructor calls in
bpf_obj_free_fields(), add a stub function with the correct type to
fix the type mismatch.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
---
 net/sched/bpf_qdisc.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index adcb618a2bfc..890edd7ab64b 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -202,6 +202,13 @@ __bpf_kfunc void bpf_kfree_skb(struct sk_buff *skb)
 	kfree_skb(skb);
 }
 
+__used __retain void __bpf_kfree_skb(void *skb)
+{
+	bpf_kfree_skb(skb);
+}
+
+CFI_NOSEAL(__bpf_kfree_skb);
+
 /* bpf_qdisc_skb_drop - Drop an skb by adding it to a deferred free list.
  * @skb: The skb whose reference to be released and dropped.
  * @to_free_list: The list of skbs to be dropped.
@@ -449,7 +456,7 @@ static struct bpf_struct_ops bpf_Qdisc_ops = {
 	.owner = THIS_MODULE,
 };
 
-BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, bpf_kfree_skb)
+BTF_ID_LIST_SINGLE(bpf_sk_buff_dtor_ids, func, __bpf_kfree_skb)
 
 static int __init bpf_qdisc_kfunc_init(void)
 {
-- 
2.50.1.470.g6ba607880d-goog


