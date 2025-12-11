Return-Path: <netdev+bounces-244396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E164DCB63CD
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 15:45:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 332EB301E912
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 14:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3957528727B;
	Thu, 11 Dec 2025 14:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BlVLteqZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C1285C89
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 14:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765464254; cv=none; b=Y63Wt+j8ThvOQz2Clx5k6rHHTfIQAWY930E5YHcn+NhxHJyymI9kYoVLevL5slRlMVnQdZeEeqfm+qTQ1w0a9mSfFlJXg4ivypIP9DgR6/PLhSmEvKRAiBTPiefZx3E+l6YvZjQyDNIzvy2T/6NzMjqOUvGx74I02gd+hVtaoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765464254; c=relaxed/simple;
	bh=HcERldN4lWho/JUPnC5sIgD6t5G2cLBp2BqazKe5Jrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V6s/U8flnkRw7j4DC8f6UFyQ1RCSwieWRXVQ0+Ahq+0B9KUGYZ2XfaZsSOsAVDeLfJegGTBaGzbW05mbSxkGOlf/RE7GnYmRAXSXgwaKyYM4BiDp+Du8ym2X7kQV/MusWPIHHJn56fm1C8gqVrC20n5zmlgn6Lu7XIFFHHQUlQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BlVLteqZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-29e93ab7ff5so2038985ad.3
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 06:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765464252; x=1766069052; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EtINVVL3vB+IyxNj9ffA7lSqV98wLbUBVSb7OBPZY6U=;
        b=BlVLteqZBeszJxirK6ZI+h+MyzDKWp8b/ReApVmyTZ93Lf2maGNpNHpTFgR0YTaW7r
         QF/lHih/l+fjsQVwqqr9jtYR8rlZWzKJi4bucxdO8Y9gjTOQEFHG10d4mqPFU26oPpv1
         IQxLMljhxvuhDOmF6S+Qn2+jg+mmCly+oIzTafpubI+vygdLSK1MWTayZU8aucZbr3XZ
         cEApzlFvaWdJ/UdDPlmn6yHNkLPIMj0DymYPvX+9Q8I7GEnGLhvTydSC5Herp46Pwh96
         58tEvDXsG+EPUFok+iEMdqgVlp67qwbQrh28byVbXPkft+ovH35dxhPZ40RO51kKS5VD
         ehcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765464252; x=1766069052;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EtINVVL3vB+IyxNj9ffA7lSqV98wLbUBVSb7OBPZY6U=;
        b=JlX9oQxmpsSNoLcjrOEnlnUa1TeGb3lDLDoCA5ECA4xWoKuskz8/23hdH8s8GUhBRk
         5R23Y1ZEKCenNuWkselDTjaTBMfstv7ongx0Adl51vb55tI51wM+2IeIYsHTEn3mP27+
         RqhDdcj6G/27V+jYTBT9bxrAf87SvKrdkDSXSSpyhCy+MVnbMktjxqOlQadQ+2X7geaO
         767ebsNTcfWqlfZ4pbCqHm/PpqtZF7PzMTc7c/1Im3TtAiRaYsS5FTw/pwZ6pli0njzS
         mg0bH2FJB6J8ldHwXI8p1+unhPAXadvjdy77CiNt5FJmze0i+1i5zEJekaU6fcAdauzX
         Z2vw==
X-Forwarded-Encrypted: i=1; AJvYcCWRJv4DswqlrwMc0RZ9y+HsRZBIDnONtyK/4jZCJhooK48aZ/Ubc5s4++jN0gZ9uAcYvJsOs0M=@vger.kernel.org
X-Gm-Message-State: AOJu0YznxoJJrXOXG1MnNqFlzmLHAEVcQj+lOaDkfjZXUytAGduuelp/
	Mwpgxc9dCl3B0K9S2xg09pt3Fd2sKE0rkz2tpLuGNmgVTps7EQocYiqlDY1X0YkkCqqxGu1Q8dz
	wqamymrHlKq9XvAG5hn/ZfHnRQuXuLflPcG2LgMk6emdB
X-Gm-Gg: AY/fxX7nCMxTIXXmc1fvM/ulwyYPElhjyEpw9eXE4p24DeGyNVfyj5kh0AVhZDF9ekd
	zllgmTBNdKG9cc6w0iLiebEVO1L3ObevUWX5/XW9S0OAPAoRjLm49fjf5nyYTOSpC9Xe+GlBgQT
	nkeL66K9wEL+cXbFvXZmgt/tXi3Co7LgpKRr3ZY0T+UfrN2mgQaazc2oIPOSeQYkOob+pJJcCwp
	uuMA/QmBo2y5ttgzGB/ghXf/U0/CVwFEXEvaH8YiojngtsELMP6r6wBkXPLt1Kv/vxXzqY=
