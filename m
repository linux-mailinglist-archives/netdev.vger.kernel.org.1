Return-Path: <netdev+bounces-238670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5ADC5D34B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 14:00:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC58E3BE4BE
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 12:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA40248868;
	Fri, 14 Nov 2025 12:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZbqfK4m0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B591244685
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 12:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763125187; cv=none; b=KpVJyMMgn+91+E1xp70470SqIpRm1q9HAVGS1LtGylBHIrV0Xb0fb6Yg2gP6567BQ4gdpAOehcORqJp9qBC40tBO+6j8P1wZ+lufGBA3EMXXRvM7CO7hRJ+pS0bqcDLMAa18ggNjc9BIMJvHm0aCmBE4OH23DxDlOUjCy4bIY1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763125187; c=relaxed/simple;
	bh=OwXqaVYjP+AYjhrqdV/iUf65lNBgi6i65jcAVuzkims=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjZJjE5gbb4LKu8UGUbKuoSuW5Snyrz7xioSAUDhAOPYpwxGt8A/2GU9HON6jHQJ/xDcxS7L2d7EVt5EdQZip3kfkmPq8Wn0IamV0R7bbIFYWEMFgeps5tTi7MdHwpfalO/xf5xxsa+GU12UYKV/Tfpg2+eURAtujE2ELdEE7Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZbqfK4m0; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b735487129fso288066966b.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 04:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763125183; x=1763729983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lIa30kEZfIOzXn6c2Ch+jzSexECrPYWXzGffwwy3r9Q=;
        b=ZbqfK4m0Vk3QZZMUhnZ65dzeU/GFengPpj80uV976TTNT6cF3kLVFLU8dNGFNmtTBM
         4qOp9/GpfWs9OKiNwe0QHH/jcW19OTYlr1meSgMwyMFng3k0InkVtUKHBwfo5BNYqFr+
         4lFMJhMGNriMqn3fozHBGzFjOKEU5kUtemJ7mYPxBLflIyzVat1J4pYAXgbN4B2YnyYG
         82UWE3kzLCNGqMlMm3yvbYBMH3F7S7iX89IYp4nrzQpu+C75oEGN3b+p3276ZuRBY6eY
         kmTlfbRGGr9zKGdLcC+V/1s+Tfa76MlJmsfSuKTulTxUlUvcI4E9GKJuCGZhh00S7xuu
         FnVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763125184; x=1763729984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIa30kEZfIOzXn6c2Ch+jzSexECrPYWXzGffwwy3r9Q=;
        b=V35vyPIjlLAhUOgdCvbeqwXXbhbjShrLCtGQxEcUWXr8OZhZksuOwMEm3xC87B0HJc
         ehoqFh3xjJuGoL5iC4u0RmapiNrOig9q+/64S3miQYr63C/1SGj2tDaU/9r1bb/motIl
         uwRXv2UxevOPE/+b+/wuZvBlc6rwIwKsgj2IneNqiXmcA3xvgF4xHY6cz6EuKYtSflAe
         WNZejN8LyqCdOyy2AwMlJm7tjnDUSJd6J4dvAUOULrJp8XJ61pf9SMlZOYQmdwJTjQU1
         FRLNLUfz1UL30N0cXQX4cGoSPEom2hnGelETZCjrSURUr90JgaV6Rgg/EstLflX52A4N
         9T4w==
X-Forwarded-Encrypted: i=1; AJvYcCW6EGt6ihBJtXx/bSguyJlABcwSHCh/1p0DnqH/SSlPaJGH3rVN0p9ESdlpSL4log02oZQUo9A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBlPc1zzkyIlVjdT/OHUJvm3nwpkmd8q517DSPIbCGn+W/O+m
	8dMoFKH1mNRpFl5uRSaOE+oSHvCpPXdFPY+nv76rz3X0wHc53jT+hsEOnS8U2c42exo=
X-Gm-Gg: ASbGncuZ11d1AMv0u2oc+ArwPlATk9jy9QwvsejgDWM3EeZQg+rutwFqJZN+K9Y/ucB
	IuEC6HoUuzQpeoKH3xiD7qS2Jif1BrIhQXnq2TCaqy8SwXI1KVTF+4PJL8Py2hOjZC6blBjt1D1
	ol1mnF2LaJHDIVYw1BiKdEXykUSnu5HsQ0BS/JPNXg+SNRMESLKDZVJGeu8ZBTrn1/Z48oS60DA
	7B8clmv3cnafDZyuvnFR2CnovFMJ8IUK/b6dbZ9ljlXR6x0nXL9CHhUSBG8HcHYPiA0kKLBg+ls
	3Li1sIfowT3PekUztlzu/Nmuc3AI2H1ECQDDcw3KBrmSh+PtfQIf17ZaYfNtOqsRwj2aUMm73Gd
	JoCNKP3//UYlIV9ePIvN4BoKVzY4YKkdZD8cjF07hH1EeAKRL1hfjj7wBt4qtaKMI7DbKJrwa25
	jzv8M=
X-Google-Smtp-Source: AGHT+IH6H5eoyoDiGCawX8hcyfAIsFqjcgfKx5GqQ3M5ZUeRqB23EXgoQaPPEhXoJ1r2rQPfP0tLQA==
X-Received: by 2002:a17:906:f105:b0:b73:7652:ef9e with SMTP id a640c23a62f3a-b737652f76bmr38125366b.55.1763125183501;
        Fri, 14 Nov 2025 04:59:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fd80a3asm382714666b.37.2025.11.14.04.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 04:59:42 -0800 (PST)
Date: Fri, 14 Nov 2025 13:59:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Corey Minyard <corey@minyard.net>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vitaly Lifshits <vitaly.lifshits@intel.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Calvin Owens <calvin@wbinvd.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, amd-gfx@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-mmc@vger.kernel.org,
	netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-staging@lists.linux.dev,
	ceph-devel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Dmitry Baryshkov <lumag@kernel.org>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rodolfo Giometti <giometti@enneenne.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Stefan Haberland <sth@linux.ibm.com>,
	Jan Hoeppner <hoeppner@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3 01/21] lib/vsprintf: Add specifier for printing struct
 timespec64
Message-ID: <aRcnug35DOZ3IGNi@pathway.suse.cz>
References: <20251113150217.3030010-1-andriy.shevchenko@linux.intel.com>
 <20251113150217.3030010-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113150217.3030010-2-andriy.shevchenko@linux.intel.com>

On Thu 2025-11-13 15:32:15, Andy Shevchenko wrote:
> A handful drivers want to print a content of the struct timespec64
> in a format of %lld:%09ld. In order to make their lives easier, add
> the respecting specifier directly to the printf() implementation.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks goor to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>

I wonder how to move forward. I could take the whole patchset via
printk tree. There is no conflict with linux-next at the moment.

It seems that only 3 patches haven't got any ack yet. I am going
to wait for more feedback and push it later the following week
(Wednesday or so) unless anyone complains.

Best Regards,
Petr

