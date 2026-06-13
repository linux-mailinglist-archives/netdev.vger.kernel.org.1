Return-Path: <netdev+bounces-298842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VxMwLjKnLGrdUQQAu9opvQ
	(envelope-from <netdev+bounces-298842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:41:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B741967D55E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:41:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ETmbmN5s;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298842-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298842-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C41313007B38
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8227F239085;
	Sat, 13 Jun 2026 00:41:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D820021D596
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:41:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781311264; cv=none; b=sE+Ntkaw08ZXHClXsC1Wuip3UCZHfEVnOvc+yDybygFYsMgDoBICRhTveXohN6JWnI+5mAfcnUo0Va9scaqzc57RJygVTlvn7aZNL63i8Wql1pQi8W7fLWHWyjpEINn35jC+oNfFgc2H43jXa6FEbYo3ZOC/RnrlEXyQfaI69FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781311264; c=relaxed/simple;
	bh=nqBmvPVSuONjQVqzPSMr32HkpDt0vtwCdsouKbN1iw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=anFxuXbOuc4ygToYMVwqDqd1w7ZwNr9Q/SASYS43wXW9zxjfQG/9GS9TQwCwUD3qNPA2w+HqQDyxAk2QAb/a2AbdlOvba2U0Zig7FbF0qCC3M9V8Dxtk66SPnVjMXJKhNbpOQvFW9TMQEPxhRNgNpBFLdBs8W0BaDznjaO9raks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ETmbmN5s; arc=none smtp.client-ip=209.85.210.201
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8423770d72dso2004162b3a.3
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781311261; x=1781916061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JYBMbR4kq4DVj1z4XvYsJCTDnmw6aLGbpem+9EfbHqw=;
        b=ETmbmN5s1MHr5rMQeaCNEIjGg1Q7zCAsI8YKpJQ3/1b44T1dAdI9GkZEQTp1EfczPW
         /rwj5XtBZsHqa/RsbF5RUbSg67jVD4EEVW0+D4Y3zfLP0zR+f8DQpevSPcBR48WCgF/y
         St9aqqY+P9f60mo9Ru1SKZGb+ffP5ZIMmibG6D80DdRKR9Q/7b0BmEYVwoJaJqn0wS6O
         bSdVSb7VY4Q9ZHbPaSuRIfy8IZMzacVXor8HQwKT3C3hWeYXmMzN20WcQlNUk7Mx1m1v
         sg3BG5XxH9E+zKcQUhT59FqSxfUwH2l5cJbjtdFg8nrLgylTJclkOva7fu3fDf8W0hgq
         TZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781311261; x=1781916061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JYBMbR4kq4DVj1z4XvYsJCTDnmw6aLGbpem+9EfbHqw=;
        b=pcODQIdNCxrwrMwDg7WYi+d9BxgO4jF+KcY9iB4RI1zlvW53zHXOCrzmPhctTZNKbV
         i8bucUjtrpryDXmXD/5b8elnQIWQsZ8b73wpZ9IMy0a3kGV/kd9LZdvBHsvaidwrearb
         wvE44Ff4rdXVelvOnuIcOAJ+12utXweeTdRQriX4Te+j614zeeWj/TFMV5b0ECcAxbOu
         bWHNVYca5HCm7nkvhmJR66tCpuyCvrrNc4D1HpSY6PJfX+9hl4xmRlFD+SjSuO80g8uj
         Wk/pb2X8xs4C4uBIg5VVUdnlmtSeeitffNM9/TMDPuJnNBRKa9ImUXDHA3VDaZNC0r9n
         vM2A==
X-Forwarded-Encrypted: i=1; AFNElJ+SES21b5DmMG2M80Y1dbEZYDZN5XT2+t6jXQb0B1rLOwLLnULwNOBdrhuVTw6+7GVISXvSixg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/chmQjiDyP+7c1Dz3+TyvpH3gzS+xfwuyK+7RNiAU+npTdQP
	x7X9QE4RJh3pydlvEZS9PvHdioHNm2DdVz2lBLCulgqO3+yGkwMg5Xdsc+D5eevbKV2lAkWM3vF
	QPN7fRg==
X-Received: from pfbmy11-n1.prod.google.com ([2002:a05:6a00:6d4b:10b0:842:4be5:5ed6])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3c84:b0:841:dca1:8b69
 with SMTP id d2e1a72fcca58-844e193a47cmr2006688b3a.5.1781311260910; Fri, 12
 Jun 2026 17:41:00 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:40:41 +0000
In-Reply-To: <20260612130919.299124-5-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612130919.299124-5-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613004059.1345029-1-kuniyu@google.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf, sockmap: keep sk_msg copy state in sync
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jiayuan.chen@linux.dev
Cc: 2045gemini@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bpf@vger.kernel.org, cong.wang@bytedance.com, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com, 
	emil@etsalapatis.com, hawk@kernel.org, horms@kernel.org, 
	ihor.solodrai@linux.dev, jakub@cloudflare.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, rhkrqnwk98@gmail.com, 
	rollkingzzc@gmail.com, sdf@fomichev.me, shuah@kernel.org, song@kernel.org, 
	stable@vger.kernel.org, yonghong.song@linux.dev, 
	Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:2045gemini@gmail.com,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:hawk@kernel.org,m:horms@kernel.org,m:ihor.solodrai@linux.dev,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rhkrqnwk98@gmail.com,m:rollkingzzc@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:song@kernel.org,m:stable@vger.kernel.org,m:yonghong.song@linux.dev,m:kuniyu@google.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298842-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,bytedance.com,iogearbox.net,davemloft.net,google.com,etsalapatis.com,linux.dev,cloudflare.com,redhat.com,fomichev.me];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,etsalapatis.com:email,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B741967D55E

From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Fri, 12 Jun 2026 21:07:48 +0800
> From: Zhang Cen <rollkingzzc@gmail.com>
> 
> SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
> with this bit set are copied before data/data_end are exposed to SK_MSG
> BPF programs for direct packet access.
> 
> bpf_msg_pull_data(), bpf_msg_push_data(), and bpf_msg_pop_data()
> rewrite the sk_msg scatterlist ring by collapsing, splitting, and
> shifting entries. These operations move msg->sg.data[] entries, but the
> parallel copy bitmap can be left behind on the old slot. A copied entry
> can then return to msg->sg.start with its copy bit clear and be exposed
> as directly writable packet data.
> 
> This corruption path requires an attached SK_MSG BPF program that calls
> the mutating helpers; ordinary sockmap/TLS traffic that never runs
> push/pop/pull helper sequences is not affected.
> 
> Keep msg->sg.copy synchronized with scatterlist entry moves, preserve
> the copy bit when an entry is split, clear it when a helper replaces an
> entry with a private page, and clear slots vacated by pull-data
> compaction.
> 
> Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Cc: stable@vger.kernel.org
> Co-developed-by: Han Guidong <2045gemini@gmail.com>
> Reviewed-by: John Fastabend <john.fastabend@gmail.com>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Han Guidong <2045gemini@gmail.com>
> Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

