Return-Path: <netdev+bounces-60280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A20981E708
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 12:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B417A282B85
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 11:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1F84E1BA;
	Tue, 26 Dec 2023 11:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P+lzNB3u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF694E1A1
	for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 11:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-554e4f8610aso1213223a12.1
        for <netdev@vger.kernel.org>; Tue, 26 Dec 2023 03:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703589036; x=1704193836; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CTN5cdMQmoChMGJm7Pu05yWyEeojGL99TYTD4/ier4M=;
        b=P+lzNB3udKRaR4UHPG/O1Q9d0XONBuFarnlyZkJGQOuR3x6iC9SJb12/e2uj0m34Py
         gfmcHQa4lYOjzzgVJ7srOjgJGE/HnfiB6ZWI1PjHde01oKQIQ5+haPfJbi1eX9Plr+PV
         5bC9n6IwD9hMKqAFF1W5pkFCGl7rP7LuW11KH02QTkPZcO2Mus/SDCYz1KlT3QCCwBJ0
         KgDEZ2ogB5qNk0RRo7U8IwrE1fmY7FE3vjlUhhZvbxbR4vN/r9hQEKhDXlEefbdogviS
         J+7i2B6gRLrVFFQ7rvYWAwgnlr4HjfoE6v2YjYi7DFs11v4EjoTEcz7q5L8kvMMzAF5e
         Fw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703589036; x=1704193836;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTN5cdMQmoChMGJm7Pu05yWyEeojGL99TYTD4/ier4M=;
        b=prn6ipTL7GHbFhAnHn68+qhw6zJbvTF/Kz+XV2OrY3XXJdWXui9stkFk4HkBvO+ArB
         2hzWdObL6ZTlJOzzg5epEewLtAsuy7TKQv7L2adWoOzcAR8ChvlEvumJolY/9Zs8DfOo
         jEFtge2WpVVYfOmmpLgRI9Fav2t71IRQpUwVgmKKq/V8kfF3tud8PTW9AJgKWdPPrFUL
         GrcOHTDCKbqjb82e5yRCBogO74i8fEAYPdrFNLLKpaKPvhWR8OK7a9sUnkfzxbGLTQ8Y
         PTntD0QoOMSvEE4KrKNEwvaGjFbxCqSQbLLUw8YkNxKRKBmrlvuVUd/GP9e6s+C7KeIW
         cVTQ==
X-Gm-Message-State: AOJu0Ywz1kwjXC9i7po1NMcoy3Uv31Kx+Wecz0nBUnmCg7fysdaDcYl6
	gkY664LtGgbcl/Ybz56KkvTgncXimbwtd+lcy1w9sUeerFGayQ==
X-Google-Smtp-Source: AGHT+IGfQzrSrF3cSWyPjslxoAfAeCp0pz1UZ6+1gq+6oIVz2lpYxWYguP8HcczVomFltgiOY/Q1KAGp6a8pqBbDav4=
X-Received: by 2002:a17:907:3e9f:b0:a23:36f7:4918 with SMTP id
 hs31-20020a1709073e9f00b00a2336f74918mr4159073ejc.72.1703589035952; Tue, 26
 Dec 2023 03:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <MEYP282MB2697D55EB54FA63E7F58AFD4BB98A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <MEYP282MB2697D55EB54FA63E7F58AFD4BB98A@MEYP282MB2697.AUSP282.PROD.OUTLOOK.COM>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Tue, 26 Dec 2023 12:09:59 +0100
Message-ID: <CAMZdPi9TLiKgtPrE=XLnn694mkScj=aASN7Kc8-Qu-hKGXR0Lg@mail.gmail.com>
Subject: Re: [PATCH v2] net: wwan: t7xx: Add fastboot interface
To: Jinjian Song <songjinjian@hotmail.com>
Cc: netdev@vger.kernel.org, chandrashekar.devegowda@intel.com, 
	chiranjeevi.rapolu@linux.intel.com, haijun.liu@mediatek.com, 
	m.chetan.kumar@linux.intel.com, ricardo.martinez@linux.intel.com, 
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-kernel@vger.kernel.com, vsankar@lenovo.com, danielwinkler@google.com, 
	nmarupaka@google.com, joey.zhao@fibocom.com, liuqf@fibocom.com, 
	felix.yan@fibocom.com, Jinjian Song <jinjian.song@fibocom.com>
Content-Type: text/plain; charset="UTF-8"

Hello Jinjian,

On Tue, 26 Dec 2023 at 08:16, Jinjian Song <songjinjian@hotmail.com> wrote:
>
> From: Jinjian Song <jinjian.song@fibocom.com>
>
> To support cases such as firmware update or core dump, the t7xx
> device is capable of signaling the host that a special port needs
> to be created before the handshake phase.
>
> Adds the infrastructure required to create the early ports which
> also requires a different configuration of CLDMA queues.
>
> On early detection of wwan device in fastboot mode, driver sets
> up CLDMA0 HW tx/rx queues for raw data transfer and then create
> fastboot port to user space.

Could you please split this single commit int a proper series. At
least one dedicated commit for adding new port to the core, and you
may want one for the new sysfs attributes and state machine, then one
for  your driver fastboot port support...


>
> Signed-off-by: Jinjian Song <jinjian.song@fibocom.com>
> ---
> v2:
>  * optimizing using goto label in t7xx_pci_probe
> ---
>  drivers/net/wwan/t7xx/Makefile             |   1 +
>  drivers/net/wwan/t7xx/t7xx_hif_cldma.c     |  47 +++++--
>  drivers/net/wwan/t7xx/t7xx_hif_cldma.h     |  18 ++-
>  drivers/net/wwan/t7xx/t7xx_modem_ops.c     |   5 +-
>  drivers/net/wwan/t7xx/t7xx_pci.c           |  88 +++++++++++-
>  drivers/net/wwan/t7xx/t7xx_pci.h           |  11 ++
>  drivers/net/wwan/t7xx/t7xx_port.h          |   4 +
>  drivers/net/wwan/t7xx/t7xx_port_fastboot.c | 155 +++++++++++++++++++++
>  drivers/net/wwan/t7xx/t7xx_port_proxy.c    |  89 ++++++++++--
>  drivers/net/wwan/t7xx/t7xx_port_proxy.h    |  12 ++
>  drivers/net/wwan/t7xx/t7xx_port_wwan.c     |   5 +-
>  drivers/net/wwan/t7xx/t7xx_reg.h           |  28 +++-
>  drivers/net/wwan/t7xx/t7xx_state_monitor.c | 125 ++++++++++++++---
>  drivers/net/wwan/t7xx/t7xx_state_monitor.h |   1 +
>  drivers/net/wwan/wwan_core.c               |   4 +
>  include/linux/wwan.h                       |   2 +
>  16 files changed, 537 insertions(+), 58 deletions(-)
>  create mode 100644 drivers/net/wwan/t7xx/t7xx_port_fastboot.c

