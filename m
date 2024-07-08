Return-Path: <netdev+bounces-110040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C6192ABBB
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 00:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3071F2151D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 22:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CCA14F117;
	Mon,  8 Jul 2024 22:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BXDc5XC1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E572A29
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 22:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720476465; cv=none; b=JQM4SeqWIrxFfF+6BnNapudIVQcIg81jUOPShfsJoEZQvH3QBB+PAX6RJNM2vaCZ/1/YSSl+amkbounmpcr4wQcTg7jTmJKPVRqpU8VbZkoxAntavj25VFLwIH2YVIuDatBy5QWKMcngu5EEwtswxpMvC7wEd2S7S+3fuTl+pDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720476465; c=relaxed/simple;
	bh=bbjFVL+87eIJXhNOO/1ZuvrmOIEo91eejE/t2O+HwzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2IDA1BGaj+B+J8pZZaJAxnALzdNFUaI+kxfVvTrXSAupK1gyuZRyrDStXhJOKGD8k22pYe/ILq/g1MOKJV39fGX3QUdV4WzvwkMmDdqJ3hPbzGgkmC+DOkeenrVJ85vHdqHukxa04Nu/nuFSjSJxMHnj/iK4QqXISU1nVoJ/K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BXDc5XC1; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ea929ea56so5134378e87.0
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 15:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1720476461; x=1721081261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3d2CN5hhOeCC2Iq32vXEPszLnZZlqHyY+unA+bXp10M=;
        b=BXDc5XC1n4XxIx9yFec9PayMixF2w3u6EJgV9dKvtFvEeEXD24X52NTLdo9CPXOj+f
         0WyH0Hxa+xobLI9gA83i+q3VP+ZqkxSELE9C5UU/Lqle4tURp5eL741oGEfEIz1c3Pki
         laDnYNYNOamn/GyEg8pILP9Hd6o5iBT8Gz0V7Z6wt17lXEJonYqBNLv8m8iMIm7APJD9
         d0Qo7yUpMnQFp1EjxjC4Rc9vO3CTkQhrYUUAr0kbFjqvo0yjgBKEofVzLBo2hnXxcYwY
         c6/GM2hSmoGyusEP2p7RPETwheoPKTa6GoIOT459fDy6v3JbqHTM4ZQaKRtO+ytlcfNH
         h+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720476461; x=1721081261;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3d2CN5hhOeCC2Iq32vXEPszLnZZlqHyY+unA+bXp10M=;
        b=NI6JiqU5NVuRMkmOZdnP3DXohgy3qdIM7O4eRNDLgQ+DoUTv6oE2XwwWnjhUvjfvEn
         TPu98rJ6BC62y78GDApD4T56RW6g4JVrnqEqk5qJdytQNWncncesQ+RWVIV09YL01/ag
         O4OOHarAOuQtAqsqfZRZxveB/U+zu79f8lZJL1NXyaFP1zaLy3fqHSmi5Y6WXrkTeIzY
         bZoCtSvzBnwmMuriDvtrPdVGYR2cIzIjc2FM5uKoCAsvchx6y3ZCtcnuQiL7pPcxs7lH
         ChaMSxv1DptQRYeKMquVk6jLtiggfYaXOuxOsgCme97DNr65rnkP6yIjF+cGrhERSUI2
         05Mg==
X-Gm-Message-State: AOJu0YxYC7Dc9Q6WpXtRh6kiZATI83tz5qTCBvAc5hNoFVdaLicwQZW/
	kEkCEH7l9domdhIVvLSkCBViDQcPcEWsNFwQcoHOY21yfkndLc9PTSrcp0idv/k=
X-Google-Smtp-Source: AGHT+IHV6eLZXwLbqqIgQisodhgQwWXJGGv7Uwtcxt5AKInVo46kWtXyZqDKO+B5AQx+xmX6vd6gmQ==
X-Received: by 2002:a05:6512:2245:b0:52c:c9e4:3291 with SMTP id 2adb3069b0e04-52eb99d653amr473069e87.60.1720476461517;
        Mon, 08 Jul 2024 15:07:41 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:4ac0:9854:18a5:18f3? ([2001:67c:2fbc:0:4ac0:9854:18a5:18f3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc8cesm26683066b.26.2024.07.08.15.07.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 15:07:41 -0700 (PDT)
Message-ID: <937bd3bf-e6c6-4b10-905f-932d66c7a602@openvpn.net>
Date: Tue, 9 Jul 2024 00:09:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 11/25] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-12-antonio@openvpn.net> <ZowPltmxMLBaJa3K@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZowPltmxMLBaJa3K@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 08/07/2024 18:11, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:29 +0200, Antonio Quartulli wrote:
>> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
> [...]
>> +	/* cause packet to be "received" by the interface */
>> +	if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
>> +				     skb) == NET_RX_SUCCESS))
>> +		/* update RX stats with the size of decrypted packet */
>> +		dev_sw_netstats_rx_add(peer->ovpn->dev, skb->len);
>> +	else
>> +		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
> 
> Not needed AFAICT, gro_cells_receive already does
> dev_core_stats_rx_dropped_inc(skb->dev) when it drops the packet.

You're right! This should be removed.

> 
>> +}
>> +
>> +static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>> +{
>> +	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
>> +
>> +	if (unlikely(ret < 0))
>> +		goto drop;
>> +
>> +	ovpn_netdev_write(peer, skb);
>> +	/* skb is passed to upper layer - don't free it */
>> +	skb = NULL;
>> +drop:
> 
> I really find this "common" return code confusing. The only thing the
> two cases have in common is dropping the peer reference.

I believe it's just a matter of perspective: I read it as "exit path" 
and if something went wrong I just do some extra actions.

However, I am perfectly fine splitting success/failure paths if the 
common code is little like in this case.

Thanks!

> 
>> +	if (unlikely(skb))
>> +		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
>> +	kfree_skb(skb);
>> +	ovpn_peer_put(peer);
>> +}
> 

-- 
Antonio Quartulli
OpenVPN Inc.

