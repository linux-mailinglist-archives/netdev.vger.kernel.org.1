Return-Path: <netdev+bounces-59691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F4381BC8F
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:04:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 657651F2445A
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5255822B;
	Thu, 21 Dec 2023 17:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5K5dtRl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CF85990A
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-554473c653aso28258a12.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 09:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703178262; x=1703783062; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XjAUPTWASIOdoiBXIpeMpz5TlvjISpvY13QHruxO8Is=;
        b=D5K5dtRli2sp0CgsTotfY370uhTIDvaIWoYocaYt8ee5MGdzExI7jSGfETxi0qbgvl
         ImtCqcw9G2YpbLEZ/On/pIKiATMIb1hF8p99opzX7+m78TqIDrAlnD7szp5HxZwLgn0D
         RN+gA0UCne55+Xvm/ouHtZQUGrMrPNoYZR4grMYjSvnn7S8+vz05kH+iopcZNNcpYuPg
         POjXpeXyO4fTORiKyr2C3jzt5t2AelwYB/E64bSjmsQePU77mm3x54szAJTA8nGGZgZu
         7RK9Xqxd7HexJStKjPFUQSiHY0gNbGGqQ9fhOwjCHShX3zDW69olLsqgUsJEYnp8grPB
         4Y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178262; x=1703783062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XjAUPTWASIOdoiBXIpeMpz5TlvjISpvY13QHruxO8Is=;
        b=d2CFrDo4nCWdZ2gKkPqUs3fDKwabC6Gwfq20XXLCxqC3Wpw6ePVqgyny7EYzO5QRvK
         sMqwy+ODCk5z9SZk7jjUacC1C81dpFNpG5WicaG8HNekHdKn6LCwt13+RK5dbg5YkQQC
         TfQRka7iP4/if+6qzp816AH5ltqKyJ3caaf9M+1ndxpX4hcTl8J/pjT2NUXvleoiz45m
         JUsh6DeaMGSjT1FPnqFIryGy1cnC0mUCIAfyCEWHRR9WqcuqQmC5ZZ0qn5Mv7XpmJns8
         nfTQfamBooq9qcaEV+sjjuxvqhr/J/Sy1kGFtEGEMahd5k9EKaO86FoBd9HtrIt1dKo6
         /oQg==
X-Gm-Message-State: AOJu0YzAqA8A8Xx2Z569d8hghMDJvf4iTohFOjMhaJ9ucwD5nFZFmm6X
	hcV33NlaGv6+74DKIeWgJRc=
X-Google-Smtp-Source: AGHT+IEsNCduYVD886oerEpoqwUt5NvYzr2p41VseixEllBGSGKgIMNnFb/S8+H3lPyF9PtHKBB0tw==
X-Received: by 2002:a50:9ea1:0:b0:54b:d16:4c0e with SMTP id a30-20020a509ea1000000b0054b0d164c0emr11855832edf.15.1703178261837;
        Thu, 21 Dec 2023 09:04:21 -0800 (PST)
Received: from skbuf ([188.27.185.68])
        by smtp.gmail.com with ESMTPSA id y4-20020aa7d504000000b00553894fc87dsm1406779edq.8.2023.12.21.09.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:04:20 -0800 (PST)
Date: Thu, 21 Dec 2023 19:04:18 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Alvin =?utf-8?Q?=C5=A0ipraga?= <ALSI@bang-olufsen.dk>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"f.fainelli@gmail.com" <f.fainelli@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"arinc.unal@arinc9.com" <arinc.unal@arinc9.com>
Subject: Re: [PATCH net-next v2 1/7] net: dsa: realtek: drop cleanup from
 realtek_ops
Message-ID: <20231221170418.6jiaydos3cc7qkyp@skbuf>
References: <20231220042632.26825-1-luizluca@gmail.com>
 <20231220042632.26825-2-luizluca@gmail.com>
 <w2xqtfeafqxkbocemv3u7p6gfwib2kad2tjbfzlf7d22uvopnq@4a2zktggci3o>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <w2xqtfeafqxkbocemv3u7p6gfwib2kad2tjbfzlf7d22uvopnq@4a2zktggci3o>

On Wed, Dec 20, 2023 at 01:57:41PM +0000, Alvin Šipraga wrote:
> On Wed, Dec 20, 2023 at 01:24:24AM -0300, Luiz Angelo Daros de Luca wrote:
> > It was never used and never referenced.
> > 
> > Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> > Reviewed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> You should always put your Signed-off-by last when sending patches.

I'm not so sure about that.

When you send a patch, it gets reviewed and then accepted all in the
same version, the Reviewed-by tag will be after your sign off. It makes
more sense to me that if you send a patch with a review tag carried
over, you put it in the same place where it would sit if it was received
on the final patch version. Idk, not too big of a deal.

