Return-Path: <netdev+bounces-161475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BC1A21C57
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 12:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056D0166979
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 11:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE881AF4E9;
	Wed, 29 Jan 2025 11:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="nU2nFaWk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j1kw4YWE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HV3JnNK4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="L3zKaIXh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282B2186615;
	Wed, 29 Jan 2025 11:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738150301; cv=none; b=cKYQkBm9lrY7vkegz18CAUlpQ8PQ+R8/eH4OGFdYBT4pDliCIN92NhIXL8jy5ab0IU2mid/MKKx8/7gtbQqNQP1taZiKeJeGq0c8d/8ixdYpE8yezUsYRZPWPVdZCp4SljLwNDDGWY3rkI72sWYNKsLwGxs9VJAk38YloLX0VEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738150301; c=relaxed/simple;
	bh=WUl8faxreAR5NMBCJ1M6ObnVZ59G1D8IoPaqQ74AJ1o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gU7l7PGJbLgpr+Vz0daq1GesC4TPOFEfaTL72P7EjbrH4G6rXGuNW1qsPKxBU7Iy8jDheEn7apXF4abJybtnsGX3gHe08BNCEwYDijoIpGWu+yVclJFSC6ncauQlokGliYU2zNYEt0EE/OdM1e0LAvLNoV7lRja03PV1Zx0hRK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=nU2nFaWk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j1kw4YWE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HV3JnNK4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=L3zKaIXh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EF8BF210F7;
	Wed, 29 Jan 2025 11:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738150297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm6ZkWTIU04p43tALdfwd8iDD1PBnWsYZdHrDAB1F10=;
	b=nU2nFaWkzOahH2RbEzX1MP1tFf2th6c0/rqe9JxI8yG7IS1xw5wa2Z/oJ4LAORbu2tbqTp
	ntt9kL90u3KsR2LfCsw5fCxm0PZpZbGc6aX4Pc9VTK13fbRl3vVG9yKSlVtQeJHY+Qe6t4
	Fz0B8CuvezUvBgbpEbBsXcuSzJOWncw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738150297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm6ZkWTIU04p43tALdfwd8iDD1PBnWsYZdHrDAB1F10=;
	b=j1kw4YWEx74S9RkAT7eY6t4D6u2Z3VS8wKZ3KOI20Cw1XARFymibEOnH4fLZ9k2EQhI5A/
	BYPhmMiaz4cjsEDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HV3JnNK4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L3zKaIXh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738150296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm6ZkWTIU04p43tALdfwd8iDD1PBnWsYZdHrDAB1F10=;
	b=HV3JnNK4w4Y4/uhTqrgfzJT0vZ+ksyfNfogjuG78leRGkSmx88aYUT3kHzrshhew9aqRQW
	U89QWkaoO+pXK4IrJ4ypRppNHRo+1HuebXymKRaTtdsuFwYs5/TjtG1Ms+ex6WPe1yLDZm
	mSuqriENMgm9YjOn2s8F4Ypey8b3w48=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738150296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gm6ZkWTIU04p43tALdfwd8iDD1PBnWsYZdHrDAB1F10=;
	b=L3zKaIXhP8KijyNLmmlPMTRks2w8Q8RXl0SHU+DJGJ0yRzsMA3SupEsobZf2I9u5wuyL+A
	mFo1RS6GJ7db47Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6571137DB;
	Wed, 29 Jan 2025 11:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id r3JpL5gRmmftYgAAD6G6ig
	(envelope-from <tbogendoerfer@suse.de>); Wed, 29 Jan 2025 11:31:36 +0000
Date: Wed, 29 Jan 2025 12:31:29 +0100
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net] gro_cells: Avoid packet re-ordering for cloned
 skbs
Message-ID: <20250129123129.0c102586@samweis>
In-Reply-To: <CANn89iJODT0+qe678jOfs4ssy10cNXg5ZsYbvgHKDYyZ6q_rgg@mail.gmail.com>
References: <20250121115010.110053-1-tbogendoerfer@suse.de>
	<3fe1299c-9aea-4d6a-b65b-6ac050769d6e@redhat.com>
	<CANn89iLwOWvzZqN2VpUQ74a5BXRgvZH4_D2iesQBdnGWmZodcg@mail.gmail.com>
	<de2d5f6e-9913-44c1-9f4e-3e274b215ebf@redhat.com>
	<CANn89iJODT0+qe678jOfs4ssy10cNXg5ZsYbvgHKDYyZ6q_rgg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EF8BF210F7
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Thu, 23 Jan 2025 11:43:05 +0100
Eric Dumazet <edumazet@google.com> wrote:

