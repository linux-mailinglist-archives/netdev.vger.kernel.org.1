Return-Path: <netdev+bounces-285983-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LNvAiNa/mlapgAAu9opvQ
	(envelope-from <netdev+bounces-285983-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:48:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 771804FC0B6
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 23:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4689301CFED
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 21:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71199322C78;
	Fri,  8 May 2026 21:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vc4IQrBf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0946C31AF3B
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778276883; cv=none; b=U6epff+SHdTFFMDN0g6SVXjei9dyNWpHQuZhZ9qgz4ShbZMdMSKro/nAGjTV0cxsrxqo4HiE0vhvC9Jwv+lYDcp4WF3WJz9GbV/e7vnbZ+r+JR417fETrmi5PO0c5chVq19OZl2zxyLDPbcp3L2K5UiPynto5mUyIg5YovdkhGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778276883; c=relaxed/simple;
	bh=b4xSfSEBba07dS73A1Cb20OypxaXWo+/j+rABWOKtO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ycce8Iq88YX+sQwnDDHoq2MQIE/SPOuEDV39WQ2VNAHhp2I623B2PsEJiV9Qw6ypa1baCRdO79hhRz6qT61tE05GXTlpZbjfNm8nYJRpfknujR0TQxlXAEEyRjshv0BhG9XPkClGEE1jmIkPbceS4i2YO3I1ty1D8RbPE0tOVk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vc4IQrBf; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-c70ea5e9e9dso1084893a12.1
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 14:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778276881; x=1778881681; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G0o1Aye+qO6lkwtaNafHPbGoI4Pmy+TMkFbSow6+WyI=;
        b=Vc4IQrBfsk5HXcj2h17fUZr352Throppee8uOb0Sk2OYHlD2+EwFXRUJsSmT7RGrK4
         c2G7RiS1VvQ2n2JPd9q7qYLXNBhALvuH1CDyWs9Xv85HnkP+vJNvFuq0wlNFjSeYjV0k
         S/VVv+JDNFpyMO2A0LzhHbrMloolXReDLPyBVEfF/1q9cAAmc6fNOwWRb+6FQx0LrBmn
         x1w02y9qPTQxXlvW+ZBIp5+e8zHplklfpTTVEbRl68mnp7FKQXtejNXgvd/7cgDKYGbd
         kxXPV7yjGW9ZVL21xJhKF6V/Ih1HEyCShDndEG9d69dDwynkOAKwWagDSjHqC0kutHQ1
         C5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778276881; x=1778881681;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0o1Aye+qO6lkwtaNafHPbGoI4Pmy+TMkFbSow6+WyI=;
        b=qWXS+lN47gUe5AuSYI8i/ly2RXb0EjHp9AQlIdfFQrhwuCjUv6ASggnTwbPgCboHDq
         JDFHMumeUHYSTlZlVnTKdZ4s5UYJ2Qq/GdxblExtEtEnvMoM7S7w76JmB3+K95827OD4
         /zdGA5bimfMguVLeVayrof4bG4X0tvJHcslQA9V7dyK831+c3h1iOwdt9dPQK0zR2Hj3
         wpjD3yZMjBX8o2B0P8A2cAoATUzAfDYgs9Kk1j/LClpSin1ef8VluKMOzkoq/Fzw451r
         t+Cl0/hXGtQ+FfQ7NqMD0hASJXg60gNmCM9W0xcdt/9XBioDIm6wUea9vho689FcLx8t
         4SLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/QijV65oEQarazT31NnFlMQkiYFrvofy0x7pzAYzShAgMStoAb7Dpv7k3n+pIjNxdEIOxh7QE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoX67+Inw60+ig0r3Y8Xj4M5AOi66KUP0KFnzOzWSTzk/Y8RqT
	z6OR3Qe49TwTrdx2p4DUl+ytU4RPBzH1W8IwHk7Xl/PLEw3+Jb/3xXxFSNu0bY+j
X-Gm-Gg: AeBDietbJdaABAP+3mv4NHXx4DioG0UnWUl2ed4WlUGirA3qwUXtWk30gcZVq7H/Hu8
	kspUBqReTLpRjd2uVVCGy7MeTlnz8NHlau+fMpR6Jl17kgDBMd76nyxVSZRg5cWJ2twESAVCVYZ
	J74RZHGQTmXWsXfAhJy+J1IOgs0cKUh41DqOy6DtQKc4cVGhpYEMS7gNNmqj++I985qIxvlJBRr
	oWplvRGDZ8mrwisG+fWoGKL1bFJ8PCbL2QWs3qcmRm5TRzaJ7L97jQZRczmAE+d1BXLlDWY+6FG
	9WaFEKb3fIi7d42h/lfGXZiXWN0ghuvQhPrjVjxfmapRgRN9ogIHTV+QeWEa1eAvfN4XGbgZtI/
	97u+3G9W5wHrBQp0Tb9wyTDXDJwk30H6Cp9FLlGr9qvtOpqs3i8I2AFg0ySHWJsd/Damy85qsNA
	3C1Rp5XJQILRggJMM=
X-Received: by 2002:a05:6a20:958f:b0:3a2:dabf:feed with SMTP id adf61e73a8af0-3aa5a72c4d7mr16428652637.3.1778276881331;
        Fri, 08 May 2026 14:48:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:8::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826767bdffsm2732043a12.5.2026.05.08.14.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 14:48:00 -0700 (PDT)
Date: Fri, 8 May 2026 14:47:59 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tenzin Ukyab <ukyab@berkeley.edu>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 8/8] selftest: bpf: Add test for
 BPF_SOCK_OPS_RCVLOWAT_CB.
