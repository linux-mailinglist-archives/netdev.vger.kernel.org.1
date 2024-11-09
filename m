Return-Path: <netdev+bounces-143555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8141B9C2F6D
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 20:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9633B1C2104D
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 19:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5105419E994;
	Sat,  9 Nov 2024 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElmvbSZR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7751E4BE
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 19:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731182193; cv=none; b=scAFAhXixhxGg9XZU6U49RdzBRNTL0i+ykBvW7YLfCs2CFbOqdtwUg7aBnG70jk0nwMciDGeXZYgagytNDb3AI1OXb6N5hI3UMIOYkOFjXr/Z7gUu6XuYUMBAupypu7I2JzSkWDZYKL+fOoiZR3nW3EaZWjA8AZDQFFt6RkZEug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731182193; c=relaxed/simple;
	bh=xKe/AQJ5wsQpVc2W+L2/6650GMDQN64iYJuEn5yuzLQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=eOFaugHwQKhAMTO0A9kl/TtyoSoWATe1HhSdgQDvCgLlCVneEm05bQ6WAJgIClgMgcE4sytKPtRv0s5lAnRGe9bLKuKDyDqFhg3EXtxooZvsLje9L2eHBIVXzgh2g0Z34TpRJ9TMPxjuOqRlRiUEqG4T7dR9jYOVqsu07tzhqBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElmvbSZR; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1b224f6c6so228642485a.3
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 11:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731182190; x=1731786990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xKe/AQJ5wsQpVc2W+L2/6650GMDQN64iYJuEn5yuzLQ=;
        b=ElmvbSZR8WuaSCY6yia+JeeMfHI1vD5K9dT6vzuXgz+G6wqSzhzgdJdorrACs2X7dN
         tSZ+b/bVtk/aNyfaK2vEInLpfjqzpUu/clhPbldAVkJaG0dVy0bxY/1MfkyBDqDFroDD
         V1NRzrX2/WjM9fjjB/TebAr6g/0+ePSRsJQFgUrwBi8BIInF7hQoVgQbTEHE7uy5CRwT
         SDcGAs9wPvpN/TVz4VtVlfoej2ezqBEWCSfOYDnGAqQY/EQpVG1iuZqT80YRCbbXj+hD
         0U0u7s4DFVq29EKss4OGVARTsHvoxa6iXMs5G+NLoeiKjes/b7hdCk+e+KDdhrJRF6Gh
         7P3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731182190; x=1731786990;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xKe/AQJ5wsQpVc2W+L2/6650GMDQN64iYJuEn5yuzLQ=;
        b=iAJgQoHZk3NJqbcJfciwvCMbRj8WdhvwDGLleKrbc81xANX3E2kG3GwACnSWi2Ji8X
         OXr50yr/OJKQYuyY1AghXJaN0IwhAkWum+/sOKzpx6DchHfRqA+3C+p2LNzU3JCIlacS
         H91x5n83w8jXGvqQ2JfHwU7tpFTByqbHrBJZ1yD9EU1+wa6zg0MJu8kO5+ocP51HgiNU
         uFjSMIWQ0YE+RzQYOSxaJvjejVZHUWfWOzf6+9G7Znabfr+RAOY6jOQL3xXO0NHMb6KH
         Gehc1T2jLhCDLMQ8+WahVlEz1UAAHJNgX1yaGf7q2ewnueV6crotSuoLSzH7CVRrqON8
         9aCg==
X-Forwarded-Encrypted: i=1; AJvYcCVYOF7NWV/thR+Cyb1xgsSCANO/ntjk80YS9bjkdsULv9Oa2L+6IWVCyhxV/TgdLyymIU4ACBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBa8aO45nLbD4eskj9LwGtbTUuNrEI8jejG55r1rNIVhmzUNAe
	kStSGcu8ssv9xY7vJHYWroXGdUvVZrpybstoIN1JHwV6hwR69mgX
X-Google-Smtp-Source: AGHT+IFwS2L3BMvi/VAMfMNjrCuCqHzr+zWhZe3lSgJekmn9APbWD8GJgKn+rL04gbrc5ihBn7abuA==
X-Received: by 2002:a05:620a:4441:b0:7a1:c40c:b1f1 with SMTP id af79cd13be357-7b331f197e9mr887789185a.58.1731182190451;
        Sat, 09 Nov 2024 11:56:30 -0800 (PST)
