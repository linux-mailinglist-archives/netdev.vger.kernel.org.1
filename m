Return-Path: <netdev+bounces-233680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E80C17461
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2E74E1350
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1522D7814;
	Tue, 28 Oct 2025 23:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzMEfiPX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E959019DF62
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761692909; cv=none; b=sicc931y8iNhi+aqwJTjiobUFWOU2q1Due962biQ/6g7DA5EmnM3VEV41S6Tzg9VcumMSl81kCZuQYyR1TOUhzh3tgYfmubsO6tpWh2ebe82Uyh9GDxZ6HszZn5BQPUKDAnf9j9d95yz4e2hPqVPnm8rztwPudyNxbOrjNqRiO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761692909; c=relaxed/simple;
	bh=ExOwdKc3mwlfni+83kaKjg4+zrSy5vAKgoJbQ3Mn2Uk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bp2xa6p10nFcuAfxoYP1ZB47sa7qwRUUHJT24sghbUQSYrCrZ+TWEu495HEyvVamfK/tatSwKcJIfV3yFtLBY+Gr+bEfS+B/PawNlBEuzB8IrvzW/kwShb0UcYwpDRynfQZj9C0ycWvIklCjajzEZSuueSPVSwNzk7auMAAVNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzMEfiPX; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3ee64bc6b85so6621094f8f.3
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 16:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761692906; x=1762297706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esh31/9odKTMlTJcLS37RV/UNmgVpgrZ6tdIKS+IUA0=;
        b=WzMEfiPXc8P80agRGDxfvPXHUv4Z15iTgX1d51ui7gHuY6yVrn/83GLqxDA3w4KFe/
         21gy+wsAnPlVW68gsPgVKpXzPS5PO0nuILlKm5GMvEEf3myryPzx6acSbhCpSBPkKAxj
         bfp92SEA8fDr1LeKL/6I4GT9/VNTTZHqzVEEL01IgKuLx7aE9VBe3FIF9yQm+bUvJcbL
         VUzjlQhhxkId9GcmoF6GNHJ0+hxrLuRlMTxLNSD2dBbj7429Wba2UMWg0Tu2sU8XBaw4
         v3i+N3u7l9XdqLXahCA8L0o/Uf87XPm4ssboL3XVNThv/Lofmih9FKJ4wbiY/xMxsPxz
         A74w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761692906; x=1762297706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=esh31/9odKTMlTJcLS37RV/UNmgVpgrZ6tdIKS+IUA0=;
        b=C4I6ZidwAdDZaTk0u6sFZOWF6AIB++3qWRcRF7OzbkwD5cffK189fxfl1cgWdM8sRT
         5drNkzzqvk4wYK2/RbeKvdR05Ly/EAsOig+MmZFcgRLOXW6KBZghOz7AKcFErv8gFGaN
         ZaX2TAQC4+9/YpdoNEQPx03ocwVToBOe19GaPDQoVK9CGGGdENQCau+7tHQmZm4Ial6r
         4tjFzZERVK9kzW+9PUvl0YWx7C+L5kRWfksvgXJNq2UMVQ+Oq/ZqgpiEL5R7YLMpyRL+
         w6SdCna1DwwnxDHED0V09U+lExcrgNIT5a4KtCE0aDu0LCEgOH5YPU9OuRq1BgTgP7nh
         1V3g==
X-Gm-Message-State: AOJu0YyvMTFcb6laPHzKUnxclEnGHwf6hXwus87yXdhWEMlztdjN9ebB
	GYSykr+oUe7cpX2L3gVsHqlGLwu39/WLNDeektukeer/QpGiPuxsmC2a1vYPXbQvhATh0pYoim8
	s5JqM9xuqkGAKyZwSpjEKZs7oZLLZ5LE=
