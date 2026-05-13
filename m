Return-Path: <netdev+bounces-287671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B6lEcalBGogMQIAu9opvQ
	(envelope-from <netdev+bounces-287671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:24:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 966FE536FE4
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 18:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8C4CA313DCEC
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFBE46AF1A;
	Wed, 13 May 2026 15:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wpz6TKW5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaWzKrwd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5191D43E9CD
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778686791; cv=pass; b=qds8WPgN4gkqn93kR/MwuoG9Dl7gMHATBgpUNFg9uAhm0DpcM4tJ18re8AYSE+HurSmtxqFdyIsbSF+iAaPec0msuL+BJT1BhdeMCU8/QNk5KsplPKLQjF0EMYMkDrzNeBC+5Q5lRwJfIOx0ETuyEBTnN7Rj6er6XBncXSSvrfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778686791; c=relaxed/simple;
	bh=I6CRyv67nDUME5VvRLFuqsc58wOTMq7M6YaCgoHOEwE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y1Jm9ykUmhxJF/KabiRW5VA4v9EiypoAaALfAPsa5cySxGxGK+8xGix4boZ2SuNkvc/eRJkzFo9ShXGMGb2XpKyoIOuxdyNtMTsDdoRMF66wo7Ngy4L70DV5U3FDlWkpE+XK4KfBY7vcZ8uvURXcvdXJVA1WGqQ9ZPJegfcN42w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wpz6TKW5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaWzKrwd; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778686789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZmYjZclztoGUcmB8bgTN3A8z10j8cbJPBMIgLaq9Wck=;
	b=Wpz6TKW5c92MLIegUQzKAuoITmu3CaYxr1eMf1YVyzIzzSW2wicUumyR5IPKQckYBp96VJ
	kyLHECUiv3oMZYNSI+FVlGeimfZ5q3Ln7+32bY8jlBBJSk9lxQhOXpZ/uolLUXFanc9xC3
	tOWFWQ9g5RzJ5xv7DGjea4EqpIxt5co=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-W76_BvDSO56pjaavwKFNqA-1; Wed, 13 May 2026 11:39:48 -0400
X-MC-Unique: W76_BvDSO56pjaavwKFNqA-1
X-Mimecast-MFC-AGG-ID: W76_BvDSO56pjaavwKFNqA_1778686787
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bcfd21f71ddso295229766b.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 08:39:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778686787; cv=none;
        d=google.com; s=arc-20240605;
        b=OU+MXrR2bduGmubnuAvR2nUEkOnLvhoIEj7c8oE6RJSvF9Lzx8x++1AnoakeFEFduR
         s+uv6aR17I/K8VrMLnKFn17heTpoG4LCjeiWw/SQbOG4TBheWp5DpZZPOabHE3SFEzDU
         cbv6HJLi5jnS5yzQIM61+Kse4B+pO+O5WeQk6INNlQBi7+iHUuOf3D6ZtpVSOxR559Sr
         metViSY6+atQNGqcud/uOyptVFrLzsEP/Rfccs/xiRqniWYtH8FQ7Ffy52mtQ300uwXu
         ktQ7RgA+/LWkMyZxWKvZw/qzJSnU0VjyOoWkOqPUsW4mf3/DEM+D6YgUtOFUAZA+2vJt
         PThg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZmYjZclztoGUcmB8bgTN3A8z10j8cbJPBMIgLaq9Wck=;
        fh=Tmxz3a79UKdkumrKeS+Q+rDY27d+Mx6LCtVyAiXVNTI=;
        b=bPaUjmCD1PJuQE+5++oLoqvN7DePwDIESPG2pc7HapBjsA7ZwqCzsRRS1fLGzo9YTg
         WsaibPuebeWmht5BhiX+GnPDVc+6dthbPEzwlZjAK/9iwmLoUHl/co7mXVnpwL5hR7gT
         l8XV12SRyQfiQAz6c+NcTVcQA5omwx9C3MA+xRZBi13mwj5EEHJFaUUsuhTR308oF/ey
         JHafvt8/5C1jGbDYy7CLSuT9SR0m9JLH/Ryn8bq8JekcSrEBDadGmwuZqoL7gF8Ea8G7
         W2Mn8t/G3br9EgzIsRUOpEPIAL0cWrrzcleplSJSAtrE46MrqSgXYloJW6zhwmG5gddU
         hEKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778686787; x=1779291587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZmYjZclztoGUcmB8bgTN3A8z10j8cbJPBMIgLaq9Wck=;
        b=DaWzKrwdwmN4O8zrxXjTj4Dg8SsSSn1aYAzssJgeGHtBE9G33KH8/mpQkHkRgCPpY2
         3iQQrkqdzhi8295xlJrBEK8Yw4SavS4ACGCHa/amTJnfVAzgkxSS1gj8kQNW/quzqAdG
         wYLCnlMlEY1H/JQ6jadOtWQ9o9FgO1cKNM/rJgCbk/PyAFeO95762ZcRnegzCUyB6CdC
         V8Tm3d1lyXWm17nEzz8D0um24TEN36vAER9UnwGZVdqL8KuI8852dcqUYmEvL2759nRk
         TCQ3ZWq4nknAef0BzQZ1FeIrBvV7FXB1ahQJ9Z/6r5jbg52lNoJs0PfX9IPF9U7uLH2e
         w+6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778686787; x=1779291587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZmYjZclztoGUcmB8bgTN3A8z10j8cbJPBMIgLaq9Wck=;
        b=haM6E/UvA67/QfMGqyBWzUhff+4W6COjgWGd9d6/QOc2VK3bWfxn+D2IOcqOJHovKw
         jn8JQ4NQM3UFekVKOTynojRwkkD2UO7PpnqPMMceGQA1CKBmO8akiqv94VRsaKcUR66T
         UbZ3PI0tClUegZUO9gp8N3OioJymj5MeEExM+D8X/Cyh4Nuyr5L1Ww+uw2Zw/OX3H4i3
         tZ461/MhUteyf5T5ZixMrR/FU33VJHTSHgKDQLXaj51t2ndvu7RKizZVAyQVQuoGZmkW
         2Zvioed37Q+dhI7Sw5NmTIHnoGwy8sp63Spl5kfqelXLzC3lXOQ1j6TwENNkbQ0nqnxB
         BqeQ==
X-Forwarded-Encrypted: i=1; AFNElJ+80lte4Q7nEAKfwOUX77mlYABCNaaKDWCEvK194u67MN0BTS1pR4rJ+SJqgbWWaQ1682tt79Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1KoBOwn9ff5c9Tkls84iCcSEtVFyKADMOr+slfXTZS8Hbrnmw
	a6/c/CHRNP4HMXSxOfAx/GPwjB+Ca+dOm2HOAwDrB4Lgd2Wd1kw8h5UgKPEMh5avr2guy9uRpsz
	gUHKzTkIaswPdGnnuy+Eu4FuKz+Tb/0RPCYmKQpeG71oFShmX72aSwJkd/4yRD0sv9ypt2KqrV6
	SqZtZ/0GqUK9w6IE/SAKC3KyYa8Rq5k78l
X-Gm-Gg: Acq92OFcAqm/V5Fho1CTOLZ6ljj1Uyye6Uk6udvrr6FaJr2MC7BGb9WQpPZkIL9ypqC
	/waFxA1SrO+JwoY6Q3LuKYywRMAo3ctjACp0Pg8JYij9kZrFvooItYqRdHNki4z6r42IsP+1c8s
	mIzLgfMXo/BcVk+cDtMfLqnJ5KYKphVhrGAja9eubCmkoCucbiZd0dzwKfMNLqCMtunZAQOr2+t
	yS3iZrMOgyrIFA4PUbzUv0oRgAEgmN22hDLo5PORtH0D7+K42iRCKp2n28umVxObc87bc4avZSH
	zUaghSsqpYDPTz6QmXW7Yys=
X-Received: by 2002:a17:906:730a:b0:bab:b930:474d with SMTP id a640c23a62f3a-bd3dfb5e659mr240249366b.1.1778686786789;
        Wed, 13 May 2026 08:39:46 -0700 (PDT)
X-Received: by 2002:a17:906:730a:b0:bab:b930:474d with SMTP id
 a640c23a62f3a-bd3dfb5e659mr240245466b.1.1778686786238; Wed, 13 May 2026
 08:39:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511184338.392420-1-rrobaina@redhat.com> <9802a1edc2f809440603350047f202e3@paul-moore.com>
In-Reply-To: <9802a1edc2f809440603350047f202e3@paul-moore.com>
From: Ricardo Robaina <rrobaina@redhat.com>
Date: Wed, 13 May 2026 12:39:34 -0300
X-Gm-Features: AVHnY4LvvCa0_cKymVrIA8eBbpHhIGvAvi3Lc-Gh0oHKmJHppjzn0OwWfWOkiZ0
Message-ID: <CAABTaaAPx62gWTwMAa-O6bKXihv6eDHQFQq7D2=vrNhAO5gLrg@mail.gmail.com>
Subject: Re: [PATCH] netlink, audit: prevent false ENOBUFS on timeout expiry
To: Paul Moore <paul@paul-moore.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, eparis@redhat.com, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 966FE536FE4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287671-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rrobaina@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,paul-moore.com:email,paul-moore.com:url]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 4:35=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On May 11, 2026 Ricardo Robaina <rrobaina@redhat.com> wrote:
> >
> > When auditd is bottlenecked (e.g., by slow disk I/O), kauditd blocks on
> > the netlink socket. If the wait timeout fully expires (timeo =3D=3D 0),
> > netlink mistakenly interprets the zeroed timeout as a non-blocking
> > request. It then triggers netlink_overrun that drops the event,
> > completely bypassing the audit subsystem's internal retry queue, and
> > falsely returns ENOBUFS to user-space, resulting in the following error=
:
> >
> >  auditd[]: Error receiving audit netlink packet (No buffer space availa=
ble)
> >
> > Convert the `nonblock` argument in netlink_unicast() into a `flags`
> > bitmask and introduce NETLINK_UNICAST_TIMED. When a caller specifies
> > this flag and exhausts its timeout budget, netlink intercepts the
> > zeroed timeo state. Instead of defaulting to an overrun condition, it
> > safely frees the skb and returns -EAGAIN, allowing the audit subsystem
> > to gracefully enqueue the pending event into its internal backlog.
> >
> > Suggested-by: Steve Grubb <sgrubb@redhat.com>
> > Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> > ---
> >  include/linux/netlink.h  |  5 ++++-
> >  kernel/audit.c           |  8 ++++----
> >  net/netlink/af_netlink.c | 17 +++++++++++++++--
> >  3 files changed, 23 insertions(+), 7 deletions(-)
> >
> > diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> > index 882e9c1b6c1d..1888c8ee416a 100644
> > --- a/include/linux/netlink.h
> > +++ b/include/linux/netlink.h
> > @@ -226,7 +226,10 @@ void netlink_ack(struct sk_buff *in_skb, struct nl=
msghdr *nlh, int err,
> >  int netlink_has_listeners(struct sock *sk, unsigned int group);
> >  bool netlink_strict_get_check(struct sk_buff *skb);
> >
> > -int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 porti=
d, int nonblock);
> > +/* Internal flags for netlink_unicast (do not overlap with MSG_* flags=
) */
> > +#define NETLINK_UNICAST_TIMED 0x80000
> > +
> > +int netlink_unicast(struct sock *ssk, struct sk_buff *skb, __u32 porti=
d, int flags);
> >  int netlink_broadcast(struct sock *ssk, struct sk_buff *skb, __u32 por=
tid,
> >                     __u32 group, gfp_t allocation);
>
> ...
>
> > diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> > index 2aeb0680807d..acaa96695981 100644
> > --- a/net/netlink/af_netlink.c
> > +++ b/net/netlink/af_netlink.c
> > @@ -1325,14 +1325,17 @@ static int netlink_unicast_kernel(struct sock *=
sk, struct sk_buff *skb,
> >  }
> >
> >  int netlink_unicast(struct sock *ssk, struct sk_buff *skb,
> > -                 u32 portid, int nonblock)
> > +                 u32 portid, int flags)
> >  {
> >       struct sock *sk;
> >       int err;
> >       long timeo;
> > +     int nonblock;
> >
> >       skb =3D netlink_trim(skb, gfp_any());
> >
> > +     /* Extract blocking mode: strip internal flags, preserve MSG_DONT=
WAIT */
> > +     nonblock =3D flags & ~NETLINK_UNICAST_TIMED;
> >       timeo =3D sock_sndtimeo(ssk, nonblock);
> >  retry:
> >       sk =3D netlink_getsockbyportid(ssk, portid);
> > @@ -1351,8 +1354,18 @@ int netlink_unicast(struct sock *ssk, struct sk_=
buff *skb,
> >       }
> >
> >       err =3D netlink_attachskb(sk, skb, &timeo, ssk);
> > -     if (err =3D=3D 1)
> > +     if (err =3D=3D 1) {
> > +             /* timeo may have been zeroed by schedule_timeout inside
> > +              * netlink_attachskb. If the caller is a timed-blocking s=
ender
> > +              * (not genuinely nonblocking), don't re-enter with timeo=
=3D0 as
> > +              * that would misfire netlink_overrun on the next iterati=
on.
> > +              */
> > +             if (!timeo && (flags & NETLINK_UNICAST_TIMED)) {
> > +                     kfree_skb(skb);
> > +                     return -EAGAIN;
> > +             }
>
> Is the new flag needed, couldn't you just check to see if a non-blocking
> operation was requested and do the same?
>
>   if (timeo =3D=3D 0 && !nonblock) {
>     kfree_skb(skb);
>     return -EAGAIN;
>   }
>

Hi Paul,

Thanks for reviewing this patch. You're definitely right, it seems I
overengineered the fix.
I'm just doing some final testing, and I'll post the V2 shortly.

> >               goto retry;
> > +     }
> >       if (err)
> >               return err;
> >
> > --
> > 2.53.0
>
> --
> paul-moore.com
>


