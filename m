Return-Path: <netdev+bounces-201594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 160EDAEA06E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED691889768
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4457E28DB6D;
	Thu, 26 Jun 2025 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxPxj39K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A679C2EACE9
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750947915; cv=none; b=iJ+QLZ6hfLrn6A411bfOpsKyStFSBtox1+Ve0JRpcguo2x6tXxO/r93lrNr+Su6onEg5XGxXpHsLRsh6GWu9Jhj/+tKdSCjYAYU5Q59B5qX0zpmKcvghGL4CPYAvsy2A4oa6XPlcuA9PMmdWpTw7VcxG6IeRyUoQ7UsEDOiOZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750947915; c=relaxed/simple;
	bh=bRwLjpOecHTQi5l8MB5RtJwDXbO6/XFmqwP/ssGh6nQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mmes+QwXZy80xchp7bfs6iizx7JFp1xQG6phPbEqXNSgb3YOgAimetlDbJDuAuhQISCsK5F7l4QKO9OXwmbBVQvlkPpfdwoCDZxe6M3+odaLBw3t5HPPTKsco02oKdecOfNsOh+YqjTqJGsKQn+IH+eVar+F4YcixiDfaqXss4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxPxj39K; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-70a57a8ffc3so11890767b3.0
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 07:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750947912; x=1751552712; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9v72zSICGxTfiVoWDRHX7QGUiR1i4+hcwzXHzRdWANE=;
        b=PxPxj39KL45xJP9JSuYD1Rnzba+JC28lIrrJdIJ7vyX2xcM5BkKonZfblN9oIPbGET
         qZBiQ+TAov6+bywYPgLCDIj6y6y2ngODS5c11aOCWddQJJL40kjhYlbaNw5IMT3e3cTh
         sPVW4IjA1uxbKi3Ybc9fjumL/9tYZoqmUGJ5gY+eGMriq+1WXBwIxvycgoMzzARyYoei
         RUIyg6tjiRRkaPpXcsXxDd8+9GDauc6Vr8hgCfAMFHN5qC5Qc1NU0c3ON1m0dFoqwfGP
         zHcYoq8/6wmLoFG6N3GfNCIaMl0gSSAtOsSlwnN5TiXdSvIRMtx8ren6AgiTTVA1eXK+
         gezA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750947913; x=1751552713;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9v72zSICGxTfiVoWDRHX7QGUiR1i4+hcwzXHzRdWANE=;
        b=VaelRjrXTvA5o67NscKfgpkHh/j/frvO/YLzdmBWzD6iu5bFnWhgNjXgXNVzKqPXo3
         4dPEkCiRBe4E6p9IFJTFXMw4VA8AnB4CyuPWHZAwQ7L93sLF058TMQ46f9Cyt/Vzma9M
         W3Uxv/pfzp7ydNOQMsk9kkOC8HmMznvhgKyVaZXm78eGEwMUenTluDKg2NGja2S5TkhN
         wq/EQZMhmsBtiz3ww7kgLU/qt4BOnNvodjMRURZyScWO5DiK3a29iq1k6/IdgSms0j7S
         7ySlqAvLr4Axv1x2RZsT5X8zDF/QX3hZ0WHhW5XYlGOeAjjaKkDUmmZVzkUBooTPDoYs
         8JsQ==
X-Forwarded-Encrypted: i=1; AJvYcCX41Byd4IT7nIED/3OOIu13Co0gqBoBmMSan3jNjsc2zFSf7u1ayis1RH+dA7vaXtls3qgQL+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWPhPWQZhn5i9vEQyDbrg/GhOUZ7VEBMYgI2NuxeGA4+/JmDlq
	Ew2YAg4yGLo/lZJEdkmrf25JSdmoD9ofQ0fMi5qapkJjlPqWfB7aNHLs
X-Gm-Gg: ASbGncv/507DQNasATO50LbOuZfRtnsup3/eZH2gItwzJjvMhhmznQxA6pDyebRq2/9
	jA1AJBZ5Mc7X30GeWcMG9NPCRW+f1mGoZs2S1aXU172W3Z52c8wIEyvT8mfUsLG7RIoZJzUacV3
	/seqYTF1IwHE8484oYN0nAV71CjD3E3wyq+5plGWSW/KIyB0/6g/mET8a+qK/OqvEwY0VER2gu4
	IVH+sIuFeOUzV+bTJaBtOhj4JvSshNFoZyjqEGfT+AzTd0r+lY20L8yWS4AhKNUY+acIGPD2Rql
	Xoo4sD+7BFgJNV7K9WhRHZSDpA/QCtm5IddCGc2ZQ0462ZNIan7Kg+8tJwDNKnlCSyQJITe3Tve
	ebhEIwzds7RnXOB2Lfhe8rlSuNZCW++ucVDGmGlhEhnjgCjvSQa4c
