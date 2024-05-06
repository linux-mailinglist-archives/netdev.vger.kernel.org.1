Return-Path: <netdev+bounces-93794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 819978BD390
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 19:04:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CBC1C2185F
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 17:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA1B15746B;
	Mon,  6 May 2024 17:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FnMt/DXd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D2D157461
	for <netdev@vger.kernel.org>; Mon,  6 May 2024 17:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715015050; cv=none; b=IHQKBIVk+ZpwWOWfbkp7eGR8YrZA6DiZOGzrat74mRykxTNXqKvVQW9FvuVmWCyaO4rizljT5GqMRYFWcUZ/fIbAjd6/B3iVXwhWRFuze24aXts0bZMRwSZqo6QrYVAUkhHcw3DZGaGBdsXlh3HcpK5X5rcnmTCYEgecyTG2658=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715015050; c=relaxed/simple;
	bh=3ERVaimfa0RavbCwXjVsALhYs2yHgjOMIPHx21z0Fkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzEN2V/+0f9iS16b5Qb3SsFWm76EltwylWU15bmD02c0iFZdtgM3g0hVHbwbZot0kA9ziwP7WQbJitQHZExP6HxJWDDpZ1UeOw01u10Kd5k1EaI81ZMkGN1ABGKRo5XBBgSG57wd/xFl16CZ3FHObao5/J5eyJlZP4f4jn7MVLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FnMt/DXd; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6f460e05101so1237275b3a.1
        for <netdev@vger.kernel.org>; Mon, 06 May 2024 10:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715015048; x=1715619848; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nh5u78QHidWuEv3zxf5mnHEaLauXii2ZAlcYYCjkWo8=;
        b=FnMt/DXdhjIG36+E+qsCRWpYuSxiaksnl0gHPWNtnZNLJsF9SiY+ANP9zonlJxosNG
         jW9t/x98ejoZBy0zi4xW2ZAFD7leuFNxxUoHxOK2xNnluU9muFHrI/f/BWwm4F5scD+8
         cBioL9A5GQ2tcTRlZzCrcMQLq6zR9KpG0/LnA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715015048; x=1715619848;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nh5u78QHidWuEv3zxf5mnHEaLauXii2ZAlcYYCjkWo8=;
        b=DGSddP5EjSUINGPhaxus3Cs79Darfj/wiI/gpB5yHM/QbiEY0Ax9qyeEWKss2mK5qQ
         yFkypMJQYl3CbTiDWEkU+/AZJPi3yPkGXvZyCJaeCXckKz0xt7Tx+01+6p6u6kS3qi5T
         /WWfvIqEINNZGfwIuDszxZ9cywkZo+/FHW6Lptq+qfDUETxB3+YsSbiKLaJR9roh5QDN
         q/0PM+r+gpMw+WEUgNDuIET/ebywnIdVUetRSW06vQwWfsgaEZzgzYIq974P1SzUOzWE
         /YPFQjkvN2GFMpW+PQskAcYXRTgOqlfjNE9s/t/6KfKFvJOtz0G1CCVu+mexfUyom7hV
         wy7g==
X-Forwarded-Encrypted: i=1; AJvYcCUAKnyXEZe/7aaP7qDe6N6ZXSsh/ZTVetlgwre/20WiokyTWw6eW+snPBCHAIBFVFNfn41RIvNOQtHgsp9XEvbOJj6YnC/w
X-Gm-Message-State: AOJu0YyvX0xz9U3m6/I7d4C1jWsD87gCvKcNVoej8+gU63dI3H/GmTdI
	41HRuEalSbt6yzj9IEe2kFx8HKFxNKDfmIB4zsbfegC+LmsTrEBg8VyF+aLbsQ==
X-Google-Smtp-Source: AGHT+IHZ19g7EIIbe17uKRyz+Ga9/paMlTkZAc++bhrs3f5TO8DSdkyHhZh5qpgkkcFIrfHkocR+fw==
X-Received: by 2002:a05:6a20:4393:b0:1ad:7e68:570c with SMTP id i19-20020a056a20439300b001ad7e68570cmr312144pzl.4.1715015048352;
        Mon, 06 May 2024 10:04:08 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id e14-20020a62ee0e000000b006e724ccdc3esm7945562pfi.55.2024.05.06.10.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 10:04:07 -0700 (PDT)
Date: Mon, 6 May 2024 10:04:06 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>, Sasha Levin <sashal@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Jon Hunter <jonathanh@nvidia.com>, Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v6 00/10] Fix Kselftest's vfork() side effects
Message-ID: <202405061002.01D399877A@keescook>
References: <20240506165518.474504-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240506165518.474504-1-mic@digikod.net>

On Mon, May 06, 2024 at 06:55:08PM +0200, Mickaël Salaün wrote:
> Shuah, I think this should be in -next really soon to make sure
> everything works fine for the v6.9 release, which is not currently the
> case.  I cannot test against all kselftests though.  I would prefer to
> let you handle this, but I guess you're not able to do so and I'll push
> it on my branch without reply from you.  Even if I push it on my branch,
> please push it on yours too as soon as you see this and I'll remove it
> from mine.

Yes, please. Getting this into v6.9 is preferred, but at least into the
coming v6.10 merge window is important. :)

-Kees

-- 
Kees Cook

