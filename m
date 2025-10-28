Return-Path: <netdev+bounces-233530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 547E5C151CB
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC8C1AA47B7
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BDD33858F;
	Tue, 28 Oct 2025 14:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OR6irS/Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6805330FC10
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761660587; cv=none; b=UlhUnYaDPE0v2Sk7gndiWNAV5JmEvjdLZulihpuyNCsrVyVuM9gVaoMft817UznzFz0yEh7F1uFnCfwHUP0dIHO6+9XJSeQpi7xnVBlAdKMWLRvFhlGmrIQf80pbaDUtnst+Sz36UqqGpm5rYypJ8YQvbjWXtnaoO7FiMqe+fXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761660587; c=relaxed/simple;
	bh=unnUb/eSm49TuPeg6eODeqzKIWef+4vsiWvFR1TFhB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=amc/U9cfzX320d0bG95De3G1Hp9T1OATT+v0w4Twbbk5AJW/EpDa7yEVHPDYKduigGv9KzhV3WYGbMr2kz9sjjt9fqPtKA0kYywXdVA6oViB6VL5IHg30U+Co+LfU7EDZgPrTFo4vYBO0DGplLb28tPA8Ika+urODVf+nxjpNbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OR6irS/Q; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7829fc3b7deso47899637b3.3
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761660585; x=1762265385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=unnUb/eSm49TuPeg6eODeqzKIWef+4vsiWvFR1TFhB8=;
        b=OR6irS/Q0ZbSBhDil9rrWYCoZesNdU52tfuJEmTvs/FtVsg+8aNrk6WgzyLiigqPqZ
         CbUHBvk2uN+b1ovusH6FY7vAQhypa049pdBSk3qfQ2RWkZzvyrHJi/R04M8ieiSWa9PF
         FnPkp2PlUr0urRSVUN3vjZKmQhsNrjHRHvqQpUZgPkVK9OsU2pmBFH5Ir1DMKkaujKvI
         fnTnFmomEF5jaG+sgRY50NM6MOnLZuE8DjYj5JsmFanNlMGeo/h+NdzjLio/5Z+se7Om
         Sp2Kiy4TxHYa8dVDU6exojH1+xjK5mFcOB79VYVJz4RHhXv4715WHc0zzKCueoZsU8eF
         QhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761660585; x=1762265385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unnUb/eSm49TuPeg6eODeqzKIWef+4vsiWvFR1TFhB8=;
        b=dVi9GIWjvF9zt7/YiN2AZOayzokdD8ery0uN48rOhGpKhUnRRb67zFy8uH4dVifQrV
         XTzO+oeRmTAQhhdblKie5HOujLV0bCONU7wRz9ZXiuvlMt1SOyCiYmTjrO8Tg/JAHldF
         O8624YGuPwj4eLREC/rIyKMN7eBt+/MF372RLZLG96s9zNV8UzVO1LOtAab/boFbfdYB
         fl17l5KlE0MWaDMrRHOB7rEG46eJEtlzPU4w7f101YD3+sNqx3QRQMcoZqSK2idpX6yC
         ZRzmYibHPtDG6w5ElCRhPqi+EAS9Lheh044ZwoyJzVeTaXwWGhDipqiBpTx3mDKOwDQE
         Xgaw==
X-Forwarded-Encrypted: i=1; AJvYcCXT8occye1LVF0Lu5HwK1W2bCiS6IWhpZxgXtmgEHPhv0j3OQupjbVs8kFM0EafZoPN8/2byy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvZQJfskJo8Qs4JUuLsXEyZbaWqoHUuQ3G7TpN1bxb007cIQj9
	soLwHX7/Th9oIhrn60eeBUg0dQ+5mE/tn50cG8Imr3tW98SEbnyX8KPi
X-Gm-Gg: ASbGncvV44EVxtcz1AeRmcvMBaFiQfdLTr1b//LwtHrExJOCRKoypr4rLgmAeKMYOCE
	G3qaXQAOqnL8s0EVD0B6xx7pDblv+ra3y2X9g4LOGW5fRWEpnjdnM4dMjqB0g1U7W6Ic/mYqVMN
	EkHk0qpt12joMLuDz7hZSJ8d/sbHa0mE8antLdrLJmu8MyjrH8vYZ5PWgOpgtQmIF980sWVrZBO
	iATm2mdvLA41s1m+izb4Arl2YiJ1AZgiss11kJbLZTYnmjQtuPfvqp1mWGLyvjTRUI0DN265E1V
	gqbDo/nrkTiXpU96+pCb+VuwfcuE8HErTXsJSg+HkGy+0UA2JstlbWS/L6xI4kgzYTW/Waxu1zH
	pxSVJjTKNKW/zfRVvreOhAZLFU+U61q+iyQwmEgumgMyumxjCWrP4kADN0MHqpajf+PWLa+lPsT
	b2dk2iOXu3JafLyFssBU0=
X-Google-Smtp-Source: AGHT+IEvxs7ohiYNwW7xTxAotIV30qgCydIQJhW/9TRA9i6dkFEwWmMisgvTyOn0Z2/Nz9kzUXhyZA==
X-Received: by 2002:a05:690c:13:b0:782:f343:62af with SMTP id 00721157ae682-786183cada5mr36711427b3.61.1761660585069;
        Tue, 28 Oct 2025 07:09:45 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed17dbd8sm28029987b3.15.2025.10.28.07.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 07:09:44 -0700 (PDT)
Date: Tue, 28 Oct 2025 07:09:41 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
Message-ID: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org>
References: <20251028095143.396385-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028095143.396385-1-junjie.cao@intel.com>

On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
> Syzbot reports a NULL function pointer call on arm64 when
> ptp_clock_gettime() falls back to ->gettime64() and the driver provides
> neither ->gettimex64() nor ->gettime64(). This leads to a crash in the
> posix clock gettime path.

Drivers must provide a gettime method.

If they do not, then that is a bug in the driver.

Thanks,
Richard

