Return-Path: <netdev+bounces-82642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC96E88EE88
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 19:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236B12961EE
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 18:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3A714D428;
	Wed, 27 Mar 2024 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEVaQRdO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BA512A144;
	Wed, 27 Mar 2024 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565435; cv=none; b=L806apqNdpCMaTaB6Zxje2j6tFcyc7QrQZtGwxi2UXIKkyZuZdaKZxMpBKEe5Jw/Yj76wMZwa0SsslNa8axCqhBUEOOhNHS+fFIxg+soV/wskQxHnQDxM0h/x//9hth8l9Qn2aMU4atOZcoaQyVdWv9asfLDyQrRQCCp7klSWGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565435; c=relaxed/simple;
	bh=GFvQgMNJBWspruDNJYpa4H7L8hbKoNxTiUdF0cyBUDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ehM2Q4S0ndfbBMnoQHJYeHKauM2DPTKah4mNwzweL5y41Sj3q7/QSaZXyt9Fp5igP6hKgsydA85qsNl9L68mjkX+zjltAK1hLb16cyYlJaPyx10za6MVkYHIP3inOenZXOnAsUYsrK7ECDlUrTkEvAeJpLdXBRXTmJf+hnknDjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEVaQRdO; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4151d2322caso365285e9.0;
        Wed, 27 Mar 2024 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711565432; x=1712170232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KsfvFHmLl4J9gKu8x0WatApKjWJ8CycUDWrjbzrw20=;
        b=fEVaQRdOJ4RiiQaEzX1iPyLGZQ0yFqYTe2FdvUiseJSvxwebdlnY6w6JwlsG39UyXg
         d5D2cBXNDNpqpQxZS2sO7UyZdWJKxUFISqE0NEm3CP4O+ADWPul4v3sKTUvwBp72vwCV
         7gMiXjs2QBjB6AtrMu+m70KIzdaKXsyBogDythnHUY7suNG8LW5FU+tV4L2HVwwHyydA
         hJVkKa/Ppx2Z7FCV/qpLFLjaUtWmME7Xcxz79hZkdSm4xbnYZYPko7n7ZHaTRK872aNv
         FN8VmhtvbcBuQQcncrdMbujIRo0D7BUiuJUJBhkoIQ6Vq0tZd3L6SEcxqj+O9SqRDV7Z
         CdgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711565432; x=1712170232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KsfvFHmLl4J9gKu8x0WatApKjWJ8CycUDWrjbzrw20=;
        b=ZsJ8pvMAFhgB80IosrnL8W1/PqxeYGefSHqgXuVG1HRKZnhmOzUU20hygjv9CA/WPk
         oRi1OQt4FDpfqZZDTO1xKjxB9xG13bS2gIzz4npMxzWhAyPrfiCgayGJQPUl8wPsM8r2
         hdaca6YHnPIj8+Ckhy4kkr7Eb1ErWYN9O2UBTfmY1dxNKfmK1vWxnmBFwazOg3x80zs1
         Lihxvl5GgRs5xHlv59wXcIbiywKVVHzBiwZJ5yr3cwcfkz1PqsghvBMtqS0VXjSjukS4
         EkKNYoPOsIrDnRDCeOtXcNvhnxiM5tO629QPK6zgHKJer1EBb2PNb+YJtn/b5lbBz4J+
         zVOg==
X-Forwarded-Encrypted: i=1; AJvYcCVVWHePN1WohoWzyY4FbGlR8MxMbtSr0ajwTSBc+wI++fPUGO6lx+K84Xs7sReLstcQfYn7MfqPymBYF5uwOnih/T/G
X-Gm-Message-State: AOJu0YyGUehsE787/0eX36abtIsKhdiBFshdaiIOAeUE4Rcmznkv1jmK
	DVoBuPJtrPzfMf3WopNXeNMNMxiIru35YxA0U7Z73LrZXacddcCI7t6sUFA8eqLEz7lZB1UrWZZ
	55ykEPn0afi9ugWuAn70A0R+U6/Y=
X-Google-Smtp-Source: AGHT+IFLrWuvzUW0/3AWgrGPVcYx5N/ofCaXzQXgeaSlrsBW4MK9IoAAOm0O2vwgChxHwOjX5Orz4PkO3jU1pFJ/gyU=
X-Received: by 2002:a05:600c:5103:b0:414:63da:a2a2 with SMTP id
 o3-20020a05600c510300b0041463daa2a2mr759171wms.29.1711565432402; Wed, 27 Mar
 2024 11:50:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com>
 <8410a6f61e7a778117819ebeda667687353ffb21.camel@redhat.com>
 <CAADnVQLj9bQDonRzJO5z2hMZ7kf6zdU-s6Cm_7_kj-wP3CiUSA@mail.gmail.com> <d917d3a5690a0115cb8136e1dda5fbe5621dcd95.camel@redhat.com>
