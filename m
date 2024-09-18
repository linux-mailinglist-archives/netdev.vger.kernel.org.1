Return-Path: <netdev+bounces-128777-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D133D97BA92
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 12:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21499B273ED
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 10:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E70817994F;
	Wed, 18 Sep 2024 10:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekBf09+t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40752175D54
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 10:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726654071; cv=none; b=TXjkNKTXGREoNmM1dBEq6aTcJZERagm9c9Qqtp3SAF0J1CQA+XBXuRamYcfRHYn2zZ3ZJXnPto0WqNWkU7w3uIA1U9z7/mLYQbhx264ibxpqhezavHJtejCNMB4yR7QawPzodKvwC3Uxg2h5HDt2ncsIbPJzlqAC5uOtGvErqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726654071; c=relaxed/simple;
	bh=BcFQzMacYPncnCQjV8GlFDHy5qbYhhTmB5Qzsnnwln4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=MNY9mKo5Hx4CDxLluMuw0hneHmpC3Got+jcZr3G2frUH3LOpRrdVk7F1eIT4IDDa1GWVUuKLGfXMotK3j0v28tHZCTyZ6OQapUsntaDy2AVIK5/yJMRhY0on6gujHqG6gSqZ+jz+2af2kuYocwylNW6xns2pqHqUX/5n84F/Qrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekBf09+t; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42cae4eb026so64719535e9.0
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 03:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726654067; x=1727258867; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gszga9xFCv9CjVSfKw0ve8HTp+6D09ex0SaaFgmd1Q=;
        b=ekBf09+tDmnoVk+x8R8NCo3RTkI3VEmE7pZEbLVp9FTvQ+h8W5NSlLzQzBk0euRnU7
         pOb0NzO9/iEwiWkMPUANkn1DBwc+GOdpk1VyshE/QSAckH6iN70daYXy2JImg91Uyhqy
         w7ITwDPioHaz6teQqxAarptgRtlI9uUm4TwArhUchZlnaQ40ViY5rue0w+XLofUKVsyL
         SS70L64QQTc7oA928W4GtredFzb7tYArMPPEfRpukam6R6Z7RSXfmMv41XA3yQuSwvgp
         vdWl8yerODOTCK9ErahP86y8Xe4rgs9EwUYIiOXK5ubA0Pd/G8ck6cDZlDK9kqxB6gbv
         itaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726654067; x=1727258867;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9gszga9xFCv9CjVSfKw0ve8HTp+6D09ex0SaaFgmd1Q=;
        b=uEUqRZIiREdlOqszIJAZA+iAgwjZNZRWI3H8+b1C15/qwIk5JxYxgzTf5rkv9pNSJg
         /CvjUd54nam9WNRg64sUayi10euQebiSJ7itoUtBc3xendGLYta6qYXVvcrv2Vo7Ierh
         wjedwQ4QE0Q51yCfVmGIQd3Ed3F9EkH2ATmZq1qgWbs+WC4mKvmAIWmn3mijSAgBjGFI
         l9F8Od5uYhW8MexTAmKl7HeL+YrNJI8eXbnxuuTb0zKOHQTkIg23xyvWr703Mc/yxIR/
         ifdMRsiVMVEKYxOKynIoqWvDkLHOJm3n9GJ1d4F9lKoLMq8v46ak3U7M2mgmbO3Wozli
         WWDg==
X-Gm-Message-State: AOJu0YwFy7oSbrs7/M8kQ6EtyXnnhgAmdsd6M8z1wQjctygaAH3OQLz1
	BhzF73XvQSVjPalLMR7FMgojSQlUSjPfjjOwWdU9i5T0qjbnPqk6
X-Google-Smtp-Source: AGHT+IGLjQSsowOz/0lao5kIwdKFRBPGmj4tNdMdW633Utw5l1siVH+MMoYZLwCYIhmU4ezYTV+ysQ==
X-Received: by 2002:a05:600c:450a:b0:42c:b4a2:a1aa with SMTP id 5b1f17b1804b1-42cdb54784cmr179653505e9.17.1726654067003;
        Wed, 18 Sep 2024 03:07:47 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:f935:1e63:6c8b:667c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e70536bd2sm12639055e9.48.2024.09.18.03.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 03:07:46 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org,  kuba@kernel.org,  pabeni@redhat.com,
  ryazanov.s.a@gmail.com,  edumazet@google.com,  andrew@lunn.ch,
  sd@queasysnail.net
