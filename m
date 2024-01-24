Return-Path: <netdev+bounces-65581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8E783B12E
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 19:31:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6991F21DFC
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 18:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1E712DD96;
	Wed, 24 Jan 2024 18:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QtjDSouk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51034130E4E
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 18:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706121092; cv=none; b=b1xwgoyPasxJMTNbGNcLu0ClRkgddRpbdudqgqKfYJDwFbL4YbjpbRBCAB40woJI9O3jZJcJGfgrjW5I/1Haq8CP6Eim8bpI0S5lOnqW+H7zm/cqR2tBxXWrY9Ytga3uwNgt1v+f08/KnPor31VtlJGNWO13bPNr16EUEGClcGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706121092; c=relaxed/simple;
	bh=ILdp65m4kgLyLSI3PighSVXO/j22c7lZSdMxiWKFTvk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lm9xSCMhf8YK8q9v6GCxfX1KSvzv3Bd6wiWs+okoIsoEI2+iNrsSEjJCMn3fdVzs9cxm8oC8WTvzjUaTjk66IEaDHd8oJN422J+d6dfxXV9hNaWBno6sEf4/EscS07zOSh/VEHZVG8dYrbWYE0LraE7IpPUZlqs4G+jyFntI7y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QtjDSouk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706121087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ILdp65m4kgLyLSI3PighSVXO/j22c7lZSdMxiWKFTvk=;
	b=QtjDSouk5pHOW2SaljeiYeDV9lIfd8vFohOUtBJfuplrK0UeBVvWyFELs8pl78qf0q2Wv5
	zFp1dmgjOqeLricgazpC9G0IbldGubKY8bNhZM286kbl71qRhtZP5Ew0uBAjO6e2QEQk5o
	Q0RYbf7u9mpAyIE9Ro2cFLG2o8fbiqU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-0TPHBWucMxeCYX-uIrKjLQ-1; Wed, 24 Jan 2024 13:31:24 -0500
X-MC-Unique: 0TPHBWucMxeCYX-uIrKjLQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e354aaf56so15860245e9.1
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:31:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706121083; x=1706725883;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ILdp65m4kgLyLSI3PighSVXO/j22c7lZSdMxiWKFTvk=;
        b=PAksMVqj6gPQwvG7TaUlhzTmOoLAeAIepeH/GJO1TRciu4tgiKEHKDek9PRJp/cc2E
         7MDXxhnc3eGH8yxkgSrai5vXb7p0OtjJVTMHWI/etqGdVDs5j5Pr4wr2/0VFIuCLuVZJ
         u7CYGV+U0jHJKgtdswemo6b3M49mPwKCkaLH3Ru850qem7KT5XfoVd59R1KP0Q2UvwSe
         yKBLSwxsFcYjiooV/Ii7XG3HWe7eop6VmZfp2cOUaSuHOMEu+9uHlG2zpk/mg00Jcinl
         GY9QRoTQ6oaHRCE31hpy6dmZcGedPoh27XKT65lxpmbuEPs+8WB0a0pK40IVVWJo8MU0
         1Meg==
X-Gm-Message-State: AOJu0YwyX3dWWOPJADhH42I1UAMx78F8cK8duiX4ULXKsb5//8vP9I/w
	Y8F6zTHRIHsCUplThOIcfZE1RQJRw3io1GqRBRnDx9HGJ1BP4UGurgpuErNEaJjrRArSgsmXmsV
	VTyBawIWu2Kx3FENuZ1k1d0jEV871F4u9NTQtt7XInKrSZ1opSu5c7Q==
X-Received: by 2002:a05:600c:3b02:b0:40e:9f73:f33 with SMTP id m2-20020a05600c3b0200b0040e9f730f33mr2193026wms.0.1706121082990;
        Wed, 24 Jan 2024 10:31:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcjUttD6Kilsf3znZGJL8Nznc7Gnn2XQ2Vhf80FNOr6siIn5927qooHY7Xy4hd/K3L5WAiNw==
X-Received: by 2002:a05:600c:3b02:b0:40e:9f73:f33 with SMTP id m2-20020a05600c3b0200b0040e9f730f33mr2193004wms.0.1706121082639;
        Wed, 24 Jan 2024 10:31:22 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-245-66.dyn.eolo.it. [146.241.245.66])
        by smtp.gmail.com with ESMTPSA id j33-20020a05600c1c2100b0040e559e0ba7sm457976wms.26.2024.01.24.10.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:31:21 -0800 (PST)
Message-ID: <e6060eae34e41ea29c651bd25d51632d8d52498a.camel@redhat.com>
Subject: Re: [ANN] net-next is OPEN
From: Paolo Abeni <pabeni@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Jakub Kicinski
	 <kuba@kernel.org>
Cc: David Ahern <dsahern@kernel.org>, Hangbin Liu <liuhangbin@gmail.com>, 
	"netdev@vger.kernel.org"
	 <netdev@vger.kernel.org>, "netdev-driver-reviewers@vger.kernel.org"
	 <netdev-driver-reviewers@vger.kernel.org>
Date: Wed, 24 Jan 2024 19:31:20 +0100
In-Reply-To: <65b155bf549e3_22a8cb294c7@willemb.c.googlers.com.notmuch>
References: <20240122091612.3f1a3e3d@kernel.org>
	 <Za98C_rCH8iO_yaK@Laptop-X1> <20240123072010.7be8fb83@kernel.org>
	 <d0e28c67-51ad-4da1-a6df-7ebdbd45cd2b@kernel.org>
	 <65b133e83f53e_225ba129414@willemb.c.googlers.com.notmuch>
	 <20240124082255.7c8f7c55@kernel.org>
	 <65b14c16965d7_228db729490@willemb.c.googlers.com.notmuch>
	 <20240124094920.7b63950e@kernel.org>
	 <65b155bf549e3_22a8cb294c7@willemb.c.googlers.com.notmuch>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-24 at 13:23 -0500, Willem de Bruijn wrote:
> Jakub Kicinski wrote:
> > On Wed, 24 Jan 2024 12:42:46 -0500 Willem de Bruijn wrote:
> > > > Here's a more handy link filtered down to failures (clicking on=20
> > > > the test counts links here):
> > > >=20
> > > > https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2024-0=
1-24--15-00&executor=3Dvmksft-net-mp&pass=3D0
> > > >=20
> > > > I have been attributing the udpg[rs]o and timestamp tests to you,
> > > > but I haven't actually checked.. are they not yours? :) =20
> > >=20
> > > I just looked at the result file and assumed 0 meant fine. Oops.
> >=20
> > Sorry about the confusion there, make run_tests apparently always
> > returns 0 and the result file holds the exit code :( It could be
> > improved by I figured, as long as the JSON output is correct, investing
> > the time in the web UI is probably a better choice than massaging=20
> > the output files.
>=20
> Absolutely. My bad for jumping to conclusions.

Some tests are failing because they need an xdp program build under the
ebpf directory.

Since such program is used even by ebpf tests, I'll send a patch
duplicating it under net, and using the existing rule for nat6to4 to
build it.

Cheers,

Paolo