X-Google-Smtp-Source: AGHT+IEmEFQlvbBlRShmDnefLZIZSx5DWO8WmdgzaULARHGEfaymct8sV/4h93v5RD8D4YSxFwM3CJl04SW4WB5B9eI=
X-Received: by 2002:a17:903:3205:b0:295:5625:7e41 with SMTP id
 d9443c01a7336-29ec2319bfdmr70617415ad.22.1765464251582; Thu, 11 Dec 2025
 06:44:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251211125104.375020-1-mlbnkm1@gmail.com> <20251211080251-mutt-send-email-mst@kernel.org>
 <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
In-Reply-To: <zlhixzduyindq24osaedkt2xnukmatwhugfkqmaugvor6wlcol@56jsodxn4rhi>
From: Melbin Mathew Antony <mlbnkm1@gmail.com>
Date: Thu, 11 Dec 2025 14:43:59 +0000
X-Gm-Features: AQt7F2pnwvtOPbnMcrHx8A-PKFVB-JfGrhIlVSiOwVGrW6Eib51aDnzbmR7nZ7M
Message-ID: <CAMKc4jDpMsk1TtSN-GPLM1M_qp_jpoE1XL1g5qXRUiB-M0BPgQ@mail.gmail.com>
Subject: Re: [PATCH net v3] vsock/virtio: cap TX credit to local buffer size
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, stefanha@redhat.com, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	eperezma@redhat.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stefano, Michael,

Thanks for the feedback and for pointing out the s64 issue in
virtio_transport_get_credit() and the vsock_test regression.

I can take this up and send a small series:

  1/2 =E2=80=93 vsock/virtio: cap TX credit to local buffer size
        - use a helper to bound peer_buf_alloc by buf_alloc
        - compute available credit in s64 like has_space(), and clamp
          negative values to zero before applying the caller=E2=80=99s cred=
it

  2/2 =E2=80=93 vsock/test: fix seqpacket message bounds test
        - include your vsock_test.c change so the seqpacket bounds test
          keeps working with the corrected TX credit handling

I=E2=80=99ll roll these into a [PATCH net v4 0/2] series and send it out sh=
ortly.

Thanks again for all the guidance,
Melbin


