Return-Path: <netdev+bounces-52278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A44047FE1E7
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D376F1C20B0B
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 21:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7060D2B9AF;
	Wed, 29 Nov 2023 21:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y6QhwAfE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBAB170D
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:27:09 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso85970a12.1
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701293226; x=1701898026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ka42P07XD3cUN5FmdYHNdz0HlIW/qLMANiOksrtIlmU=;
        b=Y6QhwAfEG0WiSrtFokzSRFvATNtVphVuV7Xrwfn0KCnHhcAP9syha/MMvcIG9kEDwb
         fWZGsK3wO957wSdYBxMaA++cJiM/vBti1DMOK4rz5mDe4B/PtJu9kd7e4GT/Yj/1c+S3
         GuIqgpQ+GmIpwFXcE6u+8e09KA/JPU+wd8Aj4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701293226; x=1701898026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ka42P07XD3cUN5FmdYHNdz0HlIW/qLMANiOksrtIlmU=;
        b=oMc65kuMrR+8KGs33z+VQvy9MT0jIAHnAEwP5VChZEEUkh9rFkuD7T2uoObf7p1i8g
         0HljuTUH6RmxqwXR/stciCsrzF31BsOclISCFqlCJXWnaNlDFT+/pNZ6LpuG+QSMr/++
         U3wZgxIlfKNbBdd5D9qapeX95t7rN+OSsb7lW1DVFP6Sy9DcZr4l6qTiO9e9kcAg3L+r
         16ynQb7AZrFT0HJldX6AWoxp1lXePMhKnSUyN2soRrLqN5ZIJzyoWH3aSV9cusWqQu4g
         L22M9eIm4a4/PMhatjHMty+agVwWYNe4gCozW5Tlt9R6r4aIW1nQWh3OhI6V7qU3yTXC
         s59A==
X-Gm-Message-State: AOJu0YxcfIi1mUwBQ6PaggmKbIHt/kXmE/WzW9/jAUW24M7Hujyi6+Jx
	P7ZYJWqr7jcviQn2nIETCEI18ej4ICPIP+Lr/pjs3P0Q
X-Google-Smtp-Source: AGHT+IGUblKPoSdN2P+l8rmw+XlfRCUerH6rumNCvUjoI+e2uDMpIgYbFKFMYp/PzquDZq944D0b7Q==
X-Received: by 2002:a17:906:c791:b0:9ad:8a96:ad55 with SMTP id cw17-20020a170906c79100b009ad8a96ad55mr21361642ejb.14.1701293226036;
        Wed, 29 Nov 2023 13:27:06 -0800 (PST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com. [209.85.128.42])
        by smtp.gmail.com with ESMTPSA id p18-20020a1709061b5200b009b9a1714524sm8414445ejg.12.2023.11.29.13.27.05
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 13:27:05 -0800 (PST)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40b35199f94so21575e9.0
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 13:27:05 -0800 (PST)
X-Received: by 2002:a7b:c415:0:b0:40b:33aa:a2b9 with SMTP id
 k21-20020a7bc415000000b0040b33aaa2b9mr40631wmi.4.1701293224778; Wed, 29 Nov
 2023 13:27:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231128133811.net.v2.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
 <20231128133811.net.v2.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid> <d6f843b90b7146059332c82159ba79ff@realtek.com>
In-Reply-To: <d6f843b90b7146059332c82159ba79ff@realtek.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 29 Nov 2023 13:26:52 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VOdj5z76Rvue93MUriGhX2Arijo-ZMifHw=qO6kxbjtQ@mail.gmail.com>
Message-ID: <CAD=FV=VOdj5z76Rvue93MUriGhX2Arijo-ZMifHw=qO6kxbjtQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/5] r8152: Add RTL8152_INACCESSIBLE checks to more loops
To: Hayes Wang <hayeswang@realtek.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Laura Nao <laura.nao@collabora.com>, Edward Hill <ecgh@chromium.org>, 
	Alan Stern <stern@rowland.harvard.edu>, Grant Grundler <grundler@chromium.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Nov 29, 2023 at 4:47=E2=80=AFAM Hayes Wang <hayeswang@realtek.com> =
wrote:
>
> Douglas Anderson <dianders@chromium.org>
> > Sent: Wednesday, November 29, 2023 5:38 AM
> [...]
> > @@ -3000,6 +3000,8 @@ static void rtl8152_nic_reset(struct r8152 *tp)
> >                 ocp_write_byte(tp, MCU_TYPE_PLA, PLA_CR, CR_RST);
> >
> >                 for (i =3D 0; i < 1000; i++) {
> > +                       if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> > +                               return;
> >                         if (!(ocp_read_byte(tp, MCU_TYPE_PLA, PLA_CR) &=
 CR_RST))
> >                                 break;
> >                         usleep_range(100, 400);
> > @@ -3329,6 +3331,8 @@ static void rtl_disable(struct r8152 *tp)
> >         rxdy_gated_en(tp, true);
> >
> >         for (i =3D 0; i < 1000; i++) {
> > +               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> > +                       return;
>
> I think you have to replace return with break.
> Otherwise, rtl_stop_rx() wouldn't be called.
> And, you may free the memory which is using, when rtl8152_close () is cal=
led.
>
> >                 ocp_data =3D ocp_read_byte(tp, MCU_TYPE_PLA, PLA_OOB_CT=
RL);
> >                 if ((ocp_data & FIFO_EMPTY) =3D=3D FIFO_EMPTY)
> >                         break;
> > @@ -3336,6 +3340,8 @@ static void rtl_disable(struct r8152 *tp)
> >         }
> >
> >         for (i =3D 0; i < 1000; i++) {
> > +               if (test_bit(RTL8152_INACCESSIBLE, &tp->flags))
> > +                       return;
>
> Same as above.

Good catch, thanks! I've changed all of the `return` statements in
this patch to `break` for consistency, though for the other ones it
doesn't really matter. For patch #3 I also changed the `return` to a
`break`, but for patches #4 and #5 the return was better so I left
those.

v3 posted now with this fix.

-Doug

