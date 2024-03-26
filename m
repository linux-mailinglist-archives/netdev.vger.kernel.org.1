Return-Path: <netdev+bounces-82270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AD888D04B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 22:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD20C1C32E22
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197F613D88A;
	Tue, 26 Mar 2024 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ISx7zH4u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5538173
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 21:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711489524; cv=none; b=QvT2zfY4W5Ke9FyutJvv0gcIvg2VFtwItXWpZDsiWYXTuTefUtp06aYIG2HjwzobxsVIcTw47G0jmmbwdp3WVZH7MayqB7zeGMH6+xh/fWWiQZdV8GLj9l9Q7JBkXvbs029v9dHISC0/FQPTAAG3vgKYn4pgWKc5XAXsV/LqcGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711489524; c=relaxed/simple;
	bh=+qGJb+BTj0PPLbgP+utwClewxIxav1jB1gGpqUrFN7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ol4e1hXnW+y43pOg3KHsA9POihOceZNhDENJZIXVgfCIZHxx4BOmi0daxvLmBGrkaxrjgD7sRYBMDpY6tc+KZlTYvUmH+0i5gnk2mqGtIe8a4uE16ViVjquC4+fc2sy2dqTDYpGh76gfk+0fQkcGHrS17ySqZi2E/iNI7iPHAgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ISx7zH4u; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41490d249e9so4700795e9.3
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 14:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1711489520; x=1712094320; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x26+t6Wu3TNmU6iUO6Oo0lX0aWesd01li/awVKYCU1k=;
        b=ISx7zH4utBFx12nMNN+y2yiDuGjQGClXnyZhji42V+sdNij6eBsqEzf+8SVZwgzlmw
         W2JuAqcWBWsbM6LefIkQ83Ie3ajgzyCOMuZ7X9nxQmyY7zRQ43YHtLoUTnAHplvdrDRr
         MMNzMqzMrmjK6g8I9+/MZkJzSVysR4wUjzI2VManuSXHsjVKts3wcsvY+ZVjy3xp342P
         wL1LKEy1cbV057ew0Xjx21WO5K4PSAIP+PcCg9U8/8MB8Tu+bjTtAgBrjow38RE+eC9h
         aEAvnHGW0fUo3gwaL55SS6E6XDYloZbQnPhyPqyvY3gy0hdzb0JYJXxjTZc8mavQTfSE
         3F3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711489520; x=1712094320;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x26+t6Wu3TNmU6iUO6Oo0lX0aWesd01li/awVKYCU1k=;
        b=SEnYlOc/Nj/MUhfj458WSKXZ4eGmr0+cIY/pV7MPovd54J5P8Hq9SledU2hywl3aok
         Sx3uyPbS0/Td5NfaIp7KDqBAlOQQi8HWxEbvGCD4DFtN84cwlj9bQESMT/TqGgtHdF2N
         FfQ1BeBQPZNLumnxyZcuFUnlVTFwUTmPjo67o4njJW82xdsG7jToIaLuQI0TXbi1EErS
         2/bVAkHOx2+tXDUc9e8GcHdxm8Vd7dxB6fmRliC3ru2HVcKGVbAlSaxclE/SJ3TrBVPU
         7Nm5rwUXgz72FxDaBa1Zo+FPzoDG9kk3+hI7K2sHOgNDBN7Khe8wavDD39529PBZ1EJy
         WGaw==
X-Gm-Message-State: AOJu0YxR5wPEhcDlFJaDEYcMilVEpNTsLcT0rntY4bRNDRU5I4Su3eZU
	mXdeIo7fZBMw2U+qAcLzZJWnCjU00gK9nX3ah+yWMZqdZHadOkGyVT6tID8izONMunp+ilQRQBh
	7
X-Google-Smtp-Source: AGHT+IG8R6PG4dd1DWEr8h/8UjntBZo7ULFJhOuKSv7293OTGqtCBYCDOAj32fSXUDAXeTOEdJfD+g==
X-Received: by 2002:a05:600c:358a:b0:414:8865:bfc0 with SMTP id p10-20020a05600c358a00b004148865bfc0mr6440793wmq.0.1711489520090;
        Tue, 26 Mar 2024 14:45:20 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:2da8:e89c:e33f:a4e3? ([2001:67c:2fbc:0:2da8:e89c:e33f:a4e3])
        by smtp.gmail.com with ESMTPSA id l20-20020a05600c1d1400b004146a304863sm146007wms.34.2024.03.26.14.45.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 14:45:19 -0700 (PDT)
Message-ID: <5d7f805e-8b09-44cf-8d6b-e9c0b17909e9@openvpn.net>
Date: Tue, 26 Mar 2024 22:45:59 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/22] ovpn: introduce the ovpn_peer object
Content-Language: en-US
To: Esben Haabendal <esben@geanix.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-7-antonio@openvpn.net> <871q7xe0xf.fsf@geanix.com>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <871q7xe0xf.fsf@geanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/03/2024 11:34, Esben Haabendal wrote:
> Antonio Quartulli <antonio@openvpn.net> writes:
> 
>> +static inline bool ovpn_bind_skb_src_match(const struct ovpn_bind *bind, struct sk_buff *skb)
>> +{
>> +	const unsigned short family = skb_protocol_to_family(skb);
>> +	const struct ovpn_sockaddr *sa = &bind->sa;
> 
> You should move this dereferencing of bind to after the following check
> to avoid segmentation fault.

ouch. good catch, thanks!

> 
>> +	if (unlikely(!bind))
>> +		return false;
> 
>> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
>> new file mode 100644
>> index 000000000000..4319271927a4
>> --- /dev/null
>> +++ b/drivers/net/ovpn/peer.c
>> +
>> +/* Use with kref_put calls, when releasing refcount
>> + * on ovpn_peer objects.  This method should only
>> + * be called from process context with config_mutex held.
>> + */
>> +void ovpn_peer_release_kref(struct kref *kref)
>> +{
>> +	struct ovpn_peer *peer = container_of(kref, struct ovpn_peer, refcount);
>> +
>> +	INIT_WORK(&peer->delete_work, ovpn_peer_delete_work);
> 
> Is this safe, or could we end up re-initializing delete_work while it is
> queued or running?

ovpn_peer_release_kref() is only invoked once upon peer refcounter 
reaching 0 (then the peer object is erased).
Therefore it should be safe to init the work object here.

Cheers,

> 
>> +	queue_work(peer->ovpn->events_wq, &peer->delete_work);
> 
> /Esben

-- 
Antonio Quartulli
OpenVPN Inc.

