Return-Path: <netdev+bounces-128740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CBA97B52D
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 23:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4651C21672
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 21:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF1BF18950D;
	Tue, 17 Sep 2024 21:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ItRruCDP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B8B18133C
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 21:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726608526; cv=none; b=uQGNjPHLulJbAipg2ieYa+6bW9XLB8DcxMNO7xVmQyjxaDab3nBc21ttqC12ionyVp1NUzSYlJagrT+mCgC3rmNN9ui4YGXnkz3pln39wJFF0PrUftSsJOKC/YvJAPEcvOg9cDgxAY/03IjASzrceX9BFQz3fXyeRIjhyi4yG8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726608526; c=relaxed/simple;
	bh=RwJQGJN8l3CDQpg71PFMIQr9nlSUj2Y/At4qA5Ft06g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jDZDO8L6db7RMWyrWxG+YEtKeXiZwTOQBSg7xbL4a0Mgn7xmIeS9EdCfXoYyO+eXUHoywudxIfU1Y6akiglVwQJJJ/rPMCdMBj5tVgtVy36XYc0tAwSSQub85Fv2f244X5AhxLoAsySIEjkgppPAQ0fXq6P3JIlTarK1Ig0i4Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ItRruCDP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42cb57f8b41so64360365e9.0
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 14:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726608522; x=1727213322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=up+w3coNdish44W9x/TOQ5t1yZiape9rup0Fe0cMMF4=;
        b=ItRruCDPAw/jegDYpuEd8wrW1YPz6Gt+DkkQ8Gl9TkTiDJBTUl2ArvpmmeLU3QHKdW
         h3Wc/2CBqy1hO9lKvjf0RsSqxohVa/t0Trjw+/53smmQZuJL3JnESINAGsu0f3DtpF+C
         ano3s9XDrON0wTmnwXqhjgqSpTioAQ+GPN1ono9ZVJtEuJ6qmyqZ19OuzAodU+dT2ksF
         l4MY3EhCeRYdw8FahR0Rc4IZSUbB2S5cOCtdCPqgBXE0gKJ7Zgh7zzoFVky7IiWPela7
         dKENEIMOOSLra5vD0BHoDcK7+EH4H74K4tIPbDSDv7anlT+D1F19WPTTr4fehauo1IXO
         KE7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726608522; x=1727213322;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=up+w3coNdish44W9x/TOQ5t1yZiape9rup0Fe0cMMF4=;
        b=VmEoJqzD85Rvi+clDaf/Ez64a1loevrECjEXFsgJf2IfDTz+7lcdl92adpspZSodly
         nfolX/14QXpIb3HnxubonxMOJFyPhO9/98xvs88oT9wY+RSlVrmb4BTlAViPq6k9lMQQ
         e5iPpFrBTRQ7aHX0wpt5QSrsLJx4itg7WnmltYHwqpYOj1oL6odv+qr/8SdrrrDfjfnX
         4DP1J7g31rVuj6ENNc6ZDOvp+cUYHSI4lQccMl6is0OEatLsIiys36+mm3Y0f+WhM+yN
         lhAviFc41jN+x1423nD9zRqM//orJ3NSntHLqzUhLoaqrD7EDdKrbUrwKUbNG1rRwTdl
         VUAg==
X-Gm-Message-State: AOJu0Yx+ev3sbXyCrxf8+PIyDIjy38Gf2ZqNgcZOQGyhQjTSUmqq3h4M
	Q4Ou25F71IgMVNZWYNX1+yO6O0uwGkOgV+3hLt/vrpeFeHOgw8h94Ycs/4XIi4E=