> On Thu, Jan 23, 2025 at 11:42=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >
> > On 1/23/25 11:07 AM, Eric Dumazet wrote: =20
> > > On Thu, Jan 23, 2025 at 9:43=E2=80=AFAM Paolo Abeni <pabeni@redhat.co=
m> wrote: =20
> > >> On 1/21/25 12:50 PM, Thomas Bogendoerfer wrote: =20
> > >>> gro_cells_receive() passes a cloned skb directly up the stack and
> > >>> could cause re-ordering against segments still in GRO. To avoid
> > >>> this queue cloned skbs and use gro_normal_one() to pass it during
> > >>> normal NAPI work.
> > >>>
> > >>> Fixes: c9e6bc644e55 ("net: add gro_cells infrastructure")
> > >>> Suggested-by: Eric Dumazet <edumazet@google.com>
> > >>> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> > >>> --
> > >>> v2: don't use skb_copy(), but make decision how to pass cloned skbs=
 in
> > >>>     napi poll function (suggested by Eric)
> > >>> v1: https://lore.kernel.org/lkml/20250109142724.29228-1-tbogendoerf=
er@suse.de/
> > >>>
> > >>>  net/core/gro_cells.c | 9 +++++++--
> > >>>  1 file changed, 7 insertions(+), 2 deletions(-)
> > >>>
> > >>> diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
> > >>> index ff8e5b64bf6b..762746d18486 100644
> > >>> --- a/net/core/gro_cells.c
> > >>> +++ b/net/core/gro_cells.c
> > >>> @@ -2,6 +2,7 @@
> > >>>  #include <linux/skbuff.h>
> > >>>  #include <linux/slab.h>
> > >>>  #include <linux/netdevice.h>
> > >>> +#include <net/gro.h>
> > >>>  #include <net/gro_cells.h>
> > >>>  #include <net/hotdata.h>
> > >>>
> > >>> @@ -20,7 +21,7 @@ int gro_cells_receive(struct gro_cells *gcells, s=
truct sk_buff *skb)
> > >>>       if (unlikely(!(dev->flags & IFF_UP)))
> > >>>               goto drop;
> > >>>
> > >>> -     if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)=
) {
> > >>> +     if (!gcells->cells || netif_elide_gro(dev)) {
> > >>>               res =3D netif_rx(skb);
> > >>>               goto unlock;
> > >>>       }
> > >>> @@ -58,7 +59,11 @@ static int gro_cell_poll(struct napi_struct *nap=
i, int budget)
> > >>>               skb =3D __skb_dequeue(&cell->napi_skbs);
> > >>>               if (!skb)
> > >>>                       break;
> > >>> -             napi_gro_receive(napi, skb);
> > >>> +             /* Core GRO stack does not play well with clones. */
> > >>> +             if (skb_cloned(skb))
> > >>> +                     gro_normal_one(napi, skb, 1);
> > >>> +             else
> > >>> +                     napi_gro_receive(napi, skb); =20
> > >>
> > >> I must admit it's not clear to me how/why the above will avoid OoO. I
> > >> assume OoO happens when we observe both cloned and uncloned packets
> > >> belonging to the same connection/flow.
> > >>
> > >> What if we have a (uncloned) packet for the relevant flow in the GRO,
> > >> 'rx_count - 1' packets already sitting in 'rx_list' and a cloned pac=
ket
> > >> for the critical flow reaches gro_cells_receive()?
> > >>
> > >> Don't we need to unconditionally flush any packets belonging to the =
same
> > >> flow? =20
> > >
> > > It would only matter if we had 2 or more segments that would belong
> > > to the same flow and packet train (potential 'GRO super packet'), with
> > > the 'cloned'
> > > status being of mixed value on various segments.
> > >
> > > In practice, the cloned status will be the same for all segments. =20
> >
> > I agree with the above, but my doubt is: does the above also mean that
> > in practice there are no OoO to deal with, even without this patch?
> >
> > To rephrase my doubt: which scenario is addressed by this patch that
> > would lead to OoO without it? =20
>=20
> Fair point, a detailed changelog would be really nice.

My test scenario is simple:

TCP Sender in namespace A -> ip6_tunnel -> ipvlan -> ipvlan -> ip6_tunnel -=
> TCP receiver

Sender does continuous writes in 15k chunks, receiver reads data from socke=
t in a loop.

And that is what I see:

   40   0.002766      1000::1 =E2=86=92 2000::1      TCP 15088 51238 =E2=86=
=92 5060 [PSH, ACK] Seq=3D2862576060 Ack=3D1152583678 Win=3D65536 Len=3D150=
00 TSval=3D3343493494 TSecr=3D629171944
   41   0.002844      1000::1 =E2=86=92 2000::1      TCP 9816 51238 =E2=86=
=92 5060 [PSH, ACK] Seq=3D2862591060 Ack=3D1152583678 Win=3D65536 Len=3D972=
8 TSval=3D3343493494 TSecr=3D629171944
   42   0.004122      1000::1 =E2=86=92 2000::1      TCP 1468 [TCP Previous=
 segment not captured] 51238 =E2=86=92 5060 [ACK] Seq=3D2862642188 Ack=3D11=
52583678 Win=3D65536 Len=3D1380 TSval=3D3343493496 TSecr=3D629171946
   43   0.004128      1000::1 =E2=86=92 2000::1      TCP 20788 [TCP Out-Of-=
Order] 51238 =E2=86=92 5060 [PSH, ACK] Seq=3D2862600788 Ack=3D1152583678 Wi=
n=3D65536 Len=3D20700 TSval=3D3343493496 TSecr=3D629171946
   44   0.004133      1000::1 =E2=86=92 2000::1      TCP 20788 [TCP Out-Of-=
Order] 51238 =E2=86=92 5060 [PSH, ACK] Seq=3D2862621488 Ack=3D1152583678 Wi=
n=3D65536 Len=3D20700 TSval=3D3343493496 TSecr=3D629171946
   45   0.004169      1000::1 =E2=86=92 2000::1      TCP 500 [TCP Previous =
segment not captured] 51238 =E2=86=92 5060 [PSH, ACK] Seq=3D2862665648 Ack=
=3D1152583678 Win=3D65536 Len=3D412 TSval=3D3343493496 TSecr=3D629171946
   46   0.004180      1000::1 =E2=86=92 2000::1      TCP 22168 [TCP Out-Of-=
Order] 51238 =E2=86=92 5060 [PSH, ACK] Seq=3D2862643568 Ack=3D1152583678 Wi=
n=3D65536 Len=3D22080 TSval=3D3343493496 TSecr=3D629171946
   47   0.004187      1000::1 =E2=86=92 2000::1      TCP 13888 51238 =E2=86=
=92 5060 [PSH, ACK] Seq=3D2862666060 Ack=3D1152583678 Win=3D65536 Len=3D138=
00 TSval=3D3343493496 TSecr=3D629171946
   48   0.004201      1000::1 =E2=86=92 2000::1      TCP 1288 51238 =E2=86=
=92 5060 [PSH, ACK] Seq=3D2862679860 Ack=3D1152583678 Win=3D65536 Len=3D120=
0 TSval=3D3343493496 TSecr=3D629171946
   49   0.004273      1000::1 =E2=86=92 2000::1      TCP 13888 51238 =E2=86=
=92 5060 [PSH, ACK] Seq=3D2862681060 Ack=3D1152583678 Win=3D65536 Len=3D138=
00 TSval=3D3343493496 TSecr=3D629171946

IMHO these ooO are retransmits for segments still waiting in GRO. With the
v2 patch this looks applied trace looks like this:

 2856   9.526256      1000::1 =E2=86=92 2000::1      TCP 64948 50452 =E2=86=
=92 5060 [PSH, ACK] Seq=3D1871837193 Ack=3D209151777 Win=3D65536 Len=3D6486=
0 TSval=3D2755210164 TSecr=3D2795235137
 2857   9.526258      1000::1 =E2=86=92 2000::1      TCP 5480 50452 =E2=86=
=92 5060 [PSH, ACK] Seq=3D1871902053 Ack=3D209151777 Win=3D65536 Len=3D5392=
 TSval=3D2755210164 TSecr=3D2795235137
 2858   9.535262      1000::1 =E2=86=92 2000::1      TCP 1340 [TCP Retransm=
ission] 50452 =E2=86=92 5060 [ACK] Seq=3D1871906193 Ack=3D209151777 Win=3D6=
5536 Len=3D1252 TSval=3D2755210174 TSecr=3D2795235137
 2859   9.585477      1000::1 =E2=86=92 2000::1      TCP 64948 50452 =E2=86=
=92 5060 [PSH, ACK] Seq=3D1871907445 Ack=3D209151777 Win=3D65536 Len=3D6486=
0 TSval=3D2755210224 TSecr=3D2795235197
 2860   9.585486      1000::1 =E2=86=92 2000::1      TCP 64948 50452 =E2=86=
=92 5060 [PSH, ACK] Seq=3D1871972305 Ack=3D209151777 Win=3D65536 Len=3D6486=
0 TSval=3D2755210224 TSecr=3D2795235197

Looks ok to me, but without a GRO flush there is still a chance of ooO pack=
ets.
I've worked on a new patch (below as a RFC) which pushes the check for skb_=
cloned()
into GRO. Result is comparable to the v2 patch:

  604   1.987863      1000::1 =E2=86=92 2000::1      TCP 64948 57278 =E2=86=
=92 5060 [PSH, ACK] Seq=3D1220895319 Ack=3D1484877190 Win=3D65536 Len=3D648=
60 TSval=3D646104760 TSecr=3D459787214
  605   1.987866      1000::1 =E2=86=92 2000::1      TCP 16488 57278 =E2=86=
=92 5060 [PSH, ACK] Seq=3D1220960179 Ack=3D1484877190 Win=3D65536 Len=3D164=
00 TSval=3D646104760 TSecr=3D459787214
  606   1.998231      1000::1 =E2=86=92 2000::1      TCP 1308 [TCP Retransm=
ission] 57278 =E2=86=92 5060 [ACK] Seq=3D1220975359 Ack=3D1484877190 Win=3D=
65536 Len=3D1220 TSval=3D646104771 TSecr=3D459787214
  607   2.049288      1000::1 =E2=86=92 2000::1      TCP 64948 57278 =E2=86=
=92 5060 [PSH,
  ACK] Seq=3D1220976579 Ack=3D1484877190 Win=3D65536 Len=3D64860 TSval=3D64=
6104822
  TSecr=3D459787276
  608   2.049304      1000::1 =E2=86=92 2000::1      TCP 64948 57278 =E2=86=
=92 5060 [PSH,
  ACK] Seq=3D1221041439 Ack=3D1484877190 Win=3D65536 Len=3D64860 TSval=3D64=
6104822
  TSecr=3D459787276



diff --git a/net/core/gro_cells.c b/net/core/gro_cells.c
index ff8e5b64bf6b..06e6889138ba 100644
--- a/net/core/gro_cells.c
+++ b/net/core/gro_cells.c
@@ -20,7 +20,7 @@ int gro_cells_receive(struct gro_cells *gcells, struct sk=
_buff *skb)
 	if (unlikely(!(dev->flags & IFF_UP)))
 		goto drop;
=20
-	if (!gcells->cells || skb_cloned(skb) || netif_elide_gro(dev)) {
+	if (!gcells->cells || netif_elide_gro(dev)) {
 		res =3D netif_rx(skb);
 		goto unlock;
 	}
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 2308665b51c5..66a2bb849e85 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -322,6 +322,12 @@ struct sk_buff *tcp_gro_receive(struct list_head *head=
, struct sk_buff *skb,
 	if (!p)
 		goto out_check_final;
=20
+	if (unlikely(skb_cloned(skb))) {
+		NAPI_GRO_CB(skb)->flush |=3D 1;
+		NAPI_GRO_CB(skb)->same_flow =3D 0;
+		return p;
+	}
+
 	th2 =3D tcp_hdr(p);
 	flush =3D (__force int)(flags & TCP_FLAG_CWR);
 	flush |=3D (__force int)((flags ^ tcp_flag_word(th2)) &
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index a5be6e4ed326..a9c85b0556ce 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -647,6 +647,11 @@ struct sk_buff *udp4_gro_receive(struct list_head *hea=
d, struct sk_buff *skb)
 	struct sock *sk =3D NULL;
 	struct sk_buff *pp;
=20
+	if (unlikely(skb_cloned(skb))) {
+		NAPI_GRO_CB(skb)->same_flow =3D 0;
+		goto flush;
+	}
+
 	if (unlikely(!uh))
 		goto flush;
=20
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index b41152dd4246..b754747e3e8a 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -134,6 +134,11 @@ struct sk_buff *udp6_gro_receive(struct list_head *hea=
d, struct sk_buff *skb)
 	struct sock *sk =3D NULL;
 	struct sk_buff *pp;
=20
+	if (unlikely(skb_cloned(skb))) {
+		NAPI_GRO_CB(skb)->same_flow =3D 0;
+		goto flush;
+	}
+
 	if (unlikely(!uh))
 		goto flush;
=20

What do you think about this approach ?

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Ivo Totev, Andrew McDonald, Werner Knoblich

