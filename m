Return-Path: <netdev+bounces-165963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A4BA33CF2
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C2416962C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF220E717;
	Thu, 13 Feb 2025 10:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzzpDagJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B9190477
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443762; cv=none; b=sW3uCh1QGkgp3F3kqbYq2fMoP3DfRV7RaB2ra4xe8fgFxhIcTJG9OxESibyss/WTur1KgfL4NfMHyrlejdEOpf8j4u4GQW6WYrAhZbjeWnjjuhLCW7A0R5GYWcwq0+WwPmjkT8uQ+v/gj4PPIjNX5lcHhhw+OTwU3Il8buFDhQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443762; c=relaxed/simple;
	bh=fniy0gSpta8uFDhYaUh3n8EiToC9KfmQTepX/voxJsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rBeRL7+Cs+F/h97/47LIVnlHUBGxrcXXpQggxLtzuALvEXY6XkLztXlYwgo+aP9i0r2uoA7pRHM6EjAMc7Qc567tHEapRcQzmgiKf1EbJj+bmzmxAMItcHZWdCfQQYPTHA7NeXwhMpZQ8SKhL5u1GASqJb2duOy5Ki2lVrHaDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QzzpDagJ; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3cfeff44d94so2210795ab.0
        for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 02:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739443759; x=1740048559; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udkZpp0hNqYiNrq0Nf13yAi6zz4/hgOh8hNsAzh7hww=;
        b=QzzpDagJ5vBRl+V3wCdFNGHrKEpDImTMaVvQJuLkRGSu3DzxD+i8d0i+np2RdbnV0/
         4cFgSnjYJWNDIuEnbiODj2oH5PEXfX6VL3MKlpOhWIIy7F3+gefqWZ8EfBXICfKrKdf3
         4c6ANAGIal0cLq78cxCeolWxuYaT8nWxXJM4tMXOHGfSd7X3GWoJmEnKul5WJCVpZxDx
         EksuGBo4LmzlseWKo+9nmN2iaBpSIpFyONJKZJnAG/eZEZTN6f88T+F6rKi7n1ZEMdqU
         LBqYV7oahSA3btDWR6i+naLuMijuDNfZlapJ8EXU4rfsO6g5x/TecuKKin777PgCqIni
         opaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739443759; x=1740048559;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udkZpp0hNqYiNrq0Nf13yAi6zz4/hgOh8hNsAzh7hww=;
        b=kjoyTHNepZmVAR/6ai3cD9W+wXQ2cJMOyQJSix0+7Txvdj5D22aNcxzwtSVjCAw4at
         v9QrgeoEAWsygoBahUPf/gRg87BG13Ubjmyd3+mcg/znpEZL/XD2EpH13AwDIYubSVu9
         y4Rbw1Uwkf+TMgKfgPGo8+bzP8wrznkUYVat4PWL3iHLGaZ0n/Em7YxPFe4jSjKrTcpl
         QSyjJYIL728eSf/uq1JSuWcdJ/IVIju0mciaCrcKuUn5OvdHe6BFcPK4wi0/vIF8MuxG
         65muaNJ/JsiRcSV1VK8Srw+5qV50EU9KKTAJ1n1UyoJWYUJZSeBL6h7uDBiET0kEw9f9
         yirQ==
X-Gm-Message-State: AOJu0YyTI7CgnyWBGJdt8taWBjIRMwUY605Ll92Wt8OJGQOyH9SPpaaX
	EcOTl4SZKJ6PhxE5azmFlKkkD6oukhkoKybmgNxrx6bds0bDkDphfjP6+cl2Wh3mV/pd99PNrdw
	GDhs1hUMiKY/g7yEYKHAzZZqmcPc=
X-Gm-Gg: ASbGncuyIkiaDxpOfh9iFO5oh8ZOt1dpL6/5B01isJOtC2oqbOY4SkF8HirtJBG2oRb
	Tvd+nEEHz/CVG+VReO4fZz9nypmuH2eclTFImQ4aDWECwlBbQJfaMqbzw3rY8DGc7yRw3xS0J
X-Google-Smtp-Source: AGHT+IESZYfsOuR0P0dvH6R8sqMZ/5QVBH6pgrJ9RqtdY+64IYQ6RlEGEhc/d24yDLy1Q53v1Bgx3ZMiVwemj2dJINs=
X-Received: by 2002:a05:6e02:2168:b0:3d0:255e:fdc with SMTP id
 e9e14a558f8ab-3d17bfde1f2mr65596455ab.15.1739443759123; Thu, 13 Feb 2025
 02:49:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213052150.18392-1-kerneljasonxing@gmail.com> <94376281-1922-40ee-bfd6-80ff88b9eed7@redhat.com>
In-Reply-To: <94376281-1922-40ee-bfd6-80ff88b9eed7@redhat.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 13 Feb 2025 18:48:42 +0800
X-Gm-Features: AWEUYZlAqRBe6AutibjGK-7FCQKNDKvLtcw8V-5_ZddPYageClaDNHD7J57jYkg
Message-ID: <CAL+tcoC6r=ow4nfjDvv6tDEKgPVOf-c3aHD56_AXmqUrQMyCMg@mail.gmail.com>
Subject: Re: [PATCH v2 net-next] page_pool: avoid infinite loop to schedule
 delayed worker
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, ilias.apalodimas@linaro.org, 
	edumazet@google.com, kuba@kernel.org, horms@kernel.org, hawk@kernel.org, 
	almasrymina@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 4:32=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On 2/13/25 6:21 AM, Jason Xing wrote:
> > diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> > index 1c6fec08bc43..e1f89a19a6b6 100644
> > --- a/net/core/page_pool.c
> > +++ b/net/core/page_pool.c
> > @@ -1112,13 +1112,12 @@ static void page_pool_release_retry(struct work=
_struct *wq)
> >       int inflight;
> >
> >       inflight =3D page_pool_release(pool);
> > -     if (!inflight)
> > -             return;
> >
> >       /* Periodic warning for page pools the user can't see */
> >       netdev =3D READ_ONCE(pool->slow.netdev);
>
> This causes UaF, as catched by the CI:
>
> https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/990441/34-udpgro-b=
ench-sh/stderr
>
> at this point 'inflight' could be 0 and 'pool' already freed.

Oh, right, thanks for catching that.

I'm going to use the previous approach (one-liner with a few comments):
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1c6fec08bc43..209b5028abd7 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -1112,7 +1112,13 @@ static void page_pool_release_retry(struct
work_struct *wq)
        int inflight;

        inflight =3D page_pool_release(pool);
-       if (!inflight)
+       /* In rare cases, a driver bug may cause inflight to go negative.
+        * Don't reschedule release if inflight is 0 or negative.
+        * - If 0, the page_pool has been destroyed
+        * - if negative, we will never recover
+        *   in both cases no reschedule is necessary.
+        */
+       if (inflight <=3D 0)
                return;

Thanks,
Jason

