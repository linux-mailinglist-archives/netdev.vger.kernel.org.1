Return-Path: <netdev+bounces-128694-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C88ED97B0B7
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 15:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2A91C21F94
	for <lists+netdev@lfdr.de>; Tue, 17 Sep 2024 13:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832CE166F25;
	Tue, 17 Sep 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrFXDeDi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3704C66
	for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 13:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726579448; cv=none; b=c4fqERSp5/tPVODe9pyJ1Zkol+gAeW7bTfWj39uiuNkYH1761Bgrx6xUWkUPzr8wh2FuTNfGANKzBo6C7FuOw8FTGxNVGC1r+u8vhRN6/BZaXMs6g9WCrIfa1zElf/kadAXY9jM1pW2IxtVYA93P78KYh3ZIE9DwLiHWqwcgD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726579448; c=relaxed/simple;
	bh=+/WXBeVZ5fv1+oeEJYnl47W2a6urQRLfGNgtsbB1Y7Y=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=J8rUl3a5Z9MZLGIVJo4oEtfVHei5ikTWp2UG1/aySEH1hctI5Eo7TpqLwFcxFXeNRRx+EQvvB9X0KUXSw4zPGirjMYSnGYo8W/Bfxocc4/dBWJKh/PQpbrqERLoNkt6M+252eSDAenYwdaduxI5AJbBSZOMcc/VzxOlhktlXaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrFXDeDi; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42cc8782869so54954315e9.2
        for <netdev@vger.kernel.org>; Tue, 17 Sep 2024 06:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726579445; x=1727184245; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DHyZ1TPDpLkQlAlwFWcAHQPTiC406qTyg5OtxMuLmU4=;
        b=GrFXDeDi/SCr2rMRhVSbWunCOb2nLWCeCZPGcGnt0Fb7vFpg0Qypvsv7uVV5qQdAIZ
         FFG5zxPDc+ihdbXUiS6TRq4TUbNFiYVzHAkAXzWCzkJORk7jdiqxXTfYthh2gp6hhemT
         FNIpEpgRrXB1fOUKQpwJkHZHrZQqkdOOaPpjAq8McDQRBy3BGjejayFJKQJHee3fpvRK
         Ja6PlqsQ7csPXKjfzIrADaHoJWFvTJb4PqTINwDvPQ3ByYTIAZyN+AjEVRU1Vhe65HPx
         kijpkqCAYgmjU0sk0HlgJ19psykZfNnH7WJa5uUymcEA3NHHNBn8r+YD0OxxsSWKNQJU
         W4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726579445; x=1727184245;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DHyZ1TPDpLkQlAlwFWcAHQPTiC406qTyg5OtxMuLmU4=;
        b=dnG8492NtH+2bXLm3sC5zMsZr7a1e3gh483gcF58SnSQw8i2pdVXyrQaPcLyFpgXpy
         RNvT+jOi1nI/WqK2Ies5MgaHngMN1fdL+2uf63MvY/vgjMteeoL2PzEz5a9H9D/3Fp6T
         AU3O0bj+k16Lsx4/StgA8uTTExzSyGmfxInqBl0oiG+k3jJeFqMLIKULVnTH2LRY0p2x
         rk0a0TaB4129zt+edtxx0oFACI9sLGdVB3EPaPiq6B1PrGpYhZN2e/kcR/4svuMAarnn
         smc4SaW+2wXm4ZqIH/gZZPykLvrGCTcYx/aYVdeR6EO2gyVWhg3ECz7Gg5eIuipcQvTV
         6M5Q==
X-Gm-Message-State: AOJu0YzXukbCMxNP5ATrTRDxmA3i9VNySq0/nOiPOBNLfsz5W0sk8+da
	2/Im7IWFJPWSIlZZcJY8ZK6KiLZRrKjZMZqQyq6Mfhpb5WoAZ7ot
X-Google-Smtp-Source: AGHT+IFvFGWeIP+w0c1l3gD5VT5mU6RBLheSZmreXkjYwTGEC6AEZHhMKNxvLlhXdVX93wYj5ad0vw==
X-Received: by 2002:a05:600c:1c85:b0:42c:b9a5:ebae with SMTP id 5b1f17b1804b1-42cdb5385c8mr138804885e9.9.1726579444277;
        Tue, 17 Sep 2024 06:24:04 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:b1fe:6c04:a046:b080])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42d9b054fc0sm138096015e9.7.2024.09.17.06.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2024 06:24:03 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org,  kuba@kernel.org,  pabeni@redhat.com,
  ryazanov.s.a@gmail.com,  edumazet@google.com,  andrew@lunn.ch,
  sd@queasysnail.net
Subject: Re: [PATCH net-next v7 04/25] ovpn: add basic netlink support
In-Reply-To: <20240917010734.1905-5-antonio@openvpn.net> (Antonio Quartulli's
	message of "Tue, 17 Sep 2024 03:07:13 +0200")
Date: Tue, 17 Sep 2024 14:23:59 +0100
Message-ID: <m2wmjabehc.fsf@gmail.com>
References: <20240917010734.1905-1-antonio@openvpn.net>
	<20240917010734.1905-5-antonio@openvpn.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonio Quartulli <antonio@openvpn.net> writes:

> This commit introduces basic netlink support with family
> registration/unregistration functionalities and stub pre/post-doit.
>
> More importantly it introduces the YAML uAPI description along

Hi Antonio,

net-next is currently closed so my guess is that you'll have to resend
this when net-next reopens at the end of the month:

https://netdev.bots.linux.dev/net-next.html

I have read through the YAML spec and I have few comments (and nits)
below.

Thanks,
Donald.

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

Nit: Is there any reason for the underscore in chacha20_poly1305 and the
mixed use of dash / underscore in various identifiers throughout the
spec? The YNL convention is to use dashes throughout.

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

The use of structs as attribute values is strongly discouraged. There
should be separate attributes for port and ipv[46]-address.

https://docs.kernel.org/userspace-api/netlink/intro.html#fixed-metadata-and-structures

> +      -
> +        name: socket
> +        type: u32
> +        doc: The socket to be used to communicate with the peer
> +      -
> +        name: vpn-ipv4
> +        type: u32
> +        doc: The IPv4 assigned to the peer by the server

nit: IPv4 address

> +        display-hint: ipv4
> +      -
> +        name: vpn-ipv6
> +        type: binary
> +        doc: The IPv6 assigned to the peer by the server

nit: IPv6 address

> +        display-hint: ipv6
> +        checks:
> +          exact-len: 16
> +      -
> +        name: local-ip
> +        type: binary
> +        doc: The local IP to be used to send packets to the peer (UDP only)
> +        checks:
> +          max-len: 16

It might be better to have separate attrs fopr local-ipv4 and
local-ipv6, to be consistent with vpn-ipv4 / vpn-ipv6

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

Perhaps keyconf should just be used as a top-level attribute-set. The
only attr you'd need to duplicate would be peer-id? There are separate
ops for setting peers and for key configuration, right?

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

This might be better called 'dev' or 'link' to be consistent with the
existing netlink UAPIs.

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

I think you need to add an op for 'del-peer-notify' to specify the
notification, not reuse the 'del-peer' command.

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

Same for swap-keys notifications.

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
> +mcast-groups:
> +  list:
> +    -
> +      name: peers

