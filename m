Return-Path: <netdev+bounces-194831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEC3ACCDD5
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 21:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F083A512F
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 19:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAB221324E;
	Tue,  3 Jun 2025 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="w1Mk4zE0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F0B2F2D
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748980349; cv=none; b=tcltjQfye55uK7wUdG14k4RgDs4ox0hcUEFUtqbbA3CNzbtTqUuQ+ksRFwJOg/HdGf6cIGjXTZSK367vCycCERvskKLhEQT+gjDGeA2Nns3nG7Eyx89FMkP3ZxMvXm7V3f8WxL4lVLedJgMYjGi8mlR9cbIYIhadzm0L3zxDhfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748980349; c=relaxed/simple;
	bh=BBIQPN0gBmNraGTB7fxqolT00ky3D+w1y3Ip+IpcLVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XHIBJEQf/Fd5xVSDtfm6Ygcz2issTSCz7Q33ke+o4uH4O+EvgYYC37ANtDCjDqiP0gIyH2HKxhpe14DJnPNJCsz1eLIz0UwRWpHO0f6RTr6ubAFpX33jdoZpSTO54fUWsi6m2pP/RkWGd/6K8V7Lwpnah14aIo4AuIkQX9JuHsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=w1Mk4zE0; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2348a45fc73so50515ad.0
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 12:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748980347; x=1749585147; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2xu4Xvea4/RZ0hUeFzVrbFrDBrIPevWvQCTSFWqqcX0=;
        b=w1Mk4zE0+uiffr/ER/0KCZNV2r7yjXI5xAjrFJR88xWmTpMhlxIhwqPBmtJ31/rgSK
         3Yh/lHBy826lGq95fDioCDAxNY8F4zurykfbC3D8F4DYrcs8cZNs6mJg86qsm0m4+rv8
         HWW6fQPE/vosNFEkuGWCehg0K6HxFtotzEHMYmOTQoUPYnejWmcXBoaD8qzf9kSPKD9M
         JUx14AAPm4+mc1KROWN7mwgB98HlXcqOH6aObuHurV+5jDfNFaDQphf+mXJbAfnBMS9q
         xDVNsTa2xzewiz0ek9TOW/l0HiybBXPtNJTovFBoWze5QJT1YlW6XkxeBjM0MkRiWPL3
         JL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748980347; x=1749585147;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2xu4Xvea4/RZ0hUeFzVrbFrDBrIPevWvQCTSFWqqcX0=;
        b=nLizGXVDe4Ql7SDu9YoFr4qMFDiTfOYE12H5lHdSa00V3iNT0YHL1K6kWefQbvRcLt
         C/2FiQ2i2uiZZLpo+YwYdsWUKUZdtqAn/hHWUQOFt13p07+X0ib1ElepA4l/tSb9PrAo
         wxqk6Hv8B8bGvWSag1Iw15urspItCu+SIe9EN0tjHF6AKZ3bpXI+PGp2ujPSbXTYyY7W
         HvafINyoqbhcPN2glZu2FlFmbTiV/g0PIWaG1MFp/2I1zDsTOipKacnMGLNz4rRaWRB2
         FhQZKhrWVtUn/Rm1H/I1Q+KaRoVlL8DG8gPGcZzPB7iJhVopytTwyF/KCYxurl5OTBg9
         opAQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOzh0sVOyRRwFrOQGr4rKsx/AsbQgSySENvCTTNR6BtnS3lVU8Rs8nFa8ywtLbcVZDbLTp9DU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVX/WqJZAVmzsu8MY8a9jc2B1Gd4mwFwpt5XfHEMxApFb7hgBv
	Ln+xiJWDmLL3+zH6EdRV/iuOuRsI7MEfmEFDRZeT8JDBoQz794stBMrJOWzgmRHavBRHSJGFh1p
	qL2n+Jzn01gK7BWTiBpeJSGm5DsuTlz+72V3Fuz4i
