Return-Path: <netdev+bounces-117748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 235EB94F10B
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 17:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52B231C21C5F
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B7E183CDD;
	Mon, 12 Aug 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="p6mn1JAG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B469817C7C8
	for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 14:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723474754; cv=none; b=u7mSj0UCRbvoPxT5G0W+f+2O7zjT1KP8WSaOkAc6D0sxDgaBAP13+ykZefI+l+6NzyjmF4IuRsvu+qfEeupuPmhnaYm1nToAw1Ph6dBgbimh29PygNeSgB5iXSuU5WwU+R43fGQ5NLFEwP+fnBl4yA8pOk4xitwRW1/aIklY+3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723474754; c=relaxed/simple;
	bh=jwew8zUcf7StgyIihrBL74730peDypgp9YuxKyddzoc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qX566UPasvHVzFJGUaV93vyAmp0icnyMCMY/TENCEZ3KxTlV0auo8SSu7MoJkS8IGpwiPP2ExVYOYtohvUmj8J3x9dC9xyy258iGFuTiqhtQlUsuNQFRaZiwssJh4caw7IyWpQs/w3UOse+rVYui5LdALXYHUpk/sJ1bhD9+NvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=p6mn1JAG; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d1fb6c108so3114992b3a.3
        for <netdev@vger.kernel.org>; Mon, 12 Aug 2024 07:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1723474752; x=1724079552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xiRdgb5rr5OMjfMs15ItAGk8pkQZ75L/Emxc5koaT0=;
        b=p6mn1JAGrV+AYdGCipiQEXGxoKF8Ljfex734CX8znh6vIyUIDxvEDkcXv7O1AYjP15
         j7aRPUFNr+wbuOhY1D67EGADN3TpzmBzpx/3VP53WW4A9TJSdKk8hUYqBO0NQmOOn0Hz
         y1qEf+Vh4B+Ox7o0Aq3KrrxOnCTfkHGN8p4iWczg5180IIQM9r4XDJp4yowyqLaL6yBm
         dNPJ425Ibp9c/lHNLcmTCxH+EdNikIHsMXydqmW6ntAM9PZCO+y8vOxw6OEkXjEWk5YZ
         dBHiUWUuZhSUWqElklyenvr3jAKsKgLy+n1k0MQl3IQTUKBWYoPojei06kiyoMztQlB0
         wJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723474752; x=1724079552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xiRdgb5rr5OMjfMs15ItAGk8pkQZ75L/Emxc5koaT0=;
        b=qLgBvWT5uds6tkV6kNolqZuBE2Zm7L0RkIcIxg44cPXm/aFF8NXLrWOANKz7KmQ3vX
         UgLW2L+UkEhWjlFvyC3zM4SXcZwQMp4rtxf144JZUc4MSj2Dx/eTBMx6kuuz8ZfF7giA
         Q/kYINzRIZDb3hqO1zjJUIWojAxaNJWSHlu8boJ3x5lt10Qg2A5mfzyy8QIa6bZhFHDT
         UZVRWUgnXzkVaNTm9Raqhm7RhIWhGMVhsha+JSBMncVaD1JnpMiErhnZfMHv/d6lQTox
         +t7e26P9T0NipJrCFFLMCUCga6CmUzZziOb3xzTXgBgFst83wJi2OkgdCp3cdD+rh1Bo
         2lxA==
X-Gm-Message-State: AOJu0Yw3yYK9j4VMQQ9of4iJldvsipVutbbOTtTOpGXRty1cf/SWfKs2
	noPrS9hjhGEMiKMOlYWTyOMQVWFNpcEpJkctk3Ufn56U4lioarLRr/GQZaHm5MA=
X-Google-Smtp-Source: AGHT+IHeu30A5lMWPBGRilpOU8frJ5MvRTWIV1JyOeJQ9MdHu6RMJvWEvMjQvkmyUOtVDxri0KBgkQ==
X-Received: by 2002:a05:6a00:2346:b0:70d:2cf6:5f4 with SMTP id d2e1a72fcca58-7125525d101mr534043b3a.25.1723474751952;
        Mon, 12 Aug 2024 07:59:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5872b1csm4085706b3a.40.2024.08.12.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 07:59:11 -0700 (PDT)
Date: Mon, 12 Aug 2024 07:59:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute] man/ip-xfrm: fix dangling quote
Message-ID: <20240812075910.180a1f4e@hermes.local>
In-Reply-To: <20240812073320.GA12060@unreal>
References: <20240811164455.5984-1-stephen@networkplumber.org>
	<20240812073320.GA12060@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Aug 2024 10:33:20 +0300
Leon Romanovsky <leon@kernel.org> wrote:

> On Sun, Aug 11, 2024 at 09:44:46AM -0700, Stephen Hemminger wrote:
> > The man page had a dangling quote character in the usage.  
> 
> I run "man -l man/man8/ip-xfrm.8" before and after that patch and I
> don't see any difference. Can you please provide more details?
> 
> Thanks

It is more because Emacs auto-colorizing of man page
gets confused by the single quote character.

