Return-Path: <netdev+bounces-111501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE4F931643
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9051D1C22235
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9658A1E861;
	Mon, 15 Jul 2024 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGWqLs9s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239E1E4B2;
	Mon, 15 Jul 2024 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721052014; cv=none; b=kXipbIevG5gyHpKpxLW318CqztdGc32uaDzd8xJ4Rgd7ypH91qIhUyDUScOe5aLVNoysZ63BNPuCNnW9ja31a+/3t3rKrR8SagwMhe6tKQ8CvXFGUrYrzKzLUzDmqZC4eiBjpGS8sFNOAEgPvMffF53XYQlDVI5atNzf4A8hxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721052014; c=relaxed/simple;
	bh=cYNMMXJNQ6K3pYS1CyeAn7PQPp0dduaDhVBQ9o9mykI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HjaSxo4KHGw8kLX0DzUIZiE+cG8CbXl44mBe7Q7Px6EUytWGwKfJGG4YyNaLNYoNgf8BY3zxxfosCSOpkGubxF1Ker0Z+LfGT/mP3PPWQHlB2EFpc2h/PCnfxKBnWI6NR5859tWg/C+R5N9GTkxKrrSiAT3yi67kuItVl0Z+R34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGWqLs9s; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52e9a550e9fso5256264e87.0;
        Mon, 15 Jul 2024 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721052011; x=1721656811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bn4G4brw9udnRBDw/Bbw9ySIPLm1PcS3eVqaufETezI=;
        b=lGWqLs9snjnA4fI3xCZg+bSyq/CVBbac17CvVN2vtpbyCvQyz1i8X9VYAeGFn1S9IV
         WHsBqC3BYoR0plZHGv94YXhiPaarJuztVURCyPseckv/FxvE6jojhGiVuTZ9lgLT79oJ
         8csUaf9cITPJPeKLwvaPJdUxDqPWR0CQ2r2RrlFLse/DdE6NgaoGSj88uR0eLAQmjSwU
         u+qkm8NyVvJ6Hf3vB0INp7/Z8NfKH1Ymtc/5eEPH6LXUESf/Y+HdVeA2gOHelwFV/vpb
         oCJsoOZXlID8ToN7meAefjDDZrzsr4dfKviKunct+ukbGFlChpCjvORxbvC/2u3zuNCE
         774g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721052011; x=1721656811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bn4G4brw9udnRBDw/Bbw9ySIPLm1PcS3eVqaufETezI=;
        b=XPmsCFt0FoO4ov4TjVRcjXGktCrF6jM1q8Zt6nDyK8LHRazq7LYiYyPkq1UMjhbCg0
         IpDkqfYhQ6AHYD4yskFfEDH6Zp1/qWhz0oebZFbIENoa4LH0obPHfztLCfu95kgxNQAl
         zFpvrmfqWMRS9YOGYVl+cBALhR+PajoHBQSaQd6nz2+9q5b7MmoC0Iezk3+FpGWZauUl
         5CMGZMT2XyF+WD7j1kkI4BZzLtHYCsSvZKjQakh2aKkTZ4v67KUpUk4YPuxo4HQmRmgm
         O7Vh7d/qrysye1jS3ETn6DvSrRtKlWdPgfqBOxB72NSXq1hjNPh54l/5fBTD+CsxWNka
         /t1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYzWT/NcqxS0cOH+maL0BCLKeD19Q0ZU/6gWYF2dt3ExLoHaszTWMbBaEiNjNgjOPYdrakzjzU1dcua9l9EyXlJonf6gbjFyGpoEVzfPjyOIhmxY9t+P08M3gFSuDYz2+jXydMMJDz
X-Gm-Message-State: AOJu0Yx4/+ZEmiGdlYaKWPJ40VF4xud1VVmrXtgYqeLA1Fcd3bYsw7Yt
	ggfVeSUyklSKivruAVw/8PpBBwbiuJn7GYIiAS8/D9rruukRIlJbqwZSBiJdcPdP2/BW7px6v3k
	8WACcpx6TAOZ0lmyzgsJDmrn/zaw=
X-Google-Smtp-Source: AGHT+IElEmWXblvhI4xeOFveXJji2/Q6Oxj2vUS8hwteYcCZLorKtw8RXhKgzNXyNoU8G/jGWY1lBqUW8XF5lVqHsyg=
X-Received: by 2002:a05:6512:3baa:b0:52c:9820:5e52 with SMTP id
 2adb3069b0e04-52ecb6a2f34mr3000406e87.27.1721052010664; Mon, 15 Jul 2024
 07:00:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
 <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
In-Reply-To: <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Jul 2024 09:59:57 -0400
Message-ID: <CABBYNZKudJ=7F2px9DYcqgpfEJX7n1+p4ASsH24VwELSMt8X4w@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bartosz,

On Mon, Jul 15, 2024 at 9:56=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
> On Mon, 15 Jul 2024 at 15:49, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Sun, 14 Jul 2024 21:57:25 -0400 Luiz Augusto von Dentz wrote:
> > >  - qca: use the power sequencer for QCA6390
> >
> > Something suspicious here, I thought Bartosz sent a PR but the commits
> > appear with Luiz as committer (and lack Luiz's SoB):
> >
> > Commit ead30f3a1bae ("power: pwrseq: add a driver for the PMU module on=
 the QCom WCN chipsets") committer Signed-off-by missing
> >         author email:    bartosz.golaszewski@linaro.org
> >         committer email: luiz.von.dentz@intel.com
> >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.=
org>
> >
> > Commit e6491bb4ba98 ("power: sequencing: implement the pwrseq core")
> >         committer Signed-off-by missing
> >         author email:    bartosz.golaszewski@linaro.org
> >         committer email: luiz.von.dentz@intel.com
> >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.=
org>
> >
> > Is this expected? Any conflicts due to this we need to tell Linus about=
?
>
> Luiz pulled the immutable branch I provided (on which my PR to Linus
> is based) but I no longer see the Merge commit in the bluetooth-next
> tree[1]. Most likely a bad rebase.
>
> Luiz: please make sure to let Linus (or whomever your upstream is)
> know about this. I'm afraid there's not much we can do now, the
> commits will appear twice in mainline. :(

My bad, didn't you send a separate pull request though? I assumed it
is already in net-next, but apparently it is not, doesn't git skip if
already applied?

> Bart
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-n=
ext.git/log/



--=20
Luiz Augusto von Dentz

