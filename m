Return-Path: <netdev+bounces-231094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A63BF4D3B
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 09:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 798EB348052
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 07:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0542727381E;
	Tue, 21 Oct 2025 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MytdQgZt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2842A25A623
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 07:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761030502; cv=none; b=G4CJN532L4CjoA4QlPYTq6R05KzFDjOmc4vRsU+y+oRM4PvDC0E4B5SOxsFXUPB1EsVlUoeJPb2Y5bCiqFkQxiKQDLGmyHAXsih0/fHvfLjyPaku8NVFSWnUMtdti4lvjCzh1ZfQ74seofoR6nttLk26APycEHzaeK+VdLvPluQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761030502; c=relaxed/simple;
	bh=lSdJkaQpaF2qhWbhmvpzzG0XYHlFdbfkXv6CiPaEUuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZJte7F/U24a3//WMJ6LRq/KSlgbkzsyVFidi8LMCa6DEXFDd6G9rkgx5VHAYiMJxjNNfmFd0tyW2FAJrnaZwURBzxiCZuyFdDL4BrxgXwk0TdI6O8KWRXJTceSnj7qcnKCNBJvkXa2DfIlNN7u0DPxmcA7+ceT/4fYG4A3UwUUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MytdQgZt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761030500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2xPTBI/BvJVBTH0bO2IDPCnHQ8CTKIOA4Ozbz62ndF0=;
	b=MytdQgZtQ71JFvwdaRfZA2mCPs9zyVRPg7guPnTD58ug3hyQ+MQDviCsyTXBSID9/bqLbF
	5je7/tbZP4rDTiX8CKh0uCIwGjW0OyGYdniWV7GQznuzs1syhcIEGzn/vrXdpiUiy8BAgn
	YEJfgNBfB0XC+tJLo1BQ6appF0K4pzc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-WGzm9y5cNe6_8QnP6zk9MA-1; Tue, 21 Oct 2025 03:08:18 -0400
X-MC-Unique: WGzm9y5cNe6_8QnP6zk9MA-1
X-Mimecast-MFC-AGG-ID: WGzm9y5cNe6_8QnP6zk9MA_1761030497
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47114d373d5so50929075e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 00:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761030497; x=1761635297;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2xPTBI/BvJVBTH0bO2IDPCnHQ8CTKIOA4Ozbz62ndF0=;
        b=GoGUnGzGsEudCzk7thGFgEPIxUyXkl8eqKu3MwcsRtUrQlYnbcO/ing7VRWNauUCYq
         FThp4o5pzGcPB3yHlD+11iAhBlmwg18FWd4pEp0V2jzLz3jhKvmWuoW7+SbLHrwTQN2Y
         qZ2x+Wnal0INHcdzFoL7J8trswwaLFTZgY/FdaS/V59S1AtWQT4RVLhpkvUXghwlTwO2
         cAnVCOLKvEBrhOSMoo+TKR0u8OYMi7FS6HCoPD/zJTQQ3/ppxIIklckqJVV7iYFrv18c
         xwyOFERDrgrJo0e3fquGuuZbpFL874pHRMZopD0LOLa3WrpwuTbCvsbdAoDCOyy14DWR
         tK6g==
X-Forwarded-Encrypted: i=1; AJvYcCXNgyFLjXvd7+tTklb3L5chhno7zfu82Tl7mPR3HY5cNWCI9nML1ybJOMwwl9KlYs2EfJikmqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1yru3LwW0XKoP0oC+8dFAmzZlzPH+saHWvTUlClkD1yCr5Rr8
	MWZLnAXps8N3bsk6BtRylqEABh2TMQ/8SKSGHZzvZOizfSn7d5MOtA2mRIjP8JxAh8Othb+2F/8
	9dxKs1BRCrxY8hRF4tvJVQQD2kG7S8soGiLIh/jjXShvHpa55a2i7uTG1cA==
X-Gm-Gg: ASbGncuJLLaM7BmBWun8c62E18qnHlHZGe6w65Pc196DCqkTHzU8qA0MOGiZuNS9P+K
	VhzmtuymhLgUIgrBc72kdNm1Mp9m3QVdQhDsSVUBZbYhtegq2Xz61HAaYqT0vQN2wjKvke+0XzU
	xaSngm+O1sqzHUX0NkBkkNwizK20ci63vvTXj1Dkzs/ghOMQ+1/u5hWkg7TF9kLTPfwpB5A9rIJ
	OQjJ3JeVsSLm5piGCYhUFizQswYFHXAplTDwf6n8o4/DPNyZ1MoYiaTBh7qTUIIbm65lVxKAUYn
	2W3NYNz8YUJbfDqXX6W4WLg87jP6+lgxUflHFYzZwNsXuV7JcaYP4S0eXzVTfzGOE3NhuUm6mKl
	yYqHiARe2ARp5yaF+ngjb853bZf+YBHbW+MPTCS+tHGKHciE=
X-Received: by 2002:a05:600c:190f:b0:470:feb2:e968 with SMTP id 5b1f17b1804b1-471178b125amr116158155e9.15.1761030497235;
        Tue, 21 Oct 2025 00:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfeULxx9QBgsLfU6ewhvNaSK+B9y0CapaXM5d5KIoN+VltTEytFeDsgfboyBJs8MoMlsxoKw==
X-Received: by 2002:a05:600c:190f:b0:470:feb2:e968 with SMTP id 5b1f17b1804b1-471178b125amr116157935e9.15.1761030496823;
        Tue, 21 Oct 2025 00:08:16 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-471144b5c34sm281292155e9.10.2025.10.21.00.08.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Oct 2025 00:08:16 -0700 (PDT)
