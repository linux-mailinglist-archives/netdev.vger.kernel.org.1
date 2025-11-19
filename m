Return-Path: <netdev+bounces-240160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F57C70E70
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:53:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C77BC4E1415
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C395E371DF4;
	Wed, 19 Nov 2025 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="cWj/bIdf"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D3220698;
	Wed, 19 Nov 2025 19:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581980; cv=none; b=e/NXEaaoOW33aJA5Os2sXCmBc+CSrpnEAUk65JpPoyVHAZuTjPEiA1QdN8+gD+aoydMXskEx//DcpsYQO6PBKmIAq3nYCH52Y6FTtvrkSspYm6E7TXGx5xrl8PsV0qnlhc3ljJc1NuEnBu+W8XHt3V0qyqSOhq8v3ru38V1XGTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581980; c=relaxed/simple;
	bh=jF6kVo6Hjs7U3p0jUm2wQrED5+i0c1aTSJj3C1XKJPo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2ZiVNO1zzwUYbIlqEhoJPgb4rNh6qGaAgzZ553pt1lJbtqPlFMtKN9gR6qcUcNQr+xHOEmOKPPWWhzwKzL8i3ZBJ0l2UoZid4PlbLEYBRWDT+QzB8Ea8XwZ61ShSAfGdrwt7PkniFIOF2fSE23YRJRG6AcKrIADVCV29rxQ0BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=cWj/bIdf; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vLoEQ-006OPH-30; Wed, 19 Nov 2025 20:52:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=M1tjLezg7BNgs3HfhRtLwjVoRH1sIIdmfgc0Pkts8CE=; b=cWj/bIdfxRAjFQ9tTxzlg1lBeR
	gEKX3Xhb+7jXiBgjl8JotTnysxyTfr0ZgXTDyqKPHBLOKL8GnfltMbGte4W6hXC2HelDEuSZ67gIO
	uxdNe+eIyZNwkva/l1r24rzKzkyYijXZq1KgzknjR9+dL9NV63TT3Sie9RxUudNA7CCa044zSm1j7
	2R82WD8+BcX/M8GY2vCwpam4rHLIZCJSsYkjpklANgR2uWXnNXhTIeaPpT2XYynnh1SMuwdzCo+TQ
	oOLJdsAn/yGsa4JODlT5O2zqAR+Ln2lJ5o8nr5COfERTjeD18hsxwLgl8h1eIW/VsPi9tFgRI70dx
	VL7PNjZw==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vLoEO-0003y3-Jc; Wed, 19 Nov 2025 20:52:44 +0100
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLoED-00GIgn-Sk; Wed, 19 Nov 2025 20:52:33 +0100
Message-ID: <1b2255c7-0e97-4b37-b7ab-e13e90b7b0b9@rbox.co>
Date: Wed, 19 Nov 2025 20:52:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
 <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
 <09c6de68-06aa-404d-9753-907eab61b9ab@rbox.co>
 <663yvkk2sh5lesfvdeerlca567xb64qbwih52bxjftob3umsah@eamuykmarrfr>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <663yvkk2sh5lesfvdeerlca567xb64qbwih52bxjftob3umsah@eamuykmarrfr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/25 17:31, Stefano Garzarella wrote:
