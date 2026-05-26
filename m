Return-Path: <netdev+bounces-291632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDGvGtdtFWojVAcAu9opvQ
	(envelope-from <netdev+bounces-291632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:54:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 145C65D3C1A
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 11:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 18A1A3019553
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A74A3DC4BD;
	Tue, 26 May 2026 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdL02sYQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D4D3D9051
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779788908; cv=none; b=qak5obQhoJAhPF2ykaoZOj5r+LcUvIHQDbk4S5wCvqp8OvdI8VmpjfgsObAQqekb6qc+KM2yXCJWF2eQ/Ddx15jyFXAkbQrLL910N0TCovd+dorOvqq01E8dzxRNU7YUniQ54r0HnAgru6dw+6hSVQ6I0FLONnUxqV33jUBEGyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779788908; c=relaxed/simple;
	bh=sfIdKLgbnP1Jx9DwtOti3HcjvYbdhL8sVMQrKD5R0IY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z5jpfke+KNtD/CscN221DeReQU/OfEIRzCzArdnQHOjaLbJUlYwvIlyFwutnuCRri/vM47gufgKOx/um9NWgia2oPRY9NiMpSf7/VyXn32RNZ8RTqdin1G6HfXJX9D2UT81Nf5OMkYNExs199wxKveCciQfCFRHNMkM5/bWLiv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qdL02sYQ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-44c350a5b87so6136326f8f.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 02:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779788903; x=1780393703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z95kS+UYwumfGMG8a6gHQpRZk1x78jmk447ahFVrDl0=;
        b=qdL02sYQr2sCJopEHdjQH/GWBcGQ2TF+zRKDpqAOkSLWa7cHatS+yFR4wHBpWMi4dg
         yimxIN6j4+1T1J9t/1ft5SDn1aGIJqW+6KNwU+oGa+Fm0wA7eTU3BIOpmqviNRtnwtWN
         DX0Z5PDIrUIE2mhnd+9KfeIRWSmW4rYAYZjsXtAjoUVlRQXBdjdubI3wxDeGma9UGEV9
         +1NaJLFSHNkOKW0/UYulzy0WGiHLDaB7t6KIuSzmkena7wcLe6niRFboOpvHCveJgp3J
         Re+LY5D07KGGCi80Jn97779Fyuqc5zNG9UQ1cmV1G0S61fYlk1RipM7brNqrb/bwAmhZ
         SzFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779788903; x=1780393703;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z95kS+UYwumfGMG8a6gHQpRZk1x78jmk447ahFVrDl0=;
        b=C5Q9Rkbs1uVZ1BmJHv76MfVDPWpt4pk0iHfCc13mvbp1vQZ7KnB4iDhmxZMSll4sDE
         b2JMHlln1/ZVrfhFZhOdilG9Rq6VEJhgeD99Dmww0dQ0vWht7Yt9bknt3OisJi0PAR4h
         nYEdLocT2SllQxqYa9gxtzVUxdBZ8zE2rxyyxbhg9yIhrWl5NTnVKzUHaJjFykQXLnwo
         kaJc7DtLGWGgZP/ev5ZfDR11z7oBgAY59rHED8yrt+ookATA4t8HB6MUpHnhdGfhx7T4
         POLY63wFoKHKhSoj5VSCe2QF0xVMNeu0onhX6zUqcmeenO+aZtSjcS/5FpCT5spqZ7N4
         V0zA==
X-Forwarded-Encrypted: i=1; AFNElJ8kHXjOxSnycignVf1L/nCx3AieQgkXH7TDntE0wTCBfKAPVLJeE5+MzkXCjb4shLyf5oNfdAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWbZdtnV9OKUIi8BKkHO/Y3srXEqivNoMDcthNfNFkAUbzJYnM
	ipe9ZF6IVtSDb0wdWJkQBVwv1RT6g7Xza9jcS6cRzvt653giX4JRiKMd
X-Gm-Gg: Acq92OGA4KgPvJQfAXmAbDAq02JBGdb7jE8AouAnJIGQLnSjJ5gDEgy9RWhiXK28wZg
	dzXcZoSx0oKJgPpjK8RFVgRGZU98ATO2m7VeENOgZjtC6y5xVJtjOy+eIFnc5rGiypxwDBr2XJr
	0oH/Zxy2JoTaJ743vQvsDqKiC92gxrxRBFcRA3Uj5cRo3GBxVM+9m1FVriDmFu5bysUh83rhdgB
	e0vziqmSO8VZMUcTZvZJwu4/gyjmHKoRnoKxGiNFazUrob4dQq3tel8p/n/MH+YoFFQjHnlOYkz
	beN9p72rwVHzqvhUqGDLULXkGj1hAOlao6b5mUDSFBXfFa5zcE8Snp9S8mJcZNFSNRAS0YCI+j2
	4ZjvqGVIrSx6jH6FADDDSy7bDDFo3snvt0pqrD9gmYTXKKY7XFrY/u7e0Q2Vj22cwe9Qf/IUpWa
	L7rkST8J9KBbVKF8PgsHaSSg5hJvmUczPcJ3vFIc8lgtOIweox250nsXn+rvrv9V3fCvj4aXeWl
	cI=
X-Received: by 2002:a05:6000:1848:b0:43d:733f:aee6 with SMTP id ffacd0b85a97d-45eb3687dedmr30362420f8f.10.1779788902589;
        Tue, 26 May 2026 02:48:22 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6c9ba2esm34990000f8f.8.2026.05.26.02.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 02:48:22 -0700 (PDT)
Date: Tue, 26 May 2026 10:48:21 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Rajat Gupta
 <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260526104821.6eedb8ac@pumpkin>
In-Reply-To: <CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
	<CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
	<CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
	<20260521073526.793d30c3@kernel.org>
	<CAM0EoMnvrAxGC=bty=ZUXG6XDN_hTNZiy9LSZhNicEdbe8DghQ@mail.gmail.com>
	<20260521084640.683c1ee6@kernel.org>
	<CAM0EoMmNWYzryfc5=4R0SkW+wfVhBxO3tAH+KeoMP3sPr6yrFA@mail.gmail.com>
	<20260522084611.390fd0a6@kernel.org>
	<CAM0EoMmKQc3oqDDiz5jGmwc8D3eTWd2wgst0MWEvXpPZHn-C7A@mail.gmail.com>
	<CAM0EoM=Db_AD1tqcG5w18pJKh8ysbUUHyzgP4c3thHTmeXLVyw@mail.gmail.com>
	<20260522175507.02b4fe83@kernel.org>
	<CAM0EoMkh3CF4EpNQDHUogxJLyqdw8gMFfvXQFOE+N4dLZY6gJQ@mail.gmail.com>
	<CAM0EoMnDjLJ=_+p+2xuHrbWFhtNCdQhONu21z_S7eZK+OFMibw@mail.gmail.com>
	<20260523094641.2bef6580@kernel.org>
	<CAM0EoMmOeqdwZnxAf0LNJSVVnJwJg=G5Ao3zqvC12J72WQeMtw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291632-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,oss.qualcomm.com,vger.kernel.org,davemloft.net,google.com,redhat.com,resnulli.us,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[davidlaightlinux@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 145C65D3C1A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 12:57:08 -0400
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> On Sat, May 23, 2026 at 12:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> >
> > On Sat, 23 May 2026 08:13:21 -0400 Jamal Hadi Salim wrote: =20
> > > > > @@ -474,8 +473,6 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk=
_buff *skb,
> > > > >                 }
> > > > >
> > > > >                 *ptr =3D ((*ptr & tkey->mask) ^ val);
> > > > > -               if (ptr =3D=3D &hdata)
> > > > > -                       skb_store_bits(skb, hoffset + offset, ptr=
, 4);
> > > > >         }
> > > > >
> > > > >         goto done; =20
> > > >
> > > > I see you are trying to get rid of the skb_header_pointer() /
> > > > skb_store_bits() piece. Sure looks cleaner if we must linearize. =20
> > >
> > > The other thing (i may be over thinking) with pskb_may_pull is: if the
> > > data is already linear (in a clone), wouldn't we corrupt the shared
> > > linear data of the clone? =20
> >
> > I said
> >
> >   for the portion of the problem that's "we are writing to frags"
> >
> > IOW not replacing the rest of the patch (assuming we care). =20
>=20
> So as an alternative to the piece i posted? i.e this:
>=20
> diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
> index 79921b8d89ba..8f0f84b50c85 100644
> --- a/net/sched/act_pedit.c
> +++ b/net/sched/act_pedit.c
> @@ -474,6 +474,12 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *=
skb,
>                 if (write_offset < 0) {
>                         if (skb_cow(skb, -write_offset))
>                                 goto bad;
> +                       if (write_offset + (int)sizeof(hdata) > 0) {
> +                               if (skb_ensure_writable(skb,
> +                                               min_t(int, skb->len,
> +                                                     write_offset +
> (int)sizeof(hdata))))

I don't think that needs to be min_t(), a plain min() will do.
(Possibly with the (int) cast removed from the sizeof.)

-- David

> +                                       goto bad;
> +                       }
>                 } else {
>                         if (unlikely(check_add_overflow(write_offset,
>                                                         (int)sizeof(hdata=
),
>=20
> cheers,
> jamal
>=20


