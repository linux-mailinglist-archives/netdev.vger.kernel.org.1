Return-Path: <netdev+bounces-161682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DE1A233CD
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 19:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF4A163CCF
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 18:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A668F1EE7A1;
	Thu, 30 Jan 2025 18:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="QnVEC7gh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B061925A1
	for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 18:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738262107; cv=none; b=VBzYF6X+sgXp+ylrrMsmfk8rBKCsKlS61WwQRXMm28eGw/0gxvFbXaPPtvqo3HKBnw0X2oN5Levl98br1ig0OpWZ4m2+EliwZURcXo1jgNr92k/UOsCCyibZ2t2CSd74hCh66yO78ym6mYBHxQkY8Xhw4dI4niU4CX/kiB1D9Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738262107; c=relaxed/simple;
	bh=ADAKfa+fKooVFUJPYLJV7fckpmztFRNQYgSEJbzqcPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdNCDJW9BmMz/PHyDdQ5L5ns6tU62fs3cqZU18spvAo1ShHGHfJQBhGCQhhgWhD5xfiUsiZof8JMxRH05hcdEc1WLIXff8Jo5jjTSvs1oQzmGX6qsSHMeHoDX3m0yD9u6EVky8G85SWsBDv/2o8aG0t09SMotDXpVfZTGN/A2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=QnVEC7gh; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso248296966b.3
        for <netdev@vger.kernel.org>; Thu, 30 Jan 2025 10:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1738262104; x=1738866904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/QoYXIzAUEmCbBIJVjbThVFY9blUYC4TFpSTb083/Q=;
        b=QnVEC7ghnkryxTncJGu72zErBDiG53eeoHiEZyA1gK/v0548GZBvnZpFViypAEDzGy
         LtMLZvtBXBFm021JvkfnCeRknpNqMpk0MtefnQpFhZB28LrXmtqS2yAC+h848knTPIWE
         okUnw6ODUBYZpbhq/0RpvEDY1keoM/mthpt173Djkd2djB4jBS+1LHQueJiPxUrmgcZW
         KsyVUFU8sbRVVsxLX4AfgmtAc2Md1bVyREZNnOcWbvTLbyNltee7ga2DntOQpaUb/Ef9
         x0SSAYCFcVmMfwKqlm3EVnZUBfGxNUhdUrt9hbQQK/YJYBJLpzZqFiL+d26U+58WuHwH
         OykA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738262104; x=1738866904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a/QoYXIzAUEmCbBIJVjbThVFY9blUYC4TFpSTb083/Q=;
        b=eXlNk7s2oJCe+U4baMc+fGMsGRE5sMbUGX/UIaZOLSn8fRcLYMcf37wtjB15/Z/qtn
         +VXmaJ3RYCp6YXsy6ojUQzctiNabUJnDiC6U88qIzAcff1t8I5zXxqqwR3VlZpyBwX2n
         rHmZuJcVVSvWn9z/I2glShjorhAg2Ap1gz5zXoqO21vBBSGLy69GrNuVvLNNKH7cp1T8
         94uOMcHqHejelCo0RCXP58L09ZseUEmtqokOI/tc1ZNYjEFr4qLRr/lwCqh0++aEsMOH
         dXGRs3nIoURAn6bgpqNg8+5hcFAkAtdUlkX3GDF3WJoBn91K344Di5ZCnuCjLHVGeCGj
         EwMA==
X-Gm-Message-State: AOJu0YxNkBHox0xQx3vyr/lW7YCvHhEyi2Q56tvFqfrssJJkpCEhGVys
	xEgwDxP6P7NeMisYRCeMgtsc+ATYvb4TMBXO5R+TVHnNX5ffJevDC+brNWhMweACV3A1XI5pExk
	2M4GuvGd6+TXULYd7VyDCKm7LGby+xPQVAJ63ag==
X-Gm-Gg: ASbGncvDOOOiOMzMIzbgR5M6jcfL9cU4kEW+edt6MwyomRIw/p73rSXlW1CEOVaw12N
	s7CKwvUr0h7FZSrEdt3BwMHLTSgfCJpD2upZkbDwfUoeeMvUhQjyRpaOSebKsoKaRj1Ru4Csvca
	KKz7pfYPHVY6c=
X-Google-Smtp-Source: AGHT+IFrY0xvpkSX9b3z41ncnuxdSTXg1UW4Jy38GiqpH1vdIqIqIrxspkQadqZqVfBVUOCZ6kkTXOBg6Zr5Qr8YHo8=
X-Received: by 2002:a17:907:3fa7:b0:aae:ebfe:cedb with SMTP id
 a640c23a62f3a-ab6cfe12cfemr782840666b.51.1738262103888; Thu, 30 Jan 2025
 10:35:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z5swit7ykNRbJFMS@debian.debian> <679b9c293471b_1ca8082949b@willemb.c.googlers.com.notmuch>
