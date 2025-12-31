Return-Path: <netdev+bounces-246452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAA9CEC6B7
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 18:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A580330693CE
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 17:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521412C11DD;
	Wed, 31 Dec 2025 17:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="B65Bki7b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f228.google.com (mail-lj1-f228.google.com [209.85.208.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96FC2BEC28
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 17:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202652; cv=none; b=bcIL3UKpr/TdYaJnL9hF71W9I/xtp2J6FVOI3obWlSHewchDq5bvRUyS0Dn2mKoOBaPuOP6kfnlLej3b6eMDSvPA4DxMAnI4uoBSf+IkYrY2aQBnmBL2iWzEnoETAW/3FSn1oHDUbx7b7BYwSTMDJ30HXSNzMjZwVJZZlzBVg4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202652; c=relaxed/simple;
	bh=b8KXgdkuB2rBCBMKoOj23zAGkLun2ndQut4LRQn9YLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hoTQ+zcpJERGq6U6rtL0sNy9h/EPz+mAkyej1Cq2JDp/FRyn+NWfRwu0cqgG3Wl5169G5VEKk4yRF2xvmzYyA/surodCS/fwp20OfLLxXS3kJUG5Eby+qE/U2qZVwGgZ8ty+dA0FN5PuM1MJr/DbdQpUJBKCo7k77W2eTnysrGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=B65Bki7b; arc=none smtp.client-ip=209.85.208.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-lj1-f228.google.com with SMTP id 38308e7fff4ca-37a33bd356fso11605201fa.2
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 09:37:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202646; x=1767807446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z65KNwFWdBB4vKMl4Q2RH4hcwYRlqC7hzCG8+fs8pqw=;
        b=B65Bki7bNr5asR8gLT4UQO5QpsWvo24HYhFuxdOGrbh73k/Zr92fazIv6voAUW/2PU
         NRPRaa4XHs2xXve3L2aLfmP/X3GSNnom4rxPzZrxyrixO6Ux7nOIe8iYhtQ1ssVInkFM
         iAp3yel9cShgORh0d//av01ytc7Rj2cNdxJvUhhQHfIos3TiTrVRDeOu1/02104vqjtG
         RRS0sSH3EaSEgt6jotTfiemRL79/aQhhbmW0ch3pRyntq2bKZpwNL8WVuqLaJLpRtFGy
         ldEpIkoNzRCn8ozbNaHEkZRfejpnWZArPOsmBAtc2jDNT1N+OMNTUhmTxc0XZcfCIgaE
         gYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202646; x=1767807446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z65KNwFWdBB4vKMl4Q2RH4hcwYRlqC7hzCG8+fs8pqw=;
        b=cEbkOfwxJFnjrvtvGPYyl96roNya+DoNF0ASMKdqEwUdnUKYyVmRrLr5Lu8rTBqQgq
         HF0gx7RQeKXTojflqV8k3OMleqOFvgaCSfWWH0oWz9vfrrtj9Yb166lm26vpBzFjoqUF
         ou7AZyjerpEnwXKmp2PVAM6zctxanQ1foKgh0u432WbjwJHdJ2Pzg86RAGrPxE9SLStS
         kBTKiwuU5Fz3H/D4Xs2th7gIb8Y/5BZUl2vk/96Wik8Zqhv5c4dJhRIqd60b2tSSnHBK
         vHrm/UC54dn7eoVldxiEuuNFx+Hy2z5QwInjWB6C6claiDvnZvI7WmUSa+AQXPCqqm9L
         wZcA==
X-Forwarded-Encrypted: i=1; AJvYcCUZ34fBoAZFPofbc4xx25NeMYm/2eKhYy2PVYSQOR+wA9dgKR5kk1QNibYEbsjcG/006isBNKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU1zmprR8YisiR/4OEIQmGIphQSZY7OHVKjLcTaCGBUzcyn4Yu
	VpjuutHZIYzxBVinEqECYJjk7MrsEVU5aQJrzWyvfQV7u9xyUeEAwJsz8zY6ptJyEZXIkB1j5IG
	Rp3BCYsUPhDc3A0l8mgCLBn6THxOG0ZZNk6gY
X-Gm-Gg: AY/fxX7xreZvux6tujwuvAKuS87kAfjXP/eUmys40VvMclAiddHAMw5JKr4HQ/rk8bb
	Kuta3id2ZK90cPOunJCT/m+kqnJ6Zm2Bie5dQIY+BTwTmnZ215wV0o/ZOkKlkk/AMqHcj7Ycmrj
	gAKgmDKNBQnc5Pj24VxKq34nj87+P8ziWgLkZ6fB0Vw3Ap8wQKluiKM9p76Pj9ewvMt9ibAYfNs
	KlZiyriPz+ZCjTpbnRPDx408BJKT789dVlZCEXuYObW+6ppV/iBdIsAC7gE0e0maNSw6OyQKVZP
	eLal5hglZbFA0L5vL8ohUzmdhz8FAKdEjGedbosy3W0vIr6nHbBo72BfDVC3es807bGLPe3SHrh
	w1rHrdCk6rg0WRwPLvADpDNKLQrErCeWE5IWvB9WKAQ==
X-Google-Smtp-Source: AGHT+IHDF3ca8umxceWHVP6etyuOqrKJuvP7YcuUqaxQdob64KBatF2Z5P+pEZdYR5Wycxsg5VpsXr4tuz+m
X-Received: by 2002:a05:6512:3a84:b0:592:f383:3aad with SMTP id 2adb3069b0e04-59a17df4092mr7765992e87.8.1767202645513;
        Wed, 31 Dec 2025 09:37:25 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-59a18637640sm7186949e87.29.2025.12.31.09.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:25 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 293C9341FB6;
	Wed, 31 Dec 2025 10:37:22 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 22C62E4234A; Wed, 31 Dec 2025 10:37:22 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Shuah Khan <shuah@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 3/5] sched_ext: make __bpf_ops_sched_ext_ops const
Date: Wed, 31 Dec 2025 10:36:31 -0700
Message-ID: <20251231173633.3981832-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20251231173633.3981832-1-csander@purestorage.com>
References: <20251231173633.3981832-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that struct bpf_struct_ops's cfi_stubs field is a const pointer,
declare the __bpf_ops_sched_ext_ops global variable it points to as
const. This allows the global variable to be placed in readonly memory.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 94164f2dec6d..af8250b64f47 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -5336,11 +5336,11 @@ static s32 sched_ext_ops__init(void) { return -EINVAL; }
 static void sched_ext_ops__exit(struct scx_exit_info *info) {}
 static void sched_ext_ops__dump(struct scx_dump_ctx *ctx) {}
 static void sched_ext_ops__dump_cpu(struct scx_dump_ctx *ctx, s32 cpu, bool idle) {}
 static void sched_ext_ops__dump_task(struct scx_dump_ctx *ctx, struct task_struct *p) {}
 
-static struct sched_ext_ops __bpf_ops_sched_ext_ops = {
+static const struct sched_ext_ops __bpf_ops_sched_ext_ops = {
 	.select_cpu		= sched_ext_ops__select_cpu,
 	.enqueue		= sched_ext_ops__enqueue,
 	.dequeue		= sched_ext_ops__dequeue,
 	.dispatch		= sched_ext_ops__dispatch,
 	.tick			= sched_ext_ops__tick,
-- 
2.45.2


