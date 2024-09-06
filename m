Return-Path: <netdev+bounces-125939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 451F396F547
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22E1285E95
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 13:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D81CDFBD;
	Fri,  6 Sep 2024 13:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gG8t3GBs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931091CB152
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725629045; cv=none; b=aTlMnUQmdHmtKWDfZeB0Kt7ddhB4otDroqYEOaoehbVWcXD50yMgn5B5S54VqU6R2nKQ+iyMC+OwZZnLY2/8DSEw1klohHCjjoVy1jy6N3C8hsrJwg5pBkAwkjdMznUkMJjbWCM5mTdcjeYN8m+uiGt8G9ndpma4WM7C99kbndQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725629045; c=relaxed/simple;
	bh=KEadjf/85sVWwg8JMxmO8e7nXoH7AUjAobqQ39LPRek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+qecL5RHPcENpy9AKoeZnsiVoKKGrZF5r/yXlZSO6N3VOmWl1VP/LQJONeXpF47oQkRkj11s0UaSNHx6gDS4HYfYGAJjQaNbuqJdQLT7nZ4grj3wqZz6YuaOJPiGJ48YSez06tTuf+/xgvbkj2Mqj1RYj8IfZN8qvXdsRsAMZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gG8t3GBs; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42ca573fd5aso3876535e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 06:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725629042; x=1726233842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=BtB5qVfKLbVk5DHaCiUlLQsZUu+rmK+p1/I0tha1Yes=;
        b=gG8t3GBs6XBCwGWD0zOPvnF2XWsbw7nWPMAOvPQJZd2oG/4wUP24ED1MEIbg/ZxoLt
         egQEo4dCftMTtZY7c/LOijGlotaOXfOYmk2WHq0jRk99qkuDQne9rb2ysYSdUWgIqYWZ
         7QozEeVtnMfaRgYSCNjE75p2Tww1kapmk1fr/YJz+JTNE2xHhkZmTfeVRtyZsYlY8qlv
         FgBW6dBk+95xkUwRJH/6/pVJsPH/V4Fl9e6VBwlVsdMy64N5K0w+kUInpakzDqXSaHt0
         VGb09K24Xyss8Ncpi5zn7lZeDQ14T84UOUulTbZL6e3rOHpDU8hDJBK3hbmlOibpB+/l
         21Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725629042; x=1726233842;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BtB5qVfKLbVk5DHaCiUlLQsZUu+rmK+p1/I0tha1Yes=;
        b=idp5FfK2/A8KLuBr0SkSGqvYnyCI6o402DJAl64w5oF24rbva3lxjoeGbcZe6+5BIu
         4XjDfK/IHXlGamYFKEsRwuV4Qis16Yjap1BlOAbiErNhSyLdwHvGzhDswm4RvfKIKP/7
         sQ5TTrEYshnFByOwzjES3p3toKwTQ7eRcnOVAuDelKfOa21L7xRWIQ47GEW8c7TYi8OM
         FudkK1H4ycb5gCinWXwNj9bMMu9gkZqHSlHJ/eYJKOTr+0CfyGJfTw1RLvApDTtNoWuP
         TicXk7507+H7IWFGRpH4A7bpI4I3uzfkoUZX0DbnEbLo98L+sLR8YDAlT/C4Ea1VZQIC
         8i6A==
X-Gm-Message-State: AOJu0YzINmb96NHGAMOWbwvcSt3S4xAHOdM455K3sXUgzEQDo6bSHuZE
	qXPKCBE6qqzTAd4WO7PwUSK+/GfKwifX0/hb6A/Sc48NSCUNth6RmTbo/Y9I3mg=
X-Google-Smtp-Source: AGHT+IEhOScASvLOmvRgc2UbGay/RUJAhd9jSF1vHdBBBZudyzUqWEoXFwZmj6xNsQ6mgsVIpac0mw==
X-Received: by 2002:a05:600c:6b01:b0:42c:a036:577a with SMTP id 5b1f17b1804b1-42ca036584dmr16412615e9.7.1725629041599;
        Fri, 06 Sep 2024 06:24:01 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9b0:9865:5539:6303? ([2001:67c:2fbc:1:9b0:9865:5539:6303])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05c2656sm20811035e9.7.2024.09.06.06.24.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 06:24:01 -0700 (PDT)
