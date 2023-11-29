Return-Path: <netdev+bounces-52221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EF67FDE8A
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 18:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEE31C209E0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620DF4C3AC;
	Wed, 29 Nov 2023 17:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ro/PLRKk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BC8D1
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 09:39:00 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-548c6efc020so197a12.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 09:39:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701279539; x=1701884339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujQjK1ILR+2hLI6PlT06tIQvStPdR3UqqG1p8t5orBQ=;
        b=ro/PLRKkE8LWnXJks1ZNTl1ynGKa1l6+lyH3Rq2Q7wznfNbSHjozi+1i4V7kjOp5Ru
         GwphosNpDpSs6tBo+ou3GRA5nb8bvXilZkCzczVfFSyg+xJ0AgR+y/ZKZm+o7wZDP7U0
         /LALdwPSYeif02FY4l48R4wvfjMBeDKDX6cegYcqHOrPFow+Qh1CxAEiFs2qiO1inKA6
         iF37i4TooYRVR8EnJlXTMKegTbVRrISULSwM4BYt1NhjZDvQClqwpj4QawPWyJn4yPkG
         b0Ydr0PWjsyinbLzXeWWMJG5KuGFGYs0JvCKQy9r4SZZMuX/V8sb8S353gJ5rRJZOWYJ
         XE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701279539; x=1701884339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ujQjK1ILR+2hLI6PlT06tIQvStPdR3UqqG1p8t5orBQ=;
        b=KjJnD4Jj+HmN5V059la0SKJTa29/vSHkgXZCSTlt2688+2KX3AVjpDN1JXDTMpVF1/
         lnj5p2KEdmbeu/7vSLfyopjWxhtqozzgBgDkdjidEh1s1nuhgESJEpjDXqpKfjztwGMT
         nHT9ZklMrt70wjJg4BcRAjxnBDLMY5Ofmu/KnDPxB+sEx35ZsVD7RAMEik7u+Sd8puOy
         q5u5kk8WhKPSiHujzeoiWOh+tKs19wqmITncqbVogkczQ9vStubAs/tUzxM4lIGuWCle
         Yfs6gT7FnqAouBI5pj0QHroSk/FGwgLz9pSUEqVjT18Uv61LFHfI62wIYsWJjHP4ACBF
         /97g==
X-Gm-Message-State: AOJu0Ywt63SDXZqnGrSuFJRZFN1OA8W9ZQooXjCdWjx7LZxM524vXgYV
	jKrBK5YK2JCQce11Jecwo2LTuFYG8MMmuHaf5DAPRw==
X-Google-Smtp-Source: AGHT+IHx4n14Y0RUSfoYhS/h78Pu9QPJUaL5NPKWAuMAIy41gkXMgUXTd60p842ZCzc7mCUvwN651yAGwkDia4bXWqU=
X-Received: by 2002:a05:6402:540a:b0:545:279:d075 with SMTP id
 ev10-20020a056402540a00b005450279d075mr1069425edb.1.1701279539029; Wed, 29
 Nov 2023 09:38:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129165721.337302-1-dima@arista.com> <20231129165721.337302-4-dima@arista.com>
In-Reply-To: <20231129165721.337302-4-dima@arista.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Nov 2023 18:38:45 +0100
Message-ID: <CANn89iKXEmdz6HTGuMs_02=0e0q7LfLPE7hMovwhQa46=j36gQ@mail.gmail.com>
Subject: Re: [PATCH v4 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
To: Dmitry Safonov <dima@arista.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
	Dmitry Safonov <0x7f454c46@gmail.com>, Francesco Ruggeri <fruggeri05@gmail.com>, 
	Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 5:57=E2=80=AFPM Dmitry Safonov <dima@arista.com> wr=
ote:
>
> Listen socket is not an established TCP connection, so
> setsockopt(TCP_AO_REPAIR) doesn't have any impact.
>
> Restrict this uAPI for listen sockets.
>
> Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
> Signed-off-by: Dmitry Safonov <dima@arista.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

