Return-Path: <netdev+bounces-219218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3EEB408DC
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 17:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748FB3B408E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48631314B6C;
	Tue,  2 Sep 2025 15:23:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9552A31353F;
	Tue,  2 Sep 2025 15:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826616; cv=none; b=mB//TJquIvhsx4ko346nvrNaVuRueRPsjPKgMCnintnx7TkOLT5aHm/PG5gStFKRsZOp2qGds0IKFTvuU8523r+znKf7LfRpGVq7aDEQKZqEJzE+TmduUEgd+qMX8I5+lpY/UR5qPuS+RVbXc3kpUFUBsbWfVNZGoOpiK23JNMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826616; c=relaxed/simple;
	bh=djnGVHCYiTjuSia2u0q6T+YLWCnZ+7UiAkbLWyydC5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJbvrRdyLELj5XTchsIG2PHIpBnigp/iRJ3fX7BX3vEy0ltb6BNnjTLEsolBWYrnxIF+MtJlgcG3qRyHgE4vQXUOh1sU/ZJwicVTgY5PwBlYWPxUVxVLVGmqFMsYvIF//lallxivsoVPt4MZeZSl5KOxKL+JeEVewIWxjUIT2eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61cd6089262so8911167a12.3;
        Tue, 02 Sep 2025 08:23:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756826613; x=1757431413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djnGVHCYiTjuSia2u0q6T+YLWCnZ+7UiAkbLWyydC5s=;
        b=mljS9MLzDqQNHHOCc1Nc1J/wsfP6GMSxoaoNbxT5jCUpDxfTvIyYKErQykEaVRBYvb
         LWGgqGfByv0fEaKq4wLUaXloqe3l6eLfYs4MRB3wtmEhJK8g22Mf8igFrhgu35XZLEVh
         RmfKppELGelka2XZEB/4qkgpYGSMkzh6gJ2AVpCvHBNQrbYYB5S/mt72b7FuPddmQ7G8
         uC8QW28BsQFvmeCOpZAGEHTa8eX/hU9vZw5JPsphTa20pI0iNoWWLrXKNS6zL1QJOUKi
         IHJQYEjP87tlciAag+q6IgzWsDGUO4CKYD9Ie4O3oRNuxvCdUjL9DgF1uSYLIVg+nIqv
         yVyw==
X-Forwarded-Encrypted: i=1; AJvYcCUS+7tKm363tXPOyMUmjeUOdU82bm357PSbNcDv+tdKc76W7IivS/g0pSfsyRv5BhSF98hD2i+ySZo0tTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvktiBbVywtqZ8MmZjUKAn8/LhpmZmKzMC/2mPo/rOJ4nOk8v0
	9iHxMoRV+f2sIWyZ50qMo7nsBqfiupVjKiiwQGEwRu7DoEIFsGqCRhY3
X-Gm-Gg: ASbGncst4zbRbTMCBkU4nABOXQr/Ro0WO0OSeU0faYS5IjEnG2IxC+pRIZjgrNhE819
	8PjAajwMphd2f3wQi1PK5m1WOa2gQafrH/Wvq7FxZuu7ONhiSSN522IT3OwOU1O2LFhn+msYMfa
	R59+PQsmmce5OeLJ9nzgCGHU8FW5UFKZQq+Km1+JhQurW0hPrD0tnulttVW8uf8c/3itpm0ef5Z
	IGvRc8j43KYyQfjDgCxYsbYZsxRvCBPG1Jo7jDfgxj56QLvJpettJM1WBFEJX5rdbA5DwFYC4JE
	vVHgjs5KQj/civVTZ88DyLTiTAYgufgG7TpmUjoaYE+IbHa7l8Rh7qORDLGRyoNtjHRn/qL7ixk
	lWWCXQAgreshM
X-Google-Smtp-Source: AGHT+IFHMWo3wDGvCkq0RM0mWV3QHrM0M52EgvwyERBSosR5NrkjDWOlCm4CFx8yli0QuWlqhLx/Sg==
X-Received: by 2002:a17:907:3cd5:b0:afe:23e9:2b4d with SMTP id a640c23a62f3a-b01d976afb7mr1389440266b.43.1756826612615;
        Tue, 02 Sep 2025 08:23:32 -0700 (PDT)
Received: from gmail.com ([2a03:2880:30ff:8::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0413782b94sm703116266b.35.2025.09.02.08.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:23:32 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:23:29 -0700
From: Breno Leitao <leitao@debian.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, kernel-team@meta.com, efault@gmx.de, calvin@wbinvd.org
Subject: Re: [PATCH 0/7] netpoll: Untangle netpoll and netconsole
Message-ID: <7eqeiq2k4kg3j5442pm2zzp6bdflqui6bmwes3f7bybyizbc2r@n6riekklmd7x>
References: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902-netpoll_untangle_v3-v1-0-51a03d6411be@debian.org>

Needlessly to say that I forgot to tag `net-next`. I will fix it in the
next revision.