X-Gm-Gg: ASbGncvgntkyLeI5Ck7AP/HYhmJ/kyb6fg4h9bgEL9Y4vCjpJahIi58ElHFZp9XzQtW
	ibouWEU2/7J33VDnxpO7Pl6qrIoiX7b9WwJoyQ32A+EpVmkY2620s/UvYGj5cZPo28I5/IU2cWB
	9m5tqE7GamqWmmx5LDpDmPytFiRzxZu9hoAcHPDBd1pIFuSgBEWCKzXNLc2JrnOj3bi/8luCTTT
	ldu4IpihKYIn4X1gwR4x8kjMAaVuKHbSI0tlUmWM7MQ7Fiw/fNb4s3Db3bOTcEjZ00vt7EN3pIR
	t4T93sYIoBRco523sg==
X-Google-Smtp-Source: AGHT+IGCKnCnml/Ibn1Rk34FZ597YrQMoaeFwgU8sG35OhWOPoXsbHksfxu8jdjv8vCWczYzAZGVpSFhbVzpOnPrtSg=
X-Received: by 2002:a5d:584d:0:b0:426:fb28:7962 with SMTP id
 ffacd0b85a97d-429aefccf52mr505018f8f.61.1761692906183; Tue, 28 Oct 2025
 16:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <176133835222.2245037.11430728108477849570.stgit@ahduyck-xeon-server.home.arpa>
 <176133848870.2245037.4413688703874426341.stgit@ahduyck-xeon-server.home.arpa>
 <6ca8f12d-9413-400d-bfc4-9a6c4a2d8896@lunn.ch> <CAKgT0UdqH0swVcQFypY8tbDpL58ZDNLpkmQMPNzQep1=eb1hQQ@mail.gmail.com>
 <fa8c2fe1-23a3-4fd0-94a7-50446631c287@lunn.ch>
In-Reply-To: <fa8c2fe1-23a3-4fd0-94a7-50446631c287@lunn.ch>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 28 Oct 2025 16:07:50 -0700
X-Gm-Features: AWmQ_bkKLhkVKMVdgH0a1qLjWFrAPvfKOGhJTUCUCVaUqtx4RK6toLgEq--nY2Q
Message-ID: <CAKgT0Uf6my+3EsaJdNZi-m7EGYo0izvO_TmfVbX_5taEkw-MCg@mail.gmail.com>
Subject: Re: [net-next PATCH 8/8] fbnic: Add phydev representing PMD to
 phylink setup
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, kuba@kernel.org, kernel-team@meta.com, 
	andrew+netdev@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	pabeni@redhat.com, davem@davemloft.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 28, 2025 at 3:56=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > > > +     phylink_resume(fbn->phylink);
> > >
> > > When was is suspended?
> >
> > We don't use the start/stop calls. Instead we use the resume/suspend
> > calls in order to deal with the fact that we normally aren't fully
> > resetting the link. The first call automatically gets converted to a
> > phylink_start because the bit isn't set for the MAC_WOL, however all
> > subsequent setups it becomes a resume so that we aren't tearing the
> > link down fully in order to avoid blocking the BMC which is sharing
> > the link similar to how a WOL connection would.
>
> /**
>  * phylink_resume() - handle a network device resume event
>  * @pl: a pointer to a &struct phylink returned from phylink_create()
>  *
>  * Undo the effects of phylink_suspend(), returning the link to an
>  * operational state.
>  */
>
> There needs to be a call to phylink_suspend() before you call
> phylink_resume(). If there is a prior call to phylink_suspend() all is
> O.K.
>
> Russell gets unhappy if you don't follow the documentation. The
> documentation is part of the API, part of the contract. If you break
> the contract, don't be surprised is your driver breaks sometime in the
> future.

We have had some back and forth in the past about it. Basically we
need to work through and come up with a better way of handling the BMC
portion of this. As it stands there are still some side effects but it
can't really be helped as the resume logic will force the MAC down
briefly.

I am still also using wol_enabled and haven't come up with a good
alternative yet to say that a BMC is present on the link.

