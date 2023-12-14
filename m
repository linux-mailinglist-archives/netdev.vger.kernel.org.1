Return-Path: <netdev+bounces-57562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDEB813669
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD381F216F3
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3D760B8F;
	Thu, 14 Dec 2023 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cPpxvJtd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E296711A
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:37:19 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id ada2fe7eead31-464a3b84ef7so483994137.1
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 08:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702571839; x=1703176639; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njevfSV6ipnODY+aF4lC9wLV+jiEMCdKQ1y9AcFdFmg=;
        b=cPpxvJtdZqordDxyVxHTXrseUGxQhSFN2nRcxKwBtdZlQFBdSX7Gi1kVHE3TzjlYtz
         aOStKDcnLryJIuPkvSdqUZEVsMvtC+ZYDxPXzi0pQqvrdpO4Sp9B0z+rCDCOGU5rjklQ
         kKByg87vvGMLQSHPLeP3L5B0K1o4ol5F4igAqQ6NT3TLdjAajCZKm8dF9cODE0wYE76U
         xyXlgRHNlLW454YcKYXPzf3rHM0iTA7ZupatLXYkIX37mQgY769t+lvWnccmzQMekVcz
         N4/JahRWZi17Tn2YR0E5k/IaIV/YKZU9VQXzoCGs1Q1l6jIf5luKx57nBL6z5HX/QMQO
         JhDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702571839; x=1703176639;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=njevfSV6ipnODY+aF4lC9wLV+jiEMCdKQ1y9AcFdFmg=;
        b=rON6npDC6CAL6FE2YeZzXpm/v5EKQuMft1HZoDTDsVrfiSAnfTuuMx7CT+XNDcLNVO
         OGMAYQTc1bHoNScWm+fjinPHhSli2LZ3UYJPi/tdj0KYqsSxn3mELGFY3o0bxacGiAub
         GnFI4D9pUM47UkB51QVPgYCrefohkc4B07rnFDPc9KVyxZxUMGcL4AXbKJAP4BS4tUbi
         U6b4/fOX5g25IPm2ekxvGQSqKeNbdO63dYxm7XKlruSR1FDXLb/Gcfg0apHebwEvXJyZ
         H7GHc4FjAfFY5g5MnCUQL1V5QRfuwqKKax6ckOKUMwI2c6wLzrtz40NGimN+6neUFRbI
         5+1g==
X-Gm-Message-State: AOJu0Yzfc6EL0UTJ9zsnIwFe8Veo2i1rowggIPN85l1aLi4owaLR43ZJ
	eyk0XeiV2409V7qSjkgUZ2JaDrUVd0Abx50KvApvGw==
X-Google-Smtp-Source: AGHT+IHv4nWpsJEesS1GOpNZJJwbyChop0SI5TUvt1nAOftw0Qz/CFqJjUGsSW4LQi+8LKUYijgWaC/DWDOOaEOEhFc=
X-Received: by 2002:a67:ef46:0:b0:465:f6c3:c3c2 with SMTP id
 k6-20020a67ef46000000b00465f6c3c3c2mr9132897vsr.18.1702571838902; Thu, 14 Dec
 2023 08:37:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214104901.1318423-1-edumazet@google.com> <20231214104901.1318423-3-edumazet@google.com>
 <657b09de9f6a6_14c73d294da@willemb.c.googlers.com.notmuch>
In-Reply-To: <657b09de9f6a6_14c73d294da@willemb.c.googlers.com.notmuch>
From: Neal Cardwell <ncardwell@google.com>
Date: Thu, 14 Dec 2023 11:37:02 -0500
Message-ID: <CADVnQynZE3XG0adXdehs_2z24MALgc_uGLMKNz7_-vDS7fAf1A@mail.gmail.com>
Subject: Re: [PATCH net-next 2/3] net: Namespace-ify sysctl_optmem_max
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, Chao Wu <wwchao@google.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 8:57=E2=80=AFAM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Eric Dumazet wrote:
> > optmem_max being used in tx zerocopy,
> > we want to be able to control it on a netns basis.
> >
> > Following patch changes two tests.
> >
> > Tested:
> >
> > oqq130:~# cat /proc/sys/net/core/optmem_max
> > 131072
> > oqq130:~# echo 1000000 >/proc/sys/net/core/optmem_max
> > oqq130:~# cat /proc/sys/net/core/optmem_max
> > 1000000
> > oqq130:~# unshare -n
> > oqq130:~# cat /proc/sys/net/core/optmem_max
> > 131072
> > oqq130:~# exit
> > logout
> > oqq130:~# cat /proc/sys/net/core/optmem_max
> > 1000000
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Acked-by: Neal Cardwell <ncardwell@google.com>
                                            client_loop: send
disconnect: Broken pipe

Thanks, Eric!

neal

