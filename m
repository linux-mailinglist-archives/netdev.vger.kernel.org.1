Return-Path: <netdev+bounces-246315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E028CCE93EB
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 10:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D655E3011EF9
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 09:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D9C2C1594;
	Tue, 30 Dec 2025 09:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b="Yx0T07BY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8A1273D6D
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 09:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767087800; cv=none; b=Lq8QhVKxVcauzwKISSYD8y82D9HuE/ciyqQtbTLEq2JwRMNsommpiSpuURKDBQ95CyFOpbaBV2+CPirCWpq/q4UadzzCl3W26mwDB/ZyZvUPrGSzN22ssFfNpFFgo21vMKjhmmedzKfKRLmBq28HTiF5ico/BM2AvkZFnCtGJfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767087800; c=relaxed/simple;
	bh=iE6KV/7UHGp41soTgYVw3e1OL80Hieyf4n1TNLf1WjA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DIXI5N2HWNoFM+ON07irqDhPjf69xOWNqXxMDQTOgaOtBkmLFd3HQdDq0CXJ319ajy0kZ8tFgTaob3KW+nCxjFmcgAqow+tlCLmpmnnckFSzhdjUsmIiv654xdx55uiDJ7L+aRqmLl0H8/aT58vg8u55DwpkdwDLUiebgWzu7UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.b=Yx0T07BY; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fbc3056afso5269316f8f.2
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 01:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1767087797; x=1767692597; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZI12bs0nfawvolFv3Qb93ZqyLQZt1RM+Ems0PNmAxgw=;
        b=Yx0T07BYPCcFhDBKYke/NAaTvDdgUA+lFZ/6WggO02N39st7cpIz9sOeGiAQEEjBPZ
         DkxqvJPik2FKQ76LUyF0kHOw+RdNgcFzF8gXFE4ccNgiOA1xcEDEZKeqIJeflH+7lkYa
         vYie0HPgxMLoiNBAIHJhu5agdUbIFsGjn2oKmVOL4JXmJQkDNVEd8HRXGHVmXWLPONX4
         iO1b9uuSS6faMhUDX1rHqNQ4GnFmFwKWZ4EM/IB3xv6ymrmC4Agc7dQ+kjOo2RiUqLfr
         e+nzeh5tTDqRZo5IpAK+/lEP3ECwdwUoYpEjjRRzfaFMcxwCjUtQ8WKww7KHUALtindR
         0rPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767087797; x=1767692597;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZI12bs0nfawvolFv3Qb93ZqyLQZt1RM+Ems0PNmAxgw=;
        b=QvxZEcQe0uAan1pPX72Vi1jJP+7QB5KKBqamulccvJ9zMByHW2HE3DrjMsje5AvW4a
         tCUEiHaYQeYKz+FMuN0veLsnvbBGkTXQEgvJ6tkHQa0wgF2j1MKV3sqoyP5A7v/Zx7y6
         lGWhQ6EQ8gZIQrwRig7goSdOYbgOrlzZnBbcIb8egHdsCHaQAYdUXEL77MKxvBHwk4wF
         2V1AAh7VznYmwQSCLJfqWrmTY0syIjNS0R5SQsNr+rbde/XcqkxDnHK8VA+VzIhNvfQQ
         Fd/eZWrJ4dhPMiEmonYVYcLY5DLVJXsr91apr3c3kD0PsN5KdQACcbFGl1ULcnv6fE+c
         DLHA==
X-Forwarded-Encrypted: i=1; AJvYcCWyNYWb5R0ztHIuAQKB8ueH6pIVUgriS1zGP2Ubfd8CBllUr11bb7DNsTp4dnP7ZPMOPjt3qk4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhUH51/k0oQxfgEvS24W4KMnm/7hi2135zsl5UPgf1fqdKnQTZ
	Ju3sQfwVMp2mqN0XMhJ5VfByDcABDUrA/gx+M0ql7O83XHBMpWbLncC5p9Kw1oQrDYwL63c7V4P
	nxn0PGtM=
X-Gm-Gg: AY/fxX6oo3EoHMSUSLpVuNqu/zWzsAxhAte01qii0ac+ybo3VmXGg8e6T1NoneUOhaZ
	YsXViT3NMVg2sEppLq+MykiZ1bFKxOZBp/Eca4B33SivJ3cy6qCS/k2o+R27OVsPANUYGTAAQ1L
	/SQJ01JbBcHPQ1qKi9UVZm2o3uKHBGF12Tw9MVXxVmW5ydCrSFiIJtIvhOoea16Oek/UbDVusNJ
	lbTAzoY4JXRXnjjfcsXsca3vN411rDPfu6wcTTu6yh/X6YysckvBnAPFFktr+CPa4Cgn4wYDKRD
	1tLrPg+QtNTyeFE//tE4zstoMgly+R+q3LzwuQb2TYeO4JJkjX6SbWCleYZj5vmQ7sUz/x8rCHX
	E8ZGrK3crO17pq9ZyTdIiEgPkBfbb2VGW7sf+K3fFOsfR7FPrFoFWEPuD5T39CClgt0pAm7qQq7
	x1bgwM7mN6zS8zDQRVZ1FzJGlGTQo3jGDhpvHYlnI/YA==
