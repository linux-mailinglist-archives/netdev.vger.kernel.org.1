Return-Path: <netdev+bounces-239731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 95027C6BCCA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 23:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 6A77129EAA
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 22:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD372DC780;
	Tue, 18 Nov 2025 22:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="WDVuclEl"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E7D23C50A;
	Tue, 18 Nov 2025 22:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763503370; cv=none; b=fXhOCeWkuURpiK0gGByJpabsOeRtAkIpBqDql4ZP50Db5pTNF+aHZ39pEpR3Lf15zY5RXqCbH9Mlf4/e1kgHSvdFGkJ3NEAU/LHFE/EntFublgpI+xgicASxA/HRBo8tPsdjWibG+3dzr/s8JBR5DbYfV9OBP4hIOzKqV8Si7UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763503370; c=relaxed/simple;
	bh=qt8YtmRRkvQ2yeCkPnEr7p67nxETOf/EAmWtWVVS0cM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pc+22yljo0U46R5CJ2iE+/E4k/OqG3figHtQY8lxUGzN0sGlPBUP3fZZ8hIwUc0cl7wKalqRKC3dpOZs6nocj1MzvL5Uci3/xTnGCCIQerwnltZZnOIGRhazv1aSYMazMIoqr9XRPkMh9zLvD+oMxPvFwDbNFsihiiStlrNy0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=WDVuclEl; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1vLTmQ-003iTx-JX; Tue, 18 Nov 2025 23:02:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=keZF4Ro1KbsT0C9XLhSfH/0XAC1TntygSwFSkeooq8U=; b=WDVuclElyOJrA9ymxpO1wHKVNp
	BUhxZrzmjo+CRe3OkW885aJzWO4t/G1ePeISzc5gtQjgkP+8tWpHeEn8lEl0vsDXkWMAAcqBEBt0F
	Qyny7V6YKg2c3Hb7JexOF0olTtFu50tGa25C2zeb6PCHB1zpH0dmbrumEhj5Hxthwyk48iU1kfgaB
	BbTLUtBtuuJlAOBNe2+MY/PNZUFV5NCzRsWoYnQzqhwlT+bxoGBDXstSf/Q6Sky0bPln/4ON8+VLC
	89x4AVls9AG9D0gfP0Id6b8ep6+rQwaBUJ73gzjeTx8DFoDkhUPB3BMB2vKGDxh75NW18xcsT+BwZ
	MjdL4iaA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1vLTmP-0006gg-TN; Tue, 18 Nov 2025 23:02:30 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLTmE-00DR69-OD; Tue, 18 Nov 2025 23:02:18 +0100
Message-ID: <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
Date: Tue, 18 Nov 2025 23:02:17 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
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
Content-Language: pl-PL, en-GB
In-Reply-To: <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/18/25 10:51, Stefano Garzarella wrote:
> On Mon, Nov 17, 2025 at 09:57:25PM +0100, Michal Luczaj wrote:
>> ...
>> +static void vsock_reset_interrupted(struct sock *sk)
>> +{
>> +	struct vsock_sock *vsk = vsock_sk(sk);
>> +
>> +	/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>> +	 * transport->connect().
>> +	 */
>> +	vsock_transport_cancel_pkt(vsk);
>> +
>> +	/* Listener might have already responded with VIRTIO_VSOCK_OP_RESPONSE.
>> +	 * Its handling expects our sk_state == TCP_SYN_SENT, which hereby we
>> +	 * break. In such case VIRTIO_VSOCK_OP_RST will follow.
>> +	 */
>> +	sk->sk_state = TCP_CLOSE;
>> +	sk->sk_socket->state = SS_UNCONNECTED;
>> +}
>> +
>> static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>> 			 int addr_len, int flags)
>> {
>> @@ -1661,18 +1678,33 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>> 		timeout = schedule_timeout(timeout);
>> 		lock_sock(sk);
>>
>> +		/* Connection established. Whatever happens to socket once we
>> +		 * release it, that's not connect()'s concern. No need to go
>> +		 * into signal and timeout handling. Call it a day.
>> +		 *
>> +		 * Note that allowing to "reset" an already established socket
>> +		 * here is racy and insecure.
>> +		 */
>> +		if (sk->sk_state == TCP_ESTABLISHED)
>> +			break;
>> +
>> +		/* If connection was _not_ established and a signal/timeout came
>> +		 * to be, we want the socket's state reset. User space may want
>> +		 * to retry.
>> +		 *
>> +		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>> +		 * vsock_connected_table. We keep the binding and the transport
>> +		 * assigned.
>> +		 */
>> 		if (signal_pending(current)) {
>> 			err = sock_intr_errno(timeout);
>> -			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>> -			sock->state = SS_UNCONNECTED;
>> -			vsock_transport_cancel_pkt(vsk);
>> -			vsock_remove_connected(vsk);
>> +			vsock_reset_interrupted(sk);
>> 			goto out_wait;
>> -		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
>> +		}
>> +
>> +		if (timeout == 0) {
>> 			err = -ETIMEDOUT;
>> -			sk->sk_state = TCP_CLOSE;
>> -			sock->state = SS_UNCONNECTED;
>> -			vsock_transport_cancel_pkt(vsk);
>> +			vsock_reset_interrupted(sk);
>> 			goto out_wait;
> 
> I'm fine with the change, but now both code blocks are the same, so
> can we unify them?
> I mean something like this:
> 		if (signal_pending(current) || timeout == 0 {
> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
> 			...
> 		}
> 
> Maybe at that point we can also remove the vsock_reset_interrupted()
> function and put the code right there.
> 
> BTW I don't have a strong opinion, what do you prefer?

Sure, no problem.

But I've realized invoking `sock_intr_errno(timeout)` is unnecessary.
`timeout` can't be MAX_SCHEDULE_TIMEOUT, so the call always evaluates to
-EINTR, right?

