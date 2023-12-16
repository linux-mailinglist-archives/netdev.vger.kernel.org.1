Return-Path: <netdev+bounces-58205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C03E8815873
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 09:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26B7D1F24201
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 08:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2276513AD2;
	Sat, 16 Dec 2023 08:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZIkuR5kf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB66E13FF8
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 08:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d32c5ce32eso19067845ad.0
        for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 00:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702716493; x=1703321293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjmSx6Jn/dX4k4w+fxRlnlT9PWNuLc9fYNccV0ebAMc=;
        b=ZIkuR5kf+mVAN919vToWyz+d5Skub8Ykddg3PDdyy89DDFue+3z74x7mio6woxDJfF
         44k9Q06uS2tEoyGtpkHMx7cFRsIEeFT6Toi7H82Q1KL6piFCuLT0mqfwl/GM46IjtMSQ
         9PEiTPtFL5aD9413IU6ozSj6sInry4fXYXisidqmk1cDLSTDjYZ7uWzSE+xO+OU1nm5G
         UCPlGvOQD9Hm35co0w2e+/HPck63B5vwISvKOhl6u4Y29+Lc2MFcsaCy9Ffd1R0Yx1BX
         K2jk4a91hBmhEuAt3Q1+0Mp/Q5xFbjp1/4uc7/AG5fEjP6W4GtjNEJDQ16bp4SLKYBPO
         4ehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702716493; x=1703321293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjmSx6Jn/dX4k4w+fxRlnlT9PWNuLc9fYNccV0ebAMc=;
        b=DhSAHwxEoSBNJ5dEr2NasX/ODRbT9FWUjLVysheu9DKUTvnJa0X6EENLHxo1BTnMRd
         aEMg11CYC4+gQFhZV5pGNfdxtwj1UOTsPfUG1kgMHo9leakALSpo+7OrTqTz5yyS3rBC
         KoBtGasgW3iiB5SiB8qEZSXgwt/EcBsX291a06QAJ0OCI5tUmz4NwlLTwHgZ2/FgpE4z
         CKEcMVlM0EhT06sEVbLpRr3vWOroJk8dxRwqrNfXsqMFuXiqGa6NnRtxgcqAGkiac959
         ntqrNxMvMDI1Knz5hjFN6JpOu0K7Z22MMK7ZmmQikN9JN2NSPbqxnfdH3SF912b+5WEL
         Ce5w==
X-Gm-Message-State: AOJu0YyCPPj4+vxUgy1ofXpRdp6ilXwIyhZbilOyffQJzajEreLbPLri
	wM6KhjNBrVgfDzGtpgzUlLI=
X-Google-Smtp-Source: AGHT+IGJjMDjfH4qc6nrQGGDC9B7Rw0ADgakdrpDa81VakhDrgO4AZtqRuiucxWqhupOY/ltIrHu8A==
X-Received: by 2002:a17:90a:7789:b0:286:6cd8:ef0d with SMTP id v9-20020a17090a778900b002866cd8ef0dmr16635173pjk.37.1702716493087;
        Sat, 16 Dec 2023 00:48:13 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o63-20020a634142000000b005898df17ea4sm14554312pga.27.2023.12.16.00.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 00:48:12 -0800 (PST)
Date: Sat, 16 Dec 2023 16:48:01 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Davide Caratti <dcaratti@redhat.com>
Subject: Re: [PATCH net-next 3/3] netlink: specs: use exact-len for IPv6 addr
Message-ID: <ZX1kQQKZ7BdTAG15@Laptop-X1>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
 <20231215035009.498049-4-liuhangbin@gmail.com>
 <20231215180911.414b76d3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215180911.414b76d3@kernel.org>

On Fri, Dec 15, 2023 at 06:09:11PM -0800, Jakub Kicinski wrote:
> On Fri, 15 Dec 2023 11:50:09 +0800 Hangbin Liu wrote:
> > We should use the exact-len instead of min-len for IPv6 address.
> 
> It does make sense, but these families historically used min-len..
> Not sure if it's worth changing this now or we risk regressions.

The addr6 in mptcp.yaml also use exact-len. I don't think the IPv6 address
could be larger than 16 bytes. So the min-len check looks incorrect.

Thanks
Hangbin

