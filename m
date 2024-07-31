Return-Path: <netdev+bounces-114534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B225942D83
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 13:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA621C2180C
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD421AD418;
	Wed, 31 Jul 2024 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=krose.org header.i=@krose.org header.b="MCEfenYM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32D88BFF
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 11:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722426776; cv=none; b=hzx2bjjDXhFoAooYW1kpbaChpjhXCRaFcv6E6NzbS3mcI02WA/GDbT8OCEhpqFeRUN52/vM3dK+h42+BXkiXoluOmWumPYLB98aSg6M48Mp2+BNPOWPtk1vBS3J3l2Wn+cVy4LhHJSmtRAJ4RD4KXkren4lHhf8ZIGF89HK0Zro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722426776; c=relaxed/simple;
	bh=R1qDR4gtKNhUNFf1vA86CNX4XQ915mC5i6Ca8j1b9gs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fEfLCdj+VMw9itO/8oFDLK4gqWxHKfNmc8FgaEsSjyUUm1JSpinmXV/606H2PVBVwHZRrbjuiWCphGvkgMUFJH0esniwhmmkHmUrHM66Cie2C4tWrLfvH+/+P3ysLGBZ4Nl0QPMoMi5jEBectvgX/Wm06Kcd4Gx1jKRb1F+BMUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=krose.org; spf=pass smtp.mailfrom=krose.org; dkim=pass (1024-bit key) header.d=krose.org header.i=@krose.org header.b=MCEfenYM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=krose.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=krose.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5a156557029so9185576a12.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=krose.org; s=google; t=1722426772; x=1723031572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n9zIe5ydGqlp6O8xpXxugcwK2strGZqt9LBGShVfNeM=;
        b=MCEfenYMW7sBnbAw0CxXgBjltkpF/jEYvBl6yzza0HJ+ODk9MUOfjqnc05pFRyJtRl
         DUhICYwgKSH4xHpraRHjViujo2SbhA/orinV3TTnpYMiYWtSCIr6LD9mrkNSmVKVbbR7
         XMNQgawqx25n5U2lKQqprsUXIDcA9+6QKPU44=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722426772; x=1723031572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n9zIe5ydGqlp6O8xpXxugcwK2strGZqt9LBGShVfNeM=;
        b=GVXEa4LxLwHTb/0LDRaWSAcwJixSwrT8K5J0MQ7jxy6zKDt3E7Jf8ww9qPzk9DZSxg
         5oKYVRX4QINRSfWSPnm992ahF293gUwVr6SRd1D3tgglid6gqN1m2S1vm2GR3XETmOpU
         EOQkuIQzh3QQTpimAEklUTMNDGV5YqFCyFdROZD8MqA7JjM7CaauauamqbRAU+qv1jJ2
         T3oQY9Imgr7QEKpTkOYsFIqe8OfxKy+73bALNO3CA2SCrlV6FP9+XmEXc6ZRJPxEiLZE
         m3OMOcoXWteuA8Ry4VZfJQKxBRwyPqfrpBt15lRBsXYqPR/x0LVQyydLgtU1K7G7TDS7
         XhyQ==
X-Gm-Message-State: AOJu0YykxrzObmMRt2mrz9rrCTW1ioF3lfYoiZugWyuhxzB3AYbYGHZ6
	yltmA1Zv+VXIH3Rmm0DLFOgnxt9hdE5932v/8kvkBVnvD4bOOZq3HlTTB/HYvYiNHIu9ublsu32
	vIcWxRHL++8qHK7f6eiO6jj/hvzom+L9dcbACE4xpyn3iICSCREA=
X-Google-Smtp-Source: AGHT+IH3lm1DM1VOdfnfefduoWpFW4UAU3doeVZmwpAoLhJdVKQeRQxhCg2fuwt/MB7vXwjAx4vkFg348tHbI+61l4E=
X-Received: by 2002:a05:6402:35ce:b0:5a2:cc1c:4d07 with SMTP id
 4fb4d7f45d1cf-5b021d2245cmr9330902a12.27.1722426771637; Wed, 31 Jul 2024
 04:52:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJU8_nUFQShNSeT52nkdKmMDx6hodgFBSN3rCVXTQ_VgqugE8w@mail.gmail.com>
 <61cb1468-d1e1-4a47-9c04-71d00d0c59f5@redhat.com>
