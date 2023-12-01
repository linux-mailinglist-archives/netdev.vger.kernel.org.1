Return-Path: <netdev+bounces-53072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3A18012D2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 19:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A6471C20C12
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ECD4E1BC;
	Fri,  1 Dec 2023 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ectx/Jbm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B73BD
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 10:33:12 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a02ba1f500fso372719966b.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701455590; x=1702060390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=738HwGeAiA3Mv3rj5fZwSn1NgklwgVqxq6lPPHVus6g=;
        b=Ectx/JbmuY4a8WcA5t3oblh5ZxTI7RbGr8mSRFYJ2yi7u2g8kAP3CfcewcuRLnqcTv
         bS3YoFZuBltwTzcgEsBjj763f4KBdcrjeotCv74ou3QRmfOOk397t9icbRpvY4pcEMZS
         ZOZPr2iawiGgXBDvH4hykHPoUCDZTPv1vPNPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701455590; x=1702060390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=738HwGeAiA3Mv3rj5fZwSn1NgklwgVqxq6lPPHVus6g=;
        b=Gt37FKCUNr6nX4b6bhBhxNvwujzTvKabu3YgpO9qwkkWiYwGAOS7vBNSycYsRKuGRe
         84EIb1Mchjw17Iyg5NHDcQ7am54gCnxoiyqFKiI8WVDUd336fIQMoGHiKlNdarH6q7aA
         NIgsNbuzBJAK7SdsK9HL5+pF/Q8dmv14rYvFMYdcoeXGMSI2xWsiFSv6Z4Slfp9EBLON
         idDW0zzfki3utVHpOxn9fqd1BySqrV4ZAUSqhqgl+RvDDmHxwPiWX82GVLa+mbyFQp4P
         9ooAdy5ZIWpBY1HCyzauyt77K+XckbaEqWQBR3d/bYzfB4/GbNJdTW/sPO4Y2HWya85p
         hcSw==
X-Gm-Message-State: AOJu0YysdouUoJPTK8EGd25BDQYUQE7kppSfCeU9BOjCaXk8X7hwHqvb
	e1vHmHG1VeYRuuwwGPn0GTrn++aLMtqdn62nFt7tAohH
X-Google-Smtp-Source: AGHT+IErZMRCfWjRjG+ujAMf8xZqSh+pG2RrTJzR0lCQ7BBkQQoyJRujjGzO8g3RYWLs7oTFJYUn8Q==
X-Received: by 2002:a17:906:2206:b0:a17:80d6:2d2c with SMTP id s6-20020a170906220600b00a1780d62d2cmr1322344ejs.7.1701455590142;
        Fri, 01 Dec 2023 10:33:10 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id l13-20020a170906a40d00b00a18a9931dc1sm2092820ejz.105.2023.12.01.10.33.09
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 10:33:09 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40b422a274dso4535e9.0
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 10:33:09 -0800 (PST)
X-Received: by 2002:a05:600c:35d2:b0:40a:4c7d:f300 with SMTP id
 r18-20020a05600c35d200b0040a4c7df300mr234494wmq.6.1701455589264; Fri, 01 Dec
 2023 10:33:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231130154337.1.Ie00e07f07f87149c9ce0b27ae4e26991d307e14b@changeid>
 <62b7467f-f142-459d-aa23-8bfd70bbe733@rowland.harvard.edu>
In-Reply-To: <62b7467f-f142-459d-aa23-8bfd70bbe733@rowland.harvard.edu>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 1 Dec 2023 10:32:57 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VMZGaNdSKAL8o6jtXwmik0aKgO6DdOpe9OvHth9TZf9Q@mail.gmail.com>
Message-ID: <CAD=FV=VMZGaNdSKAL8o6jtXwmik0aKgO6DdOpe9OvHth9TZf9Q@mail.gmail.com>
Subject: Re: [PATCH] usb: core: Save the config when a device is deauthorized+authorized
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Simon Horman <horms@kernel.org>, Grant Grundler <grundler@chromium.org>, 
	Hayes Wang <hayeswang@realtek.com>, =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Brian Geffon <bgeffon@google.com>, 
	Bastien Nocera <hadess@hadess.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Flavio Suligoi <f.suligoi@asem.it>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	=?UTF-8?Q?Ricardo_Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>, 
	Rob Herring <robh@kernel.org>, Roy Luo <royluo@google.com>, 
	Stanley Chang <stanley_chang@realtek.com>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Dec 1, 2023 at 7:59=E2=80=AFAM Alan Stern <stern@rowland.harvard.ed=
u> wrote:
>
> On Thu, Nov 30, 2023 at 03:43:47PM -0800, Douglas Anderson wrote:
> > Right now, when a USB device is deauthorized (by writing 0 to the
> > "authorized" field in sysfs) and then reauthorized (by writing a 1) it
> > loses any configuration it might have had. This is because
> > usb_deauthorize_device() calls:
> >   usb_set_configuration(usb_dev, -1);
> > ...and then usb_authorize_device() calls:
> >   usb_choose_configuration(udev);
> > ...to choose the "best" configuration.
> >
> > This generally works OK and it looks like the above design was chosen
> > on purpose. In commit 93993a0a3e52 ("usb: introduce
> > usb_authorize/deauthorize()") we can see some discussion about keeping
> > the old config but it was decided not to bother since we can't save it
> > for wireless USB anyway. It can be noted that as of commit
> > 1e4c574225cc ("USB: Remove remnants of Wireless USB and UWB") wireless
> > USB is removed anyway, so there's really not a good reason not to keep
> > the old config.
> >
> > Unfortunately, throwing away the old config breaks when something has
> > decided to choose a config other than the normal "best" config.
> > Specifically, it can be noted that as of commit ec51fbd1b8a2 ("r8152:
> > add USB device driver for config selection") that the r8152 driver
> > subclasses the generic USB driver and selects a config other than the
> > one that would have been selected by usb_choose_configuration(). This
> > logic isn't re-run after a deauthorize + authorize and results in the
> > r8152 driver not being re-bound.
> >
> > Let's change things to save the old config when we deauthorize and
> > then restore it when we re-authorize. We'll disable this logic for
> > wireless USB where we re-fetch the descriptor after authorization.
>
> Would it be better to make the r8152 driver override
> usb_choose_configuration()?  This is the sort of thing that subclassing
> is intended for.

Yes, this is a nice solution. Posted.

https://lore.kernel.org/r/20231201183113.343256-1-dianders@chromium.org

