Return-Path: <netdev+bounces-211069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0B8B166C4
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 21:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E6C57B63B5
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 19:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2D62E0916;
	Wed, 30 Jul 2025 19:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRNcOLu0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854CD1624C5
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753903035; cv=none; b=J2Fkpitom9DNvH3Z0Qk9QAXqugJ2j+Em1boPrxJ1vS4lBvUKwB6Vmj5/1tzQ7+WNDCr0grsFOKVnR5dAPCxLtGafg3IF1B3fESJ4ylCwWNARX2d8HhWY/KT4IFL/eTfZ950qK2Iqgs0KcXYzE2aLb49Vju28ToKo8q1BzvffABQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753903035; c=relaxed/simple;
	bh=A/I47xL7vY/wIbA0xrAznejeBW1HRXjqz1c98hyof/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk0sMU8NpmmHlLywEHiS3QrMg+perZBJgV7180F5LDwMM0iAmmAhY2jlZ2WjVtT6lwxjomk6Zu6UPIXt5tGKD9N22Rf4plDLv1TfBGoP6B23hAcSDHfO1h1fwFMRdgANLw47WiKmAeLWKS8a60XAbtOy4ydZDxDokiURwIHR5qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRNcOLu0; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-73c17c770a7so177345b3a.2
        for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 12:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753903034; x=1754507834; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZQIfhLfTS82wPqaIFJrl1+RkallhR2HEu/Xsc2jgeE4=;
        b=eRNcOLu0WxXpPcr41hKkbs7MulmM/E9OvGZ3XscCXoKNvWv10UH4UAbZRhktX8rW8G
         41aFUQCTnMrEgSU3binSL1ScSa4uktu78uVD5QK+shgd/yAU699N/5NPRy3E7ttg50wR
         Xng4vBfrm8LD8jUELGYHPj0FM0HuzabTTfj2J6jI8XHZ5XbeULkg4v3CRAmPVv7xLMfE
         N8h9epzB/6SxP0S4m5DxhZoDT7Aer5xlVcn0hWKZLg/TwrbL2gDuhtzYJ0wieGA6pwAP
         ZxxTqOlrbLewnBO7rjpM8+4aT3ub/j3+3i8vE9YxmGeyiw8vJKteiom9d9MhjGKBeMux
         AWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753903034; x=1754507834;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZQIfhLfTS82wPqaIFJrl1+RkallhR2HEu/Xsc2jgeE4=;
        b=S+r8iQ3nVIzvzb+tj3y2xuy0WPH3q89+Jy98DEISdQbb3rF3Pp6+2VZ2ikKpLzygph
         Lo0uYQY+VzqY/L6XVLRDTIgvWffdWabM5V+wHsc7RqoJ/JAjmLXn7f8HTybf7tSnGcGq
         qzHc/2Xnvgyb+Zd1n0poXzm3dEu6bMdKDplfAHqfRrrmPPimblHMrME4cWTbcZowXsqD
         mnta8KDmSuQHKa3KS0KOxmlDLk6liwurjbHCkgnGRo1pHQ7UAoa/xiw0/fPJcZEmiz0W
         b5tiy8SbC9zJL/XpvBaXDUKfdyPtpY+z+yd7peE4Asc5md8ph/BCgmFVMePIBcUbQcix
         vjcQ==
X-Gm-Message-State: AOJu0YzZh+gGdbZbncSnFsioGpH1quo57iRzZafoVgbZMpqi3FAhgrs5
	yG9I440HQ9SnOUbI0Sty/Vsp8p8Mbf46FyK8FebryV3fFgl1MnDRTgBXkMjf0g==
X-Gm-Gg: ASbGncv5TvVf0m4NWogiZiOk6uwRjfC0v91s3HWHv47JoOTs8hNf4Md8I1234n0VOIs
	C5Ih2Yq15miYqAUh8HDBW6OvSmwQBlPsZVOUQg9lxHjFEnC6EtQdy3HOjdeZeXH3eXcw6CHqikP
	DOVQpBQS9EQZASiKwS4Vjael+z/J4ppxcEVQ+XAndjrkZKpGvxTvWrtFsR1CUtR6XGS7fYlfXY2
	rOx1nuYbYrRbRIAdMDk3a3+ijaDE+2xGnu2tYke5+JYiRA2YEf8XpzbIlR0Z0CgfMA9X9SpE/0B
	nyHW1+wYZWFbV3t690dOEHiMskPohL4TNYbNdEZa2F+tgiT+6ry/JQ1FupZO3Bm7/qEFdNARId5
	oOZElf/Js7Ez5YSIt7dQgOzfD3Q==
X-Google-Smtp-Source: AGHT+IEtFaA1/OrN6I1VVRddZpnGPVBbcbvDLW179Qd9QG5+8UtJgFkCUJXhfcMSYt3Gi2V7fjCEoA==
X-Received: by 2002:a05:6a21:33a2:b0:235:2cd8:6cb6 with SMTP id adf61e73a8af0-23dc0e7c59cmr7131452637.34.1753903033663;
        Wed, 30 Jul 2025 12:17:13 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76b210e4f94sm2324724b3a.36.2025.07.30.12.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 12:17:13 -0700 (PDT)
Date: Wed, 30 Jul 2025 12:17:12 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, will@willsroot.io, stephen@networkplumber.org
Subject: Re: [Patch v4 net 0/6] netem: Fix skb duplication logic and prevent
 infinite loops
Message-ID: <aIpvuNyyvud0sJOl@pop-os.localdomain>
References: <20250719220341.1615951-1-xiyou.wangcong@gmail.com>
 <CAM0EoMmTZon=nFmLsDPKhDEzHruw701iV9=mq92At9oKo0LGpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMmTZon=nFmLsDPKhDEzHruw701iV9=mq92At9oKo0LGpA@mail.gmail.com>

On Mon, Jul 21, 2025 at 10:00:30AM -0400, Jamal Hadi Salim wrote:
> On Sat, Jul 19, 2025 at 6:04 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> >
> > This patchset fixes the infinite loops due to duplication in netem, the
> > real root cause of this problem is enqueuing to the root qdisc, which is
> > now changed to enqueuing to the same qdisc. This is more reasonable,
> > more predictable from users' perspective, less error-proone and more elegant.
> >
> > Please see more details in patch 1/6 which contains two pages of detailed
> > explanation including why it is safe and better.
> >
> > This replaces the patches from William, with much less code and without
> > any workaround. More importantly, this does not break any use case.
> >
> 
> Cong, you are changing user expected behavior.
> So instead of sending to the root qdisc, you are looping on the same
> qdisc. I dont recall what the history is for the decision to go back
> to the root qdisc - but one reason that sounds sensible is we want to
> iterate through the tree hierarchy again. Stephen may remember.
> The fact that the qfq issue is hit indicates the change has
> consequences - and given the check a few lines above, more than likely
> you are affecting the qlen by what you did.

Please refer the changelog of patch 1/6, let me quote it here for you:

    The new netem duplication behavior does not break the documented
    semantics of "creates a copy of the packet before queuing." The man page
    description remains true since duplication occurs before the queuing
    process, creating both original and duplicate packets that are then
    enqueued. The documentation does not specify which qdisc should receive
    the duplicates, only that copying happens before queuing. The implementation
    choice to enqueue duplicates to the same qdisc (rather than root) is an
    internal detail that maintains the documented behavior while preventing
    infinite loops in hierarchical configurations.

I think it is reasonable to use man page as our agreement with users. I
am open to other alternative agreements, if you have one. I hope using
man page is not of my own preference here.

Thanks.

