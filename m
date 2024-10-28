Return-Path: <netdev+bounces-139416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 352059B22C1
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 03:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFBC61F21C0B
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 02:32:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71B01547F0;
	Mon, 28 Oct 2024 02:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="TdF522ug"
X-Original-To: netdev@vger.kernel.org
Received: from mail.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0B28837;
	Mon, 28 Oct 2024 02:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730082723; cv=none; b=BV1Oo90ZT3N3mF6FpzD/0ofrA5+KW1vWy5LoOe8bcLMyyWwhZqRAjPyLkKNfCP+3pEE5XGR/iZQwipveVOLaZzz8T03E/63YrTx9kWVDwvBZpVaqF9R3r5ZHnBM6mVUhjk1r8fYn6/sOwN0T3hQ0WJNGQRrfNjamkR/dSTjCyzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730082723; c=relaxed/simple;
	bh=IbccNuStDk2QzA/azvvqRXzui79cx3VGOeLgXEfgBQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mi0Io2V9cnEHe6cgt41TgsEd11qrByZlcCa3J9EQUH/AW0imXmKJYLQewWbPzqg4AHvpcZizyCYzlGvfwgHSk0Bq8AJyev+knuqCbUCTSOk1chQkRzHyLrxWNwFf5Kh5XPblcwknmRIF+YP1Wfc4Bkp91JXSrM/6lKUlODF4hC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au; spf=pass smtp.mailfrom=ellerman.id.au; dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b=TdF522ug; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ellerman.id.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1730082717;
	bh=akZfa4aGK9EQ5cduCJCgwynTCyBliCAq7gIFjV4NH30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TdF522ug+3gW8cmYOk+/ZAjjjG+WOfWMV2jSQEF+A+/zEys1VXWINkJNcK8FUKeoj
	 wdv58PU3zWDJlTkU0suSUsiKBxSH9U5l1l3olFE1t6V2JaXUEfsUEhZGAM/5wf47WR
	 vxqX8Wgr3/RT85Lcl23VXMv3s63+/AWiZOHNUcAuNs9Emhql6TE17s2PyT04smlHil
	 aeY4HUOXJImGhdkqumhfukTggocpXV3bhgXKCTfMgdPkngqvc5U/okQQrqVW0LgRPO
	 jqjld6cZFIeLaYsh79Wq5h0gPNCZ01zKqhtIi8h3sPLUFINBBJYFe0z7F2UpGCVrby
	 jYF3tCSg8YznQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4XcHTS49Plz4x6k;
	Mon, 28 Oct 2024 13:31:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rosen Penev <rosenp@gmail.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Ioana Ciornei <ioana.ciornei@nxp.com>,
 Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, open list <linux-kernel@vger.kernel.org>, "open
 list:FREESCALE QUICC ENGINE UCC ETHERNET DRIVER"
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH net-next] net: freescale: use ethtool string helpers
In-Reply-To: <CAKxU2N98hnVAE9WF72HhxzVEfhnRAgMykVgBErL9b3gupqqrxQ@mail.gmail.com>
References: <20241024205257.574836-1-rosenp@gmail.com>
 <20241025125704.GT1202098@kernel.org>
 <CAKxU2N98hnVAE9WF72HhxzVEfhnRAgMykVgBErL9b3gupqqrxQ@mail.gmail.com>
Date: Mon, 28 Oct 2024 13:31:57 +1100
Message-ID: <87ttcxrm8y.fsf@mpe.ellerman.id.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rosen Penev <rosenp@gmail.com> writes:
> On Fri, Oct 25, 2024 at 5:57=E2=80=AFAM Simon Horman <horms@kernel.org> w=
rote:
>>
>> On Thu, Oct 24, 2024 at 01:52:57PM -0700, Rosen Penev wrote:
>> > The latter is the preferred way to copy ethtool strings.
>> >
>> > Avoids manually incrementing the pointer. Cleans up the code quite wel=
l.
>> >
>> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>>
>> ...
>>
>> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c b/driv=
ers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
>> > index b0060cf96090..10c5fa4d23d2 100644
>> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
>> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_ethtool.c
>> > @@ -243,38 +243,24 @@ static void dpaa_get_ethtool_stats(struct net_de=
vice *net_dev,
>> >  static void dpaa_get_strings(struct net_device *net_dev, u32 stringse=
t,
>> >                            u8 *data)
>> >  {
>> > -     unsigned int i, j, num_cpus, size;
>> > -     char string_cpu[ETH_GSTRING_LEN];
>> > -     u8 *strings;
>> > +     unsigned int i, j, num_cpus;
>> >
>> > -     memset(string_cpu, 0, sizeof(string_cpu));
>> > -     strings   =3D data;
>> > -     num_cpus  =3D num_online_cpus();
>> > -     size      =3D DPAA_STATS_GLOBAL_LEN * ETH_GSTRING_LEN;
>> > +     num_cpus =3D num_online_cpus();
>> >
>> >       for (i =3D 0; i < DPAA_STATS_PERCPU_LEN; i++) {
>> > -             for (j =3D 0; j < num_cpus; j++) {
>> > -                     snprintf(string_cpu, ETH_GSTRING_LEN, "%s [CPU %=
d]",
>> > -                              dpaa_stats_percpu[i], j);
>> > -                     memcpy(strings, string_cpu, ETH_GSTRING_LEN);
>> > -                     strings +=3D ETH_GSTRING_LEN;
>> > -             }
>> > -             snprintf(string_cpu, ETH_GSTRING_LEN, "%s [TOTAL]",
>> > -                      dpaa_stats_percpu[i]);
>> > -             memcpy(strings, string_cpu, ETH_GSTRING_LEN);
>> > -             strings +=3D ETH_GSTRING_LEN;
>> > -     }
>> > -     for (j =3D 0; j < num_cpus; j++) {
>> > -             snprintf(string_cpu, ETH_GSTRING_LEN,
>> > -                      "bpool [CPU %d]", j);
>> > -             memcpy(strings, string_cpu, ETH_GSTRING_LEN);
>> > -             strings +=3D ETH_GSTRING_LEN;
>> > +             for (j =3D 0; j < num_cpus; j++)
>> > +                     ethtool_sprintf(&data, "%s [CPU %d]",
>> > +                                     dpaa_stats_percpu[i], j);
>> > +
>> > +             ethtool_sprintf(&data, "%s [TOTAL]", dpaa_stats_percpu[i=
]);
>> >       }
>> > -     snprintf(string_cpu, ETH_GSTRING_LEN, "bpool [TOTAL]");
>> > -     memcpy(strings, string_cpu, ETH_GSTRING_LEN);
>> > -     strings +=3D ETH_GSTRING_LEN;
>> > +     for (i =3D 0; j < num_cpus; i++)
>>
>> Perhaps this should consistently use i, rather than i and j:
>>
>>         for (i =3D 0; i < num_cpus; i++)
>>
>> Flagged by W=3D1 builds with clang-18.

> I really need to compile test this on a PPC system.

Cross compiling should be sufficient.

There's some pointers here:
  https://github.com/linuxppc/wiki/wiki/Building-powerpc-kernels

Or there's also libc-less cross compilers on kernel.org, eg:
  https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/x86_64/14.2=
.0/x86_64-gcc-14.2.0-nolibc-powerpc64-linux.tar.xz


cheers

