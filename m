Return-Path: <netdev+bounces-141257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 270519BA37D
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 02:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D4BCB20BAD
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 01:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA935588B;
	Sun,  3 Nov 2024 01:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="LXlc3P0g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7644500E
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 01:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730598646; cv=none; b=CTonkNtGKUI12NlgQU3LJyQqQkmCvfprSEGANlAzVoyIsgkCzcGod8T1aAx8U4q+1jk6ghuf3YO6+q8gfJRKySZRtjoV3lCekWLv7K7+rn5nbWGfB9XoYlzoitQlBED0vDpqwatcDCEMB05bevOuUyGXt+3D/LgdnNNRC7aazpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730598646; c=relaxed/simple;
	bh=EBs5gl7N93upcJIXXwrDgIci/YMFdfn4ptMpREAlBNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ha37kYJuShonkj7D22mdJsSj6azLPgo1Ce/L74fSPE9FGRSuIseQBPRshJGgsBKjyYhLwTJyL0/relGMO1ACWPricXwqFvvzpEQfF9Xs5CElreRxKsvcg30piOoKlCKu340/M89Yi0c2gimWrg2xTUefGZkxsnMdrN6gl/JYzYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=LXlc3P0g; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e2e2d09decso3051277a91.1
        for <netdev@vger.kernel.org>; Sat, 02 Nov 2024 18:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1730598644; x=1731203444; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q3Pxis2muyr2ltVxVCPzj+ieXZtWSMkxjvBW6HHZ6bw=;
        b=LXlc3P0g5MEdc8K1kdFuwNyOPNkFAOgp8kIPDHv8+1CIl85QEJOcfQv7Rfxty91uXE
         an6DEgYGZjk4H5+fRP2wRojD/P6bMbkBP2cUxH9LrY3m4zXZWsHCp0Tvr9SbxniF5Bpc
         E2K/xt3INbVVDmy0Cf7Ui33pRwmpwDQAFhKdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730598644; x=1731203444;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3Pxis2muyr2ltVxVCPzj+ieXZtWSMkxjvBW6HHZ6bw=;
        b=ibpEbbHAzDDp22UZL2WW1tu/zF/INnJfIUBDUljxxuuaLLNJ8gXkUFoLZOEeqUMz8J
         1MyrKBbR3gfTW7Mk0GojfgJb8Eaj7GhCDsNeElWdAR3bMvJKLD3RuOY8tm+xAZ5y7WMQ
         uCwTpF69rXOelxHdCEBoZbbMpUsumcmVkRCpUECGhJtTg7gN3PhlZ2Wy+cGltA7LVp24
         R+SBoCkrchw8lb6LfOkMVi3brx5b7b2gpfg35tVlCSLk/onPuPhrK3064sqJEdr17ZBR
         pVyg4QW1pNnsT3SKd1aOxTzgfOrqmB77SG5H59tRqpASYomwzlozF2EPxhUTooekc8j1
         ENIg==
X-Gm-Message-State: AOJu0YzUPmVA2qQ3MTUHB4KJYzSAL4Aml37EpdOcNX3Fu8goK+zCUFxz
	xTy+mtAx64fB0S9tVwihuFbQfouIpEWa3+t19sS1jqnCcPKcj5u4XTr7tLdAXfJn+gU8mdc4PSF
	t
X-Google-Smtp-Source: AGHT+IFsHnbXf1U3NgvkcpiLAfPsPJzjVhKBCWplOF+ORDTLneObrD4bFY9HYjBaYdBSMDye9dYOCw==
X-Received: by 2002:a17:90b:1844:b0:2da:6e46:ad48 with SMTP id 98e67ed59e1d1-2e93e058c03mr16960867a91.1.1730598644112;
        Sat, 02 Nov 2024 18:50:44 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e93db1890fsm5002054a91.45.2024.11.02.18.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 18:50:43 -0700 (PDT)
Date: Sat, 2 Nov 2024 18:50:34 -0700
From: Joe Damato <jdamato@fastly.com>
To: Hillf Danton <hdanton@sina.com>
Cc: netdev@vger.kernel.org, edumazet@google.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 0/7] Suspend IRQs during application busy
 periods
Message-ID: <ZybW6uMXrted0UGF@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Hillf Danton <hdanton@sina.com>, netdev@vger.kernel.org,
	edumazet@google.com, Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org
References: <20241102005214.32443-1-jdamato@fastly.com>
 <20241102235121.3002-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102235121.3002-1-hdanton@sina.com>

On Sun, Nov 03, 2024 at 07:51:21AM +0800, Hillf Danton wrote:
> On Sat,  2 Nov 2024 00:51:56 +0000 Joe Damato <jdamato@fastly.com>
> > 
> > ~ Design rationale
> > 
> > The implementation of the IRQ suspension mechanism very nicely dovetails
> > with the existing mechanism for IRQ deferral when preferred busy poll is
> > enabled (introduced in commit 7fd3253a7de6 ("net: Introduce preferred
> > busy-polling"), see that commit message for more details).
> 
> Pull Kselftest fixes from Shuah Khan: [1]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=7fd3253a7de6

Your URL is missing a query parameter, id, and should be:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7fd3253a7de6

which is "net: Introduce preferred busy-polling", and so the cover
letter is correct.

