Return-Path: <netdev+bounces-108944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DFA9264AF
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 17:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A1971C211A2
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688CA17DA3F;
	Wed,  3 Jul 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="UywAO2P2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558F417DA20
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 15:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720019815; cv=none; b=qiXyAc+Xs4Q394NSgWWe5sGn3/V2A42yZC7dLkmD7BP3lFbQ/WYzjSMyv9zaOInmsVGVfRR4PfZ9I2IzT4FJm1DLiRjE9umjXl/exVKhLsAt2ewXLlA7r1fA4G0RSM3EZ4QAzQ4jDAK96R7YsI0VMeJqMWeS1dyoNA3FIFAbDp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720019815; c=relaxed/simple;
	bh=1es+Trjk37AaUG8ezmycVVMv9NS+kr48bMEvweIaoWg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C/8jvcwtz3ekoZcKbZzZDCUCnaQgP/OX0kJYkT3d8EggeGTFp+PWs0w412Ypq7f5VOrnVbsA6zyX4nEVDeF66p6bKnc1JkDj4ctTc9+ke3U5DBs1JEKv52Rb8cx2mVZF9lf9JoinfCC9t644uo58Z37sLcCbgwFOTbHB7AOccHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=UywAO2P2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-652fd0bb5e6so3770734a12.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 08:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1720019812; x=1720624612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMhw25NAy3tQGuL2MKvieK4UjtNyi6UoztExQ4eMyig=;
        b=UywAO2P2sGCoyFQtwFnK3EjLB/firfPNaq7nk0D8EH4V+6KXBs18QQd9ZMz2vK/M1A
         O+CW8qL2z6oMle/SHTKbwm1hD+ioSoWppQ3+UrZj+cqFubr/v8pJm3mIdyUYGrAHKk5O
         ajHoDzSNZmbWtP/473ldgUqELRP2oIjFIooildIC2vr7/M4m0wx+jkio7kSFOTZZcC6U
         tUxvMbSx0v3ynlk/oCGZ9kLPrnNpgN85id2dEZkECfQf/e8Ux6fBq+3bjI+tGjiLTbbd
         eaOWR7O1PHtzCp4ecBExCpStD4vC+Itiig92VqYFh4qYlEwHGJBzEARQsVnwYpanDBVM
         qOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720019812; x=1720624612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMhw25NAy3tQGuL2MKvieK4UjtNyi6UoztExQ4eMyig=;
        b=i0f+0vG6V+8ZKmfmWVMP2jbyzRVCj4cEpFIJWGgofw2QFfr+QINaLYPaOeJD65Ptfd
         8nK50zH/Cj1Km9PMqxta2NR/3jsNk8PpoqTIlLfX3hOTOhpJTMNGwY+G3SF5mshtYZ6u
         DwOiBLAGwbjfk90Y/7/r0wiFyx9n9AE8NTDAptdjfXwbPLVl6hknRibbkGfA6lXdAeHV
         uz+tLkjnwxT5ULMVFQQzEXA7D8LNUzCFZaGj1WTFFrZJkHzG2js333HwM2AsJqfvkDCs
         ADr1gDqetiC/iYGLdIvY19uDM78LW7P3iijKR4z15cAEykcnvTG0c/ZxHBkPTXrCQ+5T
         MPRg==
X-Forwarded-Encrypted: i=1; AJvYcCXxKiTUiWR5BYdUeMwRlT4lGnmTXcnXQwjSbMOgyfAZSnbsynY4iNKXQSf8aS0uun5MitpPbfc+qaZzBkmeFkTJ8a1Duoqr
X-Gm-Message-State: AOJu0YzQ15Goq2xWCihIh2VfpmggjhWj0crOia8oBkWIUFdwxUhVlylF
	yDGeEhj6D5/EuKM35IdEzyAYdnWmt92MLr0nbgW1PfibtJcGuDp5t/TJN9lW9r0=
X-Google-Smtp-Source: AGHT+IFPJfU8SG1ys2V8a54fwXr0tqUxVoHSrLxME346erjv+Hjv7/D//jdgTpIwwZr8BVhXnofFHw==
X-Received: by 2002:a05:6a21:33a2:b0:1b8:9d79:7839 with SMTP id adf61e73a8af0-1bef613f2abmr16276319637.29.1720019810913;
        Wed, 03 Jul 2024 08:16:50 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7080246c662sm10558366b3a.61.2024.07.03.08.16.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 08:16:50 -0700 (PDT)
Date: Wed, 3 Jul 2024 08:16:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Lukasz Czapnik <lukasz.czapnik@intel.com>
Subject: Re: [PATCH iproute2-next 3/3] Makefile: support building from
 subdirectories
Message-ID: <20240703081648.3109da55@hermes.local>
In-Reply-To: <20240703131521.60284-4-przemyslaw.kitszel@intel.com>
References: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
	<20240703131521.60284-4-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  3 Jul 2024 15:15:21 +0200
Przemek Kitszel <przemyslaw.kitszel@intel.com> wrote:

> Support building also from subdirectories, like: `make -C devlink` or
> `cd devlink; make`.
> 
> Extract common defines and include flags to a new file (common.mk) which
> will be included from subdir makefiles via the generated config.mk file.
> 
> Note that the current, toplevel-issued, `make` still works as before.
> Note that `./configure && make` is still required once after the fresh
> checkout.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Not sure if this really needed, it impacts more than devlink.

