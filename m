Return-Path: <netdev+bounces-53835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2572A804CF7
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 603DF1C20A7C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 08:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47B93C082;
	Tue,  5 Dec 2023 08:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9xIgFcd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A789C9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 00:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701766359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ggt5TQtKw8wdsaLZ+DT3DsKtIaXBdioHGD1Zpjt0anw=;
	b=W9xIgFcdixrrY6vWUh5yN4EGHvEXCY2XGEt6KFUCsR+2YAGKp/nNdzPfjeDakaMx7QetO9
	YvvnMmVXx1D3HvkvSK7TAHQIQ4fDKsuayaW+/6FuSU53fWuJeuh4wuNh2+oYH0szJBZZZW
	ACmhbm7SYhU8dGnnBhkqy7h9LzjXEro=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-YJQI4UklPimyK-mWeNPrRg-1; Tue, 05 Dec 2023 03:52:37 -0500
X-MC-Unique: YJQI4UklPimyK-mWeNPrRg-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a18c4299e18so105602366b.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 00:52:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701766356; x=1702371156;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ggt5TQtKw8wdsaLZ+DT3DsKtIaXBdioHGD1Zpjt0anw=;
        b=nRwRkGAL6+yMaNmMwdjPD96h3TOhnMd8iq/X4mTVzX99Ty8FylOxdiJQDLrGIGNj1U
         6DkcT2RTRE40PP7PSf41blrQ/HdQLSBBhjpTTfCrnq9tfpmmgDciIPMak51b8h3jFWlO
         sg48C7Qcf+lWEEE3ynNpQHiBdSVRRuGPCpWTAkSO2RLs0qq+R3q5LCIIMtE2Rv0kps7n
         9au++ZidBkU1GG/PZMwqw2JLPmYas+hBI9KVirxK1WWhcxFcqQN7djJk6pcEp9mg0oBb
         yB8ToHFE1qNmI17/BcWVyRB1lYvnMgxfozPEvTF2JZJPIzDA1JBtEyXSqKLy5wnZqK6j
         5nJg==
X-Gm-Message-State: AOJu0Yw1eqT5PfsQse/bgNVwu2rgt/17Aqu6u+Hv3UmQbln72746nCN3
	lhQd7RamBaQROkzsJO3DwjvsIdrQFArEbr4+SGJpmyescXNhRL03FdJvx390KVBxuk7xu0l0ljj
	SPhivSRwLqATXCXwi
X-Received: by 2002:a17:907:d07:b0:a1b:8414:3dd9 with SMTP id gn7-20020a1709070d0700b00a1b84143dd9mr3791232ejc.4.1701766356683;
        Tue, 05 Dec 2023 00:52:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2vCXZmkO21aHC6g7OzC3qT1Ix9CybEzwOD5pQACArBsooBX3lDNhpTUmdgmM/auMCa/8yaA==
X-Received: by 2002:a17:907:d07:b0:a1b:8414:3dd9 with SMTP id gn7-20020a1709070d0700b00a1b84143dd9mr3791214ejc.4.1701766356389;
        Tue, 05 Dec 2023 00:52:36 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-241-54.dyn.eolo.it. [146.241.241.54])
        by smtp.gmail.com with ESMTPSA id c5-20020a170906d18500b00a1859bc527fsm6455327ejz.10.2023.12.05.00.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:52:36 -0800 (PST)
Message-ID: <1f1c04902562c58736862ce24316f5bc85757bcb.camel@redhat.com>
Subject: Re: [PATCH net-next 1/2] sfc: Implement ndo_hwtstamp_(get|set)
From: Paolo Abeni <pabeni@redhat.com>
To: Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "Austin, Alex (DCCG)" <alexaust@amd.com>, Alex Austin
 <alex.austin@amd.com>,  netdev@vger.kernel.org, linux-net-drivers@amd.com,
 ecree.xilinx@gmail.com,  habetsm.xilinx@gmail.com, davem@davemloft.net,
 edumazet@google.com,  richardcochran@gmail.com, lorenzo@kernel.org,
 memxor@gmail.com, alardam@gmail.com,  bhelgaas@google.com
Date: Tue, 05 Dec 2023 09:52:34 +0100
In-Reply-To: <20231204184532.jukt3qvk7iqv6y4k@skbuf>
References: <20231130135826.19018-1-alex.austin@amd.com>
	 <20231130135826.19018-2-alex.austin@amd.com>
	 <20231201192531.2d35fb39@kernel.org>
	 <ca89ea1b-eaa5-4429-b99c-cf0e40c248db@amd.com>
	 <20231204110035.js5zq4z6h4yfhgz5@skbuf>
	 <20231204101705.1f063d03@kernel.org>
	 <20231204184532.jukt3qvk7iqv6y4k@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-12-04 at 20:45 +0200, Vladimir Oltean wrote:
> On Mon, Dec 04, 2023 at 10:17:05AM -0800, Jakub Kicinski wrote:
> > On Mon, 4 Dec 2023 13:00:35 +0200 Vladimir Oltean wrote:
> > > If I may intervene. The "request state" will ultimately go away once =
all
> > > drivers are converted. I know it's more fragile and not all fields ar=
e
> > > valid, but I think I would like drivers to store the kernel_ variant =
of
> > > the structure, because more stuff will be added to the kernel_ varian=
t
> > > in the future (the hwtstamp provider + qualifier), and doing this fro=
m
> > > the beginning will avoid reworking them again.
> >=20
> > Okay, you know the direction of this work better, so:
> >=20
> > pw-bot: under-review
>=20
> I mean your observation is in principle fair. If drivers save the struct
> kernel_hwtstamp_config in the set() method and give it back in the get()
> method (this is very widespread BTW), it's reasonable to question what
> happens with the temporary fields, ifr and copied_to_user. Won't we
> corrupt the teporary fields of the kernel_hwtstamp_config structure from
> the set() with the previous ones from the get()?
>=20
> The answer, I think, is that we do, but in a safe way. Because we impleme=
nt
> ndo_hwtstamp_set(), the copied_to_user that we save is false (aka "the
> driver implementation didn't call copy_to_user()"). And when we give
> this structure back in ndo_hwtstamp_get(), we overwrite false with false,
> and a good ifr pointer with a bad one.
>=20
> But the only reason we transport the ifr along with the
> kernel_hwtstamp_config is for generic_hwtstamp_ioctl_lower() to work,
> aka a new API upper driver on top of an old API real driver. Which is
> not the case here, and no one looks at the stale ifr pointer.
>=20
> It's a lot to think about to make sure that something bad won't happen,
> I agree. I still don't believe it will break in subtle ways, but nonethel=
ess
> I do recognize the tradeoff. One approach is more straightforward
> code-wise but more subtle behavior-wise, and the other is the opposite.

I tried to dig into the relevant code as far as I can, and I tend to
agree with Vladimir: the current approach looks reasonably safe, and
forward looking.=C2=A0

I think any eventual bugs (I could not find any) would be pre-existent
to this patch, rooted in dev_ioctl.c and to be addressed there.

I think this patches should go in the current form.

Cheers,

Paolo


