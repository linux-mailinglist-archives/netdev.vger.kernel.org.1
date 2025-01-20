Return-Path: <netdev+bounces-159731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E73FFA16A86
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E5B3A33D2
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513131B4232;
	Mon, 20 Jan 2025 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="IXoOHnHv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE73019DF4A
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367994; cv=none; b=jLDTvS3oDMox4tuQqPnaaLvFiOxHkuc558TC8qKcWczIRoTxckFVG123iPpdiV0KOsUZg2NlkS70U8vu/v87HKn+iRir5oI3aSorBmemzCYThFC7n53pLaFiMHfQfGCROaJZdZreDaQxAHw4LpPnbixSDAz3rICPsPK42K65pec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367994; c=relaxed/simple;
	bh=POeSpLXqMDnf4ncHbT7WX49tYfW9PFR0KWRj+oU7i6Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iLUQmDPaX5mVOtLQHvUXjuBQM0uUEvQpYWsstwhvsmehD5t4hrCrhbXq/bTHJ2wv/2gSHURPNOZ350H6slvpk5o0U5YeQXDNPEi7XoRx3nU80Ed2xWuuBD5DdauisG8MV5ce3Zq8fYTRZoTkqoOUZ5ZD/8ZqOWnPvUZ3Nn46yWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=IXoOHnHv; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa689a37dd4so817309066b.3
        for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 02:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1737367990; x=1737972790; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=s+AmXtS555KTGh368N6qrcyGQOSWOD2uM0ZEZKy8e4w=;
        b=IXoOHnHvuITax+uU8uyj3FCD1+zVkSGMte6VFd9kwcZQy+03YCcP2InjSq6RKd7Npg
         hWAVjMa++UZ8MMeNiBC62klRpLf4PHfqAa0avOsNoCVzSpWCPGcoLRxCRvA6el2rDep9
         x9vCfhkZPsyq7JthqO52fkSSpIxG0inGYhr/sWPY4FOVFDpw5lJYm4YRyGF0c34hUp4m
         9Xn0ItD47XGtKu3RXXjPehu7QNwrBPeFtyxgJ8QAxzcAktboq3sq+6ogjlfc83dcKLgz
         8P2RZSVAYNyv/FSqCv0Xvk8+p49BPgx1z23/d1vpn4sPWmD/eV9dANZep41BMNKyiLUE
         oJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737367990; x=1737972790;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+AmXtS555KTGh368N6qrcyGQOSWOD2uM0ZEZKy8e4w=;
        b=aWz1AcweVFjOiVyjZlB1lH5UnVDTUwGc21s60mUpCDKSGH5r7tQ4ZGTGx74j/mkOR4
         DflVQ+x6VUmT4A/lmv+bj94m4BzihU98CA5bUWEvXVMHqjkCvFTFb7M8Pp3UfUIOZ+6T
         +mQCgC0ywWCAnnjO1tQ0deLjjowJHRC7g9ctyKKXcCu1sFIPPeI5C7eDOBSNZS9cybwC
         wgKX4zbmpzibpKNCa6UM+OaJlenxTqPLqQxDGZX7r2jbPBCg6UIMuQAEm8wocNCJzFL0
         /8BCGR0jS6lAP0QC7Ya9mZ+0Vh5JSSq/lGCnIzNx9160SFfp+/D7l46qk3jGXi9eJPWP
         WL3g==
X-Forwarded-Encrypted: i=1; AJvYcCUfdeOFt9QI3q5p9qjowh6Gt2O7UpZLuM04kAHx/YnQov+VDnS18aL/92U7Ix8d1gsLFgZzW4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5G/HHHA0xKcvvkDj07+vmRbdG0SmC4hZR7d67MCi09u2/zwJB
	LE8K+Y5hKykMxMFpsHvevSZzvg5UNaVpjc/pte1Pcqr42yO9AGq4yJ3cxFet7Qw=
X-Gm-Gg: ASbGnctrY3wG9sY0q5zqXzP0dK2C8S/vVz3kBBHDMQ/TCK3DLr+0w/I+HBg5QolImuM
	C5Gh7rhMG4vgSdlZnvxez3CcQ03Mhwnwbz1r/Md5yv+bx6Pnd4+WcPtBmrO4ABWODUQvJZhcmJN
	lDESeYyNfns9Dj0UHncT5c5oMjVf+My2jtI2vMLdlp5F2dtfvHMgHxnMQ8VzJRmCQEsC30QL0Xe
	PH+g3LKNIFg+NfKneaHhUjT+Ce30q8FmZfcpFhq7EV9QuqgQTLDSxRfs70J4JE=
