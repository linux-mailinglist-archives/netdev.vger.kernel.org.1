Return-Path: <netdev+bounces-137657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C6DE9A92E2
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 00:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCBA1F224F4
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 22:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687D21991DB;
	Mon, 21 Oct 2024 22:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YT9Z3Qg6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D126E2CA9;
	Mon, 21 Oct 2024 22:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729548296; cv=none; b=i9Tbc1nNbRPh4xv4DrGMffdwg0rbKt4KNMeO2Rj/NYPmo49w4Cth3Bf5mGJVWEzZoTaegUERA1fRhPFrExYmr67ErgukAGEQfky91/BlwPqwSR8HSHpKfEDmq+QJsJYWjJUMb6WP5oLgJztBhF4Ibdpbl3rniwu6xTduNwm+Et0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729548296; c=relaxed/simple;
	bh=xOHfePryB2P9dl4uzu8ue16CvMBphUfSLJZaBqEChiE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=goYCB8P2yyQrh6Fon9+aNatWU69/fmo9v1YdKHOoNAvPweEJNt5NbY3pltIhJ+Nx5IZE2ucATc6lAT+gs5BlYhOeHjJFRoHTYuBjX21mg2Vw4+8VyzK/t0YPdZG6NSlmPc/NW8mU+mg99pHE2soTdPhbkg1YBmkW2fmh2cAwRu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YT9Z3Qg6; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7b158542592so288202185a.2;
        Mon, 21 Oct 2024 15:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729548294; x=1730153094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rIgnwM32rxyNCa5OFMqPzKg+pXvtDbAvqexXyAOOyVg=;
        b=YT9Z3Qg6N4h+gqVJr0aIry2biQ3g0YRV5W2wd6soZsvmFjpIEzF9RyEtg8b1fzYr01
         Hhh/39m97CkmU723xT8cHedzCMgOWdzzYDOqL+lCJTjK18QO0dtGBxunwefSvekJ4egu
         emUFvZu1ICBJdxkcqpXph+NO7iwrIn6gz2y6/riN2VaCcV0G6tOdJDdgVlTYyZqDQvDA
         gZzhHaIR1umot8aGxu/2mAeR1nhnd8dEc8ZGgTUH0vCXLkNq6Hd4NuLMkZ1Rdvk+31Dz
         iVRND/XQbG+jBCVHGSiaXyMrJQRa01yReOs8tp2O7VCCSvjIUzbsGvoAbGs1kCEq2a4Z
         ipyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729548294; x=1730153094;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rIgnwM32rxyNCa5OFMqPzKg+pXvtDbAvqexXyAOOyVg=;
        b=lP4WenkrNTc9ZfViTy6N2N31vXileXPioRWK7rFiZ/GC8hhKQh1dEy/+S/Fw2OO15q
         YMJ+6l1rNvstlSOzNfXnWtjgbXTlNp/VYLoeymXy/+C5cD9kw1r/zsH29TUdAOs8DErx
         C9dxkK9bkN6co2stNJ/u4LB5pGmbloL4ACgSg7L7lOpyXp0jMf51RjqkGlg7SjSbYilg
         7CYLsxrpCcizYfEFF32co/BIfuov00LlJqQb0gdXPe5ZVwSvmQ+mg0SVce1xfjwZM4M9
         uh3zjZVFWospm3ZJdKUiKjqd1BdtAfk0TRTk4MkV+ole8eqgoSYWxtJ1DmVhOAxQDzJ5
         fruA==
X-Forwarded-Encrypted: i=1; AJvYcCWLHW8fmsZZO9Nb6fbge/oSTQ141W+Y0rIDLW9z+nPNnHzAECzi+R3co29Yyk78fwWA/8XN0+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmoPT4lpMLTBVT5w+WGTaqogrUSHUQdNTtdynm62sIlOJLIRP2
	1OpQJY3VB54Rjw7/1ruBtzKUnYfA1YB6drD+7cJ6U8W25N1IYbfU
X-Google-Smtp-Source: AGHT+IGlk2voFBz/DWsYK9jISB0rTurAgeP6UrZP+c4U6dtqzwCHVhKaOYZ4iyKpda61ISyv8hDyQg==
X-Received: by 2002:a05:620a:1916:b0:7b1:4ff4:6a05 with SMTP id af79cd13be357-7b157bebf63mr1782824885a.54.1729548293564;
        Mon, 21 Oct 2024 15:04:53 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ce009ecb61sm22350536d6.127.2024.10.21.15.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 15:04:52 -0700 (PDT)
Date: Mon, 21 Oct 2024 18:04:52 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?QmVub8OudCBNb25pbg==?= <benoit.monin@gmx.fr>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Message-ID: <6716d00429a9f_6fc77294c4@willemb.c.googlers.com.notmuch>
In-Reply-To: <2704514.lGaqSPkdTl@benoit.monin>
References: <0dc0c2af98e96b1df20bd36aeaed4eb4e27d507e.1728056028.git.benoit.monin@gmx.fr>
 <6704483c31f9c_1635eb294a0@willemb.c.googlers.com.notmuch>
 <4411734.UPlyArG6xL@benoit.monin>
 <2704514.lGaqSPkdTl@benoit.monin>
Subject: Re: [PATCH net-next] net: skip offload for NETIF_F_IPV6_CSUM if ipv6
 header contains extension
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Beno=C3=AEt Monin wrote:
> 10/10/2024 Beno=C3=AEt Monin wrote:
> > 07/10/2024 Willem de Bruijn wrote:
> > > Beno=C3=AEt Monin wrote:
> > > > 07/10/2024 Willem de Bruijn wrote :
> > > > > Beno=C3=AEt Monin wrote:
> [...]
> > > > > > Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
> > > > > > ---
> > > > > >  net/core/dev.c | 4 ++++
> > > > > >  1 file changed, 4 insertions(+)
> > > > > > =

> > > > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > > > index ea5fbcd133ae..199831d86ec1 100644
> > > > > > --- a/net/core/dev.c
> > > > > > +++ b/net/core/dev.c
> > > > > > @@ -3639,6 +3639,9 @@ int skb_csum_hwoffload_help(struct sk_b=
uff *skb,
> > > > > >  		return 0;
> > > > > > =

> > > > > >  	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> > > > > > +		if (ip_hdr(skb)->version =3D=3D 6 &&
> > > > > > +		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr=
))
> > > > > > +			goto sw_checksum;
> > > =

> > > This check depends on skb->transport_header and skb->network_header=

> > > being set. This is likely true for all CHECKSUM_PARTIAL packets tha=
t
> > > originate in the local stack. As well as for the injected packets a=
nd
> > > forwarded packets, as far as I see, so Ack.
> > > =

> > > Access to the network header at this point likely requires
> > > skb_header_pointer, however. As also used in qdisc_pkt_len_init cal=
led
> > > from the same __dev_queue_xmit_nit.
> > > =

> > > Perhaps this test should be in can_checksum_protocol, which already=

> > > checks that the packet is IPv6 when testing NETIF_F_IPV6_CSUM.
> > > =

> > You're right, moving this to can_checksum_protocol() makes more sense=
. I will =

> > do that, retest and post a new version of the patch.
> > =

> Looking more into it, can_checksum_protocol() is called from multiple p=
laces =

> where network header length cannot easily extracted, in particular from=
 =

> vxlan_features_check().
> =

> How about keeping the length check in skb_csum_hwoffload_help() but usi=
ng =

> vlan_get_protocol() to check for IPv6 instead of ip_hdr(skb)->version?

Yes, both sound good to me.=

