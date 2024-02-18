Return-Path: <netdev+bounces-72705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96AEA8593FE
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 03:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373AE1F21B08
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 02:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08813EA4;
	Sun, 18 Feb 2024 02:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="Qc4KDQxF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014CA15C0
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708222361; cv=none; b=l3ixsqlMsJoIzS7keNNxSv1IqMnd5NF2iNHFV8H67HwmhrirBNGSkbx6LLSHbdqb4g9EGg3/KBGyoZ5K1dkY1Z1ToUzl6DVMvEBHUlSwbEiROvctUfbwMxBNbT6wQFGTkcLZnSbBJtY8TovFZWKFTk3uh4z3hcTqIpJeFnSHcyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708222361; c=relaxed/simple;
	bh=9tkQ6ztc+FIsC9tnahmvOipvbwqXOtWa5lRD8Xz+7sg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e7DF+4VnTHIJylNqUomr2WByaxUbUDtZheja+KCRTMMjj//0JPQRZN2JCfVSn7dpa7cIIZty1O1G6m53PMOz9XlEF+n5CoyaYkwxD/fpUDmF+eo8Av8TFw7ktyr1n5DoIUcReL6V1WOwCuABXl4bSXWLT0ILMfGXZK/a2Tcq3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=Qc4KDQxF; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2965359a12.3
        for <netdev@vger.kernel.org>; Sat, 17 Feb 2024 18:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1708222359; x=1708827159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xYJJlqKaHO1pkncPtZXJXYEbaIAzOI1fFVt20ftCrw=;
        b=Qc4KDQxFwbAS0af8uTL3Apu9V1S5UjAu/NoHa1acLjRvEaObBRj6eJ2u+7/3FSDpLQ
         ImEJuzvAB/UNRW43tXC3z2ZUftA5CblLxMQeqBK7P5vGYqxdRvwRv85jN0AFuUJDwU+r
         MUpBgCgjCzZ12SQ89U6f7QTDdG6Sq1O42YU2KDaYoozGQj29HTr6PbduQ4C2UNmTQY/J
         bcO5kCEuRWOocs6z6REZol1/g14EXZAzDBA0MiHR0RGwqOqtUMeT1EMTQO8V4MbdW3mO
         T3bVWEQiglQ9g4Q0AbC66DVw5mCpKQULZm9iJSAmrGnGGdhnV5OZKCnPm3zu4gYRUkv+
         iFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708222359; x=1708827159;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xYJJlqKaHO1pkncPtZXJXYEbaIAzOI1fFVt20ftCrw=;
        b=eeWKbwR5LpD4opFNWs3WIv5BHxFTvF23aoIWXX6iKAeH3/frrfaXMx149zL79rsYsG
         bcKAWc9kgcmYJXFFsTtEohSHHxJ2dzfwTfGWvuLGvyLqn+UdALatpUzYDtefoOqs+hx+
         w2QpQwejWZQfk6251+eFv6k0N52kJR/VsXjW+DJMk33G/cpmykxsJBr+XFtfq/nr5/uw
         Xx3khNw3afm5zejrBwdEE5Aw+EhQKIGFh2yiVknkzuH3IPk4gGTUVMgJ+ibbmD4Wqa4W
         PPgyk7EGZTYfMPxKG7LmEISwhaT6wIbASSyG+kLD1ev8QgZtXaXYVU/1lFU42nTtUGSW
         1VCg==
X-Forwarded-Encrypted: i=1; AJvYcCWk90jQsJEi+sWA8tMFDbzstCjpUPfObnTKDfb6+Nw0DrFLwnnUDSxZbDzJMlMmyrzysP45ZeevLhGOfvq/X/hmzLrHvT/5
X-Gm-Message-State: AOJu0Yx6IrD5q/rmPyM0w8faotvFxJatrR+opdHCvuzcUr+CYnngmlzV
	uWp8D6lsU+V6Dh5s4CiV/0HB6TFPkR02QWA7mUwJHebe+rOkPBmLaIHkOibCM7M=
X-Google-Smtp-Source: AGHT+IGAjZZo/5b/mALKX6lQInelzixTc/kjkrQyfIAb0XUOF35zD515tWDY7c0DXDlJSVvT3CY5Lg==
X-Received: by 2002:a17:903:1105:b0:1d9:8832:f800 with SMTP id n5-20020a170903110500b001d98832f800mr10146861plh.8.1708222359202;
        Sat, 17 Feb 2024 18:12:39 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id v4-20020a170902b7c400b001dbcfa3dcdesm1356882plz.33.2024.02.17.18.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 18:12:38 -0800 (PST)
Date: Sat, 17 Feb 2024 18:12:37 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Laight <David.Laight@ACULAB.COM>
Cc: 'Denis Kirjanov' <kirjanov@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, Denis Kirjanov <dkirjanov@suse.de>
Subject: Re: [PATCH v3 iproute2] ifstat: convert sprintf to snprintf
Message-ID: <20240217181237.449d2f59@hermes.local>
In-Reply-To: <369729fa83564583acbb5c7903641867@AcuMS.aculab.com>
References: <20240214125659.2477-1-dkirjanov@suse.de>
	<369729fa83564583acbb5c7903641867@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Feb 2024 17:51:01 +0000
David Laight <David.Laight@ACULAB.COM> wrote:

> From: Denis Kirjanov
> > Sent: 14 February 2024 12:57
> > 
> > Use snprintf to print only valid data  
> 
> ... to avoid potentially overflowed the temporary buffer.
> 
> Also probably worth using scnprintf() to avoid another change
> when snprintf() is removed (because the return value is dangerous).
> 

No.
Read the thread, return value is almost never used in iproute2
and where it is, the checks are in place.

