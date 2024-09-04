Return-Path: <netdev+bounces-124763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 701D796AD5C
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 02:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2400C286A10
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 00:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EDD1391;
	Wed,  4 Sep 2024 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZQ+LGyp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30DB63D
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 00:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725410014; cv=none; b=qqxnV9si6FbcdlEiDeBX1EIJ+IG9G4Gqw9YDSX6st54CxdUE8NXRDVd215iCZ7E/XFg9u8dhxMx2T9Cl+dfe9zDCXCd/++GbDhvbg2A8FpHIMrClTjSg65KKULRUjgMpfmoHIzm95NqBX3uGDA+3B56/s/eVw3HlQyb06i2/Z1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725410014; c=relaxed/simple;
	bh=CzgQlRJr9rAJ2MdGG8WF+bMaAfgr1SvE4ciqA7vIpeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MK8vkvraq5orILPYUs6pLZdAmcZPGpk+JLkRbpEckKirNlvDEopl9le2n+vDQMb1M1VKQKcTOOY1RanRUl2gJKgFgrgg6luWG+BccNBDTPKdyb8xdUeqHQ0KQPo78oggv35P5h3AUpTIaBkBUeCeUPOOnjGGWtOENnEN/l3+VZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZQ+LGyp; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2068acc8b98so1985855ad.3
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 17:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725410012; x=1726014812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WI59uzm1moL4iPsVjEvl0NoNu7y5rQEQOGvd2a7a/nw=;
        b=BZQ+LGypuoSrhAmGr/olLzkbC6fWaOZtCpi84coOAseyEBH6DpmrKwYXZjIWbXEGJY
         IKhVfJVqvAeqmxKXGckIVaGRknJrvCvZRupm4Jp0+b25BASLzDNj9QB223HiVK2oyCN7
         MVjPNktZ6IPIAQdcjET0M6l5n39aKwHrOa0NanFiZx2OzBZ7h0ZFTmALiiiQWM98RFkC
         nWIAj+/aLgpfFCwF3qA5Bp5CmhtaEtf5mY6avUhJD8AOl+yVs+9Ht8mMiYaX+laIbEq9
         Z8twA2t3xP8ldTaDiviAnmtw8m8+tggfdMrfXDAxV892ZtZC5nzEbO2i0UkWgT0SIUBO
         ZhSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725410012; x=1726014812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WI59uzm1moL4iPsVjEvl0NoNu7y5rQEQOGvd2a7a/nw=;
        b=ZjaxMVrOMqrZNvfVgMbWuCxsMFKt9JXmD+MGjRVw9Kxr++JpIqDu7081glxNkdq72Y
         V1gKTqLrpJ/h54WYqzXy3HjpfpW9oQ8E3OQ3UeF+PCpkOC6RmxKDiqw9KpXhzY3lL6us
         +lf3W4Uxfs0sRi+HEvGz9cyzbACqlrLqDrPcaFfRYKarDPgsDwOOA6UnRrSGyX3fONDC
         FJ6ZrXSbX0G7ktQm15EwU7zfcN/2hcfU0GQ14p7DwdnXzWwZqF8sQ9jAmHkMVsNvp/QP
         8nlx/X8z8FzznWuz+ZVKkbVJztLlRKMCO8dpOR9Tu2q6WAp9Hjj7fyORt2nfp/n3i/cR
         /rdw==
X-Forwarded-Encrypted: i=1; AJvYcCXbtXGreij/4hLBm1HY9WTJfZU2uT2Rokr32l/rPIvNFBQa0hoIDi5czBwkslqIHzf4fCm1rNQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAyKxGebwvQn+PO6Fn9QPfQQ3K/hhu8dTbs1f8xeKOVUGs9XG6
	1Xd1JoCn1R1E8whSEWtrdiGfs9xSwQ/e+cIGOrVKmpugNeRUPV6Z
X-Google-Smtp-Source: AGHT+IETBHRzbwy/s7QZkLhcQoW5QoFqfpsBkJfSt7Ttm1pG1Qoyq4YPJeGN3gd7+5WUJS1o4Sp4/g==
X-Received: by 2002:a17:902:e852:b0:206:94f5:c2e6 with SMTP id d9443c01a7336-20694f5c61amr45187175ad.7.1725410011997;
        Tue, 03 Sep 2024 17:33:31 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-206ae950571sm3729785ad.82.2024.09.03.17.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 17:33:31 -0700 (PDT)
Date: Wed, 4 Sep 2024 08:33:25 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Tariq Toukan <tariqt@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCHv6 net-next 0/3] Bonding: support new xfrm state offload
 functions
Message-ID: <Zteq1c8TrrqoGlfC@Laptop-X1>
References: <20240829093133.2596049-1-liuhangbin@gmail.com>
 <Zta2eKJAMY-7fZzM@Laptop-X1>
 <20240903085647.77460623@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903085647.77460623@kernel.org>

On Tue, Sep 03, 2024 at 08:56:47AM -0700, Jakub Kicinski wrote:
> On Tue, 3 Sep 2024 15:10:48 +0800 Hangbin Liu wrote:
> > I saw the patchwork status[1] is Not Applicable. Is there anything I need
> > to update?
> 
> Majority of the time seemingly inexplicable Not Applicable status means
> that DaveM tried to apply the patches and git am failed. Seems to be
> the case here as well:

Hi Jakub,

Thanks let me know this. Looks git rebase works but git am failed
due to the xdo_dev_state_free update.

.xdo_dev_state_free = bond_ipsec_free_sa,

Let me rebase and post again.

Hangbin

> 
> Failed to apply patch:
> Applying: bonding: add common function to check ipsec device
> Applying: bonding: Add ESN support to IPSec HW offload
> error: sha1 information is lacking or useless (drivers/net/bonding/bond_main.c).
> error: could not build fake ancestor
> hint: Use 'git am --show-current-patch=diff' to see the failed patch
> hint: When you have resolved this problem, run "git am --continue".
> hint: If you prefer to skip this patch, run "git am --skip" instead.
> hint: To restore the original branch and stop patching, run "git am --abort".
> hint: Disable this message with "git config advice.mergeConflict false"
> Patch failed at 0002 bonding: Add ESN support to IPSec HW offload
> 

