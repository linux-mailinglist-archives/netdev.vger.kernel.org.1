Return-Path: <netdev+bounces-245769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E15F7CD7362
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 22:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4A7D23014D94
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 21:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE53304BB8;
	Mon, 22 Dec 2025 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qvq+oWfD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3306A26E706
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 21:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766439442; cv=none; b=VabK7YvBUMuVI5sQTtTlqOEJJaSahP44R8bN8JTIskVEx7qn2Z2UN66Prx8b9u2/wJxIrqRKuFhI5yGnwFVakr3PN5Z67g30bsT31EB0lm4O7EBcnP3iTbTu6L+q18IOJ7YaR43N7ZB09vEQCvy/muBrAQrphdQ1qD7HiYmzf4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766439442; c=relaxed/simple;
	bh=kH600lelwpV5ARbxm6xEjU7hYBXMxo3RTAjlXlcp2Qk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtEXlbHGwJlkn/PYDlTgOyZqH2pvbHUcVMQQYU0g4W7Yy/pz1NFS+LsFVh9iwoiseWTHDZtS+wvvAJ/LW4Tzuy9kUqvxwmganR2o+WCkL0wyHqwKp35N1mNMboE6n9nhQx6KljUitqukElHw9WKMy5I/YUYjnV9rYqIuJvqSMC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qvq+oWfD; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-34cf1e31f85so3426425a91.1
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 13:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766439440; x=1767044240; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bvrhOxrnqou8EaMF1EtBx2SQopjhhLf+eYJwRi1vRHE=;
        b=Qvq+oWfDP2SMjYhnNy++wlo2xq9yfX6P3dswDNx8lhOags1mUdwqdtfQ11OPDkJFOU
         eSVDyrCJKUkm6GWo8CSYfTIW6UmGGAfp4/qi2oABEjWTDrAjABNRvymqnEP9evS2XlJ0
         hVgd0WVm7BACtAaqHsQNKTzjVJ1jpcFF/CfpcvG5SKgW9vJhpb0qXjUmCzAZ9L0+X1bc
         zLMHlPl2+j+l7IAjXqPilR7Zhm+KURIjBO2zp2hr0K9JYUk+h6ks7V5flqGD9aZFm+Pu
         k/KzUnqTyuaPnI/ly9UpicNxAYy5VGidgn2xxcUYeIfMsrKHMiZ5G8MJhxLCw3mI8y7a
         /fIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766439440; x=1767044240;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bvrhOxrnqou8EaMF1EtBx2SQopjhhLf+eYJwRi1vRHE=;
        b=sEerF6AyljryIRM+wpsYvs3N0xhnbAMt02H/71/fB3gWkoI6tn4fV2a/ofCgKprPbR
         5e6iXWc1uPTp2c+hrdpDQF5TpNyUrhEtnEfhsn5vMdxlEWJWORvTDI/bpYnUEz1LUeMi
         8wiY0OlXYMBeo3rwBlNxj86hackGRUTnP39XtyKgd/Ml0lpToJntMWGS64dfHLeHej2I
         d/7KKgaiB5ICX7gqAlznomlMjvktaFrqKI+IIVJVKzqmKv2M10uiqVFJLDRe4C7UlZna
         JKwS3eVF/vbZ3gapWHHk6z8pX1+F9KOYRtpIcleiSrGcHvZ6JZjxgW0keF3sFvgGGJd8
         A3bw==
X-Forwarded-Encrypted: i=1; AJvYcCXZeb6qDBv3Qho68720A2uN7vImHZpW6TYv8QuITHXj6Xkd9f/ogehPzZ1Imokmt3K4/fEtsRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcGp8cpdPF0TxQOx141AgrvvKjQ49N/YVuPeH5PBw1gYeSkh+s
	oAHk24leI/l6Sl+bs2wKkAurd/POy39DM9R6+RxE4zG655UgSKtV9lC7LjAGYiz/M1radlanzWt
	q2/Fkuu2XwfFltZxl1TAKOrW/AdmHTPg=
