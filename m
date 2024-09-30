Return-Path: <netdev+bounces-130368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C4B98A3CD
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A70C1281B49
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA53A18FDA3;
	Mon, 30 Sep 2024 12:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FI8KbgvV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA418E76D;
	Mon, 30 Sep 2024 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727701083; cv=none; b=Do8cYlhzxamzMSZsK3L9CprX57sW86vj+bxV/MpLCQlSIdoL3sJJuZXdmYjNzDToZ2SU7iuXlAFalgTztSYOAh5MTfDoGzodswuQOvvJuXi3bNa7gHTkQtcOHREngxg6dbzBReKBpyUYKVCRDvUNuRi9mloPPBx2MKrh3niHnsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727701083; c=relaxed/simple;
	bh=NK1Td+vGFZWwAfelLaVgiYJL7Vj+dsLx5Sx5HeZS084=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7WolKkemY9c/wuM9hac2zcy8A/MCSrLIynDDkMRbQto4zImIEkB7SRfd03DyfWwfewa5n86jn8h56M4FuYM60hYvMi3+ZlRYI0Dwe8wGGsf5JgKRilENnaAhN/iMH9QpE0/xENu1Ne/dmrVxbDD9LVnUoc5qyBMCCkiV2hHWSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FI8KbgvV; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e2886ea751so1719184b6e.0;
        Mon, 30 Sep 2024 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727701081; x=1728305881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ux8bi3gW1DAs83nOgEJ11EpGenCjx1gwaT1mOaPq14M=;
        b=FI8KbgvVdYMFuS84GjtkZARqxyBishmmLYmshZgy/u/uPpnP/FNBL4UyktKVmlmxiL
         icejDLiNdJInc+g8zba/v+dlup99b8bZHzijuZBltnswX/UG7Am4p07RKdftNB20leP7
         SS5Tpm5G3D2ZmVyRIs98OHybRVfJgE/BhPYxXkkljxjXnQpk35UcR88ia9TKOC3mh+6u
         LZfOG0MrvsH1UmAm3Za7KhcQQTO/4GdziPEGvtwzsxfK2WgUUZH1CeTyEvcAfAzWOkYT
         DO2FGCgVrEs/hPKfL8N7+pNlWHzprvgdL/t/ELNtyeNN7cgDx1bD5k6DhlyG0ObPEYmF
         4FzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727701081; x=1728305881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ux8bi3gW1DAs83nOgEJ11EpGenCjx1gwaT1mOaPq14M=;
        b=i+vD95lDYtGLP/sZoELAfsp3Rh0PYInZJ5xMU79vjQptZqGovcmmMux8TDRUySxmPX
         kRmQXI0jdlTAph2dYbJi0TVyKHpHnNzkCru7nfTx1YLjwm+WDxWg7gwk8MLj89ITRdKd
         5v0hRLRrxO6F9mhOM+ojEL0kbrbJ+3Q3bLLjauKoPw/X/RcJn+qiSveq51MAIoES+XAx
         rbyeWdG6Mn6uPY+k8VBQcIaCXVZmjQt8udj0zYfYJzJMrAkIEG7eqLyZbbbCKCrwU4sL
         OklddGCY0LS/IlG6Ir48t3u6nLA184To8m26+yY7KOOwDldbNiNuO6MubjcBYBZVFeIE
         Sorw==
X-Forwarded-Encrypted: i=1; AJvYcCWqkzHp6UmD+j8sdcqDBjFSEAOt1WlJNLYaRyB6oFE8BmKRMPvBXOn7pcBdcLBO26jDW/qcqnePQKG76jw=@vger.kernel.org, AJvYcCXeMVr0pOBu23ocefC1d+ofeu+dNSnh+VV8pzp00vdV2du+yNvcAb7/KC/td27Y5+TGPq0H0qOY@vger.kernel.org
X-Gm-Message-State: AOJu0YxtbADmoaXyHcAsk84UkW4QVeAYrZgzgLvPhS8zS/wTqJWqSPtR
	RM3w3EoFxEMwL10/7pP6oh6HWVvgE2nvTSj74IkxzKJ2/vTahCwIoem8EGSullQ=
