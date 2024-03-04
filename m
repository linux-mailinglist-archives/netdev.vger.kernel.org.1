Return-Path: <netdev+bounces-77172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 222C387064E
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 16:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CB2287E97
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 15:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7025947F7A;
	Mon,  4 Mar 2024 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKG6Dvm6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D025947F64
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709567891; cv=none; b=SYoExcxaiVIrboJ8/MHlGjhHuIyX+bfs559e8SR9+I0/0oi8frh6htyeI3VRQwR+IXx66CUS1CsgHxodgScKliQPAaivjrMAVJ1WrRVVtPIcxkmbApaMagXzsp1g8skr8H9PFJrBHib0Vtd/N8ODFURl8/vQAEdb9Q5hCPmwqQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709567891; c=relaxed/simple;
	bh=I5l6rKpK3kgfbrZ5BFEtgmZPIyOO24AwH8FwTWF53Ks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WpdWfBFeZEnFVT6tB5d6ncpybKhcVUPW/YEXOKRhU2PBIMhIIaogO4XRvg52wtmHDnh7MkIJXr+g+zmWDZUV0sdZy4a4LQS9dbDsDFBIUITTv+JpgeTOPrpKRK+kXQAZxDOIJfPUv7j7+yGuJbREz0fY1A5MqoSf/OcIBwIvLjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKG6Dvm6; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-21f0c82e97fso2963205fac.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709567889; x=1710172689; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zZYNKRnPdoZ1tECIeldEpTFG1oSq/BwaY6MeaDVPUQs=;
        b=DKG6Dvm6krVuXX9GKGiO0Ly0HQps+5GWN0vzwwjsbXLWjN8fKc8Jd5fdFwcHk0+5BB
         TSJKaGf6zdvDs/PY/ykV1x8bIbxX5KZwwyEu56c+z9/bUbHhCm/W0NOc8wSEl23pDeiV
         RqVw5s0dUCtdU1jqX79vmWUenQWxjZJPbxAE2vlqk9909IWQXsCakfzrprgJp8DYIQ6P
         VSKi4C49gogVJ+DU7av3hu92bNmUtBKsgpHrqW4QaS/VHVFHVmWyVmmSCkvSzQ7gMzHH
         hnGxcxdF4Ds8GbxdIoHaz8E6ti52io3AjbvyKroc5UfdKo7dMCns6iY2Vk/TNBotWhq5
         B1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709567889; x=1710172689;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZYNKRnPdoZ1tECIeldEpTFG1oSq/BwaY6MeaDVPUQs=;
        b=v9AumAzbO7rAG28PAhjLtLyHCckl1juKWVg3xGCdi7riMPi3KY2OroYGovCha8KW/j
         QTQQ1oUpyKwq+EtsF3OazYdzHIjE1iml1iy6/MDkJaGkO+fb+px7aWPWHmPMWbPVOtiw
         r4uKwUavY8Mge/zhZDa0ckLXjnWNXbsrwl3TyVGUahJDEpqvgaqsLNxg4/ob3gQuP/uj
         7xMNC0SYTJG8+WQSJNfd6r6L+34zEHj2yvX0K5bVaShVo7RXjwPYJqHWWe4FbhfkhSAx
         PaoJlAe/uJFGvK/77lJEzXs6wEbRLNXaWj3SqaWByJhYjpSxXwG7WiaCVlfvNv/dBzgN
         esGw==
X-Forwarded-Encrypted: i=1; AJvYcCXV/B5Is/dwXmZom5wSyBuo2jXxxAM3EKfTVIHry8iRs+F1BL7U1x2BLcOhsipUONfGHUyqWOmWLEU9lnumfm1fKK7chEik
X-Gm-Message-State: AOJu0YztIeKmh26x5E04K14uxm9e2KruVMOwnhiSUPo8rojaMDcVEPiX
	bj2A+ZzmSC2B1thCjEL1lPOJumQj/NyR9hl/GqeW68QnTeRXn1poKYYKRxSAQOTUwnyBFhjBgAQ
	5Yga9K7YBeMoYED4ihcRwmc3cm+w=
X-Google-Smtp-Source: AGHT+IG4y+7UGMGGHm1W64QtQF8CGwyPNG/Kd2NhJAqCSw/lEbCOjbai94JiDU0hT5wBnb2YUqJTjKMssa+CebwfDbo=
X-Received: by 2002:a05:6870:7885:b0:21f:d4ee:ae01 with SMTP id
 hc5-20020a056870788500b0021fd4eeae01mr12940919oab.18.1709567888796; Mon, 04
 Mar 2024 07:58:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301230542.116823-1-kuba@kernel.org> <20240301230542.116823-3-kuba@kernel.org>
 <CAD4GDZzkVJackAf2yhG1E5vypd2J=n23HD5Huu356JK1F1oLKA@mail.gmail.com> <20240304065823.258dfabf@kernel.org>
In-Reply-To: <20240304065823.258dfabf@kernel.org>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Mon, 4 Mar 2024 15:57:57 +0000
Message-ID: <CAD4GDZzZrJATP9qTe235RYytfAEm+ByeucR11g+ixWMXvGnVQQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/4] tools: ynl: allow setting recv() size
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com, 
	pabeni@redhat.com, jiri@resnulli.us
Content-Type: text/plain; charset="UTF-8"

On Mon, 4 Mar 2024 at 14:58, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 4 Mar 2024 13:38:51 +0000 Donald Hunter wrote:
> > >  class YnlFamily(SpecFamily):
> > > -    def __init__(self, def_path, schema=None, process_unknown=False):
> > > +    def __init__(self, def_path, schema=None, process_unknown=False,
> > > +                 recv_size=131072):
> >
> > An aside: what is the reason for choosing a 128k receive buffer? If I
> > remember correctly, netlink messages are capped at 32k.
>
> Attributes, not messages, right? But large messages are relatively
> rare, this is to make dump use fewer syscalls. Dump can give us multiple
> message on each recv().

I did mean messages:

https://elixir.bootlin.com/linux/latest/source/net/netlink/af_netlink.c#L1958

For rt_link I see ~21 messages per recv():

./tools/net/ynl/cli.py \
    --spec Documentation/netlink/specs/rt_link.yaml \
    --dump getlink --dbg-small-recv 131072 > /dev/null
Recv: read 3260 bytes, 2 messages
   nl_len = 1432 (1416) nl_flags = 0x2 nl_type = 16
   nl_len = 1828 (1812) nl_flags = 0x2 nl_type = 16
Recv: read 31180 bytes, 21 messages
...
Recv: read 31712 bytes, 22 messages
...

> > >          super().__init__(def_path, schema)
> > >
> > >          self.include_raw = False
> > > @@ -423,6 +428,16 @@ genl_family_name_to_id = None
> > >          self.async_msg_ids = set()
> > >          self.async_msg_queue = []
> > >
> > > +        # Note that netlink will use conservative (min) message size for
> > > +        # the first dump recv() on the socket, our setting will only matter
> >
> > I'm curious, why does it behave like this?
>
> Dump is initiated inside a send() system call, so that we can
> validate arguments and return any init errors directly.
> That means we don't know what buf size will be used by subsequent
> recv()s when we produce the first message :(

Ah, makes sense.