In-Reply-To: <d917d3a5690a0115cb8136e1dda5fbe5621dcd95.camel@redhat.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 27 Mar 2024 11:50:20 -0700
Message-ID: <CAADnVQKXcEhL680E85=rrYuu4eVvVTH60kYRY_VnAKzZo1qKYg@mail.gmail.com>
Subject: Re: mptcp splat
To: Paolo Abeni <pabeni@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 11:33=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Wed, 2024-03-27 at 10:00 -0700, Alexei Starovoitov wrote:
> > On Wed, Mar 27, 2024 at 9:56=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > >
> > > On Wed, 2024-03-27 at 09:43 -0700, Alexei Starovoitov wrote:
> > > > I ffwded bpf tree with the recent net fixes and caught this:
> > > >
> > > > [   48.386337] WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:14=
30
> > > > subflow_data_ready+0x147/0x1c0
> > > > [   48.392012] Modules linked in: dummy bpf_testmod(O) [last unload=
ed:
> > > > bpf_test_no_cfi(O)]
> > > > [   48.396609] CPU: 32 PID: 3276 Comm: test_progs Tainted: G
> > > > O       6.8.0-12873-g2c43c33bfd23 #1014
> > > > #[   48.467143] Call Trace:
> > > > [   48.469094]  <TASK>
> > > > [   48.472159]  ? __warn+0x80/0x180
> > > > [   48.475019]  ? subflow_data_ready+0x147/0x1c0
> > > > [   48.478068]  ? report_bug+0x189/0x1c0
> > > > [   48.480725]  ? handle_bug+0x36/0x70
> > > > [   48.483061]  ? exc_invalid_op+0x13/0x60
> > > > [   48.485809]  ? asm_exc_invalid_op+0x16/0x20
> > > > [   48.488754]  ? subflow_data_ready+0x147/0x1c0
> > > > [   48.492159]  mptcp_set_rcvlowat+0x79/0x1d0
> > > > [   48.495026]  sk_setsockopt+0x6c0/0x1540
> > > >
> > > > It doesn't reproduce all the time though.
> > > > Some race?
> > > > Known issue?
> > >
> > > It was not known to me. Looks like something related to not so recent
> > > changes (rcvlowat support).
> > >
> > > Definitely looks lie a race.
> > >
> > > If you could share more info about the running context and/or a full
> > > decoded splat it could help, thanks!
> >
> > This is just running bpf selftests in parallel:
> > test_progs -j
> >
> > The end of the splat:
> > [   48.500075]  __bpf_setsockopt+0x6f/0x90
> > [   48.503124]  bpf_sock_ops_setsockopt+0x3c/0x90
> > [   48.506053]  bpf_prog_509ce5db2c7f9981_bpf_test_sockopt_int+0xb4/0x1=
1b
> > [   48.510178]  bpf_prog_dce07e362d941d2b_bpf_test_socket_sockopt+0x12b=
/0x132
> > [   48.515070]  bpf_prog_348c9b5faaf10092_skops_sockopt+0x954/0xe86
> > [   48.519050]  __cgroup_bpf_run_filter_sock_ops+0xbc/0x250
> > [   48.523836]  tcp_connect+0x879/0x1160
> > [   48.527239]  ? ktime_get_with_offset+0x8d/0x140
> > [   48.531362]  tcp_v6_connect+0x50c/0x870
> > [   48.534609]  ? mptcp_connect+0x129/0x280
> > [   48.538483]  mptcp_connect+0x129/0x280
> > [   48.542436]  __inet_stream_connect+0xce/0x370
> > [   48.546664]  ? rcu_is_watching+0xd/0x40
> > [   48.549063]  ? lock_release+0x1c4/0x280
> > [   48.553497]  ? inet_stream_connect+0x22/0x50
> > [   48.557289]  ? rcu_is_watching+0xd/0x40
> > [   48.560430]  inet_stream_connect+0x36/0x50
> > [   48.563604]  bpf_trampoline_6442491565+0x49/0xef
> > [   48.567770]  ? security_socket_connect+0x34/0x50
> > [   48.575400]  inet_stream_connect+0x5/0x50
> > [   48.577721]  __sys_connect+0x63/0x90
> > [   48.580189]  ? bpf_trace_run2+0xb0/0x1a0
> > [   48.583171]  ? rcu_is_watching+0xd/0x40
> > [   48.585802]  ? syscall_trace_enter+0xfb/0x1e0
> > [   48.588836]  __x64_sys_connect+0x14/0x20
>
> Ouch, it looks bad. BPF should not allow any action on mptcp subflows
> that go through sk_socket. They touch the mptcp main socket, which is
> _not_ protected by the subflow socket lock.
>
> AFICS currently the relevant set of racing sockopt allowed by bpf boils
> down to SO_RCVLOWAT only - sk_setsockopt(SO_RCVLOWAT) will call sk-
> >sk_socket->ops->set_rcvlowat()
>
> So something like the following (completely untested) should possibly
> address the issue at hand, but I think it would be better/safer
> completely disable ebpf on mptcp subflows, WDYT?
>
> Thanks,
>
> Paolo
>
> ---
> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
> index dcd1c76d2a3b..6e5e64c2cf89 100644
> --- a/net/mptcp/sockopt.c
> +++ b/net/mptcp/sockopt.c
> @@ -1493,6 +1493,9 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
>         struct mptcp_subflow_context *subflow;
>         int space, cap;
>
> +       if (has_current_bpf_ctx())
> +               return -EINVAL;
> +

Looks fine to me.

Martin,

Do you have any better ideas?

The splat explains the race.
In this case setget_sockopt test happen to run in parallel
with mptcp/bpf test and the former one was TCP connect request
but it was for subflow.

We can disable that callback when tcp flow is a subflow,
but that doesn't feel right.
I think Paolo's targeted fix is cleaner.

