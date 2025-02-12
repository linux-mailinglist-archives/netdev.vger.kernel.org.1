Return-Path: <netdev+bounces-165636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F24D8A32E83
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 19:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B8B43A58DC
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 18:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D537E263C6E;
	Wed, 12 Feb 2025 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LgIPFhmr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD2F260A40
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 18:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739384396; cv=none; b=lNMj4e22oLn0jW5gXUEQq4GOOc+4bvX6uls+djztoWcAwf3X+qf3gNL1Jts8YqnDe02lA3cL9hAT38gBEo1vrLUadfMrCALh+8cwv8HFxugzydM41qYagUuWa9C246th2sRObZq3+loMVhELtlJ8Dfbo54pk4H0ky1Z/bNbl4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739384396; c=relaxed/simple;
	bh=qFOWa4pauo4Iuu6WGgcIEz+h/qWRaq8iwgw9wmS1RWQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TvIS14M0y0LwsuXmh9bplwuspyHiw8LlvhSzUWben9OZMWKZHyZ1DzrkU4Rdpmts0MPrMGNi+x7kcrqz5XnXy+DeO5Ku0DeMH2/lVq5YDx9+q0ZrG2edb6PaJGPMzKp1kb5kwKseItycb1Ykqu9bLFUaikefdY0wAjKfdQlCyUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LgIPFhmr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739384393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZh4AjieEBhVpChkY/ZbfZf/JCY7uSfZ7yn1oUrifN0=;
	b=LgIPFhmrS9cYHg9EA2O/K/WqLKdZN2dSV9fmIeQxOuRJDFASFjmzFanFw0OGWDL7yvmqgp
	JMhrEIwBOMDaF6/WojjPu1+/xC6YeqP28oDZeV5E7jcOL02U/PBV6ky7GlXrWYJtdkUy7N
	4ttlisIzFAJjoG5MQZBDjU3vA2Gl6tw=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-NBxfZLqrP_KKfiD_yFq-4g-1; Wed, 12 Feb 2025 13:19:50 -0500
X-MC-Unique: NBxfZLqrP_KKfiD_yFq-4g-1
X-Mimecast-MFC-AGG-ID: NBxfZLqrP_KKfiD_yFq-4g_1739384389
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5dec9d39295so67359a12.3
        for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 10:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739384389; x=1739989189;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gZh4AjieEBhVpChkY/ZbfZf/JCY7uSfZ7yn1oUrifN0=;
        b=u67/YYqt3ZVi7scZ1HVFpp+lpi+lNvzY4RGiFTPooh09goOdGxdKN/MSRtZALcM0Cw
         5LKaQulRw6iXbSO/j4GMPS2CAkBKxYx5ocgUrm6kCUHUmBY3Ky+2jy1D8OwT2phFDW/Q
         ri7OagvS3doAejixyOixy6AXzkMPXYVC/9biMb/RxmMTYLRzIN5LQ5FRLT+ETA/btLpp
         fd3GhFVf7yLBGFxNvo+UGXi1LehMRV6wu3rWuZLwg/UClIoeCqVR3nwTHgF0lk6e/gqt
         2SC6w5sL+/yROWV/6WZFpQp+tc9boOhJ9SWPf+2fkVFJoNNgKI9WgeLlyNBvG8J+qFZF
         OcTg==
X-Forwarded-Encrypted: i=1; AJvYcCXkfobYC6zZAPvnY2Sg0DFRCesNKNE3z+rZE4iSTh+Ch0BSuXT++jCpYton5gV9J3bNK/AYSds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAB5NUerEyJ7tKlQ14dAE6887madCIXj/+DaNf9omhuzKIIF2R
	WRcw4yAD7A9YVKsOX7Nz3iUyq+CYa9v8QAIZMrt/hNMQ1vupl5CziDFTOjffDM04F7guHxGPGqi
	gnx323pIOPxOgw58Kxf2EpKc5fiG59SjabGRp9eEHaOWS9ivkJsa5HQ==
