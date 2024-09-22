Return-Path: <netdev+bounces-129216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 650A297E42C
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 01:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 254262811A1
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 23:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F8D7581A;
	Sun, 22 Sep 2024 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAHI37el"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EA776F1B
	for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727047196; cv=none; b=umFLmcCb0VdlnoYXTWQDTAc0qv6H88pFW0ryKkDcTSY6y6x6x45Bmj9Zk/QexA9QdyHE7W4GYrptxZwrNpfSfQLAXMUcGAF4aeBinuJQtEeNorXR6aoXIXhPdckqApGBQod5QsMX1evfYH4mGpiZIuDiZl+3lylIR/8yln++RRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727047196; c=relaxed/simple;
	bh=3olj92bJ2bCslqRhKQdnjTb1yIH3qkSjwpnmWB2DMMY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SkURKTVdT8BLi8lNOA1g7zkop8zu9m+hd9yiIg5p22UUXD+lhxs1tWEcOldMmr2q02ny/AADeT5Z2zpM6g9vtoze1f5fDJ/pyxfDrr8FyPOA6F32a6GPJmaYWnZ9CSF66O024u5GJNTYQchiaFMjx73NhgumpqWKLdV7eCIqRQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAHI37el; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-375e5c12042so1966610f8f.3
        for <netdev@vger.kernel.org>; Sun, 22 Sep 2024 16:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727047193; x=1727651993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hGdGs3e/Hrp6hU/UR8rne3kZini8nEp5djPiuGRKrFo=;
        b=gAHI37elz8QO/DJI6CFL4fYbycVMvMpFRJ1YT4l+rLc8V7KydyBa0OM3WiTsHtJ+l7
         VrC3uHQmvyA+VglNu3ufwtI3YOhS5jH16U7pNBSTq7J2UOYGYVTFcHmw0feV06bTajht
         aN0UreM5pgDvQFDztLlNi+qln50ldNYZKe2VwoXnakCqXMe67MG+Mk+xBALXydF2AV5a
         j04/OO8uPjh7nqAgG8ooUUGwf9e4Vjxvs7ApWP/XWjNvKQmRsBbeLlHjpVi5LwZatUfG
         lzEBez8H9R3xTIlM9kmDkyt2D4yHIm/yzuE5UfTMGVQ+zKANNwsiDN2CAqczQ69Xg5nF
         BOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727047193; x=1727651993;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hGdGs3e/Hrp6hU/UR8rne3kZini8nEp5djPiuGRKrFo=;
        b=j4hhTkfVJrdFdaKPLOkLAwYAVF7C6TO3eA2VbLsA/cLDgr/w0WSc6UHLdllF5SK+Mt
         oKG0dgfSmt5iO0tMdybEHF2C8JMtxy8+BhlSsi61JEpckI0B2E+NQRfXSbLChVUcBLSs
         XPcDU8RtV0LmcraAf4F/HcVNI6RHej8VzTxXdDyk/E0d1GOnpe0PPpKCRMi02nt1M+WU
         lHSN+NUdmOQxTR8gGl6U5v2lTQeAEStqFcsZrkrgugcF/xUeos2C+L0IHEV2rkmmhPo1
         LyvD3LSTgijun2eDVp+LN6thoVfsQtIc0IigImV4pY/w79CbfQXCVb3726E4UBtBMvzh
         jNgg==
X-Gm-Message-State: AOJu0YxK2EXsdySLtSe5w70dWzQiOspGs0f5I/d4Tay0Lf0WOx4sQC+x
	rX/iyDAv2ocMNHCzyXfjq/Lk+6rII98chixbrgpfvqFFF/b3vLXo
X-Google-Smtp-Source: AGHT+IEcV8o904j6w80ZZOxKF9VBgO0q4YSDp2bfFgfm+FGZCM6h7imY/3DSjfQA355BwVoZwGv56w==
X-Received: by 2002:a5d:6d0b:0:b0:378:c2f3:defd with SMTP id ffacd0b85a97d-37a4226bbd5mr6281107f8f.13.1727047192299;
        Sun, 22 Sep 2024 16:19:52 -0700 (PDT)
Received: from [192.168.0.2] ([69.6.8.124])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e73f649dsm22991425f8f.53.2024.09.22.16.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Sep 2024 16:19:51 -0700 (PDT)
Message-ID: <70952b00-ec86-4317-8a6d-c73e884d119f@gmail.com>
Date: Mon, 23 Sep 2024 02:20:07 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/25] ovpn: add basic netlink support
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew@lunn.ch, sd@queasysnail.net,
 donald.hunter@gmail.com
References: <20240917010734.1905-1-antonio@openvpn.net>
 <20240917010734.1905-5-antonio@openvpn.net>
