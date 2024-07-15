Return-Path: <netdev+bounces-111520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9415E9316B5
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 16:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07DB8B21BC9
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 14:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508EA18F2F0;
	Mon, 15 Jul 2024 14:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBIJgfyc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC41418EA90;
	Mon, 15 Jul 2024 14:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721053714; cv=none; b=Lpc4Tf3JvbBrxZmiYf18TtcFqtkYZFcxQS3B9ekYhcNrCCtuMWYKugcADrrIZJvoXLtcsjSBmyJRo9n4H1wxetyKcqSfKqsccvWFPhNnxc2m5cn4eRwkoly3V53KNiIzQmS9li2MFmYcoddjMONb01E6ccN2bCf0jjvyj5t5DFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721053714; c=relaxed/simple;
	bh=8VEqa6vxVMDdBt2wx0riyc8t0sA76JMatjiYg9xk//4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyfxDsX3W4IaMwLVOt1VXfXvtUpd44cPnwS/uM+gc9JKA2Z6WHqwgZCuPd6LKVkRU8exfqKbkGycctoJq2aJAVG+vkCMpiROyjO2u+mAaUE6uJNNXyttlZAFLWHb3nOuDqAdOaSBUPoeL7IiiSZjZzGTt6f8DoRTLnqAz2jGnsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hBIJgfyc; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-75a6c290528so2590557a12.1;
        Mon, 15 Jul 2024 07:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721053712; x=1721658512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7ETV/86uAdJX4NPKeACWFXwS4pyIbf8iFwosUlQCFo=;
        b=hBIJgfycM8MJ/7+GQ9GIZaZUwTLMhYQoOlTvE5FdUdtxAqVHhfTZ3hNP2F06zpIEyk
         oFmZfvxSPJh05ckTDOB+4/TagYHOy8Le4LKmtxoGM0dkojFuxwMz2RtvMU7JxXBVmmKw
         s80SGETj8MX5k3pyybI4rFsKN3HC+ZA3/zb9j/0wZgd4U1bh99Fs6Z6lnAdZftCtvwse
         bZjddEmnP3Je8WMNO2WzII1Plm1CKHQ/SaHD1X0NsbM+xcRbCnRojJh0o0nbsW+F8oQP
         BzkE4NGX9sndazWzAaUvDmDcdKWIxfaj3ZN83fV3L2+CIlWbaFDVw/dcLRo3pzr6ucE+
         NwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721053712; x=1721658512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7ETV/86uAdJX4NPKeACWFXwS4pyIbf8iFwosUlQCFo=;
        b=lwfda242bpYzfVro2XfrPdpgVLV/NhpRgsxgup8lUS7JxnvncP4keMbsLbRSH+WMee
         1oZYKEK8Qs8falkZrlniFRicJL2LJKH0OvdDbjwDzrgSjZHLIbncN+xU7MY9Qhj1mXST
         blytGjswYDCVHZOMQ70Do2VETq4/zfYe+lrfMemayrdywUpwN7UpRl71EWsu94TgwTmt
         GKEX0LKLI9BXtDeYhgA5nuQPSs3dZPlRSRh5HoRUkqRvMsWH+CTApJDpJJPf/4Cm3CzI
         EZ+LJISokmBSQOc6xWWK3CCRy1q6oSmOKEkNGLrGka7ARptdZWHxcTEs6M7K6gxR97ZI
         23+Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1cx4RaGXZ1vUItWUxqrLXuXphECh881dUZ9Lo8CexnR9etuWWxsAJ376Q3EZK3jr1HrGEEvCnn5Y9cD686oRxVxA0qHyax4UL3drKkf9hmpslrMY5voJXT2dbkxnsB4sx6Q0QgV5p
X-Gm-Message-State: AOJu0YzIuUyPd41t3r3ttB6BXn/AVokllLiFvyvqObWY3ruLq5BVLvzV
	086NQzsmszADOfS8SYWUqThgke6tLWbvNKuERtQO3x2gXbxvtrHVWEPnfM+SYg2YT8pPuBSBwMq
	M3rLT44a5CA8+Fs5cZUlA938Twso=
