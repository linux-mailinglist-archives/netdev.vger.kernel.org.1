Return-Path: <netdev+bounces-196831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEDEAD69C3
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:59:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277031890399
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 07:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38D122156F;
	Thu, 12 Jun 2025 07:58:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1E221577
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749715118; cv=none; b=UgZHMvfqlUe52hjWoDTffJq+asxKoMkCd1ESESjsiJJ70tDWWshwq16CltJI3SShTvOp+lVogKpB4xolKm5f6j3VTw5RSMOS5Io/p/pZLiF3mBi4wBV15GXmmSGS0xB9ZKcCnF2+B35zK5wwgdEFVX6P5bcCVURj7mnGeU7mTLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749715118; c=relaxed/simple;
	bh=2sHopMgp7fJPjyCNLxV9Xv4S/OM+dTqXxsTzX0dRwUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KJrHwKp2f/+zI8q+rHm6m8LlnUWlBHl2d/9FXNyTejZt24tY97E9WeaWow0mFJaPr1GGeD6tMJLKOcrSMMIahovKCDctjGBnvqPH/kVXh3bQaMi15zdtnQU/A2Qi6VCk/vKw6rkl8whFTE5RzsiVes0nxafAj3zLYTBhJQJzkeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6070293103cso1266921a12.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 00:58:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749715115; x=1750319915;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7CcKH4dAxMiN65v89Cj1mYC4gizPmua1HwqmHo4LAIw=;
        b=Vf51JlZ+A1WiFN5SnC8drHQIlWHx/1nzQ7Sj4DeFGm6hK/CK4SfoUGQTSbEl6he5Iz
         mItp8x5VeaOR03ijcjCWPeEquTaWRwNcr5TvNw8WByeemZCuN3zvZaP8Rn2JcrCcs3EP
         SgEAMC6KVjnAM3lmWbJjxzi7ow8iAhBwP2WLmuecB3fhWt20+gdL3WIC9yEar+6ZenrO
         axL4erZluiFJP6z8NCNI5eCoYPJTGdFd6L77wvJ+qUbcYj+oQZazXCJaBt3XfFz4nHnp
         02nbXqITOobDHfbLGwIX1WMBxersfgk3rbSjd0nKtnlwTGvX29Cva00LMmfpfbYuoO3H
         0KTg==
X-Forwarded-Encrypted: i=1; AJvYcCWLfFPDqhT93eIId998LXaFIfr8Np8ekWIx1qhUi2rSG+sUGZRWx7Cn6eGo6E5Z5wcXnHa7V20=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCdrmctf97Ijjo51jT2hnDQ0rynpLmBjCZMaMIuo2dOp4xY63d
	6QTM2qrcP2bMCAeC8KB9wS7sTV0SmdZgINBsYwNXnGETaXhxsFlOob2tUYpc6A==
X-Gm-Gg: ASbGncusu/8YQKJliX15baae/gaLS2QrO4spQSpmJdnIimbZA7jsFJCzzO1Zpcz8utD
	QgvcaCWCdZgTzDnvCtoZaSGboe+/pmDizUCQz0gbavC7wG1LG9q7CKN39bWep3KT0a/CAmTV1JC
	LvaNIF6IUyx5jrJMPxHG8DXqJgBYT9Evi9k3/IXBWjGp4D068vAnURC47hgGVqKbQtZsQHFvB/P
	bFPChyuyHC0pB33m3wToHK5HHxQadlfPIKbTVgOAeQfbCAwxtgvB8skC17739KSWvu98lHKfdPV
	av+7Ji2o1J29JBqASH3MsUHhHXS21VY5N7//fHeQMrRuaO6RxLcRYQ==
X-Google-Smtp-Source: AGHT+IE2y8FgAh5msMYs7R4zuH1Pu55csSBzj9w3vYxhY8jH0mTN7tIOLZ3odtLtyRoF295x2cRyCw==
X-Received: by 2002:a05:6402:350b:b0:608:1670:efe6 with SMTP id 4fb4d7f45d1cf-60863b05170mr2736549a12.22.1749715114999;
        Thu, 12 Jun 2025 00:58:34 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:71::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6086a5517easm771309a12.4.2025.06.12.00.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 00:58:34 -0700 (PDT)
Date: Thu, 12 Jun 2025 00:58:32 -0700
From: Breno Leitao <leitao@debian.org>
To: Dave Marquardt <davemarq@linux.ibm.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk
Subject: Re: [PATCH net] net: drv: netdevsim: don't napi_complete() from
 netpoll
Message-ID: <aEqIqDwHUGcblXjT@gmail.com>
References: <20250611174643.2769263-1-kuba@kernel.org>
 <87a56dj4t6.fsf@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a56dj4t6.fsf@linux.ibm.com>

Hello Dave,

On Wed, Jun 11, 2025 at 05:23:33PM -0500, Dave Marquardt wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> 
> > netdevsim supports netpoll. Make sure we don't call napi_complete()
> > from it, since it may not be scheduled. Breno reports hitting a
> > warning in napi_complete_done():
> 
> I decided to go learn a bit more about netdevsim, and ran across a typo
> in Documentation/networking/devlink/netdevsim.rst:

I acknowledge the bug exists in the latest netnext/main repo. Would you
like to send a patch and fix it, or, should we?

Thanks for reporting it.
--breno

