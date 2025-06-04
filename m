Return-Path: <netdev+bounces-195100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F379ACDF78
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 15:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15F73A508B
	for <lists+netdev@lfdr.de>; Wed,  4 Jun 2025 13:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BC928ECF3;
	Wed,  4 Jun 2025 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fXzIGO5Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568AC2900AF
	for <netdev@vger.kernel.org>; Wed,  4 Jun 2025 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749044470; cv=none; b=YaWqNbvVEDuDh163KXpzcRgjygvTqbIwATGNjMzA6Q1rKzNeCVRPSI5CpGBiYaRYZ+h0LZF5Bxx3MnueTvmXPlFrfX0UXIH6FWRq8r6urj8nQf31H5bV4M1vjnt5cin9ovSHgJBJBs/XYOG1QECUvHSkqS+B5ypHBJ10IFOcLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749044470; c=relaxed/simple;
	bh=VUaXHXGQtJTlEAL2NUbRaJZtxKc78N6bkwtkgRmSA4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hl6aGt9ShydhzrWJ13G4HZ9uugRrXEgCnNuu4vkyIHdGxsLtq298QPohN7dpEEu0Ud0IPdNvVv7XSjABQTVssr4M0NP6qZCr4CoCmZIORn2eseCjoZzHsZQZyTZEntvn5hMPdoBDgMS7D2QFxrC8rs/KDKqw98TaADeyu0sEGYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fXzIGO5Z; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a50fc7ac4dso1930403f8f.0
        for <netdev@vger.kernel.org>; Wed, 04 Jun 2025 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1749044466; x=1749649266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g3W+5PbETo+fXNQh2NZXLtKM7p6GUxBcVZtKFC0IRUo=;
        b=fXzIGO5Zym+ELARmffWfhh+rIYjkzAmWSHP8vSP1x4+uEfhXhT0Ex4TD5PWwS0I7uo
         v/EtApCtchr9L+4CTiaZalUrJkZ6oWiV9Mp4fyso+8fdD+J0BXNI8FRCMbna8pxq4Egg
         KJubRovFuKjoVpHChSfMwCSJA5NdytjqM8W6A9bG0jvPNT7nsAQUuKo7f2XLcoMSN3PO
         oaSBqmxw1p3mN2OLRgtNRhq36UqE6trS0BEa4J0PTvsbdmzWn05kuy17TdjMGb2ViY18
         FlP8SZEjdb9scr4ZQS+6LqzwzgR5Y0/Poh+xbiGFWqG3R7OP/SL3DMYVVWcZ+C6d6hU1
         NORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749044466; x=1749649266;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3W+5PbETo+fXNQh2NZXLtKM7p6GUxBcVZtKFC0IRUo=;
        b=WJb0IJdBQsKLXTuxu4KcQEdxXbZpwLeHJj6tQ2Y3DKMu64FFapN9ejKNhhLikzCngb
         xVGpFL5pUCokSufrgvsB7+ewMrW77RUmkXLncsNNl3yZ+eGZJOYvIkGI+XmrCC/yqIXP
         BOi1uShtq0UAMe+BPSI2nokjFoOGAf+n/8VibbkzuX8gbF7z21ofR72zOobTWXFKiAcA
         NDgL5ARuFoRmYk5X8iTNmN9NQKyWyti5eJE0WwWdu68+9szBwjdXvlZwOfVDwYeoNyu5
         0Wh0qG+MJlFd5cc8svXGjAzfn0qdhevXCiiq4gE68WW7XiuWIeHGbhOfWQ6fSlIdJl4T
         LcMQ==
X-Gm-Message-State: AOJu0YwkG3kEjxAV+213dAvLGupncAI5Vjt/Iu/xpqZj3DkaiMbpc1Dp
	wVbvu6RFo9lARhmM3yBaUS1uBsbJ5LM67e0BUdJ9uKhrSI13qLj6uivNkBw1hSDyPQY8P+gc7mf
	zyFn9jvddWk7D679R4cABK54GeyBqKhaFtgiMapBNlfSxo56NMUw=
X-Gm-Gg: ASbGncvR8JFmWxPTKpaX6W0R8oiusG0q6FZNc7iyzLPyro4R32k9od+BVhoUpdX8jJL
	N7JWlK5YddiOMvgJDL1oRojM+zLA0jm3QgfSBJ0KHJYOo5RoLO/G09B42wV/o6I+7xsadjcx+eX
	iUw5uFhISFPIouM06vthkqtCsdDajGGYEQFEppzUwYJYm4+iu9D6NwgM8CMSSnQn1y54zjTyx5W
	2lJpdUMYO50Co9TFb2/Y0PLmYtlDpkU8H/NmZspIWSMoWpUDgQP1hXy4VgCpAJKH1kXHjza8B8A
	34GMYWqtj4+33Y0CcZIflCslSFio96miUvTs40+3LE/gZrTlf1IuA6q0QL/OTIaxyyNb/bXSbrg
	UD0n/4jKPbwCzUPjJ4u1k4II8
