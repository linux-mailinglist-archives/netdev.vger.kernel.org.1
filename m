Return-Path: <netdev+bounces-210417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34B6DB132EC
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 04:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BCD18944D0
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 02:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1882AC17;
	Mon, 28 Jul 2025 02:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3lNc+2s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272E3CA4B
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 02:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753668844; cv=none; b=I2NwMxsO3bVqARvwaQWf4lLeJVFhGNTlAKN84Gr6MGWiobwnM/kqvKfO8eHQmoa3MwZ6Nu6ZJDg2Ad5awSDv4IzodBMkQUIYFg34ink6J8AZ6dgyd4oe9DhQQ8M24zUKRLE6S8aWyd84xWIsvhKWhOPK7fr3smFuQzrCx6l1t0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753668844; c=relaxed/simple;
	bh=ZH2H1SHgXHAzNvURWNO/Q7IBGF7/DRF3UU1mvJP7/a4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i5F5iKZNS9/3d8mlWQt6ZgkGi9RAFS+wGYePAQbzk5eLq2CfjuXTcNg2anjxBWPG/XY765qELKZGfliCc3STX6twAPGhaJd/LRAs+lPBwRf0FvOoeMQ0gJtwxEWIrXeMTTZIoy7Hv4znjEyUTPIV6ThANwnbLVcv5RMlopVXMok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T3lNc+2s; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-31ecdf5faaeso681673a91.0
        for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 19:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753668842; x=1754273642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LaHfsGO5kWY9ze7ehxNDvVyriG9bkoJ18mlYZyClRac=;
        b=T3lNc+2s0n2Pa65Z7y2dVCdvlNFtYGag8PRd7WIBhjy4fQfgl2ZKQC2hEddeYKlIC4
         BmowmBd9Uz17KRy7wBJoey+tDo1Uoy7Y7Do4TvWnCrkah4dz97++wWEJkCLyc+vd5CIP
         2WqMFhGKdsGNL33JHBc7QXQsLFybRD4KD0CrlhA17Im2NyS36CL0N8yniBIocBD8XqXq
         nlHdQzQspJqNg8bhffrZNupxLhJkNg4waTNCAx0AXeAlxRHBnrDObTR0QpXTVKvpj3mT
         hKipEb4nn/U4Bym6EZbYp/WRe+d5kObSXH8yyw3iQSIBz4ThDaasc5N0Px88FQgrlD8R
         MFbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753668842; x=1754273642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LaHfsGO5kWY9ze7ehxNDvVyriG9bkoJ18mlYZyClRac=;
        b=oUpuYnfNs7cR7kpf+uhSAa956GncPPl3J4l5YHtC6RFFzq/Ug+eTJ4clIOwfA2AO/D
         NvOJl3qxDUuGN/80NuAF2IWr3G//U/L93qQCe3hAtvVThooccgkizXDlGx/LrxvBcsb9
         psp7zTx1ejgMwgxuv+GToM014yfw9ppopIQP/7Xt4C+lMz9pf7KPlBQtjFMSVJaUq1J8
         aujaVocRIZRqaW/1GoOeDaILfTED4XXopwfOX02wdfUitwvJktc6TdOAb+snP0ZSev3K
         ZOBv4WJSk3N3U6Q7kQI7bhwpVqDKdiTHBHBeQZzFPAqLAtHb6Cv6pcoEhjLUnL2cMSxE
         jS8A==
X-Gm-Message-State: AOJu0Ywr+JT8JdOffExKp8GXQKRCPn1hbR5cZsft/GZ72qKaUWqTzwEx
	eGFqx/t5qu4ipxwYfvAOm/n13BaDXrLqXJBXQigc+GnbLLPicJz9QPiENVrDu9YsMhdoiLJmjDs
	aU917FqYdsj/ntNZTtxV0CqMQkQV9mRw=
X-Gm-Gg: ASbGncu9BWej+dJhAv0cfDNyjvK+/o/XrQZC8NAoQNPG5XOthJcgZDB4YqF9Mvj6pGc
	BBOy4Q1dhNdggk2n84yux4LDqmeV6LpqbjSORyi0HZdMd6fs/64FddDyZ2fEOM2VVWibXD0CuWy
	Wx8/yKEAdeG4f2btVF5ZBiXgYhArbS16BHx6Hz8IxOShbvcNDzpJzwkNBrpCF1x6XbNRl00tha2
	ykw0sWNB5g8wejjSEM=
