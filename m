Return-Path: <netdev+bounces-298844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /t+UMvGnLGpOUgQAu9opvQ
	(envelope-from <netdev+bounces-298844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:44:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAC867D574
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:44:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=RmIdU2jV;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298844-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298844-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B95F316C42E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA1722B594;
	Sat, 13 Jun 2026 00:44:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9316521CFEF
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:44:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781311469; cv=none; b=txkKrymmwktwHlXq/ybW3paKv8Owf23tAa2sEq2jozsG+Ct0l/oQ8oTDnHzMfSPBaU77wCLVCVk473q6y5OZazcuNc/2cRxzPGFfHduKbl/BLUoeAKafZV08/lCokpb3BcfdbZ75RL3H4ASDcdVuiJibeuwHhLDDllmNL581VA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781311469; c=relaxed/simple;
	bh=Tn7ej/8bpTZPZT3FAt7K90hmxt6AummHBhAcDjCJFgE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ChpPojXbfoz8mg5ci/kAJnLxFz0gCID6sPp5v4djTTGuRgII3SKnLqPV8sZCKjDJ1ytDr8IjqhnH87g8q73cmmSDa05dpoXu/XHdkinbWPjrNm1WmQ3oq+MRMGNh48e3Mo4KRSXGdcDFfwLLPcOp7KuJVy3+N49rDUQKr+qp7VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RmIdU2jV; arc=none smtp.client-ip=209.85.216.73
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-36bc5e97950so1719372a91.1
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781311468; x=1781916268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GdSWAaXQJk4NhbjCX9jOP5RFV/noRIR3yFDGGrPquyo=;
        b=RmIdU2jV1C8CJe8EPYElgzSqa4i3FnlGMQUTTrCvBUGO6hYkI7peMDOp327jmjwCUI
         22ZlRhzD6JwbeTtqSYIsy1h5IIn0JBVZt8td7l5fAH5F/gSpY6j9plesYh9+xRAbLCcF
         apweIUx0biRGGTFHrBMyiNv0fvqnd04vLVCjWx4gmtdphroRCUJJxPlwg+0Csn1KUAtb
         w911zRrHf48+iYgZHtIWwkKN/o2/0aYA1uHg16LP6exg8J1V3qSdGyksLWf1m0OEEb+1
         d9nWdnkgM2FPJO4DD1I+ZDmZ1xohQ+24xcWoYFa7tjf4BfzyWvX4sTe4X1Z2mN+RI5+1
         05Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781311468; x=1781916268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GdSWAaXQJk4NhbjCX9jOP5RFV/noRIR3yFDGGrPquyo=;
        b=qw9hw6VPifag4c+HYwrBd4aBF86QrX7Jd7YK/eQx2k3skodp6UtQmaqHQrDfZhJJBM
         C1HNjKvXN+hx1YPc3AXy0OyS8oqgug6TIYuVHF+kqeMEoK0fVXbMNaEFvf2ekdcMPbeT
         Hx+7JMmhC+jYoWSltkLVCGQ7/DV0S2CfCIHpqfD7FKtWssYAyuI/DAdI2zS7JFTW6hEv
         xN1rjhbmU4TZ+Yg8BzVdkc32dh0df+oSa/rsa+w5w05gAi6b/cSZn5MjLPsXJOH4rxRp
         ZzXOAvLgSvhZ1BAqFRg0wHuyIn5Ea/xRFzjxTJ28Le2WX8LMfF4/qS+QCndAm1nJGfUW
         FeWw==
X-Forwarded-Encrypted: i=1; AFNElJ+QLsCKoQffg73gFiTGZ4X5riPX/qFe9UHy8J3P6ctZsuDgUzsdjteAqm1lH/ATntm18i8qHzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE/WfunMxEgkgbgYnlQe+iH+wRgMkhxtyCcq91VUlru23UIJ4Z
	s1VWH41TJB2683gZPRfRSPDJvXiXboCamlVvUOalxOQYJT/ZoWsflX0efLa0zzpJKM3BzRIXLSX
	kaZE7DA==
X-Received: from pjyt12.prod.google.com ([2002:a17:90a:e50c:b0:36b:a12c:2f0])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:4c:b0:368:ea0c:1b75
 with SMTP id 98e67ed59e1d1-37a01c36550mr5265091a91.6.1781311467684; Fri, 12
 Jun 2026 17:44:27 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:44:23 +0000
In-Reply-To: <20260612130919.299124-7-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612130919.299124-7-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613004425.1347589-1-kuniyu@google.com>
Subject: Re: [PATCH bpf-next v3 6/7] bpf, sockmap: fix integer overflow in
 bpf_msg_pop_data() bounds check
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jiayuan.chen@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	cong.wang@bytedance.com, daniel@iogearbox.net, davem@davemloft.net, 
	eddyz87@gmail.com, edumazet@google.com, emil@etsalapatis.com, hawk@kernel.org, 
	horms@kernel.org, ihor.solodrai@linux.dev, jakub@cloudflare.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, rhkrqnwk98@gmail.com, sdf@fomichev.me, shuah@kernel.org, 
	song@kernel.org, yonghong.song@linux.dev, 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298844-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[29];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:andrii@kernel.org,m:ast@kernel.org,m:bpf@vger.kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:hawk@kernel.org,m:horms@kernel.org,m:ihor.solodrai@linux.dev,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rhkrqnwk98@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:song@kernel.org,m:yonghong.song@linux.dev,m:kuniyu@google.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,bytedance.com,iogearbox.net,davemloft.net,gmail.com,google.com,etsalapatis.com,linux.dev,cloudflare.com,redhat.com,fomichev.me];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linux.dev:email,etsalapatis.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FAC867D574

