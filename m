Return-Path: <netdev+bounces-88668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 190B78A82A2
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 13:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49F841C203B9
	for <lists+netdev@lfdr.de>; Wed, 17 Apr 2024 11:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5060513CFBA;
	Wed, 17 Apr 2024 11:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="E2hMp4WC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B135313CA9E
	for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 11:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713355132; cv=none; b=KGLPw5fEv0YsHkvVQfF/yhXYtl+MtaY1Ia8rRluJeM2XZYhtQ7F1c/n/Mxj1REeIj6VwPWWQzIliQYg+mnNTCcyk1dCU5ZwAN7XFiQhkcTHtAkaR0GlnRf0dJrRx/Y0XMX20w+bnNIekCa1ecNeNOZr9Yr4xa5hcO5aD8jRK5B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713355132; c=relaxed/simple;
	bh=i++d/LSGW+ItQM1cv25ZIcpp8R8VZzG/u0n7K8I+Zro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cnJrKgRZ2zEA9WRCQ82MBjXNHxr7H4RQz1zCqdHgcUI13/plTGicQVg157J1FSMdNFzh74nwMpNeamcxsaGdY09mU2ZC3HC+TnYQXMaGpUoSxQG9UnlRawflegt+dqW6gBV9ovN/zKIGHfQf9gXOQv4fTImYyBhV3yraJQEMq20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=E2hMp4WC; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5700ed3017fso12083a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Apr 2024 04:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713355129; x=1713959929; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ddgmhf4VOJewzysoq0Rn4OGoTJBxt8VjAEnHieO5oY=;
        b=E2hMp4WC/ndwFusUXUhTA+mTwf3+NHWxKppdsKemMHLx+L9sFLtv3DvWlyArWMGFOb
         KLyV9u7PFUhzpSEIZiZbEaUCRGPluqsmUAgAOJKvt73DREuLkFP8WyyrEnS2Kz9eP5Xi
         hV0+qyjdA15MBGA4gLHHNCn3IJc7MeZ87D0dUKKvF9vsUV7ZywBuGir2ea++U4tpa0KZ
         pbbSfbikOv5U/Ej/BBRxQXN14GggRA4nlqKg63GvM4nFIrJVpRnEAp/TIx6QVREpxHj4
         VKzrGxnjMAzK9MW3M5oTybVDLb5JwmQyKgz8KnDmB0++z7RHHIOJaizM3yP1zMRsAmSH
         l/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713355129; x=1713959929;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ddgmhf4VOJewzysoq0Rn4OGoTJBxt8VjAEnHieO5oY=;
        b=ZHkXX86EzY15298bqvExTfzuDMVOFFbogUwPhSVfE17+u5nIETvTQjSjQzHK9BqbJD
         Uku2pBUzszplH791BClB7J+/LQRU3MB6W+MMitscWpv58y9hSaLvB83Ale8qnRNXKOWP
         GWMxKNcuv+IA2sx/5mpYkdYirbm+czrWLd+bCGXRJJMfh0dcQGbGCvxRj2cWSwIL4BOo
         F4Xn8mEffdNYXf4cgKMezpgCkvC1x+DwqyckuY1haDwBiWizCqWyEInHTCn0XNRYRjLP
         u6c3VawpWhK7M9+oQEMm2C8grNJzwcK+cKy3YSpwQLfQ4mQoK/VtBx78hSZagBQ4St2Z
         npsg==
X-Forwarded-Encrypted: i=1; AJvYcCViPboAYqY6BZsVY9ogBQrpRBULTyLbnYCrMGtRrmQNz92dXXzlqO/6CXY+DAUad6+zkeLMNCA5HCWUroWcJHxtcS+m4iOg
X-Gm-Message-State: AOJu0Yxg+mzIPlehZ227tt6brMk8A0iCsWzXlkghAgOu4UrK7ZPlWRUB
	9L/yo5U2PCCGu62wszq2EJdCEw+Ih7Gv4xCqzvX3n10XhjwVggiv+lx1UwhSr+xCpjwZvtnii8t
	sDJn6r3WB06zV5FH1x9hLCHADz+zOEiu4C6R4
X-Google-Smtp-Source: AGHT+IF1rihMtq4Tk3ikzU7fRYVPFHCJ6l3Ie9PP+b0QgG7TSFcZPFLZmdUKOeP50/KhMY6+oZaoKfVknr+lxHbdl+M=
X-Received: by 2002:aa7:c90c:0:b0:570:49fb:79d0 with SMTP id
 b12-20020aa7c90c000000b0057049fb79d0mr142349edt.3.1713355128771; Wed, 17 Apr
 2024 04:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417062721.45652-1-kerneljasonxing@gmail.com>
 <20240417062721.45652-3-kerneljasonxing@gmail.com> <CANn89iLKxuBcriFNjtAS8DuhyLq2MPzGdvZxzijzhYdKM+Cw6w@mail.gmail.com>
 <CAL+tcoBZ0MCntKO2POZ9g6kZ7euMXZY94FWN85siH1tZ6w5Lrg@mail.gmail.com> <CANn89iJovrpBc8vFadJZdA89=H5Qt8uvj2Cu3jr=HHP2pELw2Q@mail.gmail.com>
In-Reply-To: <CANn89iJovrpBc8vFadJZdA89=H5Qt8uvj2Cu3jr=HHP2pELw2Q@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 17 Apr 2024 13:58:37 +0200
Message-ID: <CANn89iJm3Pokx2hJy4af-frhV2+cadRYBSydG2Pc5w3C7d8RrA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/3] net: rps: protect filter locklessly
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net, horms@kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 17, 2024 at 1:52=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> @@ -4668,7 +4668,7 @@ bool rps_may_expire_flow(struct net_device *dev,
> u16 rxq_index,
>                 cpu =3D READ_ONCE(rflow->cpu);
>                 if (rflow->filter =3D=3D filter_id && cpu < nr_cpu_ids &&
>                     ((int)(READ_ONCE(per_cpu(softnet_data,
> cpu).input_queue_head) -
> -                          READ_ONCE(rflow->last_qtail)) <
> +                          rflow->last_qtail) <
>                      (int)(10 * flow_table->mask)))
>                         expire =3D false;
>         }

Oh well, rps_may_expire_flow() might be called from other contexts, so
only the  READ_ONCE()
from get_rps_cpu() is not really necessary.