In-Reply-To: <679b9c293471b_1ca8082949b@willemb.c.googlers.com.notmuch>
From: Yan Zhai <yan@cloudflare.com>
Date: Thu, 30 Jan 2025 12:34:53 -0600
X-Gm-Features: AWEUYZkvXLhdGcyJ8Jfgiqm-Vwsi8bzj1u0Mz5yYCapsWPqPYnxruvdSQFj3VN8
Message-ID: <CAO3-Pbpep00Up+WADoxun7kDvMruHSpydU6fEmyhnxM+o_jP1g@mail.gmail.com>
Subject: Re: [PATCH v2 net] udp: gso: do not drop small packets when PMTU reduces
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Josh Hunt <johunt@akamai.com>, 
	Alexander Duyck <alexander.h.duyck@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2025 at 9:35=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Yan Zhai wrote:
> > Commit 4094871db1d6 ("udp: only do GSO if # of segs > 1") avoided GSO
> > for small packets. But the kernel currently dismisses GSO requests only
> > after checking MTU/PMTU on gso_size. This means any packets, regardless
> > of their payload sizes, could be dropped when PMTU becomes smaller than
> > requested gso_size. We encountered this issue in production and it
> > caused a reliability problem that new QUIC connection cannot be
> > established before PMTU cache expired, while non GSO sockets still
> > worked fine at the same time.
> >
> > Ideally, do not check any GSO related constraints when payload size is
> > smaller than requested gso_size, and return EMSGSIZE instead of EINVAL
> > on MTU/PMTU check failure to be more specific on the error cause.
> >
> > Fixes: 4094871db1d6 ("udp: only do GSO if # of segs > 1")
> > Signed-off-by: Yan Zhai <yan@cloudflare.com>
> > --
> > v1->v2: add a missing MTU check when fall back to no GSO mode suggested
> > by Willem de Bruijn <willemdebruijn.kernel@gmail.com>; Fixed up commit
> > message to be more precise.
> >
> > v1: https://lore.kernel.org/all/Z5cgWh%2F6bRQm9vVU@debian.debian/
> > ---
> >  net/ipv4/udp.c                       | 28 +++++++++++++++++++---------
> >  net/ipv6/udp.c                       | 28 +++++++++++++++++++---------
> >  tools/testing/selftests/net/udpgso.c | 14 ++++++++++++++
> >  3 files changed, 52 insertions(+), 18 deletions(-)
> >
> > diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
> > index c472c9a57cf6..0b5010238d05 100644
> > --- a/net/ipv4/udp.c
> > +++ b/net/ipv4/udp.c
> > @@ -1141,9 +1141,20 @@ static int udp_send_skb(struct sk_buff *skb, str=
uct flowi4 *fl4,
> >               const int hlen =3D skb_network_header_len(skb) +
> >                                sizeof(struct udphdr);
> >
> > +             if (datalen <=3D cork->gso_size) {
> > +                     /*
> > +                      * check MTU again: it's skipped previously when
> > +                      * gso_size !=3D 0
> > +                      */
> > +                     if (hlen + datalen > cork->fragsize) {
> > +                             kfree_skb(skb);
> > +                             return -EMSGSIZE;
> > +                     }
> > +                     goto no_gso;
>
> This is almost the same as the test below.
>
> How about just
>
>     if (hlen + min(cork->gso_size, datalen) > cork->fragsize)
>
> And don't bypass the subsequent checks with a goto, or modify the
> rest of the code.
>
> > +             }
> >               if (hlen + cork->gso_size > cork->fragsize) {
> >                       kfree_skb(skb);
> > -                     return -EINVAL;
> > +                     return -EMSGSIZE;
> >               }
> >               if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
> >                       kfree_skb(skb);
> > @@ -1158,17 +1169,16 @@ static int udp_send_skb(struct sk_buff *skb, st=
ruct flowi4 *fl4,
> >                       return -EIO;
> >               }
> >
> > -             if (datalen > cork->gso_size) {
> > -                     skb_shinfo(skb)->gso_size =3D cork->gso_size;
> > -                     skb_shinfo(skb)->gso_type =3D SKB_GSO_UDP_L4;
> > -                     skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(datale=
n,
> > -                                                              cork->gs=
o_size);
> > +             skb_shinfo(skb)->gso_size =3D cork->gso_size;
> > +             skb_shinfo(skb)->gso_type =3D SKB_GSO_UDP_L4;
> > +             skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(datalen,
> > +                                                      cork->gso_size);
> >
> > -                     /* Don't checksum the payload, skb will get segme=
nted */
> > -                     goto csum_partial;
> > -             }
> > +             /* Don't checksum the payload, skb will get segmented */
> > +             goto csum_partial;
> >       }
> >
> > +no_gso:
> >       if (is_udplite)                                  /*     UDP-Lite =
     */
