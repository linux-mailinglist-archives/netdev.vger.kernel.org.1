Return-Path: <netdev+bounces-179190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7BDAA7B193
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 23:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05DC516375A
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 21:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 353852E62CE;
	Thu,  3 Apr 2025 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6DczCXv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94D2E62BB
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743716643; cv=none; b=ut9EUmahyigDO9VLqQQIxTKd7nFdHYbYx+ebInnhfFYXm7nNSgLfU51fv0IywTpCjEHOq7lnLROKNlsan3si9c/D+uhGIpPGCnKkPwxXMRu7MHNqQBTBv3WSoY618pkSzrGj5vpDcvg7WRtF/dcaQe4jMM3cDZL05F3L5MkpwkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743716643; c=relaxed/simple;
	bh=/d/01rxAdq8hvUMuGuuucacc+mCukr6gQmr+EDJRMfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XR7V+PiNTjA1JJGDq7JI72UCQeK9DfL93wydEwKHwjcfvzTzmK2sP77vKzqd+xhY2AmCkd91bxYFIUQAigr7UIfdtBgadOdUHidmE8XZ82mMkD11EtI1/d+6ivsehAREgnCDYJS1zZ2BXgDtKYauJ4srtQ1Kb3prFNmwxskCZKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6DczCXv; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so1141359b3a.2
        for <netdev@vger.kernel.org>; Thu, 03 Apr 2025 14:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743716641; x=1744321441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNgySazCwvJrfPD8D3gNA1arU7/wxttNs8R7mQWUw1k=;
        b=m6DczCXvmJUbETm7CjAb7EERgMl6qWyvmf9E4kIJPS5WXqsGRmzMLVtb4d/5LtvUpO
         vDt/lFQ+MeBud7yyYXJiEbu1Ttyz5E74DmZDpy7SpaDpBH712fHnjO3dvXuHXBPQ1FWR
         FAGZzxNFLKqHGct3R7jdie7/OYmnThCJZrcejzMoSwLfab8FFu5AmMAKQFeYjPTWec32
         noYYqsM+AIY4oMK7QZmvDMheiQNxuBXHM7vqkFSb3GJ7m4Nvzvo/2iCFPrUXRzphjqPV
         Xw/C3e93PNIyT8Bfts0RTo7vVegSY18gwPnYxQ83BhJMdxb0kcGrSh9uI0nkm8xZwp2a
         WCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743716641; x=1744321441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNgySazCwvJrfPD8D3gNA1arU7/wxttNs8R7mQWUw1k=;
        b=A2PhixShhumuN82mPz8qp7xfcswo8BmDuMk3OMas/8j8WTBDmnuQ9lSDGbtiawibWG
         kJN/20CrA1Odv0NzE5hgF0/812VFv8fI8S3gDWfkPL7nHiKfSMFOydmNH9yWBWxRaoMG
         jOx/W9v/zRBtE7rSbeUJ6g5bgJ0YUx0lgK5StCAEnDO8VA+i0QxRWFvu1vw1BKcvvqUE
         oX/oM21fh4iyHaiODTSBu9o4Kf6EaKlcNl56pZ4s1WontRnoRz1mULx+wyThmKAeC3im
         HSJHjd6xMbzQaO7H7Qz1AxMkhK5Nqdr+gboFOw8GqLyFKtGnXGNf0cPPad8EjujK+2g3
         5QHw==
X-Forwarded-Encrypted: i=1; AJvYcCXguuGagngVl+PaT4S+0B22Vd7CJwuVmTZLi3c/OPdsljpPF4r+hTfsWNaKELRSTryIkGj7CiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMp22eyUxah7zkh2cmmxif8QMShM8uR9gMFWrYCIBIQrsW6Mxz
	QzZI5hnCezOstqlYxZ6ZzFU5bHBBwPXJaGtRiMevIMAkV+5ZEPMa
X-Gm-Gg: ASbGncvgk+Mw/IIAYCnxAWhphFwh7flhri5ioqB0fLf4XA3eqqn6q9GTwxrAs3vQVbe
	ce7o+So+OipBTQ8vfcwbEI4mp5O3r+RERKwMPttoK1M6Oan+NCEnpGLm7E+d4eKs8OO4YKDkJZ8
	r1EHeCpEo+aZZLiKpqYKCuE866HsT4lF8+cphraSnSv2CtNm+8J/oT3eK8wpedvMQjEhFM3lz38
	o4wDCgqMtZPMsHFAqVFLuvUSj5YgBlKgaMWc6E3sBQaLfEjMhcLIjqV/ptVQlcu8qpEcu2H26jK
	gG00VCt2tXaMUoDEI84kWAeWnvapkyjRjSw5BsOfu3yTF/8O
X-Google-Smtp-Source: AGHT+IHFne56kGUfbIvnpUCPESoYDrnEBbgHy8yHydIvYb1vgH6Z6EfCkhP3D1pHJcoK3STiSXvTYA==
X-Received: by 2002:a05:6a00:244b:b0:736:450c:fa56 with SMTP id d2e1a72fcca58-739e6fa9cfamr512394b3a.5.1743716640626;
        Thu, 03 Apr 2025 14:44:00 -0700 (PDT)
Received: from localhost ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0ea190sm2079163b3a.177.2025.04.03.14.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 14:43:59 -0700 (PDT)
Date: Thu, 3 Apr 2025 14:43:58 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: Octavian Purdila <tavip@google.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] net_sched: sch_sfq: reject a derived limit of
 1
Message-ID: <Z+8BHkw5Q0KtASdm@pop-os.localdomain>
References: <20250402162750.1671155-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402162750.1671155-1-tavip@google.com>

On Wed, Apr 02, 2025 at 09:27:47AM -0700, Octavian Purdila wrote:
> Because sfq parameters can influence each other there can be
> situations where although the user sets a limit of 2 it can be lowered
> to 1:
> 
> $ tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 1 depth 1
> $ tc qdisc show dev dummy0
> qdisc sfq 1: dev dummy0 root refcnt 2 limit 1p quantum 1514b depth 1 divisor 1024
> 
> $ tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 10 depth 1 divisor 1
> $ tc qdisc show dev dummy0
> qdisc sfq 2: root refcnt 2 limit 1p quantum 1514b depth 1 divisor 1
> 
> As a limit of 1 is invalid, this patch series moves the limit
> validation to after all configuration changes have been done. To do
> so, the configuration is done in a temporary work area then applied to
> the internal state.
> 
> The patch series also adds new test cases.

Acked-by: Cong Wang <xiyou.wangcong@gmail.com>

Please carry this Ack when you send v3.

Thanks.

