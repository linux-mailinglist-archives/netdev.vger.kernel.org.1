Return-Path: <netdev+bounces-143520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A27A9C2D7A
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 14:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4149D1F21D54
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 13:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77C8F1957F8;
	Sat,  9 Nov 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wi7HRDRO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5875E192B9E
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 13:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731157676; cv=none; b=tpygvvAXmBb3zImql77g1Zhs1GTAKcIGgIVYi0tUyHgxRUi1sKRv4KY1iGT4OoNcLHLsHs2p03xx9/cqUCpospwzzFsRs9NwY/t0eNLshWptWOUPQkr6taeaQesP6aReSSacXVJSN9/gTsY+pSjjfIALWLJBRbSwz9U/+SBXazE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731157676; c=relaxed/simple;
	bh=4llUVsB89r/UQUHdc05QEHjc9Us1oVc4Ce4M+551BRY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bO6hcFP3Kfx19cw58GluqpdJmCs35/23bEXhU7BRCkiObHUNP5v61QEocEKJecsAiKANHxAY1DjAb+HmmODhypUKyDOiCfNfsdmZoLk+1teeXX90cbVkovG6Jvns9CnN7JFj0QdO1AU0nuGMDycdZcoDBnXICNsM4Ro4J2UdBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=wi7HRDRO; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2e2b549799eso2566803a91.3
        for <netdev@vger.kernel.org>; Sat, 09 Nov 2024 05:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1731157674; x=1731762474; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4llUVsB89r/UQUHdc05QEHjc9Us1oVc4Ce4M+551BRY=;
        b=wi7HRDROfnwWy+lDGBR93BBLQbq9TfXTpkcyNpKCN+yC01WhZplmzdWTFd37G6ma2t
         ss5Cln3Ce30xRcKOkN9enEp8NsBXRabSieUQRZ04hpWE90m2PyqkCDO1OHdhMw2CbYh/
         7CoSyUWlrqDiRW5UIXym5KhyGxSHS1F7ckoODI3JjlU/C40Owe0HLPWLoqJ3JoE8WCct
         45DC7mp2nXXiSzBKxeFwNSsOet6QOwFxzSgdUA7BokHFs288y8a6mSTcWjWgl9bioC+c
         PFDA79KjhJTBql2C+xvDMDWY2qC3P3F6nGdPF7Qx404mYhF0kYs9Yinhi72nb8Q1v/f7
         Mujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731157674; x=1731762474;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4llUVsB89r/UQUHdc05QEHjc9Us1oVc4Ce4M+551BRY=;
        b=HIYdxE9P5pZBx5iGTCNc+8WIIAc6gvX5G+log1y1uFNfRs4lRFbeeldsRSJyZklhUi
         ic+nZKz39eCP8GQXf+e8W8EpeONxsTCMzYkdn0w5vFWwHFH5jKzQiWz4XW6yTQ29ReBP
         ZoTquBKEpm3eNo69RBKSx7G+2JHN2ARQUZ+SE2zX2Mmv+UF7LHDR/j0Bg/POQQN249kw
         owmCRIZADMDMqn2jy8NWNM/6llqttr4AAQAtwq+MjtL2CQuyRYOGCcBtCNxa3mrlW6/Y
         gYz+W2Qm5N2fSl1gZ1zMFZ6F9MZQx6CSsZL9jsM0ZRZYubORwTrek/uahxAaF9Y9iv2O
         rCSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAlcG1TUlWYwYIdU2RmK7xLLuzep/7XGfVEdiT6AOa6knVsJuvu9ZGXbZQ43XkVH6dDC6Z1cU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzphO6DxWa+lLA6N/Pzzjnepf4t36IgPr0Y6japSqJbjowM5p4
	LCKi38m0qSjNfV94gRXAZC4YAjDlfMO51g6priQt15zto3E/rrpgCcLi3Md4OgANwDtjZFShZ/j
	jiOyGtignU0TthHYK78sWPOCC5z6uPRBgm2Rz
X-Google-Smtp-Source: AGHT+IEs2t/ORZ8yf16HMnZQ8zIDLfkw/hfBlmXZS+4PeYEQLudnF8iiQVPICb4XXSpddykk7UV0Wiebi38fnRhfE10=
X-Received: by 2002:a17:90b:5250:b0:2e2:e769:dffe with SMTP id
 98e67ed59e1d1-2e9b1773bf8mr9014129a91.30.1731157673723; Sat, 09 Nov 2024
 05:07:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106143200.282082-1-alexandre.ferrieux@orange.com>
 <CAM0EoMmw3otVXGpFGXqYMb1A2KCGTdVTLS8LWfT=dPVTCYSghA@mail.gmail.com>
 <CAM0EoMknpWa-GapPyWZzXhzaDe6xBb7rtOovTk6Dpd2X=acknA@mail.gmail.com>
 <7c4dc799-ebf6-47fe-a25f-bb84d6faa0cf@orange.com> <27c31e30-b2d6-43a4-8ad6-adbeb38db9ee@orange.com>
In-Reply-To: <27c31e30-b2d6-43a4-8ad6-adbeb38db9ee@orange.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Sat, 9 Nov 2024 08:07:42 -0500
Message-ID: <CAM0EoM=yX4yWrSrxU4PxVje9E-Qh1GcXkwWRqLybNmQhLXEaHg@mail.gmail.com>
Subject: Re: [PATCH net v3] net: sched: cls_u32: Fix u32's systematic failure
 to free IDR entries for hnodes.
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: edumazet@google.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 6:14=E2=80=AFPM Alexandre Ferrieux
<alexandre.ferrieux@gmail.com> wrote:
>
> On 07/11/2024 23:58, Alexandre Ferrieux wrote:
> > On 07/11/2024 15:47, Jamal Hadi Salim wrote:
> >> On Thu, Nov 7, 2024 at 9:45=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.=
com> wrote:
> >>>
> >>> Hi,
> >>>
> >>> On Wed, Nov 6, 2024 at 9:32=E2=80=AFAM Alexandre Ferrieux
> >>> <alexandre.ferrieux@gmail.com> wrote:
> >>> >
> >>> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >>> > Signed-off-by: Alexandre Ferrieux <alexandre.ferrieux@orange.com>
> >>>
> >>> I'd like to take a closer look at this - just tied up with something
> >>> at the moment. Give me a day or so.
> >>> Did you run tdc tests after your patch?
> >>
> >> Also, for hero status points, consider submitting a tdc test case.
> >
> > Hi Jamal, thanks for looking into this.
> > Just posted a v4 with a tdc test case.
> > Of course, I also verified that "tdc -c u32" has no regression :)
>
> And a v5 with a proper title as requested by Eric, along with his Reviewe=
d-by.
> (Sorry for violating the rule "one version per 24h" but there's no code c=
hange)
>

BTW, what is your interest in u32? I am always curious about use
cases. I gave a talk here:
https://netdevconf.info/0x13/session.html?talk-tc-u-classifier

cheers,
jamal

