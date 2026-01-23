Return-Path: <netdev+bounces-252861-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EEU8CveMc2l0xAAAu9opvQ
	(envelope-from <netdev+bounces-252861-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:00:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2CD77622
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 80B303006D54
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A947233506F;
	Fri, 23 Jan 2026 14:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="VupZkdig"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com [209.85.208.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6782926ED56
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180381; cv=none; b=c+D++cDyfOpWkTvx2Fm99nvoKGLqDbvfTWfkv9XfbzE2Y8guQZgkp3mxRhXvH6J/05FP8Jgjo67MeSkpZmPTaFq09xfbTcpilhLFdpsEVflUZroQulZDWIcckJ+H9fkGxWril2v0aj1Rpt0SUE/xTU6ewr9v2+BtM5I4d1CAn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180381; c=relaxed/simple;
	bh=OiiQ6NpHryNtjGVVPD22cyeUNTIH8+XUUWiFi1FnLh8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uO3kwX4eCFq8g9upOtOxwz5GTpjg1ESod2qOsIKVEQ2BZPLW2lU8z1MtJ+YLEKJQOpi4JCAf0ArIoWx5kSUUzs2NNh3T+d/1gtdFvWIq2EpOaXBvQDH5OTPGNP2h7zHiUX4yh9dCuYN99zCs3pI1MSeyLZF8Ig9p0GP2q+bOB8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=VupZkdig; arc=none smtp.client-ip=209.85.208.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f66.google.com with SMTP id 4fb4d7f45d1cf-652fdd043f9so4099712a12.1
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 06:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769180375; x=1769785175; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jkIl7dS+mkiKgOTH9bgq3/o2+8pPlzP+BKaLvYWO3Zs=;
        b=VupZkdigAVADoCnmxfFHhdPVfxedK8utn3d5xY71hhKpK4cDXVOoM4C5+X/EWd17lD
         YCa+8J/fT2asK14qObzGjC/pEURnemMM8DlghYwX7xKeueJo3XW3nM4CdygS46ftt9lo
         KEBL2+ydeppjIMTWQrlzgLDaAH4elXF//0PYB7nh1hXaeoHjY68BVFqMmpSP2tNoyQH9
         cpvMn2297CMaWurdqFOwk1vaYg7w1DUVtZqmZaMTCjc4N+NLZCLrF14lg676BMsIqrIf
         YC+3ZouZBtTa6bT0dqAosXGb/NjlI7FN/EOdsx46u0utCcrq9VaOwAD0YfR0Is3YLxpv
         uVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769180375; x=1769785175;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jkIl7dS+mkiKgOTH9bgq3/o2+8pPlzP+BKaLvYWO3Zs=;
        b=iuL+Qv0tIiAVr54jB/TYfjGPmoHtK97ylWORsmkT+3+OYr3gGoYw2YUGc0Q+e9Kd3+
         78nqdpmhGkzTR8eLIGChTV4YaieePy6mcSxQuxzv8I84bDiL09apYD9eRdJi/VBJHDBK
         5wROXaP6ivja8fnB/BaaS79vaiOm/9IhPTDpx0bNW1d7Qzc89JfqVAwf1THMXeh/3a39
         aQaunRIdjQUln2Ofqd+5ScpELgH/luGG3nTPzo83M2nHz8M84uQzxdDiNsPbBBc52nU1
         spQHY8xEgFJYypBGJ4fTR3zVSwxd0IqFqpc48YHOR3ypOIHtzpSoA4puaJhlumWz3csg
         7wXg==
X-Forwarded-Encrypted: i=1; AJvYcCVUz6USxx6/iYYvapqgGgSCJWKMGCFWesyce/zR+hBeiTUZdVhvvN1vX10vAoLa+rEPUceLGJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKwuf1as4GOV5uHlKiIcoUCGnSioxAh2hlO2qdBdG/t5Wyffaw
	X78j23yWFJThpR7GanweefMmcscaE6zA2E5lqvkHsLu63RzIx2T6cxYj2vIUFVqOIg8=
X-Gm-Gg: AZuq6aLOHN+n9WeMi4Z3HI8ggZFYoH1E4puzMBEIaZ5Ii+vrNTm92d9rxBVM8LELVVM
	vmThoxLUYT7PGYyokaVe3CsMKrDTfH00kThLjqhOdCx9tyBSlagMkWQZlPuMOgghu2jK1wiqgPC
	xC/5hQ3WscN8A3qmrnGx9LSsvMDqtxNiq1q/EPPFJYWAcaOj/L2tBnfRJ7nRMyFb4WdcYEyXt8D
	j7qbCUbkcUpg7A4CbQRPzXtnFh4JThvNdEIgwxTc0HdBt4Yer09fgAGSdC6W61m/s9g1mdUnCwJ
	MLDziP1Xlzw6qXWDuqN/ylpf0s8M/K1+qpggPvXFJ57ipZyU6tbSVfP88sz5VCZppmVEJ943EvH
	k4aBJRGUI7dng78yeghDQ6X2a+7oYS3M5GEv9zX2KeanwwJrfRJX61JBQ8RBd6tfcSSG8isTCxj
	x4fb0=
X-Received: by 2002:a17:907:9616:b0:b87:d92a:f71 with SMTP id a640c23a62f3a-b885aea1336mr201953666b.62.1769180374748;
        Fri, 23 Jan 2026 06:59:34 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:d2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b6ff176sm115832466b.32.2026.01.23.06.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 06:59:34 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org,  "John Fastabend" <john.fastabend@gmail.com>,
  "David S. Miller" <davem@davemloft.net>,  "Eric Dumazet"
 <edumazet@google.com>,  "Jakub Kicinski" <kuba@kernel.org>,  "Paolo Abeni"
 <pabeni@redhat.com>,  "Simon Horman" <horms@kernel.org>,  "Neal Cardwell"
 <ncardwell@google.com>,  "Kuniyuki Iwashima" <kuniyu@google.com>,  "David
 Ahern" <dsahern@kernel.org>,  "Andrii Nakryiko" <andrii@kernel.org>,
  "Eduard Zingerman" <eddyz87@gmail.com>,  "Alexei Starovoitov"
 <ast@kernel.org>,  "Daniel Borkmann" <daniel@iogearbox.net>,  "Martin
 KaFai Lau" <martin.lau@linux.dev>,  "Song Liu" <song@kernel.org>,
  "Yonghong Song" <yonghong.song@linux.dev>,  "KP Singh"
 <kpsingh@kernel.org>,  "Stanislav Fomichev" <sdf@fomichev.me>,  "Hao Luo"
 <haoluo@google.com>,  "Jiri Olsa" <jolsa@kernel.org>,  "Shuah Khan"
 <shuah@kernel.org>,  "Michal Luczaj" <mhal@rbox.co>,  "Cong Wang"
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 2/3] bpf, sockmap: Fix FIONREAD for sockmap
In-Reply-To: <d8c440c1255979b5120eed985f7d156f68cd7a3f@linux.dev> (Jiayuan
	Chen's message of "Thu, 22 Jan 2026 03:56:50 +0000")
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
	<20260113025121.197535-3-jiayuan.chen@linux.dev>
	<87a4y8uy67.fsf@cloudflare.com> <871pjjux2u.fsf@cloudflare.com>
	<60a0c463ef6dbe38d836c773c5256706c163311c@linux.dev>
	<d8c440c1255979b5120eed985f7d156f68cd7a3f@linux.dev>
Date: Fri, 23 Jan 2026 15:59:33 +0100
Message-ID: <87cy30tlwq.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.16 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,linux.dev,fomichev.me,rbox.co,bytedance.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252861-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[28];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jakub@cloudflare.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: EB2CD77622
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 03:56 AM GMT, Jiayuan Chen wrote:
> January 21, 2026 at 20:55, "Jiayuan Chen" <jiayuan.chen@linux.dev
> mailto:jiayuan.chen@linux.dev?to=%22Jiayuan%20Chen%22%20%3Cjiayuan.chen%40linux.dev%3E
>> wrote:
>> January 21, 2026 at 17:36, "Jakub Sitnicki" <jakub@cloudflare.com
>> mailto:jakub@cloudflare.com?to=%22Jakub%20Sitnicki%22%20%3Cjakub%40cloudflare.com%3E
>> >  I've been thinking about this some more and came to the conclusion that
>> >  this udp_bpf_ioctl implementation is actually what we want, while
>> >  tcp_bpf_ioctl *should not* be checking if the sk_receive_queue is
>> >  non-empty.
>> >  
>> >  Why? Because the verdict prog might redirect or drop the skbs from
>> >  sk_receive_queue once it actually runs. The messages might never appear
>> >  on the msg_ingress queue.
>> >  
>> >  What I think we should be doing, in the end, is kicking the
>> >  sk_receive_queue processing on bpf_map_update_elem, if there's data
>> >  ready.
>> >  
>> >  The API semantics I'm proposing is:
>> >  
>> >  1. ioctl(FIONREAD) -> reports N bytes
>> >  2. bpf_map_update_elem(sk) -> socket inserted into sockmap
>> >  3. poll() for POLLIN -> wait for socket to be ready to read
>> >  5. ioctl(FIONREAD) -> report N bytes if verdict prog didn't
>> >  redirect or drop it
>> >  
>> >  We don't have to add the the queue kick on map update in this series.
>> >  
>> >  If you decide to leave it for later, can I ask that you open an issue at
>> >  our GH project [1]?
>> >  
>> >  I don't want it to fall through the cracks. And I sometimes have people
>> >  asking what they could help with in sockmap.
>> >  
>> >  Thanks,
>> >  -jkbs
>> >  
>> >  [1] https://github.com/sockmap-project/sockmap-project/issues
>> > 
>> Hi Jakub,
>> 
>> Thanks for taking the time to think through this carefully. I agree with your
>> analysis - reporting sk_receive_queue length is misleading since the verdict
>> prog might redirect or drop those skbs.
>> 
>> There's no rush to merge this patch.
>> 
>> Since the kick queue on bpf_map_update_elem addresses a closely related issue,
>> I think it makes sense to include it in this patchset for easier tracking rather
>> than splitting it out.
>> 
>> I'll spend more time looking into this and come back with an updated version.
>> 
>> Thanks,
>> Jiayuan
>>
>
>
> Hi Jakub,
>
>   I've been thinking about this more, and I realize the problem is not as simple as it seems.
>
>   Regarding kicking the sk_receive_queue on bpf_map_update_elem: the BPF
>   program may not be fully initialized at that point. For example, with a
>   redirect program, the destination fd might not yet be inserted into the
>   map. If we kick the data through the BPF program immediately, the
>   redirect lookup would fail, leading to unexpected behavior (data being
>   dropped or passed to the wrong socket).

I reckon there is not much we can do about it because we have no control
over when inserts/removes sockets from sockmap. It can happen at any
time.

Also, a newly received segment can trigger sk_data_ready callback,
and that would also cause the skbs to get processed. We don't have
control of that either.

Does this change break any of our existing tests/benchmarks or some
other setup of yours?

>   I also considered triggering the kick in poll/select via
>   sk_msg_is_readable(). However, this approach doesn't work for TCP
>   because tcp_poll() -> tcp_stream_is_readable() -> tcp_epollin_ready()
>   will return early when sk_receive_queue has data, before ever calling
>   sk_is_readable().
>
>   In the next version, I'll address your other nits and remove the
>   sk_receive_queue check from tcp_bpf_ioctl. I'll also open an issue on
>   the GH project to track this problem so we can continue exploring
>   better solutions.

Sounds like a plan. Thanks!

