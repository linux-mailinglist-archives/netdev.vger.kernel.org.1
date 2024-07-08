Return-Path: <netdev+bounces-109880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9DC92A245
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704CB1F2279C
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CAF13B798;
	Mon,  8 Jul 2024 12:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0vvqDe8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0666C7407A
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 12:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720440495; cv=none; b=Wgdozat8D+skoOPInEoXtBI70JLk2z6U+dchOliw/f5XknlD5ZM/3LDMS+mjV3maXnYfSCHqbJrNAKao5eDk5a5v3zpqGIOs4VnB1hp+6dSUuj7+NSTgGd7xd4zeYwWcZ2m3BMa/nXvM7ZqnwqUcr8NVM2aPZutGCMac8g6R31M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720440495; c=relaxed/simple;
	bh=CZz0OjF+N3d/uH296pPaOfWKFpaq9SpRo0F+caUTF6I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h7UFbynUK1vzjvKkLadQta9aofqooVs1681g30E3DmgXw2MtRrSTsC5RT8kI2+IeOi0iBSvbOe8hFVhJ5B1gNSPBbut5GDQhEWwJQNZIviaioBGJu7RBDfbaFUdzQ1tDKmGqzyF1tkp4LxjRmMZFmHrrCPFibd3mjuB9PlUG0us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h0vvqDe8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720440493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Nwb/NHCNDPBbNOYdrz+GYj8J2TCseSslvd8sX/M8mWk=;
	b=h0vvqDe8ogmpj3+nSGVKfQmMZMw9Hiw/9bf973evxfzsnfJs4kayuvF5qez0SUe0KeYA+Y
	HzEhrGrjgq9pU8kLg+GZMsXFSaycgVBWJ21frk8ZllG0XaRO8R+UAS8HWr7BHYWFFGlzcH
	MZeDg/yeH0emLnO+2fPVQ8YWYf+G+J4=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-trSzgQdxPfuQfeSRVADw-A-1; Mon, 08 Jul 2024 08:08:11 -0400
X-MC-Unique: trSzgQdxPfuQfeSRVADw-A-1
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-6c9b5e3dd67so2290455a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Jul 2024 05:08:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720440490; x=1721045290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nwb/NHCNDPBbNOYdrz+GYj8J2TCseSslvd8sX/M8mWk=;
        b=azHosjgpMnoqhUQfrqTIBJobVSmvACVePZAHZTgF8eNYn4lQsUSsrLOQtNeuTOz48P
         OyMkUPde9wXkXRxBCwYpccwxtWVei4VAgUo/0v/5axt6k5TTaVZpTfGrmP/lksJHLCkW
         5u9WwHz06Ar4eg1o4GlmvFBf76CY1lEhrcA1AdkKysSvwjaB7JIOJW665mT5YJAGhqbq
         0TdFC05OjZSrC85IqOGD3tSL9zqM5arZ90ag0z58Sm7UJEesRg11U2LxJ2Ou+rbFoFzg
         sZlFRm/u9E2MVY+lHxUzTbEzXOJo0Uqi/9ekvt5KCqlx1E5J8wekSEkrv7RanNw9NZ8D
         S6mQ==
X-Gm-Message-State: AOJu0YyLEiRJLTF6f3F6hZaK3BIzG28pmD+YCY9ioFpwOBKfciB0KgFB
	/xy1RR6esD023h03xuCyAKWgHt13FDZ1PPglKv95Z2LstqUMqGAR6X+PAITh8b/5v3PD0/bV1TR
	zVC/40lxjEjN62Tr7eJR8Ql7L5rI3y7tOPb3VGr4tS9pnkED1059gGZr0J7e070oWNTzkmvsZb+
	qVoIrv8crHEdc860JPdauRBeKy6oXX
X-Received: by 2002:a17:90a:ac0d:b0:2c9:7616:dec7 with SMTP id 98e67ed59e1d1-2c99c54186fmr7125423a91.6.1720440490515;
        Mon, 08 Jul 2024 05:08:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPwHzsQDzGu+xR3DQUoweoTT1Kf7TAdTBOw1dFR4nyWDCgQYp85Jk5+a4EU54LIpsTE9hEkS0qlGqZ3527u2o=
X-Received: by 2002:a17:90a:ac0d:b0:2c9:7616:dec7 with SMTP id
 98e67ed59e1d1-2c99c54186fmr7125397a91.6.1720440490094; Mon, 08 Jul 2024
 05:08:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705133348.728901-1-ast@fiberby.net> <20240705133348.728901-2-ast@fiberby.net>
 <aadf8f7c-2f99-4282-b94e-9c46c55975dd@fiberby.net>
In-Reply-To: <aadf8f7c-2f99-4282-b94e-9c46c55975dd@fiberby.net>
From: Davide Caratti <dcaratti@redhat.com>
Date: Mon, 8 Jul 2024 14:07:58 +0200
Message-ID: <CAKa-r6u85yD=Ct4nq2xZLXLT+3vWsz+WoDZ__xS4tkpge=yf-Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 01/10] net/sched: flower: refactor tunnel flag definitions
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, Ilya Maximets <i.maximets@ovn.org>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, 
	Ratheesh Kannoth <rkannoth@marvell.com>, Florian Westphal <fw@strlen.de>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, linux-kernel@vger.kernel.org, 
	Stephen Hemminger <stephen@networkplumber.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

On Mon, Jul 8, 2024 at 1:12=E2=80=AFPM Asbj=C3=B8rn Sloth T=C3=B8nnesen <as=
t@fiberby.net> wrote:
>

[...]

> Davide, I think David Ahern would be happy [1] if you could post a new ip=
route2 patch,
> since the kernel patches should preferably hit net-next this week (due to=
 uAPI breakage).

I will send an updated patch (don't use "matches" + add missing man
page + rename keywords [1])  in the next hours.
thanks,
--=20
davide

[1]

> Nit: I would prefix all of these with "tun_".

"tun_" or just "tun" ? please note that each flag can have a "no"
prefix, so is it better

notuncsum
notundf
notunoam
notuncrit

or

notun_csum
notun_df
notun_oam
notun_crit

?

(I'm for not using the underscore - but I'm open to ideas: please let me kn=
ow)


