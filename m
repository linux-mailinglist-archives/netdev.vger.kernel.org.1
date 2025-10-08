Return-Path: <netdev+bounces-228182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC3ABC3ED0
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 10:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C97494E2E8C
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7BA2F361E;
	Wed,  8 Oct 2025 08:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esadfgje"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB41F4A33
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759913433; cv=none; b=jgJEgVq8BFkbD0aFfeoZ2lNg5CZKvXSLRHJPU1jA49Vh7bV6hRQEG4Aa//10X5fGWMmvnVSclCIvJKoZlSNvtGVdZyQCq2UfRkoWdKOyEDPFiu/l39i9QPPFpU1Q9ZI56pp5fkEM93Vh61fH0je4CdZDAYoabZ7Kq25/e96+pXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759913433; c=relaxed/simple;
	bh=mjKV8LR3z0adrs0lgCARkF49pJwCIwW9No7CKCawXy8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KfJLZlfFYrEPCAZ03el6raHOuNwEU0IFdH3nU0a/7/KxzZtMweUQvC2IWp5GuZ4LodQtoCs4k6gbGvecmaFCYx8OUrlxlJPc3x2m+D4uM2AXmS1+EoGKoIDj11GpHsscEPHlZSVNvLQpBm2Hdx0NEAUazwX6atArnwyHgpLKpC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esadfgje; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso10467521a12.1
        for <netdev@vger.kernel.org>; Wed, 08 Oct 2025 01:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759913430; x=1760518230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SDdgt531fZXua2Nuzzq7uSWagHpPHjlp+/dNBNaohR8=;
        b=esadfgjet+I774mpqEHp0XtND+ZhDCEJcapjt6MUj8Sz1+yZ54QUZKKwPNnsVaBVnq
         xz01LLF62F3dlYF1fQrhcGJzwz2ZZLi/OzAlfk++m+BQUY0FsKmjBvT6wzDphI4ehcnq
         /EFJLS8Jtk9vFoU7O9ukcULs7ZPejjhOAVf7PpVxuQq6hriZCmg3WP2asoCJJipZgTd/
         ytza1DhjNsUfrHSC9puA2gnSbsMTEDZAFHxNIM7NJOi+f+1ABxZCc3hhlqanuMbZlgxa
         REfUNzoZn1ayp8775l7e//V2di0eTWhkmyZbno8m9nJ+Qu6m0TXf7xDeLq8muF4HU9iC
         S79w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759913430; x=1760518230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDdgt531fZXua2Nuzzq7uSWagHpPHjlp+/dNBNaohR8=;
        b=dSC8wnAMhCVNGAs1+4wBTNuUXABNABYpQvCFMoYSEeD41LytEfFla44OviQDzSTmov
         R8rXGBAYYJkJKwDh1G+bcrHF5kPsjiT0HXxexQ7JW4cHmbguDSckuT6ygp5bXN0yJxFg
         tOcuhr+Px/GpUGm08JUYI19Qkn27bUgdmjifj+iFTbfMESn0J2JxtsyO5MvnojjjyrX+
         OKKR5YiM0jaUfN+DrBv19K/p5GCgh0X1gz3OvDZFuSPcsSCoYaOErNmmauWP2heCf2R2
         Zu/yM5mbD+YLRro7TsvjB7kafPXJ360naUz9K95m9Udv/TAaOLpnrhI/tY//RFwzWYx+
         mzxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSIUlM68fcU73eJsYeyaoFQJNS0kEM/jBOwwiTd/pTCkU4AHkadHaT0LR3Gfdq7FzC9N+VNhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmH878E1wKl04sVhn7D/EB7yp/6itRTBPVaHxHyCGDRl+ekOo0
	gv/tFpI7WFzlMjTV/jgOxzR1isKc2kNnyvNhGq0YTs0ZhyoJF0pLOUa0WzI5UwLTgpSebM4Xryj
	H5NJOBWHU7GTmFli9m+AePJfKW0NUwic=
