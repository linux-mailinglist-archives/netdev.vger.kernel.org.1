Return-Path: <netdev+bounces-97211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 693738C9FB7
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 17:31:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F5F92830A7
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 15:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4895E137748;
	Mon, 20 May 2024 15:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WsG4jaO+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987F1136E23
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 15:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219024; cv=none; b=rpm6DzROfeqyGmPo6/CKaiv7+785bZ+0YXDWybzqYzW6IZMeoPP0C1BLb1z8z3ikG/h9YWw3URC9xuZYDjeRnRSOOzPBn1xlfKNfmhPi19okWhWsxMUnTMvtgDKYHsXY65eSeHBWUkDfKuuNhCkLDKLejGhANf0u1G/l3MA6isg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219024; c=relaxed/simple;
	bh=0xxEY/076LFSqn8mhpD4UdPG6sakA19AY0itCemv52s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MWgWA23XrW5TG0yWeQTjHm4eeVSfZ/Wuj4FoCu4dw4KdX/VwjHo1mcKxLm3rXEwLJaYMRkBU2Quj8WOQ9UNfQ7WHqbfIjWkNfh80oT1MoRhLCDUAnsugtGse6DkwpfzvEUiROF1C25kP/YUG545wbTTFm4qfuic+lxvxvfpg+/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WsG4jaO+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716219021;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0xxEY/076LFSqn8mhpD4UdPG6sakA19AY0itCemv52s=;
	b=WsG4jaO+QT8GieJ6zrgcgQ1hQLN7LpsjzRqQC27lTg7TISQmnCkPZALgcLpobYSGU2AAc/
	PfPh4gms3UXkb6g3lW4V5LKBCxGGrVptvm1lREu597rH3BDfELp91iO91q+3rZmjPaDsP1
	hYNUPzLR/+8wOlu+bBEmNl23PgDTRe4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-9CN57DYGMmODaH6H97dtnQ-1; Mon, 20 May 2024 11:30:20 -0400
X-MC-Unique: 9CN57DYGMmODaH6H97dtnQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-34d92c4cdd9so1402557f8f.0
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 08:30:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716219019; x=1716823819;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0xxEY/076LFSqn8mhpD4UdPG6sakA19AY0itCemv52s=;
        b=oaLiIqFF/YCueJridRNZOVnPBKGyv2NjmDKZFswOprvUy+1C1YZ86I4ZIG8oFEB2sZ
         n7YebyvwajeEXquf4xWvaILc8bCMLfaNl1w2HuoDJFgYp4SfTFoKqiQl178HwcHc86rp
         VXBR4ObpNEBnSWwqoKGJeic5OBaTuaPhqoudUjlS016Y6Iq7ZYTNBDD108VTkRPZxoTr
         si5FRYB2WbNOuVgpixUvJy2XfYpCIwV+yterIlEJu00cgBbp+Nwq/AwIrO8wUf0Fr9dm
         XW+clhM5iQ19Ca5xPnPpd16AqbW6Xp4l3sSxav4cK4wtAQtYLeh7zey/dtsKfID3o88V
         RUAQ==
X-Gm-Message-State: AOJu0Yz7hUDrWyLTKifPv3M3E+Tj2r86BPPX8qdCUFT9ALJ5aXXvKUeZ
	oX7mfj67rS8ZcV6zbM4FqlALxagBpKnGXBk+mvQ3qGm4DhEjb81JxXvjQho4BCeKMz5h+vXfz/9
	DXJ/lQ/SXFrp9UnbfxRnFXYW1VOrazt/jp7ZzFEL798J+88jlJaop+w==
X-Received: by 2002:adf:faca:0:b0:34d:707c:9222 with SMTP id ffacd0b85a97d-3504a633102mr21491936f8f.2.1716219018881;
        Mon, 20 May 2024 08:30:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGZZWIVd8pMrrJtpqHS+WGplidwHr8e/Q2cU0ODjqlNo4INHmDWGstN2N+gKfYkp7cRJZOdQ==
X-Received: by 2002:adf:faca:0:b0:34d:707c:9222 with SMTP id ffacd0b85a97d-3504a633102mr21491917f8f.2.1716219018462;
        Mon, 20 May 2024 08:30:18 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10::f71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35332a5f36bsm9417427f8f.60.2024.05.20.08.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:30:18 -0700 (PDT)
Message-ID: <3410304ae2006ce9d8816429c2423591f8a9317e.camel@redhat.com>
Subject: Re: [RFC PATCH] net: flush dst_cache on device removal
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, David Ahern <dsahern@kernel.org>, Sabrina
 Dubroca <sd@queasysnail.net>
Date: Mon, 20 May 2024 17:30:16 +0200
In-Reply-To: <CANn89iKg4p+ZgW36mKf-843QGydw0g_jxvti86QJOoxCyB0A8A@mail.gmail.com>
References: 
	<13bccadd7dcc66283898cde11520918670e942db.1716202430.git.pabeni@redhat.com>
	 <CANn89iKg4p+ZgW36mKf-843QGydw0g_jxvti86QJOoxCyB0A8A@mail.gmail.com>
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

On Mon, 2024-05-20 at 15:54 +0200, Eric Dumazet wrote:
> On Mon, May 20, 2024 at 1:00=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >=20
> > Eric reported that dst_cache don't cope correctly with device removal,
> > keeping the cached dst unmodified even when the underlining device is
> > deleted and the dst itself is not uncached.
> >=20
> > The above causes the infamous 'unregistering netdevice' hangup.
> >=20
> > Address the issue implementing explicit book-keeping of all the
> > initialized dst_caches. At network device unregistration time, traverse
> > them, looking for relevant dst and eventually replace the dst reference
> > with a blackhole one.
> >=20
> > Use an xarray to store the dst_cache references, to avoid blocking the
> > BH during the traversal for a possibly unbounded time.
> >=20
> > Reported-by: Eric Dumazet <edumazet@google.com>
> > Fixes: 911362c70df5 ("net: add dst_cache support")
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>
> > ---
> > I can't reproduce the issue locally, I hope somebody able to observe it
> > could step-in and give this patch a shot.
> > ---
>=20
> H Paolo, thanks for your patch.
>=20
> It seems dst_cache_netdev_event() could spend an awful amount of cpu
> in complex setups.

I agree.

> I wonder if we could instead reuse the existing uncached_list
> mechanism we have already ?

Then rt_flush_dev()/fib_netdev_event() will use a similar amount of
time, right? Or do you mean something entirely different?=20

On the plus side it will make this patch much smaller, dropping the
notifier.

> BTW it seems we could get rid of the ul->quarantine lists.

I think 'quarantine' is used to avoid traversing multiple times the
same/already blackholed entries when processing multiple
NETDEV_UNREGISTER events before the dst entries themself are freed.
Could it make a difference at netns disposal time with many dst and
devices in there?

Cheers,

Paolo


