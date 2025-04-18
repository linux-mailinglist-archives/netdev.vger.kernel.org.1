Return-Path: <netdev+bounces-184254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E657AA93FF6
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11FB1448140
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A281225393D;
	Fri, 18 Apr 2025 22:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JfYqzh7l"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D3D2459CB
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745016436; cv=none; b=B5J9/4tjFkzoy54wHsaqmTFfFp0wDXyEdWXQZ+D7Qk+CLQBdApIvniDqXWpZ9usEbEYwhAS7fFj5orygmMtPYsL3v6qKxVkT/AymjMzKvtYovBeqiAzV+r1gm+I+ZhSJ+R7fYtI5JMuWiQhSc5/K8ozW0ebBqk0NB8DprYzL1nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745016436; c=relaxed/simple;
	bh=OSgQ/kTYIPP+HEuAEQ39jT6+MWIWB0gAsn10G0y1v9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5QMjBUWzmtrnuY3mTFYeEe3a5mj7EBi4nWrv07mgIQFbh2fllFi/Y8wWyzlNhm9N+qzhoz7cj/1zspAxLZS78weeGtuz/1XGM6kFmx36hMKh7eyYRKLiPFHpR0RQFHlDzxdiXyBJY9W9TWbHmRi6voP2ZtalNSeTgBOAQ5+YJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JfYqzh7l; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745016431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/KTY9VRdQcwLvPSJGuFdTg46U1/5fxyrLnnHuCMXSC0=;
	b=JfYqzh7lN4ueUKEK38QDokrGX6KHhGQuqxw5mcYA7X9xwXfptp47iY1SMDqPMG0OD/s2NE
	XbHJAipfmqC+oBED6vk1ZviP/hIuyzjiPhGklYAoVTqWzyrFHkLt3Eznx8VRfSuKUKVM+O
	8S3ohxk1lXHy6t/RObzTaoijfVp3U/A=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	kernel-team@meta.com,
	'Amery Hung ' <ameryhung@gmail.com>
Subject: [RFC PATCH bpf-next 01/12] bpf: Check KF_bpf_rbtree_add_impl for the "case KF_ARG_PTR_TO_RB_NODE"
Date: Fri, 18 Apr 2025 15:46:39 -0700
Message-ID: <20250418224652.105998-2-martin.lau@linux.dev>
In-Reply-To: <20250418224652.105998-1-martin.lau@linux.dev>
References: <20250418224652.105998-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Martin KaFai Lau <martin.lau@kernel.org>

In a later patch, two new kfuncs will take the bpf_rb_node pointer arg.

struct bpf_rb_node *bpf_rbtree_left(struct bpf_rb_root *root,
				    struct bpf_rb_node *node);
struct bpf_rb_node *bpf_rbtree_right(struct bpf_rb_root *root,
				     struct bpf_rb_node *node);

In the check_kfunc_call, there is a "case KF_ARG_PTR_TO_RB_NODE"
to check if the reg->type should be an allocated pointer or should be
a non_owning_ref.

The later patch will need to ensure that the bpf_rb_node pointer passing
to the new bpf_rbtree_{left,right} must be a non_owning_ref. This
should be the same requirement as the existing bpf_rbtree_remove.

This patch swaps the current "if else" statement. Instead of checking
the bpf_rbtree_remove, it checks the bpf_rbtree_add. Then the new
bpf_rbtree_{left,right} will fall into the "else" case to make
the later patch simpler. bpf_rbtree_add should be the only
one that needs an allocated pointer.

This should be a no-op change considering there are only two kfunc(s)
taking bpf_rb_node pointer arg, rbtree_add and rbtree_remove.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 kernel/bpf/verifier.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 54c6953a8b84..2e1ce7debc16 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13200,22 +13200,22 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 				return ret;
 			break;
 		case KF_ARG_PTR_TO_RB_NODE:
-			if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_remove]) {
-				if (!type_is_non_owning_ref(reg->type) || reg->ref_obj_id) {
-					verbose(env, "rbtree_remove node input must be non-owning ref\n");
+			if (meta->func_id == special_kfunc_list[KF_bpf_rbtree_add_impl]) {
+				if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
+					verbose(env, "arg#%d expected pointer to allocated object\n", i);
 					return -EINVAL;
 				}
-				if (in_rbtree_lock_required_cb(env)) {
-					verbose(env, "rbtree_remove not allowed in rbtree cb\n");
+				if (!reg->ref_obj_id) {
+					verbose(env, "allocated object must be referenced\n");
 					return -EINVAL;
 				}
 			} else {
-				if (reg->type != (PTR_TO_BTF_ID | MEM_ALLOC)) {
-					verbose(env, "arg#%d expected pointer to allocated object\n", i);
+				if (!type_is_non_owning_ref(reg->type) || reg->ref_obj_id) {
+					verbose(env, "rbtree_remove node input must be non-owning ref\n");
 					return -EINVAL;
 				}
-				if (!reg->ref_obj_id) {
-					verbose(env, "allocated object must be referenced\n");
+				if (in_rbtree_lock_required_cb(env)) {
+					verbose(env, "rbtree_remove not allowed in rbtree cb\n");
 					return -EINVAL;
 				}
 			}
-- 
2.47.1


