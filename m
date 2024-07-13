Return-Path: <netdev+bounces-111243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1959305BD
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 15:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36CFF28206A
	for <lists+netdev@lfdr.de>; Sat, 13 Jul 2024 13:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F83132124;
	Sat, 13 Jul 2024 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1ojjmMX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9596EB46;
	Sat, 13 Jul 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720876917; cv=none; b=aDj/+jBKNkIXdCCyHrKIhWBQ6RxP4wLNkpLELCL4CpzSr7LmfbmE9elRBMz/8HZhNdQZtIC8N2am2HC3FU81foAxGKzOsYL08swC+c+bZOHn+mzCm9C4AdZ5LsSkZ/zQRbrdrOFHc4/KhmMEkFEyCrGN5jwlb+53LmTrdqusC5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720876917; c=relaxed/simple;
	bh=honn9ygJb4ImAhrWiHlS8o+IFmNJ/zou2TwVBoVwfL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cph+eGsZleyyBVaU3gyM8V6UDFoxVcymATIna7Yxg7FGup80K9kUITzJ2W1f1Ae9JuFzdgKAV3ck/ygjKkdMzW80kateU/G3aR45A9qMMuLlx5OFNeESwDtFLid+ZAyI1B4sSJwYJLJtffpHUFeRnihSPdiPPYMRtlmY9zYL5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1ojjmMX; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-25e16380bc9so1504144fac.1;
        Sat, 13 Jul 2024 06:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720876915; x=1721481715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=honn9ygJb4ImAhrWiHlS8o+IFmNJ/zou2TwVBoVwfL0=;
        b=O1ojjmMXwnrujnV6wO5HWtFxlIvf6tOZH3nsr28q3B5lhIyCWej04+gwB5G3WtLGRt
         jmc3XynQnCDLcB7qcsrvlJuVkIKgNIB+JL7sElJ3d6TMqmJK2Sr9W5GIve8GaLidbce5
         gT1PQmwSS6i2XBDdJBY0erpgVZ7cSK+OMpcwqsyTHloAP7dgLMQxXpcwdQ4AlyiRM+4W
         LreAeEkeN2a4fLfLMTi3FzXJM659U0WLIhgwRCpHQfZCp7RbusVnnbIn9aTCavrAVNe3
         3hTCb2gtsL1cGl1VvOJ+z50xAKGDYbY9jPkYZK36pInG8E4Sxhhu53mt+k1MzunJJfZu
         GMzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720876915; x=1721481715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=honn9ygJb4ImAhrWiHlS8o+IFmNJ/zou2TwVBoVwfL0=;
        b=S8e84P5t+cavvLBP+GYnBtSe6n7HyD+dAmJZNRSCyDFcKv0ZncwIAI158qkQtFUU6x
         Evw+H/vzEQYfZ35nZNYYNFcy/slH50kTkY3DJz8FHiQ/eQ7S0Vb4bcPftsMvY9GBjGu9
         b4quBZMTH5uVrPUIAOeNjjHnKg6SgJRtkrnP/tuLFoDIHiEZ1YIQb8JdqKSATdWNLEUj
         VRiIGoSD+hELqrrZ9VgDJbEX+IgyMgQsSznZBUaDEQRaIcmYwkYvPiF6qcnAsjBIvQkZ
         e4h1IoCnWRV9vatuMQIj6ucmyRPvHD4Z499KV2Ygrd7PwdTud3rDgNWSm3sLeiF2ecG7
         W0vg==
X-Forwarded-Encrypted: i=1; AJvYcCWHYU6+5knaEtR2CuUtMPN1HWQEA1gdR7rD68XFj23QuuTF9oxwTdDSSJw6U+55UopfwOgSkf3Hd+uq97AckB1tBh5guUNIutUTlX6R
X-Gm-Message-State: AOJu0YyBXhNDeo/UOEByjAqLWoXpEW9QSSGxt6at09DNyh/2RN8ZYq6T
	84Hy8LEcFViT1zLppuCQaKz1g2LwuwqtHw3egn28XdG62Ou2qL4VM3cu7jfIEKOzoLtLg4NZUMn
	sqAoXMfA6fmrCqEQapaOgcy/TDOw=
X-Google-Smtp-Source: AGHT+IFAvefHU5Q7T9cKlpGSPYf9h93Fvyv7BmlSPWk83ViBwMHWwSEI1wgbc1ZTdvhD9LOi2jF45Mu+KmSx6o8i84M=
X-Received: by 2002:a05:6870:46a9:b0:25c:b512:afb1 with SMTP id
 586e51a60fabf-25eaec7af32mr11165204fac.52.1720876914875; Sat, 13 Jul 2024
 06:21:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240713021911.1631517-1-ast@fiberby.net> <20240713021911.1631517-11-ast@fiberby.net>
In-Reply-To: <20240713021911.1631517-11-ast@fiberby.net>
From: Donald Hunter <donald.hunter@gmail.com>
Date: Sat, 13 Jul 2024 14:21:43 +0100
Message-ID: <CAD4GDZwZDv2Z+9-EdS61u7X1YDSRLYmkaj5mLRiSwMPyRG6wPw@mail.gmail.com>
Subject: Re: [PATCH net-next v4 10/13] doc: netlink: specs: tc: flower: add enc-flags
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Davide Caratti <dcaratti@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 13 Jul 2024 at 03:19, Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby=
.net> wrote:
>
> Describe key-enc-flags and key-enc-flags-mask.
>
> These are defined similarly to key-flags and key-flags-mask.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Asbj=C3=B8rn Sloth T=C3=B8nnesen <ast@fiberby.net>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

