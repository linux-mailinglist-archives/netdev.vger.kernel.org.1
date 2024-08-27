Return-Path: <netdev+bounces-122176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3827B9603DF
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 10:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF59C2831C6
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 08:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65232197552;
	Tue, 27 Aug 2024 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WSGKO7lo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E12193088
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 08:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724745789; cv=none; b=ROhmGSVulfO8f5HbB/2Y0b/W0DVBVX938oqYFnGTCmhGE4lVejp9dBW4Wf1v3xS2EiYkaBPtJD/mauumJbVyh+hDh2wFtoKbmUPymUVnK7kz+b+9FganRLnlVJvHezTrOqKQfvzWFy0SM+WYDqbY+p+vMlTi7Krnvbnt2usAsp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724745789; c=relaxed/simple;
	bh=dnoHKm2yvxPH3VTkgPHnEhhPPekUB87k1C9//rmT6Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mtt0SYkQqlTaFD7pNyzPKnyGzozwXz6bjqyAjcoOTKUEt7q1/ZE6pfDYI3/4XA+CGfk54u9R83ixh3tRhJpmA26PfgJDLrTLOxmEhCOL/eoc1+V2QgRZJsBSKiYRFofB4UXL3/YfQ7b02txfbfVfuwudDIMwGV3hf9hI4v/ljcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WSGKO7lo; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-202089e57d8so33003665ad.0
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 01:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724745786; x=1725350586; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STq2SksYEpeE5OUyyw6K3VOvxFlLjRrHwh+2IswLxOg=;
        b=WSGKO7loWDL1iJpVlAaNTr75V7Ghhm1S+6eJGP9RVUtqg1U0ygzvq7lXrzhsGGKG8d
         uYJBGBn+9uI5QFXVyWy/8RO5SFSca6ctHfvFHnqh1gtHwvUfrA9dqgq+pUcKwp8+nqpD
         4sRrK7HwlcDBfqQpZ1Tx22AW7pRGedNCLfrsazQ2w/Dd0+8GvDZBTwIsQySQ7f4jKzIo
         ku1qxydULGm4U6MnnpsPttRXhcRuB67XM8G2ZXPk8aRiWFE8hx3HdN9RKXpl81A8WjUI
         +bfThRSPxG27PKjemVifCISmmpxZTZEQiG+pRA4kCm7le3th048kqhUYdwc0M7cAmL9X
         tZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724745786; x=1725350586;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=STq2SksYEpeE5OUyyw6K3VOvxFlLjRrHwh+2IswLxOg=;
        b=ik9Bi3fN+24CUIbJqFZRQcPuvkrgBjTiwGScED6UeSAEAG9K93ZkRl8UUSh4MyPjWb
         BKMxXO7SLKNOT+/t3rArKtqCA8zQ7ubKa0qrKWAyp20166fLmQS+zgxIv5iRRt6MuLq4
         z0AxnTFvC+/8BuZIMlx/7vrDQxHMSY9/oyG4p2920MbOuFYYnWw50m2nEPhVY4pvMp/J
         nAmDJ6qQXcNVatJj8yyyZ2qVsfSN1HXgIpQphAqlDftzGZGliEd+DIPDX/oaVTrIHjYV
         RgCkZXLxa08Gx7R1NxrJ0v08Zzlsod34S2YliVpbO8zzBMPip+6T20vhysswU3p8QP9W
         Tofg==
X-Forwarded-Encrypted: i=1; AJvYcCXMtZgAWINSiYDLeQutybhSfpVMFhCr0r+zYY0t5ABLtAwhbyELKkU8PLlVFzWeuXNYVZUx6jg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpnO1KQKXVKtsDMr90nqkRknF4aSbUIBEGVjWLwaPf2Xj4X09o
	Tls4c2xigch1YnRlnc1+ujiwF18xc0HpPvXSCmFo+nLS6FHoKsqgnyv5IQAtAgM=
