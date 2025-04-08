Return-Path: <netdev+bounces-180317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB94A80EC0
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0216174887
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:45:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95F81C5D61;
	Tue,  8 Apr 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b="VpHcnhLw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E0D2AD0C
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 14:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123528; cv=none; b=H48hgQurMSiF2A8c07t/r/uxsrsmU/0gLAcOCPXV4uASRPlR15vyd6Lf3hEWvEASiNaHSDPSergTuX/YM+PEPtYx4n2XsA8H9NN5KLNe1wrtLGlrzgrOZyeeLOflzECLZeQMkaH5SNqKej8XrYUy9fvyaBCsD0VlyTyjQ2EUD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123528; c=relaxed/simple;
	bh=QYspwtBhVsFSgwIRvDlo0+t6maQ17Xcqzma1ZXsCdVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKqLPQZw8qeWt3cul1OxRG65YVw3m3AJgGLxokBh00TKfypSkDtY5wcYCNrLBs2qWETeRYqvwpQwwKl2MYSKEj27qizrK6VCiyQwN/YktFoPJ7BZlAAObuBHFD1QHO04WFTESrl244nmzr8B5Y9QiFTqZEjVyz03wwyv+bKwVMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net; spf=pass smtp.mailfrom=unrealasia.net; dkim=pass (2048-bit key) header.d=unrealasia-net.20230601.gappssmtp.com header.i=@unrealasia-net.20230601.gappssmtp.com header.b=VpHcnhLw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unrealasia.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unrealasia.net
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5edc07c777eso7333563a12.3
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 07:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=unrealasia-net.20230601.gappssmtp.com; s=20230601; t=1744123524; x=1744728324; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MovUcynSAJffR7RJo4naoiiZN0xmuejMREjzSeCfcHU=;
        b=VpHcnhLwaVR70JotD6QvTGNJ8qTriRDGYolM/NGYYOQDEzKbQIkbnJBF6VACxXKQCG
         ihenfk8Pwqydo6R6AjFKv/0exyenphki/b13RGS5nChjeOeSvJASeg22eiXQUmNnRxfF
         zcj+7C0D+KVYCOHk8W6PbYHRwtalK4HlpG38kDw4/YYlZp85wpFB0I684cvJkT/bdG7L
         8vqGSwoJFyGyudQVuiXa70/Rb3nDLgQLLTM8QPdXTYIVthe6ZO/NDikTJmpI8CM94GKo
         uum9Fmk4lD8dIuoNvzi96uZX3dSvnkO9tMxHlHkd/AF/NcOl+UMR2bb4fGGEygx+f3vp
         2+wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744123524; x=1744728324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MovUcynSAJffR7RJo4naoiiZN0xmuejMREjzSeCfcHU=;
        b=G+oPwTX2wr/j4z3Zo2pdZpEhWaX18lkdo61NaC3UXxa8/GLOMo5qYq9blwlzQff6wV
         pPq2DWyXQnHa2ilqZdEv8eoAbb1kVJ2g47D00U+twyGu3IUQ9f2gldaX9USuY+s34GTr
         7tXUCq8juxPJ9DOxrT/G1D6k3QlI3foxvbbsyx9RByaAxuuC5sZZ2UjJBncIuz0JPUOS
         MUwmxhyFoSq/PEIZLsTsT49RgLKcg3u5JqSVewo1Z0m2paxtFDVoPXEnlHbYOO3tZ2KG
         HEfzhAGOMkY9eiGhFFnhQZiuVK48wU2pMWNC3Gzhrx7adLzB+DMk3F1HG/M+ekF1wZMG
         hX0A==
X-Forwarded-Encrypted: i=1; AJvYcCXRxrMVmKU7hAlaMKyUS0k4bPy0lbZ2BRWB7mq6WgS8ZU4+7xuQ0SNtKliV2kAV2e6SsJeXx2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOwRmSAdpsrOeYOeIwBxR/8RgWzxLyqZZNKZN1zPBQVsPNk1W+
	CcAAwUGrtnapd26C8GOWtE6xX/bUNSmk+4F35ylofg5G3yvCe1e8E0pugjaBsS48c9M1MbKAycg
	KLVEoRbqJ341QNYWjklJQlKaER/7Fem+sFnIWCg==