Subject: Re: [PATCH net-next v7 04/25] ovpn: add basic netlink support
In-Reply-To: <99028055-f440-45e8-8fb1-ec4e19e0cafa@openvpn.net> (Antonio
	Quartulli's message of "Tue, 17 Sep 2024 23:28:41 +0200")
Date: Wed, 18 Sep 2024 11:07:09 +0100
Message-ID: <m2o74lb7hu.fsf@gmail.com>
References: <20240917010734.1905-1-antonio@openvpn.net>
	<20240917010734.1905-5-antonio@openvpn.net> <m2wmjabehc.fsf@gmail.com>
	<99028055-f440-45e8-8fb1-ec4e19e0cafa@openvpn.net>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Antonio Quartulli <antonio@openvpn.net> writes:
>>> +      -
>>> +        name: local-ip
>>> +        type: binary
>>> +        doc: The local IP to be used to send packets to the peer (UDP only)
>>> +        checks:
>>> +          max-len: 16
>> It might be better to have separate attrs fopr local-ipv4 and
>> local-ipv6, to be consistent with vpn-ipv4 / vpn-ipv6
>
> while it is possible for a peer to be dual stack and have both an IPv4 and IPv6 address assigned
> to the VPN tunnel, the local transport endpoint can only be one (either v4 or v6).
> This is why we have only one local_ip.
> Does it make sense?

I was thinking that the two attributes would be mutually exclusive. You
could accept local-ipv4 OR local-ipv6. If both are provided then you can
report an extack error.

>>
>>> +      -
>>> +        name: keyconf
>>> +        type: nest
>>> +        doc: Peer specific cipher configuration
>>> +        nested-attributes: keyconf
>> Perhaps keyconf should just be used as a top-level attribute-set. The
>> only attr you'd need to duplicate would be peer-id? There are separate
>> ops for setting peers and for key configuration, right?
>
> This is indeed a good point.
> Yes, SET_PEER and SET_KEY are separate ops.
>
> I could go with SET_PEER only, and let the user specify a keyconf within a peer (like now).
>
> Or I could keep to SET_KEY, but then do as you suggest and move KEYCONF to the root level.
>
> Is there any preferred approach?

I liked the separate ops for key management because the sematics are
explicit and it is very obvious that there is no op for reading keys. If
you also keep keyconf attrs separate from the peer attrs then it would be
obvious that the peer ops would never expose any keyconf attrs.

>>
>>> +    -
>>> +      name: del-peer
>>> +      attribute-set: ovpn
>>> +      flags: [ admin-perm ]
>>> +      doc: Delete existing remote peer
>>> +      do:
>>> +        pre: ovpn-nl-pre-doit
>>> +        post: ovpn-nl-post-doit
>>> +        request:
>>> +          attributes:
>>> +            - ifindex
>>> +            - peer
>> I think you need to add an op for 'del-peer-notify' to specify the
>> notification, not reuse the 'del-peer' command.
>
> my idea was to use CMD_DEL_PEER and then send back a very very short PEER object.
> I took inspiration from nl80211 that sends CMD_NEW_STATION and CMD_DEL_STATION when a wifi host
> connects or disconnect. In that case the full STATION object is also delivered (maybe I should
> do the same?)
>
> Or is there some other technical reason for not reusing CMD_DEL_PEER?

nl80211 is maybe not a good example to follow because it predates the
ynl specs and code generation. The netdev.yaml spec is a good example of
a modern genetlink spec. It specifies ops for 'dev-add-ntf' and
'dev-del-ntf' that both reuse the definition from 'dev-get' with the
'notify: dev-get' attribute:

    -
      name: dev-get
      doc: Get / dump information about a netdev.
      attribute-set: dev
      do:
        request:
          attributes:
            - ifindex
        reply: &dev-all
          attributes:
            - ifindex
            - xdp-features
            - xdp-zc-max-segs
            - xdp-rx-metadata-features
            - xsk-features
      dump:
        reply: *dev-all
    -
      name: dev-add-ntf
      doc: Notification about device appearing.
      notify: dev-get
      mcgrp: mgmt
    -
      name: dev-del-ntf
      doc: Notification about device disappearing.
      notify: dev-get
      mcgrp: mgmt

The notify ops get distinct ids so they should never be confused with
normal command responses.

>> 
>>> +    -
>>> +      name: set-key
>>> +      attribute-set: ovpn
>>> +      flags: [ admin-perm ]
>>> +      doc: Add or modify a cipher key for a specific peer
>>> +      do:
>>> +        pre: ovpn-nl-pre-doit
>>> +        post: ovpn-nl-post-doit
>>> +        request:
>>> +          attributes:
>>> +            - ifindex
>>> +            - peer
>>> +    -
>>> +      name: swap-keys
>>> +      attribute-set: ovpn
>>> +      flags: [ admin-perm ]
>>> +      doc: Swap primary and secondary session keys for a specific peer
>>> +      do:
>>> +        pre: ovpn-nl-pre-doit
>>> +        post: ovpn-nl-post-doit
>>> +        request:
>>> +          attributes:
>>> +            - ifindex
>>> +            - peer
>> Same for swap-keys notifications.
>
> Yeah, here I can understand. My rationale was: tell userspace that now we truly need a
> SWAP_KEYS. Do you think this can create problems/confusion?

Right, so this is a notification to user space that it is time to swap
keys, not that a swap-keys operation has happened? If the payload is
unique to this notification then you should probably use the 'event' op
format. For example:

    -
      name: swap-keys-ntf
      doc: Notify user space that a swap-keys op is due.
      attribute-set: ovpn
      event:
        attributes:
          - ifindex
          - peer
      mcgrp: peers

>> 
>>> +    -
>>> +      name: del-key
>>> +      attribute-set: ovpn
>>> +      flags: [ admin-perm ]
>>> +      doc: Delete cipher key for a specific peer
>>> +      do:
>>> +        pre: ovpn-nl-pre-doit
>>> +        post: ovpn-nl-post-doit
>>> +        request:
>>> +          attributes:
>>> +            - ifindex
>>> +            - peer
>>> +
>>> +mcast-groups:
>>> +  list:
>>> +    -
>>> +      name: peers
>
> Thanks a lot for your comments, Donald!
>
> Regards,

