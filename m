Return-Path: <netdev+bounces-62662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBFA382863E
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 13:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD971C2424A
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 12:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649B3381CD;
	Tue,  9 Jan 2024 12:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX6D52mS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089BE381C3
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 12:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso1108085a12.3
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 04:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704804568; x=1705409368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WAkldLmJP+jhXx3OHkr4R9KxZfIleT5fdaW5nG+qqF4=;
        b=PX6D52mSyuU45wLHoYnD1S/PlGKz58z8/sVCqT4m37pT1cPyJS5c77x4rW0cWnVoXK
         68oQj4ekHGulEBUpwK3AeDtFEmIMlaMm5fH1AFQj6vAzZK9LWUufsVM95V3jBFNBrOvV
         51ycaDZQf0traAmSb3rDFB4efqDcZu+Mx2MMxkNc13xN/+VnttRhGJJ7dBD+CvN54WPh
         b1TIJ28KGOjThZj2s76dBRxQ7WVOtfUrT0L8mBmyGekXUTNhygYmSwd5GJkkgRsZlpyY
         nPwah0KILx++DrRgQHrdbkWlpU+efZhTDmePTMqqcqcub0B5ONfNknQeYRuYoMbb1CJP
         87+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704804568; x=1705409368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WAkldLmJP+jhXx3OHkr4R9KxZfIleT5fdaW5nG+qqF4=;
        b=S9TBBbGpT8EuLJuaoB/eKtr7WtHjwRd8lmGuxE+8kVrgpRqDYvZkws8W12NMhvTP5u
         GvyoXPgKYTJpzY4eflS29qZlzYDxn2AZoDq7ltIkh8JXPrZw4060j+XiaAqc+O2fl2mv
         n0LRa7l2jcB/bcEtTOdiYecAxt0GDLJzTZc5AKCQQgI/N2r8kkYZ4zHWWBrnRApquCIk
         bUFb8Ez7OwhjUZ4f9gRT9AqdNtv5Uw1+hAtcQNalBD0wAJnGwWgWCJp76yuoZOc6VTvf
         T0X3GiVtV7xCe91+N9HaM0m0h5beBTgTYU0mR+dn8QkgyUsxqN+QGxYXI5TNV8LNTGY0
         VQ9Q==
X-Gm-Message-State: AOJu0YzUJ5KDeHodYUsns3HwX1r/inRpRdx3MSPo+DDiAwUfXA9gsH/1
	Vce+86V+SOe53oNWgKf7o9OYvbvXqHFNFo+fu/0=
X-Google-Smtp-Source: AGHT+IE3N/leCg8yTcjdIECXgC2zw+euyZgzMb7vc2vew8/fBlyIeuws52TdgchHdSdaiGBc0BBOxvuWPXLk3CfUbxg=
X-Received: by 2002:a05:6a20:61d:b0:199:99b2:f072 with SMTP id
 29-20020a056a20061d00b0019999b2f072mr1924936pzl.20.1704804568204; Tue, 09 Jan
 2024 04:49:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240104142501.81092-1-nbd@nbd.name>
In-Reply-To: <20240104142501.81092-1-nbd@nbd.name>
From: Dave Taht <dave.taht@gmail.com>
Date: Tue, 9 Jan 2024 07:49:16 -0500
Message-ID: <CAA93jw5w5eQEHVQWsKyQghELUdQVpefQHr2JcjdA5eyTxPr_Ng@mail.gmail.com>
Subject: Re: [PATCH net-next] net: bridge: do not send arp replies if src and
 target hw addr is the same
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 4, 2024 at 9:54=E2=80=AFAM Felix Fietkau <nbd@nbd.name> wrote:
>
> There are broken devices in the wild that handle duplicate IP address
> detection by sending out ARP requests for the IP that they received from =
a
> DHCP server and refuse the address if they get a reply.
> When proxyarp is enabled, they would go into a loop of requesting an addr=
ess
> and then NAKing it again.
>
> Link: https://github.com/openwrt/openwrt/issues/14309
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> ---
>  net/bridge/br_arp_nd_proxy.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/net/bridge/br_arp_nd_proxy.c b/net/bridge/br_arp_nd_proxy.c
> index c7869a286df4..3a2770938374 100644
> --- a/net/bridge/br_arp_nd_proxy.c
> +++ b/net/bridge/br_arp_nd_proxy.c
> @@ -204,7 +204,10 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, s=
truct net_bridge *br,
>                         if ((p && (p->flags & BR_PROXYARP)) ||
>                             (f->dst && (f->dst->flags & BR_PROXYARP_WIFI)=
) ||
>                             br_is_neigh_suppress_enabled(f->dst, vid)) {
> -                               if (!vid)
> +                               replied =3D true;
> +                               if (!memcmp(n->ha, sha, dev->addr_len))
> +                                       replied =3D false;
> +                               else if (!vid)
>                                         br_arp_send(br, p, skb->dev, sip,=
 tip,
>                                                     sha, n->ha, sha, 0, 0=
);
>                                 else
> @@ -212,7 +215,6 @@ void br_do_proxy_suppress_arp(struct sk_buff *skb, st=
ruct net_bridge *br,
>                                                     sha, n->ha, sha,
>                                                     skb->vlan_proto,
>                                                     skb_vlan_tag_get(skb)=
);
> -                               replied =3D true;
>                         }
>
>                         /* If we have replied or as long as we know the
> --
> 2.43.0
>
>

Acked-by: Dave Taht <dave.taht@gmail.com>

--=20
40 years of net history, a couple songs:
https://www.youtube.com/watch?v=3DD9RGX6QFm5E
Dave T=C3=A4ht CSO, LibreQos

