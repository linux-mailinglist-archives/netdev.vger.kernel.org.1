Return-Path: <netdev+bounces-228053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75A6FBBFEF2
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 03:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711D03C4B7A
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 01:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A72F1B87EB;
	Tue,  7 Oct 2025 01:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxBotesK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3041DE3B7
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759800178; cv=none; b=uWS0WPpEGC7MzibZdmAdZPf85cyjusEWXpqYUQqwb8jdFn/fCFtTzarYEHGxcv6CXepzXEOtKQcD5Ol0OZOoOpT0mjXicgLNCV/YPbaMTqTo6XafQG4SdoV3hJrKX6qU7lERgybnibBlks8hL8TI3VVnxV1lPg4QsbYWXpxTyuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759800178; c=relaxed/simple;
	bh=00hx5O89+8fvzy4PkP6xQKJCZLvcQoPJKp5vdlCLTCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=riEA9Kb/LPqRc3WmryLeE7y+aHxgEGLdYxBLhITeq7F1wjyzcFzbYeILIVImILGY7Zt4IMIQ0IotmQ+XlnVFSNAe7dekevq2SQJ3VIMsRhOqNkymrGUsOnJNGmknpDRUo+W+MpjKRfh/EB44GyaZBsQcN5qI1fD36G47GHLJNUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxBotesK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-63963066fb0so6719794a12.3
        for <netdev@vger.kernel.org>; Mon, 06 Oct 2025 18:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759800175; x=1760404975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t47vpiwRUGgVZgrjR0ubmEzxDtialDVYBK5r+ezzR+E=;
        b=cxBotesKVT0kItaCi+pL79Rrdy7oHT/uuYEDZPxBFct+abfWG5d4HATokKErrW6Dov
         8LWvTC2r6AiCf/12ib4PyDnFYyo1rbz31IcEhzWeCLYpaSKEUVFq4CrOvMZcYr4gwbPH
         Rch5xtKR2oqwJ17lxy9L6RGmoGAb8ObcoCauAwoIW0IpqpzUe2Sni6rQnGMGgWvZ15tO
         FKv6HB/L4snlgopisxw6TsUTVEv4ItS6cxhYcXh7/Eh02tMMmtELMrwrTFJ4VNZmnNIH
         +w65691ilDaIiDGbzVQ0QX2hw5fXhO4qN25lkV5AUkqGod9x0m6/typnjfSkVxjdx92m
         rawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759800175; x=1760404975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t47vpiwRUGgVZgrjR0ubmEzxDtialDVYBK5r+ezzR+E=;
        b=upO6X2XIBfvim0F+PJ1ScAK7MbhUfkPm5xx/4TG3Thg9fuFEUq1OzJO5KbFgBZ6Ice
         Y5aHcv5DgYoNk7WsD4UXgg9DrTLlR0VepHlDNAmouDMdf0zOg9UNeWR53FXiQ5Vrv1e3
         xVjZW+/SZ7KNXb9PcFqJhEVhXUeembtH0qPsjBaNLjwAMtFbR3tYZkYw0FZx1HhQq1J7
         uHxxPOoaHuh/3n7cYrOhLNm7Z6P2btfwRzmKBj/5ael7M3Qc9UcL4psxFnGf/CkCumUC
         91OipwtHC6Hq+Q2jxI5CAGsK3JvFTm30T7AscJCs2WUdFfXlPPitWTm6vYJ/JCy6qemg
         d6Ww==
X-Forwarded-Encrypted: i=1; AJvYcCXr+JLc8vaoZ608nT1H2pcaZHdcpyzVm61iz82VVhmz6WNevJ2egQXS3L2qcRF+1JQX6F1rdwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQJObM1911mrz3R8SRFivl0ELPPPIIwBbYMb+A0m/Vg/5cinHK
	xN+F0h8J7G4uZYaC1P/eWe3FQE7cFIz7GBQI3rRONhOAJN9q5YxTyIWmjiXPVjSSIZelxfiVg9R
	OMfrUsUMTgI+JFGM2uh4JC+vPPf/nzCo=
X-Gm-Gg: ASbGncvz+J/ZvUeT7IzJWcZ03HRWQJQ8Y+lGk5HdDqsRFD0h03z/RIpbKSQWWzYZqoK
	BhMVpAVyV22zGP4/CVjsUuSPf+ESbbrLPWvc/fxgzypWXHO3S68DSOQD+izdTk6hSsjmWaJPDpA
	U+BnVbBy2fmRdZNDpeZeG65QSPd8EO2AE5JADU3NEZk0jCUAMLIydLVxfmuf1BSIha0X/fiYUnv
	rr/aqbiVZJXayjPgReQbA6wjw5GPaAED/OmZEZpqqW6jFTOtT4Z3BvjCOqnwg==
X-Google-Smtp-Source: AGHT+IEqVioe1S+GxtMPUCva4kG5CmfdDTTGDPNdiniLUblABnKsGagheixLUyeC/Xqdz84Zg3zCalpzx4OwzsmlUYQ=
X-Received: by 2002:a05:6402:b0a:b0:638:d495:50a7 with SMTP id
 4fb4d7f45d1cf-639348fa973mr13226165a12.16.1759800175262; Mon, 06 Oct 2025
 18:22:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251003043140.1341958-1-alistair.francis@wdc.com>
 <20251003043140.1341958-4-alistair.francis@wdc.com> <05d7ba0e-fe39-4f86-9e46-7ba95fccdce9@suse.de>
In-Reply-To: <05d7ba0e-fe39-4f86-9e46-7ba95fccdce9@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 7 Oct 2025 11:22:29 +1000
X-Gm-Features: AS18NWA3ErD_gS2cWuFH4B1EU9R8Gp49Hxw1eP3L2D2MX2i73c7hEabcslLmzvQ
Message-ID: <CAKmqyKMRXKJTQciiqjPXYAFa6UUJ6xkTSdEfU+9HnyNTOx-BxA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] net/handshake: Ensure the request is destructed on completion
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 4:16=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrote=
:
>
> On 10/3/25 06:31, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > To avoid future handshake_req_hash_add() calls failing with EEXIST when
> > performing a KeyUpdate let's make sure the old request is destructed
> > as part of the completion.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > v3:
> >   - New patch
> >
> >   net/handshake/request.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/net/handshake/request.c b/net/handshake/request.c
> > index 0d1c91c80478..194725a8aaca 100644
> > --- a/net/handshake/request.c
> > +++ b/net/handshake/request.c
> > @@ -311,6 +311,8 @@ void handshake_complete(struct handshake_req *req, =
unsigned int status,
> >               /* Handshake request is no longer pending */
> >               sock_put(sk);
> >       }
> > +
> > +     handshake_sk_destruct_req(sk);
> >   }
> >   EXPORT_SYMBOL_IF_KUNIT(handshake_complete);
> >
> Curious.
> Why do we need it now? We had been happily using the handshake mechanism
> for quite some time now, so who had been destroying the request without
> this patch?

Until now a handshake would only be destroyed on a failure or when a
sock is freed (via the sk_destruct function pointer).
handshake_complete() is only called on errors, not a successful
handshake so it doesn't remove the request.

Note that destroying is mostly just removing the entry from the hash
table with rhashtable_remove_fast(). Which is what we need to be able
to submit it again.

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

