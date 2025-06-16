Return-Path: <netdev+bounces-198019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A211CADAD31
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89043B3314
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26615279355;
	Mon, 16 Jun 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dZezKrKJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFEC27EFE3
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 10:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750069071; cv=none; b=qui0cYYjlYHp96baZI7ahFAbqeXZFA76MZ1F4lkUmdnfMtkaqrbXPGuIE3c+0xIBI09gQgLKKnem5f03tgtcxygdDJ63D5ElaSKmSAdy08fy13PuZcRGcFuDUB5fctamY91MrrJiH5oRJ71QkkE6meFn035AzymPpFTLH70++Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750069071; c=relaxed/simple;
	bh=0b/6S5wLlrlmRtrtpHR7r/0y6kh1F4r7ZeBrAKzXm6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T47MGLmvPgSLRAe9uvfMbCeQLbgGBVQdHb0b5wtnRl7pas5Cn0J3waYfyQoe+LxkinjzujjioAr5M0YzZ+frf7Snijqjx3YzEDng5w+dgTrh1Iz3hb7McnETzqRvB2L0OY2qsr4vD/qMEShqyR7plBy/kWOHVFBagFc3TLDgS4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dZezKrKJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750069067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EWzwRrno3LKIaIVMyLoLNIYksHkAFGMua1kcSSkdYw=;
	b=dZezKrKJUE8zoQeApjdcuSSAuyF2s0l6Z35/TtiGFCJEt8yQfnlQppYzLPHpd3h/Xsj1Cu
	Z+Xg0ZzBWolYm0S2k3v9GbwJ5NIhUzUlbmdXJF+V0kcW7eQc3c2LrJauqir2VsDd9x+oJ2
	EVdZKMgnhnBH2+z5nNkVQjf5TqFWv3Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175-OnRmr0QlNbyAca2OEeiO3g-1; Mon, 16 Jun 2025 06:17:46 -0400
X-MC-Unique: OnRmr0QlNbyAca2OEeiO3g-1
X-Mimecast-MFC-AGG-ID: OnRmr0QlNbyAca2OEeiO3g_1750069066
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso1536544f8f.2
        for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 03:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750069065; x=1750673865;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3EWzwRrno3LKIaIVMyLoLNIYksHkAFGMua1kcSSkdYw=;
        b=bRz4n+9RrtbRJ5vvErls01Os+gGKJs9fBN5mSDFbZ4yK1GjlHHe5hVF943K/leQ9MN
         2RZI8y/+/EsrmtrO5JFQXDTSd87RlZHTNv+yQARJ/lL+2WIgGTFfWiaMwUFEB2ZSh3Rw
         gUdDY11fAy98o1bu0E6jeUyCuM01+Mf2Q/ygAuSpyKJtQMcfkCqrj0OpRza2xrFT3PRa
         q3O7tLftiwHRc0SAqgFpCS8YEXq4S8eLLQcIrxSxy2etHAKa/Y8DHStg+72zphsMg2HX
         QFzhiu951o8qt5myQeHEPoKjN3ncB2S8WTmZKRaInaOw1C7mXqguNihKYyFTJU2CvG2t
         OyhA==
X-Gm-Message-State: AOJu0YyFR4HaLDpNBalSFoOZ/NHj9qkZsmise464B7nSkW4T/OMdVPhK
	FoCHB9Hx0tNLWnaKZwrEi/na8cw5uU5VSWuI0AXMUAXCK4ua01VFTcJtn2sae94quovNfvpmqsq
	VTgKKQK6siIaaK4oe1gt9JBdYtNFI+UDfMkuRPeB+Dks//OxkYD5RjCEfJQ==
X-Gm-Gg: ASbGncuDVQWSWujN9RDuk3BPmCfXI2v7v8zXRL3gWN0tVAyWwnwBFx/TRj+R8ZgoLIm
	D255Ix+PNygvAsPkIH/xXYbLYFldeRwlQIHVmdbnGt832TUlQCKM753TVfyu+47MkqnXWYPAaQM
	xLYRwlKRP1X2ETkGLjxmLPfJB6rzoqZIHbm5yT0nmdy9vBhIwA+c3VgqTMmS9w3OR3bNq0a7wrU
	sicVTiSc+Am0Za+6uGfrwVLcDvZ7FkXON3juVtXkPnjmMjc5wZVXoK/dJ814l+lyoh/TxONsd3c
	Lt4XfI9RzMscdkK/4gfXXmnsFYXgSw==
