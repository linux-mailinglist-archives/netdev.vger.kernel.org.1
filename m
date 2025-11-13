Return-Path: <netdev+bounces-238381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E30D8C5804E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 15:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C2463AE867
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 14:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683062C21D4;
	Thu, 13 Nov 2025 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SRzAFso0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="c8KpH4BD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83DC29B8E0
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763044784; cv=none; b=p1P/YrhxUSZw0H9cRnIVqLnW+LQBcgOOdpAdDmHR5F+YlCr1yinXqmlln+QaEUD0J7ecg7BpHab6128+Rc5U2KiRc2VL4tDC4w/Z2oMbJXZ0EGJb4+zl4Roam7KZcxb42Y1r/OKV23aS8qUbTpd2yXWgH55L3xzpkdJsqRtDRMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763044784; c=relaxed/simple;
	bh=WZlXUh05gtlAY7ujomAKuF63JeA7BJis07HZSFeJXuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YR7Z7e/qCcNPFUIP2HP9ltZ7TgGNBtYuSVMWLy8UaTK7+6KChK5HH+mqxbxIsyIqjjzpv5iEM9L9KQCcCstZ1WqIo0P/Imhk6+XJIc0Mo66oVZ5lw8dWxUYSv2s6LtL9cgWP/aZU+OvRyc7yChUAnoPOqaW5WDgXsHM4c3mvrbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SRzAFso0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=c8KpH4BD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763044780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C6ZlE/8wFoMWAmPveb7rTnuh4QFvGSZOBJ0lkY75WHA=;
	b=SRzAFso0iznnitrCamVClU22g2/R8Z+KUoJ5VWefviUDPXb26pn51mYc3oYpC1UagfEy8w
	50vHkjmtfhCHzJzbrcvVXXfb/wgBQ4pPXyaMkg0G6SEuFgjWfBu5Z9zDSmZf7yHuD2QeBP
	zGqlr92FlR1q8bfhz6U8gAuqq0GW2EY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-443-bfnNUj_9O2erBz5HBFmufA-1; Thu, 13 Nov 2025 09:39:39 -0500
X-MC-Unique: bfnNUj_9O2erBz5HBFmufA-1
X-Mimecast-MFC-AGG-ID: bfnNUj_9O2erBz5HBFmufA_1763044778
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-40cfb98eddbso956206f8f.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 06:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763044778; x=1763649578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C6ZlE/8wFoMWAmPveb7rTnuh4QFvGSZOBJ0lkY75WHA=;
        b=c8KpH4BDQAzXj5yndotz6K96d36bDlywY87h0nqY5QMDRgFs5GAAAX/T5fp3feof2m
         vkDWwEj2McYRXshkMgIgrF6DqeG7zD2XA05iT3stqcAXwW6WCRYM+0kAPYtn92HvvAYh
         vLkgdE51I4CHzaCeCE1nEWA4jGpWObCVsKNqEDAEJjH4M+2r/cwboTG+UV/kTMfRaqP6
         vBJprNV2pkb6ifPQgK6R5PwUsdKiSeuB4e7tJEEmqLDbiplnkWAjQUkeLeY/2h5z5WGn
         u8O2UGmA2HNoUUA/nkHxqq3qdGrF1+oeb4PBKBLwsVfwMiyUDcRJIjNpsj1n6AP8ufub
         NGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763044778; x=1763649578;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C6ZlE/8wFoMWAmPveb7rTnuh4QFvGSZOBJ0lkY75WHA=;
        b=JGjlkVUqA3vJ/2gFOF1o6DQc32XNageLjs8cnr6BhDtfaVBd7X+acyW8y+xG7DJMF1
         1Ze1azd/EZ/QcV8oqmuOFwJllzbp+wSEd94L+giNZyUXha5oXbD1aLlkF/eV949m5n4H
         K08Gm7FIAjnbqpDOUE+7mMafSAwCqnk7SC9RdtXymEaWfOvkPTEjxVEt0NXj3n6juY8N
         gItbKY+djBm5DPxbDJZWqtXFuV8e6wRuxJYNsGIHonwh1NWrjuTs0nZ07P/7K2OCuS3C
         HmbKFDOGo6QHW8wKwlEMNBCqlBEE5eUiMgcEFFlysqfIfV++1EsPOfoRxL11VG0OYvNg
         6tWA==
