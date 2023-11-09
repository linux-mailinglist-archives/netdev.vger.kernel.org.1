Return-Path: <netdev+bounces-46726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC96E7E61C5
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 02:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C7E1B20C26
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 01:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E45B67FC;
	Thu,  9 Nov 2023 01:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyLy8Pzz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8070DA5F
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 01:17:48 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B9125B6;
	Wed,  8 Nov 2023 17:17:47 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-28019b66ad5so249765a91.3;
        Wed, 08 Nov 2023 17:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699492648; x=1700097448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lBNYzqasXDmHMz+y+gn6jPytXIm3L/47ou0r+HRqqJc=;
        b=NyLy8PzzSvJp9c9giMQEEXbRSb3HGrc2N5/nb8BAhV+adWYiMdv7FcNfMT28PxuvFi
         5UdKg50w35s+ypxlOlfYDTRuXhMOliRIAkDqKHwfErI42uFPFLNjHqAtRVa7bFtie06r
         oI9+kSBCDKLsoA3Ct7DddpSe8putnJkAdWRXhOL0Cllv63Abu17H91ROqnKv85HR3mml
         +LQDWOZ5lT+62sWhEpWxXX6FKmkDKXDlUfkEnFyhjSD9o9VAkbtPevEaTMQCYJyrsAwU
         i+jXOBwOzDKiIcoXdsQSZ3t2myO2cg7APfpB3VlsJSwlvHKymMDana2cOiXcOk3gKmII
         C0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699492648; x=1700097448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lBNYzqasXDmHMz+y+gn6jPytXIm3L/47ou0r+HRqqJc=;
        b=SiR9QjyM7kr03KVxriCTHsbiFN24sWf0otHqWW+DdUxnGhGKq5HE/rLtkyFnu0cHgj
         h+61MNDGwPco8epXEKwPEZq7DO+QpnkF0glBwWdQJh/ENhG7XPt/3mjakT4AUr2dvbq+
         x0wXk74mZxw3p6iEt7AgykwpYQhShhpPm6iubJqveUQKy7/BR0ZXoBdy5qdmCwNScom2
         BvnFHKlrTRXD062FTISdOdh0NOCDaxVcLNKErEkNFzMrtgHfCuKjII05FHyQtSddw/pi
         0ChLV2Pd7uIyOhd8vk9GTXI0Xz1Y/YdGXRPOa3LrdGPZbx/pg4igpAydXkmXFOspp2fa
         iJiw==
X-Gm-Message-State: AOJu0Yw/CCJqyoWCKEw3NMqKEZ+ZADBPGUS3DPYsZK/790EM7+FnUYJh
	+2loRh60ESZ5+j4fr3iPtwQ=
X-Google-Smtp-Source: AGHT+IFtqOgYbckOxuYGwXLv/tmibGyLbwZS6E+0CzesNWUuL+fiyRstimVdz8h++jB5d+pnkp93Dg==
X-Received: by 2002:a17:90b:4d07:b0:280:c4be:3c85 with SMTP id mw7-20020a17090b4d0700b00280c4be3c85mr308973pjb.23.1699492647732;
        Wed, 08 Nov 2023 17:17:27 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 11-20020a17090a034b00b0027ced921e80sm153671pjf.38.2023.11.08.17.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 17:17:27 -0800 (PST)
Date: Thu, 9 Nov 2023 09:17:23 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	netdev-driver-reviewers@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Simon Horman <horms@kernel.org>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [ANN] netdev development stats for 6.7
Message-ID: <ZUwzI29bQB7G9yUP@Laptop-X1>
References: <20231101162906.59631ffa@kernel.org>
 <ZUt9n0gwZR0kaKdF@Laptop-X1>
 <ff7104c9-6db9-449f-bcb4-6c857798698f@lunn.ch>
 <20231108083307.364cfe91@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231108083307.364cfe91@kernel.org>

Hi Jakub,
On Wed, Nov 08, 2023 at 08:33:07AM -0800, Jakub Kicinski wrote:
> Now, CNCF has a similar setup: https://github.com/cncf/gitdm
> and they do share their database. So I use that, plus my local hacky
> mapping. Unfortunately the CNCF DB is not very up to date for kernel
> folks.
> 
> Hangbin, according to CNCF you're at Red Hat, which seems sane, and
> that's how I count you :)

Thanks for this info. Glad to know my email and company are mapping correctly.

> I brought creating a public DB up at Linux Foundation TAB meetings,
> but after some poking there's no movement.
> 
> It would be great if Linux Foundation helped the community with the
> developer/company DB, which is ACTUALLY USEFUL BEFORE WASTING TIME ON
> SOME WEB STUFF THAT DOESN'T WORK FOR THE KERNEL.

I personally agree Linux Foundation should maintain a developer/company DB.
The developer could submit their information on a voluntary basis, instead of
letting some tools search the website and collect data.

Thanks
Hangbin

