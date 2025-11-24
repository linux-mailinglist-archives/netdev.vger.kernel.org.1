Return-Path: <netdev+bounces-241220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CB41FC81930
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F16B3348350
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95E931A81F;
	Mon, 24 Nov 2025 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Gj9rRbGI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102531A7F2
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001770; cv=none; b=gwRFC4o3piKl5eOMdP1tmjYWudROI4li5rcbvWRi2u0TiHq0AHDf3m5lqsDS/TsI3nrzz9NdDXsjl9dxJbTDy85yKXzV/6pT33bLh0gcpG63gwHfI2QftCGiIaWryAi631p7mjgCMnzm+Pzh+ukfu0AxRktEYKBr4j7HMopjgTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001770; c=relaxed/simple;
	bh=gn3lwu0lwNNZQxYoDTnJ3/kNnMccZeCRcDy79hG6uvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uOrbyUDLCPE2WwmAu5WOrq4dm9mB2W9B80Hsg5YtzB3u3bebcbv8YTvmQ6jNn0EN8C/4xl1aqG7kew/t0UN/DHnT7IPp98rkhntNK9fO8DmxYUuFBg32m/5kQHty1xOWQE9yYhIrw45rXyArnmdG8t1bb+QDQ8lgPEDkSrBhBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Gj9rRbGI; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-640aaa89697so6228450a12.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 08:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1764001767; x=1764606567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WcnZA3oocUjPm1Pbs0JivQauclUVtFumqh9U/++qzrg=;
        b=Gj9rRbGIcUphfGlsDFaA9dVmOVMIPWugIYQsslLHRV1yTigcmbWBOdUAbcXR5PuVUR
         JI6mUc0/pBioPw1DJ/j6LVjpom3QJ/fMkJdXViuDDCZsuEGETDko8rTeM+Mo7a38mh6K
         7W5Ii0Ed2CPKJW9c+dmzLRm2Vlva3srKvpgdYrmc+91/fu2kKZBgwUAaWAkzG/G8Mwz0
         6vfGDeguCqSAwCCIYpu3A65X2RDt+XsAoTx8n+OFLfcf8aLQQdSPw+3FGJpRA1TVMR+Q
         xyNTy93C0RhDuDFjCu8UCRT+EmMY7d2uhxOLK3Ep11G5+Yf7sHQnnnEco/sixglNzMYQ
         /x9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764001767; x=1764606567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WcnZA3oocUjPm1Pbs0JivQauclUVtFumqh9U/++qzrg=;
        b=pgEckbDZzUFqMZHvZgiGJThTsjLoDaxwpGaJP5/wa7TjdFeAWWtPGRb+0lfhw8hUy/
         zUuAM6izYjvR9VXqmbQhpzN1D8f5CsdyHIZvBqDZVI69J87vZKZ5NK+zZ2JvXPg4YJsP
         qiAJntbOF5CVRCuZ3rLOaxdkZFaUh2SbuQg7QmhhjuEbQExr7c6V7hyoq2wNjlYytXVH
         FvVmprYnIVjEuFocZ1S0kiReDDue/3IQlowwMcN3Vt08tjWNLUBU3iMUyFBpPTsxGn9b
         gljM0J0eZFgqFbiilUY39FX71m4T1lYGLLWDRMf/utcPulugCQ6UITghyPB+xj5tnPak
         W7RA==
X-Gm-Message-State: AOJu0YwqC4sAkv5UuPNsDZiexfmshGc6+u196JPdQ3Jp6LLKVRf1X7Q3
	fSeE8aTuSlfuPCxQMeQQ3RoV5lmH3vKWVXyDW7xfS3f4SAQQ8TmNpWYthWqcLYlF75q2y9ZzP0W
	8ZQBh
X-Gm-Gg: ASbGncuBWeQnoU+3WTPuoKMP5jcvIgK1j0c+ylhejGBeTOpQbM69J9B4Ya3Apkjxgg2
	8zsQLqdiH2pJVzHT3stS8f32l5z+l39gVdYpdqvHjqLOoTQdVjXRTAt5e6NEG1VobkxCwXOcwKW
	gkJL1iT6YYVgnkX7Z2RshJHkBMQoEfLuWogoWmUpgG5UyOrsk7LYAIiCSrPcirZ129rojLIfBJ4
	XwPqN3dPCVj7tHySof6xBkQ7hJlaC+vveaG6o8GBUzs+BpU7+lDz7JavTWleN50fgqwXrGsNiM1
	lLhzXDL8+mbPEpeFNxxnofdP2MdBXt2ODj0fPOWzvsU8wC/pmJSNNOEdpH/wXPk2a93b2DMxp5X
	Nnk+EaeN/00QVifNdr3apXgEEm2YSIfY2V7p++7xfzykhEuxZXSTo4fbWyKp/Z4CyVFngEjZczw
	Uat/XqCigedutVVd9KjbcUAOPpwdonzoTTBTQYRWNONc2FbkQhCjSsIy8Z
X-Google-Smtp-Source: AGHT+IHzHVKZgWlwFJNITVk1pZE24H5+ccpjEjWf8TxJm96X1BCpW4pnpkDGeBI3dUiPPsjpQf2KLg==
X-Received: by 2002:a05:6402:27c6:b0:63e:600b:bc86 with SMTP id 4fb4d7f45d1cf-64554459661mr11495118a12.14.1764001767493;
        Mon, 24 Nov 2025 08:29:27 -0800 (PST)
Received: from cloudflare.com (79.184.84.214.ipv4.supernova.orange.pl. [79.184.84.214])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64536460ee1sm12393313a12.34.2025.11.24.08.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 08:29:27 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 24 Nov 2025 17:28:50 +0100
Subject: [PATCH RFC bpf-next 14/15] bpf, verifier: Track when data_meta
 pointer is loaded
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-14-8978f5054417@cloudflare.com>
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
In-Reply-To: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-0-8978f5054417@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, kernel-team@cloudflare.com, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.15-dev-07fe9

Introduce PA_F_DATA_META_LOAD flag to track when a BPF program loads the
skb->data_meta pointer.

This information will be used by gen_prologue() to handle cases where there
is a gap between metadata end and skb->data, requiring metadata to be
realigned.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/linux/bpf_verifier.h | 1 +
 kernel/bpf/verifier.c        | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 42ce94ce96ba..fa330e4dc14a 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -639,6 +639,7 @@ enum priv_stack_mode {
 
 enum packet_access_flags {
 	PA_F_DIRECT_WRITE = BIT(0),
+	PA_F_DATA_META_LOAD = BIT(1),
 };
 
 struct bpf_subprog_info {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb4e70913ab4..32989e29a5e1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6160,6 +6160,10 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
 		} else {
 			env->insn_aux_data[insn_idx].ctx_field_size = info->ctx_field_size;
 		}
+
+		if (base_type(info->reg_type) == PTR_TO_PACKET_META)
+			env->seen_packet_access |= PA_F_DATA_META_LOAD;
+
 		/* remember the offset of last byte accessed in ctx */
 		if (env->prog->aux->max_ctx_offset < off + size)
 			env->prog->aux->max_ctx_offset = off + size;

-- 
2.43.0