X-Gm-Gg: ASbGncth26zw8ryfSOeojYGZl40QjcN4VKD6XOBGrKm+0ZJPnBueNItb8yUnp5rPHe4
	uwBQnUbjwoPVJoQcxzN1+7vTdEPECncdCHAEvifv8XfJlgTNVSImCZr9QkUsEG3nDLEclzgUFvq
	24r0UKs/UB1lAEW28u6xVbAN96LjheZzZ/wsDNecF57cu8WefHHuKgl27YnULr86Awmkq4xfU7w
	WLivf1yeM1ztUkg/SafDoXF3nkW+Gs5KqL2LnVYDf8RYXc6klKY2YtbMwhmC0m2q80/w5H+FjJJ
	bf7F+SuHz6gUjvEanguuez6lSzuQjQkFz+Qh2iRYX+zAd+7o9DJnjk3bYB2kQhmGZqD5sgrWW8S
	RBNR8AbXzjyM8LSaBs+cBZZHXWBxnDA8gXw==
X-Received: by 2002:a05:6402:4605:b0:5dc:8f03:bb5c with SMTP id 4fb4d7f45d1cf-5deadd9217bmr3909046a12.11.1739384389353;
        Wed, 12 Feb 2025 10:19:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IESGQAXDzed7Fmi16ciLszJ4Ey0xkXA+j06UKHlLqfUdrmcANPKem5IWP/WHHNGNcVUN6LRhQ==
X-Received: by 2002:a05:6402:4605:b0:5dc:8f03:bb5c with SMTP id 4fb4d7f45d1cf-5deadd9217bmr3909028a12.11.1739384389013;
        Wed, 12 Feb 2025 10:19:49 -0800 (PST)
Received: from ?IPv6:2001:16b8:2d24:c00:803c:5b80:8fe:19d4? (200116b82d240c00803c5b8008fe19d4.dip.versatel-1u1.de. [2001:16b8:2d24:c00:803c:5b80:8fe:19d4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5de4d250084sm10090241a12.16.2025.02.12.10.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 10:19:48 -0800 (PST)
Message-ID: <dfbc4edd2670fc102ba4959d99bb2c5d6bd1d626.camel@redhat.com>
Subject: Re: [PATCH] stmmac: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Andrew Lunn <andrew@lunn.ch>, Philipp Stanner <phasta@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Serge Semin <fancer.lancer@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Yinggang Gu <guyinggang@loongson.cn>,
 Yanteng Si <si.yanteng@linux.dev>,  netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Wed, 12 Feb 2025 19:19:47 +0100
In-Reply-To: <885058ae-605b-46e6-989b-3ff52908e6fd@lunn.ch>
References: <20250212145831.101719-2-phasta@kernel.org>
	 <885058ae-605b-46e6-989b-3ff52908e6fd@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-02-12 at 19:13 +0100, Andrew Lunn wrote:
> > =C2=A0	/* Get the base address of device */
> > -	for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> > -		if (pci_resource_len(pdev, i) =3D=3D 0)
> > -			continue;
> > -		ret =3D pcim_iomap_regions(pdev, BIT(0),
> > pci_name(pdev));
> > -		if (ret)
> > -			goto err_disable_device;
> > -		break;
> > -	}
> > -
> > -	memset(&res, 0, sizeof(res));
> > -	res.addr =3D pcim_iomap_table(pdev)[0];
> > +	res.addr =3D pcim_iomap_region(pdev, 0, DRIVER_NAME);
>=20
> I don't know too much about PCI, but this change does not look
> obviously correct to me. Maybe the commit message needs expanding to
> explain why the loop can be thrown away? Also, is that BIT(0)
> actually
> wrong, it should of been BIT(i)? Is that why the loop is pointless
> and
> can be removed? If so, we should be asking the developer of this code
> what are the implications of the bug. Should the loop be kept?

Yes, the reason why the loop is pointless is that it calls BIT(0) for
all runs, instead of BIT(i). This would have caused an error btw if it
weren't for pci_resource_len(=E2=80=A6) =3D=3D 0, which I assume prevents t=
rying to
request BAR0 more than once, which s hould fail.

The commit message should mention this, agreed.

I assume this is not a bug, but the code was just copied from the other
part (also touched in this patch) where a loop was necessary. Argument
being that if the above were a bug, it would definitely have been
noticed because the BARs other than 0 are not being mapped, so trying
to access them should result in faults.

Although a confirmation by the respective developer would indeed be
nice.

P.

>=20
> 	Andrew


