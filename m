Return-Path: <netdev+bounces-83989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 053958952E7
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EFF91C2091E
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 12:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2584979DC5;
	Tue,  2 Apr 2024 12:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y/PM2lOG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5DE76EEA
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060731; cv=none; b=UBgW+wqG+r84wMZexUUZveB+ozOx95jK3c//6caGoPboS2Qtf8udHcsgHB6Oxq5CoAfEUaA+7ngG/UPuV5uvruRgD0smpmcfj4l1HZC05hnt5a9rcP8NazJlUew5Sjo932Md+7V82+zTDrQ8XCsTf3dGJxWlnIpQWi9a4fiKjRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060731; c=relaxed/simple;
	bh=p/UeUz6BQzzlTj362U5Q+0hUyUg483V1OKi+HLKX4OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSbhbnstla9P8HmxlreKX1mjvForQZuEkbB75RHUbd4p3oIbnOhYr18pGoudnZdSO4kvXnr2hkeygO61KNrp3cOb9mP1oGZYtkhzJJ+NzkmJvlZQFe4x1z9E+neJM3S4gquxyJW9c9psBgzwflKRMtHsqJRWxlzs8AocndhAt+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y/PM2lOG; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-61495e769bdso19093577b3.0
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 05:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712060727; x=1712665527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYDEIQksW8zQ45WbeyUEVn5ldQ4luRyFOVVyheFSkHo=;
        b=Y/PM2lOGfwWISYEdLESt2KTtPtlHr8yg1/CGBA9FdtQYocQGHfZ+cW0YX8gg6woOzV
         GW2SDVi0/W3ULE54zcjGLCvAVZmtCbh3VTBP3+tIbEtfDVbLhIKmqb1+a4TsXXIi5Yzk
         SmHdUNPRN3zFBd10rSJY/qlNyGVwoVukAF36q+yItox15kUXELlUSRxcl8Mpdx9vLxmG
         OY2lC+VOGMvXLQpb+r8L51QY+HHC99dDGGT3DX0N/M8WeSY9BE+U/oYh+6bWOLo9Abss
         DlybL2mtVJawsbxg5WOsIutmwfbaMVxbHlwZxE2sF43N12B5PAMcfpnEeYIqUQTLlbrm
         fqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712060727; x=1712665527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYDEIQksW8zQ45WbeyUEVn5ldQ4luRyFOVVyheFSkHo=;
        b=SCBVyJs/ckO1G3G/C3yZOqsKFaOdLZFNvsTx81PWGLBLdRl8kTTL7huFk+2rjx02Ye
         GcpganKbQcVJ5EsY9A901hJCWnsvRNoW+tzEgMtZRMlZrCfBir/bg+6DeVgY/zggOhjn
         4fTjZ5DZfknKcX8y8fvjxedgIuPzAVkyT/zmxiY7hEES+R+fPgE99mtMFl8HgkcrLXIu
         ICdtFyb2jPy7ZWWnJ2u2ucLuT/m+PibxMwv8sCoFDBG40MnWUopodRnmJCWiY1bcnqzN
         HMEvbF5LLSPsXX8bSlw7O0TBsvoD51ZXrazGcftqZn0pMXgYtyGTXdlSD3PgqKtu5Riz
         nCOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqzs+vy+9wkpY82DZS24/4Pvl6duq43ddU/6o4Eab7kTO7TsAPgbr1OhsaaJZXVGfUuja0WiUbPSZ6Ou/25D/OznjAhdHi
X-Gm-Message-State: AOJu0Yx17/4KiJPbNe5nVw6zUXwkvA6B37XT6xJcQrRNCrvWicwlBc1a
	UEgIRFAi4JP8H+n4g9RKSZhv7M4KW5avoxSIUKnH4zkAZs3q/sUOVJG2cFC5VgVxwyN9jkRSWo/
	6zGuhebv4lQ7+KCPYE+hLntWSASGAEawPYa8Apg==
X-Google-Smtp-Source: AGHT+IFUrSspS0uEXi4Mtdf0lWq2f6Bt6/664idaePnQ5n7gs/Aofr4lkRbBJPYECBaOux5ZgxpPBc0T/C/GsKmHDRA=
X-Received: by 2002:a5b:104:0:b0:dcc:ec02:38b0 with SMTP id
 4-20020a5b0104000000b00dccec0238b0mr8733778ybx.64.1712060727251; Tue, 02 Apr
 2024 05:25:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327160314.9982-1-apais@linux.microsoft.com> <20240327160314.9982-3-apais@linux.microsoft.com>
In-Reply-To: <20240327160314.9982-3-apais@linux.microsoft.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 2 Apr 2024 14:25:15 +0200
Message-ID: <CACRpkdaSBGe0EFm1gK-7qPK4e6T2H1dxFXjhJqO2hWCm1-bNdA@mail.gmail.com>
Subject: Re: [PATCH 2/9] dma: Convert from tasklet to BH workqueue
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org, 
	vkoul@kernel.org, marcan@marcan.st, sven@svenpeter.dev, 
	florian.fainelli@broadcom.com, rjui@broadcom.com, sbranden@broadcom.com, 
	paul@crapouillou.net, Eugeniy.Paltsev@synopsys.com, 
	manivannan.sadhasivam@linaro.org, vireshk@kernel.org, Frank.Li@nxp.com, 
	leoyang.li@nxp.com, zw@zh-kernel.org, wangzhou1@hisilicon.com, 
	haijie1@huawei.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	sean.wang@mediatek.com, matthias.bgg@gmail.com, 
	angelogioacchino.delregno@collabora.com, afaerber@suse.de, 
	logang@deltatee.com, daniel@zonque.org, haojian.zhuang@gmail.com, 
	robert.jarzmik@free.fr, andersson@kernel.org, konrad.dybcio@linaro.org, 
	orsonzhai@gmail.com, baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, 
	patrice.chotard@foss.st.com, wens@csie.org, jernej.skrabec@gmail.com, 
	peter.ujfalusi@gmail.com, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, jassisinghbrar@gmail.com, 
	mchehab@kernel.org, maintainers@bluecherrydvr.com, 
	aubin.constans@microchip.com, ulf.hansson@linaro.org, manuel.lauss@gmail.com, 
	mirq-linux@rere.qmqm.pl, jh80.chung@samsung.com, oakad@yahoo.com, 
	hayashi.kunihiko@socionext.com, mhiramat@kernel.org, brucechang@via.com.tw, 
	HaraldWelte@viatech.com, pierre@ossman.eu, duncan.sands@free.fr, 
	stern@rowland.harvard.edu, oneukum@suse.com, 
	openipmi-developer@lists.sourceforge.net, dmaengine@vger.kernel.org, 
	asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	linux-mediatek@lists.infradead.org, linux-actions@lists.infradead.org, 
	linux-arm-msm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mmc@vger.kernel.org, 
	linux-omap@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, linux-usb@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Allen,

thanks for your patch!

On Wed, Mar 27, 2024 at 5:03=E2=80=AFPM Allen Pais <apais@linux.microsoft.c=
om> wrote:

> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
>
> This patch converts drivers/dma/* from tasklet to BH workqueue.
>
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git for-6.10
>
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
(...)
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
(...)
>         if (d40c->pending_tx)
> -               tasklet_schedule(&d40c->tasklet);
> +               queue_work(system_bh_wq, &d40c->work);

Why is "my" driver not allowed to use system_bh_highpri_wq?

I can't see the reasoning between some drivers using system_bh_wq
and others being highpri?

Given the DMA usecase I would expect them all to be high prio.

Yours,
Linus Walleij

