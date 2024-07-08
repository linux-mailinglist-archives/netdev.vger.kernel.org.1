Return-Path: <netdev+bounces-109995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBE292A9F4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 21:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6DEB21FBE
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447CB1BC39;
	Mon,  8 Jul 2024 19:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h5D7ZejA"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A0C10953
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467729; cv=none; b=k1R1XG0BXjl0okNjTWnBcOsCatG2KuP4Wr01M72HhrIdF3wZOaDDNJfaqF2YVyBIBgArlNgnuzp1gZxzTIATBxEg6nxr4VKbL3tgC226xdcjMhBQV6o1fU4zoJs3lhr/Fgs9dvM/aw2EVV8S87CVrTYSKuM31bLPdhIp/aL0QaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467729; c=relaxed/simple;
	bh=GtJD905SftEHjNbCVoGNDHndS2x35U5aRY3wSa397QM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bEgVzGAqoi859qBLkAZcpDdM/Bn+elM/O1iffXKiqp4mtdNBOmU4DTI104j/FeBJvHs3GqKoFj2BIYSsWapVRgwgIj2XFgPflgKRYloUQRqu+B2DHo0+huGtHaaeJtBMniFB8JWLhTqOD4F7td/aEfwdL8tGy3iiRRNNbLvj5+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h5D7ZejA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720467726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GtJD905SftEHjNbCVoGNDHndS2x35U5aRY3wSa397QM=;
	b=h5D7ZejAPC6Or3V2vJsAtmKrjE1i2nzpTR9AtvgJ9mBNK/kn4+CjpjVtA3UlI+gui4jqKs
	6SXMhdXCcoEh39XTY+4ADwjLaH/Y0G0XwJvjSr4ppKNyA40pL2Q5sbLX7UHQwrHqDlJcgF
	ExgDN6hUcDKb7JzkIyJ0EPMPsdPYqk4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-y1_Tst5xNZexMmIElDOv_A-1; Mon, 08 Jul 2024 15:42:04 -0400
X-MC-Unique: y1_Tst5xNZexMmIElDOv_A-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36794e8929bso455299f8f.1
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 12:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720467723; x=1721072523;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GtJD905SftEHjNbCVoGNDHndS2x35U5aRY3wSa397QM=;
        b=YbfyR8OgTu59cVUZGe+7eM+9u30E4oXGfkg1fqJ2Ft6EMxNQHmfU4zeprFUixuh8Zo
         axOSciRj2rBzaFHzzG032OgZRGO66c3zyC0lpABQ1yO5FcSH93KROsFdnSaaHMUz+V2y
         LLY9e8e27+3nqK6BzF9hrRgSqzsJBnmhPYsjx/JDUnei9C/zHypUA/Op/s2cJEfRnuiM
         U+A7bE9y50JIBnpu8/eiTouuhHQBCmfxQjgWOmBXE5UK5ScNg1uyi8i6JJUIxZZAD2YO
         7LZYbGHuHypAd9uY2mQRhH82HTYrp708XKBUvuvY3NpDRvnQLr8cJFNNR0QZ9wgILFh6
         Y4xg==
X-Gm-Message-State: AOJu0YwGsymkY4hrHTTKvVVf/QBZNvkE4R4EEe1GZxRIXnPW3Lj2O3AF
	o6+tAS7vw667pmiBcoiiklrwqXZdFVg/WfQyQd/SRVvEdT0lc+QktsHfjMKEQbnwrIknuAwkC3x
	xWAQ2sFR5DMj8F1pAMkP65tZumpMfbnPWBOtLtPZJT2fHZD36ISQvcg==
X-Received: by 2002:a05:600c:470f:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-426709faff4mr3510175e9.4.1720467723123;
        Mon, 08 Jul 2024 12:42:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFt1ndeDdo5Dljq1fMljAIlVCgsrBshUQbE/UsJY0MaFHy48JEVe2aviZUfXABsrmh0vBk6fw==