Message-ID: <af5ZVL3EmKIfTcFQ@devvm7509.cco0.facebook.com>
References: <20260508073355.3916746-1-kuniyu@google.com>
 <20260508073355.3916746-9-kuniyu@google.com>
 <af4CV5itdz5Dzwo7@devvm7509.cco0.facebook.com>
 <CAAVpQUD01-UJorFM=4sT1b4XbiVF0TPorpzpU+b8DYXzn0FH0g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUD01-UJorFM=4sT1b4XbiVF0TPorpzpU+b8DYXzn0FH0g@mail.gmail.com>
X-Rspamd-Queue-Id: 771804FC0B6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285983-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,google.com,berkeley.edu,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On 05/08, Kuniyuki Iwashima wrote:
> On Fri, May 8, 2026 at 8:35 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 05/08, Kuniyuki Iwashima wrote:
> > > The test is roughly divided into two stages, and the sequence
> > > is as follows:
> > >
> > >   I) Setup
> > >
> > >     1. Attach two BPF programs to a cgroup
> > >     2. Establish a TCP connection (@client <-> @child) within the cgroup
> > >     3. Enable BPF_SOCK_OPS_RCVLOWAT_CB on @child
> > >
> > >  II) RPC frame exchange in various patterns
> > >
> > >     4. Send a partial RPC descriptor from @client to @child
> > >     5. Verify that epoll does NOT wake up @child
> > >     6. Send the remaining data of the RPC frame
> > >     7. Verify that epoll finally wakes up @child
> > >
> > > During setup, two BPF programs are attached to simulate
> > > a real-world scenario; one is SOCK_OPS and the other is
> > > CGROUP_SOCKOPT.
> > >
> > > While the SOCK_OPS prog handles the dynamic adjustment of
> > > sk->sk_rcvlowat, the CGROUP_SOCKOPT prog is used to enable
> > > BPF_SOCK_OPS_RCVLOWAT_CB via userspace setsockopt() using
> > > pseudo options:
> > >
> > >   #define SOL_BPF               0xdeadbeef
> > >   #define BPF_TCP_AUTOLOWAT     0x8badf00d
> > >
> > >   setsockopt(fd, SOL_BPF, BPF_TCP_AUTOLOWAT, &(int){1}, sizeof(int));
> >
> > Hmm, so you do want to have this enable-on-a-per-socket use case.. Then what
> > happens to the skbs already sitting in the rx queue by the time
> > we enable BPF_SOCK_OPS_RCVLOWAT_CB? Isn't there a race? Or am I missing
> > something?
> 
> If the upper protocol is designed that way, it could be racy.
> 
> For example, HTTP2 could have multiple streams within the
> same TCP connection while only one stream can be upgraded.
> But this use case simply does not work with a single
> sk->sk_rcvlowat in the first place.
> 
> This feature implicitly assumes a single stream per connection.
> 
> In our original implementation, it traversed all (technically
> up to 100) skbs in the queue and parse them like psock.
> 
> But this will be unnecessary if the server drains the queue
> properly before enabling the feature.
> 
> If needed, we could return -EBUSY when the queue is not
> empty.  It's always under lock_sock() or bh_lock_sock().

But even for a single stream it's racy, no? Suppose I do recvmsg()
and then setsockopt(BPF_TCP_AUTOLOWAT, 1). There is a window of time
between recvmsg() and setsockopt() where we can receive a packet?
Or you're saying that if it is an-RPC type protocol, the receiver
explicitly signals to the sender that it's ready to receive (by sending
it an RPC request). If that's the case, let's explicitly explain this
somewhere?

