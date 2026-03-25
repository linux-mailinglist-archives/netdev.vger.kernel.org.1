Return-Path: <netdev+bounces-271464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJioIL6lw2lssQQAu9opvQ
	(envelope-from <netdev+bounces-271464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:07:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EC34B321E0B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 10:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D06830234CD
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52C320A37;
	Wed, 25 Mar 2026 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B9wpEBrV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C801E3043BE;
	Wed, 25 Mar 2026 09:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774429492; cv=none; b=g0Zupkcs1mKBUhvaKR7c1r4a9AwqC4MbzbpmV2xM33u2BlPCDW9D1oWzVpp45GQF3BVDfYRMMsd4gsdXfo5TFconm3FAdtNeRl9CgOwpElFRt9QHdgTvQjN9ZYjIxvuigHWaEfMrQ0Y4SvZLffq1m+t/09ISUdpYHaC29VWD0Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774429492; c=relaxed/simple;
	bh=ui5jwegU4OLOS+z60QNhyMislxj9h80Sy917sqNwYmg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c6hk3xLgpX4YKWYEpdkol/mr+2x5O8D91/GiKyoJhnTNkPqaQfJyo4KJ2Bs6sBwM9fa9lTI/j2hIzUP347FOOI2/SJxoLdea1lnQuU1AWi1JTngm+97//by1hVbQRvqMpDY+P98Q8473qvAG1lUhoRm5YchCAyqeFOSBY9o+05A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B9wpEBrV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E291C4CEF7;
	Wed, 25 Mar 2026 09:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774429492;
	bh=ui5jwegU4OLOS+z60QNhyMislxj9h80Sy917sqNwYmg=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=B9wpEBrVYArfi+e1noQ5LkzwNm6yiIdZiLNIxXS2n8jYNmFLEfdUshnz5GwQ35JCi
	 eoNBKB+fNjk0qCFU4ICkl2BGOBdltLcl2C4+lwh8F5tdNCyUJt6izjoaj5hYVYkraE
	 c1UuVvyvOnZqeGo8Bn3x9VaTnq3gyR9lgB8b8CF2SYtyBF3YNDTukm9mR0it0GbFLL
	 ik5mVvYbsBXUjRYqjc/I5L/pGho8ZLdXaBaVJI3D1KlV47iloPRnk+IAP3dR7TIRje
	 TuwUXs5jfFoNsPiIthMu7ntsQr6RAaUe27r3LBlNB7rR6WEt6Vkbr+G+9IaxdRG+Kr
	 3i3VuIVaSplQQ==
Message-ID: <73d7be31-f066-474d-989b-731b0b15f134@kernel.org>
Date: Wed, 25 Mar 2026 10:04:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v2] mptcp: fix soft lockup in mptcp_recvmsg()
Content-Language: fr
From: Matthieu Baerts <matttbe@kernel.org>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, weiyongjun1@huawei.com
References: <20260324085131.4187473-1-lixiasong1@huawei.com>
 <12ad947e-f386-4fcc-9043-bf4f95a7db83@kernel.org>
 <2da353a7-96cf-40ed-9d83-f256ec6965e1@huawei.com>
 <5d5d6905-4348-409a-9bb3-8eee30f215b1@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <5d5d6905-4348-409a-9bb3-8eee30f215b1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271464-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email]
X-Rspamd-Queue-Id: EC34B321E0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25/03/2026 08:16, Matthieu Baerts wrote:
> Hi Li,
> 
> 25 Mar 2026 03:39:13 Li Xiasong <lixiasong1@huawei.com>:
> 
>> Hi Matt,
>>
>> On 3/25/2026 3:23 AM, Matthieu Baerts wrote:
>>> Hi Li,
>>>
>>> On 24/03/2026 09:51, Li Xiasong wrote:
>>>> syzbot reported a soft lockup in mptcp_recvmsg() [0].
>>>>
>>>> When receiving data with MSG_PEEK | MSG_WAITALL flags, the skb is not
>>>> removed from the sk_receive_queue. This causes sk_wait_data() to always
>>>> find available data and never perform actual waiting, leading to a soft
>>>> lockup.
>>>>
>>>> Fix this by adding a 'last' parameter to track the last peeked skb.
>>>> This allows sk_wait_data() to make informed waiting decisions and prevent
>>>> infinite loops when MSG_PEEK is used.
>>>
>>> (...)
>>>
>>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>>> index cf1852b99963..401fb2b17685 100644
>>>> --- a/net/mptcp/protocol.c
>>>> +++ b/net/mptcp/protocol.c
>>>> @@ -2006,7 +2006,7 @@ static void mptcp_eat_recv_skb(struct sock *sk, struct sk_buff *skb)
>>>> static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>>>>                 size_t len, int flags, int copied_total,
>>>>                 struct scm_timestamping_internal *tss,
>>>> -               int *cmsg_flags)
>>>> +               int *cmsg_flags, struct sk_buff **last)
>>>> {
>>>>     struct mptcp_sock *msk = mptcp_sk(sk);
>>>>     struct sk_buff *skb, *tmp;
>>>> @@ -2048,6 +2048,7 @@ static int __mptcp_recvmsg_mskq(struct sock *sk, struct msghdr *msg,
>>>>         }
>>>>
>>>>         copied += count;
>>>> +       *last = skb;
>>>
>>> My bad, my recommendation to move this assignment here was not a good
>>> idea, because 'skb' can be freed at some points after mptcp_eat_recv_skb
>>> that can be called here below.
>>>
>>> If I'm not mistaken, when MSG_PEEK is not used, sk_wait_data() can
>>> always be called with NULL for the last skb, because the queue is
>>> supposed to be empty. If not, no need to wait for new packets, so NULL
>>> can be used. Is that correct?
>>>
>>> If yes, then I guess 'last' can be initialised to NULL before calling
>>> __mptcp_recvmsg_mskq (limit scope), and only set to 'skb' here below,
>>> when MSG_PEEK is not used (what you had in v1).
>>>
>>> Would that work for you?
>>>
>>> Cheers,
>>> Matt
>>
>> Thanks for the review. I analyzed the concern about the 'last' pointer.
>>
>> When writing the v2 patch, I did consider this case - in non-MSG_PEEK
>> scenario, the skb is freed by mptcp_eat_recv_skb() after setting *last =
>> skb, making 'last' point to freed memory. However, in sk_wait_data(), the
>> 'last' parameter is only used for pointer comparison:
>>
>>     skb_peek_tail(&sk->sk_receive_queue) != skb
>>
>> It only compares the pointer value without dereferencing, so there's no
>> actual UAF issue.
> 
> Indeed, but the skb could be (unlikely) reused at that stage.
> 
> For me, the main point is that mptcp_eat_recv_skb() will remove the
> skb from the queue. Then NULL can be passed instead, safer.
One last thing: as noticed by the AI review, this Fixes tag could be
used instead, as it is more tied to MSG_PEEK:

  Fixes: 8e04ce45a8db ("mptcp: fix MSG_PEEK stream corruption")

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


