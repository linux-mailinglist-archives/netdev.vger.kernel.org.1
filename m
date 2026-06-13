Return-Path: <netdev+bounces-298834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1u41GguiLGpYUAQAu9opvQ
	(envelope-from <netdev+bounces-298834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:19:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E5767D3B7
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 02:19:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=HUMA3xMg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298834-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298834-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B59F32A46EB
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 00:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F061CAA78;
	Sat, 13 Jun 2026 00:18:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538031A9FB7
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 00:18:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781309893; cv=none; b=rJI62bvIaDnBPhO3TZdOk/mKufbLB8CTT02Da/dC9Vcaa6gZQjyxQIdsMxXUfkQG0LYRPPxzqwfBSaMctIpPXUbQ2PQQIFnPyGzZ+vIzwwpdikqrlfAvRVABuLFSd6dRmDxWAxsVDLtfJ4AxUj2pU8OOquSUzpziNgf5FgQbhKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781309893; c=relaxed/simple;
	bh=fO5bIS7T32qmhvQPtoFme1D+CA70Mblzls9B5czEnB4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BH+Uv7gXrTTLVeS4u8ufNxAYYpLxMPeW2ThS4uFULIP7HFmXaoKoriNuV3So53wcNzIRgpcYYuw+MAxGHcGzDJASmtY5TXYhNZ5OHOpvIFw8aEr3BV8UL/7NeY4A6GslED8ZQbRn6C0sohdK8pHenLAK26CRkvhpahqDDvS053c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HUMA3xMg; arc=none smtp.client-ip=209.85.214.202
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c0c32f4b1bso14947015ad.2
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 17:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781309892; x=1781914692; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9+VMYc+z8VkDSiefkxwsG30lb919a3RxfPEsLaGriGM=;
        b=HUMA3xMgkumL6cNTwk5zanGzQRdzJRFNCtoKC+Lvi9ASztgpD97SXm3HPlqeDLI/Ro
         7fhtQWno8kMTG29nHFypfEeCSK2/01CEEV9rqkL8xqmO/vfr2b5v71d3qH2HmRJOzGdR
         qkumvnvpVZ19aVVMQ1MtMY8gENOKfi20Nxik5QQd3MqzfbCbwbHAT99nx6nQKJgdTcVO
         B4SZUTBJ/2Y2LaumaMtb1Y7OVn1C0YDr3RMiCCiJ/feOz6rsdZ5vm+myjFIRYQZacNv6
         ocvtPMR39ewo6IqX4BzyxFGrFXxGU5P0vqGsMF5U0sDBU4VpFckpm825EB+hB8rA2g7g
         Atbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781309892; x=1781914692;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9+VMYc+z8VkDSiefkxwsG30lb919a3RxfPEsLaGriGM=;
        b=CUmDF1HTtne3uukcsff1NKriaG5BPii7o5qfQH3Xj+lZ3f5rEqrQtkzWEGT1mvEI3T
         GpAGw986tkgLVfubq0yqqskGUE3RRW7jCNB+m0qiXW7dyNd2DUSaPSdxyxWj5DNBQL6H
         y3eVbLbHTZmFPjZVYdNcM4ohxCj4CpFFtuLlToBcAsbBjj9KggPO5Yw4PrdEQ74kimNI
         HgZa1T0+frECTWTP3dvFXW/38H+lqclceGTXuVdat3n3cM3fsGJFZjkgs3FBhwu0OWVS
         TpElUWO5AT2f2cqbhngoOYhGfMDokUuveP+PpbEOaMBkrvpNvB/TMb1mu3k2xf5jusvN
         u8Rg==
X-Forwarded-Encrypted: i=1; AFNElJ/xEsOl7p/WMXrBL9FgQIo1NcLC0LnTYMLO5FM+ij1nO48y01/4iA5nYhR0GGmKqGOyZgmSEq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUqt+LPFp6AP+rzYEScCysagTcBPzjzTlnqmPiuR0V/bGRSDK5
	hrrurUreEunHvW60sjyOm15aK9tv7WolThI33mr5lBKDiiruSCbMtu4uLhRYqTi7a6yiPM/ESnW
	PEJjnjw==
X-Received: from plhz24.prod.google.com ([2002:a17:902:d9d8:b0:2be:bf91:ff92])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2351:b0:2c0:c3ac:4af3
 with SMTP id d9443c01a7336-2c66416ac4amr20227845ad.15.1781309891366; Fri, 12
 Jun 2026 17:18:11 -0700 (PDT)
Date: Sat, 13 Jun 2026 00:17:31 +0000
In-Reply-To: <20260612130919.299124-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612130919.299124-3-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260613001809.1329995-1-kuniyu@google.com>
Subject: Re: [PATCH bpf-next v3 2/7] bpf, sockmap: Fix wrong rsge offset in bpf_msg_push_data()
From: Kuniyuki Iwashima <kuniyu@google.com>
To: jiayuan.chen@linux.dev
Cc: andrii@kernel.org, ast@kernel.org, bestswngs@gmail.com, 
	bpf@vger.kernel.org, cong.wang@bytedance.com, daniel@iogearbox.net, 
	davem@davemloft.net, eddyz87@gmail.com, edumazet@google.com, 
	emil@etsalapatis.com, hawk@kernel.org, horms@kernel.org, 
	ihor.solodrai@linux.dev, jakub@cloudflare.com, john.fastabend@gmail.com, 
	jolsa@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, rhkrqnwk98@gmail.com, 
	sdf@fomichev.me, shuah@kernel.org, song@kernel.org, xmei5@asu.edu, 
	yonghong.song@linux.dev, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jiayuan.chen@linux.dev,m:andrii@kernel.org,m:ast@kernel.org,m:bestswngs@gmail.com,m:bpf@vger.kernel.org,m:cong.wang@bytedance.com,m:daniel@iogearbox.net,m:davem@davemloft.net,m:eddyz87@gmail.com,m:edumazet@google.com,m:emil@etsalapatis.com,m:hawk@kernel.org,m:horms@kernel.org,m:ihor.solodrai@linux.dev,m:jakub@cloudflare.com,m:john.fastabend@gmail.com,m:jolsa@kernel.org,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:martin.lau@linux.dev,m:memxor@gmail.com,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:rhkrqnwk98@gmail.com,m:sdf@fomichev.me,m:shuah@kernel.org,m:song@kernel.org,m:xmei5@asu.edu,m:yonghong.song@linux.dev,m:kuniyu@google.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298834-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[31];
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,bytedance.com,iogearbox.net,davemloft.net,google.com,etsalapatis.com,linux.dev,cloudflare.com,redhat.com,fomichev.me,asu.edu];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,etsalapatis.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,asu.edu:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03E5767D3B7

