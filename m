Return-Path: <netdev+bounces-210153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6D3B12303
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 19:30:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D331188DF74
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C412EFD81;
	Fri, 25 Jul 2025 17:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHIdx9MJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B4E2EF9DA;
	Fri, 25 Jul 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753464596; cv=none; b=WUI647kWMvXWyrCK4/dXOgX2PmYVogQBQZWw5/faG/rog2+wYMbGORX1qt5LwrDIHBrD3WwBmYqCZX5G7xl0uyZZEeBTSQV8XKtXhfvo1hDo2XQ0VMgjj9SklY/IN1ubq8Imwr5uthPh2g13n++iiM2hzQb/mKLa1SCf7001cSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753464596; c=relaxed/simple;
	bh=Ew2699Aur7BqrfPvdL0BDzLKcg9OFgGEOfpK+zuwD8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIP9gvSvW45gZBNsQ3gPFqTlVf/5WyX882JWWSgtjhO9MfjBYyb3Lue8dLRVJHqKS2H5A08ex5zpExzwsKeGOCIMLUMiaC7CW283Tr/GnnLfdLdZ0c6NT5/FC4oZAAIUr5bHY6qTTxmwrbGiSSFxTDtm+vmdrSxIK7IFTHBVW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HHIdx9MJ; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23dc5bcf49eso31806175ad.2;
        Fri, 25 Jul 2025 10:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753464595; x=1754069395; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ocsGeTsyVUnVv4DB7+4OU5ttaZP01qZNaqWEPBO9yjk=;
        b=HHIdx9MJGdgbhYOnx1Ybf7UF4Rg54ewwg/EBqXmGEl8BEuzL++aOfQajT7XcJuI0PL
         1usHKJWRCtd3Gsq6/PYlzofdwRAbsybMkyIfqMqPwkm1b8QVdiTt5w05IMHRQSgTe2zl
         fmHBhVKFcFnfb795DFrXlsZfx2KyWXY93a0wdJMlIfDwT5zHL7E1MyFgK4xzNs6O1k2J
         Dc138bM86iBY52xSWirekMBYittr9gZ8lYWkXzAqXLXJBSJyfdE3Xw5YhppwD3DZAl4l
         LtM4Znh49Emk37nPqHB3+ZV3+eJIlZ9pazbmBxLXWiqushUzlHOxa4Tdf6pfwWbCJKln
         zDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753464595; x=1754069395;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ocsGeTsyVUnVv4DB7+4OU5ttaZP01qZNaqWEPBO9yjk=;
        b=bZ/C24+uoJ3RNj0yKp4ILwu4rErx3QT9k4zYAlRngbE1CIT7apLDf5bAjOA4uLkqep
         igMg4+OyHrU75NRz6Z8RQmOHREYaNLuseLd05z1eX5135cSjJdJazesdSXURhR0KLR1i
         EzH6mxedi2g/OxF9HBtSUPKAu58Xofydh36Dyc9fSQ1e3m8NX9+s3qbPoEibN/OKEDqG
         uBYSBcY8X9+88LA2eo6LNTwe7dIY5I+uKh/q8QxAZiiA15lHb1DqVfumxEnc7NXEAveH
         /D2hjmrjzaKaldi60vrt3Q7Sgr8ww5PG/Uz2FA2gZN0GBIFJ+bXm4nuaO2oDmhC0a7xZ
         R/sw==
X-Forwarded-Encrypted: i=1; AJvYcCUWgCs6BgLonZuRWHjjoISG6D2Yd7tPrPAHYaEDr0Uxjn86Id3IiVM9iHeOuPXl0jtdgSSioll7@vger.kernel.org, AJvYcCWmexiD4OCTu+82BtAH3bdI1XosNpVYXN3Ohyj2eBQCmnvICt1Aow3fR4bRZCFPCPW48febB36/sPQmwV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMqhn5tfBnAM4gEUjtLn/jid3Vs2Nipg/BfBn/oxqj4xeAvy1r
	HLhb2htVPRq0FOqPkt2Qou0N2rGQ4XdyXs75piIBXYFOgCb+TpXyNqDT
X-Gm-Gg: ASbGnctEKVMjphZmzus16OfHpg6bnDENuSr37M16Se3+xta4Wfm8HqgyApNRZkwsEof
	kqLhE/NBg4PpWs0UAOTd2bT9/HN7StJlwwV26dLXCYC/6BdjEt69EHxG9fyuk3ef6WryC8jtjPq
	B+dFwj1OdWCt6RABM1LYtCKetLTn0IBF2Yu6Ks7IzLqPNsUKlXCs4Yt2eTQJdyYTWRm/E2eFjEC
	ux4g+qvOmDd1/4AK38C+zstqD3pOsGWWvW3Ex6P2t8VNtijXaAh5rF5TKIb93/XQZjKGiBDcoM4
	RlKJ5koFssJ3umtRFGSQhjUUzdUtu+yC8LF5Vph+LWYqkBW70b/5L4Qk99PUKqoLEGgDHfbtfY5
	UxQlq/XqRDAajPJuwVtxspvZ47Q==
X-Google-Smtp-Source: AGHT+IHWD7vh8tx2gBBN3mSirhqWjxjFgh4bXbeghjAwdgnsIbsk19Ap680Pptl+N8iGYoMnhmAIkw==
X-Received: by 2002:a17:902:f609:b0:235:88b:2d06 with SMTP id d9443c01a7336-23fb306606fmr38073585ad.6.1753464594701;
        Fri, 25 Jul 2025 10:29:54 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe585538sm1540825ad.211.2025.07.25.10.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 10:29:54 -0700 (PDT)
Date: Fri, 25 Jul 2025 10:29:53 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: huyizhen2024@163.com
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andy@greyhouse.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Discuss] KASAN: null-ptr-deference in qdisc_tree_reduce_backlog
Message-ID: <aIO/ESEgsCzBv/hX@pop-os.localdomain>
References: <20250723144828.664-1-huyizhen2024@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723144828.664-1-huyizhen2024@163.com>

On Wed, Jul 23, 2025 at 10:48:27PM +0800, huyizhen2024@163.com wrote:
> Hello.
> 
> KASAN found a null ptr deference in qdisc_tree_reduce_backlog.
> If cops->find cannot find a qdisc, it returns NULL.
> And if cops->qlen_notify doesn't valid arg, it will deference the NULL ptr, resulting in a kernel crash.
> Should we add a check for the argument in cops->qlen_notify?
> 
> Looking forward to your reply, thank you!
> 
> net\sched\sch_hfsc.c:1237 hfsc_qlen_notify-null-ptr-deref
> 
> other info that might help debug this:
> 

Thanks for your report.

May we know which kernel version you are testing? Because recently we
fixed quite some qlen_notify related issues, testing the latest -net is
highly recommended.

And, if you have a reproducer, please provide it too.

Regards,
Cong Wang

