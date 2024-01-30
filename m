Return-Path: <netdev+bounces-67375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D43D84310E
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 00:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7486C282EA0
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 23:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9FB114F78;
	Tue, 30 Jan 2024 23:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HhCzzit2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC867EF06
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 23:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656915; cv=none; b=Iyzs/FibuppVeuHY79mfn1R310gu7cqO+2ffDMEdL6wW1yvGAPaEYfT0PyuxYEyP///aQcOKwrzgNSqSgk542dwYycOFae1utnzPRk3JBdcHTmyUB+OZ8XX9Djt/JjBweHicSUUISzemBBCnkScNPO8ydjzUqxD6qpz9eUp4eS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656915; c=relaxed/simple;
	bh=Ge0Y3b9mg8alEuUZm8pS45nDEZdashCHWIVl60GnCP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YCilvVh3s0jnP6Ladjv/JFJkRNOkggt9J1PNsrqgxpCaSI7SzNXPmpHsFQb5hjYGfYc1JRuES1zYw5VMd1pZFGNh3vdwrsp8Rx4PRYTcvbRexAAddRzC1QyZtizmHujXxVq5N043yxb077kNERu+Y8iVXFGhRl/otLeWo5srpAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HhCzzit2; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d057b6ddfdso17354991fa.2
        for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 15:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656912; x=1707261712; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ge0Y3b9mg8alEuUZm8pS45nDEZdashCHWIVl60GnCP4=;
        b=HhCzzit2XgL/QVcMGlCo/2WKAOaxVEuZExgeRArKQDrS8On6fqyv4zI3zo97yjb6rs
         3z2XwyNcwGH/8ElsLTu84Y1FF99KLp43fOBZOEA9ZVUwvB24ieNITWT7rl0WgRwHyh2l
         MWqr8OQrWlevt3nyxpwp+YBfs/LISPciynDvvJvyxQ9u15MBNpIy95jY8kjUFp+BGbcl
         R9BhIBSKWZlBYntsfsfD1HCTFmuu/MfqBIW1RHsyH6FK029h42i7gZp5xReftDlIDmDI
         cZvs9KoF1b7AADxLMXTKToGF9ZPD/E+q1vcsZul1AQ7YcicopZYIQfT604fGeodrgGA3
         XWmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656912; x=1707261712;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ge0Y3b9mg8alEuUZm8pS45nDEZdashCHWIVl60GnCP4=;
        b=Aoh1tvczEU+XqGTNl5W53d8rJxIjKB8qgXrH9dwOaTr46BPZrpfMeM6RpI0Vb+FpHW
         y7vuKBJwRiRp0N0/0NNexWwKJbKNkCednQ7tM0VNL7Ljv0I81HuyVwKKg8kLIWkiHlnS
         zCdHhiT6s+W0wpbGfOhxSUelU67wqZuUCJNEOA7ATpuoi1gCgMt6Nz56nHLenvEWU29l
         HsUez8xGbyIl8PO350laWi9mvUymFF5BraKopFF2o4YMf044BI5h8tQwhpUjBqsPBgRE
         zSaWxeGDUflaOgJguQ/0rO1iLykl+1+OVcjmpbwCqRMTidStAnAzFB8Z3yYoO0rPgDF+
         lN6Q==
X-Gm-Message-State: AOJu0Yx8TTMnDo1SlM9efszWRryrxmmPrSnwOyBZQsGnxL6uOAC/jUKh
	CK8GYoqlNvl/hqd4/8fZrPEWvgVtK/0sUHfXBZgqFK9TmeF25kzrwQjEXvVczI6tAuiHnmYt1Ix
	61BAzTmHPk67NVFO1pEaaJAOnrVw=
X-Google-Smtp-Source: AGHT+IEg+pc6BnWqkZIdmUB8NbCDEMChSVkVjwuzM+9HGMYcKpRiEwCQDt4mF97jbO9M2InxSoINvNC9ZB4I9ePdf4Q=
X-Received: by 2002:a05:651c:a06:b0:2d0:63b6:e93c with SMTP id
 k6-20020a05651c0a0600b002d063b6e93cmr555743ljq.20.1706656911938; Tue, 30 Jan
 2024 15:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20240115215432.o3mfcyyfhooxbvt5@skbuf>
 <9183aa21-6efb-4e90-96f8-bc1fedf5ceab@arinc9.com> <CACRpkdaXV=P7NZZpS8YC67eQ2BDvR+oMzgJcjJ+GW9vFhy+3iQ@mail.gmail.com>
 <ccaf46ca-e1a3-4cba-87eb-53bf427b5d68@arinc9.com> <20240129-astute-winged-barnacle-eeffad@lemur>
In-Reply-To: <20240129-astute-winged-barnacle-eeffad@lemur>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 30 Jan 2024 20:21:40 -0300
Message-ID: <CAJq09z4JZGaEBwus=Bmt95TWCtX6Y6EaqRHeo6iHqpD5hiRFbw@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/8] net: dsa: realtek: variants to drivers,
 interfaces to a common module
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	alsi@bang-olufsen.dk, andrew@lunn.ch, f.fainelli@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

> > I've had trouble with every mail provider's SMTP server that I've ever used
> > for submitting patches, so the web endpoint is a godsend. It would've been
> > great if b4 supported openssh keys to submit patches via the web endpoint.
>
> The only reason it's not currently supported is because we don't have a recent
> enough version of openssh on the system where the endpoint is listening. This
> will change in the near future, at which point using ssh keys will be
> possible.
>
> > Patatt at least supports it to sign patches. I've got a single ed25519
> > openssh keypair I use across all my devices, now I'll have to backup
> > another key pair. Or create a new key and authenticate with the web
> > endpoint on each device.
> >
> > Safe to say, I will submit my next patch series using b4. Thanks for
> > telling me about this tool Linus!
>
> \o/
>
> Please feel free to provide any feedback you have to the tools@kernel.org
> list.
>
> -K

+1 to b4 users: v5 just sent using b4. Great tool.

Regards,

Luiz

