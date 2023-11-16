Return-Path: <netdev+bounces-48475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F227EE81E
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 21:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFAF1F243B6
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 20:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFAB364BC;
	Thu, 16 Nov 2023 20:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2CvZfP2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AD8131;
	Thu, 16 Nov 2023 12:09:49 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso1880472a12.3;
        Thu, 16 Nov 2023 12:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700165388; x=1700770188; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9+lGtWQifftq8TGSF/BjybQMGoU7gRlllvGwvpfwadE=;
        b=k2CvZfP24HryrES9ej2pb08TCSoaukeAwwXyVyD044iKUcFQHxy/1qc4WKfaWY4KrE
         OuRzRn7cgd0eRrrCSkrC7b/3l2GihpktS8lcOh9rJypupVTW0cvibwDbwvUCV8hRSE+q
         eeW7lXu5ciDt4SjWCzkpyMNKuHgrJ80R4jjtjEsUNoLlzMQdLvLjpV1dGvUHjELI5kfG
         8GmFs17Y9TLl08fnz+nK/5vdlnVqMUoGEl9LdKNA4Zl8GwyqqIEast4D8ekMqTvVubrX
         mASd5TD73LWENrjxIRZ2pUhm86FOTd0au0VKhgRjku6SlBh9NS6H/dJkXMEoWN0IboZj
         9hig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700165388; x=1700770188;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9+lGtWQifftq8TGSF/BjybQMGoU7gRlllvGwvpfwadE=;
        b=gTb8zw3ArvsILljYyTfgxLmbEbKw95gvNadlNprMSNvbxvO/Woozi2wYeBQVHr3W0C
         v8ENx0yhqyVlxPCdf9bYu4zvNylZpdLnlFf5cVT/NkeqctWPno14II3zRrpswtKku5V/
         doffy6sZB4jiyEG4CSw77xfsIBqfHRJ1C+D3X+eGn9fjDGpb+YQf6SIYDX3fPQ8Gvs1F
         YdHCuEFkWLUkV39QXUpNUZGVNzYfAbsUcJ/Y8CekTCqFbXbjBl1uMlbVU5UOCJUEts+q
         xgy3AhEPf1Yv8OW5v87HLva3Ep8vupQmyYgb3dA6neTaTqn8y3DEReci3kX5YdR+ue/d
         EqGA==
X-Gm-Message-State: AOJu0Yw++GdyCfLJBBPvrdrnks/OlQWHj2h6ylPYjJbvZxNwQ4PZ9MNo
	2K4RInm2moqAfPYQH2ZHsE92HfUAzhI=
X-Google-Smtp-Source: AGHT+IHzEjru7acwHME7Ly8fM1VveBKkN1pOVwe+Gj4lE7spXnjnJ113qFTa8eu8u+H9HxblHPDgPA==
X-Received: by 2002:a17:907:76f7:b0:9e0:5dab:a0f1 with SMTP id kg23-20020a17090776f700b009e05daba0f1mr12731539ejc.36.1700165387515;
        Thu, 16 Nov 2023 12:09:47 -0800 (PST)
Received: from smtpclient.apple (077222239035.warszawa.vectranet.pl. [77.222.239.35])
        by smtp.gmail.com with ESMTPSA id se23-20020a170906ce5700b00992e94bcfabsm4417ejb.167.2023.11.16.12.09.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Nov 2023 12:09:47 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: possible proble with skb_pull() in smsc75xx_rx_fixup()
From: Szymon Heidrich <szymon.heidrich@gmail.com>
In-Reply-To: <7f704401-8fe8-487f-8d45-397e3a88417f@suse.com>
Date: Thu, 16 Nov 2023 21:09:35 +0100
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 USB list <linux-usb@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB9ACA9B-78ED-48C3-99D6-86E886557FBC@gmail.com>
References: <7f704401-8fe8-487f-8d45-397e3a88417f@suse.com>
To: Oliver Neukum <oneukum@suse.com>
X-Mailer: Apple Mail (2.3731.700.6)

Hello Oliver,

Could you please give me some hints how this could be practically =
exploited to cause mischief?

Best regards,
Szymon


> Wiadomo=C5=9B=C4=87 napisana przez Oliver Neukum <oneukum@suse.com> w =
dniu 15.11.2023, o godz. 12:45:
>=20
> Hi,
>=20
> looking at your security fixes, it seems to me that there
> is a further issue they do not cover.
>=20
> If we look at this:
>=20
>        while (skb->len > 0) {
>=20
> len is positive ...
>=20
>                u32 rx_cmd_a, rx_cmd_b, align_count, size;
>                struct sk_buff *ax_skb;
>                unsigned char *packet;
>=20
>                rx_cmd_a =3D get_unaligned_le32(skb->data);
>                skb_pull(skb, 4);
>=20
> ... but it may be smaller than 4
> If that happens skb_pull() is a nop.
>=20
>                rx_cmd_b =3D get_unaligned_le32(skb->data);
>                skb_pull(skb, 4 + RXW_PADDING);
>=20
> Then this is a nop, too.
> That means that rx_cmd_a and rx_cmd_b are identical and garbage.
>=20
>                packet =3D skb->data;
>=20
>                /* get the packet length */
>                size =3D (rx_cmd_a & RX_CMD_A_LEN) - RXW_PADDING;
>=20
> In that case size is unpredictable.
>=20
>                align_count =3D (4 - ((size + RXW_PADDING) % 4)) % 4;
>=20
>                if (unlikely(size > skb->len)) {
>=20
> That means that this check may or may not work.
>=20
>                        netif_dbg(dev, rx_err, dev->net,
>                                  "size err rx_cmd_a=3D0x%08x\n",
>                                  rx_cmd_a);
>                        return 0;
>                }
>=20
> There is also an error case where 4 <=3D skb->len < 4 + RXW_PADDING
>=20
> I think we really need to check for the amount of buffer that is =
pulled.
> Something like this:
>=20
> static int smsc75xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
> {
> +       u32 rx_cmd_a, rx_cmd_b, align_count, size;
> +
>        /* This check is no longer done by usbnet */
>        if (skb->len < dev->net->hard_header_len)
>                return 0;
> -       while (skb->len > 0) {
> -               u32 rx_cmd_a, rx_cmd_b, align_count, size;
> +       while (skb->len > (sizeof(rx_cmd_a) + sizeof(rx_cmd_b) + =
RXW_PADDING)) {
>=20
> 	Regards
> 		Oliver
>=20