Message-ID: <b0bc747b-82ee-4d7b-90f9-3ea299d1249c@redhat.com>
Date: Tue, 21 Oct 2025 09:08:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
To: Jonas Gorski <jonas.gorski@gmail.com>, Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?=
 <noltari@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251015070854.36281-1-jonas.gorski@gmail.com>
 <20251016102725.x5gqyehuyu44ejj3@skbuf>
 <CAOiHx=mNnMJTnAN35D6=LPYVTQB+oEmedwqrkA6VRLRVi13Kjw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CAOiHx=mNnMJTnAN35D6=LPYVTQB+oEmedwqrkA6VRLRVi13Kjw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/16/25 1:50 PM, Jonas Gorski wrote:
> On Thu, Oct 16, 2025 at 12:27 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>> On Wed, Oct 15, 2025 at 09:08:54AM +0200, Jonas Gorski wrote:
>>> The internal switch on BCM63XX SoCs will unconditionally add 802.1Q VLAN
>>> tags on egress to CPU when 802.1Q mode is enabled. We do this
>>> unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
>>> VLANs while not filtering").
>>>
>>> This is fine for VLAN aware bridges, but for standalone ports and vlan
>>> unaware bridges this means all packets are tagged with the default VID,
>>> which is 0.
>>>
>>> While the kernel will treat that like untagged, this can break userspace
>>> applications processing raw packets, expecting untagged traffic, like
>>> STP daemons.
>>>
>>> This also breaks several bridge tests, where the tcpdump output then
>>> does not match the expected output anymore.
>>>
>>> Since 0 isn't a valid VID, just strip out the VLAN tag if we encounter
>>> it, unless the priority field is set, since that would be a valid tag
>>> again.
>>>
>>> Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
>>> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
>>> ---
>>>  net/dsa/tag_brcm.c | 12 ++++++++++--
>>>  1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/dsa/tag_brcm.c b/net/dsa/tag_brcm.c
>>> index 26bb657ceac3..32879d1b908b 100644
>>> --- a/net/dsa/tag_brcm.c
>>> +++ b/net/dsa/tag_brcm.c
>>> @@ -224,12 +224,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
>>>  {
>>>       int len = BRCM_LEG_TAG_LEN;
>>>       int source_port;
>>> +     __be16 *proto;
>>>       u8 *brcm_tag;
>>>
>>>       if (unlikely(!pskb_may_pull(skb, BRCM_LEG_TAG_LEN + VLAN_HLEN)))
>>>               return NULL;
>>>
>>>       brcm_tag = dsa_etype_header_pos_rx(skb);
>>> +     proto = (__be16 *)(brcm_tag + BRCM_LEG_TAG_LEN);
>>>
>>>       source_port = brcm_tag[5] & BRCM_LEG_PORT_ID;
>>>
>>> @@ -237,8 +239,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
>>>       if (!skb->dev)
>>>               return NULL;
>>>
>>> -     /* VLAN tag is added by BCM63xx internal switch */
>>> -     if (netdev_uses_dsa(skb->dev))
>>> +     /* The internal switch in BCM63XX SoCs will add a 802.1Q VLAN tag on
>>> +      * egress to the CPU port for all packets, regardless of the untag bit
>>> +      * in the VLAN table.  VID 0 is used for untagged traffic on unbridged
>>> +      * ports and vlan unaware bridges. If we encounter a VID 0 tagged
>>> +      * packet, we know it is supposed to be untagged, so strip the VLAN
>>> +      * tag as well in that case.
>>> +      */
>>> +     if (proto[0] == htons(ETH_P_8021Q) && proto[1] == 0)
>>>               len += VLAN_HLEN;
>>>
>>>       /* Remove Broadcom tag and update checksum */
>>>
>>> base-commit: 7f0fddd817ba6daebea1445ae9fab4b6d2294fa8
>>> --
>>> 2.43.0
>>>
>>
>> Do I understand correctly the following:
>>
>> - b53_default_pvid() returns 0 for this switch
>> - dsa_software_untag_vlan_unaware_bridge() does not remove it, because,
>>   as the FIXME says, 0 is not the PVID of the VLAN-unaware bridge (and
>>   even if it were, the same problem exists for standalone ports and is
>>   not tackled by that logic)?
> 
> In general yes. And it happens to work for vlan aware bridges because
> br_get_pvid() returns 0 if a port has no PVID configured.
> 
> Also b53 doesn't set untag_bridge_pvid except in very weird edge
> cases, so dsa_software_untag_vlan_unaware_bridge() isn't even called
> ;-)
> 
>> I'm trying to gauge the responsibility split between taggers and
>> dsa_software_vlan_untag(). We could consider implementing the missing
>> bits in that function and letting the generic untagging logic do it.
> 
> If there are more devices that need this, it might make sense. Not
> sure if this has any negative performance impact compared to directly
> stripping it along the proprietary tag.

I think this patch makes sense for 'net' and reaching stable trees,
where most b53 users sits (I think/guess).

The DSA-core base solution could be a follow-up IMHO.

@Jonas, please still clarify a bit the comment, as per Simon's request.

Thanks,

Paolo

> 
> And to sidetrack the discussion a bit, I wonder if calling
> __vlan_hwaccel_clear_tag() in
> dsa_software_untag_vlan_(un)aware_bridge() without checking the
> vlan_tci field strips 802.1p information from packets that have it. I
> fail to find if this is already parsed and stored somewhere at a first
> glance.


