Return-Path: <netdev+bounces-254413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJX+DI1bemm35QEAu9opvQ
	(envelope-from <netdev+bounces-254413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:55:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 935A8A7F08
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 19:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D723032755
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2F736F439;
	Wed, 28 Jan 2026 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlfLRzuq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2515372B34
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 18:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769626462; cv=none; b=AJmnmweIvP5JHFOHFpnoueMZ0Yt2B2vgDAhF+EtnGpJmIHrypUxEJlSd9jWbLcR0xsMh5uzO5kWB4zhr/rxuy7WomJyoOPUNH1UYEWUqZww79J0o5VmUXR82hYBc/yimEUpMgudq5GcDHVFsUzVadDL4A0k2Z3pRDMuc8RwSZLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769626462; c=relaxed/simple;
	bh=pCugLepC5Fo9ZuTYtxKJgcQS6mTCH9EIr8vM/brU+9I=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PGOVtjIQCtsAgSMBSJhUGbR9CLS+WPo44Gxd5Vmur8IekrqTMDGpTw/tQuSuAQGJegRKSEgsEGwwfAnVWTTdhp5yi97qo3tg2NrK0S0Tel4s2dKZXZ2qzzoRt5twXElNNPGRsDL+Zgrq6c4adyB12b1JVrdmsu94Q4/xz3mfyig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WlfLRzuq; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7927b1620ddso3173157b3.0
        for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 10:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769626460; x=1770231260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KFnpsV2acec7TB8LSsKC707eTO+zFsXqs8A2slOzjIw=;
        b=WlfLRzuqc1chRDMCT48XMFEBTjHoHjtiBFzMIhnXr4pARMd02TtQs3O5D91FpTkzVN
         QaGgCFgEOqrOvsaZgV1ayoP5jSUl9CWTXH3XpbKsJRhfz8nQ7l5qI54nVhu2G64R+Rqi
         dyQoArlkw5lbgh6vCePkkY5XaGI+hbin3vVU0LkZjpi45a/fpmQlV0/VFCiSW4f2azqU
         mXfk89VTY5ELnJTJebNG8G7hFTPTF5Zrdrx4eW5ANqrmCMkJkHSyoZ0bNANQ//05iEwa
         KCjwtV3ipHeRbqO5L4biCPbrY1sazTli8AhGhzOvFamKc1+s7jGoLvOP/L0y+NZvEj/+
         6yWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769626460; x=1770231260;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFnpsV2acec7TB8LSsKC707eTO+zFsXqs8A2slOzjIw=;
        b=kCgbCeaPR1EyRpcOcp3hRcrrP6L6tzFKJRrnQBy6K2rembVGJO2kANE+T2cedRcqtu
         QJAyuHkyC808KDWK5OibyiTVnbdkHY9SHvpQR9m5J+X646SiunERtO0Lm3vngRs9F1p0
         5oX7uYqjSo9GXIFfwIxTYmvOoAQtiqPpjGGrAJei9ixRjpEeSs4ULUsVpPOQ//2BnOx3
         P6eqm4JtC1QsF/dTu5tJwgyphu6E4dKO2n14GyVto/8I9V8L6FmE37BFhtpS4VOxrnee
         C40rhTXFbfxbepIAmTjgTXM6QPD2h+aJqADPi0ZjXM1hBJ1wKpmWlMENbIeB5f2p/GMO
         sXnQ==
X-Gm-Message-State: AOJu0YzKvF1NwS3NRx12UMqaPXsGGZMFZKAX8NWxHu5DHyGipeoxJNq0
	h69f9zwNKDvCWp7kBxxemaZYZPwcA1mqQu6njoJj+G7o1vKEr2xxm6we
X-Gm-Gg: AZuq6aIIBpanZc6xsX7bslJ5HmDYimDqROaihZqyaR80jW367fK5iPdw0kIk6BJdXc2
	JksqBQjjJH1iqDEfFpdYHdOFVh9ikUiVk6O1G4Quc9NnqnCMXpWTsTACtgH0a197Q8+p7w/1o7U
	0K3wK45gb7XO2r0SP7tvV8eBL86Bjqjck5Jcn2n1L10y72FyTHi8hDZ/XAd82NkVxQrwT44OYEt
	kII8rIdVXBdeyCWeHn+YdpxtQ02h3hzKfHQUajOuTT4Ur+YONYQW+K7KD069kYPWWrv/VFyO7cO
	9hgWeE1+xNMJry9gNOjIN9+w2glCjCXU+zMVjfO261mqOu0gwm3nMEWbgVFrUhgso+q0cOvzesu
	RHToGXY6v55mtR63TocuyoeH/k1MhRsUpYIf5DVRRog7/6IkQrZ1rdZgjzqe6bUDEtZ+Sy6btzy
	KYQA0actS9lDG9Sw8spkQmHbnykRvag28oXRRYsxAC0rBHhtPpmQp6w7B+tY2eZzmF6evl3Q==
X-Received: by 2002:a05:690c:f84:b0:794:8ff6:e837 with SMTP id 00721157ae682-79490da998fmr3808117b3.26.1769626459828;
        Wed, 28 Jan 2026 10:54:19 -0800 (PST)
Received: from gmail.com (21.33.48.34.bc.googleusercontent.com. [34.48.33.21])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-7948278a0b9sm13878077b3.13.2026.01.28.10.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 10:54:18 -0800 (PST)
Date: Wed, 28 Jan 2026 13:54:18 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>, 
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 dsahern@kernel.org, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 kshitiz.bartariya@zohomail.in
Message-ID: <willemdebruijn.kernel.1d6503085031f@gmail.com>
In-Reply-To: <CA+KdSGO9KV-15mPYkMPmi0bovbGng_ogC=kGXUjWt3-hsQU_qA@mail.gmail.com>
References: <20260128070311.48892-1-mahdifrmx@gmail.com>
 <CANn89iKwmhmAOConHjNP7XxVLghaJJgU4gDSH+To8Q1V67Jv0Q@mail.gmail.com>
 <CA+KdSGPvcGrUGeMiguBZ_RcHQjXeik+DgqetWaGNW8aGK3LUZg@mail.gmail.com>
 <CANn89i+k+dB_9G+gvCpv+_8wWSxp71LxQTdbOZVm7LSugRK5+A@mail.gmail.com>
 <CA+KdSGO9KV-15mPYkMPmi0bovbGng_ogC=kGXUjWt3-hsQU_qA@mail.gmail.com>
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254413-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davemloft.net,kernel.org,redhat.com,zohomail.in];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 935A8A7F08
X-Rspamd-Action: no action

