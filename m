Return-Path: <netdev+bounces-127216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEED974922
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 06:33:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94532B23A57
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 04:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A00C37171;
	Wed, 11 Sep 2024 04:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7eg3rB/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18A68BEE
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 04:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726029180; cv=none; b=FkjTqmftbIJoWmLptn92jA6WgwGEiuO6570I1FP3UUNDSHDfkgFVT3YyEX+xhqwJl3cIYLnD/W+UA7XTaa6jDj3FdbWiCHP55rxyREEHO2qnStqcBYyxhA3dNtZ30EKRwUFAqEENAjCtW8COrCmaW2GRvxrF+v8f4YcTE3zQVxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726029180; c=relaxed/simple;
	bh=1QHA26DMatZE2n4NvcaVZ/clmjMh95MZ8F+rgteatBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4w0dAgGIojMQkjA/HVzTgFKKFe9CThEwrBhiH7x9Dpnah3TFk3mXKb0IGUy9skI7Ckg31l491HqBDjDxQkLIfJT0Za5l3OuimDBz+jg9K52gNIDaA1Pgd52MZC+yWTSgbIF6Xwqb9d1sdUz1+MWxk71ndMw0zn+tCDWmZOETnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7eg3rB/; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-207115e3056so32247345ad.2
        for <netdev@vger.kernel.org>; Tue, 10 Sep 2024 21:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726029178; x=1726633978; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iZPPp4AmihDnflrVq5NC+ml6tzKRW4UhTrHl+mZ/oJI=;
        b=B7eg3rB/1JMKj0D+rf87eq813pmUwPPMEEvh6lNuQNRVmSYmTL3h93ZNwGfQkKpu7l
         2fB6nyi1c/W7+hU0B6lMSz9eNiSexajPfP7npWEzTHPLG6hqs/GfB+JkdkffbD5GckPY
         LiuqwmH8h9QLcMTyWRFvTZ7hMSZ00BGkDzt0w3Izvgt5KyGwBjf9sgvz9PnW65/yVHdQ
         ezOQwrBv+ih/SfnCoGKvqrn7pevm8KxElFBxfsAclkxkzgeZov0JhRnve5mjrDMloWC1
         W9HRtNbAt/2K5hJ2poz4o2FERoDf6SQ7P5ZE23grpx/DRjp6f10R7ZBwumB0vSRcEsmi
         qbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726029178; x=1726633978;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZPPp4AmihDnflrVq5NC+ml6tzKRW4UhTrHl+mZ/oJI=;
        b=T21IHjahyLas0zrC3t556/NsX1JdcQCY+ZK8oqE5G1qekwV8aEPGXm8TRkN2zr5lPK
         9zP3a7j6cusj6QpRUqJTI2V6J5fjg4iWYQAi/5IgOu90XhYZmiOw71WWEEXXvh6/VUji
         IF+Q1hBLW2BxiyzvlMjx7HbBAly+DYRk7iXPwP8x95J2PYtxsUJe2fcpOCdjZNbTCgbO
         yJtv8CP3BQWgEPSJ00Tbf6xwb3Q/8ew6DN3JcxA2YCaTq05bWVMDJyk8d0EOB6AFNpx6
         VsvzKPv+2iYGfVJ4M/8FKLLiLHUmZDrK5PPWYv+bIsXn/1k+v20gb2lJdHUymBmlq2Q1
         FMpA==
X-Forwarded-Encrypted: i=1; AJvYcCVXSES9PV9M+mXN9GOM7HmZQWsuXbi1wGqO8gmqmBMSTCdIjuir2BD6Amchnq/loirDQ9cuauk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTQ+5Hr5iYTvBASzOtWQChiTExIPfG+JozKvTyfwO//CXHkNxh
	/2Suc6ywqMIchuMm5y+g/HqDZS7ajjzboBz4FR8wLRtGKZJDX8w0
X-Google-Smtp-Source: AGHT+IHa1cGnUEbMmg0AHsWwbRYRQzLNJixhowSWhsdcyNK0Q8uZmavw5OuUMy5VWzXsb62ZcQFCHQ==
X-Received: by 2002:a17:902:dacf:b0:206:c911:9d75 with SMTP id d9443c01a7336-2074c60fb85mr41433545ad.20.1726029177975;
        Tue, 10 Sep 2024 21:32:57 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:7cb4:335c:8e84:436f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20710e0edc6sm55793275ad.47.2024.09.10.21.32.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 21:32:57 -0700 (PDT)
Date: Tue, 10 Sep 2024 21:32:56 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH RFC net] net: sockmap: avoid race between
 sock_map_destroy() and sk_psock_put()
Message-ID: <ZuEdeDBHKj1q9NlV@pop-os.localdomain>
References: <20240905064257.3870271-1-dmantipov@yandex.ru>
 <Zt3up5aOcu5icAUr@pop-os.localdomain>
 <5d23bd86-150f-40a3-ab43-a468b3133bc4@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5d23bd86-150f-40a3-ab43-a468b3133bc4@yandex.ru>

On Mon, Sep 09, 2024 at 10:04:21AM +0300, Dmitry Antipov wrote:
> On 9/8/24 9:36 PM, Cong Wang wrote:
> 
> > Are you sure it is due to sockmap code?
> 
> No, and that's why my patch has RFC tag in subject :-).
> 
> > I see rds_tcp_accept_one() in the stack trace. This is why I highly
> > suspect that it is due to RDS code instead of sockmap code.
> > 
> > I have the following patch ready for testing, in case you are
> > interested.
> 
> Does it work for you? Running current upstream with this patch applied,
> I'm still seeing the same warning at net/core/sock_map.c:1663.

I never tested the RDS code (hence why I didn't post it). But for the warning
itself, actually disabling CONFIG_RDS made it disappear on my side, yet
another reason why I suspect it is RDS related.

Thanks.

