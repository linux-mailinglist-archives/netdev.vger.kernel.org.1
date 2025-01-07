Return-Path: <netdev+bounces-155888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A694A04357
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 15:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22C1D163A70
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A8B1F0E2A;
	Tue,  7 Jan 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kU3/lptp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6D1F1922;
	Tue,  7 Jan 2025 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736261558; cv=none; b=Zt2vK1HzdS3bzKcOCTU4S18sgerQHgP26Hacoop2kBt6XxbMVdHJvFAIfEuhcx1FXps1KUJ0mgDZ1p4WKcmVKIqEnrn18Hf43DK8lt0rHtkaes67XiD8DLbufJEu2zVQ2mpbz+mEyuHBmQoyciFVTLMcGIXa04vaD7E9f6YGeEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736261558; c=relaxed/simple;
	bh=MOH868ngW9dUOwN4thFNX1TPcOFJP2qf8DZugGyoX8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BdpK0Ax56ueHgCmqJuPEGmrvu4lD4i29jhwVizQ5FBQgBia+iUVs8HurMxMMwV/qVHyWtk7KAD76U5Ivrtwz31B4ju96NQ/glsW5BSMelFFyfceDEz/2nGiaPAsy+QM8OgXrMFqEFnP1FongVPX7rZaIpuKCLXUh/2fN7a2c9EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kU3/lptp; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so2264526366b.0;
        Tue, 07 Jan 2025 06:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736261555; x=1736866355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy9mDmEp3duyQlRFahCU21spYZivWlH+YgZaad61gT0=;
        b=kU3/lptpCfQs5ohBFmomLBRl6kMYTJ24fbXdic9GAxa6oorF7llMAMXhDEt2FL/Rt6
         /0d41whm9KhpRPQx8Uaiiw12Ptdmv/TJJ4EJItOe4O4QC7Rbv5SEGJbmkZJwzjVIG38o
         1+3LMYXVZ6KY5zix+cfcv9bndlNlus2Pe4ZJLhWWIW25awz+LG3zdqV3ZUyXx0VIVdoT
         M9pUT6YvUsIJ9lReY9X9IhLTJMzGgBg2P8bVuO03f1L6o5R/upx4LSw+kPPdoBGX4xTe
         puoqT2SKAVsLtPmL6KBPlWXj6NTTIUA40o8+p5JbdJycAi4p5uCogJaNC4/VSHSUSnWJ
         RQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736261555; x=1736866355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy9mDmEp3duyQlRFahCU21spYZivWlH+YgZaad61gT0=;
        b=fjjk87hcpBsKU65nvlk5yDrXKDy/Oh/1yVY1Ikr1Xuc66SrbebDlYYpjHSROKkXK9H
         6IrCAVogLdlmCXnwvjGCpBApT1pFd/qtzC+wFixWkz0O0EKsrY7nLGqLLYHOV3alI1G2
         7tGx8YADaw3eL4zXn6JDvv10cJR8JvtJT8lkRHsZUBNVAVKF+5vA+Ete7y4jTmCY1HE2
         zmCxh150ZyJN4aM8eEWvdF0bUCVlPz+Ai1goGEnijZIWPJgjnlY3nV6o+KkbmyR6+BqZ
         ojOua858dDz554+BSjDu0GJNDIjm/e/o6fBKzig5MUATggtUdx3plDFazTOnjryNQrUq
         ntmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIIG6Q/xIFGO47jbQ0MMgxRwWyjJjSPL9SwGVVBiE7pkuI5+SzTo58qPY+JpaoJfBLy7fHVvjX@vger.kernel.org, AJvYcCUmcYIehdG2HJlff6oEW3mFULirQI9lf4PjDh2TH+GxKY1b3tozvVkhP78gd3jEZtKIY0f9tcFyTN4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm8Y4MUb04hvoPjTo4KFtFa6Jt5SnxJEgEHyUzMZ8zJagFjCSV
	wU9ujgMd8JK+s/PssYJ/5GXgvUvorNNcAlV4sbq6j6u4UHZazdoit7S2kaNW0yweKegc1NS2eSy
	Pon0AjanFQ5R6/Qr1JUWPg7uaEEo=
X-Gm-Gg: ASbGncsDphxnRGaH9E1wKedMnQe4IzVaOyDUcXOSxz4UoZyqecwULfCxq7qATD3PeGv
	GDYUwjIcr/Uw3nZGzr2qNlt9lMmosovXF2BBLzdk=
X-Google-Smtp-Source: AGHT+IFr4AsIDZ/804Oq5/41YNjTqilp4vsNEac0k/8HSVxc03qpEYsbHpINeUQ1HRthjeTyKuJxDj81+FPOXYB8j+o=
X-Received: by 2002:a50:cc48:0:b0:5d3:cf89:bd3e with SMTP id
 4fb4d7f45d1cf-5d81de1c92cmr120964554a12.30.1736261554968; Tue, 07 Jan 2025
 06:52:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250103150325.926031-1-ap420073@gmail.com> <20250103150325.926031-3-ap420073@gmail.com>
 <20250106184854.4028c83d@kernel.org> <20250106190456.104e313e@kernel.org>
In-Reply-To: <20250106190456.104e313e@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Tue, 7 Jan 2025 23:52:23 +0900
Message-ID: <CAMArcTUZA=Ox5VgSG1+PqErrLwqXkiT1JOY7gzuXBUOJw_2HKA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 02/10] net: ethtool: add support for
 configuring hds-thresh
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	almasrymina@google.com, donald.hunter@gmail.com, corbet@lwn.net, 
	michael.chan@broadcom.com, andrew+netdev@lunn.ch, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, dw@davidwei.uk, sdf@fomichev.me, 
	asml.silence@gmail.com, brett.creeley@amd.com, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, kory.maincent@bootlin.com, 
	maxime.chevallier@bootlin.com, danieller@nvidia.com, hengqi@linux.alibaba.com, 
	ecree.xilinx@gmail.com, przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, 
	ahmed.zaki@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com, 
	jiri@resnulli.us, bigeasy@linutronix.de, lorenzo@kernel.org, 
	jdamato@fastly.com, aleksander.lobakin@intel.com, kaiyuanz@google.com, 
	willemb@google.com, daniel.zahka@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 7, 2025 at 12:04=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>

Hi Jakub,
Thanks a lot for the review!

> On Mon, 6 Jan 2025 18:48:54 -0800 Jakub Kicinski wrote:
> > >   * @module_fw_flash_in_progress: Module firmware flashing is in prog=
ress.
> > > @@ -1141,6 +1148,7 @@ int ethtool_virtdev_set_link_ksettings(struct n=
et_device *dev,
> > >  struct ethtool_netdev_state {
> > >     struct xarray           rss_ctx;
> > >     struct mutex            rss_lock;
> > > +   u32                     hds_thresh;
> >
> > this value is checked in devmem.c but nothing ever sets it.
> > net/ethtool/rings.c needs to handle it like it handles
> > dev->ethtool->hds_config
>
> Oh, I see you set it in the driver in patch 8.
> That should work, my only concern is that this is not how
> any of the other ethtool config options work today.
> And there isn't any big warning in the code here telling
> driver authors that they are responsible for the state update.
>
> So even tho your patches are correct I still think it's better
> to handle it like hds_config, just for consistency.

Thanks, I will set hds_thresh in the ethnl_set_rings() like the hds_config.
So, I will remove code setting hds_thresh in the netdevsim and bnxt driver.
Also, I will change the comments of hds_thresh and hds_thresh_max to
your suggestion!

Thank you so much!
Taehee Yoo