Mahdi Faramarzpour wrote:
> On Wed, Jan 28, 2026 at 4:07=E2=80=AFPM Eric Dumazet <edumazet@google.c=
om> wrote:
> >
> > On Wed, Jan 28, 2026 at 1:27=E2=80=AFPM Mahdi Faramarzpour <mahdifrmx=
@gmail.com> wrote:
> > >
> > > On Wed, Jan 28, 2026 at 3:14=E2=80=AFPM Eric Dumazet <edumazet@goog=
le.com> wrote:
> > > >
> > > > On Wed, Jan 28, 2026 at 8:03=E2=80=AFAM Mahdi Faramarzpour <mahdi=
frmx@gmail.com> wrote:
> > > > >
> > > > > This commit adds SNMP drop count increment for the packets in
> > > > > per NUMA queues which were introduced in commit b650bf0977d3
> > > > > ("udp: remove busylock and add per NUMA queues"). note that SNM=
P
> > > > > counters are incremented currently by the caller for skb. And
> > > > > that these skbs on the intermediate queue cannot be counted
> > > > > there so need similar logic in their error path.
> > > > >
> > > > > Signed-off-by: Mahdi Faramarzpour <mahdifrmx@gmail.com>
> > > > > ---
> > > > > v6:
> > > > >   - increasing a single counter based on socket family
> > > > > v5: https://lore.kernel.org/netdev/20260122185357.50922-1-mahdi=
frmx@gmail.com/
> > > > >   - check if drop counts are non-zero before increasing countre=
rs
> > > > > v4: https://lore.kernel.org/netdev/20260108102950.49417-1-mahdi=
frmx@gmail.com/
> > > > >   - move all changes to unlikely(to_drop) branch
> > > > > v3: https://lore.kernel.org/netdev/20260105114732.140719-1-mahd=
ifrmx@gmail.com/
> > > > >   - remove the unreachable UDP_MIB_RCVBUFERRORS code
> > > > > v2: https://lore.kernel.org/netdev/20260105071218.10785-1-mahdi=
frmx@gmail.com/
> > > > >   - change ENOMEM to ENOBUFS
> > > > > v1: https://lore.kernel.org/netdev/20260104105732.427691-1-mahd=
ifrmx@gmail.com/
> > > > > ---
> > > > >  net/ipv4/udp.c | 5 ++++-
> > > > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > > > > index ffe074cb5..dd302f5fb 100644
> > > > > --- a/net/ipv4/udp.c
> > > > > +++ b/net/ipv4/udp.c
> > > > > @@ -1797,10 +1797,13 @@ int __udp_enqueue_schedule_skb(struct s=
ock *sk, struct sk_buff *skb)
> > > > >                         skb =3D to_drop;
> > > > >                         to_drop =3D skb->next;
> > > > >                         skb_mark_not_on_list(skb);
> > > > > -                       /* TODO: update SNMP values. */
> > > > >                         sk_skb_reason_drop(sk, skb, SKB_DROP_RE=
ASON_PROTO_MEM);
> > > > >                 }
> > > > >                 numa_drop_add(&udp_sk(sk)->drop_counters, nb);
> > > > > +               SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family =3D=
=3D PF_INET)),
> > > > > +                              UDP_MIB_MEMERRORS, nb);
> > > > > +               SNMP_ADD_STATS(__UDPX_MIB(sk, (sk->sk_family =3D=
=3D PF_INET)),
> > > > > +                              UDP_MIB_INERRORS, nb);
> > > > >         }
> > > >
> > > > Hmm.. I have not followed your prior attempts, sorry for coming l=
ate.
> > > >
> > > > Note that an UDP AF_INET6 socket for which ipv6_only_sock(sk) is =
false
> > > > can receive
> > > > IPv4 and IPv6 UDP packets, if bound to any addresses.
> > > >
> > > > The to_drop list could contain a mix of IPv4 and IPv6 packets.
> > > >
> > > > Ideally we should track SNMP values in the proper space (Ipv4 , I=
Pv6).
> > > >
> > > > See IPV6_V6ONLY and /proc/sys/net/ipv6/bindv6only for reference.
> > > This is the exact discussion I had with Willem de Bruijn:
> > > https://lore.kernel.org/netdev/willemdebruijn.kernel.17f36003699cb@=
gmail.com/
> >
> > I think Willem was wrong :)
> >
> > __udp_enqueue_schedule_skb() is called either from
> > __udp_queue_rcv_skb() for IPv4 packets,
> > or __udpv6_queue_rcv_skb() for IPv6 packets, and they both can feed
> > packets to a single and shared UDP socket.
> >
> > An IPv4 packet will not go through __udpv6_queue_rcv_skb().

Happy to be wrong :) Thanks for the correction.

> >
> > It would be deceptive to increment IPV6 UDP counters if a host only
> > receives IPv4 UDP packets.
> Ok, in case other people wonder which logic is in fact true, refer to
> net/core/dev.c in which
> netif_receive_skb is defined that's called from device drivers. This
> routine checks the packet
> against a list of struct packet_types, ultimately finding the matched
> type and calling its
> registered func field, that are ip_rcv & ip6_rcv in case of the two
> ipv4 & ipv6 types. So, the
> appropriate routine is chosen based on packet type, not socket family.
> =

> That being said, I think the previous patch was just fine, unless
> Willem wants the newline
> after variable declarations:
> https://lore.kernel.org/netdev/20260122185357.50922-1-mahdifrmx@gmail.c=
om/


You'll have to resubmit anyway. Then please address the minor
stylistic point.


