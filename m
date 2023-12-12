Return-Path: <netdev+bounces-56427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E155580ED0E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DA2C1C20A87
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:16:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17E61676;
	Tue, 12 Dec 2023 13:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iEft57K0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6647109
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702386983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=31wrvrreNEeInHOXuhN21MS2MQUmzm4Dvi8rAQtOaUU=;
	b=iEft57K0li+n2oYWmapKmUdoKisQAd775nkwOKneGAMbVRH7jbCp1ga7NJLWt8eXRityq0
	YDSDrFtckvk5cXEjmhPX30d8+Jv8kqhpyp1WcHFpc9Mp4s95MSWYZ9hm7Uu03sDIINAGVP
	l9li2w5v81o8330/W/4UqOjh9Btn5mw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-ZqFNwAp2Pmmii8oYuHD0_g-1; Tue, 12 Dec 2023 08:16:21 -0500
X-MC-Unique: ZqFNwAp2Pmmii8oYuHD0_g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1d27c45705so121206866b.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:16:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702386980; x=1702991780;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=31wrvrreNEeInHOXuhN21MS2MQUmzm4Dvi8rAQtOaUU=;
        b=Jj4S0QprWIkcqeJtTVVVN5dmy/sA502m3IKWHeXonWJYxQ0OGgHQHGxhnDe+sdRXIP
         1fiMlhneBOUVwuC09QoaIB8H3rjZMs1HKqzVv5WQguGutXUE5gTjQBy1B+msHtuZ0w5L
         XpI2WNXyiklfZv3c9jYwOVrRQ6G6iHrSISlDtDl9IY2lZFhfraWQA3Htd+67eDlquhzy
         OpcAPwddxQ5A9jQecV6XC4ASmp2WkMFjllkiv74y4WZxDI2r6ySxPcg7inXcVoemOUxd
         SI8SN3iZUQDrapHCUhMXCvq5tCLbkgqJq1e2+l2HbmeoUGZB9ZBtldsq6YEeb3Lr4yM5
         xb2Q==
X-Gm-Message-State: AOJu0YylHxm6UdqNlOSdsoxfHr/KNT3IP5VqkLiumW7sw1cZ3M2vWmlD
	eS4ZKCuMm4ev19rqfrxWQChnaYxHBkGoagiW6ZKsDURo8WebM1MHCQ1swtGhZorOyIaCsG+Kuvm
	78C7howKdmkLHaWkltABpPxHA
X-Received: by 2002:a17:906:99cf:b0:a1c:5944:29bb with SMTP id s15-20020a17090699cf00b00a1c594429bbmr6450387ejn.7.1702386980289;
        Tue, 12 Dec 2023 05:16:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG2ZLRjLhUTpIIGlTgfEva2UaraTVf0p1iAzwo3/M7gSzZ2erm9hLDOHhzvdgR1wjPWws1Shw==
X-Received: by 2002:a17:906:99cf:b0:a1c:5944:29bb with SMTP id s15-20020a17090699cf00b00a1c594429bbmr6450367ejn.7.1702386979905;
        Tue, 12 Dec 2023 05:16:19 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id ub26-20020a170907c81a00b00a1c96e987c4sm6307592ejc.101.2023.12.12.05.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:16:19 -0800 (PST)
Message-ID: <ddeff631a676d2763eb42fa620672c57743c514e.camel@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: realtek: Rewrite RTL8366RB MTU
 handling
From: Paolo Abeni <pabeni@redhat.com>
To: Linus Walleij <linus.walleij@linaro.org>, Alvin =?UTF-8?Q?=C5=A0ipraga?=
 <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Date: Tue, 12 Dec 2023 14:16:18 +0100
In-Reply-To: <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
	 <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2023-12-09 at 23:37 +0100, Linus Walleij wrote:
> The MTU callbacks are in layer 1 size, so for example 1500
> bytes is a normal setting. Cache this size, and only add
> the layer 2 framing right before choosing the setting. On
> the CPU port this will however include the DSA tag since
> this is transmitted from the parent ethernet interface!
>=20
> Add the layer 2 overhead such as ethernet and VLAN framing
> and FCS before selecting the size in the register.
>=20
> This will make the code easier to understand.
>=20
> The rtl8366rb_max_mtu() callback returns a bogus MTU
> just subtracting the CPU tag, which is the only thing
> we should NOT subtract. Return the correct layer 1
> max MTU after removing headers and checksum.
>=20
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

FTR, my understanding is that the possible MTU API changes still under
discussion, are somewhat orthogonal to this patch, which is suitable
as-is for net.

I'm applying this fixes right now.

Cheers,

Paolo=20


