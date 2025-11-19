Return-Path: <netdev+bounces-239924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E14C6E08B
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 11:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 049254E29CF
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 10:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394D334D4C6;
	Wed, 19 Nov 2025 10:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cfzVWmEp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nUdtxk4u"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C12346FA4
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763548593; cv=none; b=gpnaeninGrk2CzShFB5I84U0NJSPWxJxThjE6BN1qMea46VswrIOje0CuiU66lb/SZM6GeiI/ZgqIGa/mefdbRXRdr8jFu5mX7L69fg7e0wFUW/9lwjmua/rtAq931HOYutSHjDXFhXcGrXYiJkbyces6fPduPqwt3xLpvib03A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763548593; c=relaxed/simple;
	bh=kcdSh/PleBZTikfdfxnDkRlvpKVEXW64pLQbMvoyV0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5y2a4xPryFXjIEDjRtTlvWCKBd4hx1CNQ9AaM3Ydway2WPsnuCVt1VX0K1TrRMe+Z2Tyt0b53QkcJNJjrQkikCwnnQbARR5XzFI0/h4DABYLIH4EQ3DbhB+jffNTMhIlUALlV2AlmEeXmwAH9mlpRiK+laCcEBmFMLCQV17fYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cfzVWmEp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nUdtxk4u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763548589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gf49AAxeoAe3fsAYRgAbyAHDAwCYQHRIMr0VODeYCYE=;
	b=cfzVWmEpTHRglvvlGvSpz38Y++5VfC/fGAhB9ZvEPwC2PCrSVQlCKylnAex9AsHgg/LOAy
	w+FrNAHnwN4rhCGDpiy17Z5cdHkho1Je0NDaqSdvLAOyrt9GBBBaqI3kgDaIK6f3XdUaY6
	xvK88kKTGhkmL2uVrb5D9GRm8vWslko=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-UkkeaV1ONM2U5xeJvoyVRQ-1; Wed, 19 Nov 2025 05:36:28 -0500
X-MC-Unique: UkkeaV1ONM2U5xeJvoyVRQ-1
X-Mimecast-MFC-AGG-ID: UkkeaV1ONM2U5xeJvoyVRQ_1763548587
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ee416413a8so3531031cf.1
        for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763548587; x=1764153387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gf49AAxeoAe3fsAYRgAbyAHDAwCYQHRIMr0VODeYCYE=;
        b=nUdtxk4uwAdCldP3TyRLWGeuTsTx1zXixYPu3WLu5dryYVDGqAHC9p8IBcnEbFD3Wy
         pHtyW63ScM9W4F36Xjpx39WZKM9SrqhiIYrg5chnUhsVLvpqFgSE1+mmlW2vpjiVXP2c
         TgM1mvAc5hrYkqS2v7MN5h8CRNfYuvcKRLva6CF+O2b3XsycRL1+JJQIxJF1gD7wNq1i
         1TMUhwNqljrWgLaPLV+vuj81BP2uyY72ttp8HIe7RWMAJlrW3wZZd0wD46RlUS1K7DxK
         z72czAfBXAwiBWI5h+DSUoQ1PzB/wG8YOY4oePgVUiR+wbf0RKVAWRu81Bkl5R6UJr+N
         oH9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763548587; x=1764153387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gf49AAxeoAe3fsAYRgAbyAHDAwCYQHRIMr0VODeYCYE=;
        b=B9hKYpHgNbd2QNhD4Kyqb8OF3fQLa5O5WSEzM3u57C7AZ98Q0cTSNLWcbGon8AyGAu
         kytWoBU+lfqv8NfwXTSuTbmgJ8bqswMT4MDTCMlqByGnoE9gRD/rv6KDe8XPOqlshI5l
         cefE+L1Gf8pAmnH1VPolq8LP1PboteeLDgO3pSfuKtNF27RgEd0WJjIYUdQNe4CItMPY
         FL7XCciWWB8Hm05f3VADVW5ev51TuW0VCtO/U9MiBJmjSwoOvq6QAHc59owpjrh7D7I+
         r10qjzL0PKTx5nTb7jOLt5RVfPTNT2Ebq9FjoqCfIHnX5ha16LTlVwu6Nn/JbtIUp7cl
         baZw==
