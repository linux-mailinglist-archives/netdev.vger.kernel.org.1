Return-Path: <netdev+bounces-63423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 478C282CD10
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 15:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC2ACB2278B
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 14:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4F4363;
	Sat, 13 Jan 2024 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BncxCAo9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089A6360
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2cd0f4f306fso86533511fa.0
        for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 06:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705156901; x=1705761701; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qcjvRV32siJwc2Y7Rzvj1x6w0tlsj4sWi41CJHMwftg=;
        b=BncxCAo9QMdcQh9YOqo9DMCo37TfqWjeDNn1EaPhRc6DQjJTfCmQWvx1dfRTn3TeSk
         sQHGnkIfL6TXLfZhfQqCeZfLe1tLZv0Rrl0DLyneklQJVT7HuyEp4pER7poHOD7i8sah
         sgUL56ZeTyDOyHtZgushBgxGZYm6aBGwZy/s/jg+MpCtF7e89SPq9EphX58XTDS7hyVr
         UiUEb9IyDDazPGFALT5U2AffxbBn1n9KaRUKU2HVHsGv892bJbw/LPHdirXjjjnzQ8t3
         /stAI1vcNp7g7KLU4pFU6A4Hi9OSWz0TofA8eoKCyCGoXaHB6cwvSnKGL5zXlDqutx1e
         7C/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705156901; x=1705761701;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qcjvRV32siJwc2Y7Rzvj1x6w0tlsj4sWi41CJHMwftg=;
        b=uO8UpVoE2TdJEqVy7u8BN4D37bDZe7uU4hbBlL391BZDLhE9NtLXqe2nGk/zXRKubd
         Ne/UwV7Gqxfv3qgtoRvVlYPeBagmWtGGfNm+EpRft7NgJ1QSCn/tWJCo5IF3vPIkLon3
         a5BGXuLCtiOJ8hay1701XqtJH+BxbMl/Dv8/rjIHEPBFX+y8Z0nutroGK6/Ks7p3PsQe
         heeXe1cCZWrx16U/yUFM9QtGSosiBn1qQHidqoVnaa/vurkX+jMyOPvr47h5rTpKHl9L
         CBjcIu3MlfF4sGXH0LTxyjAbE6xzPlIY35p9Z2tmz6M6LnM18UDRWL/msacRg6jyNlvb
         sByw==
X-Gm-Message-State: AOJu0YyRhssBxUabdD7mCHd4KR3Qwbgg+ZCkFh77iZOYUvGwLnM208L5
	H17+lVE20kMVH5d1i36AwHxXjQMC39CPHWgZZMoymS4ikL4=
X-Google-Smtp-Source: AGHT+IGLSDQRrcEH2eRXhvTiTq1vDrDxNUbe3QHagxNpnzL1ieOqmEpAvhhdX+4JdZ3PtUg9pUb2WGCENJaHBlcS8YU=
X-Received: by 2002:a2e:b803:0:b0:2cd:2c8d:b48d with SMTP id
 u3-20020a2eb803000000b002cd2c8db48dmr1231889ljo.63.1705156900872; Sat, 13 Jan
 2024 06:41:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240106184651.3665-1-luizluca@gmail.com> <CAJq09z6PE02HEMJF0k8UwLjtMaDs5UVjMB43vVQo6ysLKp_FFQ@mail.gmail.com>
 <659b1106.050a0220.66c7.9f80@mx.google.com> <CAJq09z6zGVb-TwYqWaT7BYvXGRz=0MEN+X0hy613V8a_CX5U5A@mail.gmail.com>
 <659bf414.050a0220.32376.5383@mx.google.com> <CAJq09z6=78wQOv8HDghtmR04_k+kwCQbf_W7Th7d3NfGDX9pwg@mail.gmail.com>
 <CAJq09z5SEqCxC5jQ7mPS+rqr-U-eXgWH=mjcpHpWT7UF_7twxA@mail.gmail.com> <92eff1db-004c-4c08-9dd3-ae094d8dd316@gmail.com>
In-Reply-To: <92eff1db-004c-4c08-9dd3-ae094d8dd316@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 13 Jan 2024 11:41:29 -0300
Message-ID: <CAJq09z5N+uunRB586c6OTbD7J4x8O=iXHpXjAQXVPN0b5zKEXA@mail.gmail.com>
Subject: Re: [RFC net-next 0/2] net: dsa: realtek: fix LED support for rtl8366rb
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Christian Marangi <ansuelsmth@gmail.com>, linus.walleij@linaro.org, alsi@bang-olufsen.dk, 
	andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> This is addressed by the following patch, it should show up in linux-next
> after the merge window.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git/commit/?h=for-leds-next-next&id=5df2b4ed10a4ea636bb5ace99712a7d0c6226a55

Hello Heiner,

Yes, exactly that. Thanks. I wish it had appeared some days ago. :-)

Regards,

Luiz

