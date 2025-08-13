Return-Path: <netdev+bounces-213387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CACB24D3B
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 17:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41DEC189E9DD
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 15:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03CD71FFC48;
	Wed, 13 Aug 2025 15:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LMqNVgUh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D91FBCA7;
	Wed, 13 Aug 2025 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755098351; cv=none; b=oujFmM3xkpYJxmZI7jApi2tGxaRYuD4rN+lVw4XhdNfmuyQNoLDoVi/fROZddwGop7mjQpzcvCGjfr7NzHCkcnYraJLyj3gbJuz9mNlV/nMsBafqc5P3Z7K/1/0dz+hAERK7EBIjC9KpSCqRqStyqjnfSNyclFgqjxIgam+kFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755098351; c=relaxed/simple;
	bh=ttHCoJ0fS9ZoBq3faibRoEWsJ197C4OXVLM3rNqnqdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvt0J+yA2TqjgMyWT2rmRZrD1TYFN7hxSPUm2TR+NgExwDlkPq4Q1Jk7bfsnU7infwbh3I6A7rvXFJEl4UdtVONMSGDYtizW4lHK6GO8r0YGx6mprq7ZAhLLOlu/8m4wfuqFEFQYzUU6G87yYxGAjwDG9jEZ4MQt19oriMeC/mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LMqNVgUh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so61360165e9.1;
        Wed, 13 Aug 2025 08:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755098348; x=1755703148; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=juZ8HOUdWY43tN3quYG7enRlIPop0IESVECKo05cC+o=;
        b=LMqNVgUhClNRBsCfmoZOYqO7XWf3jkv3TVGjxaFTPFa2HQRMmjGLihsYLKC+3dWjhI
         uFkUaxkLU6lxHHQ2roOSDOBw4zp3pjmNqajZBqWPGCW7ekNZeYcvKSkfmkx4qtqxl37h
         Nu64hm1yUs7v2U4BaSVOjjELhEH9VF+mijwITKrG575iviebYkke6HSi33gz045Hnwqv
         w1gRNeEH6jpoVgC4ovvC/D5AdZWnS7UvzaZ7kueFqnnwDxVy58BqMeUi9hc9mlNpFAJD
         M5K7JCqRUZFc5Zcto+fO0TaIt5+Urrxss6C8/HLd8ykPVScDutRx+IJ32/ludeLgY5bg
         guVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755098348; x=1755703148;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=juZ8HOUdWY43tN3quYG7enRlIPop0IESVECKo05cC+o=;
        b=t2vDBP2TrtaMX4uHWPF7pF2CWWYuCb3OiZbOrJAl7CetmPnkOYANXgurBTjIpVHJYa
         jL9hC/Udn97ZgYll2v3j/9R1KwNcFVoH4CbvaRJS/ohftzkcBo3FMmXHul2GF0ZPkqvZ
         1gFFc7f7wwhVq10CbIXMIYj6nFQ2eSWbZmMpjkH2MSxTzjHTvulciP4AjGNmKIo47xtC
         BcoO9+lN7arkuFvsWvOGU+9VoInsNEsOHJWyZl3eIhQc8VvLqmkFw41/2uLibIW+5QYT
         9HjuOUc12DYxYAEWPIoFnhektex4Fwrs8ffIqi7IESZCC9KmkVORwKY8/j5Y/PqlWgaq
         SUIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJX9kty4fVqHEIlzkvG0dKuLNa8x1I0yL5+12IQjTo9wAPJuMnl4LwrTZidMqp8ov0R0CC43sg62Oeo1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzR3N2KTKyWTzA18q3RQ6yOV6EAEeqZzzwvHK7qr0toJBd7E9wn
	4uYR4qwPVrNCnP1ZianTx1S+GADEk/Soy26WoZhGnBnicWJvzgBZkLrM
X-Gm-Gg: ASbGnctk9E1ccvn67LSrcOzbSt3JaNdXPmBdHLzEVUAqOyqqT/uIvUN6XGu6OJXtR9e
	vdPhkYMZSCydOYcIA5sGHCAigJtW7rhrkmiig/v0XLlEm5xfTCcEHGmhNzlZJ4n5SWtqzW1QCKZ
	1rVqvLAki1yRxoZCvMk3rDtOY7sT+egCLXOMFPk/enbtGqKL9fGOpDG29xrhfFKtfIlhqyw2z0G
	NFViG5hxvKYHbf0S7DgTWyhPDjDrvAEF87mc/ZqD/kQZMpysSwaSXSTy4UzdMexDuYJ5D3yZAYy
	JfCKcBoCv9C7FZu09s86GdeZn/164YYgw5oebyEuYZFFMai8MAu41cR19A551+QYCYKP7Ui99M0
	Xk5J0pnmFCTAFYmgYB+Xzr2yyTCC3mrfuKyLOpvttkQvX
