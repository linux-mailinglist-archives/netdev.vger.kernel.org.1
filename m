Return-Path: <netdev+bounces-147913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B25229DF160
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 15:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781692814EA
	for <lists+netdev@lfdr.de>; Sat, 30 Nov 2024 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40E819EEA1;
	Sat, 30 Nov 2024 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIhRWpho"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4714B19C575;
	Sat, 30 Nov 2024 14:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732978778; cv=none; b=flARtrenA6F/kCFsCnHjGljqYz8eXwn9Wg1cegoRwKwIW6RS9NggjW0RdRUfNFwS9Awked5w/7LkDGJC2yXBxiz20Ded1cFAmJE2NFcbmfBVYG7YjX7AlruSlO0GkI6jkyEvo0bXuKWcBNOuUm1+slDSvwxAEHyWEKEix48TOSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732978778; c=relaxed/simple;
	bh=URaGqVKKuWW8MwiXJopqiJOmHX1eSYr/mOq4JRfGp4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dx9je9vYx3krPqGv+GQHpvR8BFJRUPSM2lXHtKGbS+wBE29DAFIExjWn292VUtsXrpJapCp6xCXXE3+Jypbpav0wTADKO2jJQKiIfaDS29Gtqp+B+VYt8BD1VBcFDP++W2SLecSzdSZ3xGE9yJr01fUmMy1pGVVWw0aI0IuOB3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SIhRWpho; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2124a86f4cbso21446545ad.3;
        Sat, 30 Nov 2024 06:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732978776; x=1733583576; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RZ6qWljX1NmB9fvRtZnfO2acvl/CiqtzKjg+sv4hk3E=;
        b=SIhRWphosLjqu+tpecIb4R5cQH8R3UK6UoCJKFwB8IZbNx8eAbVK1+SLPm6X4eoEvV
         WrIjkMv/QclF1W9mGgKcYxUElkWIwoveYNwqTgqREkUxeCZFVM+i6OS8dKwPSthXNqeR
         pE3vSJ8kflhA8/5LummytAkbqENg8I6tpk0S+FdtcSegW8lSmv4RorVXaGJn27Ivga4E
         CdhTP3O9nlxrbNM3MPLzwOq90kOs49mPJvKRhuzFlhBI3H9nF3unvqqufhpyu7ZiG6uG
         6SQSjXepdqJGh51XC7ggm0lpgx5jFxZpEUboYb1T13PABhN3ktnh7m96o0OBDlXUkGwh
         Nkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732978776; x=1733583576;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ6qWljX1NmB9fvRtZnfO2acvl/CiqtzKjg+sv4hk3E=;
        b=c2uQWorcTjftT4sHoUVmnMExPZc3MaoDMsTkwAnW36iw96/ICQimwaIQ5hskw/vtfZ
         dqIQcRRmlIIX38x5qz7pE5SuqBVARXcv2xvTeSjacmcFU/raq2x+xB7xsGWRjd4+H9gb
         TN6ovvRNF7pEqAy49nidh0v59/0hhweboqHz6Ta2KTa1EpdV0i/5yQ1lQtAWIuK8jmKh
         Fm9lY0GmneSBbiV8OHPh18INzCwk8iz4Oj1ACdW0MrrQT5WpLka88FW87H9nER6C/Oa3
         Pq5rBeErnUyALyDUfz4Mqp5xu+64lwTGWdj9182jy8Hy6tRjiNVtpadhxvu9VHNHyE6L
         nEHg==
X-Forwarded-Encrypted: i=1; AJvYcCWx6Rg+XL4U5l6XxG1yPhBhAGhYwbRIBgod46AWhYLXZtjY9Zo5UmiJwn9k0djJKCCMTyZElF0I1oFqC/Y=@vger.kernel.org, AJvYcCX6KhUjIM24qB+tsUpPHr0OWd4cUKJ/5L8qbv7IfmLi7JVYHaCLsya6OTGIxwXKBooJ7k4JYJXV@vger.kernel.org
X-Gm-Message-State: AOJu0YxcbOmEIeq1N/bIsDpILBjrCyjnuRp/FFFuPGc0JHvxSSk5JXzq
	jfCm2rr3jqBhQnCvOrtolkGstgSMPwTDN4jn4T40zMTjE9lCfEOUXq47rg==
X-Gm-Gg: ASbGnctc9EgDhn8s9OyTDhqMWjBMyqE8ckrQuDxAwH9HjQd5eVeH4aDSuHw1DEEv6uO
	c3qK+suKP/xOfuTmeV/Zdz4yiPXYvis81TK/bEfOzeW9SrTtK2D062q7O//Z1n2hgkAzQciR8nt
	O8xkmx+c1vnZRrigEHrE9tPsKLIG2oerze7wy/rjnb6ZC8jLUej13hOSSEwnMXhP2vQ9ZjsgsWj
	4oTVNXKx8S1RbKFtVXWfF0wYPiUhDyw+9jphlQJSx5wv63EzBlFTKoZ8wF+t3uMS0vIbw==
X-Google-Smtp-Source: AGHT+IH9dV6IPgHDSzS33SDCWldpXS17nD3Un+BmwbNGxlLweWH30p9S0tTR5bD4mCtzr1wx+crnXQ==
X-Received: by 2002:a17:902:e848:b0:212:2fde:1a1c with SMTP id d9443c01a7336-21501e5c68dmr189451375ad.47.1732978776484;
        Sat, 30 Nov 2024 06:59:36 -0800 (PST)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2156e0c8db6sm4906135ad.88.2024.11.30.06.59.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2024 06:59:35 -0800 (PST)
Date: Sat, 30 Nov 2024 06:59:33 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Cc: Yangbo Lu <yangbo.lu@nxp.com>, David Woodhouse <dwmw2@infradead.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ptp: Switch back to struct platform_driver::remove()
Message-ID: <Z0soVfzwOT2IHunn@hoboy.vegasvil.org>
References: <20241130145349.899477-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241130145349.899477-2-u.kleine-koenig@baylibre.com>

On Sat, Nov 30, 2024 at 03:53:49PM +0100, Uwe Kleine-König wrote:
> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
> 
> Convert all platform drivers below drivers/ptp to use .remove(), with
> the eventual goal to drop struct platform_driver::remove_new(). As
> .remove() and .remove_new() have the same prototypes, conversion is done
> by just changing the structure member name in the driver initializer.
> 
> While touching these drivers, make the alignment of the touched
> initializers consistent.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>

Acked-by: Richard Cochran <richardcochran@gmail.com>