X-Google-Smtp-Source: AGHT+IH+oKW1kxJutJxOKBjSITpQG+izJaO+2kKRoWTWKVcGbjKSJw8OJGb916fH2IBsCpd5yAJqrQ==
X-Received: by 2002:a05:6000:2281:b0:432:86e1:bd35 with SMTP id ffacd0b85a97d-43286e1be62mr13373132f8f.31.1767087796592;
        Tue, 30 Dec 2025 01:43:16 -0800 (PST)
Received: from [192.168.0.161] (78-154-15-142.ip.btc-net.bg. [78.154.15.142])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eab33f5sm67809180f8f.41.2025.12.30.01.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Dec 2025 01:43:16 -0800 (PST)
Message-ID: <d9558681-3113-4993-81a1-ff22873908cf@blackwall.org>
Date: Tue, 30 Dec 2025 11:43:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] bridge: fix C-VLAN preservation in 802.1ad
 vlan_tunnel egress
From: Nikolay Aleksandrov <razor@blackwall.org>
To: Alexandre Knecht <knecht.alexandre@gmail.com>, netdev@vger.kernel.org
Cc: roopa@nvidia.com, Ido Schimmel <idosch@nvidia.com>
References: <20251228020057.2788865-1-knecht.alexandre@gmail.com>
 <7cde982c-a9c1-4b9e-8d73-458ebede9bcc@blackwall.org>
Content-Language: en-US
In-Reply-To: <7cde982c-a9c1-4b9e-8d73-458ebede9bcc@blackwall.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 30/12/2025 11:38, Nikolay Aleksandrov wrote:
> On 28/12/2025 04:00, Alexandre Knecht wrote:
>> When using an 802.1ad bridge with vlan_tunnel, the C-VLAN tag is
>> incorrectly stripped from frames during egress processing.
>>
>> br_handle_egress_vlan_tunnel() uses skb_vlan_pop() to remove the S-VLAN
>> from hwaccel before VXLAN encapsulation. However, skb_vlan_pop() also
>> moves any "next" VLAN from the payload into hwaccel:
>>
>>      /* move next vlan tag to hw accel tag */
>>      __skb_vlan_pop(skb, &vlan_tci);
>>      __vlan_hwaccel_put_tag(skb, vlan_proto, vlan_tci);
>>
>> For QinQ frames where the C-VLAN sits in the payload, this moves it to
>> hwaccel where it gets lost during VXLAN encapsulation.
>>
>> Fix by calling __vlan_hwaccel_clear_tag() directly, which clears only
>> the hwaccel S-VLAN and leaves the payload untouched.
>>
>> This path is only taken when vlan_tunnel is enabled and tunnel_info
>> is configured, so 802.1Q bridges are unaffected.
>>
>> Tested with 802.1ad bridge + VXLAN vlan_tunnel, verified C-VLAN
>> preserved in VXLAN payload via tcpdump.
>>
>> Fixes: 11538d039ac6 ("bridge: vlan dst_metadata hooks in ingress and 
>> egress paths")
>> Signed-off-by: Alexandre Knecht <knecht.alexandre@gmail.com>
>> ---
>>   net/bridge/br_vlan_tunnel.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/net/bridge/br_vlan_tunnel.c b/net/bridge/br_vlan_tunnel.c
>> index 12de0d1df0bc..a1b62507e521 100644
>> --- a/net/bridge/br_vlan_tunnel.c
>> +++ b/net/bridge/br_vlan_tunnel.c
>> @@ -189,7 +189,6 @@ int br_handle_egress_vlan_tunnel(struct sk_buff *skb,
>>       IP_TUNNEL_DECLARE_FLAGS(flags) = { };
>>       struct metadata_dst *tunnel_dst;
>>       __be64 tunnel_id;
>> -    int err;
>>
>>       if (!vlan)
>>           return 0;
>> @@ -199,9 +198,13 @@ int br_handle_egress_vlan_tunnel(struct sk_buff 
>> *skb,
>>           return 0;
>>
>>       skb_dst_drop(skb);
>> -    err = skb_vlan_pop(skb);
>> -    if (err)
>> -        return err;
>> +    /* For 802.1ad (QinQ), skb_vlan_pop() incorrectly moves the C-VLAN
>> +     * from payload to hwaccel after clearing S-VLAN. We only need to
>> +     * clear the hwaccel S-VLAN; the C-VLAN must stay in payload for
>> +     * correct VXLAN encapsulation. This is also correct for 802.1Q
>> +     * where no C-VLAN exists in payload.
>> +     */
>> +    __vlan_hwaccel_clear_tag(skb);
>>
>>       if (BR_INPUT_SKB_CB(skb)->backup_nhid) {
>>           __set_bit(IP_TUNNEL_KEY_BIT, flags);
>> -- 
>> 2.43.0
>>
> 
> Nice catch. As Ido said, please use get_maintainer.pl next time.
> The change looks good to me as well. Thanks!
> 
> Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> 
> 

haha and I missed to add Ido to the reply..
need more coffee this morning :)
Sorry about that!

+ Ido

Cheers,
  Nik