Message-ID: <7acf098f-777b-4785-9009-4388b47b0bd6@openvpn.net>
Date: Fri, 6 Sep 2024 15:26:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 15/25] ovpn: implement multi-peer support
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-16-antonio@openvpn.net> <Ztcf88I1epYlIYGS@hog>
 <ZtgyA744W7QkXXnX@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZtgyA744W7QkXXnX@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/09/2024 12:10, Sabrina Dubroca wrote:
> 2024-09-03, 16:40:51 +0200, Sabrina Dubroca wrote:
>> 2024-08-27, 14:07:55 +0200, Antonio Quartulli wrote:
>>> +static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
>>> +{
>>> +	struct sockaddr_storage sa = { 0 };
>>> +	struct hlist_nulls_head *nhead;
>>> +	struct sockaddr_in6 *sa6;
>>> +	struct sockaddr_in *sa4;
>>> +	struct hlist_head *head;
>>> +	struct ovpn_bind *bind;
>>> +	struct ovpn_peer *tmp;
>>> +	size_t salen;
>>> +
>>> +	spin_lock_bh(&ovpn->peers->lock_by_id);
>>> +	/* do not add duplicates */
>>> +	tmp = ovpn_peer_get_by_id(ovpn, peer->id);
>>> +	if (tmp) {
>>> +		ovpn_peer_put(tmp);
>>> +		spin_unlock_bh(&ovpn->peers->lock_by_id);
>>> +		return -EEXIST;
>>> +	}
>>> +
>>> +	hlist_add_head_rcu(&peer->hash_entry_id,
>>> +			   ovpn_get_hash_head(ovpn->peers->by_id, &peer->id,
>>> +					      sizeof(peer->id)));
>>> +	spin_unlock_bh(&ovpn->peers->lock_by_id);
>>> +
>>> +	bind = rcu_dereference_protected(peer->bind, true);
> 
> What protects us here? We just released lock_by_id and we're not
> holding peer->lock.

hmm. I think originally it was not possible to hold this peer in any 
other context since the peer was stil being added.
But now we have added it to the by_id table already, so we cannot assume 
that anymore.

Maybe I should simply move this assignment before the 
hlist_add_head_rcu() to regain that assumption..

> 
>>> +	/* peers connected via TCP have bind == NULL */
>>> +	if (bind) {
>>> +		switch (bind->remote.in4.sin_family) {
>>> +		case AF_INET:
>>> +			sa4 = (struct sockaddr_in *)&sa;
>>> +
>>> +			sa4->sin_family = AF_INET;
>>> +			sa4->sin_addr.s_addr = bind->remote.in4.sin_addr.s_addr;
>>> +			sa4->sin_port = bind->remote.in4.sin_port;
>>> +			salen = sizeof(*sa4);
>>> +			break;
>>> +		case AF_INET6:
>>> +			sa6 = (struct sockaddr_in6 *)&sa;
>>> +
>>> +			sa6->sin6_family = AF_INET6;
>>> +			sa6->sin6_addr = bind->remote.in6.sin6_addr;
>>> +			sa6->sin6_port = bind->remote.in6.sin6_port;
>>> +			salen = sizeof(*sa6);
>>> +			break;
>>> +		default:
>>
>> And remove from the by_id hashtable? Or is that handled somewhere that
>> I missed (I don't think ovpn_peer_unhash gets called in that case)?
> 
> ovpn_nl_set_peer_doit does:
> 
> 		ret = ovpn_peer_add(ovpn, peer);
> 		if (ret < 0) {
> [...]
> 		/* release right away because peer is not really used in any
> 		 * context
> 		 */
> 		ovpn_peer_release(peer);
> 		kfree(peer);
> 
> 
> But if we fail at this stage, the peer was published in the by_id
> hashtable and could be used.
> 
> Although AFAICT, ovpn can never create a bind with family !=
> AF_INET{,6}, so this is not a real issue -- in that case I guess a
> DEBUG_NET_WARN_ON_ONCE with a comment that this should never happen
> would be acceptable (but I'd still remove the peer from by_id and go
> through the proper release path instead of direct kfree in
> ovpn_nl_set_peer_doit). Otherwise, you'd have to reorder things in
> this function so that all failures are handled before the peer is
> added to any hashtable.

To be honest I don't mind adding a pre-check and error out immediately.
I don't like adding a peer to the table that is actually failing basic 
sanity checks.

Thanks!

> 
>>> +			return -EPROTONOSUPPORT;
>>> +		}
>>> +
> 

-- 
Antonio Quartulli
OpenVPN Inc.