X-Received: by 2002:a5d:64ca:0:b0:3a3:6a9a:5ebf with SMTP id ffacd0b85a97d-3a5723a352dmr8080251f8f.20.1750069065283;
        Mon, 16 Jun 2025 03:17:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPzMGnwhNdNZuInW9L+ojqLcCLL0Nd1nr7vWsaVeQ3BO4Qf5T9G6JLsDeKJbL1sKISCIRqgw==
X-Received: by 2002:a5d:64ca:0:b0:3a3:6a9a:5ebf with SMTP id ffacd0b85a97d-3a5723a352dmr8080221f8f.20.1750069064745;
        Mon, 16 Jun 2025 03:17:44 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2448:cb10::f39? ([2a0d:3344:2448:cb10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b4e4f1sm10446822f8f.87.2025.06.16.03.17.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 03:17:44 -0700 (PDT)
Message-ID: <1f0933e0-ab58-41b8-832b-5336618be8b3@redhat.com>
Date: Mon, 16 Jun 2025 12:17:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 7/8] tun: enable gso over UDP tunnel support.
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <a38c6a4618962237dde1c4077120a3a9d231e2c0.1749210083.git.pabeni@redhat.com>
 <CACGkMEtExmmfmtd0+6YwgjuiWR-T5RvfcnHEbmH=ewqNXHPHYA@mail.gmail.com>
 <b7099b02-f0d4-492c-a15b-2a93a097d3f5@redhat.com>
 <CACGkMEsuRSOY3xe9=9ONMM3ZBGdyz=5cbTZ0sUp38cYrgtE07w@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEsuRSOY3xe9=9ONMM3ZBGdyz=5cbTZ0sUp38cYrgtE07w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/16/25 6:53 AM, Jason Wang wrote:
> On Thu, Jun 12, 2025 at 7:03 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 6/12/25 6:55 AM, Jason Wang wrote:
>>> On Fri, Jun 6, 2025 at 7:46 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>> @@ -1720,8 +1732,16 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>>>>
>>>>         if (tun->flags & IFF_VNET_HDR) {
>>>>                 int vnet_hdr_sz = READ_ONCE(tun->vnet_hdr_sz);
>>>> +               int parsed_size;
>>>>
>>>> -               hdr_len = tun_vnet_hdr_get(vnet_hdr_sz, tun->flags, from, &gso);
>>>> +               if (vnet_hdr_sz < TUN_VNET_TNL_SIZE) {
>>>
>>> I still don't understand why we need to duplicate netdev features in
>>> flags, and it seems to introduce unnecessary complexities. Can we
>>> simply check dev->features instead?
>>>
>>> I think I've asked before, for example, we don't duplicate gso and
>>> csum for non tunnel packets.
>>
>> My fear was that if
>> - the guest negotiated VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO
>> - tun stores the negotiated offload info netdev->features
>> - the tun netdev UDP tunnel feature is disabled via ethtool
>>
>> tun may end-up sending to the guest packets without filling the tnl hdr,
>> which should be safe, as the driver should not use such info as no GSO
>> over UDP packets will go through, but is technically against the
>> specification.
> 
> Probably not? For example this is the way tun works with non tunnel GSO as well.
> 
> (And it allows the flexibility of debugging etc).
> 
>>
>> The current implementation always zero the whole virtio net hdr space,
>> so there is no such an issue.
>>
>> Still the additional complexity is ~5 lines and makes all the needed
>> information available on a single int, which is quite nice performance
>> wise. Do you have strong feeling against it?
> 
> See above and at least we can disallow the changing of UDP tunnel GSO
> (but I don't see too much value).

I'm sorry, but I don't understand what is the suggestion/request here.
Could you please phrase it?

Also please allow me to re-state my main point. The current
implementation adds a very limited amount of code in the control path,
and makes the data path simpler and faster - requiring no new argument
to the tun_hdr_* helper instead of (at least) one as the other alternative.

It looks like tun_hdr_* argument list could grow with every new feature,
but I think we should try to avoid that.

>>>> @@ -2426,7 +2460,16 @@ static int tun_xdp_one(struct tun_struct *tun,
>>>>         if (metasize > 0)
>>>>                 skb_metadata_set(skb, metasize);
>>>>
>>>> -       if (tun_vnet_hdr_to_skb(tun->flags, skb, gso)) {
>>>> +       /* Assume tun offloads are enabled if the provided hdr is large
>>>> +        * enough.
>>>> +        */
>>>> +       if (READ_ONCE(tun->vnet_hdr_sz) >= TUN_VNET_TNL_SIZE &&
>>>> +           xdp->data - xdp->data_hard_start >= TUN_VNET_TNL_SIZE)
>>>> +               flags = tun->flags | TUN_VNET_TNL_MASK;
>>>> +       else
>>>> +               flags = tun->flags & ~TUN_VNET_TNL_MASK;
>>>
>>> I'm not sure I get the point that we need dynamics of
>>> TUN_VNET_TNL_MASK here. We know if tunnel gso and its csum or enabled
>>> or not,
>>
>> How does tun know about VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO or
>> VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO_CSUM?
> 
> I think it can be done in a way that works for non-tunnel gso.
> 
> The most complicated case is probably the case HOST_UDP_TUNNEL_X is
> enabled but GUEST_UDP_TUNNEL_X is not. In this case tun can know this
> by:
> 
> 1) vnet_hdr_len is large enough
> 2) UDP tunnel GSO is not enabled in netdev->features
> 
> If HOST_UDP_TUNNEL_X is not enabled by GUEST_UDP_TUNNEL_X is enabled,
> it can behave like existing non-tunnel GSO: still accept the UDP GSO
> tunnel packet.

AFAICS the text above matches/describes quite accurately the
implementation proposed in this patch and quoted above. Which in turn
confuses me, because I don't see what you would prefer to see
implemented differently.

>> The user-space does not tell the tun device about any of the host
>> offload features. Plain/baremetal GSO information are always available
>> in the basic virtio net header, so there is no size check, but the
>> overall behavior is similar - tun assumes the features have been
>> negotiated if the relevant bits are present in the header.
> 
> I'm not sure I understand here, there's no bit in the virtio net
> header that tells us if the packet contains the tunnel gso field. And
> the check of:
> 
> READ_ONCE(tun->vnet_hdr_sz) >= TUN_VNET_TNL_SIZE
> 
> seems to be not buggy. As qemu already did:
> 
> static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
>                                        int version_1, int hash_report)
> {
>     int i;
>     NetClientState *nc;
> 
>     n->mergeable_rx_bufs = mergeable_rx_bufs;
> 
>     if (version_1) {
>         n->guest_hdr_len = hash_report ?
>             sizeof(struct virtio_net_hdr_v1_hash) :
>             sizeof(struct virtio_net_hdr_mrg_rxbuf);
>         n->rss_data.populate_hash = !!hash_report;
> 
> ...

Note that the qemu code quoted above does not include tunnel handling.

TUN_VNET_TNL_SIZE (== sizeof(struct virtio_net_hdr_v1_tunnel)) will be
too small when VIRTIO_NET_F_HASH_REPORT is enabled, too.

I did not handle that case here, due to the even greater overlapping with:

https://lore.kernel.org/netdev/20250530-rss-v12-0-95d8b348de91@daynix.com/

What I intended to do is:
- set another bit in `flags` according to the negotiated
VIRTIO_NET_F_HASH_REPORT value
- use such info in tun_vnet_parse_size() to computed the expected vnet
hdr len correctly.
- replace TUN_VNET_TNL_SIZE usage in tun.c with tun_vnet_parse_size() calls

I'm unsure if the above answer your question/doubt.

Anyhow I now see that keeping the UDP GSO related fields offset constant
regardless of VIRTIO_NET_F_HASH_REPORT would remove some ambiguity from
the relevant control path.

I think/hope we are still on time to update the specification clarifying
that, but I'm hesitant to take that path due to the additional
(hopefully small) overhead for the data path - and process overhead TBH.

On the flip (positive) side such action will decouple more this series
from the HASH_REPORT support.

Please advice, thanks!

/P


