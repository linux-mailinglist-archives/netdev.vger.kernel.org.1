Return-Path: <netdev+bounces-166878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C725A37B49
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 07:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064CF18924B7
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 06:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10B718B492;
	Mon, 17 Feb 2025 06:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="tXRP/I4k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC79E1885B4
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 06:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739772889; cv=none; b=S6mCdKzzGMakpCXholgWT/FcjzywSfScPgbwG6zDyQS9IPWFTv/PFOxWJ+UKijligi+6jOLnhQU0dxnyOjvOhQ+2v/b2Uu794H20vRZdYuVTrEVcMS+KeWGROuKBdgRUUOOWnWf4VQSAo3t8zK0cMdMaNwasD6ouTZVMmKL0QZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739772889; c=relaxed/simple;
	bh=Fs9S40b6w8HXNDPJIeZcnrQQ6+4qYJ9kaM73w0XMotY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZ9COo/KgKyLH1p/2quSsQIQGRVH3YdH+9hqcpHyLFRDeaeq1UOewkKzhzC4zCnNmcXGmarHJYZEsKNYpXtP9OxbsYusGHrUtOlFgEYdazKo0YBzbR9rUiYsZEg36cYvgSvCMwa/SizzMYvBSqhoarlDYgrs409pahA7o2OsbvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=tXRP/I4k; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-220c4159f87so52179295ad.0
        for <netdev@vger.kernel.org>; Sun, 16 Feb 2025 22:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739772887; x=1740377687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7auImr6nP9NM0oa/FP+uWv7xRTE6wpGoLtPywLpd/hY=;
        b=tXRP/I4kvjsXJRTRrZRizKUYuqg5WJ+KDpBX+zEP9IgQ1BxNcaBYu/c/Zew3QeDpIA
         ziDT7JMOAFsk7BOrdejAfypySK+P2dgrClnRAwT/fybLocLpv6FrQYMPfau0SycUIGi7
         uRobnOVOzDLOkl82KkMWmyLWrvVFYqsK9SQKrd48eHkisz5r+WIMSu7N4yT3X19IYFfd
         bggBE/YqcxVNgcFe41phDlQ+rkwO7+tFScPXUa+lT/N+XCv5f+QZq/gqDGpvQrYhirPf
         GpcLugmvwl329aORAEy/zjFkDX68owu7jsV3yQ8Jfh2hr9j4zffj9qE5Iz15/8M4e65j
         4/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739772887; x=1740377687;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7auImr6nP9NM0oa/FP+uWv7xRTE6wpGoLtPywLpd/hY=;
        b=VbB38Le7MzrVpbo+42DJQq4ktTPSfYQIHQ2PTyqfhIFHkq/PohPzSWuH0Fn4Zkc3zW
         fJNYCwDI72adoDEf1x6oq37VZJDUsk2R9ngBQ7FeCa4H7hb3vctkiu6GjOIWnka4jA1S
         82GCfQ02OsL1N9sKZtRy+NOIeVwmAjGKGZDMaL9Uaf1tNQ75SSaykB8y2BNm913M8mzh
         4Q7Ukn+FfULHgbgdDhEprAAgO/3m/XfJDfOPi2ijltTcl7t2n2fHWF36FMdErBsiR5Bs
         L4k9F7HWahiHMH2UDDZ+szbTaIhTJhgqW87A3841GkJyVdp+Naj5rPDeFAJ7O47zogrd
         ye4g==
X-Gm-Message-State: AOJu0YyFGapRbhaUA7JZt7lnhPBNFNRMROJpb8d7djjI8I5j3+b1ib9l
	Xoe4vMY5fkuezW/Djs5cCYwlBbLsY9a3nlMeAMmYjgKaFDQPWYJlYldjYEVgGFk=
X-Gm-Gg: ASbGnctD+7udwNYUh3txyJQuCu4UejCrBajSgLEuzsAuoVIM/UX1G3S86YoRyZs00CP
	7Q7EDB3m8oE6eXX+yU6ur1B88xgwClAzwtNxU2MwrEftuClrC32q9NYtmNGRGFm49uxjOXbTSB8
	ICdu/XTtD2mDOb9/VT0B1QtRno3fK4Vp25QonTs1ej7tgBEq8AKQVSZv5187QBE/Cd9gn9GUBY+
	1Hfr8Ppg73quRk+OeSWNSHp+dKJanRfbyjL8StowqBGiktJG5bSE/GKsd13N9PRuAAmVhRJENq2
	HpsGtHO3XTmpxizWfkf2mOnkaexjzLTT58kYtZRJA/r0zpzj/hoTqgaCPEXZTZIaL8Fl
X-Google-Smtp-Source: AGHT+IG5wwgH/k9VIS9R2RYjFVdMYJvnTeuWGGmQ7w5GxI6vl7XYI0iJExM9fB7+yPlzg8c9jHAb2Q==
X-Received: by 2002:a17:902:fc4e:b0:21c:17b2:d345 with SMTP id d9443c01a7336-22103eff158mr134522025ad.3.1739772886953;
        Sun, 16 Feb 2025 22:14:46 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53494c0sm64024325ad.6.2025.02.16.22.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Feb 2025 22:14:46 -0800 (PST)
Date: Sun, 16 Feb 2025 22:14:44 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jonathan Lennox <jonathan.lennox@8x8.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] tc: Fix rounding in tc_calc_xmittime and
 tc_calc_xmitsize.
Message-ID: <20250216221444.6a94a0fe@hermes.local>
In-Reply-To: <85371219-A098-4873-B3B9-0E881E812F2A@8x8.com>
References: <85371219-A098-4873-B3B9-0E881E812F2A@8x8.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Feb 2025 16:16:21 -0500
Jonathan Lennox <jonathan.lennox@8x8.com> wrote:

> The logic in tc that converts between sizes and times for a given rate (the
> functions tc_calc_xmittime and tc_calc_xmitsize) suffers from double rounding,
> with intermediate values getting cast to unsigned int.
> 
> As a result, for example, on my test system (where tick_in_usec=15.625,
> clock_factor=1, and hz=1000000000) for a bitrate of 1Gbps, all tc htb burst
> values between 0 and 999 get encoded as 0; all values between 1000 and 1999
> get encoded as 15 (equivalent to 960 bytes); all values between 2000 and 2999
> as 31 (1984 bytes); etc.
> 
> The attached patch changes this so these calculations are done entirely in
> floating-point, and only rounded to integer values when the value is returned.
> It also changes tc_calc_xmittime to round its calculated value up, rather than
> down, to ensure that the calculated time is actually sufficient for the requested
> size.
> 
> This is a userspace-only fix to tc; no kernel changes are necessary.
> 
> (Please let me know if anything is wrong with this patch, this is my first
> time submitting to any Linux kernel mailing lists.)
> 
> ---

The concept makes sense, but is missing a valid Signed-Off-by: and therefore
needs to be resent.

Also, you don't need to rename the functions, why not always use floating point


