Return-Path: <netdev+bounces-235984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D8C37B20
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 21:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61860421370
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 20:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51564346FC3;
	Wed,  5 Nov 2025 20:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dkjGpoof"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4108934CFDA
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 20:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762374006; cv=none; b=azt/tQ4kjdEoc+s65FavKMoUdW6hWm4/ElsvTZcrbirfuwvpr/a4A/nUb87pue5dwpZhbU3T1Mo5ibZ/I8tGORHxdJR45Iql9BFuaPfGI/4ERJ/fOdbsVnTEqtPB+foNC3TEszkF+3/pacgdXKi47z7S2bCxVSbLMt9hw74tujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762374006; c=relaxed/simple;
	bh=vCfM6eD/4x3AH4lDp8NXC9l3gFJIHcUEOllrqTSnyb4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iD33gZeSaUseGn5WhGxUCjz2mh0P05hgSwAWE1Ik3GUoSuVNRxcGzjjD0LuxqjIWQdOIexIo0WRcqeDcGHm+NsC7V0eEkFjPcB4nUXxlUxEJURuUKrj1OCr3NCELiWa6PRb/ru/APlcsFtyQI4/ZVvz1kQAvhtyVmzDWFw3t5qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dkjGpoof; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b71397df721so38591366b.1
        for <netdev@vger.kernel.org>; Wed, 05 Nov 2025 12:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1762374001; x=1762978801; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VE4zKA3Lr6vamrKh5y4iU3j8c9W3NoIkC4ZMEr2Y0Bk=;
        b=dkjGpoofJZeOyFX4pFVUACVYbDv9txA1AKZW5qqt68oN21T3Ozbe9utRKPR5xx2VSq
         X6+DfdlPF7n6WdUWJYhXDlEFkjCgNba3+TY0qBHjH7p0om/KUD+Z38N6tmBIAtdFdTMk
         ou1oQ4lD0UWWxl3NKD0N4ELvV717IvGsfOFH8KoSpu5A5VOOX8BsSaVqhUrC7y0q69f5
         GW9Cm/tvOaiBaP0qYWkjkTHBki+OMmYjBfH71SzX7wuK3cnfAg8guxA06Ks+AHSL5jJ4
         IHTycf1s7rXgd0xElZvUZpCr/sN2raFflevmpTvnv4TkeDdSCPr8jV8aSlgbjTebNb4n
         xLUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762374001; x=1762978801;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VE4zKA3Lr6vamrKh5y4iU3j8c9W3NoIkC4ZMEr2Y0Bk=;
        b=UXOUQgWQQlHRpP3nkmzYIfmbvCCsHGgAmDNe08lXvQibhz74JSJjEroey0L71sJ8Zj
         fkEq+pOfO8As3RQUCkq3xcZmZQ9pd7wNLPNUC+oQeJq++5flDjPw0tcweHSsBdtpcHBv
         IeX2PegatkWzoetm6NoP6NYhZJCIgRN8x1HAJC0DoEmw6NeLnySWy7fHaaT2mBQsTBmQ
         ACx/82O1u5dXA9W93KHAZbpAwKJBNUJgriMDjitnMxnfkiztIzapuIpf7WHnae4CHwX1
         X+H6zmqs0iNN0N7XEqzykIf7wwaXdY6X/b2/5w8XGzmLSJ8XHf7Qwu4SoLJLqjF9aE4S
         Ynfg==
X-Forwarded-Encrypted: i=1; AJvYcCVQpfYJ0aLeEgvdayxUV7loeD04tx1d7jERUyRHsVdreXOqlf00KdaBUDQvAt/dRiObw0cqVyk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP9K67NOrIwDkxq6n3ZJjMHpWHEgJvU2Y0tmvXeRc3UEdvnmio
	ehUIbLgGbgd9zUI2NI8va5oQUn0K5FVWIBqUCrldhSkN4jcXvy9TJrZ6TD/0UO83xsM=
X-Gm-Gg: ASbGnctMQlxYYoQ8iGwudQmZ9mnyn+MaNv6tt9Sy0g52SkZU5dKao16QeT7DU3vU9ZB
	crrxcPIFkkpY7Xa2bnx7xq6+Mf+UwO750hLY+rmB9dpFu3JLQFod+js2dpQzewEyVADcCHSN/tf
	CcfCKB6T7C3YG1iNMk25fAcEvlmJdcvUXmONt6pc5qYh/uH95WpIWVQcWM3l96+aG+TKPaFFCim
	Zyxxl2b/kEjBTGBBwoiSSBQLDdOibqNcdRQRw6hoWiZUMQTj+Kk1Q5isGKgeWO2uD2vCpWAoauA
	fglP8idwuIamIJlsFuVP+ZQmKY+9uWaN6Y3IfHKy6PPh1fS9AdL4NVMeQzr8Rq2/PsLaj3bzQBf
	NYCTMy+wY9vCQ1RjJolN8RIkfo+gK9WcYMN+YDagpykYXoh33V+9Y46LvPi602KzsVB7YQDFybp
	hMYQ3rAjZTSDXhXNNxMXPVUTJ30Ft1FwaP6S56bMi6ZnJ2Jw==
X-Google-Smtp-Source: AGHT+IFKXf2tUPyc/JPWAMb1s7hBMAvDTXGcN4NW54DNkOoIZqTkesWdoqG6VDY96AgSDq/2VuOkPA==
X-Received: by 2002:a17:906:4fc7:b0:b70:9f38:dc1d with SMTP id a640c23a62f3a-b726569338cmr439644066b.63.1762374001467;
        Wed, 05 Nov 2025 12:20:01 -0800 (PST)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b728933429fsm46709866b.9.2025.11.05.12.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:20:01 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 05 Nov 2025 21:19:45 +0100
Subject: [PATCH bpf-next v4 08/16] bpf: Make bpf_skb_change_proto helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-skb-meta-rx-path-v4-8-5ceb08a9b37b@cloudflare.com>
References: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
In-Reply-To: <20251105-skb-meta-rx-path-v4-0-5ceb08a9b37b@cloudflare.com>
To: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Arthur Fabre <arthur@arthurfabre.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, 
 kernel-team@cloudflare.com
X-Mailer: b4 0.15-dev-07fe9

bpf_skb_change_proto reuses the same headroom operations as
bpf_skb_adjust_room, already updated to handle metadata safely.

The remaining step is to ensure that there is sufficient headroom to
accommodate metadata on skb_push().

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/filter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 370ddc61bc72..9d157d71277e 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3333,10 +3333,11 @@ static int bpf_skb_net_hdr_pop(struct sk_buff *skb, u32 off, u32 len)
 static int bpf_skb_proto_4_to_6(struct sk_buff *skb)
 {
 	const u32 len_diff = sizeof(struct ipv6hdr) - sizeof(struct iphdr);
+	const u8 meta_len = skb_metadata_len(skb);
 	u32 off = skb_mac_header_len(skb);
 	int ret;
 
-	ret = skb_cow(skb, len_diff);
+	ret = skb_cow(skb, meta_len + len_diff);
 	if (unlikely(ret < 0))
 		return ret;
 

-- 
2.43.0


