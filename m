Return-Path: <netdev+bounces-84987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D265898DC8
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0C11C240D8
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 18:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F36A130A57;
	Thu,  4 Apr 2024 18:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yb0+ZQLc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F0E1CA82
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712254397; cv=none; b=MgYwZcZZg17KdDV8NNlvDWv9EZnPvy+i7+9z5QywEweWJVcZlqvmy7WKAuvbFWs7PXSDo9ipahXcHjzkyrjMp4vtVURxChSptF53DUCHN3mAif4yKs5i19of3MuezZ1121OzQdOJDE8puAxhjunUqfMG/AzKAkrZBlibV8HScOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712254397; c=relaxed/simple;
	bh=g71Xb15JxgeIgUFH52QEeGPEnoaYoR089DZ1AVtVFms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVBNxfUAaiGR1H1WLjcYFJhIPJF2iJBbPz2LIXUb+lfXOfGRj0Srf3DuQEdEsDma+pXwPu2svCVJs3my1h1I3WheEbGPy49NoRsXX+nb4OZjB+8+P4dRvViejjbv/Cs8C2FHcH5NhpDGqFqOgnWcKvmktNamrgf1S82BJCiGQkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yb0+ZQLc; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56dec96530bso2233a12.0
        for <netdev@vger.kernel.org>; Thu, 04 Apr 2024 11:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712254395; x=1712859195; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o13qbpva2bHUrkKlbGF9y+3OnwW2SHdu/nhwVPQBjGs=;
        b=yb0+ZQLcNx5gOu19kIYfPfUoBrIHHMq1YCh5VXQdZT49sqaom1yE/mxX/JBmEMxf+q
         l4dmD0GHn+sjv06T9jXStaUadDg0Qnb+3dyPy6zDiyol0adZ2ZVkQR4za4Hm6uPTfA9B
         gAnqkjHcgjVtpnmRWDUMSvhjwAfDKYLpZuv7ABk3l3twDvnSFCtRFd5SIosIjLDMeRFu
         jvLkB4uBe4Y2gVxJrzDRz4R57tvKsgvfneoxwq+ArpcSA1erRAXN3kNrT2lqVsE48jVi
         9BnvzYfOk0qCBqBmk5NbHrG0S2BWxDKcIEn7loMScWVbvsTSnzNCTJL69pMNsjVhEyO0
         7z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712254395; x=1712859195;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o13qbpva2bHUrkKlbGF9y+3OnwW2SHdu/nhwVPQBjGs=;
        b=rBRIMHZbLpFQuggitmU0PFS42pGuQR82FussUeGdJPLpRxFfrz4Fe3ylWCUTI3tW4G
         lbgYLTFemRTQdWdgDFmBXjZYNyg0YHhuZbY8iQsgM075cpcklxBqYj0QAbNGr4R6DUoG
         uKOnxTB+babuxKWpkIzc9Hjbu9KXFqa3lot0sTKlncmZFYOy52AdtMhjxF33TFGZgNLI
         qqujsdxOXNkxKkWXastpfKrN3LIGR/y+gyHcLJwZIApEACIsyH2uk1UBXuQZZUWyW5wO
         Gq8vOMpdKWdK3bI6pBmXCdfDFkQiel65LPWnMILVSt3nYdmzm3h77YoxorggJu8fKQyc
         3T3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXtQjv+5yMLqLLSda2HsmJq3vHqvZfhxKQfjrgUdgd5IZgkbuDQHx0wYFi6ekTvyGzUX3ah+9YbKMph+DX33uva1txAlyte
X-Gm-Message-State: AOJu0YyocgpvW4chUlGpNHxYZnKwe+Z+/CJua+0tSZXM40Z/DkF4WPp0
	L4HHDnFOk6uQ3SMlSXPYHJX289uZp4hGfOi5Y+0TPdPzMydThKqsAIa7HXRPsG8lq20f0ZWNNMI
	/6TSBgEPSbFJCt6f8FVXQwFUPazqEEC0hMWmA
