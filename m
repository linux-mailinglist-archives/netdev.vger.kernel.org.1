Return-Path: <netdev+bounces-247022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ED6ECF3798
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 13:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9E2B4303C214
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 12:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AD93358DE;
	Mon,  5 Jan 2026 12:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JNVeU+u5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F1D3370EE
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767615300; cv=none; b=dy37t9rq8aCftIaNB86zXac0yJnkq2vAjQY3VDErThz9+zyTFemTFuMZgA2Djv4flVzHCXcYbtc7u+MfbxkqPOKdKAWGSshUHhaaCIiYPUWQVud2HoExXymrJpoS4sjsXHdu5qLwzk2OJF85EIKxCPxyZOBFTDrCgERXO9XP6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767615300; c=relaxed/simple;
	bh=/RTXIEaeAOB8N6tXgc0QHew6YDHppAaUiUHmnUBmhf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OJ/3Bn607jjlFhIp/gYa8FL/EG0hymbFX9xJdtPT+UkOFeqw/IC1IuNZiLhudTbpybyOCKZmYBB9E05WYLgUzycXvrrpbqTrHkdb2HqeDdSNBEJwdDS5M3BgWSb0O8IvWE7EHXUvvLx+b8lciNE28envpXcz+GJ+z46lhSx8WBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JNVeU+u5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso1893823566b.3
        for <netdev@vger.kernel.org>; Mon, 05 Jan 2026 04:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767615296; x=1768220096; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i17ZOEv88IUPvsCeeQIPsmFfWW2ihyTdJvy10I9K4EE=;
        b=JNVeU+u5fhBJdobbriv7vryU5vl5baLICKJgM/jeCqkjKX7nsalFdjkDyGHIc1vyFK
         G5DWTwI71E8sIb+0ly40Gy3Z+8X4aiBnrZjJ0jtTe12PO76U3t+kXlbgaGNkPAb3bITA
         uAs+me1TDf2f1qZPaJtEIdwPkVOv9WQqtTzNM6pRdZj/eV4sYlfgjqDmGg6lbERGgkWV
         JAEPt+HImAAhVRG9ZbrLKoG2Lagp6Dsio6hA9QOb/G+YQSBPnIH94MEleFHk/9zRO4kE
         XBqQaDggx22COVYIl3xnBQsCKLpEm7BWPEaHZN9vuB1Ptww+odgRdo+yfV5QxNCkjBbz
         GG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767615296; x=1768220096;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i17ZOEv88IUPvsCeeQIPsmFfWW2ihyTdJvy10I9K4EE=;
        b=KJ6BUuL4ggWFoOFoBR1z98+GUgl/d+gV0KjsT8Y8WiYvpM0W6toIxKrL3sJiQ1NkL6
         gdlUptJ17UWMaK3PT/wQWjXt8Z4xTetHPp7aSzsDF7BESoit6oDETTn56WHhg87w6iSv
         k7eoDzYij6qFJ3q3CK/oO24XvQpciL0WFHPxTUNeWj5ewCG5yCt4A5oTAcipYCDEu8ek
         NwKYRhDA17AYeVq9HJ8pxLvb0y179nA6dwtVt9BFRjf/DJij/22q6Z/ToWBWrZGtyAAw
         JAffUPM4zZIGyEBRRgZk4LwxH9lrCG0Xk/V0PJ7y28rvzAoRCPMxXN3YdNaPZOwjbzz6
         a9mA==
X-Gm-Message-State: AOJu0YxN6G7TG9Gz9QZpH5t05QTGDr3JI395g+IAFTJSYnV5d8+NlPXf
	tCe0hUX4FliUgPPJmJWe2NHqVnWVpWJ+AfIUucHQsnNuAwIzceixcK552A5/BvCbc0o=
X-Gm-Gg: AY/fxX4JwNCyMFbEWfkRdAbzq2a2s8OcBjz+jEnWLSX01ebH0g62QtB4MNPrc9l0rgB
	93WfNxukOK6BNmdT8Iz0Jn0b0abOe+1Ytk/O61nk1yk3QgyidtjnQWEIfX59TLxZOrHngKb2qGJ
	IGmXJwHrh2AI3Nl0DCqH5XZmvK60RR2LZfIu4EG5cmtU30To7gZmlx6kza6C+eeN1AyuCBoOhjf
	BYvDYuAvAzPSe0+wrAXAuVW2eLO7f8Q6yjFjBPKjFP19hnmG6AJHWHGEqkg8hqG371P1ISdyTzJ
	xPjDArQ6Mr/pHXS3y0S8Y/wDxbO+grVDUbhogJI8sv4xRo+ed0BASIF7/hbM05cqHR4EYh77WEx
	S8L1UAGXmaFWjUwVYdlFCRUTUz6DEej2u73Yh/+ODDBRcL1Qv+ARUBN0LFHA2Ogn7JFo6pZGspM
	fobVmK8mW7y0UEGUp8qskOBNEMM4YBHS0GavY3E71C5GudXczz7fWUtP2FLGY=
X-Google-Smtp-Source: AGHT+IHFtAXT8wrbFXnrryfLVZu8ll4KpRHg/kmcKQVowTW2A8nxw6/HzXImIkzNk9vZ0ubPmARkCg==
X-Received: by 2002:a17:907:1b0f:b0:b83:ee0d:e03d with SMTP id a640c23a62f3a-b83ee0de13amr577260466b.19.1767615296321;
        Mon, 05 Jan 2026 04:14:56 -0800 (PST)
Received: from cloudflare.com (79.184.207.118.ipv4.supernova.orange.pl. [79.184.207.118])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037de1421sm5611280866b.41.2026.01.05.04.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:14:55 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 05 Jan 2026 13:14:39 +0100
Subject: [PATCH bpf-next v2 14/16] bpf, verifier: Track when data_meta
 pointer is loaded
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-14-a21e679b5afa@cloudflare.com>
References: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
In-Reply-To: <20260105-skb-meta-safeproof-netdevs-rx-only-v2-0-a21e679b5afa@cloudflare.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
 kernel-team@cloudflare.com
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
index c8397ae51880..b32ddf0f0ab3 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -649,6 +649,7 @@ enum priv_stack_mode {
 
 enum packet_access_flags {
 	PA_F_DIRECT_WRITE = BIT(0),
+	PA_F_DATA_META_LOAD = BIT(1),
 };
 
 struct bpf_subprog_info {
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 558c983f30e3..1ca5c5e895ee 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6226,6 +6226,10 @@ static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, int off,
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


