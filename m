Return-Path: <netdev+bounces-112917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D4C193BD28
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 09:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9C01F21682
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 07:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C9837165;
	Thu, 25 Jul 2024 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fbMjkso3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32501CA8A
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721892766; cv=none; b=YgZYUg6km5G01IWhvk42ZG3KGjrdcbvOzdDrl0VNDAkZhIbXWJ1EEhpRoNvYZ03q6hn7VkVVWwAGxoEkY/1lLq1sd7063aI6uL9B06AVLShdEb5yFFw3Vu18z31kFV0Yf2HW4FEYdFA9BGloSQJDM0hck6NdYiTICdw7JgM/5Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721892766; c=relaxed/simple;
	bh=mhsrw8ogEGpLPVAj7eghcSQD3WmtTykYhuJiZIrkfk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hkuj/MDZEG+vE+eZGfwS68W9lm+Dmo06nyqsja+B39lYvsyJxyZqKR5KLHNY6utktZ9aQ0hJJ3/vte1ildjAHAiem/1aPU8XOZSOzLtCuApcKJsfGdJAiomMhPKDAlW3LSpti7eizFVpwvTAMpJUOsRSF2x/PYOJ6pT2zNAF5Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fbMjkso3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-428063f4d71so26795e9.1
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 00:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721892763; x=1722497563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhsrw8ogEGpLPVAj7eghcSQD3WmtTykYhuJiZIrkfk8=;
        b=fbMjkso3liEnVbWR449XJsVGbnAPiO1XFyONqlJOvBBjtYVSj3W6lsrjZG1t/HR709
         bBxdtAm/DBsdn5vYJRwDosgeRBeRQgleRsRF/QOIj9Wd6FbTtvUdG5DyjCLeGqlnKhAM
         WHHA7n7y4ub8JffXfpcO6gSaTl9qUmXX134QL2QnVl3oNIqQLDCRMWWcPR2/pRyvcQ0R
         t7k0b+opA48zrfL69ver4Kx6ArhfnFAhQBwemlUpHtqaYBUJqi+4BZGg/GC4p7Iph6G2
         Gqr2lKV4F2PPpgLbT4jD0ebjihptsmllRSLrbXBw/2EUe/2uu9z7c295gAtwRh/Y9g8Q
         O9aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721892763; x=1722497563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mhsrw8ogEGpLPVAj7eghcSQD3WmtTykYhuJiZIrkfk8=;
        b=hTvjJWrIfideLqkeaEqp0wIqRBNMWlhPfaew4xy8bEn0/uylp/aSr67IfpgO3Paw6h
         gqgD3jPMd62+UpyGyyrpp1C5KHMoOQTu8SEMx/ylj/Ff4V3Hox1hH6LS3yk8Z7OEgMK+
         F4oV2wPqznczKSdlHYytK4oT8IKsUD5n3jK5CMNCCxFkr8ynHIAZMTcOoxzCpqpp2ExU
         8uRNGi7h9qZ4lMf1L/vpbM5SkYWwMZkqISzHxzQjLmJT8vGATOmxjFuqKi5k379xUxmx
         St6Q/bFiEekO+aWKnApsRSW0VnVK9VuASiGVc9chmEGmd+w2RV4VVitKz445OPfxJG4F
         BjEw==
X-Forwarded-Encrypted: i=1; AJvYcCWLUb5U4zrdgdl845ASjxjlY31iWuJng4yzXtz1AjxGNwuwfH//hSTWdwveRg6n+pJbqhJVPm1H8TVqcPndokUmI8mZsge1
X-Gm-Message-State: AOJu0YxNPDHRqnX2dd1pnr+2mMw53QaFDyut+8RCQEfRJcbWbboscWWE
	XhP4MfHBG8Fd0e0QAlmWa8xNG10ryFfeGfDVOzY+noNcFpNpRhN0a/x9IxirsK3AxMCN/54sRsp
	iItMja1x1DEvzWQfrg2FEwmiFpLr1UOX3UQyw
X-Google-Smtp-Source: AGHT+IHrlPzesfUYFOdrI66JQhz2C3XefRHiL5ThLCOeaquCv+BIr6iB+fuX+Gen43Z58/Wd0LH5F6B3GUkFKOdp6m4=
X-Received: by 2002:a05:600c:3b05:b0:426:5ef2:cd97 with SMTP id
 5b1f17b1804b1-42803ffa18amr1015225e9.2.1721892762656; Thu, 25 Jul 2024
 00:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722094119.31128-1-xiaolinkui@126.com> <CANn89iKrebOtKsZptq_NMhwCGOVbrp=QgAYnJE3OPsC1__N+HQ@mail.gmail.com>
 <4ef5ab3b.171b.190e8b6eedd.Coremail.xiaolinkui@126.com>
In-Reply-To: <4ef5ab3b.171b.190e8b6eedd.Coremail.xiaolinkui@126.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 25 Jul 2024 09:32:29 +0200
Message-ID: <CANn89i+8Fn74WWjVvxnPo154JRie69p1Tz+imOUMnrnoRVmoDg@mail.gmail.com>
Subject: Re: Re: [PATCH] tcp/dccp: replace using only even ports with all ports
To: xiaolinkui <xiaolinkui@126.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, 
	Linkui Xiao <xiaolinkui@kylinos.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 9:07=E2=80=AFAM xiaolinkui <xiaolinkui@126.com> wro=
te:
>
> Thank you for your reply=EF=BC=8E
>
> At 2024-07-22 21:50:39, "Eric Dumazet" <edumazet@google.com> wrote:
> >On Mon, Jul 22, 2024 at 2:41=E2=80=AFAM <xiaolinkui@126.com> wrote:
> >>
> >> From: Linkui Xiao <xiaolinkui@kylinos.com>
> >>
> >> In commit 207184853dbd ("tcp/dccp: change source port selection at con=
nect()
> >> time"), the purpose is to address the issue of increased costs when al=
l even
> >> ports are in use.
> >>
> >> But in my testing environment, this more cost issue has not been resol=
ved.
> >
> >You missed the whole point of 1580ab63fc9a ("tcp/dccp: better use of
> >ephemeral ports in connect()")
> >
> >Have you read 207184853dbd ("tcp/dccp: change source port selection at
> >connect() ..." changelog and are you using IP_LOCAL_PORT_RANGE ?
>
> There seems to be some difference between IP_LOCAL_PORT_RANGE
> and "sysctl net.ipv4.ip_local_port_range".We can use the following system
> calls at the user layer to use IP_LOCAL_PORT_RANGE:
> setsockopt(sockfd, IPPROTO_IP, IP_LOCAL_PORT_RANGE, &opt, sizeof(opt));
>
> But user behavior is uncontrollable=EF=BC=8EIs there any other way to use=
 IP_LOCAL_PORT_RANGE=EF=BC=9F

If user behavior can not be changed, this is on their end.

Sorry, we won't accept a patch going to the terrible situation we had
before, where applications would fail completely in many cases.

