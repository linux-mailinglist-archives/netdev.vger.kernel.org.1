Return-Path: <netdev+bounces-275973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELdkFaHx1GkjywcAu9opvQ
	(envelope-from <netdev+bounces-275973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:59:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F18833AE0AF
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 13:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13643306E596
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 11:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFDF3B27C4;
	Tue,  7 Apr 2026 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="VIY6zVo3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7493B19B4
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775562986; cv=none; b=P/xxDl7UY/TnO16ONnpoQMobPL1ibcTUfiWgibxF3R7FdxefPsCFF8wlKyRSQ2nqrSuf9WbgO0Rw4mah32JCbdj77Ajb9LhHrzVwTk8uAe/8DJIkf4lW65oJRHodjRcjDW36XuFnOMY0NpYHry6pVfXTJDbT6uPdCpZ0B2ZYwMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775562986; c=relaxed/simple;
	bh=H7zbzzpkWdvolmb6crqk0GIg2mSNG386YPSGbx3Tfbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwi+CnFOUQikQL5z57hYcp6ymfFEDiZtmOcwQR2rHXh/lz5aTwrBQOLE/8qZJ1wVh9t2GhMsJCLDxPN/b8lS0tt4hNgQ8zmIrjfd/hVO2qUdCt+0t+strYvIO+kb3h8gTW0cjFM24Hy/iZVsdzZqWqhmRWy0OiT3kmerU1QWuVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=VIY6zVo3; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488afb0427eso22166835e9.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 04:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1775562983; x=1776167783; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H7zbzzpkWdvolmb6crqk0GIg2mSNG386YPSGbx3Tfbo=;
        b=VIY6zVo302WMqpoPAFhKr1cF6CU0LXK++sYTtEcGBWzSkO7tDtXfqysRhVR4ESqmsC
         BSwucciQCkMHmoxKBKDQPNuNkFx9B/El/yjF0011y3Q8U3L57j9zuf+95W/TViVE3umm
         1E+du8rK+9tYgfOEVhRhbdP13TVGdDEvbhBGRfgAkz2XP5kKSsZiTI8EJUNzsvgHJOhH
         bf4JplK2Cga1cGQ/ma0MLhFjsL9ZPekFCOWYiZihHWRVD0OSf1+N5pkYn7UsePe/5bhH
         17UHyr+HPgLxjC3ZiWSWgq38S7pBih7zxFM8aHDcCSxIJkKqNlVoEazbhHuUmTE9ideH
         J6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775562983; x=1776167783;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7zbzzpkWdvolmb6crqk0GIg2mSNG386YPSGbx3Tfbo=;
        b=l1SpQNADfzS3c4p15QVpJlbXay/Bz58NKx1+M8g/E8jHjpvDYyIUqmvR0BOal5beCb
         Xh2FvT1lPZORIW9gNFT57sj7ckP00dSQ/UhHBWZxHTdSNXzl1SdjS9fLc22KySEvWo05
         S/7wFjqRGLtf5Di+ZSrGR4Mon/oaty5Ig4qqen3R81gtQFXsQQj+j+58cX+xVybKNTJC
         SQofGi6/QHIXtGql28ICxKE7jI0IU+dQhNkOtVhhqF/iasjdfhwwT1CrOPuACZlBgxps
         NXGAuvfnmZMNs3E5OpCySD2WbpnrXIDRFUDy8KHXL0T3q5sH1aysalNc9mFpCSeTHzRB
         be+g==
X-Forwarded-Encrypted: i=1; AJvYcCW404AklrguvS5M8D/JJBvLmXUkvdFK6TR0mv2+gP1AH6l/1vil+TSyAZBfddLIhCQ0whp+mb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfcqoYRP90UVKSA3UEU1wRli/0KrjrFqzpjs5s7jlh4emaEWhN
	uF/0x4U1lEhFXAZ1TFXaLlDiVych0ET429fcAn3ew+9FIHSsfBQK2DHZr9jOEHJG/RGVdY4WbpE
	yJMrG
X-Gm-Gg: AeBDies88y8v1UU8iGbjOKs51/Ua+kIDof0P+mesAzYJd6xhhwZ18SHTcE3iXZArx/D
	DRCKGE/uir4CWmHFKBwyTT874/9t1dvSZXFFMuY4qkbu4nJhOBpmIai8QIEOlEucRRtRQf+SLSp
	OyqyCyxAw5YeddqNcws9qj5Qt8B3RhS5IhJu4xPln+uuWgbWi7Yqr0ld3W/EjQORv1GSxDaqlkx
	Oss0fUAou4ZOddpAvI24J4XuYSH/mKjKtR98ywimmIwRMe1YRGSStZSWHwVzgwyGg0e43JAAp+S
	ft1DKDe7PQ32spy0lqUA4NgvZXAI3+LTy29sZecxx5UchF/pjxXwmAevPnBnf7fYPiZTkDnQ3R3
	D81WqdtNcrfm48u9wVNBPfSq0Qc24nAr4cDe9WLl456Ub1tEdqrP6vOPhHABjwi+dx0MUQ5MeqG
	pzgEzlmNPfO8rAVhv1EyBdGTT6IslWFpJMXCycw9vSpQ==
X-Received: by 2002:a05:600c:c0ca:b0:488:c14b:201b with SMTP id 5b1f17b1804b1-488c14b21ddmr13037975e9.10.1775562983600;
        Tue, 07 Apr 2026 04:56:23 -0700 (PDT)
Received: from FV6GYCPJ69 ([85.163.81.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ab6bfc86sm68832965e9.11.2026.04.07.04.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 04:56:22 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:56:21 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Marc Harvey <marcharvey@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net-next v5 02/10] net: team: Remove unused team_mode_op,
 port_enabled
Message-ID: <47aliebnag3lkiwijdvmzev34tgmwro2v3zyyvo3iljh6w4wta@7v7z5lmev23v>
References: <20260406-teaming-driver-internal-v5-0-e8a3f348a1c5@google.com>
 <20260406-teaming-driver-internal-v5-2-e8a3f348a1c5@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-teaming-driver-internal-v5-2-e8a3f348a1c5@google.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[resnulli-us.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[resnulli-us.20251104.gappssmtp.com:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[resnulli.us];
	TAGGED_FROM(0.00)[bounces-275973-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiri@resnulli.us,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F18833AE0AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mon, Apr 06, 2026 at 05:03:38AM +0200, marcharvey@google.com wrote:
>This team_mode_op wasn't used by any of the team modes, so remove it.
>
>Signed-off-by: Marc Harvey <marcharvey@google.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