X-Google-Smtp-Source: AGHT+IHGTMaMfYkp/on1lkkckPIGjlj7gEADqkMGAtCQi/DQ+Wki5sZqXMCrDbKs7Lpm1qMRTjC1bw==
X-Received: by 2002:a05:600c:4f01:b0:42c:aeaa:6b0d with SMTP id 5b1f17b1804b1-42d907205a5mr159223805e9.9.1726608522069;
        Tue, 17 Sep 2024 14:28:42 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:a04c:720:a873:cdbf? ([2001:67c:2fbc:1:a04c:720:a873:cdbf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42da22b8b15sm114484935e9.4.2024.09.17.14.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Sep 2024 14:28:41 -0700 (PDT)
Message-ID: <99028055-f440-45e8-8fb1-ec4e19e0cafa@openvpn.net>
Date: Tue, 17 Sep 2024 23:28:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/25] ovpn: add basic netlink support
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
 sd@queasysnail.net
References: <20240917010734.1905-1-antonio@openvpn.net>
 <20240917010734.1905-5-antonio@openvpn.net> <m2wmjabehc.fsf@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <m2wmjabehc.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Donald,

On 17/09/2024 15:23, Donald Hunter wrote:
> Antonio Quartulli <antonio@openvpn.net> writes:
> 
>> This commit introduces basic netlink support with family
>> registration/unregistration functionalities and stub pre/post-doit.
>>
>> More importantly it introduces the YAML uAPI description along
> 
> Hi Antonio,
> 
> net-next is currently closed so my guess is that you'll have to resend
> this when net-next reopens at the end of the month:
> 
> https://netdev.bots.linux.dev/net-next.html

I quickly discussed this point with Sabrina and the conclusion was that 
posting shouldn't hurt as this patchset is not truly "a new submission".
In any case, I'll see if more comments come through or not first.

> 
> I have read through the YAML spec and I have few comments (and nits)
> below.

Thanks a lot. My replies are inline.

> 
> Thanks,
> Donald.
> 
>> diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
>> new file mode 100644
>> index 000000000000..456ac3747d27
>> --- /dev/null
>> +++ b/Documentation/netlink/specs/ovpn.yaml
>> @@ -0,0 +1,328 @@
>> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
>> +#
>> +# Author: Antonio Quartulli <antonio@openvpn.net>
>> +#
>> +# Copyright (c) 2024, OpenVPN Inc.
>> +#
>> +
>> +name: ovpn
>> +
>> +protocol: genetlink
>> +
>> +doc: Netlink protocol to control OpenVPN network devices
>> +
>> +definitions:
>> +  -
>> +    type: const
>> +    name: nonce-tail-size
>> +    value: 8
>> +  -
>> +    type: enum
>> +    name: cipher-alg
>> +    value-start: 0
>> +    entries: [ none, aes-gcm, chacha20_poly1305 ]
> 
> Nit: Is there any reason for the underscore in chacha20_poly1305 and the
> mixed use of dash / underscore in various identifiers throughout the
> spec? The YNL convention is to use dashes throughout.

No real reason, I must have not realized that I Was mixing the two.
I will convert them all to dashes.


> 
>> +  -
>> +    type: enum
>> +    name: del-peer_reason
>> +    value-start: 0
>> +    entries: [ teardown, userspace, expired, transport-error, transport_disconnect ]
>> +  -
>> +    type: enum
>> +    name: key-slot
>> +    value-start: 0
>> +    entries: [ primary, secondary ]
>> +  -
>> +    type: enum
>> +    name: mode
>> +    value-start: 0
>> +    entries: [ p2p, mp ]
>> +
>> +attribute-sets:
>> +  -
>> +    name: peer
>> +    attributes:
>> +      -
>> +        name: id
>> +        type: u32
>> +        doc: |
>> +          The unique Id of the peer. To be used to identify peers during
>> +          operations
>> +        checks:
>> +          max: 0xFFFFFF
>> +      -
>> +        name: sockaddr-remote
>> +        type: binary
>> +        doc: |
>> +          The sockaddr_in/in6 object identifying the remote address/port of the
>> +          peer
> 
> The use of structs as attribute values is strongly discouraged. There
> should be separate attributes for port and ipv[46]-address.
> 
> https://docs.kernel.org/userspace-api/netlink/intro.html#fixed-metadata-and-structures

Thanks a lot for the pointer! I didn't know that.
This means I have to change the netlink attributes as per your 
suggestion (address, port, scope_id) and recreate the sockaddr on the 
kernel side.

> 
>> +      -
>> +        name: socket
>> +        type: u32
>> +        doc: The socket to be used to communicate with the peer
>> +      -
>> +        name: vpn-ipv4
>> +        type: u32
>> +        doc: The IPv4 assigned to the peer by the server
> 
> nit: IPv4 address

ACK

> 
>> +        display-hint: ipv4
>> +      -
>> +        name: vpn-ipv6
>> +        type: binary
>> +        doc: The IPv6 assigned to the peer by the server
> 
> nit: IPv6 address

ACK

> 
>> +        display-hint: ipv6
>> +        checks:
>> +          exact-len: 16
>> +      -
>> +        name: local-ip
>> +        type: binary
>> +        doc: The local IP to be used to send packets to the peer (UDP only)
>> +        checks:
>> +          max-len: 16
> 
> It might be better to have separate attrs fopr local-ipv4 and
> local-ipv6, to be consistent with vpn-ipv4 / vpn-ipv6

while it is possible for a peer to be dual stack and have both an IPv4 
and IPv6 address assigned to the VPN tunnel, the local transport 
endpoint can only be one (either v4 or v6).
This is why we have only one local_ip.
Does it make sense?

> 
>> +      -
>> +        name: local-port
>> +        type: u32
>> +        doc: The local port to be used to send packets to the peer (UDP only)
>> +        checks:
>> +          min: 1
>> +          max: u16-max
>> +      -
>> +        name: keepalive-interval
>> +        type: u32
>> +        doc: |
>> +          The number of seconds after which a keep alive message is sent to the
>> +          peer
>> +      -
>> +        name: keepalive-timeout
>> +        type: u32
>> +        doc: |
>> +          The number of seconds from the last activity after which the peer is
>> +          assumed dead
>> +      -
>> +        name: del-reason
>> +        type: u32
>> +        doc: The reason why a peer was deleted
>> +        enum: del-peer_reason
>> +      -
>> +        name: keyconf
>> +        type: nest
>> +        doc: Peer specific cipher configuration
>> +        nested-attributes: keyconf
> 
> Perhaps keyconf should just be used as a top-level attribute-set. The
> only attr you'd need to duplicate would be peer-id? There are separate
> ops for setting peers and for key configuration, right?

This is indeed a good point.
Yes, SET_PEER and SET_KEY are separate ops.

I could go with SET_PEER only, and let the user specify a keyconf within 
a peer (like now).

Or I could keep to SET_KEY, but then do as you suggest and move KEYCONF 
to the root level.

Is there any preferred approach?

> 
>> +      -
>> +        name: vpn-rx_bytes
>> +        type: uint
>> +        doc: Number of bytes received over the tunnel
>> +      -
>> +        name: vpn-tx_bytes
>> +        type: uint
>> +        doc: Number of bytes transmitted over the tunnel
>> +      -
>> +        name: vpn-rx_packets
>> +        type: uint
>> +        doc: Number of packets received over the tunnel
>> +      -
>> +        name: vpn-tx_packets
>> +        type: uint
>> +        doc: Number of packets transmitted over the tunnel
>> +      -
>> +        name: link-rx_bytes
>> +        type: uint
>> +        doc: Number of bytes received at the transport level
>> +      -
>> +        name: link-tx_bytes
>> +        type: uint
>> +        doc: Number of bytes transmitted at the transport level
>> +      -
>> +        name: link-rx_packets
>> +        type: u32
>> +        doc: Number of packets received at the transport level
>> +      -
>> +        name: link-tx_packets
>> +        type: u32
>> +        doc: Number of packets transmitted at the transport level
>> +  -
>> +    name: keyconf
>> +    attributes:
>> +      -
>> +        name: slot
>> +        type: u32
>> +        doc: The slot where the key should be stored
>> +        enum: key-slot
>> +      -
>> +        name: key-id
>> +        doc: |
>> +          The unique ID for the key. Used to fetch the correct key upon
>> +          decryption
>> +        type: u32
>> +        checks:
>> +          max: 7
>> +      -
>> +        name: cipher-alg
>> +        type: u32
>> +        doc: The cipher to be used when communicating with the peer
>> +        enum: cipher-alg
>> +      -
>> +        name: encrypt-dir
>> +        type: nest
>> +        doc: Key material for encrypt direction
>> +        nested-attributes: keydir
>> +      -
>> +        name: decrypt-dir
>> +        type: nest
>> +        doc: Key material for decrypt direction
>> +        nested-attributes: keydir
>> +  -
>> +    name: keydir
>> +    attributes:
>> +      -
>> +        name: cipher-key
>> +        type: binary
>> +        doc: The actual key to be used by the cipher
>> +        checks:
>> +         max-len: 256
>> +      -
>> +        name: nonce-tail
>> +        type: binary
>> +        doc: |
>> +          Random nonce to be concatenated to the packet ID, in order to
>> +          obtain the actua cipher IV
>> +        checks:
>> +         exact-len: nonce-tail-size
>> +  -
>> +    name: ovpn
>> +    attributes:
>> +      -
>> +        name: ifindex
>> +        type: u32
>> +        doc: Index of the ovpn interface to operate on
>> +      -
>> +        name: ifname
>> +        type: string
>> +        doc: Name of the ovpn interface that is being created
>> +      -
>> +        name: mode
>> +        type: u32
>> +        enum: mode
>> +        doc: |
>> +          Oper mode instructing an interface to act as Point2Point or
>> +          MultiPoint
>> +      -
>> +        name: peer
>> +        type: nest
>> +        doc: |
>> +          The peer object containing the attributed of interest for the specific
>> +          operation
>> +        nested-attributes: peer
>> +
>> +operations:
>> +  list:
>> +    -
>> +      name: new-iface
> 
> This might be better called 'dev' or 'link' to be consistent with the
> existing netlink UAPIs.

hm ok, then I think I will s/IFACE/DEV/

> 
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Create a new interface
>> +      do:
>> +        request:
>> +          attributes:
>> +            - ifname
>> +            - mode
>> +        reply:
>> +          attributes:
>> +            - ifname
>> +            - ifindex
>> +    -
>> +      name: del-iface
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Delete existing interface
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +    -
>> +      name: set-peer
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Add or modify a remote peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
>> +    -
>> +      name: get-peer
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Retrieve data about existing remote peers (or a specific one)
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
>> +        reply:
>> +          attributes:
>> +            - peer
>> +      dump:
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +        reply:
>> +          attributes:
>> +            - peer
>> +    -
>> +      name: del-peer
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Delete existing remote peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
> 
> I think you need to add an op for 'del-peer-notify' to specify the
> notification, not reuse the 'del-peer' command.

my idea was to use CMD_DEL_PEER and then send back a very very short 
PEER object.
I took inspiration from nl80211 that sends CMD_NEW_STATION and 
CMD_DEL_STATION when a wifi host connects or disconnect. In that case 
the full STATION object is also delivered (maybe I should do the same?)

Or is there some other technical reason for not reusing CMD_DEL_PEER?

> 
>> +    -
>> +      name: set-key
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Add or modify a cipher key for a specific peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
>> +    -
>> +      name: swap-keys
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Swap primary and secondary session keys for a specific peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
> 
> Same for swap-keys notifications.

Yeah, here I can understand. My rationale was: tell userspace that now 
we truly need a SWAP_KEYS. Do you think this can create problems/confusion?

> 
>> +    -
>> +      name: del-key
>> +      attribute-set: ovpn
>> +      flags: [ admin-perm ]
>> +      doc: Delete cipher key for a specific peer
>> +      do:
>> +        pre: ovpn-nl-pre-doit
>> +        post: ovpn-nl-post-doit
>> +        request:
>> +          attributes:
>> +            - ifindex
>> +            - peer
>> +
>> +mcast-groups:
>> +  list:
>> +    -
>> +      name: peers

Thanks a lot for your comments, Donald!

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

