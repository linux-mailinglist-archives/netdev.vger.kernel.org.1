Return-Path: <netdev+bounces-45472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0327DD6A0
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 20:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C749B1C20C08
	for <lists+netdev@lfdr.de>; Tue, 31 Oct 2023 19:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409D022311;
	Tue, 31 Oct 2023 19:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCyaNxWs"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C321363
	for <netdev@vger.kernel.org>; Tue, 31 Oct 2023 19:18:28 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39005C2;
	Tue, 31 Oct 2023 12:18:27 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507c1936fd5so156035e87.1;
        Tue, 31 Oct 2023 12:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698779905; x=1699384705; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T3Ilp1TvpF5zU2TkWdi5gCXbyF9euMGcOrcfI60aWtc=;
        b=UCyaNxWsPj3MCgUY32+L7ejyFlivu+i6oFfbjSfFSlBlGm18SMdw1Nv4auJH9hCUlJ
         AHnx42rUyeDOJmTAa4rlezjRk3E2piKT6FwMvaxczZmtHch+JHo8MKqF/IPKQ37Vb87F
         gWIJPDhiya4Set8xeTi8o/wQ5qRcfPG7b87FM/1ISRcfvLB+vQqGhgAPjCeBOygQbofR
         kHESZ+3ucCKgU/HSLD3bajcORVi7Y/W3+ar6JEGZPsuWUygJ4LcSr0z3m6fZrv9lafR9
         s3eo+/faK+MdTNJ+m0sOUTFIiLpRxA/TivFjeb8fETmR7deC0V9Gn4AAD1winS+bJ5OF
         dLLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698779905; x=1699384705;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T3Ilp1TvpF5zU2TkWdi5gCXbyF9euMGcOrcfI60aWtc=;
        b=WTslIPHZffQeVoroXclMeluEAeQyST4l5vEy2gv2TA5bFA/F6N2stvU/KTayyr8R1q
         2oiCw2PxaLQ8i3qLEpg+rE+Vm4jm3ZObbaDmP6wmdOxrejGxP7jUye/k0bvgSW9n4GLe
         HRSvtIuC4aljzo9ViRnqsCKF18ZJc3QMeIfOAai8FE+p2JyJpdVRB9VLhRMJ/m5cjAP+
         zKSjN4a6tBXLtpGD3Jy6KBCVCZKa4bNA7s3QEOHbKJ9oiunFPY1EQMWc0zeJUW6XvCyb
         xGUsN2rUjuuI+Fs+FWq96YLwcamW9DOWgoXtPSefL0QroMLWIwxTg5ogSpZE7l2lpzK+
         PHaQ==
X-Gm-Message-State: AOJu0YxpFcuIHYWA2rYP7fVoQ4mdk/ad5j4s5IjlO5bccHYgM9qV9Qt2
	8vysbNdPvtb/m4r8yWiTRf/4CD7FV3SShV9RTHw=
X-Google-Smtp-Source: AGHT+IFnzoS6t5OCUWrhdKLuf0bp8kakj9QntRpu1H9/imngPp3EjTqpWPh05Yt9SAohU/tt0aJzPMSYroXdfTtag+E=
X-Received: by 2002:a05:6512:3ba9:b0:508:15dc:ec11 with SMTP id
 g41-20020a0565123ba900b0050815dcec11mr1591469lfv.30.1698779905027; Tue, 31
 Oct 2023 12:18:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231030-fix-rtl8366rb-v2-1-e66e1ef7dbd2@linaro.org>
 <20231030141623.ufzhb4ttvxi3ukbj@skbuf> <CACRpkdaN2rTSHXDxwuS4czCzWyUkazY4Fn5vVLYosqF0=qi-Bw@mail.gmail.com>
 <20231030222035.oqos7v7sdq5u6mti@skbuf> <CACRpkdZ4+QrSA0+JCOrx_OZs4gzt1zx1kPK5bdqxp0AHfEQY3g@mail.gmail.com>
 <20231030233334.jcd5dnojruo57hfk@skbuf> <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
In-Reply-To: <CACRpkdbLTNVJusuCw2hrHDzx5odw8vw8hMWvvvvgEPsAFwB8hg@mail.gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 31 Oct 2023 16:18:13 -0300
Message-ID: <CAJq09z4+3g7-h5asYPs_3g4e9NbPnxZQK+NxggYXGGxO+oHU1g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: dsa: tag_rtl4_a: Bump min packet size
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> I don't have any other RTL8366RB systems than the D-Link DIR-685.
>
> I however have several systems with the same backing ethernet controller
> connected directly to a PHY and they all work fine.

Hi Linus,

I ported TL-WR1043nd to DSA using RTL8366RB on OpenWrt main. Do you
need some help testing the switch?

I just need to test ping with different sizes?

Regards,

Luiz

