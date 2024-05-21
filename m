Return-Path: <netdev+bounces-97324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17A8CAC42
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 12:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 184AB1F211CE
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 10:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FDE200C7;
	Tue, 21 May 2024 10:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhMg8R+q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4377C14290
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 10:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716287593; cv=none; b=D6Cl2Jl6ozNOoB8k9EdmmIRq/mcFD8oR00/D754ivHyDU7K4///EE2hMzt7NrjGL7lXS9QAWWROPBfu8iQluczy+jlVNg3wWxrBGyPe3MT4miBXZMiB2GLprrn4a2FwOsIH3E9J4W03yR3U5arLVckI27fng+GQkRomC0GAaG5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716287593; c=relaxed/simple;
	bh=nKtZCK95q3WIA7a/neNnZykCH9FD3SoZ8Fu1Wu32e+o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TopFtRQDiA7/q+7gET8aep8xaCT1df0+BQrYvl7edoJagK/3JHqap4Viv8xdLvq+4tQUjQcP5dBaRtlYQJWOpzoCuml+hS62zmtI4xGhNrFUPnBWmoMrNR1Qj+veeHTevSyO3/fhRFlOpENuPms6KDBUvfeOZ9O11d3Wcem7NFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhMg8R+q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716287591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zprPOgGnQP55TZ56eaxD3hCEQCJeTwYwS5iOQZCPEco=;
	b=UhMg8R+q3DK2B+zdte1jfaKeKXzao8aYNAxXL+pZLn1cfh5WHiy/zEb1tO460s5jXdauD6
	WZ/oYPa1wT2uBGMIa7TrJGubIQptFXXKGqW2P5Ywtkvl/CyXDgKFG+zGYuLz05iypcuTzj
	aXCJTB5zW+JJKWe1y9uWx+quP5DU9oA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-GDGV_hvZO5GEsY7FRR8G9Q-1; Tue, 21 May 2024 06:33:10 -0400
X-MC-Unique: GDGV_hvZO5GEsY7FRR8G9Q-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-351d48fd1bcso638648f8f.3
        for <netdev@vger.kernel.org>; Tue, 21 May 2024 03:33:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716287588; x=1716892388;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zprPOgGnQP55TZ56eaxD3hCEQCJeTwYwS5iOQZCPEco=;
        b=IC8PQGIj0pNDQhoWSj5834/RDDvpQX1hNdibR8QlyOJPVFuk8gzr0yh3AYPinpDzIq
         17nOjjuOYcK9LSZwk2HLqfYamqVvTGlo7AdT6FhFsYUojvtb1QZSzHAevsBRheVQ/chY
         G1InKFCIcm/AeCQoYQV1mRGfQE9SfmjE9f84R8odpgFf/0k/RV7ykOIFHr+zhlslPOdu
         7A+svQCnQoC+pPIxGZ9ja0GCkribkTaOPmSIaSwN0FGCYKBRJVjAqPjYtnPU3jhakuNC
         ONCASJzvfR0zFbTknp/yqRDTbfuOBwy1g1nJQh9ILq1f1Tdhr8XG/p4YgrlfLVzsCy/d
         g/6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVN9m9Qb76LRhz735Sr1XiDBhK7zi3UPELFka7KX3mBiMCvmv1fnidIgBrTuTmOCPt+uOTZoqoTZPLImMxMLTW3xYk+ZEuP
X-Gm-Message-State: AOJu0YzTqhJH7kPby0p0Yhg0+YJlMtSAJmxIgpBALSC23zuJeOCrAIcc
	Zz9bTD2iUu4ALvUl3oDYg3jjU7Yhr1HxDsaCztkmu0e0rOc/ESewNe/7chBPC5bz/8PEBehejsr
	llJ35SJEYYuLb4fB+7btw0vJdL8U78Y0k/4euS5CXSb/wMrqEm0AfjlsEakqxSw==