X-Forwarded-Encrypted: i=1; AJvYcCVb7ZZX7B9wv5lHS+9L1zuIIIX5rGT5Q/c82OogUSjh7UklpVrsGhAqQUq/BgmKfd2310bphhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUcD8jYBN1Pv4eBsQJ1Ao57SiqskLl4ihDtg05EVk30Xo5cdV9
	OnrBlkPNvzdrYTvw5kV10GGTzgNXLTTjjiOP7ZUtgiDPuznLsu6hDHrP+raUmle7Tefnu1s0Uka
	v10jrUvMPWCGS7WSw/LMPzCWmak3Dkg0GoO8DhHdMfLZWQNjO1rXqTC37Ew==
X-Gm-Gg: ASbGncvailWCHJLDdkZKf6vw4LY9bRKpGT+RPAvoqsjNUfsGRRnRoWuw3/H/dVI7heY
	qB9KKHK7+Kw+PkdmV5Xq3LVYtn2VKc+bWbZhV0AWFwkv66Zbxg8KHRbyFbsQfVvIpGYomOzqtR9
	aYUPMabh/RRLhhr3i/hdEwLtueYSBsICH9m5Nvy8u1pjGFMxxQTQ/jRMT0LN1jZZzbMSJATMUtm
	fL2B5RhH6SzeTYnu3TX8Ur7ugsd2Gsn+tWvDVFbXraXCaQPyU3xNyCqb8Fwebda4DhT727nkIF7
	zXbLq9RHS3nGV50b6Ppe7HcUxaRheXTi/br0WXpDqQ4XhZQZ8CsEV3iTA16D+5M8SZWRcYn4jhv
	7mFytRbqBjfQWJHGMrkMj6+O7nmfoteZ7zsv460BFaf48QFPvp+JU3IhrVctyHA==
X-Received: by 2002:a05:622a:10f:b0:4ed:6a9c:7234 with SMTP id d75a77b69052e-4edf2168c05mr266308401cf.82.1763548587568;
        Wed, 19 Nov 2025 02:36:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGVGJYPcB6hMM4y6xFLsb0pmmyzT45mb5Y4pZPNRH1v2gTnyuz3m9keijTXuBrk/slwac9+Q==
X-Received: by 2002:a05:622a:10f:b0:4ed:6a9c:7234 with SMTP id d75a77b69052e-4edf2168c05mr266308091cf.82.1763548587068;
        Wed, 19 Nov 2025 02:36:27 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ede86b3adesm124475941cf.1.2025.11.19.02.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 02:36:24 -0800 (PST)
Date: Wed, 19 Nov 2025 11:36:15 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock: Ignore signal/timeout on connect() if already
 established
Message-ID: <rptu2o7jpqw5u5g4xt76ntyupsak3dcs7rzfhzeidn6vcwf6ku@dcd47yt6ebhu>
References: <20251117-vsock-interrupted-connect-v1-1-bc021e907c3f@rbox.co>
 <dh6gl6xzufrxk23dwei3dcyljjlspjx3gwdhi6o3umtltpypkw@ef4n6llndg5p>
 <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <98e2ac89-34e9-42d9-bfcf-e81e7a04504d@rbox.co>