X-Gm-Gg: ASbGnctZEL/FY4x6FlWHBt3KiQiU4/hyidkr24GLeicjW/FqU1pdjAlwBOKdYo/kHdE
	+GYK2A59UCPCR9MtF/2qKQwktiKt8vB9gfq4Sl3v8j95dtoj9QG6dRL+Z6jWwbSlzqmBSU70kS4
	IW4vUnAh3YAVZVKaBXo2E+POfwVKjtjA/oGrQw/XzRjUnTD1SIMoFw2fcDCu6gF3XjHt6TTEjkX
	nY=
X-Google-Smtp-Source: AGHT+IHFh1Py9kpL/kMi0IWMMD5q7rs8QpaLf+7z1cfp15D7ZXTSNiQeRzoMC9g90hdHog4pcjZsG9mf04UVCbESwLQ=
X-Received: by 2002:a17:903:8c5:b0:234:b2bf:e67e with SMTP id
 d9443c01a7336-235dfca5073mr464645ad.13.1748980346684; Tue, 03 Jun 2025
 12:52:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250601195223.3388860-1-alok.a.tiwari@oracle.com> <3fc6e01d-64d5-496d-8be6-d449b7e65182@redhat.com>
In-Reply-To: <3fc6e01d-64d5-496d-8be6-d449b7e65182@redhat.com>
From: Harshitha Ramamurthy <hramamurthy@google.com>
Date: Tue, 3 Jun 2025 12:52:15 -0700
X-Gm-Features: AX0GCFuPVPl0aw_huyRHCSDstJeazFKT_oJd0NgBZXiZ9HxLKXDaOH0GPYOs8IY
Message-ID: <CAEAWyHenoS_JBXPzX3cRCZMsT63CxTCn9NTQPD2SMM=TWFc3QA@mail.gmail.com>
Subject: Re: [QUERY] gve: gve_tx_free_rings_dqo() uses num_xdp_queues instead
 of num_xdp_rings
To: Paolo Abeni <pabeni@redhat.com>
Cc: Alok Tiwari <alok.a.tiwari@oracle.com>, almasrymina@google.com, bcf@google.com, 
	joshwash@google.com, willemb@google.com, pkaligineedi@google.com, 
	kuba@kernel.org, jeroendb@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 3, 2025 at 3:34=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 6/1/25 9:52 PM, Alok Tiwari wrote:
> >  drivers/net/ethernet/google/gve/gve_tx_dqo.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_tx_dqo.c b/drivers/net=
/ethernet/google/gve/gve_tx_dqo.c
> > index 9d705d94b065..e7ee4fa7089c 100644
> > --- a/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> > +++ b/drivers/net/ethernet/google/gve/gve_tx_dqo.c
> > @@ -424,7 +424,7 @@ void gve_tx_free_rings_dqo(struct gve_priv *priv,
> >       if (!tx)
> >               return;
> >
> > -     for (i =3D 0; i < cfg->qcfg->num_queues + cfg->qcfg->num_xdp_queu=
es; i++)
> > +     for (i =3D 0; i < cfg->qcfg->num_queues + cfg->qcfg->num_xdp_ring=
s; i++)
>
> Please note that num_xdp_rings has been moved elsewhere by commit
> 346fb86ddd86 ("gve: update XDP allocation path support RX buffer posting"=
)
>
> /P

Hi Alok,

It's appropriate for the free methods to free based on cfg->qcfg
parameters since struct gve_tx_queue_config is supposed to track
'allowed and current' tx queue parameters as documented.

Also, like Paolo has pointed out, cfg->qcfg->num_xdp_rings does not
exist. 'cfg->num_xdp_rings' does exist but should not be used to free
since during gve_adjust_config(), this field tracks what has to be
allocated in the future, not what is current.
cfg->qcfg->num_xdp_queues is the correct parameter that tracks what is
currently in use and should be used in the free methods.

Thanks,
Harshitha

>