X-Google-Smtp-Source: AGHT+IGUq6Ssinxq8hgJom3bYUP9KTpfK88TzqIPfcUhlMyX8nTOQ78THO8mDbIlxzT3v+ybfJFGew==
X-Received: by 2002:a05:6000:230e:b0:3a5:1cc5:aa6f with SMTP id ffacd0b85a97d-3a51d9583d8mr2300901f8f.34.1749044466228;
        Wed, 04 Jun 2025 06:41:06 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:563d:9d70:bd70:ee17? ([2001:67c:2fbc:1:563d:9d70:bd70:ee17])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe2b35dsm21644340f8f.0.2025.06.04.06.41.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jun 2025 06:41:05 -0700 (PDT)
Message-ID: <c05d08c1-ed23-40d3-8950-d00aca49f480@openvpn.net>
Date: Wed, 4 Jun 2025 15:41:04 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/5] ovpn: properly deconfigure UDP-tunnel
To: Larysa Zaremba <larysa.zaremba@intel.com>
Cc: netdev@vger.kernel.org,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Sabrina Dubroca <sd@queasysnail.net>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20250603111110.4575-1-antonio@openvpn.net>
 <20250603111110.4575-2-antonio@openvpn.net>
 <aEBHNVFvthKTUWuO@soc-5CG4396X81.clients.intel.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <aEBHNVFvthKTUWuO@soc-5CG4396X81.clients.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello Larysa and thanks for chiming in,

On 04/06/2025 15:16, Larysa Zaremba wrote:
> On Tue, Jun 03, 2025 at 01:11:06PM +0200, Antonio Quartulli wrote:
>> When deconfiguring a UDP-tunnel from a socket, we cannot
>> call setup_udp_tunnel_sock() with an empty config, because
>> this helper is expected to be invoked only during setup.
>>
>> Get rid of the call to setup_udp_tunnel_sock() and just
>> revert what it did during socket initialization..
>>
>> Note that the global udp_encap_needed_key and the GRO state
>> are left untouched: udp_destroy_socket() will eventually
>> take care of them.
>>
>> Cc: Sabrina Dubroca <sd@queasysnail.net>
>> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
>> Fixes: ab66abbc769b ("ovpn: implement basic RX path (UDP)")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://lore.kernel.org/netdev/1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> I do not think MC_LOOP is necessarily set before attaching the socket, but 1 is
> the default value, so I guess restoring to it should be fine.
> 
> Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> Another less related thing is more concerning to me: ovpn_udp_socket_attach()
> checks if rcu_dereference_sk_user_data(sock->sk) is NULL to determine if socket
> is available to configure, but a lot of callers of e.g. setup_udp_tunnel_sock(),
> including ovpn, set the user data to NULL by not providing it in the config.
> 
> In such case, is checking rcu_dereference_sk_user_data() actually enough to say
> that "socket is currently unused"?

This is an "interesting" area of the code that required a lot of 
attention during implementation...so having more eyes on it is 
definitely appreciated.

In ovpn we have:

ovpn_socket_new()
   lock_sock()
   ovpn_socket_attach()
     ovpn_udp_socket_attach()
   rcu_assign_sk_user_data() << sk_user_data is assigned here
   release_sock()

The lock takes care of preventing concurrent ovpn_socket_new() 
invocations, with the same sk, to mess things up.

Upon socket detachment, a similar strategy is implemented to make sure 
concurrent attachment/detachment are properly handled.

I hope this helps.

Regards,

> 
>> ---
>>   drivers/net/ovpn/udp.c | 14 +++++++++++---
>>   1 file changed, 11 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
>> index aef8c0406ec9..f4d3bd070f11 100644
>> --- a/drivers/net/ovpn/udp.c
>> +++ b/drivers/net/ovpn/udp.c
>> @@ -442,8 +442,16 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
>>    */
>>   void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
>>   {
>> -	struct udp_tunnel_sock_cfg cfg = { };
>> +	struct sock *sk = ovpn_sock->sock->sk;
>>   
>> -	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
>> -			      &cfg);
>> +	/* Re-enable multicast loopback */
>> +	inet_set_bit(MC_LOOP, sk);
>> +	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
>> +	inet_dec_convert_csum(sk);
>> +
>> +	WRITE_ONCE(udp_sk(sk)->encap_type, 0);
>> +	WRITE_ONCE(udp_sk(sk)->encap_rcv, NULL);
>> +	WRITE_ONCE(udp_sk(sk)->encap_destroy, NULL);
>> +
>> +	rcu_assign_sk_user_data(sk, NULL);
>>   }
>> -- 
>> 2.49.0
>>
>>

-- 
Antonio Quartulli
OpenVPN Inc.