On Tue, Nov 18, 2025 at 11:02:17PM +0100, Michal Luczaj wrote:
>On 11/18/25 10:51, Stefano Garzarella wrote:
>> On Mon, Nov 17, 2025 at 09:57:25PM +0100, Michal Luczaj wrote:
>>> ...
>>> +static void vsock_reset_interrupted(struct sock *sk)
>>> +{
>>> +	struct vsock_sock *vsk = vsock_sk(sk);
>>> +
>>> +	/* Try to cancel VIRTIO_VSOCK_OP_REQUEST skb sent out by
>>> +	 * transport->connect().
>>> +	 */
>>> +	vsock_transport_cancel_pkt(vsk);
>>> +
>>> +	/* Listener might have already responded with VIRTIO_VSOCK_OP_RESPONSE.
>>> +	 * Its handling expects our sk_state == TCP_SYN_SENT, which hereby we
>>> +	 * break. In such case VIRTIO_VSOCK_OP_RST will follow.
>>> +	 */
>>> +	sk->sk_state = TCP_CLOSE;
>>> +	sk->sk_socket->state = SS_UNCONNECTED;
>>> +}
>>> +
>>> static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>> 			 int addr_len, int flags)
>>> {
>>> @@ -1661,18 +1678,33 @@ static int vsock_connect(struct socket *sock, struct sockaddr *addr,
>>> 		timeout = schedule_timeout(timeout);
>>> 		lock_sock(sk);
>>>
>>> +		/* Connection established. Whatever happens to socket once we
>>> +		 * release it, that's not connect()'s concern. No need to go
>>> +		 * into signal and timeout handling. Call it a day.
>>> +		 *
>>> +		 * Note that allowing to "reset" an already established socket
>>> +		 * here is racy and insecure.
>>> +		 */
>>> +		if (sk->sk_state == TCP_ESTABLISHED)
>>> +			break;
>>> +
>>> +		/* If connection was _not_ established and a signal/timeout came
>>> +		 * to be, we want the socket's state reset. User space may want
>>> +		 * to retry.
>>> +		 *
>>> +		 * sk_state != TCP_ESTABLISHED implies that socket is not on
>>> +		 * vsock_connected_table. We keep the binding and the transport
>>> +		 * assigned.
>>> +		 */
>>> 		if (signal_pending(current)) {
>>> 			err = sock_intr_errno(timeout);
>>> -			sk->sk_state = sk->sk_state == TCP_ESTABLISHED ? TCP_CLOSING : TCP_CLOSE;
>>> -			sock->state = SS_UNCONNECTED;
>>> -			vsock_transport_cancel_pkt(vsk);
>>> -			vsock_remove_connected(vsk);
>>> +			vsock_reset_interrupted(sk);
>>> 			goto out_wait;
>>> -		} else if ((sk->sk_state != TCP_ESTABLISHED) && (timeout == 0)) {
>>> +		}
>>> +
>>> +		if (timeout == 0) {
>>> 			err = -ETIMEDOUT;
>>> -			sk->sk_state = TCP_CLOSE;
>>> -			sock->state = SS_UNCONNECTED;
>>> -			vsock_transport_cancel_pkt(vsk);
>>> +			vsock_reset_interrupted(sk);
>>> 			goto out_wait;
>>
>> I'm fine with the change, but now both code blocks are the same, so
>> can we unify them?
>> I mean something like this:
>> 		if (signal_pending(current) || timeout == 0 {
>> 			err = timeout == 0 ? -ETIMEDOUT : sock_intr_errno(timeout);
>> 			...
>> 		}
>>
>> Maybe at that point we can also remove the vsock_reset_interrupted()
>> function and put the code right there.
>>
>> BTW I don't have a strong opinion, what do you prefer?
>
>Sure, no problem.
>
>But I've realized invoking `sock_intr_errno(timeout)` is unnecessary.
>`timeout` can't be MAX_SCHEDULE_TIMEOUT, so the call always evaluates to
>-EINTR, right?

IIUC currently schedule_timeout() can return MAX_SCHEDULE_TIMEOUT only 
if it was called with that parameter, and I think we never call it in 
that way, so I'd agree with you.

My only concern is if it's true for all the stable branches we will 
backport this patch.

I would probably touch it as little as possible and continue using 
sock_intr_errno() for now, but if you verify that it has always been 
that way, then it's fine to change it.

Thanks,
Stefano


