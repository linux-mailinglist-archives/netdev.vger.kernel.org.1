Return-Path: <netdev+bounces-111881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06946933E22
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 16:02:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6961C2089F
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 14:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C2D1802A3;
	Wed, 17 Jul 2024 14:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="J+lc/XZO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F9417F51A
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 14:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721224950; cv=none; b=b6BeRcyfXKdvOJ2zf7QOV0sE3j7VYLf5zugotj/kVU/Zxqmv2X5kHIAxjfTsfXr6M79jurNxLaa4opa8mADn6FwNuvXQXv8Dg0utWUe0mzdff4U6CradLp5TpQa2U9aF35M020GRSn0IJR1r+9bNb8/PJYtQLagSPNFX9wpF8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721224950; c=relaxed/simple;
	bh=bLAsnGKiWm2cDthxjyAIkdfBky26OULMYeZsX4Z5zWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tc8mZRh6uta3wtOUpzsFcAbdsfcwmfg54WtN4WMts/d3G6Xm2sr/ORKFyQHyMSWankcWnQN9Aa5mXcfW/TAVSbGqCk26F36rLh6Fo2FX0M/vnKRlLAYCCotwpMZu2hno16GB7uxgFaRASzuXM5zKQ+H4tMhJo0WqPZ3YdSz4Ee0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=J+lc/XZO; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-59a47d5c22aso8082215a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 07:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721224946; x=1721829746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R1WNeWBRVVs61VlQOMkTnCyvhdLJ+p6Tr9qOVZWPKqc=;
        b=J+lc/XZO/sPZsjRhhdU+/ctFVv/wncwaCzBKxJiplk2+SJx4qPwTeA4DYz0Yppxhac
         F/3pNUaWOW2fU3f49qEMcGEVADGCRG015b0NMfaEejYqvPw9Rdh8B0+a0MwhD+5jDnrw
         sNZ94unyedas42LLFeKLVEWyfvbVIBABO3d5BGqy78uJvQtIPD9OWUKpPgiJRtx39HEg
         VMEVo7xN6Wp3ctFN0WdSsFepZosic3b0KWchf2bVU50gn8wkZ4swE6/VCbiVDNQu+pEX
         RWzkMSyQCApUocQmyO8Z+L8yb9uY3ej3gzhBwD+gesnx+WHBwk/jIIQmRkfOysDjdZzb
         WAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721224946; x=1721829746;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R1WNeWBRVVs61VlQOMkTnCyvhdLJ+p6Tr9qOVZWPKqc=;
        b=bQa7J/fwxKARA0AYSqqQKgwwX5AYPg24zmTpZU2oOgeKck3bWiYV0pllouZIIb6EsW
         pUtSnXMlOxYdIJ/+OwtnPdxjscE9+envGqEtQuS/x6Oqkv5ucuVhfnkgjRz4nW2odq8J
         8GsHS8tAfM4a6mkOkT/tA+tuiqU2zQStGVmt3fXwvB5T0lfwJsFNRUrLuLNZpq27m5zw
         gi7s+Ykmugwh+eNmXaYgfQ5E6jKJmWZD6x4E2yQD+Ry78I3PuhZ0ra1KTfZbwC/81kN7
         p/YbAF5YQGx04w5o5IynAKlrhMW+bn6fV2TvoELUmYtYdZjvyRybFvtAPG/NkL34qn1x
         ZBdA==
X-Gm-Message-State: AOJu0YxcNZ+9zESvy54DhJrWmN38xedoKMWB5k7zdjeZAQK4KlCzPond
	3WAYy4ciKqzuvKCatu97z+YAsVcMh8/OngeIDjCO/WsfQ5KmPIFrMU/zYlUfEXA=
