Return-Path: <netdev+bounces-81952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5056588BE2F
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 10:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77DA91F6224F
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 09:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B1274C0C;
	Tue, 26 Mar 2024 09:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1zcRwBW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B01482E2
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 09:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711446058; cv=none; b=pBqYp8sooPv3pH5Iu5R9eAHQSd808mVVOYBAihhmtn+48N7vp7MUfNAeheEhQCORu/TnVDGwLJDIYIlVm5QZ+XdwlUFSkGKTE4ey0Q+jONySIi3NZ6Rc3kAV/1erdvVHgTTnO6CK/v+qiGm8ruxvrULM3f57qL/7uaAW/LbQwPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711446058; c=relaxed/simple;
	bh=oYZ7Swcqv0ORL+qDvUSwxwDbcwBtILZu0BMHwDTkuVo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=QnaUTznZ/u6RcsS7r6EYoVLuB2sOFNNxLBQMy8EJK92CAXuV+qAUwCMzwlHd7ULxc1jjlDvDayjnNldUrMwIyb1XbN9DoHw7XWLrsLhitVMK1mlwipQA5XHv8YpZ5YSA9s/4orZz1KqYv4KqO+LZVnhP9R5ockVvcKsJ6xgrzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1zcRwBW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4148c65ea45so6765775e9.2
        for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 02:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711446054; x=1712050854; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bDsk+Xtv1eCqVWO9bQ6FeB3DV/CTqCmG6J4Y1W1yHho=;
        b=F1zcRwBWX/fnZCjZ/7RTRKEgYl5e1roS3d3yYDTyxqpoSHg1PeK4JsRWMifY5e6VIj
         KHHmJ2cISujsLEJX6FedN0UMFPrVJVoRze1ukkGd/hTQvZHvZNJPrb9z2KrL5ilfbqTi
         senq2jjDuOpENfNBgBdAjKj4lfF328LyrGDGSYr4v6eRj279d2myzl8gQ0tX0qePtet4
         XkOGUY7T/W1+sAqSvNo/EzBE0QGC6nMg/JCdp42HwMHTDnawrRebY8a13fsJl5rE6H0q
         INsXkfJkjHg9mwhZuuD4aIumMMR0De7toe4cgcl8g7r1FP89i5UgfB6Ma+nHiXOI/UFx
         mWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711446054; x=1712050854;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDsk+Xtv1eCqVWO9bQ6FeB3DV/CTqCmG6J4Y1W1yHho=;
        b=vN8Pt6VNafQFAXQb4t3/QbzefEvpLIIG8bwz7joKP1zQcfKk2MaEscgzmkXbNFL7N3
         kVMjYmQ6xB3U0leVjvnJ+gmyMA1lSlajIlpwspyD5TE4BdXA3uvC7dDvOf9Tame8EamF
         rjD4Vt5ztBkh3CN8MJc4rDgCkslOQzYu72VDZ5Z6jGRS8eblpV3onijkUB1SrTkYWrZg
         RS2YbYes00KuHsYK96v079TC+dugZUVTQ59NEzS0MNVjaVFZCzuOV2lULwHTenBHHWbf
         PebsMZ0pAqlNxTrD1aihUX6w0H9BsPyGTIdhEE7RFHXvCIXrVNIIzgDHL6b0hiHW/62r
         5BtQ==
X-Gm-Message-State: AOJu0YxNK8Be7YAWBL4KGA1IH71E1Bhz32SpeqbGUpoZ2fw6A4wuYGHu
	D56zYuCvttnn3suuLQ/B/xdsmLvRczhZN3Uuj0230TpQPGUh7jJr