In-Reply-To: <61cb1468-d1e1-4a47-9c04-71d00d0c59f5@redhat.com>
From: Kyle Rose <krose@krose.org>
Date: Wed, 31 Jul 2024 07:52:39 -0400
Message-ID: <CAJU8_nW=+PdWri41rJEivG_+_ckOmVncZ8jw+e3zvHHx_Gg5eg@mail.gmail.com>
Subject: Re: IPv6 max_addresses?
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024, 4:08=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrote=
:
>
> On 7/31/24 02:05, Kyle Rose wrote:
> > max_addresses, how does it work?
> >
> > $ ip -6 addr show scope global temporary dev sfp0 | grep inet6 | wc -l
> > 21
> > $ sysctl -ar 'sfp0.*max_add'
> > net.ipv6.conf.sfp0.max_addresses =3D 16
> >
> > They seem to be growing without bound. What's supposed to be happening =
here?
>
>  From the related sysctl documentation:
>
> max_addresses - INTEGER
>          Maximum number of autoconfigured addresses per interface.
>
>
> 'max_address' only applies to the ipv6 assigned via prefix delegation,
> not to address explicitly assigned from the user-space via the `ip` tool.

These are all autoconfigured (SLAAC) privacy addresses from the same
prefix. (I don't think you mean prefix delegation, which is something
else: presumably you mean PIO, or prefix information option, included
in router advertisements. This machine is not a router.)

What is the mechanism by which old deprecated addresses are supposed
to get culled? Until now, I would have imagined it was some kind of
FIFO, but I also seem to recall sometime in the past valid_lft for a
temporary address continuing to march toward 0, after which presumably
it went away; now, valid_lft seems to be updated for every address,
even deprecated ones, to match what is received in the PIO from router
advertisements, so they never reach 0. And I don't know if there is
any other means by which they might get removed.

Up to 25 as of the writing of this response:

4: sfp0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 qdisc mq state UP
group default qlen 1000
    inet6 2601:XXXX:XXXX:XXXX:c37c:cad6:ad09:b296/64 scope global
temporary dynamic
       valid_lft 6974sec preferred_lft 148sec
    inet6 2601:XXXX:XXXX:XXXX:71ae:3a57:b823:f83b/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:a6db:6a36:1ebc:af96/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:6a99:7d72:af9f:65d1/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:52fe:9140:f9f9:99e3/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:66ed:a8ba:508e:9bc6/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:e428:6b1c:4e2:532/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:9de1:cd15:6727:c1a6/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:df23:336d:d4d9:a3be/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:36e4:b05e:cf68:6956/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:2f56:1ac1:a835:2291/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:24ae:893d:c7c9:a6d3/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:7be5:d00a:2c4:ca2d/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:f392:43:eeed:adb9/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:e0b1:e8b2:96bc:2d37/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:e6e3:5f1e:2674:4da1/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:5a0e:576d:544a:151f/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:689f:c19f:85f4:9c10/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:2008:988e:316:113a/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:415a:8dbf:997d:e36/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:d07a:9db9:a3ed:c7a6/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:2f70:b871:4cc8:7add/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:6481:3fd2:69e:5875/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:7861:f451:a5ab:8671/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec
    inet6 2601:XXXX:XXXX:XXXX:5ad9:184:856d:8ee3/64 scope global
temporary deprecated dynamic
       valid_lft 6974sec preferred_lft 0sec

For reference, the address assignment (this one via PD from my
provider) for the associated prefix on the router:

5: sfp0.10@sfp0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9000 qdisc
noqueue state UP group default qlen 1000
    inet6 2601:XXXX:XXXX:XXXX::1/64 scope global dynamic noprefixroute
       valid_lft 6843sec preferred_lft 6843sec

Kyle

