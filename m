Return-Path: <netdev+bounces-108509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE11924083
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:22:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0163D283A44
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A4E19DF78;
	Tue,  2 Jul 2024 14:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="efYeT6/P"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37FEBE7F
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930129; cv=none; b=Fn4AVP+HdUJoPfv9ykdTasDa0jId94Za/2SihozjFNDGr5kcSL8qY69szK/i8n6Qko1cGaBQbQNA6UjBIkd6RqcCv8jcNhkW7euwcFMCoGlGN8y2qm6SUcAeXtTXTEvG9SHrQSedpdYtLlU61BKxR4lkGNiqq7iyUwjUmeKg4eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930129; c=relaxed/simple;
	bh=T3RL5XOku44vKPK2lavpnSne6YqHYsUAqPaLbGhcAng=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ar6NIdHkIp6xAWnE4vbk+O1Mv4KD9cuAImDgtJ4avNrvXZilNx2q4TwGEfxX5qr94T2vhYPqIxbo+M73CqEVirNXj2eMhF0qCVqeZqnLzOUWMLdCv99wvrtIxXxrOmQ9f73wmye/uKZ6J6LvVWW+t73yjksEdbl2NDLaRQvG7Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=efYeT6/P; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719930126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7815WmjE9X2+ZQtupGQUm4RjqGydZYOn+/8Prxy4HBk=;
	b=efYeT6/PDoPopNTatg0qWGla7xFHnghZbg3hLwx70YV3NpJjk6l5N8ECmVCZzBOnT5ngHa
	L3PLLbL1tLT29Q5F5cv3eyV81CDKWQDBeCDg6ny1kTXOE0RuvPAWgS+2kNzObnHJR4NqVz
	bse+S+0gI/0f7jc8knhjMGNdjDIH6FU=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-jW-fvCN0NvCZkofaIQiTYg-1; Tue, 02 Jul 2024 10:22:04 -0400
X-MC-Unique: jW-fvCN0NvCZkofaIQiTYg-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5287fb139e9so29204e87.2
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 07:22:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719930122; x=1720534922;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7815WmjE9X2+ZQtupGQUm4RjqGydZYOn+/8Prxy4HBk=;
        b=NGkhh04cbXOFFIlKsrz0ao7GSOE5RTEpQvQbj5yixPKI5HLwiz8PquTYiTXYEcokyu
         BpRMGcJjrvP50HP56OXJoadu+yJ3zea5BMFVpz3ymtC/t9qThcqxSIW91VnPA2bZNj/h
         5JG666n5Xx5P6bY4BxHD2JSyf7sbLNQH6MyQNlHIhW6DxFpsFGV0G1yvnOX+6konM6MM
         LHNObkKnvrfpwK/zwcv8khVELQY+0FQtgARvGkNchsPNr/XcV9x9SyoCkXqqK+Rt9ZGC
         ZtVDPmQ08C7ec0u4Ix9rKw66BNTVYFhcAeL3bGYPPtuVZU8KWcUDTEeUHTwz7PSSgmdk
         mnaQ==
X-Gm-Message-State: AOJu0YwQg0hbOihruH4K9zEUp3vxj01ZnL34F5H7uSYwuSYo2ZPmnKeH
	RivEOGdDq7yW8GHD2s4UazwecsWxqJIqUh7FA5T6k3PsYuJyNayaFQtSl2thpRI5Zkwy3EsslAf
	2JumniaqF2TYEG/5xAaSi7bdYolaa44jFQakanSgzRNDSTtKnn3ZeoUwrWXyYSTTb
X-Received: by 2002:a05:6512:2209:b0:52e:7407:3510 with SMTP id 2adb3069b0e04-52e8266ebd2mr4967225e87.2.1719930122707;
        Tue, 02 Jul 2024 07:22:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IET8Et/tDWczZHcAHJJu55Acmq2ql9hOlBDZ9zkarSbeGRfk5Lzq32fnOzn1BApH3+l77Btew==
X-Received: by 2002:a2e:b5cd:0:b0:2ec:4e02:f460 with SMTP id 38308e7fff4ca-2ee5e34793emr45055361fa.2.1719930100797;
        Tue, 02 Jul 2024 07:21:40 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3341:b0a6:6710::f71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af389b3sm203216185e9.1.2024.07.02.07.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:21:40 -0700 (PDT)
Message-ID: <e683f849274f95ce99607e79cba21111997454f9.camel@redhat.com>
Subject: Re: [PATCH net-next 1/5] netlink: spec: add shaper YAML spec
From: Paolo Abeni <pabeni@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
  Simon Horman <horms@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Sunil Kovvuri Goutham <sgoutham@marvell.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 02 Jul 2024 16:21:38 +0200
In-Reply-To: <20240701195418.5b465d9c@kernel.org>
References: <cover.1719518113.git.pabeni@redhat.com>
	 <75cb77aa91040829e55c5cae73e79349f3988e06.1719518113.git.pabeni@redhat.com>
	 <20240628191230.138c66d7@kernel.org>
	 <4df85437379ae1d7f449fe2c362af8145b1512a5.camel@redhat.com>
	 <20240701195418.5b465d9c@kernel.org>
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

On Mon, 2024-07-01 at 19:54 -0700, Jakub Kicinski wrote:
> On Mon, 01 Jul 2024 12:14:32 +0200 Paolo Abeni wrote:
> > > > +      -
> > > > +        name: shapers
> > > > +        type: nest
> > > > +        multi-attr: true
> > > > +        nested-attributes: ns-info =20
> > >=20
> > > How do shapers differ from shaping attrs in this scope? :S =20
> >=20
> > the set() operation must configure multiple shapers with a single
> > command - to allow the 'atomic configuration changes' need for Andrew's
> > use-case.
> >=20
> > Out-of-sheer ignorance on my side, the above was the most straight-
> > forward way to provide set() with an array of shapers.
> >=20
> > Do you mean there are better way to achieve the goal, or "just" that
> > the documentation here is missing and _necessary_?
>=20
> I see, I had a look at patch 2 now.
> But that's really "Andrew's use-case" it doesn't cover deletion, right?
> Sorry that I don't have a perfect suggestion either but it seems like
> a half-measure. It's a partial support for transactions. If we want
> transactions we should group ops like nftables. Have normal ops (add,
> delete, modify) and control ops (start, commit) which clone the entire
> tree, then ops change it, and commit presents new tree to the device.

Yes, it does not cover deletion _and_ update/add/move within the same
atomic operation.

Still any configuration could be reached from default/initial state
with set(<possibly many shapers>). Additionally, given any arbitrary
configuration, the default/initial state could be restored with a
single delete(<possibly many handlers>).

The above covers any possible limitation enforced by the H/W, not just
the DSA use-case.

Do you have a strong feeling for atomic transactions from any arbitrary
state towards any other? If so, I=E2=80=99d like to understand why?

Dealing with transactions allowing arbitrary any state <> any state
atomic changes will involve some complex logic that seems better
assigned to user-space.

Thanks,

Paolo


