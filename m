Return-Path: <netdev+bounces-78745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E43788764B7
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 14:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3C6D1C2134B
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 13:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390261D545;
	Fri,  8 Mar 2024 13:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPVCStoj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13B17551
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 13:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903238; cv=none; b=XAz1xdppt+iZuYd+/6637l+thnFgumvlkSrZZMuKiUZIIsLbyyNBjuQtmNYq4ImE1VjGtR6UZ7S/x1Po+noyXILdqIHlkeQcAnCXO69y9FQ2rMPlL4IKaEPxZRBnQOxEIkFAGVYlvWM0OkD3lszA0VNNuYZcqxpJyJFJLFlDpb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903238; c=relaxed/simple;
	bh=O8SpvgGHknW7h+/G/DuKh/q+/zHaAs+5CxTIXtQpHoI=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=Niqa4EF+B0OlXkR6Aubc8KhJKimjuyKp36g7CVU6lKzj9fOq0FEOsaSv+tvGYUqSI3vneLXgMuxWGU8pfxoxEmQ81jjNVL47CaDChwd4ASE409n8oIHuJ2YA7D+UXAqTAWONbXv3ZzWY61vrUAHOpImL08jFPjFSDjrROCBi6v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPVCStoj; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412e6ba32easo6004435e9.0
        for <netdev@vger.kernel.org>; Fri, 08 Mar 2024 05:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709903235; x=1710508035; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1qnmjYs+hXRwuDIo+nyxVzB52WPrsNDH/aV8VWOQSJM=;
        b=GPVCStojVuCj7B+rOUBXRxXU8pbuTb28/RId8NyTbHiLfyJrKWm7G5hhJbuedRaHlH
         0d52TTSXq4WLVZ+DQBK/521A+Oq3++v9ML4U/MZwEVHsrb+f+yUpFm92pVchL8YuOI7P
         KE/sTGjZkQTQ73wkT7TVRgmNruWqnkkv9bwdkHCw9zCXgChZM6aHu68iyDYTFLHbtmwH
         wx57LF3syAFDw926jqLB0cD61ocKqJ2PccSnwa4eMxo8zUGalqoGd2EzImXyjiDERXc4
         AZ6y4iUWaNmfYYllD1CHZ4B+hQpUywF4n4DhDtqIQznRdfP6l+6ZxsJGyjlA0v8yllv/
         V+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709903235; x=1710508035;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qnmjYs+hXRwuDIo+nyxVzB52WPrsNDH/aV8VWOQSJM=;
        b=Mf9m5LrB91XgEb6TlLqHehNLzZ86da1bg8vMrCfC4WmPtIEuc+mlyQki4h/GdW4azA
         KWKjHAS3tHSWtXQt+5KQd9iGPNM8DzQKKyZTsJYkL71Vvz1PQ6cqbqE7ktsxS9H1BaOw
         3HVSuJqWR7ByZnizpadx03QR4z5OV7pAV3xpwXfJC5OKe/IedGbCjGs3RWVN0Lyrgs+4
         gdV9jX3cjv3T/OQ+Iqdar42m6u+KnZYmPV7nDEr3ofSjb5whprpNi6LedfN57GlCQlgx
         YzS/whscKKOluhrEsvhG+qrHw3rDbFV1x2N6uTy4eMUipBlB9NPamsv05qD6AABSwhH4
         boDQ==
X-Gm-Message-State: AOJu0YyagE7pPxfWUZSIlAQHFqxESROj7emmySVMmKbPHrr1Z8L8n4Qc
	p79lkrP7/dmY12dP4iq4st6FdHrjlyi98io10NkpN9M17j6DfEpg
