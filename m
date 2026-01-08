Return-Path: <netdev+bounces-248267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F32D062C5
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 21:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABD173014BFD
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 20:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCA233120E;
	Thu,  8 Jan 2026 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxe8eozA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D79330D27
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 20:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767905631; cv=none; b=bcea0+A+/Otg8qwTf1A104ibJCsUSdhrdV6tii3BcWGH1hv2OBAMW2Xj8ChlmSWIqVLe4NxHVODR4Nb90FMNbyqClNgqDq78Uoa9la3crN9tO9fK2g7D9gmMhgSAQKx02nbY5BxIcvh4fxjny5Fv17Bd7sUQgVW/49jHiQsA9Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767905631; c=relaxed/simple;
	bh=afGOrrG253csa3uqEgPmIydOfBGWfK5KtcXw5MNo1rs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HSx9pgCIq8Q4qIk8efPJX4Yl+RfMMHnYReYxCDQmC61g9e05Kz678R6dfJBCBSXUlTM7sZKlIPR8JYI5IOcGlloY49/6JuiLS0KoKZnPnI7WZ9tMNNjgBtnMMkEHW0skDD1gf0sScidqbNAz86qOOF0pP6omn288sK5s3QtHXIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxe8eozA; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a0c20ee83dso34087905ad.2
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 12:53:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767905630; x=1768510430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgesYXUyjhKCm1S8hcZ/z6okb8iz6ntq+8D27jGAgrg=;
        b=lxe8eozAGyl5Rq42+5MONGZZ14Z4t6MESExnzFKwxJIOPvc/+V2Af0Dg8Yfi4I0VSJ
         xPxHs2hVJa8gUNMxdptGKFlidgcouWPq27uehwOPCGAxbrb7bvnM7fKNjWYI1vCNdcq+
         PLsWeSoQqYClZnOPBFRu4WUpTH4jkw0mfSU9CXx8nCuc9HR/0IM8e5cIELeJO/YJn68j
         Sy660zIWbziZIIUz7IaGyAm06dpO5c/MH7NDV/0A4tN31LmBstX/81qF5b5eE175t9E3
         070c/dLqw3mbXhxWmtRcBlpCA5zyCxVxjSpwCWe7kCAU8O7IiHqXOrR5UsplUxiY2Gwp
         qOqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767905630; x=1768510430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgesYXUyjhKCm1S8hcZ/z6okb8iz6ntq+8D27jGAgrg=;
        b=A2ROiNtbKJD18u0yE3MKYnFVkdwalfqq2e1JmZftqra479zzO8g66ICFEKy4DkJTwE
         hLAZQlM0ZKRBrDLf8WpqdbLmwMA+ilJp0y1JVbexhcbjsemlDumy8TlxkL3FW/Y6R++X
         sdJvisDHlBvXsUMS6vYYU4aQItql5TMWJzCMtdd3/lcCwmgpoiVFHK7Yzl1dqoz2t32b
         DYezKZmNvAMuE5GJaVKq1pwXvYxF5kwrAz+8AOHkq3QlMRj/j7khKbHsB/kCf2MXvCMX
         OiIS9rJ9LlVKzZUrSDH+ItLgXLNlSPoIdmhUX9hP2UIDJm9fQpCVG5ZyPOJo6zQdv4Cd
         Js7Q==
X-Gm-Message-State: AOJu0YxHA+QUTq7Ok/9y/5LAf7VrAgpYixpvwWRD3j3Gd1nbxgIYYt2B
	y2QSuv7X/rLIhnq2VwhrmWDwdobbDcZZLW+8RuuqosopEiEydF3gGK8reiHzIo+yibdV32XLtvD
	/PBvXAIngGAufV+O+Vhr4r49abdVThz49Tl/zd7k=
