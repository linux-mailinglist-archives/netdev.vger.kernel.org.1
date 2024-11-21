Return-Path: <netdev+bounces-146620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE349D4993
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 10:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 316A6B22168
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1A1CBEA3;
	Thu, 21 Nov 2024 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X3PG1Gv4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400181BC091
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 09:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732180161; cv=none; b=EyuZVDSZlfBsm4m4DUbXMHp2yHtt9A/q6NqALWr/rqTyoGV8ndCgFQpM2xBvbsImakjQ26+UYzTLA+fDu6Rdff6BDAZ29eE8LyJvVwbQeWvAUv7mafwXKmu11JIkgiSaZ2D+/Vm3w+ClWLnU8YgjWj0EUQn2rnlGTI2aBHwHgXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732180161; c=relaxed/simple;
	bh=ZAyrck5tlQevYqpMXOTskbTcJyaWO8Hs8gXBxfr1uf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jT+dIVWgkvPmWnw+0JTdCGARxS9Sp7hFEjieynCv4vyByc4ha5nfgQFdzcIkX4LYZApXuHcJS2ExNiF/803NHUj1caAv3y0vEJhffpU7vQbBlNENvfSyxAUJ/2MPPTCNUPiB1l5/5Yjra71Pe3419Is7yMrNu8Y6q8jcVEWJ9pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X3PG1Gv4; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-296b0d23303so373571fac.2
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 01:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732180158; x=1732784958; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OxHbi6ASfjiq8iEPoZc72oeQ6cf3BdSdOcjBRpGls9o=;
        b=X3PG1Gv4pozV9GCqt4ynVNV7RV23xK1HTQ777xWKR9yvvModLnnDVuf0T9zgxd+tXG
         sVSdH/RnLhRxpH7asqIrkyp77vkmK4WFlaaXJPhQ8bnXvINehE8LWIUIn2RyVriFE5bo
         lwvM/GvTcOMSYuf7kGgQJ02vEvnprNAGtD46DEeEEyE1/+sYYH7CGD8xOTFvgPXlPkl2
         0Is+I3emjxWcHOk32waqVSmF1AvOTwJ726UBECkqpjUDVAaQrDCZBzie+SR96eZxXf7Z
         BRZfnfwTDs264yEwoUoQM7LFtHbvvksevORwbEt0wqYpWurCEVEuQUSsyUCj46ld56Ll
         jlUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732180158; x=1732784958;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OxHbi6ASfjiq8iEPoZc72oeQ6cf3BdSdOcjBRpGls9o=;
        b=GoFJfm5shxZ81qxD7ErXVF2nz5xiciMkjMI7X3qHs8KVSzKNoF+j4jeOSknPLBlvJw
         b/UMcedSUh+W9fytuK1imnXV4QiU3xcmkH5nfQ5I+KsYh5/UWII39Tw5yPEoTuWQUNzN
         11mCmtStOzansrqptDH1M0TKUJb2DutsVjW7DHV2Cwgi8BB2yuPjJDfDB3GGyKb6s64P
         MWmJWV2+bRnezjpAHk8ds9qWXbQ3lDTs71jUM6XuE5LEfVvo6M2BX0LRW9Bg5p7IpdQy
         ntpi4XJkok++iozJ1WxZ58e57K4/jELLCGmnYw9Z8JBnPUPtyOy1h4gJTG9qv5O+UUT1
         lcWA==
X-Forwarded-Encrypted: i=1; AJvYcCVEBAiEclDOZHkvQc8HpwtsiRVPEp8F2ZgkkxuN+phRckr+aCzCNA6EGnZZ3ELjsNBQIEE7kLE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx23eKdO0gZLdt4WhwoLzlkZDn9VeX1Wo6niHkvQyd50QtUPlt5
	2nT/E4EBBlVDdN38WrGr8Hs/fg0PXa53fN6ttwjWuDv4J7Xu9pKx8J3L+Alg6yYZ/9XlykYJYhm
	OCBHqttpagdd5/eblDyjSop30tWSoklBfIT1kiA==
X-Gm-Gg: ASbGncsg1P4wAkMimQk6ELZCm3mqR/0LZ33P7cOOwtO+V04NDzjg709fZ8ub4YCJ57o
	mUpxKBT8sbCakIMFqPKj3xnYVaUCsIQ3zKhhYD1ACETlAFD1//1LcZqk2voxNuQ==
X-Google-Smtp-Source: AGHT+IGlBrhM1he89NTY6gbHyTFxW/0w/9MnZ6DHduJEKWDUclBwVD79cdcU9z96VzKNIRfTYH3d9MO2sG8QjenfPWw=
X-Received: by 2002:a05:6870:d914:b0:296:aef8:fe9a with SMTP id
 586e51a60fabf-296d9affe47mr5902908fac.7.1732180158357; Thu, 21 Nov 2024
 01:09:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120093904.8629-1-jerry.meng.lk@quectel.com>
 <863ba24c-eca4-46e2-96ab-f7f995e75ad0@gmail.com> <fbb61e9f-ad1f-b56d-3322-b1bac5746c62@quicinc.com>
In-Reply-To: <fbb61e9f-ad1f-b56d-3322-b1bac5746c62@quicinc.com>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Thu, 21 Nov 2024 10:08:42 +0100
Message-ID: <CAMZdPi_FyvS8c2wA2oqLW5iVPXRrBhFtBU8HOqSdNo0O1+-GUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: wwan: Add WWAN sahara port type
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Sergey Ryazanov <ryazanov.s.a@gmail.com>, Jerry Meng <jerry.meng.lk@quectel.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Nov 2024 at 22:48, Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> On 11/20/2024 1:36 PM, Sergey Ryazanov wrote:
> > +Manivannan
> >
> > Hello Jerry,
> >
> > this version looks a way better, still there is one minor thing to
> > improve. See below.
> >
> > Manivannan, Loic, could you advice is it Ok to export that SAHARA port
> > as is?
>
> I'm against this.
>
> There is an in-kernel Sahara implementation, which is going to be used
> by QDU100.  If WWAN is going to own the "SAHARA" MHI channel name, then
> no one else can use it which will conflict with QDU100.
>
> I expect the in-kernel implementation can be leveraged for this.

Fair enough, actually the same change has already been discussed two
years ago, and we agreed that it should not be exposed as a WWAN
control port:
https://lore.kernel.org/netdev/CAMZdPi_7KGx69s5tFumkswVXiQSdxXZjDXT5f9njRnBNz1k-VA@mail.gmail.com/#t

Regards,
Loic

