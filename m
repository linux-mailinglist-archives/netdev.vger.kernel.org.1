Return-Path: <netdev+bounces-89069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAAB8A9571
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 10:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDDAD1C20AE0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 08:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E615C158858;
	Thu, 18 Apr 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fYOaR+w6"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCC1E498
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 08:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430678; cv=none; b=c0ws06v3lQWVE8+hQXUHxj1fZdsRU3hBLytCWbmXSoHU0/GOobCTXod8zWCcJhg2Rv3hQ4AaoHvDkD413NmWSK9krvBY4YGpZgLguUP4d7hitcZfo58/N72+TWWLxSL5eb5qQZnTa5U3Ec1EbTLFNSwXU7aVrTvCUiqC87MYMVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430678; c=relaxed/simple;
	bh=jOyUpC0nJOZyXn5CGWfbaKP4X0Shy26WBetMcibpIYw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lMi/MMfm7JtUDJ8SqjYz8cAihEubRTsuBal1a1UiYPIc/LonftJWRdfl+R24FmaUtfFbSkalAofA5Oyh1sG4yuuQ/xGV57BVHQ3a0cGvy3V5AqkFK3rxh25PRPdwA+i27PWQ/lccyW1KF8XvaC9fPrSyZE+wcgfmAUCyCYNDuOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fYOaR+w6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713430676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jOyUpC0nJOZyXn5CGWfbaKP4X0Shy26WBetMcibpIYw=;
	b=fYOaR+w6crQ0osPd+ekqNMAOsQ0qScUA9M+rzNg9kJh1KEu/6azyIaCMAeEcg87ValB6Oy
	OJL+zSuC5lhAnYzS07FX5hcuaV6ndKmtpGlX5if+eT8C/EMdtVvKf/fA5hD6DRY4rmcOkN
	ojeoInGGbT/QcX/bqEiR33yXwZKLfqk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-VC6s401YO86WPD77jOGfTg-1; Thu, 18 Apr 2024 04:57:53 -0400
X-MC-Unique: VC6s401YO86WPD77jOGfTg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-349a31b3232so63394f8f.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 01:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713430672; x=1714035472;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOyUpC0nJOZyXn5CGWfbaKP4X0Shy26WBetMcibpIYw=;
        b=sUmyLqdj2N/4Rb6SKO5zUQetgYm9SI2fDRVHNZVyFNOPda1uZOMOLgQwCb0ka2dWPb
         JpTcptKjG1+v+yTksxyksYp84EsNFaH3/vhRxHapKqoTM6xmzdIlVrR+W89Nand51V6F
         U45/1W9z8auX9e7m2SCdbmfuq7FqnfEYyXJBtDMZMuqOC82G+oOQNr/3b2WQHthfLBQS
         jXWxjEta1jb5+IiqYWoFyM5SgDgChcXOqGz7fD2MJRO61gjrAqjbR1AlwEOEx/oF7Zbe
         r3/K6rR9zDkZ3o+Y4PoDK/mGKA680dkjL0VNq5nnDvGR0m8wpF/QpAAl85ygvbWVxdyI
         0/0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUZIu10iNT60zRCljY2nYJv5Loicqg4zpAV3OL1cWED1WRuA/doQpJdvTcRBZgY51O3xYGdbX70KlV7pl9jKvyjioj1fu8t
X-Gm-Message-State: AOJu0Yx2zQnL0bTfMwsFFpS/FYjsqxHZgxDcYUhM5qt78etMkkBo7Ad6
	mX6ajpZsR/CcsZJeZ+Sg6ugCpw96mIV25A1622479DUKVibTJtgBWU5yTgycL+W0CRBQuBDgZHm
	MWhQfyeZz775agrSN5vRGWAD6kftPpOVsJSKIOOPSLpJNHnIFFmLFww==
