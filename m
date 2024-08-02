Return-Path: <netdev+bounces-115227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1280A94584E
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA1A1C234F8
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 06:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00A1481DB;
	Fri,  2 Aug 2024 06:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="boHJRGA2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53F29D19
	for <netdev@vger.kernel.org>; Fri,  2 Aug 2024 06:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722581940; cv=none; b=AvZ21qrF7C1uXMmHSCoFxVqkOXCUoXM6XQK1h+1yqzPy0r8rLvzB4qRULmquLpoqSIfNU/GPOGRV4+BUVTsuPJCJET6rzNijheckl+BBHp2o9qmjFr2pxPh0XuR6xKeOeYQvHCffqfVuabF/f0uRn5UXfdqwK/dDQwgaXR3bqm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722581940; c=relaxed/simple;
	bh=eQAW/JHG4ChUKs07HIs6Hr4crTY7GhFxyYiFQjnt6mE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CQyi30eJlKhVWbIJk267gySezNcb8pp4ZFHQCXemLJuwxB9XZoNa3S4IbC4OydGinICCdYBrvRHfezkP9cusZKnRt0gpbXB5PWqBkLqmlUkIVDLzb/DxZvwGpaqxRYZkHtL2/q7FUYmkDLcYtX/+jCCud0oPJ1IRnC8LhFMWOPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=boHJRGA2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-369c609d0c7so5232380f8f.3
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 23:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1722581937; x=1723186737; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eQAW/JHG4ChUKs07HIs6Hr4crTY7GhFxyYiFQjnt6mE=;
        b=boHJRGA29HTMC9PCW7N+Ze8kPvI7tvbHhyD2RxaivU+F5lj0dr96nj0z6LAqbt5pqR
         /dmT47klcclLmZq8iCdces+lr5KJhjOSzrgfaGOQUUiyu7nTL0nCnUTSvFUl+3y3Y9nD
         zedzGTP+X1LlS6UwLAXCAMR81lXtqltiIimmyEb1iZDsYSdNQ4uLM4gnFIWAx89FFo27
         Ctvi5Brl52wbPWzRFlN/JmcGPB9Co/aIkGBKkcD28WzNu3MwWFTuTR6C/gHTv2FI7YIL
         jm2M7MfYrQibkELAiR3KwK4PW1knPGGF0UDfYbTgtpuaEq14P1lXVqNGjjC41dcIeB+4
         pUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722581937; x=1723186737;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQAW/JHG4ChUKs07HIs6Hr4crTY7GhFxyYiFQjnt6mE=;
        b=DXfm5/P3GQXBLLCBZZmvPSzoT0dLBqlRQx4+dVC/n2QJ9kT5+W6wrBzSUGTy6lKoKY
         EwAstT3G4BjQgzErdIxDu2av897PSkCfTgX2Wr6poDIY9IpcoAaMv4JiedbnTO8Lu5tP
         G1SzigEl5OK1xWgHPpbhhA83wXJDCStuo6eRH7SyQ/+9437udtU4d3klKcEqeSNQx5Lu
         9nH0Z0JG8CWEB/i4nVaxiF5Q1wIPB+0T16Z87Sw7b7nv4Zs89VIDWJaRRw19o6UeqzIs
         igOwzAu17A+60oqfuxc5IWNx4rWm5POJwt2i6xivsv4kGwbG3mhx3O2B3M3048psH1wt
         m73w==
X-Forwarded-Encrypted: i=1; AJvYcCVHhInnjLnNeotP97Zy99Zjx2W1GfKQja8AIFphFu7nB0174bh+x7v0VoILODoVnuDr+LdBuXson+PuSZw82VAkaPT5n5E9
X-Gm-Message-State: AOJu0YyViyiSv0jevVUaid7HPLQSU/4cFj6yt/UY/19sBseGpZqcCKBw
	IJu9GKwphcpvCSLtucAuMETJqVBD1pIEPkz8v6fpUSYC09SsMNFIyROEadW3heU=
X-Google-Smtp-Source: AGHT+IE2w11rQ1kHb5mMwdVod7/30dt8PFCQq/jfmh+IwZ1KnHQTV3MrkUkGK/13uzc8m8mBAnwPVg==
X-Received: by 2002:adf:e94b:0:b0:368:6596:edba with SMTP id ffacd0b85a97d-36bbc1a5586mr1769729f8f.39.1722581936449;
        Thu, 01 Aug 2024 23:58:56 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbcf1e97esm1174816f8f.37.2024.08.01.23.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 23:58:55 -0700 (PDT)
Date: Fri, 2 Aug 2024 08:58:54 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: remove IFF_* re-definition
Message-ID: <ZqyDrsiheWwDebsI@nanopsycho.orion>
References: <20240801163401.378723-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801163401.378723-1-kuba@kernel.org>

Thu, Aug 01, 2024 at 06:34:01PM CEST, kuba@kernel.org wrote:
>We re-define values of enum netdev_priv_flags as preprocessor
>macros with the same name. I guess this was done to avoid breaking
>out of tree modules which may use #ifdef X for kernel compatibility?
>Commit 7aa98047df95 ("net: move net_device priv_flags out from UAPI")
>which added the enum doesn't say. In any case, the flags with defines
>are quite old now, and defines for new flags don't get added.
>OOT drivers have to resort to code greps for compat detection, anyway.
>Let's delete these defines, save LoC, help LXR link to the right place.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

