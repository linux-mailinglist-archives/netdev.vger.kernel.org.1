Return-Path: <netdev+bounces-150749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61239EB684
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 17:34:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9A521886DDE
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 16:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F21C5F29;
	Tue, 10 Dec 2024 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="oK4bkqyY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AED1AAA1F
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733848449; cv=none; b=YxDML1EH795ixBG5fuKG0RTEGPyryAQvjMKQDuDIlioCaMjPzZKwTK6nzU3qkXGFpHM0h17s/afQIO2hKnSfUQlxKJ5zk8IXloULMOpFD7UWlnpuaqwZI8Fy9ijGGDATx3frrasdOPbnpdLp7tKA/S3jMQ3b087/W3YjeRKxXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733848449; c=relaxed/simple;
	bh=sQnuwRWxUOnAEtZKfyXTWmf+zCpmwdFu1sUDT1TVN9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thE0ZCcj7Ro9cDTB/waRcDf/tNFLwJPI7C1PWjkITIdkCkK7ydmgVybbh+1dHmyCko0g+ef1DqGLG165swYwL7yKmNGAhsIJ+ZTvbMBgNflGIQxRw0dy0UZiODsmG5TFloDbTbbs36Jge2QLi+52higkEHaCB7SaF7g7S5Na3v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=oK4bkqyY; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21634338cfdso35673555ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 08:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1733848447; x=1734453247; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MM7mkfPX/z4yVilBxiJBcCR4eR91hwy3WY2ezGvB4AQ=;
        b=oK4bkqyYuWDw1fTocixksaNeP2BqJ0mjQRSRCe6bwXylBVlXbZbfFn7xNeIxkSMo0S
         oN2svEUItYgEjNsnGot1m/BblPZOsy2DzhPfamRRgqPyAKjzFzegQJXrM/ZHB8zBO1M7
         dcYL7ClVS132tmMz3kxnv9yUKz7c0hcmssFHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733848447; x=1734453247;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MM7mkfPX/z4yVilBxiJBcCR4eR91hwy3WY2ezGvB4AQ=;
        b=td8Jkq2K8e7P6SqD+cY1DslxPocfiweXeuCSOLpD3B7holeSSiCl9h+orbO1A4pfUF
         0LYM190D6EII1QwMltYZ/t0NfNT4U7tfaGVqgtuek4/tWI+wW5LC3kTufXbN+bqbHtPW
         AK3RQZvUySYODp8hNkrRBaOWvB23lUz0n0ESepffz/Ep45krqplywKuBM5TwaqQKfDcc
         2v0VhNcd4prYwAvWHrFKmXQyS9eR3RyPwnwcgj88ji3Nag177xzjEkMpydTCHb22P2WU
         gVAnqZYiQrtKWHu/3B32ssxLBNY6yGVVZ5qNr1+lZqedACCYfC+ibHd+qjrWMUDLnpZD
         d/fg==
X-Forwarded-Encrypted: i=1; AJvYcCWQX/bS1euIo+dLAOi9Ncsrju7qJZMMKJX+O8A2v9eyFoWFfvMx0L8x0IyX+crmSLcPTPeaq/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgi6/vyS/ZdLGcXeyu3jdO2e2PyEbXPxQ29we7Vi4UZNGeT8JL
	t97fKbKsaLBDKascvl6ssV7y8x6irqapbGPJGCnjxkiPF/fNkiiDDOdaRhv8Cys=
X-Gm-Gg: ASbGncvHensEvsS58ckFCLYh08NeBE4jhekXWmxXmdXxRhJdNfe7Ie7SLi6kaVNE9fH
	lfMkv+MQcxmOrV3W6K/wYqyfea8y4Ir9lqn4YZLH/oBGJCNAG9RVgX9EaUH9bvYhmDsaDvGp7S5
	uw6BEcn1NFc3iF2/JrHtX2vUSXfPTjx2fCjDXsbqTnejh5/dsymcYJH3LenAtKMViPSN2S6gZP0
	6epBdF00dSB7VGC8xMUu66M+TPpV/Wf2CMoYjYAnog0b6G3qP5EzBHMeT98m+q35RaqYQaNpV0X
	PYi/Mg7BNPqiDA4EcKmj
X-Google-Smtp-Source: AGHT+IHN9nygNnSTRx/qg058XotfWs2WH/nks8UlZLQYwvpdFiCk0KpSOEKf5NuVrm6lqzjl4PvC4Q==
X-Received: by 2002:a17:902:c948:b0:216:66d2:f190 with SMTP id d9443c01a7336-2166a0bc824mr71072565ad.55.1733848446802;
        Tue, 10 Dec 2024 08:34:06 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21628c448c4sm61023095ad.23.2024.12.10.08.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 08:34:06 -0800 (PST)
Date: Tue, 10 Dec 2024 08:34:03 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jan Stancek <jstancek@redhat.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, stfomichev@gmail.com,
	pabeni@redhat.com, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/5] tools: ynl: add main install target
Message-ID: <Z1hte2LnnPdC6DMm@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jan Stancek <jstancek@redhat.com>, donald.hunter@gmail.com,
	kuba@kernel.org, stfomichev@gmail.com, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1733755068.git.jstancek@redhat.com>
 <59e64ba52e7fb7d15248419682433ec5a732650b.1733755068.git.jstancek@redhat.com>
 <Z1dhiJpyoXTlw5s9@LQ3V64L9R2>
 <CAASaF6wVb=c2mYJDqSdjbGD2hQ9CdbxmEKopVoT3Aniy+xRJ+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAASaF6wVb=c2mYJDqSdjbGD2hQ9CdbxmEKopVoT3Aniy+xRJ+g@mail.gmail.com>

On Tue, Dec 10, 2024 at 02:56:05PM +0100, Jan Stancek wrote:
> On Mon, Dec 9, 2024 at 10:30 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Mon, Dec 09, 2024 at 03:47:17PM +0100, Jan Stancek wrote:
> > > This will install C library, specs, rsts and pyynl. The initial
> > > structure is:
> > >
> > >       $ mkdir /tmp/myroot
> > >       $ make DESTDIR=/tmp/myroot install
> > >
> > >       /usr
> > >       /usr/lib64
> > >       /usr/lib64/libynl.a
> >
> > This is super useful thanks for doing this work. I could be missing
> > something, but it looks like the install target does not install the
> > generated C headers that user code can include at build time.
> >
> > Am I reading that right? Is that intentional? I was thinking that it
> > would be really useful to have the headers installed, too.
> 
> It's not intentional, just noone asked for it yet. We can add those.
> Would /usr/include/ynl/ work? Or do you/others have a different suggestion?

/usr/include/ynl sounds good to me, but happy to see if other folks
have suggestions.

Thanks for being open to adding this; it'll make developing user
apps with libynl much easier.

