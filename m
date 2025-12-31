Return-Path: <netdev+bounces-246447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 93141CEC651
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 18:37:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E5E27300EA3B
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 17:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2112BDC1B;
	Wed, 31 Dec 2025 17:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="P2mJbFiI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D822459C6
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 17:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767202646; cv=none; b=DQO3bibzVCIm40O623xSsX0Jy5RtbbbA72Z9IGWWuutilnqS2WfODSdUz5nBhS5aiJ1U2ZU22cdieqArUqwxIvvctNuEI3qMK0OKK8hkdy1KXzEZdh3oWvEafbTI4a+B68YaIMnzln3VgS8t6Ra8PsGQ0hNJJxqTfQ+qZf1BSz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767202646; c=relaxed/simple;
	bh=7sztx2cWvWIz9TKeoZ7WJJeq8MyUlFzC//jJbHulVpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/k0z2ZnzULVCav8PpJswrWzqU+HAt6VEeiiu5WHdOi961YMrl4XecBeN81LU9DZLDxWYetaiJr1sznWu4VtyA7MLq6Ok7+VRrkpzjac7d91N+Aw+TreHOI2imM2eFloT/IZjVvBLm+/U75VHx/NJxa4uezFlzDZnavmA/vxZAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=P2mJbFiI; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-88a390056e1so4183216d6.0
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 09:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1767202643; x=1767807443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/dTXIrnjBfrtWAAe53M4yTIg6PHJwwBbAiaJAY560g=;
        b=P2mJbFiIjxyvdqq/JX2llGW/WJojGB4kayCihusbAmL/yNlDIjsOKRLWjRyPWI3DLQ
         2CtA7ap8gGYXNq84Y6oj9Mu6UZcTaq+e5TMThl8Xb14mvo+olG8oZ516c19DahmPmXd2
         HdRU/B3SF2w8HaiHu8sFSN4Emg8DGyxDx28yRrZY6tRBPMshz+mgTha/6tpLs/DGoFD4
         8/kh/QbLbSbe0bKmG2pkNdWssaIwZ8MMMM/OQDrVjy0sw/eSHReM/UvSf/POjb18OOnG
         xdGuC9qHSgN+Y/8no06Ff/Q17rMSad4HBKIVUdAralaCrnDcWBheu4icsbsd4lR2Oxc5
         C0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767202643; x=1767807443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f/dTXIrnjBfrtWAAe53M4yTIg6PHJwwBbAiaJAY560g=;
        b=ZmPBcqQwBSsEz1ClGMfrTzLta+ncPBPDUswqHFVRN3wpzPhkDHNJSI3/oIUGJpNmG+
         VCC4NvgEEoLRmrhMCdirUR1xRc9y//rdHxLUUwL4n7Y1XlqC1Prox60i/EATq86J20b3
         AxfJ+0Ii6fbfatcFkEPYye+44Feg7SzkDpvVEr63gIyXKbxWuW+hW7RSjJANcLK557nT
         qpSddba5QZ80IaUS/HqQA4WeqpRLqG2d1aMr+ZsBA1hiOrQ7HcgySz0BfjdtcYgqUsZw
         rEigVJrFZL0NGmotQavn6pUnXhPOSkOugoH/aPockx4/esyC/UiZshstlUUbA+/nQL5m
         7cQw==
X-Forwarded-Encrypted: i=1; AJvYcCXYsXYzRnIFvCBG4ArbHP9YIPj3aCInivHzw1CAA3kZkAKC1PXY9zzWrngVmvYCPcHHg+qS9Ig=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe/seNucMEVcMIVhqRtHWC1LS0R/alyNCOIjMDVALZ9Iab1Afa
	j/9hsDHr55oIUwDenVyshX0O8xmFRFVLBSK/QbQdoYxvZ15UVgPl7JcMrxS4pe5MrVKHM6O1seB
	pvfUP8A/W8axmpn5rkvo3NKMAmq46wnbvxEsBBD0ieNuZWOA6DleS
