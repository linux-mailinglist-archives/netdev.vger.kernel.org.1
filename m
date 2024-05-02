Return-Path: <netdev+bounces-93014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB66A8B9A67
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 14:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FB3286C6A
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 12:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E674271747;
	Thu,  2 May 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1gJ4OIp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F6F6E617
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714651356; cv=none; b=lMX4GmJuVDy8jVqL+4x2MiiGFh2AhB/iK60v0PIECG4o9oKPxgosriVLRv+TZXOkDYoiFmPHutUYfA14koyft2UktmGGGFtZ4FMU+A0286pkRMr2+nfv0s1uGu0GHjrxEM2i1FBduq9w9c4pXUBjr9/BFDAEkUi2U5w3pc9j6yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714651356; c=relaxed/simple;
	bh=5LCtxE1foP4p42pbTXYapXqnE7N4+pBu402ePprtg7k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TlJztRjYQpFk8bcdxrtFFF8CWx1RKhOqFoE7AnEBK1Vi6KO/a+dykVSdyM48wTo9IUWMI+mkZkBVfzoDpMOCHpLYuj+3TjT5MWRaZ6XZNb3RWdR1q034HPTv8tYwxw3ifmZtLjdtJVdvymJtRcQ6ndwzDAYrNwg+aoD1P95Dzkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1gJ4OIp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714651354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=XfXBI1UCEocbU9bnKa0OdkUDyFRe6Bw2+hz1Q8popRQ=;
	b=S1gJ4OIpsY/cYbkBBlE3L1xQktd4SwWzRnW538cPkf8n6GIk7AdJ3iib6RT2J9KVD4Jrwk
	gt+dhpKU3uYAWZO+u8D979LXwDKOYXImLgIQ/ANQlD9qNp7IHhcodzbIRgwAFNRggd9fYC
	D16B1J25sMaD5O4KV1MoBnGXOtudobo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-zMp08yA1Md-a4egeHTasRw-1; Thu, 02 May 2024 08:02:33 -0400
X-MC-Unique: zMp08yA1Md-a4egeHTasRw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2d8647f923fso12193891fa.0
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 05:02:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714651352; x=1715256152;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XfXBI1UCEocbU9bnKa0OdkUDyFRe6Bw2+hz1Q8popRQ=;
        b=n4huBBz/kRlY2A3KORjY1MnTQPUwtjG5/sAjEUCbJzZABD7NOKH/amaT6CGv4hp/ta
         6zKLIcqLPDBmoFPlE2/vTqsZ3c7xb5F41jxu1HOkUrCm+GnClI9n6s9wiWS9VYCtpML4
         h4RuXw6Q+WAiC8cY0CoMrQfCkgkVXosD2eRBVRyD9ys9HK4zB9flUM0kvxp3LaG/cXI7
         FRpTuXdkDFc8OabH0a7zntHT4FO9PI0T2tpXa8M+lMNrbrdBiQ6zmEF3MaX4z/vmuUhF
         Q3pZ6iVZHD1jeh17JHqoP/XUaJ0BBDz4VOQ6VGztF3hTdHnBm7JjfcY+gb1X5CwvvA9+
         DTpg==
X-Forwarded-Encrypted: i=1; AJvYcCXVRgKjMCrizMa3js581KlKOlLF1wsw5ojEcha7cZdRswUmS2to6whNiGyCb4o6MRrADvBMprte+5fleNuUtYj41lMfVYNn
X-Gm-Message-State: AOJu0Yx7kUVVkF5lyJjA57s0jualkx4TISxM92ajs3ckaMltVyeTTvwO
	z7SosQRMhitQ2UmrlfIaPU51QRIcB5B/K0g/8+6uq3N10J7jhhWozBgb/RTMaq0qKBkBjqI4K4B
	+xxZXyWkfhzP2bN0YvYCTQAbI41yZ0r+VVGur6+z8YGgyZ2cTMC56Ng==
