Return-Path: <netdev+bounces-124198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9390B968764
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B609D1C21B1A
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2615D19E971;
	Mon,  2 Sep 2024 12:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gbvi8wtk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D7219E974
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 12:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279727; cv=none; b=QYLp4R28cXvJz0Ua6VmJfTR7FPzKrfQKZXRHWsBv0jL5hNw3b/UndOuI6Ah5vT46MY0E9WY8rxo+xzmrxYdHB+oSksb6NEz4JVYLu99iBXhcZDCepQISUJQvhsAcG+c1gkKMSuv0Ggmkbv5CvtKwAifI+ZysxcK2R7MHlEa0WEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279727; c=relaxed/simple;
	bh=v4y34GTYudnVxLxFNuHWaCCHazoe5dYtgDkzNjy9Gqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z6DyW5yswWZOgxCqZ1os2zPRunrbm2ohO3XJeUqB9XZAOKQqlkCPPicXy8WU/iMz72v5nTbAPNCPNJEPxhhJkOrXmL8cRiMLzC2QwsAnAQhrHDZJB9PNtDutbdLXDRVSxaIzxu30eRe3SQwQkcHnKHPEjymLiSxH2gIEqU7qD8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gbvi8wtk; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8695cc91c8so416022566b.3
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 05:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725279723; x=1725884523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=r+xKZrYeqbvAjnGQX1fXfmE1V7qz4Pav6TZSEPmwMz0=;
        b=gbvi8wtk4viysbFVs7R5lbqMVwE1651xaeXv4d85tiB1yTitGfH/LVE18Gf3wFYz0z
         NjwbEN1xhXc5O2T326O3+lOGakxJ+KbVF6kx/mvYWLkBo56/mZ+4vNoUzfze/HFsjo+J
         zEZgfKDVpid1VwwsKeywz4zBafuu353tvPQCZEK+DpJ5yj2BgtVmg5q2aG8n5Thzrgux
         Xk+u1M05FqqMXmomKQrl2NBAaMece0a+qJK9OhWr1RKs7Nfrtf/L1iAIAbkSvcqpQUCv
         CKhNKUqMJxqdJnzSTjyoIb7FW0W5+0/ajxmIWm5JHjChc7is4j5fYTH3UwfoACmAQ6pu
         RPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725279723; x=1725884523;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+xKZrYeqbvAjnGQX1fXfmE1V7qz4Pav6TZSEPmwMz0=;
        b=ldKEnlO+IbAtQ7XeBpj/67TRhJBFdsUpbEJTIKEp032pJv7mMCENYtnPSqIv1WIdOH
         4Bk2NpdKG6g9Pj9N9+NswLu+S/WcwGwa5nFEVE32ozVUdFFhLrZQqTzfEXgKzIjgRZnv
         0y0eUVb/txlm/T/6bQ7zvL9IM827UmfKR3/B4Jc9fki28viGY8IITGgSyuxmzTZriA+b
         pR7nixSmpuAHeY4hD74ZcT+jhOa+w0LswAawKl9HnEpFwxjIGjIgSpS6yC1PhnarDomM
         0trKginjkyf3phd/cCmH2pMyVhjz6jlTBGXlKgwTHNYQPRZxzJ8z4bgGkmeite7+Y/MR
         VtfA==
X-Gm-Message-State: AOJu0YzokbrCs4Edpxi8WJP3+yNfL0WenO57N5idVefh1dcxVl9hBdRV
	n6ZjBqMTxHhuPwdAVwJczlZ6q5eDhupydFqyazGHXqfb8xYfV5jG6ZIDJRx/d0M=
