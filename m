Return-Path: <netdev+bounces-146638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A4DC9D4CA2
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 13:15:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41E5128320C
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 12:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE15C1D3197;
	Thu, 21 Nov 2024 12:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQy8ElbA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341171CEAB8;
	Thu, 21 Nov 2024 12:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732191354; cv=none; b=IGURV2DcBEW9Yy4k3WMazAF8B2A1gz+cw54NFNVkzs76d3rfJleQYdF6sqbHC/XUtib+QyUPwvaxC2GMBKmmKcnWtIIsWMfWj0Cbj2KNa65oQnD3Z83O8bdFHIErfRrZpilMvaTBPIZdNUUitg28lwNOZdo1Vd/K37CJtwj0GfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732191354; c=relaxed/simple;
	bh=SDIsbIJw3gxkYLO9xc7OQIkC2OhZhRUpQhL6fssipQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VETafWG8rNgYLTiCfwfC8oo0WcqVo/UfXNjQdLH68MdPycotkGpzFnUYc/T7wAzF1nliooBlmja9IwiZvmq1wxXbc7cfUq8xQsHHj0FDZ521vgGOyFxHcaaTXW7B4SHPmnvjE+CMDppAaxGcrWeFXar2YnCly9yFbk0F8quHpUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQy8ElbA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43152fa76aaso384235e9.1;
        Thu, 21 Nov 2024 04:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732191351; x=1732796151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EsqmlGkU160gyu0B5J8qHuqRhq9RtAQjZILv1YpjDWY=;
        b=aQy8ElbAu9k8/Km1ooyxC1cxSIjCYq4H2GF7Px0RJK7FIcQvjM7m9m/CJf5nEHOrmf
         R8uXf7/3WS6UAf2knMaPXFf2GP5L0VKtetsj05X0Wy0G0hjpcPLhJmv+T7EaCP1ewCmy
         2aAwgDK3TuNEItlT2iWdMAWLom/AcqqLsIEYaKYIOg/k2tM7NPDUFu40NRWaoBeVY3b0
         lUzRH+Nc9h22dFTGD/uDFFmvqEiDIqDbw0OeRXDgdeKmMXmCOHnh4qAcF0+PL1Zi1eD6
         CfCgfNTgRjlvmcVRYa/47GSg2iizyXplHppm2LJ0K1Ysk/2P1GnB02cX6HBwBcGxtm6r
         SBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732191351; x=1732796151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EsqmlGkU160gyu0B5J8qHuqRhq9RtAQjZILv1YpjDWY=;
        b=YZ6pcrhaHyxOYugEMbXNHpoqO7Ra3mcQW4/FhBtz+KcfdMI/hr3/wxKZ4/JV9ReU82
         ajgUtUUMxUQn4ZGTc9eOnJdNg2ktjU12P0rDoxZpvuQI2OsojtmFsz+cfeu7JKJ5mnRX
         k4DCPcRayTWfXKiExwS8YpV1g+Cxr6V86kSOj4F+NywkgY+VByQZGyPBq+gXdN6mouzZ
         qCzqTVVOsQoU0PbTamfKSGDdsspi++1IE8AZxSs1LTOHzbwQmGBDI2k3NJhE6sMCscDa
         afV8hHwWz99s6Fb37YRS6czYhSAdwOo0n2mFy4Crks1urrW38ZD7DoA/ZH664FlIGHS3
         ojDA==
X-Forwarded-Encrypted: i=1; AJvYcCVexJO4aII0LcE/SKu7Hu8UvmL/eSY/WEf947CbI9pYlfNWgNpNF1z0HBtjTnpSNT0zjhF//8nys7yZbsQ=@vger.kernel.org, AJvYcCVi0lI7+iDIYkDxYax8ZcrBdKwGdtLusd1Ucx48Ib77S0JKKRqwHzLpEUrhtgY5jM2g/G0PGrDQ@vger.kernel.org
X-Gm-Message-State: AOJu0YxYjEd8qMkE/G5eTKpDRAKd4tFMy3gqMQJSNNWWQwSSSolPG0N1
	s6PaexZ6gaeBtiSWFtqCg0k5kXJFbaiclp2HSrlWbOS6PEttlY73
X-Gm-Gg: ASbGncv/Re0Yg6JgNvTx8zqNZSwXT6t8PHU2ffv5HD/p7K4i9RNOlZajVpEgZC1lIxR
	7re8oeh482XcsnpY4ADxp8Wr/mNQ9GAmWiPLWHRWT7hNyxKVnorXZ6y6zYH+dTbd508+bXp6qGW
	RW52fCxOYvQgefiV38OQWXlzYGHqtMTludcEeKhygFmbz4XajCfRN5QlHe+zv6H8aNg/SEj/S0i
	89ZZQNQ7XzK6oX6FhLOwWpH3F7wSINTZBaGkqc=
X-Google-Smtp-Source: AGHT+IEoGCN9chsc5RwTfzAgurnmlEprVGtYfnhVSkjIglYAd861gpQP3mOWcX1SbRN7wDA77XH29Q==
X-Received: by 2002:a05:600c:1d1f:b0:42c:aeee:80b with SMTP id 5b1f17b1804b1-4334f0230ffmr23047205e9.8.1732191351152;
        Thu, 21 Nov 2024 04:15:51 -0800 (PST)
Received: from skbuf ([188.25.135.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b01e1046sm56866425e9.4.2024.11.21.04.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 04:15:50 -0800 (PST)
Date: Thu, 21 Nov 2024 14:15:48 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Cong Yi <yicong.srfy@foxmail.com>, andrew@lunn.ch, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phylink: Separating two unrelated definitions for
 improving code readability
Message-ID: <20241121121548.gcbkhw2aead5hae3@skbuf>
References: <Zz2id5-T-2-_jj4Q@shell.armlinux.org.uk>
 <tencent_0F68091620B122436D14BEA497181B17C007@qq.com>
 <20241121105044.rbjp2deo5orce3me@skbuf>
 <Zz8Xve4kmHgPx-od@shell.armlinux.org.uk>
 <20241121115230.u6s3frtwg25afdbg@skbuf>
 <Zz8jVmO82CHQe5jR@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz8jVmO82CHQe5jR@shell.armlinux.org.uk>

On Thu, Nov 21, 2024 at 12:11:02PM +0000, Russell King (Oracle) wrote:
> On Thu, Nov 21, 2024 at 01:52:30PM +0200, Vladimir Oltean wrote:
> > I don't understand what's to defend about this, really.
> 
> It's not something I want to entertain right now. I have enough on my
> plate without having patches like this to deal with. Maybe next year
> I'll look at it, but not right now.

I can definitely understand the lack of time to deal with trivial
matters, but I mean, it isn't as if ./scripts/get_maintainer.pl
drivers/net/phy/phylink.c lists a single person...

