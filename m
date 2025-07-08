Return-Path: <netdev+bounces-204939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E4DAFC9BB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4285563027
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022F226CE02;
	Tue,  8 Jul 2025 11:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wB/hZ+tB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3BB2686A0
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 11:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751974734; cv=none; b=SZLPh7ylgLCLJZ+aAzy5L3YtErnk9uydev0xahJzjUa8GLPWSdmsj9BXfVJkjaVJ5KTSVLxaTwkJUr8WE5nza1K9dOrxeRUU8LLRGJVpu0PBEtyFi9oGRSM/lx2f+YBQnEWHfNGEqm34WYuVNto6d7XXCmxDGHSyCe2kYfEE090=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751974734; c=relaxed/simple;
	bh=5ER9zYNW2UKCXYROFqoF154/uJ6q6q4eERaYtZYzcyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7FK4+xPegp/rfxVaWpN2r8gA3TxjB+JGQgaNXGMdCKEwQjCpzbgtAbje4qLP6MBQI3O6k5axbKn+dIUa5LtgoBmIm7cNLPBOhp3UZBdWDmo/HK8dydvsHwJ9Lva31alSdzoxBanEWPuo4gLa6QoFt0FSLKiiIM9BH/URzo9yIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wB/hZ+tB; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4a5903bceffso61363101cf.3
        for <netdev@vger.kernel.org>; Tue, 08 Jul 2025 04:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751974732; x=1752579532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dbqpd+L4+7YqepHpvtcTkrrvNOjstJB1TsRI43MZYyY=;
        b=wB/hZ+tBDPaqpLOVisvH0/H8JJdi8r/dJu3y7e7/Fd9KVODp91n3AvFoyxVCuDpzXn
         FwEnMaZBXSS1EONTex7WZCLJurktyOf4L9PnqcoCkJZ0fyoHYdPZeSV4Orb02CvwLVBD
         i7ftz4rEfVwPO4bYy0ZyN7pgZRujkatVHQ01DZm1JXzavlVi61ppw2T1H0njSeIu1/Hh
         rfRV81qIC9a8yeTVFdxOIRnN4vZUYfEo539ET5e4cKS86OXxQooqfojE+yiVZukGrgm6
         pv7ojne9+wds22TcHmnUwOcS8D6QfAtJXHLKl3iDCBZ2oWTzRTwmomHE41sqqVyUCK5v
         Q+lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751974732; x=1752579532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dbqpd+L4+7YqepHpvtcTkrrvNOjstJB1TsRI43MZYyY=;
        b=cAyiRKl8qSaig0lnJ7u/qTowctr25KLX3MgtKjxQ9Mrrt1fVkAEfgkF6MolfJ5h+zt
         GaTBEufc7FqQnu37CwTBy3OQzYfVpGpeR6s182SZWdMKX5wy+EYpsm5Fgk/yhj3BcA1B
         zouUaQr+GLMhZmcEONH5bi5hczxPURXbpvj4F5GkEn7a3r6DUG5Vt8whBDqw0MfSWb45
         +1nCH8R6o9/If/tly4dhrmV0hJkzYBJu4s9rPw4voRKctpvGqf311FBzsKxi3vYSw+CW
         YXPL851fld8hiOUfKSnpPKWB4juE2uZP5+PPvYfnxT3g67U3+JKIYnTDu9je2nd185x4
         LwFQ==
X-Gm-Message-State: AOJu0YwgE58TZFNJ8a9jfVbsI3zsRLbH9JaOfRBXU2S8XVIdtDTvffw7
	7rhzgs60FGUtkIN9F97P2/qCe8NUBOwTMkCpkVLnwtzuM+nVv+C3AvBEkTkQ+Bjw5VkcrlF2vVW
	iALRlGk7BRAeYxyI5gMVXUhC91NTAJ1w3R6kV6DJv