X-Google-Smtp-Source: AGHT+IHHdmlCs4XmQ1940ZGsH325xC/Fhaw/95MXYkzM5EjkhUmcuNnI94nlgW6vKFQeM1E/jrYyBQ==
X-Received: by 2002:a05:600c:3b24:b0:459:da76:d7aa with SMTP id 5b1f17b1804b1-45a165e2ec5mr25972245e9.25.1755098348280;
        Wed, 13 Aug 2025 08:19:08 -0700 (PDT)
Received: from localhost ([45.10.155.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48105csm48296954f8f.64.2025.08.13.08.19.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 08:19:08 -0700 (PDT)
Message-ID: <9727fba9-a238-4d0c-aa12-cb6c4cbcdea3@gmail.com>
Date: Wed, 13 Aug 2025 17:18:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v5 3/5] net: vxlan: bind vxlan sockets to their
 local address if configured
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, andrew+netdev@lunn.ch, dsahern@kernel.org,
 shuah@kernel.org, daniel@iogearbox.net, jacob.e.keller@intel.com,
 razor@blackwall.org, petrm@nvidia.com, menglong8.dong@gmail.com,
 martin.lau@kernel.org, linux-kernel@vger.kernel.org
References: <20250812125155.3808-1-richardbgobert@gmail.com>
 <20250812125155.3808-4-richardbgobert@gmail.com> <aJxaYt7aPxuU9iN6@shredder>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <aJxaYt7aPxuU9iN6@shredder>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/13/25 11:26, Ido Schimmel wrote:
> On Tue, Aug 12, 2025 at 02:51:53PM +0200, Richard Gobert wrote:
>> Bind VXLAN sockets to the local addresses if the IFLA_VXLAN_LOCALBIND
>> option is set. This is the new default.
> 
> Drop the last sentence?
> 
>>
>> Change vxlan_find_sock to search for the socket using the listening
>> address.
>>
>> This is implemented by copying the VXLAN local address to the udp_port_cfg
>> passed to udp_sock_create. The freebind option is set because VXLAN
>> interfaces may be UP before their outgoing interface is.
>>
>> This fixes multiple VXLAN selftests that fail because of that race.
> 
> This sentence is no longer relevant as well.
> 
>>
>> Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
>> ---
>>  drivers/net/vxlan/vxlan_core.c | 59 ++++++++++++++++++++++++++--------
>>  1 file changed, 46 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
>> index 15fe9d83c724..12da9595436e 100644
>> --- a/drivers/net/vxlan/vxlan_core.c
>> +++ b/drivers/net/vxlan/vxlan_core.c
>> @@ -78,18 +78,34 @@ static inline bool vxlan_collect_metadata(struct vxlan_sock *vs)
>>  }
>>  
>>  /* Find VXLAN socket based on network namespace, address family, UDP port,
>> - * enabled unshareable flags and socket device binding (see l3mdev with
>> - * non-default VRF).
>> + * bound address, enabled unshareable flags and socket device binding
>> + * (see l3mdev with non-default VRF).
>>   */
>>  static struct vxlan_sock *vxlan_find_sock(struct net *net, sa_family_t family,
>> -					  __be16 port, u32 flags, int ifindex)
>> +					  __be16 port, u32 flags, int ifindex,
>> +					  union vxlan_addr *saddr)
>>  {
>>  	struct vxlan_sock *vs;
>>  
>>  	flags &= VXLAN_F_RCV_FLAGS;
>>  
>>  	hlist_for_each_entry_rcu(vs, vs_head(net, port), hlist) {
>> -		if (inet_sk(vs->sock->sk)->inet_sport == port &&
>> +		struct sock *sk = vs->sock->sk;
>> +		struct inet_sock *inet = inet_sk(sk);
> 
> https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs
> 
>> +
>> +		if (flags & VXLAN_F_LOCALBIND) {
>> +			if (family == AF_INET &&
>> +			    inet->inet_rcv_saddr != saddr->sin.sin_addr.s_addr)
>> +				continue;
>> +#if IS_ENABLED(CONFIG_IPV6)
>> +			else if (family == AF_INET6 &&
>> +				 ipv6_addr_cmp(&sk->sk_v6_rcv_saddr,
>> +					       &saddr->sin6.sin6_addr) != 0)
>> +				continue;
>> +#endif
>> +		}
>> +
>> +		if (inet->inet_sport == port &&
>>  		    vxlan_get_sk_family(vs) == family &&
>>  		    vs->flags == flags &&
>>  		    vs->sock->sk->sk_bound_dev_if == ifindex)

My bad, will fix.