X-Received: by 2002:a05:600c:3baa:b0:418:90ac:3494 with SMTP id n42-20020a05600c3baa00b0041890ac3494mr1391983wms.2.1713430672432;
        Thu, 18 Apr 2024 01:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH/XI7qBUxMqVd5G7d6TJMXnMi7AAu0DZ2aNXvMucFw7XYLwkFqE+ST8gQrnfy1ZXTNrpw7gg==
X-Received: by 2002:a05:600c:3baa:b0:418:90ac:3494 with SMTP id n42-20020a05600c3baa00b0041890ac3494mr1391972wms.2.1713430672054;
        Thu, 18 Apr 2024 01:57:52 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-236-143.dyn.eolo.it. [146.241.236.143])
        by smtp.gmail.com with ESMTPSA id q15-20020a05600c46cf00b00416e2c8b290sm5862917wmo.1.2024.04.18.01.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 01:57:51 -0700 (PDT)
Message-ID: <9fae6b381dccd6566b6366c7090468bea1f5e1d7.camel@redhat.com>
Subject: Re: [PATCH v1 net 1/5] sit: Pull header after checking
 skb->protocol in sit_tunnel_xmit().
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: kuba@kernel.org, davem@davemloft.net, dsahern@kernel.org, 
 herbert@gondor.apana.org.au, kuni1840@gmail.com, netdev@vger.kernel.org, 
 steffen.klassert@secunet.com, syzkaller@googlegroups.com, willemb@google.com
Date: Thu, 18 Apr 2024 10:57:50 +0200
In-Reply-To: <CANn89i+raqGAERfsvxv9AM_AsgJNdnk3=YgLzf4guduj7G-s7Q@mail.gmail.com>
References: <20240417190432.5d9dc732@kernel.org>
	 <20240418033145.35894-1-kuniyu@amazon.com>
	 <CANn89i+y8yqXZ3OHdzo5FxgwNs-j24-4wiNZKr8pSG+tvbYV9g@mail.gmail.com>
	 <CANn89i+raqGAERfsvxv9AM_AsgJNdnk3=YgLzf4guduj7G-s7Q@mail.gmail.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-18 at 09:00 +0200, Eric Dumazet wrote:
> On Thu, Apr 18, 2024 at 8:56=E2=80=AFAM Eric Dumazet <edumazet@google.com=
> wrote:
> >=20
> > On Thu, Apr 18, 2024 at 5:32=E2=80=AFAM Kuniyuki Iwashima <kuniyu@amazo=
n.com> wrote:
> > >=20
> > > From: Jakub Kicinski <kuba@kernel.org>
> > > Date: Wed, 17 Apr 2024 19:04:32 -0700
> > > > On Mon, 15 Apr 2024 15:20:37 -0700 Kuniyuki Iwashima wrote:
> > > > > syzkaller crafted a GSO packet of ETH_P_8021AD + ETH_P_NSH and se=
nt it
> > > > > over sit0.
> > > > >=20
> > > > > After nsh_gso_segment(), skb->data - skb->head was 138, on the ot=
her
> > > > > hand, skb->network_header was 128.
> > > >=20
> > > > is data offset > skb->network_header valid at this stage?
> > > > Can't we drop these packets instead?
> > >=20
> > > I think that needs another fix on the NSH side.
> > >=20
> > > But even with that, we can still pass valid L2 skb to sit_tunnel_xmit=
()
> > > and friends, and then we should just drop it there without calling
> > > pskb_inet_may_pull() that should not be called for non-IP skb.
> >=20
> > I dislike this patch series. I had this NSH bug for a while in my
> > queue, the bug is in NSH.
> >=20
> > Also I added skb_vlan_inet_prepare() recently for a similar issue.
>=20
> Kuniyuki I am releasing the syzbot bug with a repro, if you have time to =
fix NSH
> all your patches can go away I think.

I agree a specific/smaller scope fix on in nsh should be preferred
here.

Thanks,

Paolo