X-Gm-Gg: ASbGncske7vZ8JA9eEnP8CdSoyUwxoCSSchSC7GqmbC0VvbfcVjBc6RKR4qGhHukrwQ
	QyvjJ9W5GdowV+qRHR4RgImx+pQ1iXLj4Gpgf1yA1tVqKlDLv333KFnKwYuhoDejxRlfLj9retx
	rUu/e5B1B3fEHBXuR+RTt51+rmKTfBv2VeBoY5ZhtbGiI=
X-Google-Smtp-Source: AGHT+IF5ho9wCdHBsKlye9uP8O/f0tIadxuYMth1b+P3TQSZ0xGCLf538vdALp3A1ISlxHOn7Y2h5SXy5HT+TQdNpU0=
X-Received: by 2002:ac8:5d16:0:b0:4a9:8685:1e92 with SMTP id
 d75a77b69052e-4a9cd7b1b81mr42829581cf.34.1751974731409; Tue, 08 Jul 2025
 04:38:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703-connect-port-search-harder-v2-1-d51bce6bd0a6@cloudflare.com>
In-Reply-To: <20250703-connect-port-search-harder-v2-1-d51bce6bd0a6@cloudflare.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 8 Jul 2025 04:38:39 -0700
X-Gm-Features: Ac12FXyGNzQoqocstXqXm26qQeHz8R2_ZzAM77wKOU_KdWydIsLULdj6FB7P-8U
Message-ID: <CANn89iLm_hRW3+MHsP8p5aTUStohz0nvWbKTGZU6K3EdRadrYw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] tcp: Consider every port when connecting
 with IP_LOCAL_PORT_RANGE
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, kernel-team@cloudflare.com, 
	Lee Valentine <lvalentine@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 8:59=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.com=
