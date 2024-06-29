Return-Path: <netdev+bounces-107905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 003DD91CE70
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 19:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C921F21D34
	for <lists+netdev@lfdr.de>; Sat, 29 Jun 2024 17:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6890D12FF86;
	Sat, 29 Jun 2024 17:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nOCeGXjS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908421E4AF
	for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 17:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719683802; cv=none; b=fOsZjaQ/BdPO1C3LZ//iu5kYWEqB9EsWVyIoeRSIgYhuH9K1qno6NBXkJTIzNdp7fk9RTlSRkKAt+8+0rdeFrtIK4P5MBYJrSOWKmQL5DVUUClboRfjmh/x8N79BgHJBuIk/wNn1mpMyRoJw9F+9W9IHGjtS7mPZeURyRXjT0fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719683802; c=relaxed/simple;
	bh=ZOHwuvsXQ6IecSL1eeVt0k69uFaXHhtC4yimAo7Y+F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WXO2IcvqsK7F91P1tmE729AD7W8IUFEJsPpP+OZ/Hw0XA2un+U5cfTA/N0ojoNeqabW/qMLaCZWDDNXHcoh6bqEaMd6QH29jptDNnR5zVjV2xfEwF47LTqq3pEPv7wUYnZ3+Nfv4FvcdYjIcQgBDEx2McDQIJITlckLEz7h96UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nOCeGXjS; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52cd717ec07so2058359e87.0
        for <netdev@vger.kernel.org>; Sat, 29 Jun 2024 10:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719683799; x=1720288599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jilKPrDVzoZgv2NzOfscMz8grOc1TduetD4V2qLBOFc=;
        b=nOCeGXjSFPLrMf9P9z+vYNOyTsrXBEq7fCBGmoaepHOZbuVeIwwTnksSecKX+trrAa
         aqZZElzfI8y0QDLbIXvx3HwsQ/PeLyJk1vRMKC3bl+5kM5s8eQUVnH4UYitCigjDdsba
         ZIDnQ4Kbij36ZamUMxKFfBI3XZUVeciavIRwKvBm4dDpHeeZyt6/oEK3DBqe8UoGniyo
         HKZ0z2PquscLJVJoynmMN3D3VqqTpatJ+2RUuMaVYPl6J6lKJtSJg6q7mBQsjXEADFnB
         cFAnE/8xTKNv2Kb153z2jDGI1nUIfWflk3r9dGNnr9XoEn5dHdIW5D3P0WimaIPB1Hw7
         N+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719683799; x=1720288599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jilKPrDVzoZgv2NzOfscMz8grOc1TduetD4V2qLBOFc=;
        b=ZKwDtQgtH6FIKR2ORIhvDU7rQzdFJqHlySth7N53y7Z9gwJ7zaSD/ekZjpy1rdoIHx
         zfevNnOF1JxtFmHq0mkzQpI4WMHOVvzi+lz8lPsJG2H+1Z/iywFsM9S8BXJVUfXLrJRZ
         CnYcFK8ch7slcqu5C8XY8M+c6vUj9WMbWriYQ48B2zr42DXQyCrgNtB0+f221ELOB+/z
         0vDwFKERaLqqJPC9Nm1fK5U5wzb4PXf+BGQqbyOFOIp6wSuJ7mIAfqBp7VsVi3iPsdqr
         zcAm04k7RKZ+XeMkYUlK3pSVtmc0gJ4ST6tSxNBNNW7UQSwDoMyMPAUzAFWL2kRjiVdI
         /grA==
X-Gm-Message-State: AOJu0YzNaqNFh1oT/BImaJZy3A1ZAPaJypJz85U5xf0jUHkFMJ/cAO7f
	+3wHZIFC5Op4zh+NE+0wKgBzuz/2S6ii3N3jW87GGdbwa+0lpPLapnJEW7E2yOHD5JifFVaS5Rz
	KSDYE0/GdWcMu41PHFxApK0528b7oL9ui0HzV