X-Google-Smtp-Source: AGHT+IF4rzbEZsrN9WbeQin8E3k8jd2zjgbjaBQh9yL7ogregMyVlZMjcYgRqytn5U0bEyY6KSWcjw==
X-Received: by 2002:a17:907:724b:b0:a86:fa3d:e984 with SMTP id a640c23a62f3a-a897f84d457mr1024424666b.20.1725279722699;
        Mon, 02 Sep 2024 05:22:02 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8ddb:ca93:fc13:4f49? ([2001:67c:2fbc:1:8ddb:ca93:fc13:4f49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a898908eaa1sm555079166b.94.2024.09.02.05.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 05:22:02 -0700 (PDT)
Message-ID: <55196133-50dd-4c7d-915b-844dcff296b8@openvpn.net>
Date: Mon, 2 Sep 2024 14:24:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 11/25] ovpn: implement basic RX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-12-antonio@openvpn.net> <ZtWgCv2bH0fCarwq@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZtWgCv2bH0fCarwq@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/09/2024 13:22, Sabrina Dubroca wrote:
> 2024-08-27, 14:07:51 +0200, Antonio Quartulli wrote:
>> +static void ovpn_netdev_write(struct ovpn_peer *peer, struct sk_buff *skb)
>> +{
>> +	/* we can't guarantee the packet wasn't corrupted before entering the
>> +	 * VPN, therefore we give other layers a chance to check that
>> +	 */
>> +	skb->ip_summed = CHECKSUM_NONE;
>> +
>> +	/* skb hash for transport packet no longer valid after decapsulation */
>> +	skb_clear_hash(skb);
>> +
>> +	/* post-decrypt scrub -- prepare to inject encapsulated packet onto the
>> +	 * interface, based on __skb_tunnel_rx() in dst.h
>> +	 */
>> +	skb->dev = peer->ovpn->dev;
>> +	skb_set_queue_mapping(skb, 0);
>> +	skb_scrub_packet(skb, true);
>> +
>> +	skb_reset_network_header(skb);
>> +	skb_reset_transport_header(skb);
>> +	skb_probe_transport_header(skb);
>> +	skb_reset_inner_headers(skb);
>> +
>> +	memset(skb->cb, 0, sizeof(skb->cb));
>> +
>> +	/* cause packet to be "received" by the interface */
>> +	if (likely(gro_cells_receive(&peer->ovpn->gro_cells,
>> +				     skb) == NET_RX_SUCCESS))
>> +		/* update RX stats with the size of decrypted packet */
>> +		dev_sw_netstats_rx_add(peer->ovpn->dev, skb->len);
> 
> I don't think accessing skb->len after passing the skb to
> gro_cells_receive is safe, see
> c7cc9200e9b4 ("macsec: avoid use-after-free in macsec_handle_frame()")

Thanks for spotting this! It's basically the same issue (but symmetric) 
as patch 10/25.

> 
> 
> [...]
>>   static void ovpn_struct_free(struct net_device *net)
>>   {
>> +	struct ovpn_struct *ovpn = netdev_priv(net);
>> +
>> +	gro_cells_destroy(&ovpn->gro_cells);
>> +	rcu_barrier();
> 
> What's the purpose of this rcu_barrier? I expect it in module_exit,
> not when removing one netdevice.

Good question.
I presume it's a leftover from previous tests.
I think it's harmless, but it should not be needed at all.

I will remove it.

> 
> 
>> diff --git a/drivers/net/ovpn/skb.h b/drivers/net/ovpn/skb.h
>> index 7966a10d915f..e070fe6f448c 100644
>> --- a/drivers/net/ovpn/skb.h
>> +++ b/drivers/net/ovpn/skb.h
>> @@ -18,10 +18,7 @@
>>   #include <linux/types.h>
>>   
>>   struct ovpn_cb {
>> -	struct aead_request *req;
>>   	struct ovpn_peer *peer;
>> -	struct ovpn_crypto_key_slot *ks;
>> -	unsigned int payload_offset;
> 
> Squashed into the wrong patch?

Darn yes. Sorry for this.

> 
> 
> [...]
>> +struct ovpn_struct *ovpn_from_udp_sock(struct sock *sk)
>> +{
>> +	struct ovpn_socket *ovpn_sock;
>> +
>> +	if (unlikely(READ_ONCE(udp_sk(sk)->encap_type) != UDP_ENCAP_OVPNINUDP))
>> +		return NULL;
>> +
>> +	ovpn_sock = rcu_dereference_sk_user_data(sk);
> 
> [1]
> 
>> +	if (unlikely(!ovpn_sock))
>> +		return NULL;
>> +
>> +	/* make sure that sk matches our stored transport socket */
>> +	if (unlikely(!ovpn_sock->sock || sk != ovpn_sock->sock->sk))
>> +		return NULL;
>> +
>> +	return ovpn_sock->ovpn;
>> +}
> 
> 
>> +static int ovpn_udp_encap_recv(struct sock *sk, struct sk_buff *skb)
>> +{
>> +	struct ovpn_peer *peer = NULL;
>> +	struct ovpn_struct *ovpn;
>> +	u32 peer_id;
>> +	u8 opcode;
>> +
>> +	ovpn = ovpn_from_udp_sock(sk);
>> +	if (unlikely(!ovpn)) {
>> +		net_err_ratelimited("%s: cannot obtain ovpn object from UDP socket\n",
>> +				    __func__);
>> +		goto drop;
>> +	}
> [...]
>> +	/* pop off outer UDP header */
>> +	__skb_pull(skb, sizeof(struct udphdr));
>> +	ovpn_recv(peer, skb);
>> +	return 0;
>> +
>> +drop:
>> +	if (peer)
>> +		ovpn_peer_put(peer);
>> +	dev_core_stats_rx_dropped_inc(ovpn->dev);
> 
> If we get here from the first goto, ovpn is NULL. You could add a
> drop_noovpn label right here to just do the free+return.

Right.
Weird though that no static analysis tool complained about ovpn possibly 
being NULL.

Will add the extra label.

> 
>> +	kfree_skb(skb);
>> +	return 0;
>> +}
>> +
>>   /**
>>    * ovpn_udp4_output - send IPv4 packet over udp socket
>>    * @ovpn: the openvpn instance
>> @@ -257,8 +342,13 @@ void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
>>    */
>>   int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
>>   {
>> +	struct udp_tunnel_sock_cfg cfg = {
>> +		.sk_user_data = ovpn,
>> +		.encap_type = UDP_ENCAP_OVPNINUDP,
>> +		.encap_rcv = ovpn_udp_encap_recv,
>> +	};
>>   	struct ovpn_socket *old_data;
>> -	int ret = 0;
>> +	int ret;
>>   
>>   	/* sanity check */
>>   	if (sock->sk->sk_protocol != IPPROTO_UDP) {
>> @@ -272,6 +362,7 @@ int ovpn_udp_socket_attach(struct socket *sock, struct ovpn_struct *ovpn)
>>   	if (!old_data) {
>>   		/* socket is currently unused - we can take it */
>>   		rcu_read_unlock();
>> +		setup_udp_tunnel_sock(sock_net(sock->sk), sock, &cfg);
> 
> This will set sk_user_data to the ovpn_struct, but ovpn_from_udp_sock
> expects the ovpn_socket [1], which is stored into sk_user_data a
> little bit later by ovpn_socket_new. If a packet reaches
> ovpn_udp_encap_recv -> ovpn_from_udp_sock before ovpn_socket_new
> overwrites sk_user_data, bad things probably happen.

Wow - this is a very nice catch.

I think this wrong cfg.sk_user_data initialization was there this since 
the first prototype, but it just passed unnoticed.

I will drop the field initialization, so that the sk_user_data stays 
NULL until it gets assigned the ovpn_sock.


Thanks a lot!

Cheers,


-- 
Antonio Quartulli
OpenVPN Inc.