From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Fri, 12 Jun 2026 21:07:50 +0800
> From: Sechang Lim <rhkrqnwk98@gmail.com>
> 
> start and len are u32, so
> 
> 	u64 last = start + len;
> 
> evaluates start + len in 32-bit and wraps before storing it in last.
> The bounds check
> 
> 	if (start >= offset + l || last > msg->sg.size)
> 		return -EINVAL;
> 
> can then be passed with an out-of-range start/len, after which the pop
> loop runs off the end of the scatterlist and sk_msg_shift_left() calls
> put_page() on the empty msg->sg.end slot:
> 
>   Oops: general protection fault, probably for non-canonical address
>   0xdffffc0000000001: 0000 [#1] SMP KASAN PTI
>   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>   RIP: 0010:sk_msg_shift_left net/core/filter.c:2957 [inline]
>   RIP: 0010:____bpf_msg_pop_data net/core/filter.c:3103 [inline]
>   RIP: 0010:bpf_msg_pop_data+0x753/0x1a10 net/core/filter.c:2984
>   Call Trace:
>    <TASK>
>    bpf_prog_4cc92c278f4d5d56+0x1b1/0x1e8
>    bpf_prog_run_pin_on_cpu+0x107/0x320 include/linux/filter.h:746
>    sk_psock_msg_verdict+0x357/0x7f0 net/core/skmsg.c:934
>    tcp_bpf_send_verdict net/ipv4/tcp_bpf.c:420 [inline]
>    tcp_bpf_sendmsg+0x766/0x1ae0 net/ipv4/tcp_bpf.c:583
>    __sock_sendmsg+0x153/0x1c0 net/socket.c:802
>    __sys_sendto+0x326/0x430 net/socket.c:2265
>    __x64_sys_sendto+0xe3/0x100 net/socket.c:2268
>    do_syscall_64+0x14c/0x480
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
> 
> Widen the addition with a (u64) cast so the bound is evaluated in
> 64-bit and a len near U32_MAX no longer wraps below msg->sg.size.
> 
> While here, change pop from int to u32. It counts bytes against the
> unsigned scatterlist lengths and can never be negative, so the signed
> type only invites sign-confusion in the pop loop.
> 
> Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

