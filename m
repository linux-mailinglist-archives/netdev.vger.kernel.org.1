Return-Path: <netdev+bounces-56428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9156880ED3F
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 14:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E222B20BB5
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 13:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CEB61680;
	Tue, 12 Dec 2023 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnI+7MND"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E147129
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702387112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtAY/8Q29keHt7QBoc7eICnjFln2HFGD2DIjEnbsd1I=;
	b=VnI+7MNDuz90qQww75/4W8UoDJZwf9SBa2ZuCVEztQ8sZGr69eXxKrXx8pcbI/ot+Mvi1h
	EIsFaoo+hBGqQ8yER9Mer+Wb6EocBEis11cbfDUnfk7nVc5L4HZd+2VYgAK1dNzH01zizH
	/pwKUx7QkszGkaSDQ/CU3Pfv/4L7rRg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-faQ91B_xMUWFQzqEId62Yw-1; Tue, 12 Dec 2023 08:18:31 -0500
X-MC-Unique: faQ91B_xMUWFQzqEId62Yw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2cc31ee9981so49381fa.0
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 05:18:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702387109; x=1702991909;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YtAY/8Q29keHt7QBoc7eICnjFln2HFGD2DIjEnbsd1I=;
        b=l8q2Y7jzqq+egxTJXI4QK48A1JRLU90+Rte6+SgVLgznEjOrGoFfWJqLGCZcYjWzMy
         ZmQnp+uzmCd3/2Y+DUsYOCJkkPz+BiC6iyqzmfMoVg5YkiqgW5RYw5YIuOfL9S9+rNkL
         t37jnv6+Vs7WQ1iDq16Uqi8qdtH1NE19xXOmu3KovVgdPJUhXyKuMGiN9HyCS8qxjXQ1
         mr0BRohIXYL34rjdriUx9nDHeiFsGlkjFUA+IPsfegh5XFRJ5R6PlFfgqKBMntNPvB9z
         +3ybbXbVo1qaYcN3GvH3uDzb4nfJgOakrfWMkUm8cyCUiRwrfkvl14KJKX+uyFeRhblU
         UOxw==
X-Gm-Message-State: AOJu0YxbU97A2al/ZelMZozSYxi9sN78gHQAgVCc42bTZznH/BtULiHv
	RLg0MrU36bk2PqlgWSYIa3aneSVY6WDwAHnq6R+t9iqJEKJOqXXg+1thYwZPq6kSGw7DB+MXjvV
	IaWFwfz3pl3NviAjA79tWcEpM
X-Received: by 2002:ac2:5f99:0:b0:50b:fea2:29c with SMTP id r25-20020ac25f99000000b0050bfea2029cmr4620139lfe.6.1702387109505;
        Tue, 12 Dec 2023 05:18:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFWUIyyGidc4iOeWtSOGBALG4qvZLnE7/PtKfgojArm+pEG1pi9RRlNo2w4Kx4/ZwXfGmP68g==
X-Received: by 2002:ac2:5f99:0:b0:50b:fea2:29c with SMTP id r25-20020ac25f99000000b0050bfea2029cmr4620130lfe.6.1702387109123;
        Tue, 12 Dec 2023 05:18:29 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-249-182.dyn.eolo.it. [146.241.249.182])
        by smtp.gmail.com with ESMTPSA id vw18-20020a170907059200b00a1712cbddebsm6216701ejb.187.2023.12.12.05.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 05:18:28 -0800 (PST)
Message-ID: <525abd42a7a5b45bb70e184b9c3e6b7e37b48339.camel@redhat.com>
Subject: Re: [PATCH net-next 2/2] net: dsa: realtek: Rewrite RTL8366RB MTU
 handling
From: Paolo Abeni <pabeni@redhat.com>
To: Linus Walleij <linus.walleij@linaro.org>, Alvin =?UTF-8?Q?=C5=A0ipraga?=
 <alsi@bang-olufsen.dk>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Date: Tue, 12 Dec 2023 14:18:27 +0100
In-Reply-To: <ddeff631a676d2763eb42fa620672c57743c514e.camel@redhat.com>
References: <20231209-rtl8366rb-mtu-fix-v1-0-df863e2b2b2a@linaro.org>
	 <20231209-rtl8366rb-mtu-fix-v1-2-df863e2b2b2a@linaro.org>
	 <ddeff631a676d2763eb42fa620672c57743c514e.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-12 at 14:16 +0100, Paolo Abeni wrote:
> On Sat, 2023-12-09 at 23:37 +0100, Linus Walleij wrote:
> > The MTU callbacks are in layer 1 size, so for example 1500
> > bytes is a normal setting. Cache this size, and only add
> > the layer 2 framing right before choosing the setting. On
> > the CPU port this will however include the DSA tag since
> > this is transmitted from the parent ethernet interface!
> >=20
> > Add the layer 2 overhead such as ethernet and VLAN framing
> > and FCS before selecting the size in the register.
> >=20
> > This will make the code easier to understand.
> >=20
> > The rtl8366rb_max_mtu() callback returns a bogus MTU
> > just subtracting the CPU tag, which is the only thing
> > we should NOT subtract. Return the correct layer 1
> > max MTU after removing headers and checksum.
> >=20
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>=20
> FTR, my understanding is that the possible MTU API changes still under
> discussion, are somewhat orthogonal to this patch, which is suitable
> as-is for net.

Typo above -> 'net-next'.

>=20
> I'm applying this fixes right now.
>=20
> Cheers,
>=20
> Paolo=20


