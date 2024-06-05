Return-Path: <netdev+bounces-100795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C161C8FC102
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 02:54:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E928B23678
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 00:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDF728EB;
	Wed,  5 Jun 2024 00:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SX8/4W+P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A269804
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 00:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717548884; cv=none; b=pgyH62hzQz8+87HKF9luiu3O40qck9lkLrP6xwH9iccfyvFjLeljaoMw343rjusEVmROpmUZxmNGcdQdiXNb+j9Ysh46dCndxkef7iSZ38TWLpkHkEu9ULtXS+Kei2W6Pt6z7kC5f2Sygt5nGhsVE/ADwR6UlO1rJczTh1VwBcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717548884; c=relaxed/simple;
	bh=ELFtQI28CDmj681A4xOEs5XCfOhTeUAjWt1q/p4lq6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ven0aHqzdAAJw33eC+A0AUzZn2FNaihu99BzFqZDx3bI2ubfajRZKFX/Am5+qyJvDhGV6KzAqAe7lTCOGx7lck5MVV36WSyntm4Ydg55gqQqYK2btwWV9peIEepIq6Wyr+hn7RaonEb58Yo+J+XSUtcINIMcDzPwPHe2QfccbjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SX8/4W+P; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-52b90038cf7so5103030e87.0
        for <netdev@vger.kernel.org>; Tue, 04 Jun 2024 17:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717548881; x=1718153681; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELFtQI28CDmj681A4xOEs5XCfOhTeUAjWt1q/p4lq6Q=;
        b=SX8/4W+PFjNtQoIySm34JC8XlgP6UcCRCOS8OmpOCURbLV+b+q9SSr0BptEcKEhwOS
         LiUXZrmDjcGHvVL31u6CgXXq4o2HqoMYs9SDIT6lb82qXmtdlciyTx6h5xk+ceFch7OE
         2sHniI3yohaQQB1VXk57JxjTEPV1xK6ebD5oY0k0Mas/5D7JEUHL+bVrJkK4KRHPm4c3
         mbuQKhOLCob8nigs6PqHRYFnsSCWYajZ6WjRwzM51R7hOHPSFUY+w5hS65kzCcxiCpKp
         Zl1jXE5RPnFyjzVmAOqHGloaJe8+AtUIHrcjg4wT7TdxFhIkxl9jwvI7un3U5abvr6oG
         fpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717548881; x=1718153681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ELFtQI28CDmj681A4xOEs5XCfOhTeUAjWt1q/p4lq6Q=;
        b=pLnM5hGBG0VakbBZrrYhLE9oHWpj3qJGQx4YQqlE2FWOAfkklmDMP1EESAVYVt2kHg
         35fJsMWzhVZ7XqNW+tBfLZg2RDtJNlqqlgFLcky9jib0e76AOCehS73M+ptwwHNpO/1k
         a5Dj8aklyjT7X14v/qM8hv0F5BoQB1+ZcsxwBFYSV3Ob4UpnTKECfcisGjiaAdUzfVbW
         f4E7b/Y2wGCXhixkBrfHX3rhmAhWvMa1s6qsS5eEHhPIKqyl+VSHETyGW2vXysDnB/tg
         21634WoQ+Ky7Cp0Jb46ecObmUUfiQHMLswKx0ZcSaOJswftGWzTSMpkKP9p4I1AkHZvW
         iIUg==
X-Forwarded-Encrypted: i=1; AJvYcCWFtOjFk8UDnh6p8MYzAukmjcMgX1l/5J/GC0au1NelPb9mvIOGSxd+kDr8HubiVy7rhwqIM+zGVieV4jOISzxrLo0qquhh
X-Gm-Message-State: AOJu0YwAhL8prYgjFYGuggbuxQ8HsOALhCTq4Yju57GD9tT3YnA72vsl
	Zv80vlGnBX0+p0PoWM9WAWv+d087tlRj5T0KG3pt9moGxjKJcm+uJTd79YRhsYuusgjrfzqNlJR
	irAi6kSpPf+GKps/9RsiLYwXT+iM=
X-Google-Smtp-Source: AGHT+IGYzc8kHUiZFUukJhh1D0urbz7L9gQ4FJMjlePBtYM68CtYr17DGtBH8+gdzqcFKpOLDoGEyz8pt1PsA7SutrU=
X-Received: by 2002:a05:6512:3ba7:b0:51a:b933:b297 with SMTP id
 2adb3069b0e04-52bab4b1187mr697580e87.2.1717548881153; Tue, 04 Jun 2024
 17:54:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531164440.13292-1-kerneljasonxing@gmail.com> <20240604170357.GB791188@kernel.org>
In-Reply-To: <20240604170357.GB791188@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Wed, 5 Jun 2024 08:54:03 +0800
Message-ID: <CAL+tcoCCEdLEOJj9G=3nxTeCHarMhFbh9KTLHKLDVWfhqWXy2w@mail.gmail.com>
Subject: Re: [PATCH net-next] net: allow rps/rfs related configs to be switched
To: Simon Horman <horms@kernel.org>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	davem@davemloft.net, dsahern@kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Simon,

On Wed, Jun 5, 2024 at 1:04=E2=80=AFAM Simon Horman <horms@kernel.org> wrot=
e:
>
> On Sat, Jun 01, 2024 at 12:44:40AM +0800, Jason Xing wrote:
> > From: Jason Xing <kernelxing@tencent.com>
> >
> > After John Sperbeck reported a compile error if the CONFIG_RFS_ACCEL
> > is off, I found that I cannot easily enable/disable the config
> > because of lack of the prompt when using 'make menuconfig'. Therefore,
> > I decided to change rps/rfc related configs altogether.
> >
> > Signed-off-by: Jason Xing <kernelxing@tencent.com>
>
> Hi Jason,
>
> FWIIW, I think it would be appropriate to also add help text for each opt=
ion.
> And I would drop "Enable", modeling Kdoc on, f.e. CONFIG_CGROUP_NET_CLASS=
ID.

Thanks for your review.

I will adjust as you suggest in the next submission.

>
> Likewise for CONFIG_BQL, although that isn't strictly related to this
> patch.

Yes, I can see. I think I could write another patch to do this since
currently I would like to submit a rps/rfs related patch.

Thanks,
Jason