Content-Language: en-US
From: Sergey Ryazanov <ryazanov.s.a@gmail.com>
In-Reply-To: <20240917010734.1905-5-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.09.2024 04:07, Antonio Quartulli wrote:
> This commit introduces basic netlink support with family
> registration/unregistration functionalities and stub pre/post-doit.
> 
> More importantly it introduces the YAML uAPI description along
> with its auto-generated files:
> - include/uapi/linux/ovpn.h
> - drivers/net/ovpn/netlink-gen.c
> - drivers/net/ovpn/netlink-gen.h
> 
> Cc: donald.hunter@gmail.com
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>   Documentation/netlink/specs/ovpn.yaml | 328 ++++++++++++++++++++++++++
>   MAINTAINERS                           |   1 +
>   drivers/net/ovpn/Makefile             |   2 +
>   drivers/net/ovpn/main.c               |  14 ++
>   drivers/net/ovpn/netlink-gen.c        | 206 ++++++++++++++++
>   drivers/net/ovpn/netlink-gen.h        |  41 ++++
>   drivers/net/ovpn/netlink.c            | 153 ++++++++++++
>   drivers/net/ovpn/netlink.h            |  15 ++
>   drivers/net/ovpn/ovpnstruct.h         |  21 ++
>   include/uapi/linux/ovpn.h             | 108 +++++++++
>   10 files changed, 889 insertions(+)
>   create mode 100644 Documentation/netlink/specs/ovpn.yaml
>   create mode 100644 drivers/net/ovpn/netlink-gen.c
>   create mode 100644 drivers/net/ovpn/netlink-gen.h
>   create mode 100644 drivers/net/ovpn/netlink.c
>   create mode 100644 drivers/net/ovpn/netlink.h
>   create mode 100644 drivers/net/ovpn/ovpnstruct.h
>   create mode 100644 include/uapi/linux/ovpn.h
> 
> diff --git a/Documentation/netlink/specs/ovpn.yaml b/Documentation/netlink/specs/ovpn.yaml
> new file mode 100644
> index 000000000000..456ac3747d27
> --- /dev/null
> +++ b/Documentation/netlink/specs/ovpn.yaml
> @@ -0,0 +1,328 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-Clause)
> +#
> +# Author: Antonio Quartulli <antonio@openvpn.net>
> +#
> +# Copyright (c) 2024, OpenVPN Inc.
> +#
> +
> +name: ovpn
> +
> +protocol: genetlink
> +
> +doc: Netlink protocol to control OpenVPN network devices
> +
> +definitions:
> +  -
> +    type: const
> +    name: nonce-tail-size
> +    value: 8
> +  -
> +    type: enum
> +    name: cipher-alg
> +    value-start: 0
> +    entries: [ none, aes-gcm, chacha20_poly1305 ]
> +  -
> +    type: enum
> +    name: del-peer_reason
> +    value-start: 0
> +    entries: [ teardown, userspace, expired, transport-error, transport_disconnect ]
> +  -
> +    type: enum
> +    name: key-slot
> +    value-start: 0
> +    entries: [ primary, secondary ]
> +  -
> +    type: enum
> +    name: mode
> +    value-start: 0
> +    entries: [ p2p, mp ]
> +
> +attribute-sets:
> +  -
> +    name: peer
> +    attributes:
> +      -
> +        name: id
> +        type: u32
> +        doc: |
> +          The unique Id of the peer. To be used to identify peers during
> +          operations
> +        checks:
> +          max: 0xFFFFFF
> +      -
> +        name: sockaddr-remote
> +        type: binary
> +        doc: |
> +          The sockaddr_in/in6 object identifying the remote address/port of the
> +          peer
> +      -
> +        name: socket
> +        type: u32
> +        doc: The socket to be used to communicate with the peer
> +      -
> +        name: vpn-ipv4
> +        type: u32
> +        doc: The IPv4 assigned to the peer by the server
> +        display-hint: ipv4
> +      -
> +        name: vpn-ipv6
> +        type: binary
> +        doc: The IPv6 assigned to the peer by the server
> +        display-hint: ipv6
> +        checks:
> +          exact-len: 16
> +      -
> +        name: local-ip
> +        type: binary
> +        doc: The local IP to be used to send packets to the peer (UDP only)
> +        checks:
> +          max-len: 16
> +      -
> +        name: local-port
> +        type: u32
> +        doc: The local port to be used to send packets to the peer (UDP only)
> +        checks:
> +          min: 1
> +          max: u16-max
> +      -
> +        name: keepalive-interval
> +        type: u32
> +        doc: |
> +          The number of seconds after which a keep alive message is sent to the
> +          peer
> +      -
> +        name: keepalive-timeout
> +        type: u32
> +        doc: |
> +          The number of seconds from the last activity after which the peer is
> +          assumed dead
> +      -
> +        name: del-reason
> +        type: u32
> +        doc: The reason why a peer was deleted
> +        enum: del-peer_reason
> +      -
> +        name: keyconf
> +        type: nest
> +        doc: Peer specific cipher configuration
> +        nested-attributes: keyconf
> +      -
> +        name: vpn-rx_bytes
> +        type: uint
> +        doc: Number of bytes received over the tunnel
> +      -
> +        name: vpn-tx_bytes
> +        type: uint
> +        doc: Number of bytes transmitted over the tunnel
> +      -
> +        name: vpn-rx_packets
> +        type: uint
> +        doc: Number of packets received over the tunnel
> +      -
> +        name: vpn-tx_packets
> +        type: uint
> +        doc: Number of packets transmitted over the tunnel
> +      -
> +        name: link-rx_bytes
> +        type: uint
> +        doc: Number of bytes received at the transport level
> +      -
> +        name: link-tx_bytes
> +        type: uint
> +        doc: Number of bytes transmitted at the transport level
> +      -
> +        name: link-rx_packets
> +        type: u32
> +        doc: Number of packets received at the transport level
> +      -
> +        name: link-tx_packets
> +        type: u32
> +        doc: Number of packets transmitted at the transport level
> +  -
> +    name: keyconf
> +    attributes:
> +      -
> +        name: slot
> +        type: u32
> +        doc: The slot where the key should be stored
> +        enum: key-slot
> +      -
> +        name: key-id
> +        doc: |
> +          The unique ID for the key. Used to fetch the correct key upon
> +          decryption
> +        type: u32
> +        checks:
> +          max: 7
> +      -
> +        name: cipher-alg
> +        type: u32
> +        doc: The cipher to be used when communicating with the peer
> +        enum: cipher-alg
> +      -
> +        name: encrypt-dir
> +        type: nest
> +        doc: Key material for encrypt direction
> +        nested-attributes: keydir
> +      -
> +        name: decrypt-dir
> +        type: nest
> +        doc: Key material for decrypt direction
> +        nested-attributes: keydir
> +  -
> +    name: keydir
> +    attributes:
> +      -
> +        name: cipher-key
> +        type: binary
> +        doc: The actual key to be used by the cipher
> +        checks:
> +         max-len: 256
> +      -
> +        name: nonce-tail
> +        type: binary
> +        doc: |
> +          Random nonce to be concatenated to the packet ID, in order to
> +          obtain the actua cipher IV
> +        checks:
> +         exact-len: nonce-tail-size
> +  -
> +    name: ovpn
> +    attributes:
> +      -
> +        name: ifindex
> +        type: u32
> +        doc: Index of the ovpn interface to operate on
> +      -
> +        name: ifname
> +        type: string
> +        doc: Name of the ovpn interface that is being created
> +      -
> +        name: mode
> +        type: u32
> +        enum: mode
> +        doc: |
> +          Oper mode instructing an interface to act as Point2Point or
> +          MultiPoint
> +      -
> +        name: peer
> +        type: nest
> +        doc: |
> +          The peer object containing the attributed of interest for the specific
> +          operation
> +        nested-attributes: peer
> +
> +operations:
> +  list:
> +    -
> +      name: new-iface
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Create a new interface
> +      do:
> +        request:
> +          attributes:
> +            - ifname
> +            - mode
> +        reply:
> +          attributes:
> +            - ifname
> +            - ifindex
> +    -
> +      name: del-iface
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Delete existing interface
> +      do:
> +        pre: ovpn-nl-pre-doit
> +        post: ovpn-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +    -
> +      name: set-peer
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Add or modify a remote peer