X-Google-Smtp-Source: AGHT+IGVySmblyxgPd44QBgx/PKNc0hV6M77n5jilQw+/7NpFTAKrval08hCP8D+UysMOGM5VHKpbPxWA0W19kasfLc=
X-Received: by 2002:ac2:4e0a:0:b0:52c:df86:68c6 with SMTP id
 2adb3069b0e04-52e826787cbmr1416586e87.16.1719683798417; Sat, 29 Jun 2024
 10:56:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628204139.458075-1-rushilg@google.com> <20240628180206.07c0a1b2@kernel.org>
In-Reply-To: <20240628180206.07c0a1b2@kernel.org>
From: Rushil Gupta <rushilg@google.com>
Date: Sat, 29 Jun 2024 10:56:27 -0700
Message-ID: <CANzqiF7TQW2yUM14XS68CxM35yJpq8DCRJRonMcyfTpfatBtMQ@mail.gmail.com>
Subject: Re: [PATCH net-next] gve: Add retry logic for recoverable adminq errors
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jeroendb@google.com, pkaligineedi@google.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	willemb@google.com, hramamurthy@google.com, 
	Shailend Chand <shailend@google.com>, Ziwei Xiao <ziweixiao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 28, 2024 at 6:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 28 Jun 2024 20:41:39 +0000 Rushil Gupta wrote:
> > An adminq command is retried if it fails with an ETIME error code
> > which translates to the deadline exceeded error for the device.
> > The create and destroy adminq commands are now managed via a common
> > method. This method keeps track of return codes for each queue and retr=
ies
> > the commands for the queues that failed with ETIME.
> > Other adminq commands that do not require queue level granularity are
> > simply retried in gve_adminq_execute_cmd.
> >
> > Signed-off-by: Rushil Gupta <rushilg@google.com>
> > Signed-off-by: Jeroen de Borst <jeroendb@google.com>
> > Reviewed-by: Shailend Chand <shailend@google.com>
> > Reviewed-by: Ziwei Xiao <ziweixiao@google.com>
>
> I told you once already that you're not allowed to repost patches
> within 24h. You should also include a change long when you repost.
I am sorry about the email mix-up. I will be careful about that in the futu=
re.
>
> Since Jeroen is a maintainer of this driver, and you are not listed
> in the MAINTAINERS file I don't understand why you're the one sending
> this. We can't teach everyone at google the upstream process one by
> one so I'd like to request that only the listed maintainers post pure
> GVE patches (or the folks who are heavily involved upstream).
I could not find one single documentation that says only listed
maintainers can post pure patches.
Authors of some of the recently accepted patches were in fact not in
the MAINTAINERS file.
I am sending this patch as I was involved in getting this code to the
upstream-ready state and testing it internally.
However, if other GVE maintainers wish to follow this rule; I am ok
with your suggestion.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net=
/ethernet/google/gve/gve_adminq.c
> > index c5bbc1b7524e..74c61b90ea45 100644
> > --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> > +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> > @@ -12,7 +12,7 @@
> >
> >  #define GVE_MAX_ADMINQ_RELEASE_CHECK 500
> >  #define GVE_ADMINQ_SLEEP_LEN         20
> > -#define GVE_MAX_ADMINQ_EVENT_COUNTER_CHECK   100
> > +#define GVE_MAX_ADMINQ_EVENT_COUNTER_CHECK   1000
> >
> >  #define GVE_DEVICE_OPTION_ERROR_FMT "%s option error:\n" \
> >  "Expected: length=3D%d, feature_mask=3D%x.\n" \
> > @@ -415,14 +415,17 @@ static int gve_adminq_parse_err(struct gve_priv *=
priv, u32 status)
> >  /* Flushes all AQ commands currently queued and waits for them to comp=
lete.
> >   * If there are failures, it will return the first error.
> >   */
> > -static int gve_adminq_kick_and_wait(struct gve_priv *priv)
> > +static int gve_adminq_kick_and_wait(struct gve_priv *priv, int ret_cnt=
, int *ret_codes)
> >  {
> >       int tail, head;
> > -     int i;
> > +     int i, j;
> >
> >       tail =3D ioread32be(&priv->reg_bar0->adminq_event_counter);
> >       head =3D priv->adminq_prod_cnt;
> >
> > +     if ((head - tail) > ret_cnt)
>
> please delete all the pointless parenthesis in + lines of this patch.
> --
> pw-bot: cr

