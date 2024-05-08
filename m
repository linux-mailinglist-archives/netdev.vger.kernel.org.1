Return-Path: <netdev+bounces-94397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BFC8BF549
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 06:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6896B22AA6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 04:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACA6C147;
	Wed,  8 May 2024 04:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y22blxSF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7DC364;
	Wed,  8 May 2024 04:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715143469; cv=none; b=C1ySx84fjrKJZ7UwbzpbdlLBG4/aHVef72HYL1rxMUAFsDfse4BNQgUd9LvRQIX/2LWNyGuqFS9ykLBY7Ak56puxRkUVCrbmrXvP3HfzoZppbm4KxjZKeX00gsIG8Abmv7Hyk+l/WicT4srb0dNfZcm+5WSGVBZdR53w370Rh38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715143469; c=relaxed/simple;
	bh=iOUJ8kYbuUYawD/L951m0iz1DP0bS5YCnIXkJbzD++8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFk1R+26v1m9Yp7fOZczXQ9IJiRM3noKBuLDDQCJ9wAm5/kfFAAi6CR0A3PoBQRa0VyqersZwtlZ90Zg0ttD1IpQv0NMPYpybhCs4B14B4lLSsX+ilk9s+Iq/OOn+ibn7w5/ne44uwL+EuRY5waiXNdRBTai6uQmc06SyH/xsyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y22blxSF; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-deb6495a8c5so13404276.2;
        Tue, 07 May 2024 21:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715143466; x=1715748266; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W7zDgjfQ9ejdYEtQFd2CZ42/9Zvjl6dq+wJeEOP1/pM=;
        b=Y22blxSFxRQDlL/3Dx6eV7P0WHgvem1AoS++pZIK0kwSeNtaAwQ4OD3JiGytrPzVJd
         EmT4yyTYitdxx3GjKaEzyaO1iQb4JBF0gBCQjtkTckGkiXI0pX3tcusuRgPG5rpqoS57
         eBRA97SaqNfLewXM/2JtupHJmofCNJlGRSy0R0E88vCQ84NoRr07CPPQXAxJ1eQowLvF
         oRJ5VO9tg3HflyNA4Ff1vw/UmnNrHsxU/kaou6JTw8AQYYxUTg/LW1HWo8arnr0Jph1c
         xSVz+NLKa8ujIst47Eyyu6tp0GRWasBQqiZXlQ1CtRqD0cruh05yq0KmOVOeyW0GGksW
         dMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715143466; x=1715748266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7zDgjfQ9ejdYEtQFd2CZ42/9Zvjl6dq+wJeEOP1/pM=;
        b=ac2fRKE9ntTq312PnjHE93b+z0VIsbGOB9c3PpdXpNdTY5ckAmofdGru6QQmvsSdFm
         Hp9j3bsxhSWX6RbLw23jdLHUZZ6jlMMMqSlKUhTsYEGhZy6fwgo2+NM0TF25mz+KJi9s
         anlADvkWa/NzvhwRbY0fAQosTLIWxmutgJD/IBafsGwZ1wFcY/VS4xKQTzcOFa99C76z
         JWOI5iIBGi6H2ljhgrUlvUZLM5+tk128FxLJYDatI7MbaHqnVLbhse4mVwkiK4eWi2jm
         VeSkB+GnR/MA3mv9ehA+ER/TKabEEHbm81Owja500L1dsDUk2xBVk1De29C5ftQPr4AK
         zv4g==
X-Forwarded-Encrypted: i=1; AJvYcCWk60XQcq/gotC23L8+ZLYMxJ/zXkbnrFa2QS3znyiCMikgSZRUyymClRujFrOPMAQ0taeKm9XMaSuMSg/yxTdHO3z870tMZs/63Tul
X-Gm-Message-State: AOJu0Yzz9kqkgTP3dqPOBPlalYny3Zgvy/t35MEGjMV8/WLkG/7etcbB
	5RAu22BlygBbz+/e+sa0ySsNl+Cca5SWPZMN93JzhO81sCfWDzm8mSbEAg==
X-Google-Smtp-Source: AGHT+IGE4AcWoLxQ3WsFkXQSbENWAJJpe8pMCBqlSyO6HdO1/kFk8awXmWPH4G/IX0ptaHx9IOD9MQ==
X-Received: by 2002:a25:5855:0:b0:de4:5c38:40b8 with SMTP id 3f1490d57ef6-debb9e5b635mr1313776276.6.1715143466411;
        Tue, 07 May 2024 21:44:26 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id b3-20020a5b0083000000b00de763b8a696sm2936160ybp.20.2024.05.07.21.44.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 21:44:25 -0700 (PDT)
Date: Tue, 7 May 2024 21:44:23 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
	Sagi Maimon <maimon.sagi@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv4 net-next] ptp/ioctl: support MONOTONIC_RAW timestamps
 for PTP_SYS_OFFSET_EXTENDED
Message-ID: <ZjsDJ-adNCBQIbG1@hoboy.vegasvil.org>
References: <20240502211047.2240237-1-maheshb@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240502211047.2240237-1-maheshb@google.com>

On Thu, May 02, 2024 at 02:10:47PM -0700, Mahesh Bandewar wrote:

> @@ -457,14 +459,34 @@ static inline ktime_t ptp_convert_timestamp(const ktime_t *hwtstamp,
>  
>  static inline void ptp_read_system_prets(struct ptp_system_timestamp *sts)
>  {
> -	if (sts)
> -		ktime_get_real_ts64(&sts->pre_ts);
> +	if (sts) {
> +		switch (sts->clockid) {
> +		case CLOCK_REALTIME:
> +			ktime_get_real_ts64(&sts->pre_ts);
> +			break;
> +		case CLOCK_MONOTONIC_RAW:
> +			ktime_get_raw_ts64(&sts->pre_ts);
> +			break;

Why not add CLOCK_MONOTONIC as well?
That would be useful in many cases.

> +/*
> + * ptp_sys_offset_extended - data structure for IOCTL operation
> + *			     PTP_SYS_OFFSET_EXTENDED
> + *
> + * @n_samples:	Desired number of measurements.
> + * @clockid:	clockid of a clock-base used for pre/post timestamps.
> + * @rsv:	Reserved for future use.
> + * @ts:		Array of samples in the form [pre-TS, PHC, post-TS]. The
> + *		kernel provides @n_samples.
> + *
> + * History:
> + * v1: Initial implementation.
> + *
> + * v2: Use the first word of the reserved-field for @clockid. That's
> + *     backward compatible since v1 expects all three reserved words
> + *     (@rsv[3]) to be 0 while the clockid (first word in v2) for
> + *     CLOCK_REALTIME is '0'.

This is not really appropriate for a source code comment.  The
un-merged patch series iterations are preserved at lore.kernel in case
someone needs that.

The "backward compatible" information really wants to be in the commit
message.

Thanks,
Richard


