Return-Path: <netdev+bounces-293089-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMHADA1xGWqNwggAu9opvQ
	(envelope-from <netdev+bounces-293089-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:57:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC14601324
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 12:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 570513069E82
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 10:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2563C9ED8;
	Fri, 29 May 2026 10:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XWACDx0+";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="n7SUpnhW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52127332EAD
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780052005; cv=none; b=uAUIw+HTcQpFEFwMwv3C7h+hVzAKCSxY6WbYPfPHWj2lEOMPfGmALFJs2c00Y32bz3QqPyo3N2lxDdVRT/igTSN+sEbyePAJ5yQJUvC3yKD+PuU/zb5tiQdbyy/saHP/M5kogPC2ksDwoVaQZIcstBSU+Ncy7MRmefrGNUJoW8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780052005; c=relaxed/simple;
	bh=AmilyMgVPk0GQtdVfeFcAOQZf56kW1xFZHZVcCQ/9E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kkpun1f7fM3i+dOFcWnUUkj+8gcT9ujXeT1mLgNpnD80BAloHcsZGX/m37Wl33BRqDXHGwmC6syIj921baOO1zmxtCPbaufuBwq0eR9Gjh8Digw/Rr5TIcl/NbU4aSmxi8lb918Jy9s4VVaQsdD7IIuGtG/BXnn7jMkffWIRvJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XWACDx0+; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=n7SUpnhW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780052003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8zb2QZTiLloyzysLbsnjtkqxvYXQnQ641Q4cnR6a8OI=;
	b=XWACDx0+tNF6Iif8GSILz2ig+Wtbj7vrqaB/8ImBg98uKbyZu8sOAT0E1xcpamUodwCdH2
	EPhewQ9NySYTlJ/6JLOFqT3mQEx0vB4ZyA/FTRd7iKVIfHKWAZuxcZ6dwAtnc7iodQbBdB
	mgtfRDaBD/4K+5kWUtspgXSihjC9Vwg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-u9VSdGpOOUCiH4KibFjUyg-1; Fri, 29 May 2026 06:53:22 -0400
X-MC-Unique: u9VSdGpOOUCiH4KibFjUyg-1
X-Mimecast-MFC-AGG-ID: u9VSdGpOOUCiH4KibFjUyg_1780052001
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-48ff0eb77b5so40261255e9.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 03:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780052001; x=1780656801; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8zb2QZTiLloyzysLbsnjtkqxvYXQnQ641Q4cnR6a8OI=;
        b=n7SUpnhWY40YQptbUSL6Jz9eLQuphYbUIQv6Y/A9WZNiLRXnbWdZLOye/sKgtIEBbQ
         L1C/bAhDtGPPhc0sa+9Qqjs3b3qlEFAZTgi4mD9zbs9RJN/rT1iuudrSDW7m24tneu8N
         U1drG+J+aEAJDtyLty+88rmqnln6GK/q5XQZ3SwqyKHwPKTuyPXXLLeFIbzF8FGvdVQP
         +7VtY1JgMr3iwhlIyxKEy0jp5i04/nBTsVnxsRamUUjgWgjypnxR23w/+Wo6VsQfqfaE
         N3Dhn4eWGLy+cQX5GIxcI24+5PYkef7VNfCrkaX6w4lIwQwboxH7/ThF+TIC1D9YvCZv
         Bjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780052001; x=1780656801;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8zb2QZTiLloyzysLbsnjtkqxvYXQnQ641Q4cnR6a8OI=;
        b=VxSGyEfOW8fHpQ70bd/VnDCl6TpMd8+JA/SVTniKVXfrUjjp2vTAQvOwSfB+qyegE6
         zaKoVgGoOSH49kkmJMTqYbAx25TheYdc7lFDR1IamMix3ucYHTIu1WaXgdMD0cSA3wVK
         P5TwWLQ5EdDHHDsyMJxyKETPnm99h/+SL/T11BMXZhoOPMuqnwzjy8NyfdUw/dTLo1ZB
         ufPY9pfohNaEXFdFuaPM0ziqVN/EuVjV2sGTbpKEbkqNZHFbYoTWXvphLe/ApMEd/B5y
         +KS4Otv3MKZxPnoqPtFT4JYSE8gkecGuvGFTDQvctRmqDpDhBX/ttIAxDtD4+6Mr4rMb
         wkTw==
X-Forwarded-Encrypted: i=1; AFNElJ+4od73QN57XaQ8wAP6GXftaZPq0gOxrIzyN3PUuoUiXBXKOH6M+FdUr2iI9FCqFMLaiWQdDC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0q/5qrmzfnqYlYf4j75XJtbCB7diGDmjGwP0NzGFwHTQfqGb5
	TWpV41RNg8a9/aIPgsYXe5KXImfkEjUnSURXJ8e8+SSq6zfeOw+8w/XHSlEDEQ7y4Z3GoKUJ1AP
	L7r3h5uL1BdzWS+dyD0UFDuGSiAIt3c9YXRGFPf+ORLMYpFou60Lw7tk7NOZnLGMY3Q==
X-Gm-Gg: Acq92OHFqNFDB39Cb1yY7DLfJ2ZzFCupjyqkniCCnK3uDFEVzAnH0kGnGlDqxl7gStW
	zsWLXpA5yJTqifk2DsitA41jseaRYujh0wDQxPUrcwCl3WAVVkdeXkswN10G2MsjwHJd3ku+iQ6
	z1slPKXbul5+XPV95QmwLnKXfk113uUqi9DjJpZQ11POGa06Gjgw1GM6rcLK6TMIsa4ctnAENPF
	VZJLyiaOebivwwpwHXnW7SnYAqV6YiVBIRsGwGT0M2ZuIGbKuKOKCJZcCfF0IFDzZb14MvV2hqD
	5jRoRPwiq46Q9ls/z2zmOtXpxmYpilq9LvqEMeJE+6yI1bqN//Pl4WBpD0vBm4K0dvyTmIfaDFe
	jO+JVzey7EJ8jV4xWz3A8dELqIGeKyrbJtGTJIVe5bFtu4W/u+pepOFP2ilFoF08KCGU=
X-Received: by 2002:a05:600c:3542:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-4909c0a7df8mr41205315e9.19.1780052000814;
        Fri, 29 May 2026 03:53:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3542:b0:48a:5c23:cab with SMTP id 5b1f17b1804b1-4909c0a7df8mr41204955e9.19.1780052000422;
        Fri, 29 May 2026 03:53:20 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909c0498e0sm16548075e9.0.2026.05.29.03.53.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 03:53:19 -0700 (PDT)
Message-ID: <a5c4c3c3-4c2e-4a04-9d38-8d9490e81404@redhat.com>
Date: Fri, 29 May 2026 12:53:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 net-next 0/6] net: hns3: enhance tc flow offload
 support