X-Gm-Gg: AY/fxX6Ct3QesgKTN4H4iWMHfFc/wNAxl+lPnFpMVHOo0uH2ByXVtprkMhOofkGtAq4
	WWV1TqNFdn1BYUeWOlDenoLM1jEg787X6r5mWA49hKfvsLyBtTCfnpWGmgvLzOMo6MmgnVO2xYn
	CWYwWRuX7tzdtAhvPeXZwMKKZ+//o1wKTx9L3gaqSnxrE7wLroFGID8BaDtb7f5QzooCOe5ZS++
	PCOOY8FV/jzI5XS7qOHbkFmQ1nypDYeHnjgsuvz3cZmE65VCC1IOX6z+3Ruqn84L+oHEiw=
X-Google-Smtp-Source: AGHT+IFk1ypv6jabTKOGj053mvHy6pQjoeZ8W93H4EnhnTN6KTWCb6KqVmNC2vLwYthuOLwNH1ShsE8Bh1+hydXD/2Y=
X-Received: by 2002:a17:903:2f4e:b0:2a1:388c:ca63 with SMTP id
 d9443c01a7336-2a3ee48ab8bmr70727175ad.31.1767905629684; Thu, 08 Jan 2026
 12:53:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1767621882.git.lucien.xin@gmail.com> <1e642f7c65ec53934bb05f95c5cf206648c7de9f.1767621882.git.lucien.xin@gmail.com>
 <5cb27e9f-ec01-4b50-b22c-dc8b027827bc@redhat.com> <CADvbK_eXRpT8n1B7p2-1T6eAZZ=4p7gQgJtMGBBQrHa036nyxw@mail.gmail.com>
In-Reply-To: <CADvbK_eXRpT8n1B7p2-1T6eAZZ=4p7gQgJtMGBBQrHa036nyxw@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 8 Jan 2026 15:53:38 -0500
X-Gm-Features: AQt7F2prUwiesd57XIG5R5Kpud_5P3QAJ44UiznNwVa7X7NXC1X7eS6-WB_wefg
Message-ID: <CADvbK_dEbOvdaMB4jGkaQMO7j0CnnpYUYJXmS-eKxmURybG09w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 06/16] quic: add stream management
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 3:29=E2=80=AFPM Xin Long <lucien.xin@gmail.com> wrot=
e:
>
> On Thu, Jan 8, 2026 at 10:36=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 1/5/26 3:04 PM, Xin Long wrote:
> > > +/* Create and register new streams for sending or receiving. */
> > > +static struct quic_stream *quic_stream_create(struct quic_stream_tab=
le *streams,
> > > +                                           s64 max_stream_id, bool s=
end, bool is_serv)
> > > +{
> > > +     struct quic_stream_limits *limits =3D &streams->send;
> > > +     struct quic_stream *stream =3D NULL;
> > > +     gfp_t gfp =3D GFP_KERNEL_ACCOUNT;
> > > +     s64 stream_id;
> > > +
> > > +     if (!send) {
> > > +             limits =3D &streams->recv;
> > > +             gfp =3D GFP_ATOMIC | __GFP_ACCOUNT;
> > > +     }
> > > +     stream_id =3D limits->next_bidi_stream_id;
> > > +     if (quic_stream_id_uni(max_stream_id))
> > > +             stream_id =3D limits->next_uni_stream_id;
> > > +
> > > +     /* rfc9000#section-2.1: A stream ID that is used out of order r=
esults in all streams
> > > +      * of that type with lower-numbered stream IDs also being opene=
d.
> > > +      */
> > > +     while (stream_id <=3D max_stream_id) {
> > > +             stream =3D kzalloc(sizeof(*stream), gfp);
> > > +             if (!stream)
> > > +                     return NULL;
> >
> > Do you need to release the allocated ids in case of failure? It would b=
e
> > sourprising to find some ids allocated when this call fails/returns NUL=
L.
> I was aware of this, but didn't change it. As the streams are always open=
ed
> sequentially, I think it's fine just to leave them without causing proble=
ms
> when users assume these streams are not yet open.
>
> >
> > > +
> > > +             stream->id =3D stream_id;
> > > +             if (quic_stream_id_uni(stream_id)) {
> > > +                     if (send) {
> > > +                             stream->send.max_bytes =3D limits->max_=
stream_data_uni;
> > > +                     } else {
> > > +                             stream->recv.max_bytes =3D limits->max_=
stream_data_uni;
> > > +                             stream->recv.window =3D stream->recv.ma=
x_bytes;
> > > +                     }
> > > +                     /* Streams must be opened sequentially. Update =
the next stream ID so the
> > > +                      * correct starting point is known if an out-of=
-order open is requested.
> > > +                      */
> > > +                     limits->next_uni_stream_id =3D stream_id + QUIC=
_STREAM_ID_STEP;
> > > +                     limits->streams_uni++;
> > > +
> > > +                     quic_stream_add(streams, stream);
> > > +                     stream_id +=3D QUIC_STREAM_ID_STEP;
> > > +                     continue;
> > > +             }
> > > +
> > > +             if (quic_stream_id_local(stream_id, is_serv)) {
> > > +                     stream->send.max_bytes =3D streams->send.max_st=
ream_data_bidi_remote;
> > > +                     stream->recv.max_bytes =3D streams->recv.max_st=
ream_data_bidi_local;
> > > +             } else {
> > > +                     stream->send.max_bytes =3D streams->send.max_st=
ream_data_bidi_local;
> > > +                     stream->recv.max_bytes =3D streams->recv.max_st=
ream_data_bidi_remote;
> > > +             }
> > > +             stream->recv.window =3D stream->recv.max_bytes;
> > > +
> > > +             limits->next_bidi_stream_id =3D stream_id + QUIC_STREAM=
_ID_STEP;
> > > +             limits->streams_bidi++;
> > > +
> > > +             quic_stream_add(streams, stream);
> > > +             stream_id +=3D QUIC_STREAM_ID_STEP;
> > > +     }
> > > +     return stream;
> > > +}
> > > +
> > > +/* Check if a send or receive stream ID is already closed. */
> > > +static bool quic_stream_id_closed(struct quic_stream_table *streams,=
 s64 stream_id, bool send)