X-Google-Smtp-Source: AGHT+IGpgo0QPBc3Zri/ujHKzvW9tWGEocT7AqeW6aJSRJ3BwlO4ViM0azijyR+5HXZKyvPKp1EA8lNzvpJslV7lu70=
X-Received: by 2002:a05:6a20:748a:b0:1bd:1e06:9dba with SMTP id
 adf61e73a8af0-1c3ee564045mr91386637.27.1721053711955; Mon, 15 Jul 2024
 07:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715015726.240980-1-luiz.dentz@gmail.com> <20240715064939.644536f3@kernel.org>
 <CACMJSes7rBOWFWxOaXZt70++XwDBTNr3E4R9KTZx+HA0ZQFG9Q@mail.gmail.com>
 <CABBYNZKudJ=7F2px9DYcqgpfEJX7n1+p4ASsH24VwELSMt8X4w@mail.gmail.com> <CACMJSesSpm=C67LE9Nn+fBS_JLZgzA_h-ocnPGy_wqzy8vH70Q@mail.gmail.com>
In-Reply-To: <CACMJSesSpm=C67LE9Nn+fBS_JLZgzA_h-ocnPGy_wqzy8vH70Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 15 Jul 2024 10:28:18 -0400
Message-ID: <CABBYNZJJZp1Ge5UJS9SgR+YrYVA_-fLaM_Ft_51a3Bz+Q8JJWw@mail.gmail.com>
Subject: Re: pull request: bluetooth-next 2024-07-14
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

HI Bartosz, Jakub,

On Mon, Jul 15, 2024 at 10:17=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@linaro.org> wrote:
>
> On Mon, 15 Jul 2024 at 16:00, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Bartosz,
> >
> > On Mon, Jul 15, 2024 at 9:56=E2=80=AFAM Bartosz Golaszewski
> > <bartosz.golaszewski@linaro.org> wrote:
> > >
> > > On Mon, 15 Jul 2024 at 15:49, Jakub Kicinski <kuba@kernel.org> wrote:
> > > >
> > > > On Sun, 14 Jul 2024 21:57:25 -0400 Luiz Augusto von Dentz wrote:
> > > > >  - qca: use the power sequencer for QCA6390
> > > >
> > > > Something suspicious here, I thought Bartosz sent a PR but the comm=
its
> > > > appear with Luiz as committer (and lack Luiz's SoB):
> > > >
> > > > Commit ead30f3a1bae ("power: pwrseq: add a driver for the PMU modul=
e on the QCom WCN chipsets") committer Signed-off-by missing
> > > >         author email:    bartosz.golaszewski@linaro.org
> > > >         committer email: luiz.von.dentz@intel.com
> > > >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@lin=
aro.org>
> > > >
> > > > Commit e6491bb4ba98 ("power: sequencing: implement the pwrseq core"=
)
> > > >         committer Signed-off-by missing
> > > >         author email:    bartosz.golaszewski@linaro.org
> > > >         committer email: luiz.von.dentz@intel.com
> > > >         Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@lin=
aro.org>
> > > >
> > > > Is this expected? Any conflicts due to this we need to tell Linus a=
bout?
> > >
> > > Luiz pulled the immutable branch I provided (on which my PR to Linus
> > > is based) but I no longer see the Merge commit in the bluetooth-next
> > > tree[1]. Most likely a bad rebase.
> > >
> > > Luiz: please make sure to let Linus (or whomever your upstream is)
> > > know about this. I'm afraid there's not much we can do now, the
> > > commits will appear twice in mainline. :(
> >
> > My bad, didn't you send a separate pull request though? I assumed it
> > is already in net-next, but apparently it is not, doesn't git skip if
> > already applied?
> >
>
> My PR went directly to Torvalds. It was never meant to go into
> net-next. You should keep the merge commit in your tree and mention it
> to Linus in your PR.
>
> Bart

Should be fixed now:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3Df497862d99ddbf4e46d6e26cd0f40adb724f55c9

And I made another tag for the pull-request:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tag/?h=3Dfor-net-next-2024-07-15


> > > Bart
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetoo=
th-next.git/log/
> >
> >
> >
> > --
> > Luiz Augusto von Dentz



--=20
Luiz Augusto von Dentz