On Thu, Dec 11, 2025 at 1:57=E2=80=AFPM Stefano Garzarella <sgarzare@redhat=
.com> wrote:
>
> On Thu, Dec 11, 2025 at 08:05:11AM -0500, Michael S. Tsirkin wrote:
> >On Thu, Dec 11, 2025 at 01:51:04PM +0100, Melbin K Mathew wrote:
> >> The virtio vsock transport currently derives its TX credit directly fr=
om
> >> peer_buf_alloc, which is populated from the remote endpoint's
> >> SO_VM_SOCKETS_BUFFER_SIZE value.
> >>
> >> On the host side, this means the amount of data we are willing to queu=
e
> >> for a given connection is scaled purely by a peer-chosen value, rather
> >> than by the host's own vsock buffer configuration. A guest that
> >> advertises a very large buffer and reads slowly can cause the host to
> >> allocate a correspondingly large amount of sk_buff memory for that
> >> connection.
> >>
> >> In practice, a malicious guest can:
> >>
> >>   - set a large AF_VSOCK buffer size (e.g. 2 GiB) with
> >>     SO_VM_SOCKETS_BUFFER_MAX_SIZE / SO_VM_SOCKETS_BUFFER_SIZE, and
> >>
> >>   - open multiple connections to a host vsock service that sends data
> >>     while the guest drains slowly.
> >>
> >> On an unconstrained host this can drive Slab/SUnreclaim into the tens =
of
> >> GiB range, causing allocation failures and OOM kills in unrelated host
> >> processes while the offending VM remains running.
> >>
> >> On non-virtio transports and compatibility:
> >>
> >>   - VMCI uses the AF_VSOCK buffer knobs to size its queue pairs per
> >>     socket based on the local vsk->buffer_* values; the remote side
> >>     can=E2=80=99t enlarge those queues beyond what the local endpoint
> >>     configured.
> >>
> >>   - Hyper-V=E2=80=99s vsock transport uses fixed-size VMBus ring buffe=
rs and
> >>     an MTU bound; there is no peer-controlled credit field comparable
> >>     to peer_buf_alloc, and the remote endpoint can=E2=80=99t drive in-=
flight
> >>     kernel memory above those ring sizes.
> >>
> >>   - The loopback path reuses virtio_transport_common.c, so it
> >>     naturally follows the same semantics as the virtio transport.
> >>
> >> Make virtio-vsock consistent with that model by intersecting the peer=
=E2=80=99s
> >> advertised receive window with the local vsock buffer size when
> >> computing TX credit. We introduce a small helper and use it in
> >> virtio_transport_get_credit(), virtio_transport_has_space() and
> >> virtio_transport_seqpacket_enqueue(), so that:
> >>
> >>     effective_tx_window =3D min(peer_buf_alloc, buf_alloc)
> >>
> >> This prevents a remote endpoint from forcing us to queue more data tha=
n
> >> our own configuration allows, while preserving the existing credit
> >> semantics and keeping virtio-vsock compatible with the other transport=
s.
> >>
> >> On an unpatched Ubuntu 22.04 host (~64 GiB RAM), running a PoC with
> >> 32 guest vsock connections advertising 2 GiB each and reading slowly
> >> drove Slab/SUnreclaim from ~0.5 GiB to ~57 GiB and the system only
> >> recovered after killing the QEMU process.
> >>
> >> With this patch applied, rerunning the same PoC yields:
> >>
> >>   Before:
> >>     MemFree:        ~61.6 GiB
> >>     MemAvailable:   ~62.3 GiB
> >>     Slab:           ~142 MiB
> >>     SUnreclaim:     ~117 MiB
> >>
> >>   After 32 high-credit connections:
> >>     MemFree:        ~61.5 GiB
> >>     MemAvailable:   ~62.3 GiB
> >>     Slab:           ~178 MiB
> >>     SUnreclaim:     ~152 MiB
> >>
> >> i.e. only ~35 MiB increase in Slab/SUnreclaim, no host OOM, and the
> >> guest remains responsive.
> >>
> >> Fixes: 06a8fc78367d ("VSOCK: Introduce virtio_vsock_common.ko")
> >> Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
> >> Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
> >> ---
> >>  net/vmw_vsock/virtio_transport_common.c | 27 ++++++++++++++++++++++--=
-
> >>  1 file changed, 24 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/v=
irtio_transport_common.c
> >> index dcc8a1d58..02eeb96dd 100644
> >> --- a/net/vmw_vsock/virtio_transport_common.c
> >> +++ b/net/vmw_vsock/virtio_transport_common.c
> >> @@ -491,6 +491,25 @@ void virtio_transport_consume_skb_sent(struct sk_=
buff *skb, bool consume)
> >>  }
> >>  EXPORT_SYMBOL_GPL(virtio_transport_consume_skb_sent);
> >>
> >> +/* Return the effective peer buffer size for TX credit computation.
> >> + *
> >> + * The peer advertises its receive buffer via peer_buf_alloc, but we
> >> + * cap that to our local buf_alloc (derived from
> >> + * SO_VM_SOCKETS_BUFFER_SIZE and already clamped to buffer_max_size)
> >> + * so that a remote endpoint cannot force us to queue more data than
> >> + * our own configuration allows.
> >> + */
> >> +static u32 virtio_transport_tx_buf_alloc(struct virtio_vsock_sock *vv=
s)
> >> +{
> >> +    return min(vvs->peer_buf_alloc, vvs->buf_alloc);
> >> +}
> >> +
> >>  u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 cr=
edit)
> >>  {
> >>      u32 ret;
> >> @@ -499,7 +518,8 @@ u32 virtio_transport_get_credit(struct virtio_vsoc=
k_sock *vvs, u32 credit)
> >>              return 0;
> >>
> >>      spin_lock_bh(&vvs->tx_lock);
> >> -    ret =3D vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd_cnt);
> >> +    ret =3D virtio_transport_tx_buf_alloc(vvs) -
> >> +            (vvs->tx_cnt - vvs->peer_fwd_cnt);
> >>      if (ret > credit)
> >>              ret =3D credit;
> >>      vvs->tx_cnt +=3D ret;
> >> @@ -831,7 +851,7 @@ virtio_transport_seqpacket_enqueue(struct vsock_so=
ck *vsk,
> >>
> >>      spin_lock_bh(&vvs->tx_lock);
> >>
> >> -    if (len > vvs->peer_buf_alloc) {
> >> +    if (len > virtio_transport_tx_buf_alloc(vvs)) {
> >>              spin_unlock_bh(&vvs->tx_lock);
> >>              return -EMSGSIZE;
> >>      }
> >> @@ -882,7 +902,8 @@ static s64 virtio_transport_has_space(struct vsock=
_sock *vsk)
> >>      struct virtio_vsock_sock *vvs =3D vsk->trans;
> >>      s64 bytes;
> >>
> >> -    bytes =3D (s64)vvs->peer_buf_alloc - (vvs->tx_cnt - vvs->peer_fwd=
_cnt);
> >> +    bytes =3D (s64)virtio_transport_tx_buf_alloc(vvs) -
> >> +            (vvs->tx_cnt - vvs->peer_fwd_cnt);
> >>      if (bytes < 0)
> >>              bytes =3D 0;
> >>
> >
> >Acked-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >
> >Looking at this, why is one place casting to s64 the other is not?
>
> Yeah, I pointed out that too in previous interactions. IMO we should fix
> virtio_transport_get_credit() since the peer can reduce `peer_buf_alloc`
> so it will overflow. Fortunately, we are limited by the credit requested
> by the caller, but we are still sending stuff when we shouldn't be.
>
> @Melbin let me know if you will fix it, otherwise I can do that, but I'd
> like to do in a single series (multiple patches), since they depends on
> each other.
>
> So if you prefer, I can pickup this patch and post a series with this +
> the other fix + the fix on the test I posted on the v2.
>
> Stefano
>