X-Google-Smtp-Source: AGHT+IGPJwYfsoYv9OXLG/VCE6vhitz45QSjq5fMJ1+V+gyfmGE97xF95tkrl+oW7D0MXj+eG/vJ3culxngP8qKToEk=
X-Received: by 2002:a17:90b:248b:b0:31f:20a:b52c with SMTP id
 98e67ed59e1d1-31f020ab87cmr715820a91.0.1753668842299; Sun, 27 Jul 2025
 19:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250723061604.526972-1-krikku@gmail.com> <20250723061604.526972-2-krikku@gmail.com>
 <20250725154515.0bff0c4d@kernel.org>
In-Reply-To: <20250725154515.0bff0c4d@kernel.org>
From: Krishna Kumar <krikku@gmail.com>
Date: Mon, 28 Jul 2025 07:43:25 +0530
X-Gm-Features: Ac12FXyOc20TTY1Ayqt0ocFt04RhxxAGGBZadhBqkMR0aoHI-7eSMbNdukqiQcU
Message-ID: <CACLgkEY4cRWsRQW=-PSxnE=V6AvRuKuvYzXSuofmB8NMJ=9ZqQ@mail.gmail.com>
Subject: Re: [PATCH v6 net-next 1/2] net: Prevent RPS table overwrite for
 active flows
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	tom@herbertland.com, pabeni@redhat.com, horms@kernel.org, sdf@fomichev.me, 
	kuniyu@google.com, ahmed.zaki@intel.com, aleksander.lobakin@intel.com, 
	atenart@kernel.org, krishna.ku@flipkart.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2025 at 4:15=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:

> > +     return cpu < nr_cpu_ids &&
> > +            ((int)(READ_ONCE(per_cpu(softnet_data, cpu).input_queue_he=
ad) -
> > +             READ_ONCE(rflow->last_qtail)) < (int)(10 << flow_table->l=
og));
>
> Since you're factoring this condition out you could split it up a bit.
> Save the result of at least that READ_ONCE() that takes up an entire
> line to a temporary variable?

I agree that will make the line far easier to understand.

> > +             /* Make sure this slot is usable before enabling steer */
>
> This comment is less clear than the code..

Ack. Will remove.

> > +                             /*
> > +                              * This slot has an active "programmed" f=
low.
> > +                              * Break out if the cached value stored i=
s for
> > +                              * a different flow, or (for our flow) th=
e
> > +                              * rx-queue# did not change.
> > +                              */
>
> This just restates what the code does

Ack.

> > +                             if (hash !=3D READ_ONCE(tmp_rflow->hash) =
||
> > +                                 next_cpu =3D=3D tmp_cpu) {
> > +                                     /*
> > +                                      * Don't unnecessarily reprogram =
if:
> > +                                      * 1. This slot has an active dif=
ferent
> > +                                      *    flow.
> > +                                      * 2. This slot has the same flow=
 (very
> > +                                      *    likely but not guaranteed) =
and
> > +                                      *    the rx-queue# did not chang=
e.
> > +                                      */

I took some time to figure out the different paths here as it was a
new area for me, hence I put this comment. Shall I keep it as the
condition is not very intuitive?

> > +                     /*
> > +                      * When we overwrite the flow, the driver still h=
as
> > +                      * the cached entry. But drivers will check if th=
e
> > +                      * flow is active and rps_may_expire_entry() will
> > +                      * return False and driver will delete it soon. H=
ence
> > +                      * inconsistency between kernel & driver is quick=
ly
> > +                      * resolved.
> > +                      */
>
> I don't get this comment either, and rps_may_expire_entry() does not
> exist in my tree.

Apologies for the typo (rps_may_expire_flow). This comment can be removed
as it is already known to driver writers on the consistency of rules betwee=
n the
kernel and the driver (the driver caches its version of the flow
internally before
programming the rule). I will remove this.

Thanks,
- Krishna

