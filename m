Return-Path: <netdev+bounces-185667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C35A9B470
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 18:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328D43AE967
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 16:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE5B1AA795;
	Thu, 24 Apr 2025 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="gjV6eh7Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69AE27FD53
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745513246; cv=none; b=CKWQ3/5dNRad4VSLyPJnC07T2bQ5nUsFJ8OJY3kIQ1h/vZKggPJFith0hGL2+OJQ6G6fn5s1CTKVAiwDKcxwiE9xIAoj3M/tx7/2yjo+sew7pDEeNLRyWORrvJtdWf9rqzhalfjpfz4TvjxgWQ2s+s1P2nvg4e6vRrmZ3NG7m3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745513246; c=relaxed/simple;
	bh=wkz9kqw3OdWBo2L2FFerXuhl3CRtugInlBjq5qBFlrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OiO47XGJk0ACiG4qFXfF6t7EIYdRCQK/ZiFSc5KDZMhbnbPUyReP2ELyy5qmW8q2IA6sC+cQnNBjNeg1C9emPbdjQU49Jy5iJr0bJCuh6muy50Av+K9MPJFKPQVPTs4DGe5CuO4PNGebzk77xjE5nc4rGmt7cYj7nCOk6Fmmn24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=gjV6eh7Q; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2295d78b45cso20304665ad.0
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1745513244; x=1746118044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6+sEAf6H032WeHPc4GTl93oHCucndppdcfnevkFmfko=;
        b=gjV6eh7Qv5YFNyn3248x7ohNwlXrXpiDGT6nKw4wZuZIhjmkDD0iEvhy3EVQXP7l/U
         rJoiYxumW8ttyC5OkcuOh9ijdchgKeLp9DHzyfuDzXkLhgrPuWxGAM55WMXFxUIPYWWd
         c18YzZiFbDH6x+QT95s5M+aDleq/I6ajZBMEg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745513244; x=1746118044;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+sEAf6H032WeHPc4GTl93oHCucndppdcfnevkFmfko=;
        b=nVlB/8mretBsj1Agt77cf/Ozqljm7EJKNxpx+oI+EWuIE4LUpMYVrZB1KoC2VhR73r
         XKyB5a7DA0nEkG+bg2Y7IrtKEHLKW9+d9Wx8aQk7UiqFsqTWoiIg7OwOZ3dyXVtYtvVE
         oI0jJqYtSjiU1/pltgTZMMRqtwexbceVbS1Z36YcG4C34/aONqCW28LGa/tF2SSNYYzc
         THMgiFYwwIovdNEpdHMlb7zy9GLFSwRvfCRdB331/iXUjesS/qJ3NaXb9CXA9JHD0jMA
         Fxx24rh+GisfZhPQbwggRQ97TQFJh3voMiPvBbpGQnsPku7JOWu4paxKB4+WENyGfyOC
         JpMg==
X-Forwarded-Encrypted: i=1; AJvYcCXRvkb2fSmf7gz8LdRhKcH7wCSgmD5bliOInfl/TUKEDiHEZ669jKmj3IW048sJbJJxQigM0Co=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVgo4O1WrKseRL17Tr3Gk7+RQzK+e7c9adLEYPOb5588N4D2c
	DWWO4fGK3DYEQMLzebBH7tB9DM8O9tSJXUpyhNn6i+FhJ/rM1cJmz/3Bzc6KijQ=
X-Gm-Gg: ASbGnctaSZKXP27cGAsYnzKaviyzeoGjQLOTKIflRV1aR9PmUjie2xCsbqnmcT//0tr
	xNZreIwvVFdMXpD1K96b84tsCY9dRlNNvRV5v259Lj0cT8ym4Z77IceD28oxZm2QYeKiYBHF7qD
	Pod2XMbAiDBWaXZAqq5PtNrwJtba4cbXjuGdqnrRv90QwMfxVNvFrniWcF5tjsUd/5LQpZXJ0Qk
	kvnxG8ptTj6V4Mi54jDMsJt2Ly+hba9iUp8yU6zaT6tPM0rSYUyG6MXTpqAuZMevxFb9dkghH0H
	wQi5VgWq9Wr3jFYAAQAdeZsX4ZOxOr9OkL6OeXQJH0ecs/vYsMsjC10/IUX7D8rcSZt3C+K7oZr
	he3I4rwWNUI/F
X-Google-Smtp-Source: AGHT+IFojv1WAE1hdZFJ+LTllz61r91BmMZVgxKfeiezKuM16wrkO1DD9dc7ub6TP8KZVud0efvpaQ==
X-Received: by 2002:a17:903:1946:b0:220:e1e6:4472 with SMTP id d9443c01a7336-22dbd418b9dmr2391505ad.13.1745513243884;
        Thu, 24 Apr 2025 09:47:23 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76dffsm15860955ad.30.2025.04.24.09.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:47:23 -0700 (PDT)
Date: Thu, 24 Apr 2025 09:47:20 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>, donald.hunter@gmail.com,
	jacob.e.keller@intel.com, danieller@nvidia.com, sdf@fomichev.me
Subject: Re: [PATCH net-next] tools: ynl: fix the header guard name for OVPN
Message-ID: <aAprGMeUQLj177kr@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org,
	Thorsten Leemhuis <linux@leemhuis.info>, donald.hunter@gmail.com,
	jacob.e.keller@intel.com, danieller@nvidia.com, sdf@fomichev.me
References: <20250423220231.1035931-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423220231.1035931-1-kuba@kernel.org>

On Wed, Apr 23, 2025 at 03:02:31PM -0700, Jakub Kicinski wrote:
> Thorsten reports that after upgrading system headers from linux-next
> the YNL build breaks. I typo'ed the header guard, _H is missing.
> 
> Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
> Link: https://lore.kernel.org/59ba7a94-17b9-485f-aa6d-14e4f01a7a39@leemhuis.info
> Fixes: 12b196568a3a ("tools: ynl: add missing header deps")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jacob.e.keller@intel.com
> CC: danieller@nvidia.com
> CC: sdf@fomichev.me
> ---
>  tools/net/ynl/Makefile.deps | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