X-Google-Smtp-Source: AGHT+IGl1encpvOmGRAdNX2MxPIXlTHpbhalNmqUpIRI2HGrv7PZa7VoFWXIXFva6xBa478eyaqT8Q==
X-Received: by 2002:a05:690c:10d:b0:70e:142d:9c6e with SMTP id 00721157ae682-71406e1319cmr111875377b3.32.1750947912557;
        Thu, 26 Jun 2025 07:25:12 -0700 (PDT)
Received: from localhost (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71515c9028bsm78397b3.62.2025.06.26.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 07:25:12 -0700 (PDT)
Date: Thu, 26 Jun 2025 10:25:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, 
 Donald Hunter <donald.hunter@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Saeed Mahameed <saeedm@nvidia.com>, 
 Leon Romanovsky <leon@kernel.org>, 
 Tariq Toukan <tariqt@nvidia.com>, 
 Boris Pismenny <borisp@nvidia.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, 
 David Ahern <dsahern@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, 
 Patrisious Haddad <phaddad@nvidia.com>, 
 Raed Salem <raeds@nvidia.com>, 
 Jianbo Liu <jianbol@nvidia.com>, 
 Dragos Tatulea <dtatulea@nvidia.com>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Jacob Keller <jacob.e.keller@intel.com>, 
 netdev@vger.kernel.org
Message-ID: <685d5847a57d7_2de3952949b@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250626070047.6567609c@kernel.org>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
 <20250625135210.2975231-3-daniel.zahka@gmail.com>
 <685c8c553072b_2a5da429429@willemb.c.googlers.com.notmuch>
 <20250626070047.6567609c@kernel.org>
Subject: Re: [PATCH v2 02/17] psp: base PSP device support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 19:55:01 -0400 Willem de Bruijn wrote:
> > > +#define PSP_SPI_KEY_ID		GENMASK(30, 0)
> > > +#define PSP_SPI_KEY_PHASE	BIT(31)
> > > +
> > > +#define PSPHDR_CRYPT_OFFSET	GENMASK(5, 0)
> > > +
> > > +#define PSPHDR_VERFL_SAMPLE	BIT(7)
> > > +#define PSPHDR_VERFL_DROP	BIT(6)
> > > +#define PSPHDR_VERFL_VERSION	GENMASK(5, 2)
> > > +#define PSPHDR_VERFL_VIRT	BIT(1)
> > > +#define PSPHDR_VERFL_ONE	BIT(0)  
> > 
> > Use bitfields in struct psphdr rather than manual bit twiddling?
> 
> Some call it manual bit twiddling, some call it the recommended kernel
> coding style? ;)

:)

Preferable over the following?

	struct psphdr {
		u8      nexthdr;
		u8      hdrlen;
		u8      crypt_offset;

		u8      sample:1;
		u8      drop:1;
		u8	version:4;
		u8	vc_present:1;
		u8	reserved:1;

		__be32  spi;
		__be64  iv;
		__be64  vc[]; /* optional */
	};

I suppose that has an endianness issue requiring
variants with __LITTLE_ENDIAN_BITFIELD and
__BIG_ENDIAN_BITFIELD.

Either way, just a thought.

> > Or else just consider just calling it flags rather than verfl
> > (which stands for version and flags?).
> 
> (Yes.)
> 
> > > +
> > > +/**
> > > + * struct psp_dev_config - PSP device configuration
> > > + * @versions: PSP versions enabled on the device
> > > + */
> > > +struct psp_dev_config {
> > > +	u32 versions;
> > > +};
> > > +
> > > +/**
> > > + * struct psp_dev - PSP device struct
> > > + * @main_netdev: original netdevice of this PSP device  
> > 
> > This makes sense with a single physical device plus optional virtual
> > (vlan, bonding, ..) devices.
> > 
> > It may also be possible for a single physical device (with single
> > device key) to present multiple PFs and/or VFs. In that case, will
> > there be multiple struct psp_dev, or will one PF be the "main".
> 
> AFAIU we have no ability to represent multi-PCIe function devices 
> in the kernel model today. So realistically I think psp_dev per
> function and then propagate the rotation events.

IDPF does support multiple "vports" (num_alloc_vports), and with that
struct net_device, from a single BDF.

