Return-Path: <netdev+bounces-192632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D9FAC0953
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8EA1889CDE
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA32356B9;
	Thu, 22 May 2025 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="u6qqIT6S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C4826A09A
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 10:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747908261; cv=none; b=K7IIYdCWaxDfwthZvVzGvM/hGiZzoiMuJlGkzG5HhWOel1tC8psSSxy80dX8/yw8B1SCsHayjTbqQO+EEZhqEjf3UMNEqcu2nRdfCrHNdEmhdZZmadMvrcNHhHWcjMkadf1j4tHqUHzR63MMqY9947O71Z6u/srMbfIsW0h0Zdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747908261; c=relaxed/simple;
	bh=bIwywdUYP3bCpcBbA+JZ9CR8iEuoDyGcRaeuZGT9Ok0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EefYbWHJJSxim/kVry/7IToKmF3eOPwPJQX1krpxttiCmG04xfjJ3wlufEl9O83qcIW6HOey9r8Z3az6SOhT53OLGM9aSuCeDlE+crDAZWvf2Ym/4MHW/3SB8mNH+oHTfYqaHSN5nIPD6q/cCUChkakVKSX7+DdEV2IPWXkMyLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=u6qqIT6S; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso1321777966b.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 03:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1747908257; x=1748513057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2AkbaIJvv1Eul+zPHe8qG0e8NedocBlHyKRus5KED/Q=;
        b=u6qqIT6SB71J1EMlb48TykkWz9g5xFHhqM0dYWfwk+TGdjl6FRBirmJ8gpbuEu6EvO
         vHHDL+Tmo/CUC1k/ADm64zh4Wgf15bNxphi0Gzs26/CeM5ICO4QbFvTXyf0gwo3W903e
         iiNX7P4oTUkVKT9Snm82VgchUU8dTIQNnVeRPYUA1W7TuCLzvjgvaoVj9FHAJ7KhC4Us
         UFa/k4rm6TTeArfAlAslJHjm3MvnbC7khDOmjX9j6uCABr3Izx6Bil3mUGO+mbUcP4Bu
         YAKKV22WpV/UXYDQQGcgFRHQ01kE5nT5M3Hjm4rnGWbBW6vfHKBS0w+GdXDVMo4u5CdC
         yf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747908257; x=1748513057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AkbaIJvv1Eul+zPHe8qG0e8NedocBlHyKRus5KED/Q=;
        b=KqYxeX7LSyLP9ZzyC+MPYsvZXds2SiarIpHYijxxeyCp+UTsix0QeO8jkJyA2e+31Y
         MNpESv0lYUkMe0d2GfVDWaT8YcFGehv5PSxPf+qRyGudj7QmFsfToEditlcNl8PLBsdK
         zYyCwc5vqiCkmkP7pfBnvJnaWGSongjQ5ii1gL6dMbv1D0jW+Ims7mnEvonATLCvSlbH
         eSe+eUsUZEx7VVSDjwgA8qAn4PFC6cjvHKyVSHy2oawvB0k4ghJC9cd5JHwWUvIsdl7/
         Mc4OLm7aQFwpmrtzPbwbk36fOaj9fHZffz0ZZgiXxovQBLkGBhHATzX1hGx3CoWdyZ4q
         jCsw==
X-Gm-Message-State: AOJu0Yxsxor4fa0hGYUTFOx28h+o6hyxTHVI4Vv9COCr7Kqgi3gKTC+0
	5M4vsFnZXfhsifulNROXaRncfz50y6HPGaZ59VbSm3wwoamLuNuv5nvVd3/ED/AJuBM=
X-Gm-Gg: ASbGncsVSrOT3X8tmjuaxNEwB9NquJUtSgqtGRRDfT4h7DjlJ+Irki1/NZnJa/XrskE
	zOPyVNeg0ZsXftrM4yaucQaIj11f97u01A255uvJ/ImzdXeO82lj5gRAZAE1vUcYmBMFa5a329y
	5hkUDfduInMdNEq6UV/ldxr/9H5EmnVqNp8SXlCQOGt5pIuNOqahRDP1PALSKneD2lDjfg6pnxC
	+cWil/k/2ZFtkD7VHV1RWVhmyJscwUW6CBVkPAgkJJiWKd42khaL6a6WNTBiI0b/DnQMxoyphw7
	pB3S5NV4E3xkvk6RW66JOi45le7ZT8dCxI+mkzLVuBe1IGkCCsioKRGBnJvfA4t/063aY0grzoL
	wRFSjcXJc2tGTww==
X-Google-Smtp-Source: AGHT+IF/dyRb0ujHvoNRY2AzGHfwzPMy+ZzeM/TxXft0WZCPoo/uAHAmNEckzjWxi93lFqzcQrpUag==
X-Received: by 2002:a17:907:d86:b0:ad2:55e4:454e with SMTP id a640c23a62f3a-ad52d5e07f2mr2414848066b.58.1747908256658;
        Thu, 22 May 2025 03:04:16 -0700 (PDT)
Received: from jiri-mlt (37-48-1-197.nat.epc.tmcz.cz. [37.48.1.197])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d43770fsm1072739266b.91.2025.05.22.03.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 03:04:15 -0700 (PDT)
Date: Thu, 22 May 2025 12:04:12 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Network Development <netdev@vger.kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Hillf Danton <hdanton@sina.com>, 
	Stanislav Fomichev <stfomichev@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] team: replace team lock with rtnl lock
Message-ID: <qfgrrkuo6bvkfhuhyk767gsrlkloactjeldlqgtwxpklwl54pp@a4cy5ip3m3kz>
References: <d4047311-5644-4884-84c0-059bbb9e98ee@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4047311-5644-4884-84c0-059bbb9e98ee@I-love.SAKURA.ne.jp>

Wed, May 21, 2025 at 03:38:55PM +0200, penguin-kernel@I-love.SAKURA.ne.jp wrote:

[...]

>@@ -2319,13 +2300,12 @@ static struct team *team_nl_team_get(struct genl_info *info)
> 	}
> 
> 	team = netdev_priv(dev);
>-	mutex_lock(&team->lock);
> 	return team;
> }
> 
> static void team_nl_team_put(struct team *team)
> {
>-	mutex_unlock(&team->lock);
>+	ASSERT_RTNL();
> 	dev_put(team->dev);
> }
> 

I don't understand. Why do you ignored my comments to these 2 hunks?

