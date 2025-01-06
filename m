Return-Path: <netdev+bounces-155604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 850BDA0325C
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 22:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 064DC3A4D9D
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 21:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A731E0489;
	Mon,  6 Jan 2025 21:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b="rNkW3wuh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp1.cs.Stanford.EDU (smtp1.cs.stanford.edu [171.64.64.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40C41DE898
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 21:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=171.64.64.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736200589; cv=none; b=ok7ODFYdFRoeI0PkahTcFwB9pW4cOsZzcYYsx6g8ooVJRq1Pebox0bm+YXvbNNESZxkA2TFGrAD2xfugZPnfgjmYa2if1CsguRFZX3Yx/GgTXz6tB9AvwLkhxzYVICYzL3Vh7O1JIduORsIWLu2FVinS3WHxZq2+RXyeIDvRBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736200589; c=relaxed/simple;
	bh=Y0w61zwauEXM1sYntGqvWaV9bjyp1Ac1exbSTai63fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KY2A6x4e+cevR6kadnJq11B1JYlG8QHxmtkd2+jNCsT7/FjwUPVK7nEp1eghRVp/BwqPsJ/DQmP0vk27Gxh6ZRb4Zyr5y5kTLxkUqAHBiaFSAgSX3VOrPkEFWuDxzjtBMnIKV6Jw2B5hMzyGEIdPdO4Uimjl4+7C9/iXa46UERU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu; spf=pass smtp.mailfrom=cs.stanford.edu; dkim=pass (2048-bit key) header.d=cs.stanford.edu header.i=@cs.stanford.edu header.b=rNkW3wuh; arc=none smtp.client-ip=171.64.64.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cs.stanford.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.stanford.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=cs.stanford.edu; s=cs2308; h=Content-Transfer-Encoding:Content-Type:Cc:To:
	Subject:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y0w61zwauEXM1sYntGqvWaV9bjyp1Ac1exbSTai63fc=; t=1736200587; x=1737064587; 
	b=rNkW3wuhxQ94MtqvuwUyqOn3qiFgUpE8vKakEapyEswhp0QEf0DFw3H6l1BMmKM8cQQkJGDOiJu
	COcA8xU6FPKRJhmLbVCTp4E9U9Bq7hGIDruCYLkaq5Qa+kFexnuGfVzG0bbSZefhPeDb6n1m5JaE6
	smhGVMnHYAF0IbzDwSkeFkDVqTpKfmEfjDe+vAJ9s4h43Vya6Oacn4edigeX2c1EVHBcqrD1x24uv
	D/N7NR/oV0msyp5KZK/OJthGleUF7OA867N0VIhymL8JQz45JVDDYNtKcBUTmpMa3cMstnpQFUJW2
	hRgLzROJHPfI0Yj0flgIKtzbaiQ44bobgIMA==;
Received: from mail-oa1-f52.google.com ([209.85.160.52]:48192)
	by smtp1.cs.Stanford.EDU with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <ouster@cs.stanford.edu>)
	id 1tUv5F-0005ea-7K
	for netdev@vger.kernel.org; Mon, 06 Jan 2025 13:56:26 -0800
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e5aedbebdso6944767fac.0
        for <netdev@vger.kernel.org>; Mon, 06 Jan 2025 13:56:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVu2lx9ZI1cokUYOdnL//nJQSt3gXPqK8Si1BRLjPr/G+5Y/Ayl+NZNnr5rdpv/jWSqFNAPp3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMWeTokAVun4T9aqbvy2qrRqfkFLIhDhLMEo8NOVAS8BZzqB/h
	vlVCob1scDi9IwVqF/VVsq8zS173yvlGTJJM7qwem6YLlf8Vqc9GPAYOW7WUbdMl8uTBnrgIsbN
	I2S1P/A242mxDo1OEaK9DpaJUiAc=
X-Google-Smtp-Source: AGHT+IEH8etA4mo5xN152GTaIe3TN8uzdgxPgIQs+o5hqYwMpKJqvnMEugNybhTqFlB5ER7g4W5mQX3EsP1kW0FWrAs=
X-Received: by 2002:a05:6870:8e17:b0:297:24ad:402f with SMTP id
 586e51a60fabf-2a7fb09bad4mr31969333fac.12.1736200584612; Mon, 06 Jan 2025
 13:56:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217000626.2958-13-ouster@cs.stanford.edu>
 <202412251044.574ee2c0-lkp@intel.com> <CAGXJAmzUZLKZj_7M63r2NXHV41_zf7aUH-b9LtAQOMgcheVUrQ@mail.gmail.com>
 <de0a7ef1-c2d0-4db4-8267-9d5ac96f0e23@lunn.ch> <20250106134101.2efd5957@kernel.org>
In-Reply-To: <20250106134101.2efd5957@kernel.org>
From: John Ousterhout <ouster@cs.stanford.edu>
Date: Mon, 6 Jan 2025 13:55:47 -0800
X-Gmail-Original-Message-ID: <CAGXJAmx_0GKAUAWQwr9x11OFJKpfd1mQLjim_nrMW1NbUY=C+A@mail.gmail.com>
Message-ID: <CAGXJAmx_0GKAUAWQwr9x11OFJKpfd1mQLjim_nrMW1NbUY=C+A@mail.gmail.com>
Subject: Re: [PATCH net-next v4 12/12] net: homa: create Makefile and Kconfig
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -1.0
X-Spam-Level: 
X-Scan-Signature: 4c7a780eb20f40a19c8376fd8d8b00d5

On Mon, Jan 6, 2025 at 1:41=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> Just eyeballing the code I suspect object debug is upset that
> we're initializing an on-stack object. John, you should probably
> switch to hrtimer_setup_on_stack() ?

I'll bet that explains it. I wasn't aware that hrtimer_init might be
unhappy with an on-stack object. I will change the code so that the
object is no longer on the stack.

Thanks!

-John-