To: Jijie Shao <shaojijie@huawei.com>, Simon Horman <horms@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, shenjian15@huawei.com, liuyonglong@huawei.com,
 chenhao418@huawei.com, huangdonghua3@h-partners.com,
 yangshuaisong@h-partners.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260523105449.661848-1-shaojijie@huawei.com>
 <20260527095930.GI2256768@horms.kernel.org>
 <c6dc79ef-5f6e-4c97-97da-fa50eb1d1370@huawei.com>
 <b0b0ac82-bcbf-4aef-bf6f-7340f9517fc6@redhat.com>
 <83f34836-c848-469a-9c1c-7f28bf3035fc@huawei.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <83f34836-c848-469a-9c1c-7f28bf3035fc@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293089-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2DC14601324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 1:24 PM, Jijie Shao wrote:
> on 2026/5/28 17:06, Paolo Abeni wrote:
>> This one:
>>
>> ---
>>> +		if (is_zero_ether_addr(match.key->dst))
>>> +			rule->unused_tuple |= BIT(INNER_DST_MAC);
>>> +		if (is_zero_ether_addr(match.key->src))
>>> +			rule->unused_tuple |= BIT(INNER_SRC_MAC);
>> Should the "is this tuple unused" decision be driven by the mask
>> rather than the key?
>> A tc-flower rule that explicitly matches an all-zero address, for
>> example:
>>      tc filter add ... flower dst_mac 00:00:00:00:00:00 ...
>>      tc filter add ... flower src_ip 0.0.0.0 ...
>>      tc filter add ... flower src_ip :: ...
>> produces match.key->{src,dst} == 0 with match.mask->{src,dst} set to
>> all-ones. With the new checks above, those rules now have
>> INNER_{SRC,DST}_MAC / INNER_{SRC,DST}_IP added to rule->unused_tuple
>> even though the user asked to match exactly that address.
>> Downstream, hclge_fd_convert_tuple() short-circuits on unused_tuple:
>>      if (rule->unused_tuple & BIT(tuple_bit))
>>          return true;
>> so the tuple is not programmed into the TCAM key and the field is
>> effectively wildcarded in hardware, with no -EINVAL or extack returned
>> to the user.
>> Real-world patterns that rely on all-zero addresses include DHCPv4
>> DISCOVER (src 0.0.0.0), IPv6 DAD/NUD probes and DHCPv6 (src ::), and
>> deliberate matches on the all-zero MAC.
>> ---
>>
>> and similar later ones look real/relevant to me, and IMHO should be
>> addressed.
> 
> Yes, I saw this issue. There is similar logic in the existing function hclge_fd_check_ether_tuple():
> 
> static int hclge_fd_check_ether_tuple(struct ethhdr *spec, u32 *unused_tuple)
> {
> 	if (!spec || !unused_tuple)
> 		return -EINVAL;
> 
> 	*unused_tuple |= BIT(INNER_SRC_IP) | BIT(INNER_DST_IP) |
> 		BIT(INNER_SRC_PORT) | BIT(INNER_DST_PORT) |
> 		BIT(INNER_IP_TOS) | BIT(INNER_IP_PROTO);
> 
> 	if (is_zero_ether_addr(spec->h_source))
> 		*unused_tuple |= BIT(INNER_SRC_MAC);
> 
> 	if (is_zero_ether_addr(spec->h_dest))
> 		*unused_tuple |= BIT(INNER_DST_MAC);
> 
> 	if (!spec->h_proto)
> 		*unused_tuple |= BIT(INNER_ETH_TYPE);
> 
> 	return 0;
> }
> 
> This looks like a common problem for hns3. My original idea was to send 
> a separate bugfix later to fix all the all-zero MAC or IP addresses.>
The current tc flow implementation logic is consistent with ethtool -U.
> 
> Alternatively, I can first fix the tc flow issue in v4, and then submit
> a bugfix later to fix the potential issues in ethtool -U.

I think the latter option (v4 using `mask` and follow-up patch for
existing code) is the better one (to avoid introducing new code with a
known issues).

Thanks,

Paolo