X-Gm-Gg: AY/fxX4z2d0xt7XR/XQD2NC93n1hPfveOg9ZUwVFTDDsQd9MFO+XPrE+MOz+Aiu+zhZ
	MtOqRzI7yxmtUr9BxCNVilaEJpiTfDpfSNP2hNgRmiO39XhDbAu37TthVtFoPByi7uF+0m60IfX
	jnOk683BuEfdDLvTJ2ru+Z/zbCF7eRN9qnjJ9XnoT15UtEsGs/UBGVvc1OJfaLpaUy6KEoAqIV9
	ip/+7GOIBdfqk7Asme786JfKsb4RqrZUy4/42aVCmnbrMgfeL7fLe4zQQb9ChjVMuWwKtxg
X-Google-Smtp-Source: AGHT+IFs1hVKoJ57r5unnQVNWguiD36Pc+ZyZAkzu9i4n33L/aCO1FQOo7W+sPuyLiyDx6OuoGxaBeYZeJUJk9tO+og=
X-Received: by 2002:a17:90b:33c9:b0:32e:6fae:ba52 with SMTP id
 98e67ed59e1d1-34e9211d59dmr10132921a91.6.1766439440405; Mon, 22 Dec 2025
 13:37:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1766349632.git.marcdevel@gmail.com> <99815e3b40dccf5971b7e9e0edb18c8df11af403.1766349632.git.marcdevel@gmail.com>
 <4ab8135d-75b8-4aa0-b5ce-f917e4a34e18@linux.dev>
In-Reply-To: <4ab8135d-75b8-4aa0-b5ce-f917e4a34e18@linux.dev>
From: Marc Sune <marcdevel@gmail.com>
Date: Mon, 22 Dec 2025 22:37:10 +0100
X-Gm-Features: AQt7F2oty6yaq7V69FlFLbOiH9tZWR-DEnoxFnmYIS8I_HZ8pWIVbaaTwhqSvp8
Message-ID: <CA+3n-TrGSs-rPswMmCaUjYnM=f1APBWtmAguMUaAOvwuKm30+Q@mail.gmail.com>
Subject: Re: [PATCH RFC net 1/5] arp: discard sha bcast/null (bcast ARP poison)
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: kuba@kernel.org, willemdebruijn.kernel@gmail.com, pabeni@redhat.com, 
	netdev@vger.kernel.org, dborkman@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Missatge de Vadim Fedorenko <vadim.fedorenko@linux.dev> del dia dl.,
22 de des. 2025 a les 10:47:
>
> On 21/12/2025 21:19, Marc Su=C3=83=C2=B1=C3=83=C2=A9 wrote:
> >
> >   /*
> > + *   For Ethernet devices, Broadcast/Multicast and zero MAC addresses =
should
> > + *   never be announced and accepted as sender HW address (prevent BCA=
ST MAC
> > + *   and NULL ARP poisoning attack).
> > + */
> > +     if (dev->addr_len =3D=3D ETH_ALEN &&
>
> dev_type =3D=3D ARPHRD_ETHER ?

This is discussed in the cover letter, comments section d). I would
think more dev_types than that need to check this, at least:

+       case ARPHRD_ETHER:
+       case ARPHRD_EETHER:
+       case ARPHRD_FDDI:
+       case ARPHRD_IEEE802:
+       case ARPHRD_IEEE80211:

but as said, I _think_ it's sufficient to check for HW addrlen =3D=3D ETH_A=
LEN.

>
>
> > +         (is_broadcast_ether_addr(sha) || is_zero_ether_addr(sha)))
>
> RFC says that neither broadcast, nor multicast must be believed. You
> check for broadcast only. The better check would be:
>
> !is_unicast_ether_addr(sha)

This is discussed in the cover letter, comments section b). In short,
some NLBs announce MCAST MAC addresses.

Mind the context there, but I think it's safe. This is applicable to
ARP and NDP, so I would suggest to follow up there.

Btw, the is_zero_ether_addr(addr) check is still needed.
is_unicast_ether_addr(addr) is implemented as
!is_multicast_ether_addr(addr), and the NULL mac (00:00:00:00:00:00)
doesn't have the "MCAST bit" set to 1.

>
> > +             goto out_free_skb;
> > +
> > + /*
> >    *     Special case: We must set Frame Relay source Q.922 address
> >    */
> >       if (dev_type =3D=3D ARPHRD_DLCI)
>