> wrote:
>
> Situation
> ---------
>
> We observe the following scenario in production:
>
>                                                   inet_bind_bucket
>                                                 state for port 54321
>                                                 --------------------
>
>                                                 (bucket doesn't exist)
>
> // Process A opens a long-lived connection:
> s1 =3D socket(AF_INET, SOCK_STREAM)
> s1.setsockopt(IP_BIND_ADDRESS_NO_PORT)
> s1.setsockopt(IP_LOCAL_PORT_RANGE, 54000..54500)
> s1.bind(192.0.2.10, 0)
> s1.connect(192.51.100.1, 443)
>                                                 tb->reuse =3D -1
>                                                 tb->reuseport =3D -1
> s1.getsockname() -> 192.0.2.10:54321
> s1.send()
> s1.recv()
> // ... s1 stays open.
>
> // Process B opens a short-lived connection:
> s2 =3D socket(AF_INET, SOCK_STREAM)
> s2.setsockopt(SO_REUSEADDR)
> s2.bind(192.0.2.20, 0)
>                                                 tb->reuse =3D 0
>                                                 tb->reuseport =3D 0
> s2.connect(192.51.100.2, 53)
> s2.getsockname() -> 192.0.2.20:54321
> s2.send()
> s2.recv()
> s2.close()
>
>                                                 // bucket remains in this
>                                                 // state even though port
>                                                 // was released by s2
>                                                 tb->reuse =3D 0
>                                                 tb->reuseport =3D 0
>
> // Process A attempts to open another connection
> // when there is connection pressure from
> // 192.0.2.30:54000..54500 to 192.51.100.1:443.
> // Assume only port 54321 is still available.
>
> s3 =3D socket(AF_INET, SOCK_STREAM)
> s3.setsockopt(IP_BIND_ADDRESS_NO_PORT)
> s3.setsockopt(IP_LOCAL_PORT_RANGE, 54000..54500)
> s3.bind(192.0.2.30, 0)
> s3.connect(192.51.100.1, 443) -> EADDRNOTAVAIL (99)
>
> Problem
> -------
>
> We end up in a state where Process A can't reuse ephemeral port 54321 for
> as long as there are sockets, like s1, that keep the bind bucket alive. T=
he
> bucket does not return to "reusable" state even when all sockets which
> blocked it from reuse, like s2, are gone.
>
> The ephemeral port becomes available for use again only after all sockets
> bound to it are gone and the bind bucket is destroyed.
>
> Programs which behave like Process B in this scenario - that is, binding =
to
> an IP address without setting IP_BIND_ADDRESS_NO_PORT - might be consider=
ed
> poorly written. However, the reality is that such implementation is not
> actually uncommon. Trying to fix each and every such program is like
> playing whack-a-mole.
>
> For instance, it could be any software using Golang's net.Dialer with
> LocalAddr provided:
>
>         dialer :=3D &net.Dialer{
>                 LocalAddr: &net.TCPAddr{IP: srcIP},
>         }
>         conn, err :=3D dialer.Dial("tcp4", dialTarget)
>
> Or even a ubiquitous tool like dig when using a specific local address:
>
>         $ dig -b 127.1.1.1 +tcp +short example.com
>
> Hence, we are proposing a systematic fix in the network stack itself.
>
> Solution
> --------
>
> If there is no IP address conflict with any socket bound to a given local
> port, then from the protocol's perspective, the port can be safely shared=
.
>
> With that in mind, modify the port search during connect(), that is
> __inet_hash_connect, to consider all bind buckets (ports) when looking fo=
r
> a local port for egress.
>
> To achieve this, add an extra walk over bhash2 buckets for the port to
> check for IP conflicts. The additional walk is not free, so perform it on=
ly
> once per port - during the second phase of conflict checking, when the
> bhash bucket is locked.
>
> We enable this changed behavior only if the IP_LOCAL_PORT_RANGE socket
> option is set. The rationale is that users are likely to care about using
> every possible local port only when they have deliberately constrained th=
e
> ephemeral port range.
>
> Limitations
> -----------
>
> Sharing both the local IP and port with other established sockets, when t=
he
> remote address is unique is still not possible if the bucket is in
> non-reusable state (tb->{fastreuse,fastreuseport} >=3D 0) because of a so=
cket
> explicitly bound to that port.
>
> Alternatives
> ------------
>
> * Update bind bucket state on port release
>
> A valid solution to the described problem would also be to walk the bind
> bucket owners when releasing the port and recalculate the
> tb->{reuse,reuseport} state.
>
> However, in comparison to the proposed solution, this alone would not all=
ow
> sharing the local port with other sockets bound to non-conflicting IPs fo=
r
> as long as they exist.
>
> Another downside is that we'd pay the extra cost on each unbind (more
> frequent) rather than only when connecting with IP_LOCAL_PORT_RANGE
> set (less frequent). Due to that we would also likely need to guard it
> behind a sysctl (see below).
>
> * Run your service in a dedicated netns
>
> This would also solve the problem. While we don't rule out transitioning =
to
> this setup in the future at a cost of shifting the complexity elsewhere.
>
> Isolating your service in a netns requires assigning it dedicated IPs for
> egress. If the egress IPs must be shared with other processes, as in our
> case, then SNAT and connection tracking on egress are required - adding
> complexity.
>
> * Guard it behind a sysctl setting instead of a socket option
>
> Users are unlikely to encounter this problem unless their workload connec=
ts
> from a severely narrowed-down ephemeral port range. Hence, paying the bin=
d
> bucket walk cost for each connect() call doesn't seem sensible. Whereas
> with a socket option, only a limited set of connections incur the
> performance overhead.
>
> Reported-by: Lee Valentine <lvalentine@cloudflare.com>
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
> To: Eric Dumazet <edumazet@google.com>
> To: Paolo Abeni <pabeni@redhat.com>
> To: David S. Miller <davem@davemloft.net>
> To: Jakub Kicinski <kuba@kernel.org>
> To: Neal Cardwell <ncardwell@google.com>
> To: Kuniyuki Iwashima <kuniyu@google.com>
> Cc: netdev@vger.kernel.org
> Cc: kernel-team@cloudflare.com
> ---
> Changes in v2:
> - Fix unused var warning when CONFIG_IPV6=3Dn
> - Convert INADDR_ANY to network byte order before comparison
> - Link to v1: https://lore.kernel.org/r/20250626120247.1255223-1-jakub@cl=
oudflare.com
> ---
>  net/ipv4/inet_hashtables.c | 46 ++++++++++++++++++++++++++++++++++++++++=
++++--
>  1 file changed, 44 insertions(+), 2 deletions(-)
>
> diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
> index ceeeec9b7290..b4c4caf3ff6c 100644
> --- a/net/ipv4/inet_hashtables.c
> +++ b/net/ipv4/inet_hashtables.c
> @@ -1005,6 +1005,43 @@ EXPORT_IPV6_MOD(inet_bhash2_reset_saddr);
>  #define INET_TABLE_PERTURB_SIZE (1 << CONFIG_INET_TABLE_PERTURB_ORDER)
>  static u32 *table_perturb;
>
> +/* True on source address conflict with another socket. False otherwise.
> + * Caller must hold hashbucket lock for this tb.
> + */
> +static inline bool check_bound(const struct sock *sk,
> +                              const struct inet_bind_bucket *tb)
> +{
> +       const struct inet_bind2_bucket *tb2;
> +
> +       hlist_for_each_entry(tb2, &tb->bhash2, bhash_node) {
> +#if IS_ENABLED(CONFIG_IPV6)
> +               const struct sock *sk2;
> +
> +               if (sk->sk_family =3D=3D AF_INET6) {
> +                       if (tb2->addr_type =3D=3D IPV6_ADDR_ANY ||
> +                           ipv6_addr_equal(&tb2->v6_rcv_saddr,
> +                                           &sk->sk_v6_rcv_saddr))
> +                               return true;
> +                       continue;
> +               }
> +
> +               /* Check for ipv6 non-v6only wildcard sockets */
> +               if (tb2->addr_type =3D=3D IPV6_ADDR_ANY)
> +                       sk_for_each_bound(sk2, &tb2->owners)
> +                               if (!sk2->sk_ipv6only)
> +                                       return true;
> +
> +               if (tb2->addr_type !=3D IPV6_ADDR_MAPPED)
> +                       continue;
> +#endif
> +               if (tb2->rcv_saddr =3D=3D htonl(INADDR_ANY) ||
> +                   tb2->rcv_saddr =3D=3D sk->sk_rcv_saddr)
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
>  int __inet_hash_connect(struct inet_timewait_death_row *death_row,
>                 struct sock *sk, u64 port_offset,
>                 u32 hash_port0,
> @@ -1070,6 +1107,8 @@ int __inet_hash_connect(struct inet_timewait_death_=
row *death_row,
>                         if (!inet_bind_bucket_match(tb, net, port, l3mdev=
))
>                                 continue;
>                         if (tb->fastreuse >=3D 0 || tb->fastreuseport >=
=3D 0) {
> +                               if (unlikely(local_ports))
> +                                       break; /* optimistic assumption *=
/

I find this quite pessimistic :/

It seems you had some internal code before my recent change (86c2bc293b8130
"tcp: use RCU lookup in __inet_hash_connect()") ?

Instead, make the RCU changes so that check_bound() can be called from RCU,
and call it here before taking the decision to break off this loop.

>                                 rcu_read_unlock();
>                                 goto next_port;
>                         }
> @@ -1088,9 +1127,12 @@ int __inet_hash_connect(struct inet_timewait_death=
_row *death_row,
>                  */
>                 inet_bind_bucket_for_each(tb, &head->chain) {
>                         if (inet_bind_bucket_match(tb, net, port, l3mdev)=
) {
> -                               if (tb->fastreuse >=3D 0 ||
> -                                   tb->fastreuseport >=3D 0)
> +                               if (tb->fastreuse >=3D 0 || tb->fastreuse=
port >=3D 0) {
> +                                       if (unlikely(local_ports &&
> +                                                    !check_bound(sk, tb)=
))
> +                                               goto ok;
>                                         goto next_port_unlock;
> +                               }
>                                 WARN_ON(hlist_empty(&tb->bhash2));
>                                 if (!check_established(death_row, sk,
>                                                        port, &tw, false,
>
> --
> 2.43.0
>