From: Jiayuan Chen <jiayuan.chen@linux.dev>
Date: Fri, 12 Jun 2026 21:07:46 +0800
> From: Weiming Shi <bestswngs@gmail.com>
> 
> When bpf_msg_push_data() splits a scatterlist element into head and
> tail, the tail's page offset is advanced by `start` (absolute message
> byte offset) instead of `start - offset` (byte position within the
> element). This makes rsge.offset overshoot by `offset` bytes, pointing
> to the wrong location within the page or beyond its boundary. Consumers
> of the corrupted entry either silently read wrong data or trigger an
> out-of-bounds access.
> 
>  BUG: KASAN: slab-use-after-free in bpf_msg_pull_data (net/core/filter.c:2728)
>  Read of size 32752 at addr ffff8881042f0010 by task poc/130
>  Call Trace:
>   __asan_memcpy (mm/kasan/shadow.c:105)
>   bpf_msg_pull_data (net/core/filter.c:2728)
>   bpf_prog_run_pin_on_cpu (include/linux/bpf.h:1402)
>   sk_psock_msg_verdict (net/core/skmsg.c:934)
>   tcp_bpf_send_verdict (net/ipv4/tcp_bpf.c:421)
>   sock_sendmsg_nosec (net/socket.c:727)
> 
> Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