X-Received: by 2002:a2e:8005:0:b0:2d8:5d78:d4f5 with SMTP id j5-20020a2e8005000000b002d85d78d4f5mr3230876ljg.4.1714651351578;
        Thu, 02 May 2024 05:02:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcPqJzAlwciurUryFPLth5j5uUrvMbzyjCr5B9NBxCGEVa+xdAr7J6OIi068BtXjl2HFtRKw==
X-Received: by 2002:a2e:8005:0:b0:2d8:5d78:d4f5 with SMTP id j5-20020a2e8005000000b002d85d78d4f5mr3230841ljg.4.1714651351085;
        Thu, 02 May 2024 05:02:31 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:1b52:6510::f71])
        by smtp.gmail.com with ESMTPSA id l3-20020a05600c4f0300b0041b43d2d745sm1735008wmq.7.2024.05.02.05.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 05:02:30 -0700 (PDT)
Message-ID: <cc9eae8f17e3e0ad142c9efa3fe5dff7afe2554c.camel@redhat.com>
Subject: Re: [PATCH net-next v5] net: ti: icssg_prueth: add TAPRIO offload
 support
From: Paolo Abeni <pabeni@redhat.com>
To: MD Danish Anwar <danishanwar@ti.com>, Dan Carpenter
 <dan.carpenter@linaro.org>, Andrew Lunn <andrew@lunn.ch>, Jan Kiszka
 <jan.kiszka@siemens.com>, Simon Horman <horms@kernel.org>, Niklas Schnelle
 <schnelle@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>, Diogo Ivo
 <diogo.ivo@siemens.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Richard Cochran
 <richardcochran@gmail.com>, Roger Quadros <rogerq@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>
Cc: linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com, Roger
 Quadros <rogerq@ti.com>, Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Thu, 02 May 2024 14:02:28 +0200
In-Reply-To: <74be4e2e25644e0b65ac1894ccb9c2d0971bb643.camel@redhat.com>
References: <20240429103022.808161-1-danishanwar@ti.com>
	 <74be4e2e25644e0b65ac1894ccb9c2d0971bb643.camel@redhat.com>
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

On Thu, 2024-05-02 at 13:59 +0200, Paolo Abeni wrote:
> On Mon, 2024-04-29 at 16:00 +0530, MD Danish Anwar wrote:
> > +static int emac_taprio_replace(struct net_device *ndev,
> > +			       struct tc_taprio_qopt_offload *taprio)
> > +{
> > +	struct prueth_emac *emac =3D netdev_priv(ndev);
> > +	struct tc_taprio_qopt_offload *est_new;
> > +	int ret;
> > +
> > +	if (taprio->cycle_time_extension) {
> > +		NL_SET_ERR_MSG_MOD(taprio->extack, "Cycle time extension not support=
ed");
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	if (taprio->cycle_time < TAS_MIN_CYCLE_TIME) {
> > +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "cycle_time %llu is less than=
 min supported cycle_time %d",
> > +				       taprio->cycle_time, TAS_MIN_CYCLE_TIME);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
> > +		NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %lu is more than=
 max supported entries %d",
> > +				       taprio->num_entries, TAS_MAX_CMD_LISTS);
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (emac->qos.tas.taprio_admin)
> > +		devm_kfree(&ndev->dev, emac->qos.tas.taprio_admin);
>=20
> it looks like 'qos.tas.taprio_admin' is initialized from
> taprio_offload_get(), so it should be free with taprio_offload_free(),
> right?
>=20
> > +
> > +	est_new =3D devm_kzalloc(&ndev->dev,
> > +			       struct_size(est_new, entries, taprio->num_entries),
> > +			       GFP_KERNEL);
> > +	if (!est_new)
> > +		return -ENOMEM;
>=20
> Why are you allocating 'est_new'? it looks like it's not used
> anywhere?!?=20
>=20
> > +
> > +	emac->qos.tas.taprio_admin =3D taprio_offload_get(taprio);
> > +	ret =3D tas_update_oper_list(emac);
> > +	if (ret)
> > +		return ret;
>=20
> Should the above clear 'taprio_admin' on error, as well?=20

Side note: the patch itself is rather big, I guess it would be better
split it. You can make a small series putting the the struct definition
move in a separate patch.=20

Thanks,

Paolo