As Donald already mentioned, the typical approach to manage objects via 
Netlink is to provide an interface with four commands: New, Set, Get, 
Del. Here, peer created implicitely using the "set" comand. Out of 
curiosity, what the reason to create peers in the such way?

Is the reason to create keys also implicitly same?

> +      do:
> +        pre: ovpn-nl-pre-doit
> +        post: ovpn-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - peer
> +    -
> +      name: get-peer
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Retrieve data about existing remote peers (or a specific one)
> +      do:
> +        pre: ovpn-nl-pre-doit
> +        post: ovpn-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - peer
> +        reply:
> +          attributes:
> +            - peer
> +      dump:
> +        request:
> +          attributes:
> +            - ifindex
> +        reply:
> +          attributes:
> +            - peer
> +    -
> +      name: del-peer
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Delete existing remote peer
> +      do:
> +        pre: ovpn-nl-pre-doit
> +        post: ovpn-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - peer
> +    -
> +      name: set-key
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Add or modify a cipher key for a specific peer
> +      do:
> +        pre: ovpn-nl-pre-doit
> +        post: ovpn-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - peer
> +    -
> +      name: swap-keys
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Swap primary and secondary session keys for a specific peer
> +      do:
> +        pre: ovpn-nl-pre-doit
> +        post: ovpn-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - peer
> +    -
> +      name: del-key
> +      attribute-set: ovpn
> +      flags: [ admin-perm ]
> +      doc: Delete cipher key for a specific peer
> +      do:
> +        pre: ovpn-nl-pre-doit
> +        post: ovpn-nl-post-doit
> +        request:
> +          attributes:
> +            - ifindex
> +            - peer
> +

--
Sergey