> >               csum =3D udplite_csum(skb);
> >
> > diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> > index 6671daa67f4f..d97befa7f80d 100644
> > --- a/net/ipv6/udp.c
> > +++ b/net/ipv6/udp.c
> > @@ -1389,9 +1389,20 @@ static int udp_v6_send_skb(struct sk_buff *skb, =
struct flowi6 *fl6,
> >               const int hlen =3D skb_network_header_len(skb) +
> >                                sizeof(struct udphdr);
> >
> > +             if (datalen <=3D cork->gso_size) {
> > +                     /*
> > +                      * check MTU again: it's skipped previously when
> > +                      * gso_size !=3D 0
> > +                      */
> > +                     if (hlen + datalen > cork->fragsize) {
> > +                             kfree_skb(skb);
> > +                             return -EMSGSIZE;
> > +                     }
> > +                     goto no_gso;
> > +             }
> >               if (hlen + cork->gso_size > cork->fragsize) {
> >                       kfree_skb(skb);
> > -                     return -EINVAL;
> > +                     return -EMSGSIZE;
> >               }
> >               if (datalen > cork->gso_size * UDP_MAX_SEGMENTS) {
> >                       kfree_skb(skb);
> > @@ -1406,17 +1417,16 @@ static int udp_v6_send_skb(struct sk_buff *skb,=
 struct flowi6 *fl6,
> >                       return -EIO;
> >               }
> >
> > -             if (datalen > cork->gso_size) {
> > -                     skb_shinfo(skb)->gso_size =3D cork->gso_size;
> > -                     skb_shinfo(skb)->gso_type =3D SKB_GSO_UDP_L4;
> > -                     skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(datale=
n,
> > -                                                              cork->gs=
o_size);
> > +             skb_shinfo(skb)->gso_size =3D cork->gso_size;
> > +             skb_shinfo(skb)->gso_type =3D SKB_GSO_UDP_L4;
> > +             skb_shinfo(skb)->gso_segs =3D DIV_ROUND_UP(datalen,
> > +                                                      cork->gso_size);
> >
> > -                     /* Don't checksum the payload, skb will get segme=
nted */
> > -                     goto csum_partial;
> > -             }
> > +             /* Don't checksum the payload, skb will get segmented */
> > +             goto csum_partial;
> >       }
> >
> > +no_gso:
> >       if (is_udplite)
> >               csum =3D udplite_csum(skb);
> >       else if (udp_get_no_check6_tx(sk)) {   /* UDP csum disabled */
> > diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selft=
ests/net/udpgso.c
> > index 3f2fca02fec5..fb73f1c331fb 100644
> > --- a/tools/testing/selftests/net/udpgso.c
> > +++ b/tools/testing/selftests/net/udpgso.c
> > @@ -102,6 +102,13 @@ struct testcase testcases_v4[] =3D {
> >               .gso_len =3D CONST_MSS_V4,
> >               .r_num_mss =3D 1,
> >       },
> > +     {
> > +             /* datalen <=3D MSS < gso_len: will fall back to no GSO *=
/
> > +             .tlen =3D CONST_MSS_V4,
> > +             .gso_len =3D CONST_MSS_V4 + 1,
> > +             .r_num_mss =3D 0,
> > +             .r_len_last =3D CONST_MSS_V4,
> > +     },
>
> Please also add a test where datalen > MSS < gso_len (with .tfail =3D tru=
e).
>
ACK on both comments.

Thanks
Yan


> >       {
> >               /* send a single MSS + 1B */
> >               .tlen =3D CONST_MSS_V4 + 1,
> > @@ -205,6 +212,13 @@ struct testcase testcases_v6[] =3D {
> >               .gso_len =3D CONST_MSS_V6,
> >               .r_num_mss =3D 1,
> >       },
> > +     {
> > +             /* datalen <=3D MSS < gso_len: will fall back to no GSO *=
/
> > +             .tlen =3D CONST_MSS_V6,
> > +             .gso_len =3D CONST_MSS_V6 + 1,
> > +             .r_num_mss =3D 0,
> > +             .r_len_last =3D CONST_MSS_V6,
> > +     },
> >       {
> >               /* send a single MSS + 1B */
> >               .tlen =3D CONST_MSS_V6 + 1,
> > --
> > 2.30.2
> >
> >
>
>

