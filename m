Return-Path: <netdev+bounces-63147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1726A82B579
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3649F1C219A7
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BA956747;
	Thu, 11 Jan 2024 19:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEoPqMu0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FF156741
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2cd17a979bcso64743121fa.0
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 11:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705002793; x=1705607593; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lmniem6wSkSsUvwWz68jc030pRYxGECq931U1PqLReY=;
        b=WEoPqMu0HJaMn4fRN2big0W4hsRZ3/c1T9jFuWPyVY5IHM5lbxaydXtBGqAki3ZFdS
         Nziwho/3QgwqzWNQFiTipyK8ydEfktqFZ103shrQAvdMkgPibdBW4TtwJPBjxK4kIujj
         GYx9OZkz8DOlOSF51hFg+cotTGohf+lrjUkw1DUt7OzqHsdsfC8J1p1nGesD5TVdxtZK
         gYF7+p9d8RaNUsGr8dZtEIoPSeVnMz0CT60YGATKwl7SMm5qIR3nToMHKZzTWT3Kq8kQ
         e2u/uO73uyj97eeqvkiuAK+NLewsu+5d3d8fnwDPDtA0yEZKWkTJrvvtGQF4TeSSUHM1
         s7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705002793; x=1705607593;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lmniem6wSkSsUvwWz68jc030pRYxGECq931U1PqLReY=;
        b=gQE9lVXuuJwxgV5jG6ffuatfgroyXFZkBEhEkDlFjHLw8z49gU82Dd0PNWZhnBqHuX
         gm7I7psNjurxhbAyILEpKYhOvn6OhzkGZCo2oyt0X372pgs567eBHMLORF/rkdb0HWB1
         R2byhgmqLwi9ZGI8ZN8QpqqC+FoVBiUTvRP0/uSxydnVz5srpnF8vp48TFZMppOuBoid
         Ov/fhyeuy2kOWA5sq9nqHzOCTGdCRsM5peDxrFlp8otUbDhJwyf4DeEswrftmqwo3zUd
         zPJO14uqa89dat/XwbRoY+Fvoc3DUmLJTp01RkQLcypJsiQsp8gTiXMjTvGz6DcbwymL
         Wdcg==
X-Gm-Message-State: AOJu0Yz/nmUcK/RSqBfG1PYye/iAo38MlRE1DVAkCeJKuFDaGgwqt8sd
	t+5PK1thJ9uuedQdvXkyxuhYbYWyGYgZdnZVPkU=
X-Google-Smtp-Source: AGHT+IEsWAE6aX5aZIgzjR5h62Eik03BFcCg8t2iz+zVKsrzXuHtE1g2ufSusQWz88ChK8RPm/8HDwVQXBWPtl7dXPI=
X-Received: by 2002:a05:651c:10a9:b0:2cd:7a4c:5a70 with SMTP id
 k9-20020a05651c10a900b002cd7a4c5a70mr74285ljn.8.1705002792922; Thu, 11 Jan
 2024 11:53:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231223005253.17891-1-luizluca@gmail.com> <20231223005253.17891-4-luizluca@gmail.com>
 <20240111095125.vtsjpzyj5rrag3sq@skbuf>
In-Reply-To: <20240111095125.vtsjpzyj5rrag3sq@skbuf>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 11 Jan 2024 16:53:01 -0300
Message-ID: <CAJq09z7rba+7LCrFSYk5FjJSPvfSS0gocRCTPiy4v8V5BxfW+A@mail.gmail.com>
Subject: Re: [PATCH net-next v3 3/8] net: dsa: realtek: common realtek-dsa module
To: Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

> On Fri, Dec 22, 2023 at 09:46:31PM -0300, Luiz Angelo Daros de Luca wrote:
> > +EXPORT_SYMBOL_GPL(realtek_common_lock);
> > +EXPORT_SYMBOL_GPL(realtek_common_unlock);
> > +EXPORT_SYMBOL(realtek_common_probe);
> > +EXPORT_SYMBOL(realtek_common_register_switch);
> > +EXPORT_SYMBOL(realtek_common_remove);
>
> Is there any reason for the lack of consistency between GPL and non-GPL
> symbols?

No. I might have just copied the string from the wrong example.

> Also, I don't like too much the naming of symbols like "realtek_common_probe",
> exported to the entire kernel. I wonder if it would be better to drop
> the word "common" altogether, and use EXPORT_SYMBOL_NS_GPL(*, REALTEK_DSA) +
> MODULE_IMPORT_NS(REALTEK_DSA) instead of plain EXPORT_SYMBOL_GPL()?

Introducing a namespace seems to be a nice ideia. Let the series grow :-)

What do you mean by dropping the "common"? Use "realtek_probe" or
"realtek_dsa_probe"?

Regards,

Luiz

