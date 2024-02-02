Return-Path: <netdev+bounces-68495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D23847072
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:37:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5CB0B23F9A
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 12:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E8B15AB;
	Fri,  2 Feb 2024 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WA9w09VI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3517CB
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706877432; cv=none; b=GGCmWdX7X4rVRlsmn2rh8SKq6rWSRQwbhWiOlT44phVdUdeJ3MCgiN4b7kILmDim+aOA4k0IMO+XXNBMEQKfDaiNlruXZNhWYZcQZ9ZmajjxsqCBj4LzKg0c7uFrsAjfx+WsYi/m7ZGRMQSiylwUyIwPI3Xs9r3CBO2AfDb+nfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706877432; c=relaxed/simple;
	bh=GdzGA+MahHarGb+a6bLtFISOlF5vzDA5hSoYPVCW06g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRfm3AHCZguDbTJWk+LA1qtsxu7F367FAAZXyE7Al0X5d2vBPnuXs4X8H0aLV7aW1P+StzjApWZk27rE79nEuumIBuzL0hLl4bG/ajvPKXsRdHcelIV8NIPKNunJ6iMfVYdN9hD/eDubsIQ3MdcvUmkyYHMY9FAdcVveJpAqiKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WA9w09VI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d944e8f367so17531155ad.0
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 04:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706877430; x=1707482230; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BzExnY+BSXKtnmVr4FWOuXIwVIZZZQL7D8sjJqlZ2lo=;
        b=WA9w09VIIyW3uW8Qxf2GH0Qza0TQsjftUQ0b0nFjaQyID3UM7bLrdFV6wRTczjjPDJ
         6tFpFTaxdToO6n/V3sHcUNMYIq6UT2OhcPk44HxnQKNikjpZo9tjecOhRiWy4r0re1K+
         8GI3FjeW3gcv3DY6RbhOe9HSrWCbJ+593aqClwAztvNtKun3DFxC2p1LiC2rgmQAH/av
         joSTyF3ZXexz4cHohOKnunTBVyU74h+mVVRo/QyqyRFiF4k+eXlx1MhVS35jxBR/0Atk
         yyvOxGdcTXFhFeROG5gfqz84rOdpj96Q6UuOj0yg91EX4EsqH1v4xGToblk3ImfUnKHx
         PRiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706877430; x=1707482230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BzExnY+BSXKtnmVr4FWOuXIwVIZZZQL7D8sjJqlZ2lo=;
        b=tkpCLfcjfk93Ve5HqAPL5uGJ86tNSIipuU7XuS4Nhb3K7Bjd7HzJXkX0sszZU+E5xv
         rQ9xA4dPV616euK0P77sM/azHnU3kmmkMnv4rrMF68kAe0SZw+2Zhvb2zBACsAhEmLeq
         yqRXSBVpcDWQ2F1MmQbrL03E4WomTWTZcTaBa0TeXkKysKIqQUnqBh7z42zO6tKPaxwV
         Fqnx6kjKUu9KJhiBO48KprcIxh6DClUyZpZdzmFx+ZuD/gBKWihNyDtTxV7rZl+Z04S1
         yVpZale9gW7F1Bgzt8bb1iy0+yO0RnPnV9XPnqomCSQ7H1151BY2dPUGJVLgjyshWg6G
         P/3A==
X-Gm-Message-State: AOJu0YwA8g83Oob2/URdNhwruAVXNh56c6+khYOocDIycSwq7G8/Hftk
	is0rVGUPwvWDvD/8sgND3SPZRCl02eGAQWZ3p9QThMQaPz+lloba
X-Google-Smtp-Source: AGHT+IFZUFr8m/lefjowwtF7VcEirLNOvKPNhRyZaSPm6mnia8tvdiyUgHXFTQ3setQxGot6ccf3RA==
X-Received: by 2002:a17:90a:bf88:b0:294:2c87:279b with SMTP id d8-20020a17090abf8800b002942c87279bmr4299670pjs.49.1706877430326;
        Fri, 02 Feb 2024 04:37:10 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX1uVwfg09BT/g4rvOuffc97jY4QL+3iCERP+7te6qdsXtNx+3vsE/xicBUcF/nF8M2wd7/oE5EQbhw9BX94IifJQMlhW1wpwR3SNhSqo84WEjyglqMjrgJPLXfZh+YG9hzWZ5x4aZ60LXcNrbzft7vU8vbmVh/dykkLwg9b+ptjSn8smZeqAbSVayP0Hc8nPveI3qLSfQ3tizydeplrpXyVa0gsUc/J+XZVV/yBMCoiN28s2bKRJWA2PhFaNBv+tnFHcfdrbPYuj+Ok912pVS7vwEgFr5UnbxvLOkg2DYA8b2Vlb/tDxhrFyww5YzVwJAJ96E=
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b001d91849f274sm1494764plg.134.2024.02.02.04.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 04:37:09 -0800 (PST)
Date: Fri, 2 Feb 2024 20:37:05 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
	kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	sinquersw@gmail.com, kuifeng@meta.com
Subject: Re: [PATCH net-next v3 5/5] selftests/net: Adding test cases of
 replacing routes and route advertisements.
Message-ID: <Zbzh8Q8kj0KEBgq5@Laptop-X1>
References: <20240202082200.227031-1-thinker.li@gmail.com>
 <20240202082200.227031-6-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240202082200.227031-6-thinker.li@gmail.com>

On Fri, Feb 02, 2024 at 12:22:00AM -0800, thinker.li@gmail.com wrote:
> From: Kui-Feng Lee <thinker.li@gmail.com>
> 
> Add tests of changing permanent routes to temporary routes and the reversed
> case to make sure GC working correctly in these cases.  Add tests for the
> temporary routes from RA.
> 
> The existing device will be deleted between tests to remove all routes
> associated with it, so that the earlier tests don't mess up the later ones.
> 
> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Tested-by: Hangbin Liu <liuhangbin@gmail.com>