Received: from localhost (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b32ac678c2sm288300085a.61.2024.11.09.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 11:56:29 -0800 (PST)
Date: Sat, 09 Nov 2024 14:56:29 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Ferenc Fejes <fejes@inf.elte.hu>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Anna Emese Nyiri <annaemesenyiri@gmail.com>, 
 netdev@vger.kernel.org
Cc: edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 Ido Schimmel <idosch@idosch.org>
Message-ID: <672fbe6d15101_37aab4294b8@willemb.c.googlers.com.notmuch>
In-Reply-To: <00df52aa503fdc1a795ec1574ef9a17f2475230c.camel@inf.elte.hu>
References: <20241107132231.9271-1-annaemesenyiri@gmail.com>
 <20241107132231.9271-4-annaemesenyiri@gmail.com>
 <672cf752e2014_1f26762945a@willemb.c.googlers.com.notmuch>
 <672e246394d26_2a4cd22945d@willemb.c.googlers.com.notmuch>
 <00df52aa503fdc1a795ec1574ef9a17f2475230c.camel@inf.elte.hu>
Subject: Re: [PATCH net-next v3 3/3] selftest: net: test SO_PRIORITY ancillary
 data with cmsg_sender
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ferenc Fejes wrote:
> On Fri, 2024-11-08 at 09:46 -0500, Willem de Bruijn wrote:
> > Willem de Bruijn wrote:
> > > Anna Emese Nyiri wrote:
> > > > Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> > > > ancillary data.
> > > > =

> > > > Add the `cmsg_so_priority.sh` script, which sets up two network=C2=
=A0 =

> > > > namespaces (red and green) and uses the `cmsg_sender.c` program
> > > > to=C2=A0 =

> > > > send messages between them. The script sets packet priorities
> > > > both=C2=A0 =

> > > > via `setsockopt` and control messages (cmsg) and verifies
> > > > whether=C2=A0 =

> > > > packets are routed to the same queue based on priority settings.
> > > =

> > > qdisc. queue is a more generic term, generally referring to hw
> > > queues.
> > > =C2=A0
> > > > Suggested-by: Ido Schimmel <idosch@idosch.org>
> > > > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > > > ---
> > > > =C2=A0tools/testing/selftests/net/cmsg_sender.c=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 11 +-
> > > > =C2=A0.../testing/selftests/net/cmsg_so_priority.sh | 115
> > > > ++++++++++++++++++
> > > > =C2=A02 files changed, 125 insertions(+), 1 deletion(-)
> > > > =C2=A0create mode 100755
> > > > tools/testing/selftests/net/cmsg_so_priority.sh
> > > =C2=A0
> > > > diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh
> > > > b/tools/testing/selftests/net/cmsg_so_priority.sh
> > > > new file mode 100755
> > > > index 000000000000..706d29b251e9
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> > > > @@ -0,0 +1,115 @@
> > > > +#!/bin/bash
> > > =

> > > SPDX header
> > > =

> > > > +
> > > > +source lib.sh
> > > > +
> > > > +IP4=3D192.168.0.2/16
> > > > +TGT4=3D192.168.0.3/16
> > > > +TGT4_NO_MASK=3D192.168.0.3
> > > > +IP6=3D2001:db8::2/64
> > > > +TGT6=3D2001:db8::3/64
> > > > +TGT6_NO_MASK=3D2001:db8::3
> > > > +IP4BR=3D192.168.0.1/16
> > > > +IP6BR=3D2001:db8::1/64
> > > > +PORT=3D8080
> > > > +DELAY=3D400000
> > > > +QUEUE_NUM=3D4
> > > > +
> > > > +
> > > > +cleanup() {
> > > > +=C2=A0=C2=A0=C2=A0 ip netns del red 2>/dev/null
> > > > +=C2=A0=C2=A0=C2=A0 ip netns del green 2>/dev/null
> > > > +=C2=A0=C2=A0=C2=A0 ip link del br0 2>/dev/null
> > > > +=C2=A0=C2=A0=C2=A0 ip link del vethcab0 2>/dev/null
> > > > +=C2=A0=C2=A0=C2=A0 ip link del vethcab1 2>/dev/null
> > > > +}
> > > > +
> > > > +trap cleanup EXIT
> > > > +
> > > > +priority_values=3D($(seq 0 $((QUEUE_NUM - 1))))
> > > > +
> > > > +queue_config=3D""
> > > > +for ((i=3D0; i<$QUEUE_NUM; i++)); do
> > > > +=C2=A0=C2=A0=C2=A0 queue_config+=3D" 1@$i"
> > > > +done
> > > > +
> > > > +map_config=3D$(seq 0 $((QUEUE_NUM - 1)) | tr '\n' ' ')
> > > > +
> > > > +ip netns add red
> > > > +ip netns add green
> > > > +ip link add br0 type bridge
> > > > +ip link set br0 up
> > > =

> > > Is this bridge needed? Can this just use a veth pair as is.
> > > =

> > > More importantly, it would be great if we can deduplicate this kind=

> > > of
> > > setup boilerplate across similar tests as much as possible.
> > =

> > As a matter of fact, similar to cmsg_so_mark, this test can probably
> > use a dummy netdevice, no need for a second namespace and dev.
> > =

> > cmsg_so_mark.sh is probably small enough that it is fine to copy that=

> > and create a duplicate. As trying to extend it to cover both tests
> > will probably double it in size and will just be harder to follow.
> =

> I'm afraid we don't have "ip rule" match argument for skb->priority
> like we have for skb->mark (ip rule fwmark). AFAIU cmsg_so_mark.sh uses=

> rule matches to confirm if skb->mark is correct or not.
> =

> Using nftables meta priority would work with a dummy device:
> add table so_prio
> add chain so_prio so_prio_chain { type filter hook output priority 0; }=

> add rule so_prio so_prio_chain meta priority $SOPRIOVALUE counter
> =

> Is there anything simpler? I am afraid we cannot use nftables in
> selftests, or can we? Thanks!

I'd use traffic shaper (tc). There are a variety of qdiscs/schedulers
and classifiers that act on skb->priority.


