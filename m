Return-Path: <netdev+bounces-143552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B109C2F3D
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 19:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 376BE1C20CEE
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1313E1A0B04;
	Sat,  9 Nov 2024 18:54:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88BB1A00F8
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 18:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731178478; cv=none; b=ACkwR6/zn6zjp1Db1ANlHc/QZr0oBJiKx7LmOT9cue13DsX4rxPz5lUC5a5zkWBnWT4l2kCPcmOqBUGVlMgRLHrZ2PkFdR6oY1aHhKuQpirCAdvr5KcH63dBp/BQocX1+pHnklwqyWQfxYy7ZyTD7mv5EuquiVgPv3AXFRzqAmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731178478; c=relaxed/simple;
	bh=0wNOV6SNYOIyW0tw4BUHx3KFXF5zgy16aKuJ7++ukNw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZTp3rtevgqeRpU/vl/By0/ab4V31Zhms8W4Daqkno0Tw/Jo0/6pE8B1UVZDQOorm07bhYkmZzuffSaoeQCZY5RI+I2/dIl3TtY6nLGhq5oxCPSkXjZkckzLMZaOvo90FFf6GFSS6SJUgiyIFujOoIYTCD52SFlkOSDb4ROMyiUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inf.elte.hu; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=inf.elte.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d50fad249so2400606f8f.1
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 10:54:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731178473; x=1731783273;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wNOV6SNYOIyW0tw4BUHx3KFXF5zgy16aKuJ7++ukNw=;
        b=lu8Jx/JdylplcjzV/vCKSa3hgolukHiHKQUHFsXdpoGObRv++bHF/p+WVvC6Zi5rVk
         9t8isEkgvaOlXCRXRgIfhC3efrHBSoJtTMWWWQsjZiDp0GY+ffNwX1re9ejmSfIhpMtU
         gY3HRxPgCbnKXZ4nc7MsL2kPtaQjRTsf1KENtPwq12SRQCJPADExp+cTwNshi5y4Nc4N
         2VZilXWFNdOXzwr0tBuzUY2qf/KR2l/O9GgEFVNrY7fsVmMeWV6K+wK/kCV/IWZnKnB+
         dcb7D1BTnHH8lglIoTn/QhbXnL+UZtV4Dpl1P4XD4R4pjE63nhpNBoyiFq/fSjPPpO9J
         a5lA==
X-Forwarded-Encrypted: i=1; AJvYcCXqeUW6ltN4F2YUAA2l3E4tXtagDVec/SChFSKoHHJNjr4KTIQGHawc6pj4wJYxEntHMtmG2ZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqU82NOGOVRbyOt5qkYvrIJLjQzKjDqA42P/3loWspEK6RDThP
	7PfX6VCk5JhzbFDhwg56hqUW3RP4iZwIcqy3slmsLHMdLTRU4mRE
X-Google-Smtp-Source: AGHT+IFvBJ29pa6oJFSfesnM7EFl1UjywpMj17Ur3zCD8byKdL6DBRloAqfKy+sJCQrw82Jh7BtItw==
X-Received: by 2002:a5d:64cb:0:b0:37d:50f8:a7f4 with SMTP id ffacd0b85a97d-381f188c98bmr7340106f8f.52.1731178472663;
        Sat, 09 Nov 2024 10:54:32 -0800 (PST)
Received: from [127.0.0.1] (login04.caesar.elte.hu. [157.181.151.133])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9973e8sm8489579f8f.48.2024.11.09.10.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 10:54:31 -0800 (PST)
Message-ID: <00df52aa503fdc1a795ec1574ef9a17f2475230c.camel@inf.elte.hu>
Subject: Re: [PATCH net-next v3 3/3] selftest: net: test SO_PRIORITY
 ancillary data with cmsg_sender
From: Ferenc Fejes <fejes@inf.elte.hu>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Anna Emese Nyiri
	 <annaemesenyiri@gmail.com>, netdev@vger.kernel.org
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, Ido Schimmel
	 <idosch@idosch.org>
Date: Sat, 09 Nov 2024 19:54:30 +0100
In-Reply-To: <672e246394d26_2a4cd22945d@willemb.c.googlers.com.notmuch>
References: <20241107132231.9271-1-annaemesenyiri@gmail.com>
	 <20241107132231.9271-4-annaemesenyiri@gmail.com>
	 <672cf752e2014_1f26762945a@willemb.c.googlers.com.notmuch>
	 <672e246394d26_2a4cd22945d@willemb.c.googlers.com.notmuch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-11-08 at 09:46 -0500, Willem de Bruijn wrote:
> Willem de Bruijn wrote:
> > Anna Emese Nyiri wrote:
> > > Extend cmsg_sender.c with a new option '-Q' to send SO_PRIORITY
> > > ancillary data.
> > >=20
> > > Add the `cmsg_so_priority.sh` script, which sets up two network=C2=A0=
=20
> > > namespaces (red and green) and uses the `cmsg_sender.c` program
> > > to=C2=A0=20
> > > send messages between them. The script sets packet priorities
> > > both=C2=A0=20
> > > via `setsockopt` and control messages (cmsg) and verifies
> > > whether=C2=A0=20
> > > packets are routed to the same queue based on priority settings.
> >=20
> > qdisc. queue is a more generic term, generally referring to hw
> > queues.
> > =C2=A0
> > > Suggested-by: Ido Schimmel <idosch@idosch.org>
> > > Signed-off-by: Anna Emese Nyiri <annaemesenyiri@gmail.com>
> > > ---
> > > =C2=A0tools/testing/selftests/net/cmsg_sender.c=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 11 +-
> > > =C2=A0.../testing/selftests/net/cmsg_so_priority.sh | 115
> > > ++++++++++++++++++
> > > =C2=A02 files changed, 125 insertions(+), 1 deletion(-)
> > > =C2=A0create mode 100755
> > > tools/testing/selftests/net/cmsg_so_priority.sh
> > =C2=A0
> > > diff --git a/tools/testing/selftests/net/cmsg_so_priority.sh
> > > b/tools/testing/selftests/net/cmsg_so_priority.sh
> > > new file mode 100755
> > > index 000000000000..706d29b251e9
> > > --- /dev/null
> > > +++ b/tools/testing/selftests/net/cmsg_so_priority.sh
> > > @@ -0,0 +1,115 @@
> > > +#!/bin/bash
> >=20
> > SPDX header
> >=20
> > > +
> > > +source lib.sh
> > > +
> > > +IP4=3D192.168.0.2/16
> > > +TGT4=3D192.168.0.3/16
> > > +TGT4_NO_MASK=3D192.168.0.3
> > > +IP6=3D2001:db8::2/64
> > > +TGT6=3D2001:db8::3/64
> > > +TGT6_NO_MASK=3D2001:db8::3
> > > +IP4BR=3D192.168.0.1/16
> > > +IP6BR=3D2001:db8::1/64
> > > +PORT=3D8080
> > > +DELAY=3D400000
> > > +QUEUE_NUM=3D4
> > > +
> > > +
> > > +cleanup() {
> > > +=C2=A0=C2=A0=C2=A0 ip netns del red 2>/dev/null
> > > +=C2=A0=C2=A0=C2=A0 ip netns del green 2>/dev/null
> > > +=C2=A0=C2=A0=C2=A0 ip link del br0 2>/dev/null
> > > +=C2=A0=C2=A0=C2=A0 ip link del vethcab0 2>/dev/null
> > > +=C2=A0=C2=A0=C2=A0 ip link del vethcab1 2>/dev/null
> > > +}
> > > +
> > > +trap cleanup EXIT
> > > +
> > > +priority_values=3D($(seq 0 $((QUEUE_NUM - 1))))
> > > +
> > > +queue_config=3D""
> > > +for ((i=3D0; i<$QUEUE_NUM; i++)); do
> > > +=C2=A0=C2=A0=C2=A0 queue_config+=3D" 1@$i"
> > > +done
> > > +
> > > +map_config=3D$(seq 0 $((QUEUE_NUM - 1)) | tr '\n' ' ')
> > > +
> > > +ip netns add red
> > > +ip netns add green
> > > +ip link add br0 type bridge
> > > +ip link set br0 up
> >=20
> > Is this bridge needed? Can this just use a veth pair as is.
> >=20
> > More importantly, it would be great if we can deduplicate this kind
> > of
> > setup boilerplate across similar tests as much as possible.
>=20
> As a matter of fact, similar to cmsg_so_mark, this test can probably
> use a dummy netdevice, no need for a second namespace and dev.
>=20
> cmsg_so_mark.sh is probably small enough that it is fine to copy that
> and create a duplicate. As trying to extend it to cover both tests
> will probably double it in size and will just be harder to follow.

I'm afraid we don't have "ip rule" match argument for skb->priority
like we have for skb->mark (ip rule fwmark). AFAIU cmsg_so_mark.sh uses
rule matches to confirm if skb->mark is correct or not.

Using nftables meta priority would work with a dummy device:
add table so_prio
add chain so_prio so_prio_chain { type filter hook output priority 0; }
add rule so_prio so_prio_chain meta priority $SOPRIOVALUE counter

Is there anything simpler? I am afraid we cannot use nftables in
selftests, or can we? Thanks!