X-Google-Smtp-Source: AGHT+IH6+aOxF4KcJQtgX7XxPUEWEI9mlPYgfF4Orw3MbNvbjvlm+f9PJSfQ8vWhOwJ5e29YAPkGkw==
X-Received: by 2002:a05:6808:128d:b0:3e0:3552:9563 with SMTP id 5614622812f47-3e3939dd0a0mr6965631b6e.30.1727701081146;
        Mon, 30 Sep 2024 05:58:01 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:671d:78af:f80f:975b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71b26536bb6sm6168133b3a.194.2024.09.30.05.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 05:58:00 -0700 (PDT)
Date: Mon, 30 Sep 2024 05:57:57 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, linux-kernel@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	amadeuszx.slawinski@linux.intel.com,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
Message-ID: <ZvqgVeOe9jE02b1r@google.com>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
 <10515bca-782a-47bf-9bcd-eab7fd2fa49e@stanley.mountain>
 <bb531337-b155-40d2-96e3-8ece7ea2d927@intel.com>
 <faff2ffd-d36b-4655-80dc-35f772748a6c@stanley.mountain>
 <84f41bd3-2e98-4d69-9075-d808faece2ce@intel.com>
 <129309f3-93d6-4926-8af1-b8d5ea995d48@stanley.mountain>
 <e86748a9-6b72-4404-9042-c9b6308a9bc1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e86748a9-6b72-4404-9042-c9b6308a9bc1@intel.com>

On Mon, Sep 30, 2024 at 01:30:58PM +0200, Przemek Kitszel wrote:
> On 9/30/24 13:08, Dan Carpenter wrote:
> > On Mon, Sep 30, 2024 at 12:21:44PM +0200, Przemek Kitszel wrote:
> > > 
> > > Most of the time it is just easier to bend your driver than change or
> > > extend the core of the kernel.
> > > 
> > > There is actually scoped_cond_guard() which is a trylock variant.
> > > 
> > > scoped_guard(mutex_try, &ts->mutex) you have found is semantically
> > > wrong and must be fixed.
> > 
> > What?  I'm so puzzled by this conversation.
> 
> there are two variants of scoped_guard() and you have found a place
> where the wrong one is used

"Yeah? Well, you know, that's just like uh, your opinion, man."

From include/linux/cleanup.h:

 * scoped_guard (name, args...) { }:
 *	similar to CLASS(name, scope)(args), except the variable (with the
 *	explicit name 'scope') is declard in a for-loop such that its scope is
 *	bound to the next (compound) statement.
 *
 *	for conditional locks the loop body is skipped when the lock is not
 *	acquired.

Please note the 2nd paragraph that explains this particular usage and
that it was done this way on purpose.

> 
> > 
> > Anyway, I don't have a problem with your goal, but your macro is wrong and will
> > need to be re-written.  You will need to update any drivers which use the
> > scoped_guard() for try locks.  I don't care how you do that.  Use
> > scoped_cond_guard() if you want or invent a new macro.  But that work always
> > falls on the person changing the API.  Plus, it's only the one tsc200x-core.c
> > driver so I don't understand why you're making a big deal about it.

I think if you also count uses of "scoped_guard(mutex_intr, ...)" you
will find more of such examples.

> 
> apologies for upsetting you
> I will send next iteration of this series with additional patches fixing
> current code (thanks you for finding it for me in this case!)

No, please do not. Your "fix" it looks like will prevent writing
code like:

	scoped_guard(mutex_intr, &some_mutex) {
		do_stuff();

		return 0;
	}

	return -EINTR;

You might not like it, but it is a valid pattern.

> 
> I didn't said so in prev mail to leave you an option to send the fix for
> the usage bug you have reported, just confirmed it. But by all means I'm
> happy to fix current code myself.
> 
> > but your macro is wrong and will need to be re-written
> 
> could you please elaborate here?
i
Dan explained that you are changing the behavior of the guards, in an
undesirable way, breaking users. Please re-read what was written before.

Thanks.

-- 
Dmitry

