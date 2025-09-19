Return-Path: <netdev+bounces-224922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0F1B8B9BB
	for <lists+netdev@lfdr.de>; Sat, 20 Sep 2025 01:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE0D258721D
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 23:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CDB2D8DA6;
	Fri, 19 Sep 2025 23:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WALifacZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C821F2D77ED
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 23:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758323399; cv=none; b=pbWQjyoougtsc3FUPLtCxUErTW85gxXaLg86/4BH/ddwqVlomIHUhhInESLXu5soCI7gkuSpxWGptQhGL2qByCxK6uK7qWYKKbQXImUcScQ2VGvOtMHaIa05McKV+lOb3X02S/yn0LkRXoasiqZsWcZyamb35+U7tQK81CWyKQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758323399; c=relaxed/simple;
	bh=pcXardvoZJ5x13AoTWxdTEydJ2BB1/tUU6LaU849Aws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nmjrKL99K7aTodSeNrr1xlZHUF6Bn2NNh29Ajkvyck2c7iBrWGFa79VXuDLmQxJCFyHTfC52eRfB/ej/8Ue7z+TgBoQJrLRPgZIB8XlpGMZTyqG2C/H57aLmmsLdEpluo2Ua5GIkxa4y8bdVDIJBJnXve43d+ITpduLO548qzjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WALifacZ; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b54c86f3fdfso2757481a12.1
        for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 16:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758323397; x=1758928197; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=WALifacZWN+iIzhBkABObhUV3iG5yV3uX916LFirjENTn5ZY3v9l+40fTxAVpxx14R
         gGZb8zTVQsRqK8dfCkieG8r7m/tBhYaA3hf2Sd5+A5bI2UKyFHRNBGO9VdWF+A6hGMGv
         4hSU1vLR3nbDZyXVo03cBXJlVDaRQevxSyFKN9DJ13BoQCDXx1gwXFu0WlGaEepsOkPX
         zjZxN3CLwsUkRij5l5ovKvpss6XMmKJ0UIffX+XbhRi1Ce4/6rGgO6kEX9gKg01mCp7z
         wggdhzV7Uv+N0zkaaFjKlEtWBOb5hNnwgqz7NYds+lsbuxP3DZNDAv2ng/N+7CFpC6Fz
         2+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758323397; x=1758928197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/eWmQdzp2gJMKzDrupQRH1sPNWHwWwHav7oa7B7Mo0=;
        b=Dv9yIohkL58PVseNzK8SmYrB3YRQlmC9S8tnZW5L3huwDZeydBpxB7NKBJz9V0XLY8
         bXYnKpmnIKwVRE2URhzl8IBwtzkrgK07pw4U4CZ9Z4NarWNR+m5B13LbnPjtuSpluhhc
         PZZlwRvcypsGJsQALRnN51LnfiszfX/aLx1fBqv1KaUpUjJ8jMG9Afr5Df+drLdSKqh8
         yNSlX64CGrcT5iO+gWRCTvnHif4vNiZyCuf0owEkyDycN8r4Yy4Tawmk7c0I8t5n1l87
         mhaME8s/oi5MS5KZ/BMC72uPP7BQVS6Sdp3U87waAMPaQChcZIfoD9E4pKz0gibLLwMa
         /WXg==
X-Gm-Message-State: AOJu0YwIbuWqqWH0aZDCfsQklpnrGvqkiN9L2OOKFUgZTTdHq89vSqAs
	YREUCtMQ6Ky+sKsSbEMHx4livpmVNhZiIuI8pDp1+/fGHe+R9Cj1yJ0Y1MPghQ==
X-Gm-Gg: ASbGnctCntS2jtwV57jqRLguYwQGXcdEI977ro5pFi6KobwcQENDcLWS0X4A2FjdRW1
	rKDf+Xu0eu8WkINZezUq30xN4bqbDmJV2bXqwKgPF5t0ii6A2c8ppWbgFA+Auyd1KSSVMne3Qgn
	XlSFeKfcsTNJfE+/0yMkiNRM+YFq4ptbeWl5fAosqpka6um2yHRi4cRrvbmltqGSmRtN1KwU1J/
	IpsB2ANsUpAyZDivZC0tfxbYxOq95BKFoiSIZK1dEiYKUwREFr1CBvyd9Rd35/mVsKoyn71Y3uJ
	YKX2488CuzBAAFkEDS4akuuULebYIk+HI4/tLck7kTgk3UfWAatpj0xIma1Au3i0x62boWpwsVT
	YG/mvx/nJ2gh1