X-Google-Smtp-Source: AGHT+IFJvc/6iMgKHX2soW1stGTHMFAWzSnYstfa9aUeHUO8YtRjrGjR6xIBZNdOq9mU8EU+BVk5RQ==
X-Received: by 2002:a05:600c:1d08:b0:413:30dc:698a with SMTP id l8-20020a05600c1d0800b0041330dc698amr6581631wms.25.1711446054317;
        Tue, 26 Mar 2024 02:40:54 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:e486:aac9:8397:25ce])
        by smtp.gmail.com with ESMTPSA id l9-20020a05600c4f0900b00414895d014fsm6247430wmq.41.2024.03.26.02.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 02:40:53 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>,  Paolo
 Abeni <pabeni@redhat.com>,  Jiri Pirko <jiri@resnulli.us>,  Jacob Keller
 <jacob.e.keller@intel.com>,  Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCHv2 net-next 2/2] doc/netlink/specs: Add vlan attr in
 rt_link spec
In-Reply-To: <20240326024325.2008639-3-liuhangbin@gmail.com> (Hangbin Liu's
	message of "Tue, 26 Mar 2024 10:43:25 +0800")
Date: Tue, 26 Mar 2024 09:34:39 +0000
Message-ID: <m2o7b11gls.fsf@gmail.com>
References: <20240326024325.2008639-1-liuhangbin@gmail.com>
	<20240326024325.2008639-3-liuhangbin@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hangbin Liu <liuhangbin@gmail.com> writes:
>
> diff --git a/Documentation/netlink/specs/rt_link.yaml b/Documentation/netlink/specs/rt_link.yaml
> index 8e4d19adee8c..41b49f15236f 100644
> --- a/Documentation/netlink/specs/rt_link.yaml
> +++ b/Documentation/netlink/specs/rt_link.yaml
> @@ -50,7 +50,16 @@ definitions:
>          name: dormant
>        -
>          name: echo
> -
> +  -
> +    name: eth-protocols

I think this should be called vlan-protocols since the enum only
contains valid vlan protocol values.

> +    type: enum
> +    entries:
> +      -
> +        name: 8021Q

The convention with YNL specs is to use lower case for names and let
e.g. ynl-gen-c convert to upper case for the C domain. So these should
be '8021q' and '8021ad'.

> +        value: 33024
> +      -
> +        name: 8021AD
> +        value: 34984
>    -
>      name: rtgenmsg
>      type: struct
> @@ -729,6 +738,43 @@ definitions:
>        -
>          name: filter-mask
>          type: u32
> +  -
> +    name: ifla-vlan-flags
> +    type: struct
> +    members:
> +      -
> +        name: flags
> +        type: u32
> +        enum: vlan-flags
> +        enum-as-flags: true
> +      -
> +        name: mask
> +        type: u32
> +        display-hint: hex
> +  -
> +    name: vlan-flags
> +    type: flags
> +    entries:
> +      -
> +        name: reorder-hdr
> +      -
> +        name: gvrp
> +      -
> +        name: loose-binding
> +      -
> +        name: mvrp
> +      -
> +        name: bridge-binding

Nit: when you specify entries by name only, you can use the abbreviated
form:

   - reorder-hdr
   - gvrp
   - loose-binding
   - mvrp
   - bridge-binding

> +  -
> +    name: ifla-vlan-qos-mapping
> +    type: struct
> +    members:
> +      -
> +        name: from
> +        type: u32
> +      -
> +        name: to
> +        type: u32
>  
>  
>  attribute-sets:
> @@ -1507,6 +1553,38 @@ attribute-sets:
>        -
>          name: num-disabled-queues
>          type: u32
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

I _think_ this needs 'multi-attr: true'

https://elixir.bootlin.com/linux/latest/source/net/8021q/vlan_netlink.c#L120

> +      -
> +        name: ingress-qos
> +        type: nest
> +        nested-attributes: ifla-vlan-qos

Same for ingress-qos.

> +      -
> +        name: protocol
> +        type: u16
> +        enum: eth-protocols
> +        byte-order: big-endian
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
> @@ -1666,6 +1744,9 @@ sub-messages:
>        -
>          value: tun
>          attribute-set: linkinfo-tun-attrs
> +      -
> +        value: vlan
> +        attribute-set: linkinfo-vlan-attrs
>        -
>          value: vrf
>          attribute-set: linkinfo-vrf-attrs

