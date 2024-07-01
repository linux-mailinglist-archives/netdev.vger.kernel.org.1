Return-Path: <netdev+bounces-108070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2071491DC27
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C21B22D0D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D9312B169;
	Mon,  1 Jul 2024 10:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbPuzsQp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5570B8289A
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 10:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719828881; cv=none; b=Y/CtzIqvkrJ+88fzimOgsEUGTVsUHyBpYX3ZFQkQa7m+Qa2yDKtiOHEgj0YBjoSp2CmrRLFN3w4QqQP8L/fArMgCbctYQvrdKiXuCUPehec2tZ6OXcwkco6HeI/X6KeYmz9r4+m5T2UhNXJ/vuvb6ONlsuvcEBy+Y19FPp64ODw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719828881; c=relaxed/simple;
	bh=FYOn3dg++b3r3ulSBdKj/IIrGDVL/AtFuctMbxDvXUY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uTz3tiJcS80XpSAnX7t8rPeycssLJXVN8aSrxMxOtgoliJWCzKEIxevBGhZOt1Oq6JrTCNoMaR67F+vmQjCXMeBxpph7AeMzuevmo25UM0/C0jvIp8zRRlQyIwpwJwMxFt+8eLQ+rtNu/8wLPCQKL7f1TFBTvcge0LLC+BI8O1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbPuzsQp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719828878;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TY28F7g/hw+qQaoTbGrKyv66y84/Sxz+JK2Xm8URjqw=;
	b=fbPuzsQpQHHWuUMyHyKR5kmbVxIIXj9fuylZbbnXJDWRsWHE4auQV1SdqL6GlzlePp0KYK
	dgw1fpku6M8iBnyIGUyz488bvBKzpvpkKeAXiqIW6lMtZJCpVs7K6yDgaB5z7X61YUaFsq
	BDYI5QXn/w4DKbgWknsMuUt3diWSXHA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-Tr9MApHgM2OQrlSdMkFoRQ-1; Mon, 01 Jul 2024 06:14:37 -0400
X-MC-Unique: Tr9MApHgM2OQrlSdMkFoRQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ec5ee395f4so6245731fa.0
        for <netdev@vger.kernel.org>; Mon, 01 Jul 2024 03:14:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719828875; x=1720433675;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TY28F7g/hw+qQaoTbGrKyv66y84/Sxz+JK2Xm8URjqw=;
        b=ACE6w1exMRqEcSzgCU40SgWcVVrupbSv7IbTQLc4SypxLpmCUK6R+OUO69dX+KiBYx
         +W+NkcQ0wtzF9vIDaOESSq3Q+qjoasZouEn66DgwHWPB/HaJTTCFw/eZRWBm1DLao/yu
         WvhuzX4KSGR+toHPbP9EtnhsjP9iRyd5PXXmUPm3OW5i/MGrdG0GgDliBC6f8yNURPUK
         iKneQZgOeXTEHd+b3KoFoJUuiqeci4BI72INqPgL+jw45PPjjqIT6mvNnP3JapAsFA8A
         RsoA3fXDhJfFf1mw6pfIBDqqcVdkOpXavsF7RFftVGfto8+zKlIzHLAc3fXNFkUisFDd
         FEnA==
X-Gm-Message-State: AOJu0Yz4OTktMx/byOdSjUkUAfXhTYl1Y9PEhjwwjnUwT4SdYHSswgK7
	GtHbqJ4rwev8eGszPgGytG6U1IqZk7qNyECivhpxlndTetsHNJdBFYyk42/zAfpOQ7t6BJwnuoN
	uzze4YBMJGOCcKsr5vajG29s0jKjnI99TGPjG3+Cw10eZgtdOYVFnog==
X-Received: by 2002:a2e:9b9a:0:b0:2ec:5361:4e21 with SMTP id 38308e7fff4ca-2ee5e6e9226mr27234321fa.5.1719828875553;
        Mon, 01 Jul 2024 03:14:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHp1NLwBTFrEJQNB3OCLH4sieK84x31+rX1qjIDWh8c8OiidUvlA2n5g+gz79eZJSRpxKCIVA==
X-Received: by 2002:a2e:9b9a:0:b0:2ec:5361:4e21 with SMTP id 38308e7fff4ca-2ee5e6e9226mr27234201fa.5.1719828875132;
        Mon, 01 Jul 2024 03:14:35 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:2451:6610:7695:150b:6fd2:fdc1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af55aeasm144179995e9.17.2024.07.01.03.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 03:14:34 -0700 (PDT)
Message-ID: <4df85437379ae1d7f449fe2c362af8145b1512a5.camel@redhat.com>
Subject: Re: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
  Simon Horman <horms@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 01 Jul 2024 12:14:32 +0200
In-Reply-To: <20240628191230.138c66d7@kernel.org>
References: <cover.1719518113.git.pabeni@redhat.com>
	 <75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
	 <20240628191230.138c66d7@kernel.org>
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

On Fri, 2024-06-28 at 19:12 -0700, Jakub Kicinski wrote:
> On Thu, 27 Jun 2024 22:17:18 +0200 Paolo Abeni wrote:
>=20
> > +      -
> > +        name: shapers
> > +        type: nest
> > +        multi-attr: true
> > +        nested-attributes: ns-info
>=20
> How do shapers differ from shaping attrs in this scope? :S

the set() operation must configure multiple shapers with a single
command - to allow the 'atomic configuration changes' need for Andrew's
use-case.

Out-of-sheer ignorance on my side, the above was the most straight-
forward way to provide set() with an array of shapers.

Do you mean there are better way to achieve the goal, or "just" that
the documentation here is missing and _necessary_?

> > +operations:
> > +  list:
> > +    -
> > +      name: get
> > +      doc: |
> > +        Get / Dump information about a/all the shaper for a given devi=
ce
> > +      attribute-set: net_shaper
> > +      flags: [ admin-perm ]
>=20
> Any reason why get is admin-perm ?

Mostly a "better safe then sorry" approach and cargo-cult form other
recent yaml changes the hard reasons. Fine to drop it, if there is
agreement.

Side note: ack to everything else noted in your reply.

Thanks,

Paolo


