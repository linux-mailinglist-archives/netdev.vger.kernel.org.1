Return-Path: <netdev+bounces-81245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D9A886BE8
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 13:14:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627201F218C5
	for <lists+netdev@lfdr.de>; Fri, 22 Mar 2024 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7C53FB8E;
	Fri, 22 Mar 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="lB2p6/Ne"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7CE3E49D
	for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109648; cv=none; b=sBIOzIMkQnTHV5xKL13yr/qjqCdJXfz5mxVBz5oYbb4JYQQBzE+aqWnAKhDBxeDl3K2rb6Xml234ftasY3q9Uy/RnXsU+KidguHQIFFjU7Bm/v0KbHccn5cI9Xh6d+weLHdODqO2VBUty40wzfAGl2I6yphSAcwkQ078MsMztiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109648; c=relaxed/simple;
	bh=bzRg+T+qAU5NY/fpzuAtxGem5umvK0V7+c75ewkTyaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V6zdcFj/VWMjDHipUMia3TP0IPaKg/yMIo6F6kAZZHYjPDllBX1XzBnkk4Tay9qxKSjgCXqdkgEyRjjHbMXZfLx3heZliXMydt3jO3Qkien9ksbpqCUq2UjeNfC3enP0yBWAzS384Gdpi2A+xjKjb8rF45NIaPHHwVY5Mluczwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=lB2p6/Ne; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4147e5d9183so1148775e9.3
        for <netdev@vger.kernel.org>; Fri, 22 Mar 2024 05:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711109643; x=1711714443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+OVlX+vRLFUe+ssWEHMDttkOHwUBLet3dhGcpZ4oyo=;
        b=lB2p6/NeUH0iCnHHX9PeEovodM5pZb8+/WSL+8yYzbzSHAYUUWFhoxnFEih3Mz7a/g
         0SE9NNhuj2p95i2koxeg7hXNFj+sB3RwuElMYsYhMXQqJBAHddfVl68XQkIzIxRNho/w
         HgNmTdBang1evj902xRXJFh8dGwKQhhLAGrVWufC3f6gIKJWPKauaFjKeVTARVuqtRzs
         LnGRxgsTCEkvNKl/grdA4GB4eIfJOAzhhqUlHQWP74ULh3rdXvhoGLBH1QkGwNelDGXg
         TyMqHVln6UuUW7tcYdgTaRiERT49aBlB0upJc4fadVTHnOyETjfGhpyItqUiJ3zXmr/r
         +Yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711109643; x=1711714443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+OVlX+vRLFUe+ssWEHMDttkOHwUBLet3dhGcpZ4oyo=;
        b=vtaiIJaNV7LSr4yR1Yf1kSNjXExxznnsccSPoajVMifTSz/AXTRDQOUWgEVHe85PS0
         x0Yq16ncvKdAtCNe+vdNR7YKARy9Sl1McK2tMCkJiiYDj0X8vFr5vAiCmiF8KfyNZkAO
         QUNMSKk6F7MU/ylN0tFhBVlncA2Ckr8qL2GUpQ3r69HBohDXx7/6C/LtX7AhaA7OO9os
         tphlFKlFXPDgD52nwVhBeyJsQol/ZyPAjYIVAD03eK9CJVOZ++BOclZ9oNS5VaGwFZ5F
         TOl+SAxYi9l8FPlM4IOSuHGcwkYPa8qyspWRVBmPQc8hvwRXCZbmbyP5JWhZvLJDGa5w
         K2Uw==
X-Forwarded-Encrypted: i=1; AJvYcCVJORLutiUZ1DzCHTGZ9XeOXJ+q8yteOoia9Tp+DNaume8DPQtQHNZjOUKidKK2edHMlanpDvJb+TiYq1uxareGJo1OKbrF
X-Gm-Message-State: AOJu0Yx/nVzxucFZzosfcc0WUi6Do/UEpSe1YsYK5KITdmxQgxrjJKO6
	okiXyPQGV9/rcDy+0HwGI2Wh2FecVFn+m2+5pUsBkhDSfBX7j/bVktqDHW10BNE=
X-Google-Smtp-Source: AGHT+IEtNFq5/Nyxrdw/JB32Bq+0rkwgJL1bMtDJT74RZ3dO0hdJzojq+v7FtfTbaJeHRskn8GUCBg==
X-Received: by 2002:a5d:6186:0:b0:33e:b7d7:76ee with SMTP id j6-20020a5d6186000000b0033eb7d776eemr1553423wru.44.1711109643161;
        Fri, 22 Mar 2024 05:14:03 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id x17-20020adfffd1000000b00341babb8af0sm579303wrs.7.2024.03.22.05.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 05:14:02 -0700 (PDT)
Date: Fri, 22 Mar 2024 13:13:59 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Prasad Pandit <ppandit@redhat.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	netdev@vger.kernel.org, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] dpll: indent DPLL option type by a tab
Message-ID: <Zf12B9rjjZotZ46C@nanopsycho>
References: <20240322105649.1798057-1-ppandit@redhat.com>
 <Zf1nSa1F8Nj1oAi9@nanopsycho>
 <CAE8KmOx9-BgbOxV6-wDRz2XUasEzp2krqMPbVYYZbav+8dCtBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE8KmOx9-BgbOxV6-wDRz2XUasEzp2krqMPbVYYZbav+8dCtBw@mail.gmail.com>

Fri, Mar 22, 2024 at 12:35:21PM CET, ppandit@redhat.com wrote:
>Hi,
>
>Thank you for a quick response.
>
>On Fri, 22 Mar 2024 at 16:41, Jiri Pirko <jiri@resnulli.us> wrote:
>> You should indicate the target tree:
>> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr
>
>* It is for the -net tree IIUC, not net-next.

Okay.


>
>> Also, please include "Fixes" tag.
>
>* Last time they said not to include "Fixes" tag ->
>https://lists.infradead.org/pipermail/linux-arm-kernel/2024-March/911714.html

AFAIU and IIRC, discussed couple of times, the outcome is that Fixes
should be included for netdev patches every time, no matter what is the
matter of the actual fix and target tree. Please include it. For -net it
is actually required.


>
>Will send a revised patch. Thank you.

You should have waited 24 hours. Did you read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html?highlight=network#tl-dr
?

>---
>  - Prasad
>