X-Gm-Gg: ASbGnctk9xH367fXosHVCd4M9Z0wwMk3dzEOgsOLXRDYqj3fMYCdvPZNz5vigGakzQb
	gp6aUktmUaMVl8yXDrzuaxBRTZpbrjoVWWamPjZiujgbzCAU22eGNWmkRkmWeKvYNlPKmYgFRnr
	J3n3ynfouLVD7iJNI/n0QRgLYdkcAtlMXdGiNCOMR5oZj3PcziPzevZY9FBRU=
X-Google-Smtp-Source: AGHT+IFzWK434nhtb4w+8XqXvvTVLz7cQ33CfkusPzfC4ffnVIgn0gGz66HquvJCMDt0tb15sjoUDK45j0gNOhYrFlo=
X-Received: by 2002:a05:6402:26d4:b0:5f0:7290:394b with SMTP id
 4fb4d7f45d1cf-5f0db889fb1mr12787948a12.27.1744123515199; Tue, 08 Apr 2025
 07:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2703842b.58be.195fa426e5e.Coremail.slark_xiao@163.com>
 <DBU4US.LSH9IZJH4Q933@unrealasia.net> <W6W4US.MQDIW3EU4I8R2@unrealasia.net>
 <f0798724-d5dd-498b-89be-7d7521ac4930@gmail.com> <CACNYkD6skGNsR-AH=6TWeXLqXeyCut=HGJeWUadw198Ha3to1g@mail.gmail.com>
 <CAFEp6-2_+25Z+2nPOQtOzJPgfJM8DAs2h_e6HTQ4fAVLt0+bwQ@mail.gmail.com> <BB06D58C-E27D-42FA-8043-AE767E9B5E91@gmail.com>
In-Reply-To: <BB06D58C-E27D-42FA-8043-AE767E9B5E91@gmail.com>
From: Muhammad Nuzaihan <zaihan@unrealasia.net>
Date: Tue, 8 Apr 2025 22:45:03 +0800
X-Gm-Features: ATxdqUEXOuMMmnIAa6YJ-BdW2lii4EbPgcz6D2oVlm5dOhxW2qYubUdeN-IGJGI
Message-ID: <CACNYkD7FNx6KR_aKA9S10=bXx4-Xj9WLnGVGDWTgNERerCc6uw@mail.gmail.com>
Subject: Re: GNSS support for Qualcomm PCIe modem device
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>, Slark Xiao <slark_xiao@163.com>, 
	Loic Poulain <loic.poulain@linaro.org>, manivannan.sadhasivam@linaro.org, 
	netdev@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>, johan@kernel.org, 
	mhi@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Loic, Sergey,

Thank you Sergey for your time for the prototype.

Looking forward for the code (and coding help if necessary) and help
to test it on my machine.

Zaihan

On Tue, Apr 8, 2025 at 6:27=E2=80=AFPM Sergey Ryazanov <ryazanov.s.a@gmail.=
com> wrote:
>
> On April 8, 2025 12:13:17 PM GMT+03:00, Loic Poulain <loic.poulain@oss.qu=
alcomm.com> wrote:
> >Hi Zhaihan, Sergey.
> >
> >On Fri, Apr 4, 2025 at 7:42=E2=80=AFAM Muhammad Nuzaihan <zaihan@unreala=
sia.net> wrote:
> >>
> >> Hi Sergey, Slark,
> >>
> >> Using wwan subsystem and it works without issues, maybe i might miss
> >> something, perhaps the flow control but i never have any problems even
> >> without flow control.
> >>
> >> I am using gpsd + cgps and xgps with a small modification to Linux
> >> kernel's wwan subsystem in the kernel to get NMEA data.
> >>
> >> I had posted the patch previously and i can post the patch again if yo=
u like.
> >>
> >> Attached in this email is the screenshot of cgps + gpsd.
> >>
> >> Maybe it should be in GPS subsystem but it's working for me even using
> >> wwan subsystem for months now.
> >
> >Yes, I would strongly recommend doing the extra step of making it
> >registered to the GNSS subsystem so that device is exposed with the
> >correct class.
> >From WWAN driver perspective, it will not change anything, as we could
> >have the WWAN framework handling this properly (bridging to gnss
> >intead of exposing the port as wwan character device).
> >Sergey, is it your plan?
>
> Yep. I made the prototype exactly in this way. So a modem driver should n=
ot care about the port type. Just call WWAN core and it will do the job for=
 the driver.
>
> The prototype is done. Needs some polishing, proper description, and prob=
ably, today night I'm going to publish  the RFC.
> Hi Loic,

