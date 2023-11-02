Return-Path: <netdev+bounces-45793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9117DFA14
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 19:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28CE281CA6
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D581C2A0;
	Thu,  2 Nov 2023 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOhNT1rZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412CC208D3;
	Thu,  2 Nov 2023 18:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7E77C433C7;
	Thu,  2 Nov 2023 18:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698950333;
	bh=ZCl2RJW3X7nBpybcBZiwAWuq4xViEFQLDT5FyMu/Wjk=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=ZOhNT1rZk9HvPuPXUusS9Il3Dq1kPF2wLIBaVwFlfMsuPCI5iSr85UEBTtqyFJ7Ir
	 /eAdFr/eMhKjL9ffTdNv5dtqsJGmM+HI1cwrTtOjNCZ2IwdhNS0gZaA/wJAQE+lYNY
	 xf7uFWTH3ENRChl4sB+OUl46tL1cgg1FwpFmjqNsOh8EMt5ja5JyIw+Pt4NfLGcuYe
	 IwlIvaAwQ1n1HjyBJwV7pIpfW2jd85xayZmzT3nXrE7bb1z0HafMUNMPHcJTWg0aDc
	 +bpweElWLfh3+ujUWDNWbuFIt349rOjwXoWkr2iRnWmyHEtQe/3eFVQ0vapbl7bF3N
	 xYlHo/4aTXSnw==
Date: Thu, 2 Nov 2023 11:38:51 -0700 (PDT)
From: Mat Martineau <martineau@kernel.org>
To: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Matthieu Baerts <matttbe@kernel.org>
cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
    netdev@vger.kernel.org, mptcp@lists.linux.dev
Subject: Re: [PATCH net-next 9/9] mptcp: refactor sndbuf auto-tuning
In-Reply-To: <CANn89iLZUA6S2a=K8GObnS62KK6Jt4B7PsAs7meMFooM8xaTgw@mail.gmail.com>
Message-ID: <a41bacc1-fc92-01db-79a1-10327628a5f1@kernel.org>
References: <20231023-send-net-next-20231023-2-v1-0-9dc60939d371@kernel.org> <20231023-send-net-next-20231023-2-v1-9-9dc60939d371@kernel.org> <CANn89iLZUA6S2a=K8GObnS62KK6Jt4B7PsAs7meMFooM8xaTgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-709216980-1698950333=:19746"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--0-709216980-1698950333=:19746
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Thu, 2 Nov 2023, Eric Dumazet wrote:

> On Mon, Oct 23, 2023 at 10:45 PM Mat Martineau <martineau@kernel.org> wrote:
>>
>> From: Paolo Abeni <pabeni@redhat.com>
>>
>> The MPTCP protocol account for the data enqueued on all the subflows
>> to the main socket send buffer, while the send buffer auto-tuning
>> algorithm set the main socket send buffer size as the max size among
>> the subflows.
>>
>> That causes bad performances when at least one subflow is sndbuf
>> limited, e.g. due to very high latency, as the MPTCP scheduler can't
>> even fill such buffer.
>>
>> Change the send-buffer auto-tuning algorithm to compute the main socket
>> send buffer size as the sum of all the subflows buffer size.
>>
>> Reviewed-by: Mat Martineau <martineau@kernel.org>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> Signed-off-by: Mat Martineau <martineau@kernel.org
>
> ...
>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index df208666fd19..2b43577f952e 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -421,6 +421,7 @@ static bool subflow_use_different_dport(struct mptcp_sock *msk, const struct soc
>>
>>  void __mptcp_set_connected(struct sock *sk)
>>  {
>> +       __mptcp_propagate_sndbuf(sk, mptcp_sk(sk)->first);
>
> ->first can be NULL here, according to syzbot.
>

Thanks for reporting this, Eric. We will get a fix to the net tree.


Paolo & Matthieu, I created a github issue to track this:

https://github.com/multipath-tcp/mptcp_net-next/issues/454



- Mat
--0-709216980-1698950333=:19746--

