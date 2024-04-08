Return-Path: <netdev+bounces-85668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9704E89BCFA
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E1F81F2270F
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BEF5338D;
	Mon,  8 Apr 2024 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pu1pZuew"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370DA52F82
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 10:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712571908; cv=none; b=ohJYzObjO+6WwHdhJ0Li6EhW0OffUEK7taBb26PVToT5NmcePTuB40XvilLg58Rn0abfXIqg0RRy617O57KUBc/6lagjvjQFScRyd8xo/F41+q6intfzQjibHCWOhyyxKEQrApPuD48kgOVFkls2YELhZEsLel8szpjlgPnlVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712571908; c=relaxed/simple;
	bh=gASr0ryTA0Qahu8VylBfDLMTSb6BZlBp2V10X3Yj1yQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sk7R1y0dkWQ/qHLrV26GOfyzLQVrnRMnPktjTQYsvKeG+ZbCxMZiNWTIVvZKEJkggLC7fXPtNce9WDmLaI1qQ3CybhYPgC2WeWJ9gDY/IupxqGVktxIppyfW69gg3YcUtrvJbTRek7dOGB6wSG4kLxU7sV85ePjTtkVMwrN9/A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pu1pZuew; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56e2b41187aso4568338a12.1
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 03:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712571904; x=1713176704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lR5dj/Dq0y2ywKV6MldB7OAEtgJWv3NKuFwDng/bOow=;
        b=Pu1pZuewWIthYrQqwBCNSqoZ1GFWszTxzDAwBn5msvYvv9GwL6eQ6YnEd+zAoTnh1L
         hPIQbvE6BJUcqLOu6zlYSf8rfLi3diAGpIE88YBrPFiQP7PFW0ysxTPBDj0inZdnqjX0
         rpdYXoTR/PSP58e4Ki7jatbQTF/+sA4ShkUmyN09bYggmX16yW10vbomKGaym4peSp0x
         dPQmSBPdP0CdsyfX3FQnmuhYbQTLFsH+ynrNSXvPw36nBj1o1p9NgxeyBNq8RRpkul78
         bzAOjttH4mcEdveBtOLmqT6iWUS23b9QKIExea4SqWDI8enVB4NzrXX7nm2MoLeFhD6d
         MJfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712571904; x=1713176704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR5dj/Dq0y2ywKV6MldB7OAEtgJWv3NKuFwDng/bOow=;
        b=mR6M/PfjBIXc62SZjWmhVoE3PF23LCNanVB9JFzdK1fvIQgBvmw9qt1RcQl39jZGG3
         YSyDlNS4elqWexz3hVuyCyfA3P960Tp245W3dDuqI0hoVVtCSPBbbChPjSr10W90KSgl
         RMn8vZXWGHSGOnJdsMn7g6/zc8YxeoUzEIqXNtwS0uph36ScW+/8iFD1jJMu2jehMXe5
         aicFJn1tAWnqMTY4veuL1+XVVvaS25qt3XNmqJoVUU0GDs1ILcYVe37NDjK9heSdp7Wg
         KkH61TjJviDigXRjkVqj+Xnp23oH7liZoqatKx6LjYHoLpg4g3IUCH+g0LzOd5DOKd4l
         AX4g==
X-Forwarded-Encrypted: i=1; AJvYcCUYDzoHAS14EjYTqfgpV/mXJCeJDd/dzG4nFwGerzsulAsOqtseJ0JEBI6EdFpC26WAClNZSo0DI1VBZjO5yvNaYBXfB/cc
X-Gm-Message-State: AOJu0YwZ8J+M7N38bq0jjF9lkvtgEN0/201I75brGODbaOSL94wEDYP+
	4FOU2NP4rpL6qCO2AwY57tVbh1m0NX1yQjiWQ3RVWX8VPC6K/UUpGRD3FaH/+/4=
X-Google-Smtp-Source: AGHT+IGvTCDDCbLnsDhfolm8RjSxpqx63e4dGXai4C7pT98/17ImUly1/tzEVtd7SLi6f7+DNsDfwg==
X-Received: by 2002:a50:c359:0:b0:56b:d013:a67e with SMTP id q25-20020a50c359000000b0056bd013a67emr8343832edb.18.1712571904236;
        Mon, 08 Apr 2024 03:25:04 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id h25-20020a056402095900b0056e62321eedsm1057217edz.17.2024.04.08.03.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 03:25:04 -0700 (PDT)
Date: Mon, 8 Apr 2024 13:24:58 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Prasad Pandit <ppandit@redhat.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	netdev@vger.kernel.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] dpll: indent DPLL option type by a tab
Message-ID: <ea7015d5-8364-400c-bb15-3a4ad254df25@moroto.mountain>
References: <20240322105649.1798057-1-ppandit@redhat.com>
 <Zf1nSa1F8Nj1oAi9@nanopsycho>
 <CAE8KmOx9-BgbOxV6-wDRz2XUasEzp2krqMPbVYYZbav+8dCtBw@mail.gmail.com>
 <Zf12B9rjjZotZ46C@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zf12B9rjjZotZ46C@nanopsycho>

On Fri, Mar 22, 2024 at 01:13:59PM +0100, Jiri Pirko wrote:
> Fri, Mar 22, 2024 at 12:35:21PM CET, ppandit@redhat.com wrote:
> >Hi,
> >
> >Thank you for a quick response.
> >
> >On Fri, 22 Mar 2024 at 16:41, Jiri Pirko <jiri@resnulli.us> wrote:
> >> You should indicate the target tree:
> >> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr
> >
> >* It is for the -net tree IIUC, not net-next.
> 
> Okay.
> 
> 
> >
> >> Also, please include "Fixes" tag.
> >
> >* Last time they said not to include "Fixes" tag ->
> >https://lists.infradead.org/pipermail/linux-arm-kernel/2024-March/911714.html
> 
> AFAIU and IIRC, discussed couple of times, the outcome is that Fixes
> should be included for netdev patches every time, no matter what is the
> matter of the actual fix and target tree. Please include it. For -net it
> is actually required.
> 

I think there is some confusion here.  When Prasad Pandit says it
affects "Kconfig parsers", he is talking about his out-of-tree program.
https://github.com/pjps/config-kernel  It doesn't affect anything
in-tree so we wouldn't normally give it a Fixes tag.

There is a gray area around silencing static checker warnings.  Most of
the time, people say to not include a fixes tag for that.  But sometimes
people go the other way.  In this case, it's not really a static checker
warning, it's just a white space issue.  Also Prasad should just modify
config-kernel to match the in-kernel parser.

It's true that for Fixes it doesn't matter the tree, it only matters if
it's a bugfix.  People sometimes used to say "I'm not including a Fixes
tag because this is too new for -stable kernels".  But actually having
a Fixes tag that points to a very recent bug helps the stable
maintainers automatically mark it as NOT necessary.  (The stable
maintainers do sometimes backport patches which were not explicitly
marked with a Fixes tag because people forget to tag things sometimes).

regards,
dan carpenter


