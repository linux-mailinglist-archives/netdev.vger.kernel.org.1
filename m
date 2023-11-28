Return-Path: <netdev+bounces-51731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E987FBE5F
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A311C209AD
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F031E4A5;
	Tue, 28 Nov 2023 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bGDAMmLz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C161410CB
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:45:18 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40b4fac45dbso24085e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 07:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701186317; x=1701791117; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMlTXLe3YT0HN8OLrVDdKacmpyuKedWEwgUQDcdRML0=;
        b=bGDAMmLzhchCXdh3satbTP1wvUf90PxCT8GYdxw9Uxx1xvBHtoochoAkNsUpldhRV2
         lwSfqf2EDOR6PzPdRd6DATlbksDOntILc0JwP2zseoUHKv1x47/ArmKzM9zDl/fUvnoV
         1AUuFdW10Y9jarOkygvGweNvw6SPYn13M7D8QhdWB6wQ7x3dJ5k84NOGD57Bswwiezx8
         J97PDo2X8SoONsdkk341ZuUtuMQVEkwXSbUibOir8oiflgs3GII/ljTddHF1b5kD2UvD
         W2ifK9es8vHMwGBIjoONzHAXTStM2oQ/NA7V4btclEseM/iPRO90HB7QGxwOmucUJV1b
         SZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701186317; x=1701791117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMlTXLe3YT0HN8OLrVDdKacmpyuKedWEwgUQDcdRML0=;
        b=OXlv6+dKz+9LgiPzGTBdr38GvaEIqAn9v+CBKRC/FXo1wMEABcXgwbErlzPap7WF5Q
         bktDtVje7HHltFk9B9iVxD1WxN7BmDwI/qWw2yF0ZVS4jOLnR8pxoNrtXjWBYk0+PFjT
         EbJM4SuSHWgW+UDOziMYOLMUnOZSxyd1wsQvrH7X/vUvv5xr+c9XlbaXWTH/jeD1Kr3h
         qLfXPrU0nDFRc1IRBcm7UXG9yejeWV4zLIEcSr2oynungphYll5/siFIouHVuRdbx26m
         OYpBgO535/+2p6OhtK/R2wYPLKJUsndlCABRUIKUDmtQzUheTlWJnDPXpFs9KnRQJciA
         wgBQ==
X-Gm-Message-State: AOJu0YwoOyY87ImPc9sxu8D7K5oxaP11FlZ/v3v6qFKnSo5uFDH8TY+g
	cb2JW9W7zWd8F/QBrpNYZpR+gn31IRMJDC1pgG4fe7cRLQ/mQHe8nKo=
X-Google-Smtp-Source: AGHT+IF+9oitYNKpBeMPvzm+CiIMJPvo97+FEfqii/v/7kE9+U7pvcoMnIMSNamP9TDr6yY1OhIUHSpu+5W3Fp7VSxE=
X-Received: by 2002:a05:600c:3c83:b0:40b:2ec6:2a87 with SMTP id
 bg3-20020a05600c3c8300b0040b2ec62a87mr781446wmb.5.1701186316610; Tue, 28 Nov
 2023 07:45:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231126151652.372783-1-syoshida@redhat.com>
In-Reply-To: <20231126151652.372783-1-syoshida@redhat.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 28 Nov 2023 16:45:05 +0100
Message-ID: <CANn89iKcstKYWoqUCXHO__7PfVRMFNnN5nRQVCTAADvFbcJRww@mail.gmail.com>
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in ipgre_xmit()
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 26, 2023 at 4:17=E2=80=AFPM Shigeru Yoshida <syoshida@redhat.co=
m> wrote:
>
> In ipgre_xmit(), skb_pull() may fail even if pskb_inet_may_pull() returns
> true. For example, applications can create a malformed packet that causes
> this problem with PF_PACKET.
>
> This patch fixes the problem by dropping skb and returning from the
> function if skb_pull() fails.
>
> Fixes: c54419321455 ("GRE: Refactor GRE tunneling code.")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> ---
>  net/ipv4/ip_gre.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/ip_gre.c b/net/ipv4/ip_gre.c
> index 22a26d1d29a0..95efa97cb84b 100644
> --- a/net/ipv4/ip_gre.c
> +++ b/net/ipv4/ip_gre.c
> @@ -643,7 +643,8 @@ static netdev_tx_t ipgre_xmit(struct sk_buff *skb,
>                 /* Pull skb since ip_tunnel_xmit() needs skb->data pointi=
ng
>                  * to gre header.
>                  */
> -               skb_pull(skb, tunnel->hlen + sizeof(struct iphdr));
> +               if (!skb_pull(skb, tunnel->hlen + sizeof(struct iphdr)))
> +                       goto free_skb;
>                 skb_reset_mac_header(skb);
>
>                 if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL &&
> --


I have syszbot reports with an actual repro for this one.

I do not think your patch is correct, something should be fixed
earlier (before we hit this point)