X-Forwarded-Encrypted: i=1; AJvYcCXTalOoNYyGdWel4TGCMWdy+YUBvnKn4rtVOEGTvnD26BvLPIaAHx9pT5TmWBmFqcYR/llz170=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4oobmq9xw6saNLfHnbo/rpIcf4cnIlpEyEc+Kf/u35jTFFKpl
	6+oqGkllA96SpCO/b5UBg/9PeFC+kv0NMcsO17fvdiJDCWyXFu3Uvlp4mW9rerfFKfp1J49l9ZL
	ZW7sDjvnhyawcXpSGv4uqbyPxPtotneK5iUJi9SOBB72TqblItVsFSSbLQA==
X-Gm-Gg: ASbGncuHnT8Aj8rIyyiXt1eb0Uvadbj8lNR2iws+S2lVZi7tnxmrvnwBjb7MdKJA6lS
	4na8zAtk4sAog0iPvmYL1zyKdVAuIm0W8VcNPyXP5b35Vow3d3SaMVrJPs+/9C/vnPtC/re/U8N
	FidYPnIsfXRuSC9OLwrust11ekGGBAnwlYN/Kh9sf3UKIIvUe0wDvGIi57GAr4ANW34xi8y2K5L
	SWWEJCPPtr1lmab69QMqnsNc2I+nup3ZwnE53nU1kOSsih+BEbVeBafv09t8LSd6eXQ3hyEkQXB
	vo3pegbHmSHS8chwpTvMUXtHfkeyd0bsjHBL6mq09ARwrowbJmj1uBHoqcH2rrwgpfHIhBYCpek
	KGPCFc1pBom8y
X-Received: by 2002:a05:6000:2911:b0:429:cc35:7032 with SMTP id ffacd0b85a97d-42b52821778mr3447024f8f.23.1763044778211;
        Thu, 13 Nov 2025 06:39:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGec5SZJzkrdZIMQyF+gi07hDcBuVbPd+9nb9X5ZfZ31kZtvs0xZMBq40lgAX06ufK4If5sPw==
X-Received: by 2002:a05:6000:2911:b0:429:cc35:7032 with SMTP id ffacd0b85a97d-42b52821778mr3446995f8f.23.1763044777793;
        Thu, 13 Nov 2025 06:39:37 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f29c5fsm4196462f8f.46.2025.11.13.06.39.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 06:39:37 -0800 (PST)
Message-ID: <25b05194-63cd-4265-8d2c-e174d801fc3a@redhat.com>
Date: Thu, 13 Nov 2025 15:39:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5 1/2] virtio-net: correct hdr_len handling for
 VIRTIO_NET_F_GUEST_HDRLEN
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>, linux-um@lists.infradead.org,
 virtualization@lists.linux.dev
References: <20251111111212.102083-1-xuanzhuo@linux.alibaba.com>
 <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251111111212.102083-2-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/11/25 12:12 PM, Xuan Zhuo wrote:
> The commit be50da3e9d4a ("net: virtio_net: implement exact header length
> guest feature") introduces support for the VIRTIO_NET_F_GUEST_HDRLEN
> feature in virtio-net.
> 
> This feature requires virtio-net to set hdr_len to the actual header
> length of the packet when transmitting, the number of
> bytes from the start of the packet to the beginning of the
> transport-layer payload.
> 
> However, in practice, hdr_len was being set using skb_headlen(skb),
> which is clearly incorrect. This commit fixes that issue.
> 
> Fixes: be50da3e9d4a ("net: virtio_net: implement exact header length guest feature")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

IMHO this looks like more a new feature - namely,
VIRTIO_NET_F_GUEST_HDRLEN support - than a fix.

[...]
> @@ -2361,7 +2362,7 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	if (vnet_hdr_sz &&
>  	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
>  				    sizeof(struct virtio_net_hdr),
> -				    vio_le(), true, 0)) {
> +				    vio_le(), true, false, 0)) {
>  		if (po->tp_version == TPACKET_V3)
>  			prb_clear_blk_fill_status(&po->rx_ring);
>  		goto drop_n_account;
To reduce the diffstat, what about creating a __virtio_net_hdr_from_skb()
variant (please find a better name) allowing the extra `hdrlen_negotiated`
argument, define virtio_net_hdr_from_skb() as a wrapper of such helper
withthe extra arg == false, and use the helper in the few places that
really could use hdrlen?


