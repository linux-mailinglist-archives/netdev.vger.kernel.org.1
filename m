Return-Path: <netdev+bounces-129082-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC23D97D5F3
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 15:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90EA282E25
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 13:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB9BA155758;
	Fri, 20 Sep 2024 13:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uoOJ5z01"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB39B152E1C
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 13:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837526; cv=none; b=EucHrOb9jgOIQUywWRJFgjOia9/GOtXx5i2/8QD9zoeSHFHgnV+olPrJRhMCllubFAmFBLa6degDKQH5iPOQItfveSwvGcJyO9EqBgK92/bZujSXJsY0j8ApX6AHFQrxcS7HEdDdutOP1WFgtXe7pRVX8VmSqw0Nrbs3DSwPCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837526; c=relaxed/simple;
	bh=MhKUXU8aVOz6mueF2hWqTdMNAcMdiaMDtIq3mhIYgXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q619IBRAADx2kiXkvrZ1N/Y8XSRZyWd+uU6hwL4RGFygtVrWtbN3Dsqw33QKMF/sJ1hMS+v/pnhbyYCQkzD00Lr0yyeqBcw9VeJx4da05+9A+nU4Y8JgwjaDi+MDLMIM2nWHg5gI98YMwhhFEq0/ETeBBihOq/whktFw71JG8/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uoOJ5z01; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6de05b9fd0bso16702117b3.1
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 06:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726837524; x=1727442324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6YEquTrr3D4weJB4MW0VXORo9GFIbDg2nyF/E+4fEXo=;
        b=uoOJ5z01wkXZYhLA/6cKPkDzB4pOx4LKefchP0r+UfKGXiTtj5H/gYQ55VVDcL6yrX
         DV+BBWA8Y0E7UIPfnvUhEu11oVO0a4HPZHQyx3Ubtj+kVbmisItEjF2GAdSTFp/qv1/9
         0bsgmnZcW9K6rh6Zc7VboGsjy9K1jFXZ2lqtQv3VBp4MZnBbF7UmE8FJbRRIZVPfWq3g
         b4X6fvczRsUHArauHWJjOxK3ayjP/nzEj4bGvHuMvpSBwcAxGU1RCUof6Woit3CeMy66
         k0rctf+oqf3F5AMPs7WzTAn6b2foVUcmoy6u9o5qMjXAo5n4rEtKRgholoObdaGAqlET
         bQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726837524; x=1727442324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6YEquTrr3D4weJB4MW0VXORo9GFIbDg2nyF/E+4fEXo=;
        b=sUuGyaSTZ5LPYIM9FTCbibJhD5fZyYTfkHdzz1s96FWxmNdvCjnfI07gKYlN9mls/i
         3ogV0Egi0AMpZvsl6lifdNB1K8Wk1TEuAmFMGIuHcaJvxQI1DlqrvpznaI2MpptwZ3+s
         Df2er9tIj5qhPEYIr5orZjJkGdh2itqgqIOeSr8XoTjPwfgYYq94kWuNTZBufajI9sQX
         tEFZBoRbPMufx18u7R8XvyrSPz/RfXHgUOTbZbynKvVTvK9j27OxdvpFh5Cad13xdEgc
         7FEhdbuXC53fVEeLcKE4BRKDeZTWw8pUd7VlzIIY1svNPf7UKb+25xJIX3TroiFyyVor
         izog==
X-Forwarded-Encrypted: i=1; AJvYcCXnw5DeWFm41C5hLsp/X0lXgZPdhScyYnE3v03g8sGeNFQQhnLvGbqaaVAEjtF5i1JBpw2iGjw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc1wK9pTm79qOFxoEQJqP8JF6cBvv5OCBBohySYlrG9iDb5iDi
	gVoighT8uxAkC1bZGbiKxko7Tmzc9MlUvB498Jp8dCREn8B1ciVILSZRhemIpWvPong7P0Xk1Wv
	KQ5FmRmx4lGr4OB3AN3ajqBk/dogkEOf1LPx+yQ==
X-Google-Smtp-Source: AGHT+IFKCbJqg1izBLWVia90Fy4fDkzUjWsyKtPze4G1zkwbYRTbTYX0+4jTS47kKvWv19AI0ordJdlpG17IMFA2chE=
X-Received: by 2002:a05:690c:10c:b0:664:4b9c:3de with SMTP id
 00721157ae682-6dff282211fmr18456407b3.13.1726837523708; Fri, 20 Sep 2024
 06:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920100711.2744120-1-ruanjinjie@huawei.com>
 <lqj3jfaelgeecf5yynpjxza6h4eblhzumx6rif3lgivfqhb4nk@xeft7zplc2xb> <Zu1uKR6v0pI5p01R@linaro.org>
In-Reply-To: <Zu1uKR6v0pI5p01R@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 20 Sep 2024 15:05:13 +0200
Message-ID: <CAA8EJprysL1Tn_SzyKaDgzSxzwDTdJo5Zx4jUEmE88qJ66vdFg@mail.gmail.com>
Subject: Re: [PATCH] net: wwan: qcom_bam_dmux: Fix missing pm_runtime_disable()
To: Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: Jinjie Ruan <ruanjinjie@huawei.com>, stephan@gerhold.net, loic.poulain@linaro.org, 
	ryazanov.s.a@gmail.com, johannes@sipsolutions.net, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Sept 2024 at 14:44, Stephan Gerhold
<stephan.gerhold@linaro.org> wrote:
>
> On Fri, Sep 20, 2024 at 01:48:15PM +0300, Dmitry Baryshkov wrote:
> > On Fri, Sep 20, 2024 at 06:07:11PM GMT, Jinjie Ruan wrote:
> > > It's important to undo pm_runtime_use_autosuspend() with
> > > pm_runtime_dont_use_autosuspend() at driver exit time.
> > >
> > > But the pm_runtime_disable() and pm_runtime_dont_use_autosuspend()
> > > is missing in the error path for bam_dmux_probe(). So add it.
> >
> > Please use devm_pm_runtime_enable(), which handles autosuspend.
> >
>
> This would conflict with the existing cleanup in bam_dmux_remove(),
> which probably needs to stay manually managed since the tear down order
> is quite important there.

Hmm, the setup and teardown code makes me wonder now. Are we
guaranteed that the IRQs can not be delivered after suspending the
device?
Also is there a race between IRQs being enabled, manual check of the
IRQ state and the pc_ack / power_off calls?

>
> I think this looks reasonable, except that pm_runtime_set_suspended()
> should be redundant since it's the default runtime PM state.
>
> Thanks,
> Stephan



-- 
With best wishes
Dmitry