X-Google-Smtp-Source: AGHT+IFKBoAz/1ZlBrmFlvmD/RbL1fmSB/1HRKI+iKPRaOGmfLXSkOks6N1F81vSNPT989o7TcuSnA==
X-Received: by 2002:a17:90a:db0a:b0:32d:a37c:4e31 with SMTP id 98e67ed59e1d1-3305c70eec4mr9248642a91.17.1758323397052;
        Fri, 19 Sep 2025 16:09:57 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:9::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed276d2f8sm9348164a91.24.2025.09.19.16.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 16:09:56 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	paul.chaignon@gmail.com,
	kuba@kernel.org,
	stfomichev@gmail.com,
	martin.lau@kernel.org,
	mohsin.bashr@gmail.com,
	noren@nvidia.com,
	dtatulea@nvidia.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maciej.fijalkowski@intel.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v6 4/7] bpf: Clear packet pointers after changing packet data in kfuncs
Date: Fri, 19 Sep 2025 16:09:49 -0700
Message-ID: <20250919230952.3628709-5-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250919230952.3628709-1-ameryhung@gmail.com>
References: <20250919230952.3628709-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_xdp_pull_data() may change packet data and therefore packet pointers
need to be invalidated. Add bpf_xdp_pull_data() to the special kfunc
list instead of introducing a new KF_ flag until there are more kfuncs
changing packet data.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/verifier.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1029380f84db..ed493d1dd2e3 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12239,6 +12239,7 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_skb,
 	KF_bpf_dynptr_from_xdp,
 	KF_bpf_dynptr_from_skb_meta,
+	KF_bpf_xdp_pull_data,
 	KF_bpf_dynptr_slice,
 	KF_bpf_dynptr_slice_rdwr,
 	KF_bpf_dynptr_clone,
@@ -12289,10 +12290,12 @@ BTF_ID(func, bpf_rbtree_right)
 BTF_ID(func, bpf_dynptr_from_skb)
 BTF_ID(func, bpf_dynptr_from_xdp)
 BTF_ID(func, bpf_dynptr_from_skb_meta)
+BTF_ID(func, bpf_xdp_pull_data)
 #else
 BTF_ID_UNUSED
 BTF_ID_UNUSED
 BTF_ID_UNUSED
+BTF_ID_UNUSED
 #endif
 BTF_ID(func, bpf_dynptr_slice)
 BTF_ID(func, bpf_dynptr_slice_rdwr)
@@ -12362,6 +12365,11 @@ static bool is_kfunc_bpf_preempt_enable(struct bpf_kfunc_call_arg_meta *meta)
 	return meta->func_id == special_kfunc_list[KF_bpf_preempt_enable];
 }
 
+static bool is_kfunc_pkt_changing(struct bpf_kfunc_call_arg_meta *meta)
+{
+	return meta->func_id == special_kfunc_list[KF_bpf_xdp_pull_data];
+}
+
 static enum kfunc_ptr_arg_type
 get_kfunc_ptr_arg_type(struct bpf_verifier_env *env,
 		       struct bpf_kfunc_call_arg_meta *meta,
@@ -14081,6 +14089,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 	}
 
+	if (is_kfunc_pkt_changing(&meta))
+		clear_all_pkt_pointers(env);
+
 	nargs = btf_type_vlen(meta.func_proto);
 	args = (const struct btf_param *)(meta.func_proto + 1);
 	for (i = 0; i < nargs; i++) {
@@ -17802,6 +17813,8 @@ static int visit_insn(int t, struct bpf_verifier_env *env)
 			 */
 			if (ret == 0 && is_kfunc_sleepable(&meta))
 				mark_subprog_might_sleep(env, t);
+			if (ret == 0 && is_kfunc_pkt_changing(&meta))
+				mark_subprog_changes_pkt_data(env, t);
 		}
 		return visit_func_call_insn(t, insns, env, insn->src_reg == BPF_PSEUDO_CALL);
 
-- 
2.47.3