X-Google-Smtp-Source: AGHT+IG3sxDHUYpin9r1buo9Oh2Jpo9gAgFq3g/a7WzAvcrq0JBMicje/huYwTSgfgvyeKZ4VF6qOw==
X-Received: by 2002:a17:907:7faa:b0:a9e:b150:a99d with SMTP id a640c23a62f3a-ab38b1b45aamr1198652366b.5.1737367990090;
        Mon, 20 Jan 2025 02:13:10 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:506f:2387::38a:15])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab384f224casm589585666b.87.2025.01.20.02.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 02:13:09 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiayuan Chen <mrpre@163.com>
Cc: bpf@vger.kernel.org,  john.fastabend@gmail.com,  netdev@vger.kernel.org,
  martin.lau@linux.dev,  ast@kernel.org,  edumazet@google.com,
  davem@davemloft.net,  dsahern@kernel.org,  kuba@kernel.org,
  pabeni@redhat.com,  linux-kernel@vger.kernel.org,  song@kernel.org,
  andrii@kernel.org,  mhal@rbox.co,  yonghong.song@linux.dev,
  daniel@iogearbox.net,  xiyou.wangcong@gmail.com,  horms@kernel.org,
  corbet@lwn.net,  eddyz87@gmail.com,  cong.wang@bytedance.com,
  shuah@kernel.org,  mykolal@fb.com,  jolsa@kernel.org,  haoluo@google.com,
  sdf@fomichev.me,  kpsingh@kernel.org,  linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf v7 2/5] bpf: fix wrong copied_seq calculation
In-Reply-To: <j5piuelz2xt65bn42bxufmk4nmigvzjotbygwd5tin7t6cvrsj@gpon5o7px7tu>
	(Jiayuan Chen's message of "Mon, 20 Jan 2025 11:35:37 +0800")
References: <20250116140531.108636-1-mrpre@163.com>
	<20250116140531.108636-3-mrpre@163.com>
	<87ikqcdvm9.fsf@cloudflare.com>
	<4uacr7khoalvlshkybaq4lqu55muax5adsrnqkulc6hgeuzaeg@eakft72epszp>
	<j5piuelz2xt65bn42bxufmk4nmigvzjotbygwd5tin7t6cvrsj@gpon5o7px7tu>
Date: Mon, 20 Jan 2025 11:13:08 +0100
Message-ID: <87a5bliyiz.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 20, 2025 at 11:35 AM +08, Jiayuan Chen wrote:
> On Sat, Jan 18, 2025 at 11:29:04PM +0800, Jiayuan Chen wrote:
>> On Sat, Jan 18, 2025 at 03:50:22PM +0100, Jakub Sitnicki wrote:
>> > On Thu, Jan 16, 2025 at 10:05 PM +08, Jiayuan Chen wrote:
>> > > 'sk->copied_seq' was updated in the tcp_eat_skb() function when the
>> > > action of a BPF program was SK_REDIRECT. For other actions, like SK_PASS,
>> > > +}
>> > > +#endif /* CONFIG_BPF_STREAM_PARSER */
>> > > +
>> > >  int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>> > >  {
>> > >  	int family = sk->sk_family == AF_INET6 ? TCP_BPF_IPV6 : TCP_BPF_IPV4;
>> > > @@ -681,6 +722,12 @@ int tcp_bpf_update_proto(struct sock *sk, struct sk_psock *psock, bool restore)
>> > >  
>> > >  	/* Pairs with lockless read in sk_clone_lock() */
>> > >  	sock_replace_proto(sk, &tcp_bpf_prots[family][config]);
>> > > +#if IS_ENABLED(CONFIG_BPF_STREAM_PARSER)
>> > > +	if (psock->progs.stream_parser && psock->progs.stream_verdict) {
>> > > +		psock->copied_seq = tcp_sk(sk)->copied_seq;
>> > > +		psock->read_sock = tcp_bpf_strp_read_sock;
>> > 
>> > Just directly set psock->strp.cb.read_sock to tcp_bpf_strp_read_sock.
>> > Then we don't need this intermediate psock->read_sock callback, which
>> > doesn't do anything useful.
>> >
>> Ok, I will do this.
>> (BTW, I intended to avoid bringing "struct strparser" into tcp_bpf.c so I
>> added a wrapper function instead in skmsg.c without calling it directly) 
>> 
> I find that tcp_bpf_update_proto is called before sk_psock_init_strp. Any
> assignment of psock->cb.strp will be overwritten in sk_psock_init_strp.

Or just don't set ->read_sock in strp_init.
It's being reset only because you made it so in patch 1 :-)

