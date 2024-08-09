Return-Path: <netdev+bounces-117233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DAC94D305
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F6001C2105A
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 15:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C1319306F;
	Fri,  9 Aug 2024 15:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmEOFnP+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761B4198A0F;
	Fri,  9 Aug 2024 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723216369; cv=none; b=CZ+HaCXaBhD9lXlDK7POGTZlY6ZW20qy7uSZNh8V2fEzKhT2O3oy6kKPlkKjjw1cb47kIC4XlVFxFmyI+Sjv/of8A78mnj1C50wjCvUWEixkg7DT5T0fGyoIK2w/FGXQuxbyFxPnh8Sog1ge+sma29JaGVtf31XODmDQQ7JuLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723216369; c=relaxed/simple;
	bh=Vz2Xn62BadoSy9qvioaFz/jyifvDzrIwZmkq+/R+lvE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2L7GKXI+Ykti4Fkax5HMW0Yc44/171cvyu2o4R6PBludV99I4CT2YpLkpas0AZh2PirJG7auoa7ANixxA3Y/0ge97kUug7XkclMYT07qix5I0sAaKNVBzx8VMbumGUuSnakru35xOkXjRhhjEzs9pmU7rsQhe/mvQmyn+eKCN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lmEOFnP+; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f0dfdc9e16so25846561fa.2;
        Fri, 09 Aug 2024 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723216365; x=1723821165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3m/B0YWsCSBM+y4CXx8HMY+TLnVcXnl7/Yz4G6ZPt/M=;
        b=lmEOFnP+GaEO454+cwgUKIt+c9JMdncf0DR80YdZLxIQfIuOKdLxc1oapN7dLTwAcV
         J6KtX/MNW+onOLp31I64qc8A/65zby9Os8KgPAm8lvh7w9H00Mpa7z1iWJqBpiz5j+l3
         fJVsn6KrQWo4SzorBQHxqdU5pZ2w+MD8kAegWmzbM25NmkhIll5Fal/C6uIlguhoI+U8
         As2yTMfqsTKDAIpPKwxkF2NSdUdApDCqSunKxouX1YBSkN2lOl3tUPn6xY7SvvTJHf/c
         BvxE9+lSFR9aDuWGQbIL5OfB7nzJm9ewkzgym1oaUESBuyCEIylX6lrL7s2C585yAKTU
         tSQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723216365; x=1723821165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3m/B0YWsCSBM+y4CXx8HMY+TLnVcXnl7/Yz4G6ZPt/M=;
        b=RUywfJL1Gf5tB+Fqs9Y48Qrb47zLrNsMl4ZaBRMcvxz58nAotAJNvSvydPMw6GrQ8i
         JkHX/2tdZVgwjqgSt51nHYOoWW10CDZhNEhpDYHo5TspmyC/ydSNX+Bje0nFc1xxxvPJ
         4h5GZKha+YkIANed1ktmWLuYZcLLgmeVvnImsjMAxBNI8JTbPM74SeeAhR0oNKyEUKGa
         1tF2HMtLneWd7/l5kXjglzdhHSCWb5EtV5ue3+U/UIgLV7Zant4LECEBGB9/1LIg5UX4
         ZiBZf632anCiEc5gNOWlUOwT09RC6yh231P9ot0oLLc4D2lWEvBGg6ZmvxDFQ5Ecv7n6
         dGGA==
X-Forwarded-Encrypted: i=1; AJvYcCXGCS1ZUWvhHBqLDxPZ0VFFamIYP1sskxU9HqJjCK8ZVnOY4tfBHp8skR/MM6hjHba/2ioA0hjORrF2qAqJys8PM6LaUlZwwTRFJpmTnoizWxmQF53TkQLAukpKEvEKDSCdHKHm3B+E
X-Gm-Message-State: AOJu0YyqK23dvKHFn6426NZqvprr67uIVel1x04JVb6cYyYQk824h3zg
	7RNOJaeaoS3xHwsy8QXixQV2pzpCZFrzQ/uuJm4Lew+L+oRrcZopalIDcE6JaXKgGktFUDfYxLC
	2wWJ9YBIDWuiALakXyoYVeXebiHQ=
X-Google-Smtp-Source: AGHT+IGeqENLOIscO7R3jtplE+HgeptudAyS2maO3NLsBlYsrl/YUpxOjbujqMGnEgQMW71Dt7vazihJrx5YLbchfGs=
X-Received: by 2002:a2e:a162:0:b0:2ef:2b36:936a with SMTP id
 38308e7fff4ca-2f1a6d415b8mr14801351fa.44.1723216365136; Fri, 09 Aug 2024
 08:12:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240807210103.142483-1-luiz.dentz@gmail.com> <172308842863.2761812.8638817331652488290.git-patchwork-notify@kernel.org>
 <CABBYNZ+ERf+EzzbWSz3nt2Qo2yudktM_wiV5n3PRajaOnEmU=A@mail.gmail.com>
In-Reply-To: <CABBYNZ+ERf+EzzbWSz3nt2Qo2yudktM_wiV5n3PRajaOnEmU=A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 9 Aug 2024 11:12:32 -0400
Message-ID: <CABBYNZJW7t=yDbZi68L_g3iwTWatGDk=WAfv1acQWY_oG-_QPA@mail.gmail.com>
Subject: Re: pull request: bluetooth 2024-07-26
To: patchwork-bot+netdevbpf@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 9, 2024 at 10:48=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Jakub,
>
> On Wed, Aug 7, 2024 at 11:40=E2=80=AFPM <patchwork-bot+netdevbpf@kernel.o=
rg> wrote:
> >
> > Hello:
> >
> > This pull request was applied to netdev/net.git (main)
> > by Jakub Kicinski <kuba@kernel.org>:
> >
> > On Wed,  7 Aug 2024 17:01:03 -0400 you wrote:
> > > The following changes since commit 1ca645a2f74a4290527ae27130c8611391=
b07dbf:
> > >
> > >   net: usb: qmi_wwan: add MeiG Smart SRM825L (2024-08-06 19:35:08 -07=
00)
> > >
> > > are available in the Git repository at:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.g=
it tags/for-net-2024-08-07
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - pull request: bluetooth 2024-07-26
> >     https://git.kernel.org/netdev/net/c/b928e7d19dfd
> >
> > You are awesome, thank you!
>
> Im trying to rebase on top of net-next but Im getting the following error=
:
>
> In file included from arch/x86/entry/vdso/vgetrandom.c:7:
> arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c: In function
> =E2=80=98memcpy_and_zero_src=E2=80=99:
> arch/x86/entry/vdso/../../../../lib/vdso/getrandom.c:18:17: error:
> implicit declaration of function =E2=80=98__put_unaligned_t=E2=80=99; did=
 you mean
> =E2=80=98__put_unaligned_le24=E2=80=99? [-Wimplicit-function-declaration]
>
> I tried to google it but got no results, perhaps there is something
> wrong with my .config, it used to work just fine but it seems
> something had changed.

Looks like the culprit is "x86: vdso: Wire up getrandom() vDSO
implementation", if I revert that I got it to build properly.

@Jason A. Donenfeld since you are the author of the specific change
perhaps you can tell me what is going on, my .config is based on:

https://github.com/Vudentz/BlueZ/blob/master/doc/test-runner.txt

>
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> >
> >
>
>
> --
> Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

