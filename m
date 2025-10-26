Return-Path: <netdev+bounces-232976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE7EC0A972
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 15:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9333C18A0855
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ABF2E92B3;
	Sun, 26 Oct 2025 14:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jmewu0WS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97622E2EF9
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 14:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761488332; cv=none; b=ha4pCLnNl6DXOcZnbR1KDfftcRYABx6GEfvEFq/8cmxx1/6cTnmgxxV5Qd6S1vnl+Ukgc3hPeL3K3rznttO4SCK5GE1zhLQAL2aIzTgX7jSrb6POQBqkZai5SQdImnK1w4mZazVRcA9xP7LVcLR65wDbQxdjdajBlN2gyEoO/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761488332; c=relaxed/simple;
	bh=Gak4HRUwBOd2FQnLiXDTXLRpQgivj1vf/nGp3J5rI+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=c690h8cECEdwzTuELW7ErUU7kJSbBFcOP+0eS85CLe2d4brhqLGacfIfCcrTBriESUyMsw9HvDDH9FQ02KG9fyqc0XHzKIajS7lWno5jBNyzVjRqB9Pu36TOe7X93CsP6eRY5eVSBQiOvesRnNEbmuIqeF71oxukq/02xiLpHXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jmewu0WS; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63c3d7e2217so7244205a12.3
        for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 07:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1761488329; x=1762093129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSYvzngXAX+S+IrAJeNpu+SkdlG3R21JATkFTa33X3I=;
        b=Jmewu0WSaFA/F7m74l/d4W5oJyVqTrsastsCWQBhevkifAYnZYrlK8C/O5HYZhAaBP
         7pga/+977XfLPAQtR/QAadHi4mqNtWSSO1tAVKckmVooh/LkZAipU9ETOu2Pmt4wLQ3q
         WkhpbbZzEJbTcobPEnJypxtZafD1ttX/qSkJ81YQUQaaxnYR0FJMJ2mYdy6MeUhOcHcf
         bMLHbmk6Kq6jnLgCM9kLWO0WT2IP9ZPIFZMBt0KFAegL/RvkzNu3RPXqCGq9+dkS+MY5
         YsneHBAG0C1J87wPK1bD8xtXiaa/ezsiBVZYmx6NWOiqYmcYJpZyaOIbMP8tiw9103PR
         qnyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761488329; x=1762093129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FSYvzngXAX+S+IrAJeNpu+SkdlG3R21JATkFTa33X3I=;
        b=UaTXOodb+tJIibXOloO5t+x8aDg4adIAQNN9fNbU04gs8tTpIwDyJ9m/eHy7QDj+Ug
         xmlNgBmS23p7sY48SBHVkCWumSrJuxr+eiYk4+EOBb2Y4ItlHDb2q1Kya1E1uqgDXpvT
         uuTwF/Qli/6QWmbh9SCvmGLflWYFxWQiU7g/JLSnuT/fEcdPLNy/+diEr1a6fFHORT0h
         br+eXNtknJG/Tmgq8PUezgCmTPxzd5QjZ+K8rcJ+svNb3cNYYxDShAm4Ig95Kqjh/KLD
         A1jt0h9Em7eOkvdd6OqRrz1x1bMnXSsNTtQzUB7Mj10ucK5U7XRq1gWBbPdDelge9jXY
         bFnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxlU2Ms35sJm6Kda9jG9tFdruWx2uCZcqrNxZM+61AzV7dG+vbWUHpYVDBG5/hw/GfpSAOPL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc5DcbTVBMWOtXxOy75w32nvTlZKSfOZrGfmUzY6RMPAyuRhdn
	jnPgKqfCAlZBuV6GtvkiR3GUnQ3jspv3RZOy8vr/Vwc33pN0lE/c8lihpxEDOvBmUFQ=
X-Gm-Gg: ASbGncsvjMjFiAMr4QCP7JC6w7+i99RHsF47MZ+vWZwreU48W/ARx5dnwdxlwht8ShL
	bORrmTJiyNji7jeG3Jrwz2Cojd7H2xgi1WEtj0KuF0Ecpjkx0dVFNBFcmJHpYFTWF+qUwDWnpwQ
	RbLNPieahdgciQipfPT0rXOEAYTZ4/G2XiILdfBmRQD9Sk7T6t32us2Rjkd4+6H9Uoyaq5O2mjg
	JxHf5uyDSfSRcQ8rSxpM0f/AWY837fCf4b86rMxZ2UsrhAWgfbVmgK/0pL9R79kHzBCZaacq3oD
	selquBPacXsbha2LLn2HCKbRF+DhgYGlfztfnQdv+CNVPmZc4REyFAZgcBuDN7ZWpOE46M1ndgD
	1Gy5i02H9vcLwxfVZ0YXUQTgyUL1ay9IMOOfDUeg22ssuX2ztt5ld/rerqoaJOrwVlJA+6oqjBY
	txqf6+Y4SjDtne9+ZUrY58zEmJfr93Nw0UqBc17nAPjSzV0g==
X-Google-Smtp-Source: AGHT+IElR+KKTIQUVvqZHLDN1tnFR/WtdI9kHI8UMta06H3SpUZDJM8GEaSmKEppAf94BbKvhvPh3Q==
X-Received: by 2002:a05:6402:5107:b0:63a:5d3:6a1e with SMTP id 4fb4d7f45d1cf-63e600f2646mr7077995a12.33.1761488329226;
        Sun, 26 Oct 2025 07:18:49 -0700 (PDT)
Received: from cloudflare.com (79.184.211.13.ipv4.supernova.orange.pl. [79.184.211.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7ef9a5cbsm4076717a12.23.2025.10.26.07.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Oct 2025 07:18:48 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sun, 26 Oct 2025 15:18:28 +0100
Subject: [PATCH bpf-next v3 08/16] bpf: Make bpf_skb_change_proto helper
 metadata-safe
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251026-skb-meta-rx-path-v3-8-37cceebb95d3@cloudflare.com>
References: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
In-Reply-To: <20251026-skb-meta-rx-path-v3-0-37cceebb95d3@cloudflare.com>
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
index 80a7061102b5..09a094546ddb 100644
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


