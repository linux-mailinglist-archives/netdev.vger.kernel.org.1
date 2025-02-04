Return-Path: <netdev+bounces-162806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613B3A27FD5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 00:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE27A165B9D
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 23:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C55421CA12;
	Tue,  4 Feb 2025 23:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="bm2g2bNy"
X-Original-To: netdev@vger.kernel.org
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC321C161
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 23:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738713597; cv=none; b=Ym1lI3CQF4tP5yvaV3fpgn6y6W+qFDA5glUKQZ4y42UVIIApgIJHVHlrt63YSR951/Ig2ZcsO5j36gvT7Ukzwn0mhQjSBtL1LBf8g6vuf7F0uY+p9cg0BBvtAOQwo4HeDam7mUh17eGEXx7x0v5ZtbcePQfJbbQVTIPbkJt2Su8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738713597; c=relaxed/simple;
	bh=khXAhefL7fQ5LtOLUfh09A9W0Qte7PHize619rzd90A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oudco+MGMlV4YRZJ48qDDjX2MsZXdLRIfk+obix/UGtHwyPSL9pMeujwnW9+bhxnsSc9sQYpkhYd5yiiDxz11SWbkc3ypBVVKFsMamgsd9q75LoDP4gIKohW0omxfRcPEthrRF7AqWi8tOcWVaAjErE4Rxp6m9Xl1/i5/kUn2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=bm2g2bNy; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tfSpc-005ylr-Aa
	for netdev@vger.kernel.org; Wed, 05 Feb 2025 00:59:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=VpRZmV1c6hxxIVMLvNepADjWHDMr6G70vRzw5UrHl4c=; b=bm2g2bNy78jQc4LpHLntVcaA0c
	76jKj/b1nKp4Lr7ewD2bCfih+WrObW8nakhe/4fDblWzcJ7J2hsE3S47EMDfDfab4WPQvzGB6mL6i
	VverzaTZOl0lPILPWJPF0EhNu+3zIKmDcE3pNA3hmyE8pkWBojV8ptM5RuvH1XfEiPawqMMPf75nQ
	VRkJfc0AFRTK6REwNqR3qmgN26Jea3684WOpQveqi5+fDbnqdtbmvfpcQGs4+JxDFdTfi+ba5bCgP
	vZfNTL4KC+0BmSVylUGZqzeIkhm9vlo5OH5EbzW8wJvpK/mZQXvYv8xFlzhHXWyydFC3M+Y3tqhL5
	bhpnjbEQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tfSpb-0002MG-JY; Wed, 05 Feb 2025 00:59:51 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tfSpG-009YTm-LZ; Wed, 05 Feb 2025 00:59:30 +0100
Message-ID: <3dcc1801-a256-4a72-8371-1f06b57cef86@rbox.co>
Date: Wed, 5 Feb 2025 00:59:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] vsock: Orphan socket after transport release
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com
References: <20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co>
 <20250204-vsock-linger-nullderef-v1-1-6eb1760fa93e@rbox.co>
 <jj6xlb2udt2khosipoi4m6iwjc6g5hau3jnzbf6dg2aredfykp@y7j4jlgd4tpr>
From: Michal Luczaj <mhal@rbox.co>
Content-Language: pl-PL, en-GB
In-Reply-To: <jj6xlb2udt2khosipoi4m6iwjc6g5hau3jnzbf6dg2aredfykp@y7j4jlgd4tpr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/4/25 11:32, Stefano Garzarella wrote:
> On Tue, Feb 04, 2025 at 01:29:52AM +0100, Michal Luczaj wrote:
>> @@ -824,13 +824,14 @@ static void __vsock_release(struct sock *sk, int level)
>> 	 */
>> 	lock_sock_nested(sk, level);
>>
> 
> I would add a comment here to explain that we need to set it, so 
> vsock_remove_sock() called here some lines above, or by transports in 
> the release() callback (maybe in the future we can refactor it, and call 
> it only here) will remove the binding only if it's set, since the 
> release() is also called when de-assigning the transport.
> 
>> -	sock_orphan(sk);
>> +	sock_set_flag(sk, SOCK_DEAD);

OK, will do.

Thanks,
Michal