X-Google-Smtp-Source: AGHT+IH86MTecfWFPwy7bEh9SGR9Z3igEDgrZkSPiLkV8IanSJv03Az6pQpFFJ+M1r4KLdylsV5VFQ==
X-Received: by 2002:a05:600c:3586:b0:412:ee8b:dead with SMTP id p6-20020a05600c358600b00412ee8bdeadmr8215520wmq.34.1709903234587;
        Fri, 08 Mar 2024 05:07:14 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:f870:9393:cd1b:d379])
        by smtp.gmail.com with ESMTPSA id p42-20020a05600c1daa00b00412e6de503csm6147528wms.25.2024.03.08.05.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 05:07:13 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Jacob Keller <jacob.e.keller@intel.com>,  Jiri
 Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net-next] doc/netlink/specs: Add vlan attr in rt_link spec
In-Reply-To: <20240308041518.3047900-1-liuhangbin@gmail.com> (Hangbin Liu's
	message of "Fri, 8 Mar 2024 12:15:18 +0800")
Date: Fri, 08 Mar 2024 13:05:45 +0000
Message-ID: <m2sf10g9g6.fsf@gmail.com>
References: <20240308041518.3047900-1-liuhangbin@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hangbin Liu <liuhangbin@gmail.com> writes:

> With command:
>  # ./tools/net/ynl/cli.py \
>  --spec Documentation/netlink/specs/rt_link.yaml \
>  --do getlink --json '{"ifname": "eno1.2"}'
>
> Before:
> Exception: No message format for 'vlan' in sub-message spec 'linkinfo-data-msg'
>
> After:
>  'linkinfo': {'data': {'flag': {'flags': {'bridge-binding',
>                                           'gvrp',
>                                           'reorder-hdr'},
>                                 'mask': 4294967295},
>                        'id': 2,
>                        'protocol': 129},
>               'kind': 'vlan'},
>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
> Not sure if there is a proper way to show the mask and protocol

Using display-hint, e.g. display-hint: hex, is intended to tell the ynl
cli to render output in a human readable way. Unfortunately it currently
only works for binary attributes.

It can be done like this:

      -
        name: mask
        type: binary
        len: 4
        display-hint: hex

./tools/net/ynl/cli.py \
--spec Documentation/netlink/specs/rt_link.yaml \
--do getlink --json '{"ifname": "wlan0.8"}' --output-json | jq -C '.linkinfo'
{
  "kind": "vlan",
  "data": {
    "protocol": 33024,
    "id": 8,
    "flag": {
      "flags": [
        "reorder-hdr"
      ],
      "mask": "ff ff ff ff"
    }
  }
}

But it seems wrong to change the struct definition for this. We should
patch ynl to support hex rendering of integers.

For the protocol, you'd need to add an enum of ethernet protocol
numbers, from the info in include/uapi/linux/if_ether.h

> +  -
> +    name: linkinfo-vlan-attrs
> +    name-prefix: ifla-vlan-
> +    attributes:
> +      -
> +        name: id
> +        type: u16
> +      -
> +        name: flag
> +        type: binary
> +        struct: ifla-vlan-flags
> +      -
> +        name: egress-qos
> +        type: nest
> +        nested-attributes: ifla-vlan-qos
> +      -
> +        name: ingress-qos
> +        type: nest
> +        nested-attributes: ifla-vlan-qos
> +      -
> +        name: protocol
> +        type: u16

The protocol value is in big endian format, so it is actually 33024
(0x8100) not 129. You need to add byte-order: big-endian

> +  -
> +    name: ifla-vlan-qos
> +    name-prefix: ifla-vlan-qos
> +    attributes:
> +      -
> +        name: mapping
> +        type: binary
> +        struct: ifla-vlan-qos-mapping
>    -
>      name: linkinfo-vrf-attrs
>      name-prefix: ifla-vrf-
> @@ -1666,6 +1732,9 @@ sub-messages:
>        -
>          value: tun
>          attribute-set: linkinfo-tun-attrs
> +      -
> +        value: vlan
> +        attribute-set: linkinfo-vlan-attrs
>        -
>          value: vrf
>          attribute-set: linkinfo-vrf-attrs

