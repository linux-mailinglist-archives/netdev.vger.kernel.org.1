Return-Path: <netdev+bounces-82640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D54588EE76
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 19:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D724C1F2FA93
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 18:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDF8014D6E7;
	Wed, 27 Mar 2024 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URbowigy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C7E14D6FF;
	Wed, 27 Mar 2024 18:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711565154; cv=none; b=CKQxzN13svi+Z7YkZyL4a+fcboxzdrKo2Z3H9woIB0Qa+Dex6aWUHtkcye9s9oGwGp38fjmDsTdfi+KW5GZQ/gG5dbhyslF/g57E1E0qnI7RLiQJHwptqkGJsoPnBhDJcM6+lMxh5mVcoAgxUhl/hAFafs6XGBQr3DjLkadYMPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711565154; c=relaxed/simple;
	bh=X9HpjcDWd+CUHIO3B9B3mJkZeCNw8B+0V6efa9jE49A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DL+GaGEOyGnClAAiE2ePFHAW9NuRuR2h+4QOwR1FnqeI+WUgQDKn79k6QTW/TUaEKwZOx/JAJYbDa0YCTALKIc7wCPFvYu04Lir7zvkGoWsPdK/7IM5yg7JN5z2bI8Buy8vwfkEeo0BpkPHhdtWYtnlMNabVR4YKDg39BDpMLek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URbowigy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46D89C433F1;
	Wed, 27 Mar 2024 18:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711565154;
	bh=X9HpjcDWd+CUHIO3B9B3mJkZeCNw8B+0V6efa9jE49A=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=URbowigys3UijYNUjb6jxH1Lx87B4Qu+2Wa7T2hyJiOBAO73l2cTX3v3DUXeH6QCq
	 vKhDJtxLrBwMnqtMKytMplw7pT6tcq2q+4L33lzWwHr9M1jl+nUaqFa22A9I1U3ftY
	 xesKIR8sDjhAq58KkmBxoHrwIpTLF4zpb4hQdKh2L7NHkfbCvYZ7HcxEmSEoF3chjG
	 NoN75GMjH3T+xdu9vFMtfr4i8ucJ6EN5zBUJfMv+5e2xBysU2EY0mgfFvB/TWOCg23
	 IZ4oYt7z9BNYknBb7+YrUD1SVfiKOsYOddvoSB6WjQ6UiXqgmOeqsw7CGxr1Bmo6CS
	 tyoLmkte29Zfg==
Date: Wed, 27 Mar 2024 11:45:53 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
    Network Development <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
    MPTCP Upstream <mptcp@lists.linux.dev>, 
    Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
    Martin KaFai Lau <martin.lau@kernel.org>
Subject: Re: mptcp splat
In-Reply-To: <d917d3a5690a0115cb8136e1dda5fbe5621dcd95.camel@redhat.com>
Message-ID: <c13ff577-6f55-3005-a654-28ac6257545b@kernel.org>
References: <CAADnVQKCxxETthqDpcE1xMGwa5au8JuLr_49QuwemL7uBKfiVg@mail.gmail.com> <8410a6f61e7a778117819ebeda667687353ffb21.camel@redhat.com> <CAADnVQLj9bQDonRzJO5z2hMZ7kf6zdU-s6Cm_7_kj-wP3CiUSA@mail.gmail.com>
 <d917d3a5690a0115cb8136e1dda5fbe5621dcd95.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1233490870-1711565154=:1360"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-1233490870-1711565154=:1360
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Wed, 27 Mar 2024, Paolo Abeni wrote:

