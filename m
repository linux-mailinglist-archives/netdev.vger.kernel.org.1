Return-Path: <netdev+bounces-77419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B28871BF9
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 11:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 156FAB22F4B
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAB05916A;
	Tue,  5 Mar 2024 10:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LPGAb3FK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AE85915D
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 10:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709635008; cv=none; b=c/m2wixm386prkdV3iDGs/WApIrdvemftBEwDJvnonz/nZ35hDdKCx4nEnbVMi2kha39boNrToYk8aojHio6Z71CtMg4oTXC4RTlMB3K5pst0WolxA7GXQilLusu1lq3cIX1vNQN6T/608z31bDuCq9avY4hNmIZVrWZr4jOZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709635008; c=relaxed/simple;
	bh=eXkMQ2C0mC47Na7imDm/S3EKZLg5feMrOdPPE5cUdIo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gz7oz3V2X9j5kyJpWjaFovOeH7kl7nUWIJVhM6jA/FMctVdsm9qp2YhKQ/qXds1H1W2filOKQA0ZdIm8dhmzAAnxnw6NTE7LMkAa1F1xAsQBYlPmazQeCqLkHnilLKpwvGR05jtxm8q8sjYky+i54MQCI8a0qNdeT49VhgD8ny0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPGAb3FK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709635006;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T+iAiqiM3/ML7WhicB7tdkDJ7/RXgUQTUMdLpGQB+Pg=;
	b=LPGAb3FKnl99Ls0xfNluTCREsj0RIQ1+jvvvOcOgKqGENuipiyLvUutzFVcQmMMrd6mte8
	bwHGWorJNGXuU1g8yQwIh+rf4E2BXchKkUBOZy1eR2Q4OfEogd5fDtJMhWZtAlzMYUG92R
	OPga7rLXD/S/3lKr30pqNNTBWlofLvg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-Ys1skEp3NEa_1M3Hoew33A-1; Tue, 05 Mar 2024 05:36:42 -0500
X-MC-Unique: Ys1skEp3NEa_1M3Hoew33A-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33dd1c59918so530164f8f.0
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 02:36:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709635001; x=1710239801;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+iAiqiM3/ML7WhicB7tdkDJ7/RXgUQTUMdLpGQB+Pg=;
        b=GDCI+YUgYe3qZc5eYHjOW+mJNr363zYF/bYMnpbA1ETW5zz+NiVsnZb++6PPmP5zfm
         bi+nANGT/1jfXDnZldB+mEKNb+pff5h+0TtG/l4qW9C/Q16DuaT2fKCi5eQ+cCrbXzmO
         N4pThwQPrpEWqqJqBGQIId4vgSOur2xLMORDnIzvuAXthcGJinl/oCozdYor/olaifB/
         OSVkVPEXDtXSoP2Y9+g+xRSKEJq0GT/zgy8csphmw9VBALeOL6/RyJF2/g02cllZHnOF
         eT6m0jG/6fCc05GYgLfvPyVS9QUVJmFwXXrswzcmJUQn2h1+B1UZu+M0CF6LLp9dYlTf
         vkZA==
X-Gm-Message-State: AOJu0YztUQy5j+EwMva1/zu+PiyZppwGfVqWq6IXyMkGQmOC5QRrwG8z
	WuxcCZHjy5HRszQ+CIT50Iy5Z5NTV/JiDM26yqkjQvmpEc9q21Aa1hhwCikONOPwABYOwRSZwz4
	kST6KqIlFcFT0j77NjprkrcP6JmTsdTavoBvGDpDC1EwT5ERFwCvnKA==
X-Received: by 2002:adf:e78c:0:b0:33d:9ee1:48db with SMTP id n12-20020adfe78c000000b0033d9ee148dbmr8561184wrm.2.1709635001373;
        Tue, 05 Mar 2024 02:36:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeWOa89pIlSUpSCxENgvluf3rtQSXDIdzkncGln9XO+fDZZm031MdhP2QVZge/dml56pKiTw==
X-Received: by 2002:adf:e78c:0:b0:33d:9ee1:48db with SMTP id n12-20020adfe78c000000b0033d9ee148dbmr8561168wrm.2.1709635001019;
        Tue, 05 Mar 2024 02:36:41 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-235-19.dyn.eolo.it. [146.241.235.19])
        by smtp.gmail.com with ESMTPSA id bv28-20020a0560001f1c00b0033d70dd0e04sm14850783wrb.8.2024.03.05.02.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 02:36:40 -0800 (PST)
Message-ID: <3aa17b8d72f8d4605d1cccb7692cc152b77d7f87.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 3/4] net: Use backlog-NAPI to clean up the
 defer_list.
From: Paolo Abeni <pabeni@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Wander Lairson Costa <wander@redhat.com>, Yan Zhai <yan@cloudflare.com>
Date: Tue, 05 Mar 2024 11:36:39 +0100
In-Reply-To: <20240305102535.Mw-yj_ra@linutronix.de>
References: <20240228121000.526645-1-bigeasy@linutronix.de>
	 <20240228121000.526645-4-bigeasy@linutronix.de>
	 <8f351363c3beaf84a3cb54643b02b0981b9e782c.camel@redhat.com>
	 <20240305102535.Mw-yj_ra@linutronix.de>
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

On Tue, 2024-03-05 at 11:25 +0100, Sebastian Andrzej Siewior wrote:
> On 2024-03-05 10:55:45 [+0100], Paolo Abeni wrote:
> > On Wed, 2024-02-28 at 13:05 +0100, Sebastian Andrzej Siewior wrote:
> > > @@ -4736,6 +4736,26 @@ static void napi_schedule_rps(struct softnet_d=
ata *sd)
> > >  	__napi_schedule_irqoff(&mysd->backlog);
> > >  }
> > > =20
> > > +void kick_defer_list_purge(unsigned int cpu)
> > > +{
> >=20
> > Minor nit: I guess passing directly 'sd' as an argument here would be
> > better, but that could be a follow-up.
>=20
> I need the CPU number in the "non-backlog threaded" case for
> smp_call_function_single_async(cpu, ). sd->cpu has the CPU stored but
> only in the CONFIG_RPS case. In the theoretical case +SMP -SYSFS we
> wouldn't have RPS but would need this CPU member.

To clarify: I'm suggesting passing both arguments.

Cheers,

Paolo