X-Gm-Gg: AY/fxX7G/Jo2GtNSNZjLbnb3ookjHXOV6TTr9mRVoh9B4af5K7Z7lBIX6R2MYFvmmjL
	TyeRfw4ooP2mOElF+qJlLODDWkVmYWNZPEaFuLohW4+tJ6vFImNBE9CW8j/QI/J+oygiIWKrYdX
	vsSJzjZxgJlQjV/BM1RSwdfIVSaYDo4oiBtUf+CXt9/eBENe/wWCVyGxBEqLucrDBcS/muSYFz/
	g9P5lXNWepwR0TNH9TMRh0UAeksk/2DqPoNcEOHl/dHPA8wpZUpdivSt9MEW4VBQLiH+1xeVuG1
	4aGCmpvMw/Ld2i4LwPRbkX0yBokkIHSnAkFUiq8OB9Nad8h7IfOo6skhdHCNv5JuV9SN/GcCUaP
	qNQPQJ1NNhGJsapgNpYIauzoHzBQ=
X-Google-Smtp-Source: AGHT+IEwtYVxzJM5e94yPY3BVIRxsLzn9rKk7vTIuxyQqU0ow24Nub5lypi+z+bUWbmSnwSzc3qVcPo88ZOY
X-Received: by 2002:a05:6214:1c05:b0:880:6fa4:f55c with SMTP id 6a1803df08f44-88d8404da77mr466260576d6.6.1767202642560;
        Wed, 31 Dec 2025 09:37:22 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-88d97a82a66sm46301936d6.16.2025.12.31.09.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Dec 2025 09:37:22 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.49.34.222])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 79CB9340681;
	Wed, 31 Dec 2025 10:37:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 71A47E4234A; Wed, 31 Dec 2025 10:37:21 -0700 (MST)
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
Subject: [PATCH 1/5] bpf: use const pointer for struct_ops cfi_stubs
Date: Wed, 31 Dec 2025 10:36:29 -0700
Message-ID: <20251231173633.3981832-2-csander@purestorage.com>
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

struct bpf_struct_ops's cfi_stubs field is used as a readonly pointer
but has type void *. Change its type to void const * to allow it to
point to readonly global memory. Change the void ** casts of cfi_stubs
to void * const * accordingly.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 include/linux/bpf.h         | 2 +-
 kernel/bpf/bpf_struct_ops.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 4e7d72dfbcd4..d74189ea1066 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1977,11 +1977,11 @@ struct bpf_struct_ops {
 			   void *kdata, const void *udata);
 	int (*reg)(void *kdata, struct bpf_link *link);
 	void (*unreg)(void *kdata, struct bpf_link *link);
 	int (*update)(void *kdata, void *old_kdata, struct bpf_link *link);
 	int (*validate)(void *kdata);
-	void *cfi_stubs;
+	void const *cfi_stubs;
 	struct module *owner;
 	const char *name;
 	struct btf_func_model func_models[BPF_STRUCT_OPS_MAX_NR_MEMBERS];
 };
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index c43346cb3d76..42cfc3e0bc68 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -321,11 +321,11 @@ static bool is_module_member(const struct btf *btf, u32 id)
 	return !strcmp(btf_name_by_offset(btf, t->name_off), "module");
 }
 
 int bpf_struct_ops_supported(const struct bpf_struct_ops *st_ops, u32 moff)
 {
-	void *func_ptr = *(void **)(st_ops->cfi_stubs + moff);
+	void *func_ptr = *(void * const *)(st_ops->cfi_stubs + moff);
 
 	return func_ptr ? 0 : -ENOTSUPP;
 }
 
 int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
@@ -444,11 +444,11 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 				mname, st_ops->name);
 			err = -EINVAL;
 			goto errout;
 		}
 
-		stub_func_addr = *(void **)(st_ops->cfi_stubs + moff);
+		stub_func_addr = *(void * const *)(st_ops->cfi_stubs + moff);
 		err = prepare_arg_info(btf, st_ops->name, mname,
 				       func_proto, stub_func_addr,
 				       arg_info + i);
 		if (err)
 			goto errout;
@@ -833,11 +833,11 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		*pksym++ = ksym;
 
 		trampoline_start = image_off;
 		err = bpf_struct_ops_prepare_trampoline(tlinks, link,
 						&st_ops->func_models[i],
-						*(void **)(st_ops->cfi_stubs + moff),
+						*(void * const *)(st_ops->cfi_stubs + moff),
 						&image, &image_off,
 						st_map->image_pages_cnt < MAX_TRAMP_IMAGE_PAGES);
 		if (err)
 			goto reset_unlock;
 
-- 
2.45.2


