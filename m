Return-Path: <netdev+bounces-72548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9DA85880F
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 22:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BDDB21CDC
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 21:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32235145FF8;
	Fri, 16 Feb 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SIo2CdYl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0FE7135A6F
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 21:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708119146; cv=none; b=gSerbnGjNIRePBXliR3+yf/z8JpXZuxr5jQ1bzt0g5e9/osr72g5U7FQ/Gg2pPEolFgy+P4musseV5R5/4Bk3Ovfg1xjnsZw1z6JCnIa/5Ri1ZhkVYHDwTH1i3zP67xdF2GQUm0iIHOSBW0AXg4mhBSsAo9ulrsul0AZzOt9ih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708119146; c=relaxed/simple;
	bh=BaWe4bMmpPNIFme2TB4IMKoF4JCB3A9aQpd7EHxHVYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ahijzRau0kLqFW1GDmNPwAOeYQ12xTVA4I4P5zjoJl5ciHPvF1BI7Ed4WkpxfB0KBhWwHniBZceTaGfdoo+3Bmpuflndpqut3Z+EO2vwONNw2PtTQ6F097UZXAeBBcIlmRT0S8SbtcmsKRI7a7G887wGkbvZsvFDa4nI0UeKfco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SIo2CdYl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e10303de41so1200417b3a.1
        for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 13:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708119143; x=1708723943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6sXIGyK5fJBS6Ih9dubAjV9UnamZEvWqzmWKeqKFQcw=;
        b=SIo2CdYl4o6nmM8vf4cuQewqFnKbwwWRSwN77XgB1+PzXvqjRUrLRab4SmfaZiN/XD
         7yUWNUCxdfYd6gMCfQxG8lK2pL5WYuT43kr0TdSMSn7KPvX+zv8Hs9JO3m1rPosBckKa
         9+F+rKUAsTtdlFlVoAzy1MDUEZe6gktzJY7Ek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708119143; x=1708723943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sXIGyK5fJBS6Ih9dubAjV9UnamZEvWqzmWKeqKFQcw=;
        b=hIq1GHgQwfkdEUWmUVa3oKVAW9PWuIywCfVvEpyh8QkcSXF5bI6idga7eC0LIO29uP
         zntOOAKMooU22aTV0LCwsE31JsdUOuD1vPIhJm03bRuZCeIbIu/zTaTuW0cJR5KbqJ2u
         2Vi4Fg3wbKxJRVCu7pt5GSbYEy+UylVR43moC65b6Jv3/ZcmpB46LfokdDv4XhTSVl6K
         1VeQTVRiH1jPItEzht+c9O4av8UVWHCxk7PqPvGtNkp9T0DaVvX7/uQVeJyNVvM/QnM3
         YmLCx1gPpBZ+NpojTe8nYpyhmg0Kfk6mIUYSdNycHATzRwJTyTwFzaL2119BCaDd+gNx
         S2yA==
X-Forwarded-Encrypted: i=1; AJvYcCU+BpH62uOniqKVvYf+lMieELiXQ/7g9tjr7VmmjSm7kYW4IKiZ6V7SGSLV1O3OozFI1H/cgGpffyFe4iJ8TSyTvA4mLOJw
X-Gm-Message-State: AOJu0YzCyPZ1GmCtIoJnkF0yXGMECyXNgfaJM8Zxk8NIEe1jmtIaoRLd
	yUs8Xt1eSUyT6gXCJKMZThg6/dIflDP3v0a0HX+q352O3iu6HqjC7QIqTYhWRQ==
X-Google-Smtp-Source: AGHT+IFuEiX6j8DiaCOSSkq9g3NAQytMa+JQBiTjrmoweTW4grnjh79jt7WMWs5n6/iVNwUaQiRcVQ==
X-Received: by 2002:a05:6a21:168d:b0:19e:9c82:b139 with SMTP id np13-20020a056a21168d00b0019e9c82b139mr6259963pzb.45.1708119143182;
        Fri, 16 Feb 2024 13:32:23 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n12-20020a63ee4c000000b005dc4b562f6csm361538pgk.3.2024.02.16.13.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 13:32:13 -0800 (PST)
Date: Fri, 16 Feb 2024 13:32:12 -0800
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: jakub@cloudflare.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [RFC 0/7] selftests: kselftest_harness: use common result
 printing helper
Message-ID: <202402161328.02EE71595A@keescook>
References: <20240216004122.2004689-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216004122.2004689-1-kuba@kernel.org>

On Thu, Feb 15, 2024 at 04:41:15PM -0800, Jakub Kicinski wrote:
> First 3 patches rearrange kselftest_harness to use exit code
> as an enum rather than separate passed/skip/xfail members.

One thought I was having here while porting other stuff to use XFAIL was
that in the strictest sense, XFAIL isn't like SKIP, which can be used to
avoid running a test entirely. XFAIL is about the expected outcome,
which means that if we're going to support XFAIL correctly, we need to
distinguish when a test was marked XFAIL but it _didn't_ fail.

The implicit expectation is that a test outcome should be "pass". If
something is marked "xfail", we're saying a successful test is that it
fails. If it _passes_ instead of failing, this is unexpected and should
be reported as well. (i.e. an XPASS -- unexpected pass)

I think if we mix intent with result code, we're going to lose the
ability to make this distinction in the future. (Right now the harness
doesn't do it either -- it treats XFAIL as a special SKIP.)

-- 
Kees Cook