X-Google-Smtp-Source: AGHT+IHpEAdJhmEOk3qNwktOEazSZ2QXR4VWt8lBa+Kx0N7bUCmXXOD5ZhOKn53ZBH9CieexViOiPg==
X-Received: by 2002:a17:907:d301:b0:a75:1069:5b8d with SMTP id a640c23a62f3a-a7a01353659mr156182466b.64.1721224946111;
        Wed, 17 Jul 2024 07:02:26 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:4c30:cffb:9097:30fc? ([2001:67c:2fbc:1:4c30:cffb:9097:30fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5b7f0bsm446529466b.74.2024.07.17.07.02.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:02:25 -0700 (PDT)
Message-ID: <3a6ce780-4532-4823-a326-d10e09688894@openvpn.net>
Date: Wed, 17 Jul 2024 16:04:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 20/25] ovpn: implement peer add/dump/delete
 via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-21-antonio@openvpn.net> <ZpZ4cF7hLTIxBiej@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZpZ4cF7hLTIxBiej@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 16/07/2024 15:41, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:38 +0200, Antonio Quartulli wrote:
>> @@ -29,7 +34,7 @@ MODULE_ALIAS_GENL_FAMILY(OVPN_FAMILY_NAME);
>>    * Return: the netdevice, if found, or an error otherwise
>>    */
>>   static struct net_device *
>> -ovpn_get_dev_from_attrs(struct net *net, struct genl_info *info)
>> +ovpn_get_dev_from_attrs(struct net *net, const struct genl_info *info)
> 
> nit: this should be squashed into "add basic netlink support"

Right, thanks

> 
> 
> [...]
>>   int ovpn_nl_set_peer_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> -	return -EOPNOTSUPP;
>> +	bool keepalive_set = false, new_peer = false;
>> +	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
>> +	struct ovpn_struct *ovpn = info->user_ptr[0];
>> +	struct sockaddr_storage *ss = NULL;
>> +	u32 sockfd, id, interv, timeout;
>> +	struct socket *sock = NULL;
>> +	struct sockaddr_in mapped;
>> +	struct sockaddr_in6 *in6;
>> +	struct ovpn_peer *peer;
>> +	u8 *local_ip = NULL;
>> +	size_t sa_len;
>> +	int ret;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, OVPN_A_PEER))
>> +		return -EINVAL;
>> +
>> +	ret = nla_parse_nested(attrs, OVPN_A_PEER_MAX, info->attrs[OVPN_A_PEER],
>> +			       ovpn_peer_nl_policy, info->extack);
>> +	if (ret)
>> +		return ret;
>> +
>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
>> +			      OVPN_A_PEER_ID))
>> +		return -EINVAL;
>> +
>> +	id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
>> +	/* check if the peer exists first, otherwise create a new one */
>> +	peer = ovpn_peer_get_by_id(ovpn, id);
>> +	if (!peer) {
>> +		peer = ovpn_peer_new(ovpn, id);
>> +		new_peer = true;
>> +		if (IS_ERR(peer)) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "cannot create new peer object for peer %u (sockaddr=%pIScp): %ld",
>> +					       id, ss, PTR_ERR(peer));
> 
> ss hasn't been set yet at this point, including it in the extack
> message is not useful.

argh. you are correct. I'll remove it.

> 
>> +			return PTR_ERR(peer);
>> +		}
>> +	}
>> +
>> +	if (new_peer && NL_REQ_ATTR_CHECK(info->extack,
>> +					  info->attrs[OVPN_A_PEER], attrs,
>> +					  OVPN_A_PEER_SOCKET)) {
> 
> This can be checked at the start of the previous block (!peer), we'd
> avoid a pointless peer allocation.

Right - will move it up.

> 
> (and the linebreaks in NL_REQ_ATTR_CHECK end up being slightly better
> because you don't need the "new_peer &&" test that is wider than the
> tab used to indent the !peer block :))

good point! :-D