> > > +{
> > > +     struct quic_stream_limits *limits =3D send ? &streams->send : &=
streams->recv;
> > > +
> > > +     if (quic_stream_id_uni(stream_id))
> > > +             return stream_id < limits->next_uni_stream_id;
> > > +     return stream_id < limits->next_bidi_stream_id;
> >
> > I can't recall if I mentioned the following in a past review... it look=
s
> > like the above assumes wrap around are not possible, which is realistic
> > given the u64 counters - it would require > 100y on a server allocating
> > 4G ids per second.
> >
> > But it would be nice to explcitly document such assumption somewhere.
> >
> How about I add a simple comment in quic_stream_create() right above
> the next_uni_stream_id/streams_uni increases, like
>
> "Note overflow of next_uni_stream_id/streams_uni is impossible with u64."
>
> > > +}
> > > +
> > > +/* Check if a stream ID would exceed local (recv) or peer (send) lim=
its. */
> > > +bool quic_stream_id_exceeds(struct quic_stream_table *streams, s64 s=
tream_id, bool send)
> > > +{
> > > +     u64 nstreams;
> > > +
> > > +     if (!send) {
> > > +             if (quic_stream_id_uni(stream_id))
> > > +                     return stream_id > streams->recv.max_uni_stream=
_id;
> > > +             return stream_id > streams->recv.max_bidi_stream_id;
> > > +     }
> > > +
> > > +     if (quic_stream_id_uni(stream_id)) {
> > > +             if (stream_id > streams->send.max_uni_stream_id)
> > > +                     return true;
> > > +             stream_id -=3D streams->send.next_uni_stream_id;
> > > +             nstreams =3D quic_stream_id_to_streams(stream_id);
> >
> > It's not clear to me why send streams only have this additional check.
> This is a good question.
>
> For recv.max_uni_stream_id, it changes based on next_uni/bidi_stream_id,
> max_streams_uni/bidi and streams_uni/bidi in quic_stream_max_streams_upda=
te(),
> there's no need to check them again. (maybe I should leave a comment here=
)
>
> But for send.max_uni_stream_id, it was updated simply from the peer's upd=
ated
> recv.max_uni_stream_id announcement, it must check its local counts and
> limits as well.
>
> >
> > > +             return nstreams + streams->send.streams_uni > streams->=
send./;
> >
> > Possibly it would be more consistent
> >
> > max_uni_stream_id -> max_stream_ids_uni
> >
> > (no strong preferences)
> I actually got the variable name from
> https://datatracker.ietf.org/doc/html/rfc9000.
>
Sorry, I may misunderstand here. from the variable names:
- max_uni_stream_id: is a stream_id
- max_stream_ids_uni: should be a stream_id counter.

max_uni_stream_id =3D quic_stream_id_to_streams(max_stream_ids_uni);
max_stream_ids_uni =3D quic_stream_streams_to_id(max_uni_stream_id)

I used max_uni_stream_id, as in most places it's used to check against
stream_id.

Thanks.

> >
> > > +     }
> > > +
> > > +     if (stream_id > streams->send.max_bidi_stream_id)
> > > +             return true;
> > > +     stream_id -=3D streams->send.next_bidi_stream_id;
> > > +     nstreams =3D quic_stream_id_to_streams(stream_id);
> > > +     return nstreams + streams->send.streams_bidi > streams->send.ma=
x_streams_bidi;
> > > +}
> >
> > [...]
> > > +/* Get or create a receive stream by ID. Requires sock lock held. */
> > > +struct quic_stream *quic_stream_recv_get(struct quic_stream_table *s=
treams, s64 stream_id,
> > > +                                      bool is_serv)
> > > +{
> > > +     struct quic_stream *stream;
> > > +
> > > +     if (!quic_stream_id_valid(stream_id, is_serv, false))
> > > +             return ERR_PTR(-EINVAL);
> > > +
> > > +     stream =3D quic_stream_find(streams, stream_id);
> > > +     if (stream)
> > > +             return stream;
> > > +
> > > +     if (quic_stream_id_local(stream_id, is_serv)) {
> > > +             if (quic_stream_id_closed(streams, stream_id, true))
> > > +                     return ERR_PTR(-ENOSTR);
> > > +             return ERR_PTR(-EINVAL);
> > > +     }
> > > +
> > > +     if (quic_stream_id_closed(streams, stream_id, false))
> > > +             return ERR_PTR(-ENOSTR);
> > > +
> > > +     if (quic_stream_id_exceeds(streams, stream_id, false))
> > > +             return ERR_PTR(-EAGAIN);
> > > +
> > > +     stream =3D quic_stream_create(streams, stream_id, false, is_ser=
v);
> > > +     if (!stream)
> > > +             return ERR_PTR(-ENOSTR);
> > > +     if (quic_stream_id_valid(stream_id, is_serv, true))
> > > +             streams->send.active_stream_id =3D stream_id;
> >
> > This function is really similar to quic_stream_send_get(), I think it
> > should be easy factor out a common helper (and possibly use directly
> > such helper with no send/recv wrapper).
> >
> I will factor out a common helper quic_stream_get() but keep
> quic_stream_send_get/put() as:
>
> struct quic_stream *quic_stream_send_get(...)
> {
>         return quic_stream_get(streams, stream_id, is_serv, true);
> }
>
> struct quic_stream *quic_stream_recv_get(...)
> {
>         return quic_stream_get(streams, stream_id, is_serv, false);
> }
>
> Thanks.

