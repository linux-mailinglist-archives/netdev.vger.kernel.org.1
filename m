Return-Path: <netdev+bounces-86051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4397D89D5B9
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDBCC283819
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656887FBDF;
	Tue,  9 Apr 2024 09:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcBSBaJu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25C7FBC7
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 09:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655680; cv=none; b=WY/ZPB1ajL9g60tAE0b3HJts++nrmhbO5nfNCkVX4oTsIjnLQGFpRzdgIklRxW2ndrRIyVJ/eBIXrptm2cPfBik8PiKHvMunkc4LRC6aZ03LGxPh/rzAYkL6I4odwwLOLc1/VSfv5EO2M3VklBN3WKD19Dxt8vH0TsPf37ltF9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655680; c=relaxed/simple;
	bh=4xya5FeQqTRGyTPCVmjUPLI5ivGHsu8Kn2vU98pXj6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puA6AE0auf5wNKi4DyIp7Bzy9z070h+QJlJMNgA4mL0+cYwWlBTPdYQUFEN8ESngtkmoQNAUCRgq8WLjanPI57TqAPvpYcjtKxdwwiZ6vAOUItrex2t1QOjwXEvSoNRa9YsQl1kBJEVrv7ee6YOfKZE/pdNh1+1/4DOKrGq6HdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fcBSBaJu; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e244c7cbf8so45025795ad.0
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 02:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712655678; x=1713260478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8+IJsg04i4TQJXgPYRONnYvBd6NEMpkMuddFkJ2CCNc=;
        b=fcBSBaJuML3NSu6vA0y758CGlk8V6GwLxd29zAv99GFLRbIAUngVa0MK79M/Q0z/5I
         nWZo6Rmt5F6Nm8e3DqUILuB0FCQ1TvK+C88ZVKX1a5CvvE3M6h+UPEaYjrJLTGkAagsR
         iXSVMS6tAN4hdj8qzXSvFLFX6SxveCSBPUuCIBdqOZIKm/e+YTsyVEggcUZSKuf6scj4
         m4gfovwCh8dmqM/evzBPjs3umrp1h8G1i8V47vzaE+xsm4YJnMbt/H3xLoKz3j5LEJ5l
         P7wwIvUbT3SqyxEjqzq5kHobZDBX7MTbC0y4le61SmQjEQZMGtLV8LubTqly1yOAe+3N
         YMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712655678; x=1713260478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+IJsg04i4TQJXgPYRONnYvBd6NEMpkMuddFkJ2CCNc=;
        b=mx6YK8qN0p8p1OqlNER/veD6BfPFqEYA1ic7LqXPbh8oDAVZBugRZW6k/4DrZrcFne
         tFW5/kA4reZu8BygtSYnCnmdRusV/S0/Z32qz9tqc8wnBt8QZ9A4BemrzUXxPdHUJuuo
         W1HGPvXcGvwBOchBS8/n1rKg6xtDkWFUpIQkN13lkMxeBHjP0MFeFlSmwTq0hOQK/gxf
         dRFAkERKU+J1+76SypX0PgYySCNEuBLEyb7ZkX/mAI121S5H+zIMapm28LPacRzaXTwS
         +ThsPodJDl0GtOM060/i7hGqsDo5IWkuQas3b/jk8FbaX6a4jqAbleuoihfC/UO/UXoK
         EQGA==
X-Forwarded-Encrypted: i=1; AJvYcCXbLjANodpmpEmEUuVLGNKwu/O6/c8mT08rpehPiRQhgu5I6GooDKX2CqTlCFC9vjRw7vIAFmdxd0zUKbuRsdNucCBz0Xks
X-Gm-Message-State: AOJu0Yz1ZSdRVVf/Zl9yXAgCBYIVQ8AbYxDd17Q0Rc1fYv3OeBS/6N2C
	xyLA88nD1gRxXmnj7nCOl3Ev+WbatcMZAmzulTa3oe0YK+bk6wtq
X-Google-Smtp-Source: AGHT+IGG3n1A1J9qZ/JDRaXOMa5IJaTYi/DWdJZbHxQwOMYRHbC0cRfSuqIxk28ByGfeYdlBpm5LEw==
X-Received: by 2002:a17:902:c3c6:b0:1e2:5e32:4444 with SMTP id j6-20020a170902c3c600b001e25e324444mr10250561plj.10.1712655678226;
        Tue, 09 Apr 2024 02:41:18 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x7-20020a170902a38700b001e431fb1336sm3419215pla.31.2024.04.09.02.41.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 02:41:17 -0700 (PDT)
Date: Tue, 9 Apr 2024 17:41:14 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com
Cc: Jiri Pirko <jiri@resnulli.us>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: team: fix incorrect maxattr
Message-ID: <ZhUNOvAuGLgvdTm1@Laptop-X1>
References: <20240409092812.3999785-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409092812.3999785-1-liuhangbin@gmail.com>

On Tue, Apr 09, 2024 at 05:28:12PM +0800, Hangbin Liu wrote:
> The maxattr should be the latest attr value, i.e. array size - 1,
> not total array size.
> 
> Reported-by: syzbot+ecd7e07b4be038658c9f@syzkaller.appspotmail.com
> Fixes: 948dbafc15da ("net: team: use policy generated by YAML spec")
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>  drivers/net/team/team_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
> index 4e3c8d404957..8c7dbaf7c22e 100644
> --- a/drivers/net/team/team_core.c
> +++ b/drivers/net/team/team_core.c
> @@ -2808,7 +2808,7 @@ static const struct genl_multicast_group team_nl_mcgrps[] = {
>  static struct genl_family team_nl_family __ro_after_init = {
>  	.name		= TEAM_GENL_NAME,
>  	.version	= TEAM_GENL_VERSION,
> -	.maxattr	= ARRAY_SIZE(team_nl_policy),
> +	.maxattr	= ARRAY_SIZE(team_nl_policy) - 1,
>  	.policy = team_nl_policy,
>  	.netnsok	= true,
>  	.module		= THIS_MODULE,
> -- 
> 2.43.0
> 

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git main