> 
>> +		ret = -EINVAL;
>> +		goto peer_release;
>> +	}
>> +
>> +	if (new_peer && ovpn->mode == OVPN_MODE_MP &&
>> +	    !attrs[OVPN_A_PEER_VPN_IPV4] && !attrs[OVPN_A_PEER_VPN_IPV6]) {
> 
> Same for this check.

ACK

> 
>> +		NL_SET_ERR_MSG_MOD(info->extack,
>> +				   "a VPN IP is required when adding a peer in MP mode");
>> +		ret = -EINVAL;
>> +		goto peer_release;
>> +	}
>> +
>> +	if (attrs[OVPN_A_PEER_SOCKET]) {
>> +		/* lookup the fd in the kernel table and extract the socket
>> +		 * object
>> +		 */
>> +		sockfd = nla_get_u32(attrs[OVPN_A_PEER_SOCKET]);
>> +		/* sockfd_lookup() increases sock's refcounter */
>> +		sock = sockfd_lookup(sockfd, &ret);
>> +		if (!sock) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "cannot lookup peer socket (fd=%u): %d",
>> +					       sockfd, ret);
>> +			ret = -ENOTSOCK;
>> +			goto peer_release;
>> +		}
>> +
>> +		if (peer->sock)
>> +			ovpn_socket_put(peer->sock);
>> +
>> +		peer->sock = ovpn_socket_new(sock, peer);
>> +		if (IS_ERR(peer->sock)) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "cannot encapsulate socket: %ld",
>> +					       PTR_ERR(peer->sock));
>> +			sockfd_put(sock);
>> +			peer->sock = NULL;
> 
> Is there any value for the client in keeping the old peer->sock
> assigned if we fail here?
> 
> ie something like:
> 
>      tmp = ovpn_socket_new(sock, peer);
>      if (IS_ERR(tmp)) {
>          ...
>          goto peer_release;
>      }
>      if (peer->sock)
>          ovpn_socket_put(peer->sock);
>      peer->sock = tmp;
> 
> 
> But if it's just going to get rid of the old socket and the whole
> association/peer on failure, probably not.

Right. if attaching the new socket fails, we are entering some broken 
status which is not worth keeping around.

> 
>> +			ret = -ENOTSOCK;
>> +			goto peer_release;
>> +		}
>> +	}
>> +
>> +	/* Only when using UDP as transport protocol the remote endpoint
>> +	 * can be configured so that ovpn knows where to send packets
>> +	 * to.
>> +	 *
>> +	 * In case of TCP, the socket is connected to the peer and ovpn
>> +	 * will just send bytes over it, without the need to specify a
>> +	 * destination.
> 
> (that should also work with UDP "connected" sockets)

True, but those are not used in openvpn. In case of UDP, userspace just 
creates one socket and uses it for all peers.
I will add a note about 'connected UDP socket' in the comment, to clear 
this out.

> 
> 
>> +	 */
>> +	if (peer->sock->sock->sk->sk_protocol == IPPROTO_UDP &&
>> +	    attrs[OVPN_A_PEER_SOCKADDR_REMOTE]) {
> [...]
>> +
>> +		if (attrs[OVPN_A_PEER_LOCAL_IP]) {
>> +			local_ip = ovpn_nl_attr_local_ip(info, ovpn,
>> +							 attrs,
>> +							 ss->ss_family);
>> +			if (IS_ERR(local_ip)) {
>> +				ret = PTR_ERR(local_ip);
>> +				NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +						       "cannot retrieve local IP: %d",
>> +						       ret);
> 
> ovpn_nl_attr_local_ip already sets a more specific extack message,
> this is unnecessary.

right.

> 
>> +				goto peer_release;
>> +			}
>> +		}
>> +
>> +		/* set peer sockaddr */
>> +		ret = ovpn_peer_reset_sockaddr(peer, ss, local_ip);
>> +		if (ret < 0) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "cannot set peer sockaddr: %d",
>> +					       ret);
>> +			goto peer_release;
>> +		}
>> +	}
> 
> I would reject OVPN_A_PEER_SOCKADDR_REMOTE for a non-UDP socket.

judging from the comments below, it seems you prefer to reject unneeded 
attributes. OTOH I took the opposite approach (just ignore those).

However, I was actually looking for some preference/indication regarding 
this point and I now I got one :-)

I will be strict and return -EINVAL when unneded attributes are present.

> 
> 
>> +	/* VPN IPs cannot be updated, because they are hashed */
> 
> Then I think there should be something like
> 
>      if (!new_peer && (attrs[OVPN_A_PEER_VPN_IPV4] || attrs[OVPN_A_PEER_VPN_IPV6])) {
>          NL_SET_ERR_MSG_FMT_MOD(... "can't update ip");
>          ret = -EINVAL;
>          goto peer_release;
>      }
> 
> (just after getting the peer, before any changes have actually been
> made)

ACK

> 
> And if they are only used in MP mode, I would maybe also reject
> requests where mode==P2P and OVPN_A_PEER_VPN_IPV* is provided.

yup, like I commented above.

