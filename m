Return-Path: <netdev+bounces-82639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B3F88EE4D
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 19:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB8B7294F6F
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 18:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3AF14F11D;
	Wed, 27 Mar 2024 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfPdWBO1"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E099F14EC4F
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 18:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711564382; cv=none; b=XeL5O0ibr49r7ebOnAgOODBfOmWr7oI5FWGwRMxEKU7LMGEbrWZkSMZMkHspCNJjNyGtXI06dne/ysRxs4417N0UilneYN8XD6ZyIlz9EoXtb66rX4lS7VnLdCyzV0HjY/Wp46B3337AXtTm7vA5RXyROuuk0mEQUGyubE3e4y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711564382; c=relaxed/simple;
	bh=7ol7Ff8aJ42SSiteL67K7hwIVNb+ruR/XfYaOmuU2pk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uM+cycLcgZjUKC4z2T6/GH7zwKUHUVnsiXp2kkgAAve90eX0zC7Doy68CSCvRKuS+AaTc3SoEqXZxA3TN6c24xB92F5zh09XnE7vthAgBexyKe3xmncpVOBbPxdL1f8ITQvql0Q3uKCygwyrbtyFcxSYTEHA05ZAGMnxHOH9zM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfPdWBO1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711564379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x8ai1eCaG/6j0FeboJtQr63tU8mIb1SaZAhTgsAvgv8=;
	b=KfPdWBO1pWLrA7s4lrY7jHMZ+P040vf8E3uB/rHteK7pjbDZcMRTRErxg5DWLCMsVIpPIf
	pOYNvxRk3DQKVLK3Prk3favoDYYWonJPkAlJpvEIrzF0vGSF6EMQ/kQTrTY1XkS10bOKRL
	a80oUguDHqqTF+fJ7yRq0QzKAmC+4vM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-J9dLXn77M4Kj7_pM9PIuEg-1; Wed, 27 Mar 2024 14:32:58 -0400
X-MC-Unique: J9dLXn77M4Kj7_pM9PIuEg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-341d0499bbdso10946f8f.1
        for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 11:32:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711564377; x=1712169177;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x8ai1eCaG/6j0FeboJtQr63tU8mIb1SaZAhTgsAvgv8=;
        b=Og4Z5kczqJrcnU8CXnEvs2jD6guTwG9swgofX2Ud1AOZyzqfuGN/P7PRRsxtQNUP6Y
         g9Z+dW4hcswSBdPZ3m1vTMC1DtY4KwFDDAi14KX1b18w0L/cC8ofkrYM4WM+mhmZFoZQ
         LuKqptpTqbLKQbjNe1YqzCQLfhMtxKnZi/A7KaSL14wWjry9ddjlq4Jc839X98rdy1rS
         41QLbdYxRJ5TMGPzuVsLoRPDbkotz0vfPNXWxdJNxjUOaINgRH5n+3THql8Z7GspMMuz
         eDD5L+1Bim536eZdoKpaTFcMC39hNpLKoeT0Ajan7rKwcMakgJ/Bno+Layai1/tbLERG
         I82w==
X-Gm-Message-State: AOJu0Yw6tCmJwGlZN5ZRPrLGEaChIP2NHm4f6d1jNF3XIy/zfqaFvX6y
	UXM6KZxWvv+BtpMQq097BjFC/mHQYD618thvZ+aguFOnPEKisnJ5b9+/ILDPAbFLEi184qbGq/0
	sC8/Y6R4M933BgtzO9tkyppZabSJEWmlEEkkwdiNQQ2UfJqqzX+wVvg==
X-Received: by 2002:a05:6000:1818:b0:341:e617:8f6d with SMTP id m24-20020a056000181800b00341e6178f6dmr519838wrh.7.1711564376849;
        Wed, 27 Mar 2024 11:32:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFsTVwVp4sS0n+5Nqbdq8XPsApUrLlE4WRNDsIYC+XYK2AgDGPF11U32d+cnpoNsa3JDsyYA==
X-Received: by 2002:a05:6000:1818:b0:341:e617:8f6d with SMTP id m24-20020a056000181800b00341e6178f6dmr519824wrh.7.1711564376439;
        Wed, 27 Mar 2024 11:32:56 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0aa:8c10::f71])
        by smtp.gmail.com with ESMTPSA id ck19-20020a5d5e93000000b00341c6440c36sm11735690wrb.74.2024.03.27.11.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 11:32:56 -0700 (PDT)
Message-ID: <d917d3a5690a0115cb8136e1dda5fbe5621dcd95.camel@redhat.com>
Subject: Re: mptcp splat
From: Paolo Abeni <pabeni@redhat.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
  MPTCP Upstream <mptcp@lists.linux.dev>, Matthieu Baerts
 <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>,  Jakub Kicinski
 <kuba@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>
Date: Wed, 27 Mar 2024 19:32:54 +0100
In-Reply-To: <CAADnVQLj9bQDonRzJO5z2hMZ7kf6zdU-s6Cm_7_kj-wP3CiUSA@mail.gmail.com>
References: 
	<CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com>
	 <8410a6f61e7a778117819ebeda667687353ffb21.camel@redhat.com>
	 <CAADnVQLj9bQDonRzJO5z2hMZ7kf6zdU-s6Cm_7_kj-wP3CiUSA@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-27 at 10:00 -0700, Alexei Starovoitov wrote:
> On Wed, Mar 27, 2024 at 9:56=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > On Wed, 2024-03-27 at 09:43 -0700, Alexei Starovoitov wrote:
> > > I ffwded bpf tree with the recent net fixes and caught this:
> > >=20
> > > [   48.386337] WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:1430
> > > subflow_data_ready+0x147/0x1c0
> > > [   48.392012] Modules linked in: dummy bpf_testmod(O) [last unloaded=
:
> > > bpf_test_no_cfi(O)]
> > > [   48.396609] CPU: 32 PID: 3276 Comm: test_progs Tainted: G
> > > O       6.8.0-12873-g2c43c33bfd23 #1014
> > > #[   48.467143] Call Trace:
> > > [   48.469094]  <TASK>
> > > [   48.472159]  ? __warn+0x80/0x180
> > > [   48.475019]  ? subflow_data_ready+0x147/0x1c0
> > > [   48.478068]  ? report_bug+0x189/0x1c0
> > > [   48.480725]  ? handle_bug+0x36/0x70
> > > [   48.483061]  ? exc_invalid_op+0x13/0x60
> > > [   48.485809]  ? asm_exc_invalid_op+0x16/0x20
> > > [   48.488754]  ? subflow_data_ready+0x147/0x1c0
> > > [   48.492159]  mptcp_set_rcvlowat+0x79/0x1d0
> > > [   48.495026]  sk_setsockopt+0x6c0/0x1540
> > >=20
> > > It doesn't reproduce all the time though.
> > > Some race?
> > > Known issue?
> >=20
> > It was not known to me. Looks like something related to not so recent
> > changes (rcvlowat support).
> >=20
> > Definitely looks lie a race.
> >=20
> > If you could share more info about the running context and/or a full
> > decoded splat it could help, thanks!
>=20
> This is just running bpf selftests in parallel:
> test_progs -j
>=20
> The end of the splat:
> [   48.500075]  __bpf_setsockopt+0x6f/0x90
> [   48.503124]  bpf_sock_ops_setsockopt+0x3c/0x90
> [   48.506053]  bpf_prog_509ce5db2c7f9981_bpf_test_sockopt_int+0xb4/0x11b
> [   48.510178]  bpf_prog_dce07e362d941d2b_bpf_test_socket_sockopt+0x12b/0=
x132
> [   48.515070]  bpf_prog_348c9b5faaf10092_skops_sockopt+0x954/0xe86
> [   48.519050]  __cgroup_bpf_run_filter_sock_ops+0xbc/0x250
> [   48.523836]  tcp_connect+0x879/0x1160
> [   48.527239]  ? ktime_get_with_offset+0x8d/0x140
> [   48.531362]  tcp_v6_connect+0x50c/0x870
> [   48.534609]  ? mptcp_connect+0x129/0x280
> [   48.538483]  mptcp_connect+0x129/0x280
> [   48.542436]  __inet_stream_connect+0xce/0x370
> [   48.546664]  ? rcu_is_watching+0xd/0x40
> [   48.549063]  ? lock_release+0x1c4/0x280
> [   48.553497]  ? inet_stream_connect+0x22/0x50
> [   48.557289]  ? rcu_is_watching+0xd/0x40
> [   48.560430]  inet_stream_connect+0x36/0x50
> [   48.563604]  bpf_trampoline_6442491565+0x49/0xef
> [   48.567770]  ? security_socket_connect+0x34/0x50
> [   48.575400]  inet_stream_connect+0x5/0x50
> [   48.577721]  __sys_connect+0x63/0x90
> [   48.580189]  ? bpf_trace_run2+0xb0/0x1a0
> [   48.583171]  ? rcu_is_watching+0xd/0x40
> [   48.585802]  ? syscall_trace_enter+0xfb/0x1e0
> [   48.588836]  __x64_sys_connect+0x14/0x20

Ouch, it looks bad. BPF should not allow any action on mptcp subflows
that go through sk_socket. They touch the mptcp main socket, which is
_not_ protected by the subflow socket lock.

AFICS currently the relevant set of racing sockopt allowed by bpf boils
down to SO_RCVLOWAT only - sk_setsockopt(SO_RCVLOWAT) will call sk-
>sk_socket->ops->set_rcvlowat()

So something like the following (completely untested) should possibly
address the issue at hand, but I think it would be better/safer
completely disable ebpf on mptcp subflows, WDYT?

Thanks,

Paolo

---
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index dcd1c76d2a3b..6e5e64c2cf89 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1493,6 +1493,9 @@ int mptcp_set_rcvlowat(struct sock *sk, int val)
 	struct mptcp_subflow_context *subflow;
 	int space, cap;
=20
+	if (has_current_bpf_ctx())
+		return -EINVAL;
+
 	if (sk->sk_userlocks & SOCK_RCVBUF_LOCK)
 		cap =3D sk->sk_rcvbuf >> 1;
 	else