X-Received: by 2002:a05:600c:470f:b0:425:6962:4253 with SMTP id 5b1f17b1804b1-426709faff4mr3510145e9.4.1720467722703;
        Mon, 08 Jul 2024 12:42:02 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-12-248.dyn.eolo.it. [146.241.12.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4266f6f108dsm9867965e9.13.2024.07.08.12.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:42:02 -0700 (PDT)
Message-ID: <390717c3688956d6da04b7de00da3dc57ff9c7a9.camel@redhat.com>
Subject: Re: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
  Simon Horman <horms@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 08 Jul 2024 21:42:00 +0200
In-Reply-To: <20240703142017.346ed0c1@kernel.org>
References: <cover.1719518113.git.pabeni@redhat.com>
	 <75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
	 <20240628191230.138c66d7@kernel.org>
	 <4df85437379ae1d7f449fe2c362af8145b1512a5.camel@redhat.com>
	 <20240701195418.5b465d9c@kernel.org>
	 <e683f849274f95ce99607e79cba21111997454f9.camel@redhat.com>
	 <20240702080452.06e363ae@kernel.org>
	 <CAF6piCLnrDWo70ZgXLtdmRkr+w5TMtuXPMW9=JKSSN2fvw1HMA@mail.gmail.com>
	 <20240702140830.2890f77b@kernel.org>
	 <2e4bf0dcffe51a7bc4d427e33f132a99ceac8d8a.camel@redhat.com>
	 <20240703142017.346ed0c1@kernel.org>
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

On Wed, 2024-07-03 at 14:20 -0700, Jakub Kicinski wrote:
> On Wed, 03 Jul 2024 16:53:38 +0200 Paolo Abeni wrote:
>=20
> > Anyway different applications must touch disjoint resources (e.g.
> > disjoint queues sets) right? In such a case even multiple destructive
> > configuration changes (on disjoint resources set) will not be
> > problematic.
> >=20
> > Still if we want to allow somewhat consistent, concurrent, destructive
> > configuration changes on shared resource (why? It sounds a bit of
> > overdesign at this point), we could extend the set() operation to
> > additional support shapers deletion, e.g. adding an additional =E2=80=
=98delete=E2=80=99
> > flag attribute to the =E2=80=98handle=E2=80=99 sub-set.
>=20
> To judge whether it's an over-design we'd need to know what the user
> scenarios are, those are not included in the series AFAICS.

My bad, in the cover I referred to the prior discussions without
explicitly quoting the contents.

The initial goal here was to allow the user-space to configure per-
queue, H/W offloaded, TX shaping.

That later evolved in introducing an in-kernel H/W offload TX shaping
API capable of replacing the many existing similar in-kernel APIs and
supporting the foreseeable H/W capabilities.

> To be blunt - what I'm getting at is that the API mirrors Intel's FW
> API with an extra kludge to support the DSA H/W - in the end matching
> neither what the DSA wants nor what Intel can do.

The API is similar to Intel=E2=80=99s FW API because to my understanding th=
e
underlying design - an arbitrary tree - is the most complete
representation possible for shaping H/W. AFAICT is also similar to what
other NIC vendors=E2=80=99 offer.

I don=E2=80=99t see why the APIs don=E2=80=99t match what Intel can do, cou=
ld you
please elaborate on that?

> IOW I'm trying to explore whether we can find a language of
> transformations which will be more complex than single micro-operations
> on the tree, but sufficiently expressive to provide atomic
> transformations without transactions of micro-ops.

I personally find it straight-forward describing the scenario you
proposed in terms of the simple operations as allowed by this series. I
also think it=E2=80=99s easier to build arbitrarily complex scenarios in te=
rms
of simple operations instead of trying to put enough complexity in the
language to describe everything. It will easily lose flexibility or
increase complexity for unclear gain. Why do you think that would be a
better approach?

Also the simple building blocks approach is IMHO closer to the original
use-case.

Are there any other reasons for atomic operations, beyond addressing
low-end H/W? Note that WRT the specific limitations we are aware of,
the APIs allows atomic conf changes without resorting to transition
into the default configuration.

My biggest concern is that from my perspective we are incrementally
adding requisites, with increasing complexity, further and further away
from the initial use-case.=20

Thanks,

Paolo


