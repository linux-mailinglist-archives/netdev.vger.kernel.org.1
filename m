Return-Path: <netdev+bounces-209328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82854B0F200
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 14:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBE3582284
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 12:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726232E5B07;
	Wed, 23 Jul 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="LPoqsg5r"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E872E54D9
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 12:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753272789; cv=none; b=rD7ntEiTCZqfKBjVyXIk0Ld/A9/JuWWqetVbf5jfZPSOVK7JEwwDRZMA3QWmE5dYCasoiMe4Kxhg+Pic8RW6VfMl4IBmSbpi6tsUJfBPVNX5HIiEDxDMhdCAD4sWST1IScvz2U1ED5dRGytgxBoYPC2lH4te5ZLHYVAzRuqGASM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753272789; c=relaxed/simple;
	bh=FldOWy8/ITk7ZhfwmeYSrmVuHjEwyUuCLxbw5dH2QjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g8i6EiTx/u71yNOCmFhvgMZIVwENQ4bnixiNCczgZppEw0qaXv+qvL8WRm51n4eBahA9kbBBd9T3rxO52s8b1C0H+cwb4BEtzRkwNNXI6EiMl+oMmBhkB8PGXCICINOX+b4+scvXrrzUEU2x63oUUJ6s7YiwYSbSas2FOMs2MHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=LPoqsg5r; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-451dbe494d6so72740205e9.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1753272784; x=1753877584; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FldOWy8/ITk7ZhfwmeYSrmVuHjEwyUuCLxbw5dH2QjU=;
        b=LPoqsg5r9yUOoCl+gc1QZIAM7GHn/5z1O1PDsexUITzkC5uoKeSJY+aXjrWCcG+tpD
         Ez8hDYYuLNeBjRKoo/MyUwY3NSpJZC07BovvEV1ZVMXV/3PG8MVzKIOxKamPAe5wW94O
         mafcf0ZZd8KYJrPcJwsLa3r4Rn2AwdX7PCiatUrJUgUo3ycGw6tN18fmtV9byHs3eM5l
         yiOxA8txkee2WA3gNUTR2JNwXmcLZHAJX7PTNJYcM4/pG4BirxXdt0sdzp+BhbB6Q515
         yzeCYpgx8FAAVWNRoPKM2KJEl+vWDAJEX8A9ZCQhzWmUOnkKoJTA2JjnW+5r2s9FAGPN
         VTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753272784; x=1753877584;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FldOWy8/ITk7ZhfwmeYSrmVuHjEwyUuCLxbw5dH2QjU=;
        b=q27VUw9cdcN5i+Mu+UnErJ6tXwHPKk9nUJOQzRPTLIrXF+7+yVKNkotEBE/C82xG7+
         F4wr7bUEVrrgGR1p7rF4DFeBUQM48Sr15AEc4E7zYOknsMXCpVJ2TnjRNuBa99PXb9xg
         04ptwzqHbu/Oh2d8Zpem4df0z+Ua4aTQGqNmNkfprQFMEIouVm9ESi6/kln5LqUgYjCy
         JT0HMtkecX7n9p+k7EK4ts/41A3wM2FKW5Ran7RLdNBYe/Bh4A4Cgt4UDB4E91RaPnut
         k49+aaX4e5BLxk3o6MV8l2YcgsS9TU+kOj6VOdPojUstl9iQ4nY2nKytm/6+stNqvCfe
         SwUw==
X-Forwarded-Encrypted: i=1; AJvYcCVX2j6fv2WESntMnNiWqgWfuTV0ABezq+ICi6N+CrVZn/097psvgK4tVicIcaIpTPoaRm42JPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu7DisOeplLM7dF2KWBWtfPRolvYixsuRKDU+Avflp2c03vzRD
	Xqm3gd5XLGiKMx5mlpD8OjyVOOVBkhok3j69caZ5hXBdNbDeTZ2uKlIyXcMn6NNmunY=
X-Gm-Gg: ASbGncsuTZZnNkSsZbzFk0TVkwYAoatykrTSKPXPJLu6PgytMaOb6bMRQmU3vW7HUnT
	IrhlUzGwp1n0GCCSHpypQLXP6ExIA5LcKYc02uczFKCe42dYiK7d4Q62267rx0yio6iKi3SQUus
	V6YPJEYJSERJF1w6WNYzyyEKJvARmgMn+9HBdWs/FjXE95km/Iinhc1zDnqQrhWZxtw9BHbO9iG
	+5eToU3Cu7znM266UMvR6CFNd6fEn3/rNhJNip1rT1Bk1A0sJ81YCSFR2nbGK30oBD4O+/mlgwq
	QPjijr2DV4txk7eMr4JYkrhMnERSZqOcyDrhJBxY0s8x+6YpBLLHkX2VSDjBvkwUxeSU87D+KP2
	44RneV0t+Sw7Yc6Tyg/jmzyie
X-Google-Smtp-Source: AGHT+IEzrHcondk4/pQXmw1qMla46+2r0BeNYSpJhDSNNR0BQ/8qr7wpSrABN3Lz7VmTYLw4x8Snbg==
X-Received: by 2002:a05:600c:80c6:b0:456:1560:7c63 with SMTP id 5b1f17b1804b1-45868ed969dmr18211865e9.3.1753272784217;
        Wed, 23 Jul 2025 05:13:04 -0700 (PDT)
Received: from jiri-mlt ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458648f5ed9sm33783085e9.2.2025.07.23.05.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 05:13:03 -0700 (PDT)
Date: Wed, 23 Jul 2025 14:12:56 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
	przemyslaw.kitszel@intel.com, dawid.osuchowski@linux.intel.com
Subject: Re: [PATCH iwl-next v1 00/15] Fwlog support in ixgbe
Message-ID: <2hgukyjbhhafp5zruf5yb5rjddmjsyo4hwjd5gyyuomuugr5wu@vrftn6sxn4yr>
References: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250722104600.10141-1-michal.swiatkowski@linux.intel.com>

Tue, Jul 22, 2025 at 12:45:45PM +0200, michal.swiatkowski@linux.intel.com wrote:
>Hi,
>
>Firmware logging is a feature that allow user to dump firmware log using
>debugfs interface. It is supported on device that can handle specific

Did you consider using devlink health reporter for dumping this?

