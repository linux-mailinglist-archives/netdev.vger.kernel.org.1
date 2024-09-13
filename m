Return-Path: <netdev+bounces-128020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE279777A3
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 05:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DAC61C23AA7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 03:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFB851BAEFC;
	Fri, 13 Sep 2024 03:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZYQ+Xdw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4588827;
	Fri, 13 Sep 2024 03:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726199948; cv=none; b=GHoafOGmVJ9L44zfcXSo/dT72omWNR+zhvjLqfaajqsZVQBjOLiFFmSPQKP4WwuVz3lGWbAMJPQkpn+RP4HX58Ye6m1TplzGmiKdBg4Vv0i9FnEDR49vz6i+z0fPFCuJxdRY0nblIyhnqgFUs2iDtY0C1AHSppgTBdxns330KIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726199948; c=relaxed/simple;
	bh=IzxT5gkhqp2J+sCRoxwmPWq6zoqDVYhumEnaZbg0CYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pn1i0uAytc/8KKoOprXdsF5VMbD4hwXQZTlIoU/3yxIIp8EDVjfEzwsxXsi0GELa1b1qTfh5cjXNak4chmXBAXD9liKk1kw81MwK+HHy/OTQImKdClFfpgKJ+u0JdBH6dz4Rl0b2WCzf1sKp9JK4G+ScEnwmB2iBAH9yUDMYGZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZYQ+Xdw; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71790ed8c2dso1430012b3a.3;
        Thu, 12 Sep 2024 20:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726199947; x=1726804747; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IzxT5gkhqp2J+sCRoxwmPWq6zoqDVYhumEnaZbg0CYM=;
        b=ZZYQ+Xdw/mjOt2LkzqMsLXzWi207E49Wm1E9x+AK/PDOASxdYJreLv6S/k9gIaybCA
         BrDaIv1eFV2Y95wvMwera5KEiytnRnO0VqAtzb8QfHx30hmVYvHqV/SjAXou5TjOtWog
         7IvpHktRPVINSdvdO0gKO2HY9zYFpMAu47g1hOAmQ0sacm/FUgqWuvyPzdQCuVD4zb8H
         OPKBjpJ6/YRwUcNm5fIPUu3lE3D453YJLDU4pZZErLsLiyTE0TgnIDEbnwXnIFXnnbsw
         R4D1xEA6ozlPZgPv2praOcPd7GeXeWfUpbHiRBOyxROYYqE1dq9hZrnubvi7Ce0PGqZg
         4rXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726199947; x=1726804747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzxT5gkhqp2J+sCRoxwmPWq6zoqDVYhumEnaZbg0CYM=;
        b=X2Q/+e5/zVUZkY7QJGHzEvQlC94r/JeFrVehZBh4/zhzy6inYhGzuy50YoiXYfQpgO
         xLgHSgEAbtevYeHMeglMuu17Xs+JpzCK8CmRd+PGuVxGI1KSmoVLwxJ2LXr4IsfqPlBg
         gz+dw86FU8Ns/z0+GbvbRokKIL0YiJGHVHDdibhBuEdRgVreA2BdEhXq0m8tByGNLJdp
         9bgZJjI9MfKfC4wdQc7DbKWTZs5Sg6oCh/pCI79eWLne6oYyx3H6PHSJdWHKUtE12MCx
         kR+/ZS2gakDSt/hvAv3CIJsCq6n0V9AFNGA5B0aLzROWqM32O0mJ3dMFX6Omc0i3eeUD
         ryvg==
X-Forwarded-Encrypted: i=1; AJvYcCWgMuG3fk+5CXxXFFUdFWDhIDH59hjm12IkfNMGM/ofAoZN1tdeCH9IoYKjvaV8kLg9JFdsMNwz@vger.kernel.org, AJvYcCWyCYzC7F6QGnbYKoDTgRuGbQfL9+aMQ2uYJpt/u6H43bU08vzVwyvsEr44k9LRmiIS/l1Xam/KRTMc0WY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQGDaokXX8w/mGstG04z4jhRv6fCI5r020dD/3C/mU8gp9+2zK
	MErCNplt7LsLH0V7QJ2EGj/lSCS8FkuKw5pU12eewyB0Wq/2ftTd
X-Google-Smtp-Source: AGHT+IFEi+dW0Ycy5VWpFJ7Od16TQ4UAfRiog3o2tMOTfn2qAAfQZ0erwWerN1rTFhkt7TZoP8X95A==
X-Received: by 2002:a05:6a00:14d0:b0:717:9768:a4ed with SMTP id d2e1a72fcca58-7192609318dmr8855576b3a.16.1726199946712;
        Thu, 12 Sep 2024 20:59:06 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-719090cbca6sm5273151b3a.197.2024.09.12.20.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 20:59:06 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:59:04 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Anna-Maria Behnsen <anna-maria@linutronix.de>,
	John Stultz <jstultz@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Christopher S Hall <christopher.s.hall@intel.com>
Subject: Re: [PATCH 00/21] ntp: Rework to prepare support of indenpendent PTP
 clocks
Message-ID: <ZuO4iOyN2myqMdEW@hoboy.vegasvil.org>
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <ZuKii1KDGHSXElB6@localhost>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZuKii1KDGHSXElB6@localhost>

On Thu, Sep 12, 2024 at 10:12:59AM +0200, Miroslav Lichvar wrote:
> I'm trying to understand what independent PTP clocks means here.

Me, too.

It is not easy to see where this is going...

Thanks,
Richard