X-Google-Smtp-Source: AGHT+IFragTajUnyMQOrCKm363S7w2u729C+2OQ5oQm9xpWjQFoR7pFUfYmaEOZUaiOLr9UG0AFueg==
X-Received: by 2002:a17:903:1104:b0:1f9:d6bf:a67c with SMTP id d9443c01a7336-204ddcba2eamr40232545ad.5.1724745785897;
        Tue, 27 Aug 2024 01:03:05 -0700 (PDT)
Received: from [10.68.121.74] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385567907sm78912905ad.12.2024.08.27.01.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Aug 2024 01:03:05 -0700 (PDT)
Message-ID: <c63f8752-527a-4960-a58c-87b6685ac074@bytedance.com>
Date: Tue, 27 Aug 2024 16:02:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH bpf-next v2] net: Don't allow to attach xdp
 if bond slave device's upper already has a program
To: Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ast@kernel.org, hawk@kernel.org,
 john.fastabend@gmail.com, bigeasy@linutronix.de, lorenzo@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
References: <20240823084204.67812-1-zhoufeng.zf@bytedance.com>
 <Zsh4vPAPBKdRUq8H@nanopsycho.orion>
 <6d38eaf5-0a13-9f85-3a5d-0ca354bc45d5@iogearbox.net>
 <ZsiOxkd5KbbIIB6k@nanopsycho.orion>
From: Feng Zhou <zhoufeng.zf@bytedance.com>
In-Reply-To: <ZsiOxkd5KbbIIB6k@nanopsycho.orion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

在 2024/8/23 21:29, Jiri Pirko 写道:
> Fri, Aug 23, 2024 at 02:07:45PM CEST, daniel@iogearbox.net wrote:
>> On 8/23/24 1:55 PM, Jiri Pirko wrote:
>>> Fri, Aug 23, 2024 at 10:42:04AM CEST, zhoufeng.zf@bytedance.com wrote:
>>>> From: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>>
>>>> Cannot attach when an upper device already has a program, This
>>>> restriction is only for bond's slave devices or team port, and
>>>> should not be accidentally injured for devices like eth0 and vxlan0.
>>>
>>> What if I attach xdp program to solo netdev and then I enslave it
>>> to bond/team netdev that already has xdp program attached?
>>> What prevents me from doing that?
>>
>> In that case the enslaving of the device to bond(/team) must fail as
>> otherwise the latter won't be able to propagate the XDP prog downwards.
> 
> Yep, I don't see that in the code though.
> 
> 

Thanks for your suggestion, I will complete it.

>>
>> Feng, did you double check if we have net or BPF selftest coverage for
>> that? If not might be good to add.
>>
>>>> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
>>>> Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
>>>> ---
>>>> Changelog:
>>>> v1->v2: Addressed comments from Paolo Abeni, Jiri Pirko
>>>> - Use "netif_is_lag_port" relace of "netif_is_bond_slave"
>>>> Details in here:
>>>> https://lore.kernel.org/netdev/3bf84d23-a561-47ae-84a4-e99488fc762b@bytedance.com/T/
>>>>
>>>> net/core/dev.c | 10 ++++++----
>>>> 1 file changed, 6 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/net/core/dev.c b/net/core/dev.c
>>>> index f66e61407883..49144e62172e 100644
>>>> --- a/net/core/dev.c
>>>> +++ b/net/core/dev.c
>>>> @@ -9502,10 +9502,12 @@ static int dev_xdp_attach(struct net_device *dev, struct netlink_ext_ack *extack
>>>> 	}
>>>>
>>>> 	/* don't allow if an upper device already has a program */
>>>> -	netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>>>> -		if (dev_xdp_prog_count(upper) > 0) {
>>>> -			NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>>>> -			return -EEXIST;
>>>> +	if (netif_is_lag_port(dev)) {
>>>> +		netdev_for_each_upper_dev_rcu(dev, upper, iter) {
>>>> +			if (dev_xdp_prog_count(upper) > 0) {
>>>> +				NL_SET_ERR_MSG(extack, "Cannot attach when an upper device already has a program");
>>>> +				return -EEXIST;
>>>> +			}
>>>> 		}
>>>> 	}
>>>>
>>>> -- 
>>>> 2.30.2
>>>>
>>>
>>