X-Received: by 2002:a05:600c:3b86:b0:418:f770:ba0 with SMTP id 5b1f17b1804b1-41fea52ef14mr239542655e9.0.1716287588566;
        Tue, 21 May 2024 03:33:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPsVWYJusKzgO4kHGMvFlNH3SENvmzNTmKlXyWC+OT76rCUx5nyvxNzUqWFJyRmF1VtrPx/g==
X-Received: by 2002:a05:600c:3b86:b0:418:f770:ba0 with SMTP id 5b1f17b1804b1-41fea52ef14mr239542505e9.0.1716287588182;
        Tue, 21 May 2024 03:33:08 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b094:ab10:29ae:cdc:4db4:a22a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce25casm455622005e9.20.2024.05.21.03.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 03:33:07 -0700 (PDT)
Message-ID: <9c065f7fe03e158998289c88b9f99eb5336f9776.camel@redhat.com>
Subject: Re: Potential violation of RFC793 3.9, missing challenge ACK
From: Paolo Abeni <pabeni@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: hotaka.miyazaki@cybertrust.co.jp, netdev@vger.kernel.org
Date: Tue, 21 May 2024 12:33:05 +0200
In-Reply-To: <CANn89iLgAEPQF934aNFk5o0mhHUdYra8UYRFxep1oyqk3SsEtQ@mail.gmail.com>
References: 
	<TYAPR01MB64091EA3717FC588B4ACF045C4ED2@TYAPR01MB6409.jpnprd01.prod.outlook.com>
	 <1f42042dbfe9b413cded5e5d59cd3933ec08ed08.camel@redhat.com>
	 <CANn89iLgAEPQF934aNFk5o0mhHUdYra8UYRFxep1oyqk3SsEtQ@mail.gmail.com>
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

On Tue, 2024-05-21 at 12:12 +0200, Eric Dumazet wrote:
> On Tue, May 21, 2024 at 11:47=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >=20
> > On Thu, 2024-05-16 at 16:12 +0900, hotaka.miyazaki@cybertrust.co.jp
> > wrote:
> > > Hello.
> > >=20
> > > I have a question about the following part of the tcp_ack function in=
 net/ipv4/tcp_input.c.
> > > ```
> > >       /* If the ack includes data we haven't sent yet, discard
> > >       * this segment (RFC793 Section 3.9).
> > >       */
> > >       if (after(ack, tp->snd_nxt))
> > >         return -SKB_DROP_REASON_TCP_ACK_UNSENT_DATA;
> > > ```
> > > I think that this part violates RFC793 3.9 (and the equivalent part i=
n RFC9293 (3.10.7.4)).
> > >=20
> > > According to the RFC, =E2=80=9CIf the ACK acks something not yet sent=
 (SEG.ACK > SND.NXT) then send an ACK, drop the segment, and return=E2=80=
=9C [1].
> > > However, the code appears not to ack before discarding a segment.
> >=20
> > Note that in some cases the ack is generated by the caller, see:
> >=20
> > https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_input.c#L67=
03
> >=20
> > In any case not sending the challenge ack does not look a violation to
> > me, as the RFC suggest (it uses 'should') and does not impose (with a
> > 'must') such acks . Sending them back too freely opens-up to possible
> > security issue.
>=20
> Yes, this behavior was added in 2009, we lived 15 years with it.
>=20
> I do not see a pressing reason to send challenge acks here.
>=20
> Hotaka, please explain why this would help a valid use case (I am not
> speaking of broken middleboxes)
>=20
> >=20
> > side note, @Eric: it looks like we can send 2 challenge ack for half-
> > closed socket hitting RFC 5961 5.2 mitigations?!?
>=20
> Sorry, can you elaborate ?

Oops, I did not consider __tcp_oow_rate_limited() nor
FLAG_NO_CHALLENGE_ACK.

The code path I was looking at is:
https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_input.c#L6703
reaching:
https://elixir.bootlin.com/linux/latest/source/net/ipv4/tcp_input.c#L3874
Indeed no duplicate acks, sorry for the noise.

Paolo