> 
> 
>> +	if (new_peer && attrs[OVPN_A_PEER_VPN_IPV4])
>> +		peer->vpn_addrs.ipv4.s_addr =
>> +			nla_get_in_addr(attrs[OVPN_A_PEER_VPN_IPV4]);
>> +
>> +	/* VPN IPs cannot be updated, because they are hashed */
>> +	if (new_peer && attrs[OVPN_A_PEER_VPN_IPV6])
>> +		peer->vpn_addrs.ipv6 =
>> +			nla_get_in6_addr(attrs[OVPN_A_PEER_VPN_IPV6]);
>> +
>> +	/* when setting the keepalive, both parameters have to be configured */
> 
> Then I would also reject a config where only one is set (also before any
> changes have been made).

ok

> 
>> +	if (attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL] &&
>> +	    attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]) {
>> +		keepalive_set = true;
>> +		interv = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_INTERVAL]);
>> +		timeout = nla_get_u32(attrs[OVPN_A_PEER_KEEPALIVE_TIMEOUT]);
>> +	}
>> +
>> +	if (keepalive_set)
>> +		ovpn_peer_keepalive_set(peer, interv, timeout);
> 
> Why not skip the bool and just do this in the previous block?

I am pretty sure there was a reason...but it may have faded away after 
the 95-th rebase hehe. Thanks for spotting this!

> 
>> +	netdev_dbg(ovpn->dev,
>> +		   "%s: %s peer with endpoint=%pIScp/%s id=%u VPN-IPv4=%pI4 VPN-IPv6=%pI6c\n",
>> +		   __func__, (new_peer ? "adding" : "modifying"), ss,
>> +		   peer->sock->sock->sk->sk_prot_creator->name, peer->id,
>> +		   &peer->vpn_addrs.ipv4.s_addr, &peer->vpn_addrs.ipv6);
>> +
>> +	if (new_peer) {
>> +		ret = ovpn_peer_add(ovpn, peer);
>> +		if (ret < 0) {
>> +			NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +					       "cannot add new peer (id=%u) to hashtable: %d\n",
>> +					       peer->id, ret);
>> +			goto peer_release;
>> +		}
>> +	} else {
>> +		ovpn_peer_put(peer);
>> +	}
>> +
>> +	return 0;
>> +
>> +peer_release:
>> +	if (new_peer) {
>> +		/* release right away because peer is not really used in any
>> +		 * context
>> +		 */
>> +		ovpn_peer_release(peer);
>> +		kfree(peer);
> 
> I don't think that's correct, the new peer was created with
> ovpn_peer_new, so it took a reference on the netdevice
> (netdev_hold(ovpn->dev, ...)), which isn't released by
> ovpn_peer_release. Why not just go through ovpn_peer_put?

Because then we would send the notification to userspace, but it is not 
correct to do so, because the new() is just about to return an error.

I presume I should just move netdev_put(peer->ovpn->dev, NULL); to 
ovpn_peer_release(). That will take care of this case too.

> 
>> +	} else {
>> +		ovpn_peer_put(peer);
>> +	}
>> +
>> +	return ret;
>> +}
>> +
> 
> [...]
>>   int ovpn_nl_get_peer_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
> [...]
>> +	peer_id = nla_get_u32(attrs[OVPN_A_PEER_ID]);
>> +	peer = ovpn_peer_get_by_id(ovpn, peer_id);
>> +	if (!peer) {
>> +		NL_SET_ERR_MSG_FMT_MOD(info->extack,
>> +				       "cannot find peer with id %u", peer_id);
>> +		return -ENOENT;
>> +	}
>> +
>> +	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> +	if (!msg)
> 
> Missing ovpn_peer_put?

indeed. have to set ret and goto err;

> 
>> +		return -ENOMEM;
>> +
>> +	ret = ovpn_nl_send_peer(msg, info, peer, info->snd_portid,
>> +				info->snd_seq, 0);
>> +	if (ret < 0) {
>> +		nlmsg_free(msg);
>> +		goto err;
>> +	}
>> +
>> +	ret = genlmsg_reply(msg, info);
>> +err:
>> +	ovpn_peer_put(peer);
>> +	return ret;
>>   }
> 


Thanks!

-- 
Antonio Quartulli
OpenVPN Inc.

