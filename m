Return-Path: <netdev+bounces-91742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513CC8B3B57
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 17:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1EBEB25AC6
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 15:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3BA7149C7B;
	Fri, 26 Apr 2024 15:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UNzHCQ/B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EBD14A4C5
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 15:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714145113; cv=none; b=sC4aNc8hiWiTmotvA88smfH/DHZU2OrT+axEf0xfWCQCTypowssChnjwbq1rVtV49f18Xa7LgEgWxrw2zjqY6UC19HmcinrCq0umLPQ8N0FNN8ecrFrpX5dgZNDwODmKBtsaVFwyXYw6W8zUWhhzaExpU4iZNbJ8UarrytRcLHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714145113; c=relaxed/simple;
	bh=6N4aP4sE6VyJqTCJaJ3NQ0EAj/+TV667NwAa9Gr3yV0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=rXYTecKcZnCNA4Y5tgCPp6Z7psr4+97qq4qR5vsItnsZxjCT3NrOeYUl6jNRMOAtgviyYw/H0BxRBwlOzBicJ4tvmRv0Qibmi/OaTVdfwJYoHvGdIKH93f2ROKD9d1x/vK2PKgqwaDBGYGz1U+yNzCTRcjIhh2UPcMeknoRK+fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UNzHCQ/B; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-347c197a464so1619011f8f.2
        for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 08:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714145110; x=1714749910; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OEK8/+rMjT6YVD6gBtc7jlDXSLtHOuS5Ag8W00I4aPA=;
        b=UNzHCQ/Bmu59MDmqDkIh6jOK88U8XIfACLqTJk4/JsR6444WJi0j9q1Jfw6eUtgn4U
         ny5PoYMVQi5f3KTCXYIxLGPLztFIx25B/sn59SceWPhmRGLJ12D/nXq3uVyhGiHcHaUS
         rX/d45aWr9pDJaoynFSN/Atlqk3bX0KrlqbFZ931aQOyF80OPAEDBCcWPRlKcMbwgo9e
         Ab+n2Xl3vjkwRZWxBcAFSOINuvD5kRX68dnLpOdfdRDgKX4nE7NKfD4CAe80Ntr8gIVu
         zcJSV2SKmUwv7T1wrKcUG9zlKbvARvStYKIB/ndVV3Y+n2QsMejenntoWt4DatmdHMi1
         OL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714145110; x=1714749910;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OEK8/+rMjT6YVD6gBtc7jlDXSLtHOuS5Ag8W00I4aPA=;
        b=gbkzTlXVuKMpFlr0mjARt0xjJFlOZGBfO4AWGV1Yp6poUb2INupGK9qlHQ2ocFAeCK
         DPyWXpitHZoZCXQ98Eiu8S9iZ2gD/fQB9eA8DPf4WIHCI1sqFv9fo3cZWtoYC/qwQKmp
         2BKYMoX/z7esdl1+7ergsglbP1MSbwNsUrRcrGW5vGSvpcpw2qD4hpq2ejvFQkvB6+mF
         IYTGtW9u1bipa9NvpWM5fMZAN1MdqzEWsDFylRQoc9LMaEd2dJtHyy2SfBIQeuVJ3unb
         DBmEm/bE59pRSten2C1Fm0pNGc3reFBHtUNZms1VKrCq+k2PDkO3ZFKNaOcSFu/BUbwc
         3w6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWU2cwvwfScjgaiQW9SCkJiNEwS0pHB7VnRMBY0FyRgqSM9B3e9K1r0f/1YJAubZpiDmWcD9Wp2sMqdXmX1yi0azVAyjFUY
X-Gm-Message-State: AOJu0YyfPMQv/ILEGtl+arJtdYchqK7MgSX2JPAZaCM3Vs+StRkA9MSD
	MKfAk6AGqN80aYYGp2j38pgAv6RR/eP98v6Xu3KjCfCHUuJWJJ+E
X-Google-Smtp-Source: AGHT+IHwxPtmXmRI1u/lDAjpJM8vXASs/Q6+KDodBVEO81rsE0JwUXZpV82b9H+E4bQ06DFwo+/y1A==
X-Received: by 2002:adf:f841:0:b0:349:9de8:9896 with SMTP id d1-20020adff841000000b003499de89896mr1960026wrq.29.1714145110361;
        Fri, 26 Apr 2024 08:25:10 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:28ef:de16:bd69:2a94])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d4b0b000000b00349a6af3da5sm22591272wrq.51.2024.04.26.08.25.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 08:25:09 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com
Subject: Re: [PATCH net-next] tools: ynl: don't append doc of missing type
 directly to the type
In-Reply-To: <20240426003111.359285-1-kuba@kernel.org> (Jakub Kicinski's
	message of "Thu, 25 Apr 2024 17:31:11 -0700")
Date: Fri, 26 Apr 2024 16:25:03 +0100
Message-ID: <m2sez8f8og.fsf@gmail.com>
References: <20240426003111.359285-1-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> When using YNL in tests appending the doc string to the type
> name makes it harder to check that we got the correct error.
> Put the doc under a separate key.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

> ---
>  tools/net/ynl/lib/ynl.py | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tools/net/ynl/lib/ynl.py b/tools/net/ynl/lib/ynl.py
> index 35f82a2c2247..35e666928119 100644
> --- a/tools/net/ynl/lib/ynl.py
> +++ b/tools/net/ynl/lib/ynl.py
> @@ -233,10 +233,9 @@ from .nlspec import SpecFamily
>                      miss_type = self.extack['miss-type']
>                      if miss_type in attr_space.attrs_by_val:
>                          spec = attr_space.attrs_by_val[miss_type]
> -                        desc = spec['name']
> +                        self.extack['miss-type'] = spec['name']
>                          if 'doc' in spec:
> -                            desc += f" ({spec['doc']})"
> -                        self.extack['miss-type'] = desc
> +                            self.extack['miss-type-doc'] = spec['doc']
>  
>      def _decode_policy(self, raw):
>          policy = {}