> On Wed, 2024-03-27 at 10:00 -0700, Alexei Starovoitov wrote:
>> On Wed, Mar 27, 2024 at 9:56 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>>
>>> On Wed, 2024-03-27 at 09:43 -0700, Alexei Starovoitov wrote:
>>>> I ffwded bpf tree with the recent net fixes and caught this:
>>>>
>>>> [   48.386337] WARNING: CPU: 32 PID: 3276 at net/mptcp/subflow.c:1430
>>>> subflow_data_ready+0x147/0x1c0
>>>> [   48.392012] Modules linked in: dummy bpf_testmod(O) [last unloaded:
>>>> bpf_test_no_cfi(O)]
>>>> [   48.396609] CPU: 32 PID: 3276 Comm: test_progs Tainted: G
>>>> O       6.8.0-12873-g2c43c33bfd23 #1014
>>>> #[   48.467143] Call Trace:
>>>> [   48.469094]  <TASK>
>>>> [   48.472159]  ? __warn+0x80/0x180
>>>> [   48.475019]  ? subflow_data_ready+0x147/0x1c0
>>>> [   48.478068]  ? report_bug+0x189/0x1c0
>>>> [   48.480725]  ? handle_bug+0x36/0x70
>>>> [   48.483061]  ? exc_invalid_op+0x13/0x60
>>>> [   48.485809]  ? asm_exc_invalid_op+0x16/0x20
>>>> [   48.488754]  ? subflow_data_ready+0x147/0x1c0
>>>> [   48.492159]  mptcp_set_rcvlowat+0x79/0x1d0
>>>> [   48.495026]  sk_setsockopt+0x6c0/0x1540
>>>>
>>>> It doesn't reproduce all the time though.
>>>> Some race?
>>>> Known issue?
>>>
>>> It was not known to me. Looks like something related to not so recent
>>> changes (rcvlowat support).
>>>
>>> Definitely looks lie a race.
>>>
>>> If you could share more info about the running context and/or a full
>>> decoded splat it could help, thanks!
>>
>> This is just running bpf selftests in parallel:
>> test_progs -j
>>
>> The end of the splat:
>> [   48.500075]  __bpf_setsockopt+0x6f/0x90
>> [   48.503124]  bpf_sock_ops_setsockopt+0x3c/0x90
>> [   48.506053]  bpf_prog_509ce5db2c7f9981_bpf_test_sockopt_int+0xb4/0x11b
>> [   48.510178]  bpf_prog_dce07e362d941d2b_bpf_test_socket_sockopt+0x12b/0x132
>> [   48.515070]  bpf_prog_348c9b5faaf10092_skops_sockopt+0x954/0xe86
>> [   48.519050]  __cgroup_bpf_run_filter_sock_ops+0xbc/0x250
>> [   48.523836]  tcp_connect+0x879/0x1160
>> [   48.527239]  ? ktime_get_with_offset+0x8d/0x140
>> [   48.531362]  tcp_v6_connect+0x50c/0x870
>> [   48.534609]  ? mptcp_connect+0x129/0x280
>> [   48.538483]  mptcp_connect+0x129/0x280
>> [   48.542436]  __inet_stream_connect+0xce/0x370
>> [   48.546664]  ? rcu_is_watching+0xd/0x40
>> [   48.549063]  ? lock_release+0x1c4/0x280
>> [   48.553497]  ? inet_stream_connect+0x22/0x50
>> [   48.557289]  ? rcu_is_watching+0xd/0x40
>> [   48.560430]  inet_stream_connect+0x36/0x50
>> [   48.563604]  bpf_trampoline_6442491565+0x49/0xef
>> [   48.567770]  ? security_socket_connect+0x34/0x50
>> [   48.575400]  inet_stream_connect+0x5/0x50
>> [   48.577721]  __sys_connect+0x63/0x90
>> [   48.580189]  ? bpf_trace_run2+0xb0/0x1a0
>> [   48.583171]  ? rcu_is_watching+0xd/0x40
>> [   48.585802]  ? syscall_trace_enter+0xfb/0x1e0
>> [   48.588836]  __x64_sys_connect+0x14/0x20
>
> Ouch, it looks bad. BPF should not allow any action on mptcp subflows
> that go through sk_socket. They touch the mptcp main socket, which is
> _not_ protected by the subflow socket lock.
>
> AFICS currently the relevant set of racing sockopt allowed by bpf boils
> down to SO_RCVLOWAT only - sk_setsockopt(SO_RCVLOWAT) will call sk-
>> sk_socket->ops->set_rcvlowat()
>
> So something like the following (completely untested) should possibly
> address the issue at hand, but I think it would be better/safer
> completely disable ebpf on mptcp subflows, WDYT?
>

Paolo -

I agree that the MPTCP socket needs to manage any changes to the subflow 
sockets, so ebpf will only exercise control of subflows through the MPTCP 
socket.


- Mat
--0-1233490870-1711565154=:1360--