> On Wed, Nov 19, 2025 at 03:09:25PM +0100, Michal Luczaj wrote:
>> On 11/19/25 11:36, Stefano Garzarella wrote:
>>> On Tue, Nov 18, 2025 at 11:02:17PM +0100, Michal Luczaj wrote:
>>>> On 11/18/25 10:51, Stefano Garzarella wrote:
>>>>> On Mon, Nov 17, 2025 at 09:57:25PM +0100, Michal Luczaj wrote:
>>>>>> ...
>>>>>> +static void vsock_reset_interrupted(struct sock *sk)
>>>>>> +{
>>>>>> +	struct vsock_sock *vsk = vsock_sk(sk);
>>>>>> +
>>>>>> +	/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>>>>>> +	 * transport->connect().
>>>>>> +	 */
>>>>>> +	vsock_transport_cancel_pkt(vsk);
>>>>>> +
>>>>>> +	/* Listener might have already responded with VIRTIO_VSOCK_OP_RESPONSE.
>>>>>> +	 * Its handling expects our sk_state == TCP_SYN_SENT, which hereby we
>>>>>> +	 * break. In such case VIRTIO_VSOCK_OP_RST will follow.
>>>>>> +	 */
>>>>>> +	sk->sk_state = TCP_CLOSE;
>>>>>> +	sk->sk_socket->state = SS_UNCONNECTED;
>>>>>> +}
>>>>>> +
>>>>>> static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>>>>> 			 int addr_len, int flags)
>>>>>> {
>>>>>> @@ -1661,18 +1678,33 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>>>>> 		timeout = schedule_timeout(timeout);
>>>>>> 		lock_sock(sk);
>>>>>>
>>>>>> +		/* Connection established. Whatever happens to socket once we
>>>>>> +		 * release it, that's not connect()'s concern. No need to go
>>>>>> +		 * into signal and timeout handling. Call it a day.
>>>>>> +		 *
>>>>>> +		 * Note that allowing to "reset" an already established socket
>>>>>> +		 * here is racy and insecure.
>>>>>> +		 */
>>>>>> +		if (sk->sk_state == TCP_ESTABLISHED)
>>>>>> +			break;
>>>>>> +
>>>>>> +		/* If connection was _not_ established and a signal/timeout came
>>>>>> +		 * to be, we want the socket's state reset. User space may want
>>>>>> +		 * to retry.
>>>>>> +		 *
>>>>>> +		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>>>>>> +		 * vsock_connected_table. We keep the binding and the transport
>>>>>> +		 * assigned.
>>>>>> +		 */
>>>>>> 		if (signal_pending(current)) {
>>>>>> 			err = sock_intr_errno(timeout);
>>>>>> -			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>>>>>> -			sock->state = SS_UNCONNECTED;
>>>>>> -			vsock_transport_cancel_pkt(vsk);
>>>>>> -			vsock_remove_connected(vsk);
>>>>>> +			vsock_reset_interrupted(sk);
>>>>>> 			goto out_wait;
>>>>>> -		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
>>>>>> +		}
>>>>>> +
>>>>>> +		if (timeout == 0) {
>>>>>> 			err = -ETIMEDOUT;
>>>>>> -			sk->sk_state = TCP_CLOSE;
>>>>>> -			sock->state = SS_UNCONNECTED;
>>>>>> -			vsock_transport_cancel_pkt(vsk);
>>>>>> +			vsock_reset_interrupted(sk);
>>>>>> 			goto out_wait;
>>>>>
>>>>> I'm fine with the change, but now both code blocks are the same, so
>>>>> can we unify them?
>>>>> I mean something like this:
>>>>> 		if (signal_pending(current) || timeout == 0 {
>>>>> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>>>>> 			...
>>>>> 		}
>>>>>
>>>>> Maybe at that point we can also remove the vsock_reset_interrupted()
>>>>> function and put the code right there.
>>>>>
>>>>> BTW I don't have a strong opinion, what do you prefer?
>>>>
>>>> Sure, no problem.
>>>>
>>>> But I've realized invoking `sock_intr_errno(timeout)` is unnecessary.
>>>> `timeout` can't be MAX_SCHEDULE_TIMEOUT, so the call always evaluates to
>>>> -EINTR, right?
>>>
>>> IIUC currently schedule_timeout() can return MAX_SCHEDULE_TIMEOUT only
>>> if it was called with that parameter, and I think we never call it in
>>> that way, so I'd agree with you.
>>>
>>> My only concern is if it's true for all the stable branches we will
>>> backport this patch.
>>>
>>> I would probably touch it as little as possible and continue using
>>> sock_intr_errno() for now, but if you verify that it has always been
>>> that way, then it's fine to change it.
>>
>> All right then, here's a v2 with minimum changes:
>> https://lore.kernel.org/netdev/20251119-vsock-interrupted-connect-v2-1-70734cf1233f@rbox.co/
>>
> 
> Thanks!
> 
>> Note a detail though: should signal and timeout happen at the same time,
>> now it's the timeout errno returned.
>>
> 
> Yeah, I thought about that, but I don't see any problems with that.
> I mean, it's something that if it happens, it's still not deterministic,
> so we're not really changing anything.

Mhm, I suppose.

To follow up, should I add a version of syzkaller's lockdep warning repro
to vsock test suite? In theory it could test this fix here as well, but in
practice the race window is small and hitting it (the brute way) takes
prohibitively long.


