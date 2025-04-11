Return-Path: <netdev+bounces-181672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54172A860F6
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 16:46:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C26C8A5A18
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 14:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1ED20ADF8;
	Fri, 11 Apr 2025 14:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="gce8RSQQ"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECA61F9F7A
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 14:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744382704; cv=none; b=knVm38bGTObKTGgo7c3zl+5I7MEm6Tg6vdlrlKGgWyfA0PGhC5uV8L+/URxMLsjyEimKAK49TrJ8CrMXCV/0Z8b6/IIMM5t9MKmaXLr+7HX0faWbm48kLUMpx2PNutnlhRyOvsP4bsKIREQ7AtagXHAdYK6Xf2sMjde/ihbiI2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744382704; c=relaxed/simple;
	bh=73I6OIyoBjlsw0UkAQPplJhj3ndP2LXmxHFFHdQaNaE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=RpoxpnPWUOXPIeV2EuZ9EFYK8vWVgr94XyD1SHlS53uLoUFUGNm3z+Ye6UCSklkzk94iuL17VPW0BGDB3PUIo4dGBxv9c2hSXsDJPvBc41GFkx+x1cTvY5jTbZuReP8dlSq3KdQEeJ7y9a8REiDdRMt1Ko+0eVC+Qe7cMoBpQQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=gce8RSQQ; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1u3Fcn-006Fx0-41; Fri, 11 Apr 2025 16:44:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=QmKDk29VSF7eUUzFYWhWK27INyl4aUuIO4XeElkwTWE=; b=gce8RSQQXJ7zSXJvKcZ96i9QoT
	0o+4arI5onwYQgLj9bwZadVOkAVGPK3HENZNix89SfmiaMgmIFRC3bIOAJtPz7/7VWrSxoRP0jvtJ
	t+MEaiYC/WOtkOIOeBAgBkdWhpspNW/i1AXk38Ilbd7OFeXO6EyrT1o7WT6splDybvs8kfbKPqIKS
	Q70tZIToQYbe2wUTULaBqmOy56haFLjUIAG+EOK+ygIvr/7hYbGgcbPtkW6Aca85zl2b0rA525Zxz
	M0A6ZxLH3zh0DaJwKA4bStt5P3JqC3Bb0t92cAUbS0z9BQMfSx1QtOFCkBOEEwcG7gRZCw8MnWFEA
	Mesq2qVw==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1u3Fcm-00085B-Bz; Fri, 11 Apr 2025 16:44:56 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1u3Fca-00ElEU-FG; Fri, 11 Apr 2025 16:44:44 +0200
Message-ID: <e07fd95c-9a38-4eea-9638-133e38c2ec9b@rbox.co>
Date: Fri, 11 Apr 2025 16:44:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: bytes_unsent forever elevated (was Re: [PATCH net 2/2] vsock/test:
 Add test for SO_LINGER null ptr deref)
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <n3azri2tr3mzyo2ahwtrddkcwfsgyzdyuowekl34kkehk4zgf7@glvhh6bg4rsi>
 <5c19a921-8d4d-44a3-8d82-849e95732726@rbox.co>
 <vsghmgwurw3rxzw32najvwddolmrbroyryquzsoqt5jr3trzif@4rjr7kwlaowa>
 <df2d51fd-03e7-477f-8aea-938446f47864@rbox.co>
 <xafz4xrgpi5m3wedkbhfx6qoqbbpogryxycrvawwzerge3l4t3@d6r6jbnpiyhs>
 <f201fcb6-9db9-4751-b778-50c44c957ef2@rbox.co>
 <hkhwrfz4dzhaco4mb25st5zyfybimchac3zcqsgzmtim53sq5o@o4u6privahp3>
 <aa00af3b-2bb1-4c09-8222-edeec0520ae1@rbox.co>
 <cd7chdxitqx7pvusgt45p7s4s4cddyloqog2koases4ocvpayg@ryndsxdgm5ul>
 <7566fe52-23b7-46cc-95ef-63cbbd3071a1@rbox.co>
 <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
Content-Language: pl-PL, en-GB
In-Reply-To: <kiz4tjwsvauyupixpccqug5wt7tq7g3mld5yy5drpg5zxkmiap@3z625aedysx7>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/11/25 15:21, Stefano Garzarella wrote:
> On Fri, Apr 04, 2025 at 12:06:36AM +0200, Michal Luczaj wrote:
>> On 4/1/25 12:32, Stefano Garzarella wrote:
>>> On Tue, Mar 25, 2025 at 02:22:45PM +0100, Michal Luczaj wrote:
>>>> ...
>>>> Turns out there's a way to purge the loopback queue before worker processes
>>>> it (I had no success with g2h). If you win that race, bytes_unsent stays
>>>> elevated until kingdom come. Then you can close() the socket and watch as
>>>> it lingers.
>>>>
>>>> connect(s)
>>>>  lock_sock
>>>>  while (sk_state != TCP_ESTABLISHED)
>>>>    release_sock
>>>>    schedule_timeout
>>>>
>>>> // virtio_transport_recv_connecting
>>>> //   sk_state = TCP_ESTABLISHED
>>>>
>>>>                                       send(s, 'x')
>>>>                                         lock_sock
>>>>                                         virtio_transport_send_pkt_info
>>>>                                           virtio_transport_get_credit
>>>>                                    (!)      vvs->bytes_unsent += ret
>>>>                                           vsock_loopback_send_pkt
>>>>                                             virtio_vsock_skb_queue_tail
>>>>                                         release_sock
>>>>                                       kill()
>>>>    lock_sock
>>>>    if signal_pending
>>>>      vsock_loopback_cancel_pkt
>>>>        virtio_transport_purge_skbs (!)
>>>>

So is this something to worry about? The worst consequence I can think of
is: linger with take place when it should not.

Thanks,
Michal

