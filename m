Return-Path: <netdev+bounces-49747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8FF7F3560
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 18:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2A36B2127A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C53A59160;
	Tue, 21 Nov 2023 17:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O72JOhAM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F318E
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 09:56:04 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a00b056ca38so239139966b.2
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 09:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700589360; x=1701194160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MA4AVc9wusU+6rRUqfOFOnbQWEj+co4/T/ukMhfmlOA=;
        b=O72JOhAMYHNP51q6iZdBjpc3Os0yN2Ka6WCpkneJFhM3AVDpfBnpaFMi3EdteZ+Ar5
         qy3YBZBtTXTU9gTBsEJgo6ARRYpS4v5h7baNnztzjZut6mvIZwUZEwjsPMGOffWPakNm
         EyBkS1jcX06G6gkl3FgZna6qFd4JmYVqTOvdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700589360; x=1701194160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MA4AVc9wusU+6rRUqfOFOnbQWEj+co4/T/ukMhfmlOA=;
        b=pj2enGSAJNyGXjVKTuWbRawdRuusENl0fOz90PfR7gfBvDE6Fl60ToJ/OeFyuOmF+z
         JguQoIKknrHg9POuEx+cEehO9g/FsScPIg6kbZ7FQPUwPfVS4Vzs09z/gASEKQMV0UR4
         YzXCMx8HiLnhbRUmR14qATKKNEcN5YSYsHodVxN6VbndQGWUy+TxvziDLhU/JUKZuRGl
         1EXBjFImVuf0h9X8u3kbJi4rxFqW1m4LU8bD2dvsNPppQ6YdGkGJdHfp15b+SJ/XUo0r
         zeVVlDa1070ZyPNl6jg66eKtr7n6EbVcwsFsM6vzpWk0cClREpUCD3tudzq3jRmGthBH
         tE7w==
X-Gm-Message-State: AOJu0YxhOumU0vbz7CGwFV0VFDJ3UEsLoxTg2VbkILcmtIeea/NA/Ssd
	XTEVNRH5MVqxZBj3i6Pl+XGS37PDI/0tHFjPRHzzWb9a
X-Google-Smtp-Source: AGHT+IEv8WgSwdSvxwy6IhVZL2z7AaUbXeQUfjm7cGCtLamHeFcGAJhNXapU6nRSiQnA1jv8nKwoIg==
X-Received: by 2002:a17:906:2da:b0:9ff:1e84:76fc with SMTP id 26-20020a17090602da00b009ff1e8476fcmr4135206ejk.5.1700589360765;
        Tue, 21 Nov 2023 09:56:00 -0800 (PST)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com. [209.85.128.45])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906a29a00b00a01892903d6sm1340732ejz.47.2023.11.21.09.55.59
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:55:59 -0800 (PST)
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4078fe6a063so1585e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 09:55:59 -0800 (PST)
X-Received: by 2002:a05:600c:1c1f:b0:40b:2ec6:2a87 with SMTP id
 j31-20020a05600c1c1f00b0040b2ec62a87mr1361wms.5.1700589359277; Tue, 21 Nov
 2023 09:55:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117130836.1.I77097aa9ec01aeca1b3c75fde4ba5007a17fdf76@changeid>
 <20231117130836.2.I79c8a6c8cafd89979af5407d77a6eda589833dca@changeid> <4fa33b0938031d7339dbc89a415864b6d041d0c3.camel@redhat.com>
In-Reply-To: <4fa33b0938031d7339dbc89a415864b6d041d0c3.camel@redhat.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 21 Nov 2023 09:55:46 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VALvcLr+HbdvEen109qT3Z5EL0u4tiefTs3AH8EHXFnA@mail.gmail.com>
Message-ID: <CAD=FV=VALvcLr+HbdvEen109qT3Z5EL0u4tiefTs3AH8EHXFnA@mail.gmail.com>
Subject: Re: [PATCH 2/2] r8152: Add RTL8152_INACCESSIBLE checks to more loops
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Hayes Wang <hayeswang@realtek.com>, 
	"David S . Miller" <davem@davemloft.net>, Grant Grundler <grundler@chromium.org>, 
	Simon Horman <horms@kernel.org>, Edward Hill <ecgh@chromium.org>, linux-usb@vger.kernel.org, 
	Laura Nao <laura.nao@collabora.com>, Alan Stern <stern@rowland.harvard.edu>, 
	=?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>, 
	Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Nov 21, 2023 at 2:28=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wro=
te:
>
> On Fri, 2023-11-17 at 13:08 -0800, Douglas Anderson wrote:
> > Previous commits added checks for RTL8152_INACCESSIBLE in the loops in
> > the driver. There are still a few more that keep tripping the driver
> > up in error cases and make things take longer than they should. Add
> > those in.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> I think this deserves a 'Fixes' tag. Please add it.

Sure, I can add it. It didn't feel worth it to me since there's no
real functional issue--just that it takes a little longer for these
loops to exit out, but it shouldn't hurt. I guess that means breaking
this commit into several depending on when the offending loop was
added.


> Additionally please insert the target tree in the subj prefix when re-
> postin (in this case 'net')

Funny, I just followed the tags for other commits to this file and the
"net:" prefix isn't common. I guess this should be "net: usb: r8152".
I can add it when I post v2.

