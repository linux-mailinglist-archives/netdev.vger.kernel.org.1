Return-Path: <netdev+bounces-182994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A55AA8A83D
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 21:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC0AE4425B6
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 19:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7582224EAA3;
	Tue, 15 Apr 2025 19:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="rjooBMZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1F424E4C1
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744745958; cv=none; b=SHZMYdB4Mc5cMMgluOKdAl4Jx+2dXlefRU0TFd68ICvp5X7lpRC5EMbQ8VUKAxTHuumFNWndbx/FYW1YGhRfUFGlxN30hID2R1HARqltIgRzxYpSzfM1DyIMuQfHMj96wcgudEt33+cRH6jC/UDg1pCjauq8mA/aHqzw8Q3xdTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744745958; c=relaxed/simple;
	bh=zsGUpj5GZ2h7Vwe6HLZ5jH16wOzMfXpoGpvHr2cGzUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Glpjq/AoSj+ISLAt106+WuTf8+sNEn1jmA8Dz/pye7z4Jb6KoNf/NtXXgUgybk1FEFSlMZQegkPslOohX4xM/BuS3g3fU/68UwvOSPM/8Jh/+9jzp9nL/aiFIH3GfuqP3dUCq89tZ/UQBrbvOZ8OUrPsphU49MkJ2issmjzYtGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=rjooBMZZ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-af590aea813so14777a12.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 12:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1744745954; x=1745350754; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DgQZzwQ+VnFV+EQ4EbE4rQMrLWAC5dU5oyUSlaBvU/E=;
        b=rjooBMZZxr8ctxbFgUZ6zMte2wRpHtFKCMjMdl8aFdETZKAO47yAuHg/e8HkwktfS0
         JqVZOyhj8/PNqKb5fUR6JPIIociPJUJ2D3L9oheooceuT5rprXYlBZRbNi5avCXrIR7j
         eg4tX/QUipsQn0B9LBe8xVGTUioIeyG2M+2F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744745954; x=1745350754;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DgQZzwQ+VnFV+EQ4EbE4rQMrLWAC5dU5oyUSlaBvU/E=;
        b=RZngSLsddwY/IaPcV3D1I44Vgq3++hkWYqQDulas+u0BJ8oGY6vmLCmhJ8nAksPMZ1
         oQOgyCgb9k6/dBLNgaZBqHJUdK86Of3Gdt4V7tTQIo9OOoOSvFwrXDYdnXNDnNoWZlXl
         2TpPmuHthMYqmNTaJKzTrbQPoMMsE893dgdWHDGCWXXsq9pAGXI5XcvHHfizYMypG6rs
         j8X5388seMiuWfuC6Oa6vuSCRtdUEjIgisCzBrf1HuNhm7G3CQWv3TyHZv4GvYUJjBJv
         zF7/sH9Vf5VMo/8V6VVTDR6EAxVuIiEizS60S6+yJAjm01ZAbvW+XcM8Ms4ZEar1VgcN
         KZvw==
X-Gm-Message-State: AOJu0YyUu+pFlFsu1/9zpnY6VhcXYFcsgIMYGJCuz3A/Wvz5r3qgMAB/
	mx2GrwMs1msdyqDs2UYXGij+kfnqjnVQma2f6vPtZGS7o20osKCgL/tHmDrSkAY=
X-Gm-Gg: ASbGncv9hk9PnX47n0j5uySCkrm6WkAYQFkbBqM/+Iwx9jG/HOMqF9jm1D+RLKICiXy
	ngUnnLYj8V02aMxwFcP7nFXRY5eTJSf3IszfZAw+iDA7ebWjRy2jgdhLqvvoUQRX01c/u99hvYK
	oWZ2s0DEM649uB4GbN6GfIbwdYwdgBbu0+P9V41qcRmL6bVmwqY/hekhz/9Q1UizPT0xWJWwRrN
	7RmGEZ7e2JD4QJQkOkp2FASeeAyokIY22WNTJu5isSA01qCKRMcc3Al/asetcfn7Z1AQZj5jWu7
	q2xWi72UGl7BOFS9ekTVABBFFp0/UQcd+DJovkb/Mhbm7AuiHHw1H/SxrTOFWn9AbGKNkjd7Xkz
	b76oHoiRqR8Zy91vbslcXJio=
X-Google-Smtp-Source: AGHT+IEFrQQ8/YtODsnqpjV4NtRefMJrarn7BkrW5JrjlicGqatxKSAubw3f+uJGVSd2TJ0bQnqNgQ==
X-Received: by 2002:a17:903:1ce:b0:223:3eed:f680 with SMTP id d9443c01a7336-22c24a1440dmr72537785ad.18.1744745954611;
        Tue, 15 Apr 2025 12:39:14 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7cb5304sm121524045ad.189.2025.04.15.12.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 12:39:14 -0700 (PDT)
Date: Tue, 15 Apr 2025 12:39:11 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>,
	Eric Dumazet <edumazet@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [RFC net 0/1] Fix netdevim to correctly mark NAPI IDs
Message-ID: <Z_613wmrKRu4R-IP@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>,
	Eric Dumazet <edumazet@google.com>,
	open list <linux-kernel@vger.kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
References: <20250329000030.39543-1-jdamato@fastly.com>
 <20250331133615.32bd59b8@kernel.org>
 <Z-sX6cNBb-mFMhBx@LQ3V64L9R2>
 <20250331163917.4204f85d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331163917.4204f85d@kernel.org>

On Mon, Mar 31, 2025 at 04:39:17PM -0700, Jakub Kicinski wrote:
> On Mon, 31 Mar 2025 15:32:09 -0700 Joe Damato wrote:
> > > Would it be possible / make sense to convert the test to Python
> > > and move it to drivers/net ?  
> > 
> > Hmm. We could; I think originally the busy_poller.c test was added
> > because it was requested by Paolo for IRQ suspension and netdevsim
> > was the only option that I could find that supported NAPI IDs at the
> > time.
> > 
> > busy_poller.c itself seems more like a selftests/net thing since
> > it's testing some functionality of the core networking code.
> 
> I guess in my mind busy polling is tied to having IRQ-capable device.
> Even if bulk of the logic resides in the core.
> 
> > Maybe mixing the napi_id != 0 test into busy_poller.c is the wrong
> > way to go at a higher level. Maybe there should be a test for
> > netdevsim itself that checks napi_id != 0 and that test would make
> > more sense under drivers/net vs mixing a check into busy_poller.c?
> 
> Up to you. The patch make me wonder how many other corner cases / bugs
> we may be missing in drivers. And therefore if we shouldn't flesh out
> more device-related tests. But exercising the core code makes sense
> in itself so no strong feelings.

Sorry to revive this old thread, but I have a bit of time to get
this fixed now. I have a patch for netdevsim but am trying to figure
out what the best way to write a test for this is.

Locally, I've hacked up a tools/testing/selftests/drivers/net/napi_id.py

I'm using NetDrvEpEnv, but am not sure: is there an easy way in
Python to run stuff in a network namespace? Is there an example I
can look at?

In my Python code, I was thinking that I'd call fork and have each
python process (client and server) set their network namespace
according to the NetDrvEpEnv cfg... but wasn't sure if there was a
better/easier way ?

It looks like tools/testing/selftests/net/rds/test.py uses
LoadLibrary to call setns before creating a socket.

Should I go in that direction too?