X-Google-Smtp-Source: AGHT+IG0tK/532sHD1LwJ8RfbGyhv1Sjye7tSI09T8LO55u2z7+jj1gHpIDe04V97nEi1RgUr5ZPk6CL3Mcietes558=
X-Received: by 2002:aa7:d049:0:b0:56e:ac4:e1f3 with SMTP id
 n9-20020aa7d049000000b0056e0ac4e1f3mr149978edo.7.1712254393336; Thu, 04 Apr
 2024 11:13:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404131126.2534400-1-edumazet@google.com> <20240404100035.3270a7d5@kernel.org>
 <CANn89iJxsJBj6tG7BQ2rDibcXnb-PSHREY_zKSAFcNXQacQO3A@mail.gmail.com> <CANn89iKCBEdgu2Mc7UNrVVp6Cn4Tved2ZT_qWPPfJ44bcECJng@mail.gmail.com>
In-Reply-To: <CANn89iKCBEdgu2Mc7UNrVVp6Cn4Tved2ZT_qWPPfJ44bcECJng@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 4 Apr 2024 20:13:02 +0200
Message-ID: <CANn89iLQH45LgRhzNOawONU8R=jfJvZ75NS2ka_E4CAg_sDVuQ@mail.gmail.com>
Subject: Re: [PATCH net] geneve: fix header validation in geneve[6]_xmit_skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com, 
	Phillip Potter <phil@philpotter.co.uk>, Sabrina Dubroca <sd@queasysnail.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:47=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Thu, Apr 4, 2024 at 7:09=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Thu, Apr 4, 2024 at 7:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org>=
 wrote:
> > >
> > > On Thu,  4 Apr 2024 13:11:26 +0000 Eric Dumazet wrote:
> > > > syzbot is able to trigger an uninit-value in geneve_xmit() [1]
> > > >
> > > > Problem : While most ip tunnel helpers (like ip_tunnel_get_dsfield(=
))
> > > > uses skb_protocol(skb, true), pskb_inet_may_pull() is only using
> > > > skb->protocol.
> > > >
> > > > If anything else than ETH_P_IPV6 or ETH_P_IP is found in skb->proto=
col,
> > > > pskb_inet_may_pull() does nothing at all.
> > > >
> > > > If a vlan tag was provided by the caller (af_packet in the syzbot c=
ase),
> > > > the network header might not point to the correct location, and skb
> > > > linear part could be smaller than expected.
> > > >
> > > > Add skb_vlan_inet_prepare() to perform a complete mac validation.
> > > >
> > > > Use this in geneve for the moment, I suspect we need to adopt this
> > > > more broadly.
> > >
> > > Something is cause the ttl test do break:
> > >
> > > # =E2=94=82 geneve =E2=94=82     4 =E2=94=82     4 =E2=94=82 inherit =
0x3c =E2=94=82    inherit 8 =E2=94=82 false =E2=94=82./l2_tos_ttl_inherit.s=
h: line 350: printf: 0xeaECT0: invalid hex number
> > > ok 1 selftests: net: l2_tos_ttl_inherit.sh # SKIP
> > >
> > > https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/537382/6-l2-to=
s-ttl-inherit-sh/stdout
> > >
> > > Is is possibly this change?
> >
> > Let me check this, thanks !
>
> Apparently __vlan_get_protocol() depends on skb->mac_len.
>
> This field is not usually set, unless skb_reset_mac_len() has been called=
.

I will squash tomorrow in v4 this fix, unless someone disagrees.

Thanks again !

diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index 6898d0b8306f803c57065f6e134f96dcc8517cad..ec3950be851f2d5a04972222d8c=
f13b0d811be6f
100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -365,13 +365,14 @@ static inline bool pskb_inet_may_pull(struct sk_buff =
*skb)
  */
 static inline bool skb_vlan_inet_prepare(struct sk_buff *skb)
 {
-       int nhlen, maclen;
-       __be16 type;
+       int nhlen, maclen =3D ETH_HLEN;
+       __be16 type =3D skb->protocol;

        /* Essentially this is skb_protocol(skb, true)
         * And we get MAC len.
         */
-       type =3D __vlan_get_protocol(skb, skb->protocol, &maclen);
+       if (eth_type_vlan(type))
+               type =3D __vlan_get_protocol(skb, type, &maclen);

        switch (type) {
 #if IS_ENABLED(CONFIG_IPV6)

