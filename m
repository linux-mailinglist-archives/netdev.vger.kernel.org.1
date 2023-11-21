Return-Path: <netdev+bounces-49601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4CD7F2B1C
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 11:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7698A2825B1
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 10:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96083482C9;
	Tue, 21 Nov 2023 10:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YohrnUds"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BBA11A
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700564341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZlG9WPRpH5aLXxN0geSA1wmhi349BNl6rxlB9y+EYI8=;
	b=YohrnUdsT2ps/13eLXkFY2X2uZuuNGFPgdKiVyfCrqiqcr022o3BuPVsWwKd3T5SqFai7k
	RforfgDf5JAqZHVHdSny9DSBF25y2Z0q3szhYeWuURdOioEckczneBeuK73tdGekxuglBa
	/fJPTIhtJy/YCnAm/o0vGIdLVDCaczg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-HKv1XvUHNYKUPXgg8juIxA-1; Tue, 21 Nov 2023 05:58:59 -0500
X-MC-Unique: HKv1XvUHNYKUPXgg8juIxA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9ff9b339e8cso16610466b.1
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 02:58:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564338; x=1701169138;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZlG9WPRpH5aLXxN0geSA1wmhi349BNl6rxlB9y+EYI8=;
        b=HihqzTIsFrvZMvIx2WyIh69KQfa5sSnK1Ts9agKK8qZ4bIWeCuW+8wa9DZdFWz19gv
         UbHpcJn8DcS/7VENaRsbiRMAhHDv92bBHbm++BkIEhN18++9wV9TNqhmSxUWwW2ABYFS
         od1bF11muwuIOQEqqgZ0hSx9ssxcfKnQ4pQc1ADYfySEPpZ+1VC/JsMkCd9UhHgMGUCv
         BPqNaDwGDWyOQt1h+J4gmZ1VQcQHM6y6PVNd/hrVVCCp4qlrX6oGEA5RDumcdc4JG0Vg
         ICKXjJ607uZ8h1bY4daZ8W75mgB3j5Rq1CNP0ytGdVPF1edHw9eofBBFISnOM15MfYMv
         9gGQ==
X-Gm-Message-State: AOJu0YyGdI0Gdmrx3rjk+LMaqkyjnurHXycgl7dcsshyVlE1d4o0vC7j
	/ZCOKdRhxFEB8H/iDqUTUwM4k0zFMASWSbDxdJIGh2VwXE8uy+H//5Owzi/lw0sKLYa/GZacgXm
	L05sjVr6ShNeELr+d
X-Received: by 2002:a17:907:78d5:b0:a01:b9bd:87a with SMTP id kv21-20020a17090778d500b00a01b9bd087amr1071758ejc.7.1700564337997;
        Tue, 21 Nov 2023 02:58:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEAG5ipzdlI8GZfIF0WyvN4yVli0RfO8w5wk/nbUnc7CLOu/xfgWAvds4G/6A6bAIl7P5Wpqg==
X-Received: by 2002:a17:907:78d5:b0:a01:b9bd:87a with SMTP id kv21-20020a17090778d500b00a01b9bd087amr1071737ejc.7.1700564337586;
        Tue, 21 Nov 2023 02:58:57 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-234-2.dyn.eolo.it. [146.241.234.2])
        by smtp.gmail.com with ESMTPSA id qu14-20020a170907110e00b009fc6e3ef4e4sm3031062ejb.42.2023.11.21.02.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 02:58:57 -0800 (PST)
Message-ID: <4b534e6aab6e4cf461f07680466f146e65b3fb25.camel@redhat.com>
Subject: Re: [PATCH 0/2] usb: fix port mapping for ZTE MF290 modem
From: Paolo Abeni <pabeni@redhat.com>
To: Lech Perczak <lech.perczak@gmail.com>, netdev@vger.kernel.org, 
	linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>
Date: Tue, 21 Nov 2023 11:58:56 +0100
In-Reply-To: <08e17879fe0c0be1f82da31fdb39931ed38f7155.camel@redhat.com>
References: <20231117231918.100278-1-lech.perczak@gmail.com>
	 <08e17879fe0c0be1f82da31fdb39931ed38f7155.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-11-21 at 11:49 +0100, Paolo Abeni wrote:
> On Sat, 2023-11-18 at 00:19 +0100, Lech Perczak wrote:
> > This modem is used iside ZTE MF28D LTE CPE router. It can already
> > establish PPP connections. This series attempts to adjust its
> > configuration to properly support QMI interface which is available and
> > preferred over that. This is a part of effort to get the device
> > supported b OpenWrt.
> >=20
> > Lech Perczak (2):
> >   usb: serial: option: don't claim interface 4 for ZTE MF290
> >   net: usb: qmi_wwan: claim interface 4 for ZTE MF290
>=20
> It looks like patch 1 targets the usb-serial tree, patch 2 targets the
> netdev tree and there no dependencies between them.

Sorry, ENOCOFFEE here. I see the inter-dependency now. I guess it's
better to pull both patches via the same tree.

@Johan: do you have any preferences? We don't see changes on=20
qmi_wwan.c too often, hopefully we should not hit conflicts up to the
next RC.

Cheers,

Paolo