X-Gm-Gg: ASbGnctFalUtQ21LJdkPlMgUs5r9NDIeDHMnHwNY6JmEV93gymAw9MHBpnyxbYpCgZt
	y7UUfdAC40sPe634P0yTtUMweCWMDQP+PZTL03ph6ky6b1Y+cj8qAWbl1Gj74ZS8zgZk+eICoZH
	MAZeTbFIklV6llWjgbf+Uo88S5gZh836ddc2i9bk1+4cVN+N0zJbn30KX3nEu9MlnhhuLryZ8XE
	oml3TZTcRtEU36gU5n0JQWvA36YV9dM84MNHS69U05nzsF2m46mbpM3fmrjEEM3BjEk/lWVcAsS
	2yL3hU/JyAXxNzDwoYEDrqdbxrgYqYhhoDyZ/f4=
X-Google-Smtp-Source: AGHT+IH6PbQWB6HSus6hSy1TQCxi0qBoYNbFZhZzCJz8Lu5/L/loeIThQUlVSg8ujmNzSV989rkYc2HCeJ4j/hJs6lQ=
X-Received: by 2002:a05:6402:2708:b0:639:c56d:2407 with SMTP id
 4fb4d7f45d1cf-639d5c3f43fmr2353930a12.22.1759913429770; Wed, 08 Oct 2025
 01:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251005204946.2150340-1-pbrobinson@gmail.com> <20251007181903.36a3a345@kernel.org>
In-Reply-To: <20251007181903.36a3a345@kernel.org>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Wed, 8 Oct 2025 09:50:17 +0100
X-Gm-Features: AS18NWCYtfrYTwu7zaX5ATVUv3xg_8f1v37nPjmdIdgBrx3Rkn92q_enxY_9SOs
Message-ID: <CALeDE9MhZXmnQzazoN_HN=yTGiT=EWDhL4AQmERVvOmuELNqJQ@mail.gmail.com>
Subject: Re: [PATCH] ptp: netc: Add dependency on NXP_ENETC4
To: Jakub Kicinski <kuba@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Frank Li <Frank.Li@nxp.com>, Wei Fang <wei.fang@nxp.com>, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 02:19, Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Sun,  5 Oct 2025 21:49:42 +0100 Peter Robinson wrote:
> > The NETC V4 Timer PTP IP works with the associated NIC
> > so depend on it, plus compile test, and default it on if
> > the NIC is enabled similar to the other PTP modules.
> >
> > Fixes: 87a201d59963e ("ptp: netc: add NETC V4 Timer PTP driver support")
>
> You put a Fixes tag here, suggesting this is a fix.
> What bug is it fixing? Seems like an improvement to the default
> kconfig behavior, TBH. If it is a bug fix please explain in the
> commit message more. If not please drop the Fixes tag and repost
> next week. Also..

I don't believe it works without the associated hardware so it seems
like a bug to me, There's likely nuance and opinion. I labelled as a
fix so it lands into the same kernel release as opposed to the next
one.

> > Signed-off-by: Peter Robinson <pbrobinson@gmail.com>
> > ---
> >  drivers/ptp/Kconfig | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> > index 5f8ea34d11d6d..a5542751216d6 100644
> > --- a/drivers/ptp/Kconfig
> > +++ b/drivers/ptp/Kconfig
> > @@ -255,6 +255,8 @@ config PTP_S390
> >
> >  config PTP_NETC_V4_TIMER
> >       tristate "NXP NETC V4 Timer PTP Driver"
> > +     depends on NXP_ENETC4 || COMPILE_TEST
>
> .. why? Does the clock driver not work at all without the networking
> driver? Or you just think that they go together?

It is my understanding that it doesn't, it's also the way the
PTP_1588_CLOCK_QORIQ does it, hence i did that way.

> > +     default y if NXP_ENETC4
>
> Isn't this better written as:
>
>         default NXP_ENETC4

I did it the same way as the other HW drivers such as
PTP_1588_CLOCK_QORIQ and PTP_1588_CLOCK_DTE did in that Kconfig file
for consistency

> ?
>
> >       depends on PTP_1588_CLOCK
> >       depends on PCI_MSI
> >       help
>

