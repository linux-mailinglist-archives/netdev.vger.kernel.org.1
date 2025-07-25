Return-Path: <netdev+bounces-210166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F38D6B12387
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2C43B3659
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150DB24291C;
	Fri, 25 Jul 2025 18:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8PYGoBo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18DA1B4F1F
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 18:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753466830; cv=none; b=EbtooNjV5E2Be3dfjXJ+9bgHVXgtc5CrxIM20SxgwsPoqafBpZgzGTfk+FJxFjAadozdD0oNrGvKh0Hj8EyVHUOJ0N2P2vgQJ185/xMSpIUKWQ5MovvUxl+q+dty9UQq8bCN8dJT/KtjkhrDawQ8RrLkVw/egl9ruFNR9nOdPZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753466830; c=relaxed/simple;
	bh=uDBMbjG9ra7NtXRmRVwfUSvMboJFJpEx41Ab7xMwcRQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou1oD66OkAWqgoaqrzrFAhSGzTXmcAam9IvFD5BR19IIftKJbqIzduhEKu+F9Okv6lHzT1dT585ju3rr6h1r+ijEyDrQveSWr7l3BfCvGi39KO0RekxE4EZxypcxE4bnntVs8x1o0vNDLY1R8uoh0HUnuyZQtHIw4OS1YZi8Qu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8PYGoBo; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2357c61cda7so14505ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 11:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753466828; x=1754071628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Axl/Upysq1imNPEh2OI9EDM4ev294X+qNbv/okR0n58=;
        b=r8PYGoBooSdTG6IiqbcxXJPp10Xottv7+GU0sAoMy4lzJsN2dHr1eSAYR9Dnqp7Ovr
         AzU+uRRApZLMbJ/b906HDIXl3bt2v/hvRdvJlLIlFmgoHQLYuD26+pEBL8m9NRKxVLan
         232aps92lw3796XOfwFKDvdGdf/CMnNSYEgH+w7du6sMvxa7h0Kjix/BAEbf2m+Ae2CU
         V+/1uzJgpNXF98HHoZoo5/98yRvSKEjdOebBUjcVgPc+7kph5GjLDejLxWZv/mSs/lb7
         SQQgvmBM9A/SKUfY6pc4fjeI3cq29SpwFgBHKjbPkT2xLgiqG0KXdnIMnpAYwbOA/hdE
         ws3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753466828; x=1754071628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Axl/Upysq1imNPEh2OI9EDM4ev294X+qNbv/okR0n58=;
        b=SEFhHCx/6a4KU9IkF+WUH8mS2GsHdjJihpyJveHVj/vu6E+AS248ZJECZLRhVrp868
         E9a9t2H+2Lns4fXJJrZtRm5B4jBfUgrYe1oIb3UZ/3WzfEn/+MF5N16PzeVInhyoGyrb
         J7canVDnzkD9U3AQt+qe+LgE0EYsr7CVZNXcJ7SNz7h8uUmj1UAypVsMVPcdhTvZRmNH
         w+wmOVEcs5WY14gXZU6eFMk7F/vg6ekw3IWjqfbTtXLBf3XXxa2bvA1U6f0twnZneMIv
         EufwcF2NN5ppI3+fJw1WS2EIX9kbddZ7zW6a/rd3TdOYw+Yi95V75zQ/a+n/Oytj18fi
         ClBA==
X-Forwarded-Encrypted: i=1; AJvYcCWPSDV1mZ22+zJK39bZ+prCr1yeIigm9KydmSR3ydC2qoyB2tTqt3Xfl6yfdvNFXDhXwek3aPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNiLb85A3Vj4bbG3fANrGW52GIkVj5BqG63S+aaAyddyM9LRSI
	0NkJ6rdlff27uUab+YF7XpAlTxiHRf8EFktA7mVTiEvztTFx7b8UgPe+7bThGlNIjQ==
X-Gm-Gg: ASbGncuV+W33NQkO/UGDOQoNC/bnBSu37hLTnpqUMhlDYGsX2xaKX6iJ4obLTF5e7i/
	Y6mY8svo8XPt6IRvtMN6LCbSCFkL44taojB5iHeVA//464XC3VAQSi61LHeAy62dvG5syk2j7V6
	4zKlCLoJE+0dysu96rKMmGz35WrqQWPUaNVReXi6GYTYLExy3hKuHSErDiVSM8jHT/SdPGv0uew
	7h0LCnNCm28yeajuynPPd9MtdFcCbKbWsSXvNaKPR6w4/faSgc26nVCrxY5SU3NXAwHLbDkIMnh
	jdn9k+7fsYtIDvyOuUFfDgKT5GP0hoosLra4MOEYtrZjUbH0x9qIGl/FMwF/hPIef4w0jFEpyqp
	MNA7W755E955c7rgj8n3jcosPE5CNyBubFa11FbEmFK4R1PTdGrZ5klFcHp7qOxg=
X-Google-Smtp-Source: AGHT+IHjwe2gFYKYnkvseB2wuhGhO+XXYs2y6bsFgbqHX+OaOm+xTpI6Kr7srgOaQZoqEem2i7niEg==
X-Received: by 2002:a17:903:3293:b0:235:e8da:8e1 with SMTP id d9443c01a7336-23fbfd106b0mr119335ad.18.1753466827623;
        Fri, 25 Jul 2025 11:07:07 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640b8b063csm203175b3a.122.2025.07.25.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 11:07:07 -0700 (PDT)
Date: Fri, 25 Jul 2025 18:07:02 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Li Li <dualli@google.com>,
	Tiffany Yang <ynaffit@google.com>, John Stultz <jstultz@google.com>,
	Shai Barack <shayba@google.com>,
	=?iso-8859-1?Q?Thi=E9baud?= Weksteen <tweek@google.com>,
	kernel-team@android.com,
	"open list:ANDROID DRIVERS" <linux-kernel@vger.kernel.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>
Subject: Re: [PATCH v18 3/5] binder: introduce transaction reports via netlink
Message-ID: <aIPHxlM-hwTp32sg@google.com>
References: <20250724185922.486207-1-cmllamas@google.com>
 <20250724185922.486207-4-cmllamas@google.com>
 <20250725103858.109f1c5d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725103858.109f1c5d@kernel.org>

On Fri, Jul 25, 2025 at 10:38:58AM -0700, Jakub Kicinski wrote:
> On Thu, 24 Jul 2025 18:58:57 +0000 Carlos Llamas wrote:
> > +++ b/Documentation/netlink/specs/binder.yaml
> 
> We started running YAML specs thru yamllint since the previous posting
> (the fixes for existing specs will reach Linus in the upcoming merge
> window, IIRC). Could you double check this file for linter issues?
> We use the default linting paramters, no extra config needed.

Oh good to know. I just ran this:

$ yamllint -- Documentation/netlink/specs/binder.yaml
Documentation/netlink/specs/binder.yaml
  6:1       warning  missing document start "---"  (document-start)
  91:13     error    too many spaces inside brackets  (brackets)
  91:33     error    too many spaces inside brackets  (brackets)

I'll have a look at the incoming patches and will fix this as such.
Thanks!

