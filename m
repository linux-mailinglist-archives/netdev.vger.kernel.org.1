Return-Path: <netdev+bounces-41008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94297C9586
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 19:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A72941C2092D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BA11A265;
	Sat, 14 Oct 2023 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rt54Di6Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A71018C30;
	Sat, 14 Oct 2023 17:01:04 +0000 (UTC)
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353A4AD;
	Sat, 14 Oct 2023 10:00:59 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5a7c93507d5so36251117b3.2;
        Sat, 14 Oct 2023 10:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697302858; x=1697907658; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OdCTPjRIGMKBfGx86w66vSRp/LhHVz+z8hRAmpGNEFU=;
        b=Rt54Di6QhypOHMlf0yzHBw2aIh9POiIyxWf6v7ud3KLDhQ5ZRBIxL9i614XmmXyveL
         gGOl2qmdCPHw5Plhg0YwQ4eQIXC2bdaSYevr1zRg/aL/JxhadzDJsPqbib9J1enbQJnq
         BCRpG2BFyuLcsSCPem/0wtyGPl+cKKF1p1Kgssr8s5y2sXSSdHQWcQMYl1QZkQzYshR3
         Q3NNSVuMBNds39Sou6+w/srO6tNB5sUJfJDPHnQd1lhS+VemodSwt+akfxe8M4sUpzkw
         w1cww2mBRE+4TntpKbgUyJHEBpfYeDVfJGkCIjZO4Ek9/cjMXCJQ1m0KstXEAdK+I6wB
         RbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697302858; x=1697907658;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OdCTPjRIGMKBfGx86w66vSRp/LhHVz+z8hRAmpGNEFU=;
        b=M8r0i++s3LBL9WOu+VB1Yn/sC+Yqlypirlu5t11EYuKVyNE0F6kakh4JBjpdPZw+zV
         md2ggUGIzcxwUe26vpEJszxcItVggDkiJiBaosBJFobwcAhX1OD5m+I9Su+9R9OgvlSr
         3rF05ZKeZcnfxHrRou2MBLrDUJTvfIYEYQ+9RD/TiO3jbeBVZ72jAQbw+csxA4an81a0
         zKQEOhuyFNKTwwUqLU5F6Xu++4CW3wovlibe0tLcFkXIacQ+cV5mPhMa8dfm8A0hOe0D
         NLTqG2NCtTW/4BcVWvJ66+wRcb+rOSP8mxhdrBAx54h117F1hCNSunwemdLk3gI1LJYc
         8ONg==
X-Gm-Message-State: AOJu0YwP0pOxPCmgd2bXgFagjSp9CPKuEW10NKRfqy218+dfsYJ+oOZA
	waVz+uTOrDl/0NH6RluBdzimaSKF6WVA24pAap0=
X-Google-Smtp-Source: AGHT+IEoSxuuJv7pY/Q3o8aJkDNJxHfM2K09KpP5qtFCHnQ2S8Jr4N9HhYjo79p+DMES7WmOwmJPpuOrfRBTZapNaGg=
X-Received: by 2002:a0d:c886:0:b0:59f:9c08:8f12 with SMTP id
 k128-20020a0dc886000000b0059f9c088f12mr35762658ywd.38.1697302858330; Sat, 14
 Oct 2023 10:00:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012125349.2702474-1-fujita.tomonori@gmail.com>
 <20231012125349.2702474-2-fujita.tomonori@gmail.com> <85d5c498-efbc-4c1a-8d12-f1eca63c45cf@proton.me>
 <4b7096cd-076d-42fd-b0cc-f842d3b64ee4@lunn.ch>
In-Reply-To: <4b7096cd-076d-42fd-b0cc-f842d3b64ee4@lunn.ch>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 14 Oct 2023 19:00:46 +0200
Message-ID: <CANiq72m3xp6ErPwCOj6DrHpG_7OE9WUqVpsZcUDk4OSuH62mKg@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/4] rust: core abstractions for network PHY drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Benno Lossin <benno.lossin@proton.me>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, tmgross@umich.edu, 
	boqun.feng@gmail.com, wedsonaf@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Oct 14, 2023 at 4:13=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> To some extent, this is just a temporary location. Once the
> restrictions of the build systems are solved, i expect this will move
> into drivers/net/phy/Kconfig, inside the 'if PHYLIB'. However, i
> agree, this should be under the Rust menu.

No, it is orthogonal to the build system restrictions.

In other words, the Kconfig entry could be moved there already. In
fact, I would suggest so.

Cheers,
Miguel

