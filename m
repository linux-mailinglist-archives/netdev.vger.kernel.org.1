Return-Path: <netdev+bounces-67864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5F184522A
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 08:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4081C2526F
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 07:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCF2157E8A;
	Thu,  1 Feb 2024 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="KVHRufhb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3915285C7D
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 07:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706773383; cv=none; b=C37Rw1/a3g1kn68Gl0iT06jlLIyfg05lCp1RtgZ4NKYQpDBe7VUNY+IOehiUGAnPmw2uuuy6JkmCNCg3DDDpzQYKDRZMJURDa1+RRGxZ2tSBOmRkaGvPnCGI7lSNTRwWvL1jQD5XAoc8bbM4VjoSdlIYPPmvM5n1WpwgGhjZSl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706773383; c=relaxed/simple;
	bh=e94shsC29e1VNGM8RduCeTaJZI1jor9ldW8up3OpF9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGhvoc4xObQCfvHq/M9WQM4ZColi+qPcFaMzYXhyIivp9+jtqeFAmskIBmS9gE2kGXO70/kIv6fP22/FETJY067QcKWXIvbMQLCMVNEnlaA1E82fPpsr20Ou5/PiD/mBMgtB0aXPM2IIlukfeVcrIqGedtGJ5HIy7NUSFFRq4H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=KVHRufhb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so5122615e9.3
        for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 23:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706773380; x=1707378180; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bIwiY3/0OXRMRHobEctVMsrv6IfpcW17O/58yrPU7rU=;
        b=KVHRufhbd8sbfEwljCoL9CNjw5QzzPh9pamr9LaDEIiyX9/YZRhURr3EHHu5uaoP5E
         AwNSQndQw2muaj89iZuDejwaPIGVuzL9/aUfaJJUVhyjWKtu04/D0wtX94/0DjVJ1jP7
         frzUjkEFhR6FpqKGrC7OjCJvSco1eIWH314zSseC4NSNfVVRBsiwWl8HjbNZUjcxVBVE
         T+XUusxlzEmfm9vIfmP1I/qvzMvpXy4l0ZRKd8LT/jj5PG0TcIsFl6MXs/Z16iNw+6o0
         5Xu/rRhNptnTGHeuBK/L2QQtNpgFMXmCg4co0ZyxV4JitDJcsFNDo5Q3p9tpKNTH/FcA
         fjww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706773380; x=1707378180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bIwiY3/0OXRMRHobEctVMsrv6IfpcW17O/58yrPU7rU=;
        b=fpTjfLJg2wjW+Xxh7Pt7d4g2e7pzZNuT51N+MkKap+16RCxgfohr0S3AmYIhd4DW1z
         0htq1AWK0zFdz9GJwYtttG/tLf2A/UDSsHRbl17K+J2SgQHpUKQLQiqY9S8qJ3Ave3tu
         3DlA3Sv8SChrq24FbFeXy1vy2OLL0aiTPVvfFLw7/lSm8KDRmOzQ9H14ZPgCrcRZGoW4
         +dQHGnFSnwkEFI7Kr4h5DhudadicwXyjKTnwgKpWqgQAWn+HsjQSz3LKLQR7vcc1Peol
         rW5Z1PEt1gLebRTr0L72SVKneMCe5x8XjFJ65UlgIJVzf/x/n82I4iMqg41KqZlF8Yj3
         kk7A==
X-Gm-Message-State: AOJu0YwtpE7rCb8rizGjgzhkCTMiAXhDzwJn5SewaOap7UcdlehSo2fe
	lG47JQg6KqHDWtIWpUCCQltUpj9rivuUYsz3i7tpSFuo4Yc92HrRTFeHzOl+et4=
X-Google-Smtp-Source: AGHT+IFM72i3dfmjauq0Nzivx1xbBtSwerH0NtLifNq17YVO5AxkrzxocbmJ/9hhLYlbbwRqJqylmw==
X-Received: by 2002:a5d:638b:0:b0:33a:eda5:acde with SMTP id p11-20020a5d638b000000b0033aeda5acdemr1033119wru.11.1706773380237;
        Wed, 31 Jan 2024 23:43:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWP6SrkJipsQwN1Gc0er7jisj0oQ2cSf4pFlGtqFLgpDH7MXHrISwKk3zouvNIrrX77RC132a1Eqg/8vih4iVQStzYawWmV6hxLkmyZfkhxoX62rgb6EyIkyAjbAh1IW8gYsE6n1kxvGAhP0oaOGObE+NdjAptTvQ8E6msqrh9saahhy9uAlet6nfdCKVGGVAScj3Zd9g2xigJeY0dwF2QO8qay4mCHko9bUeHtkz4P7yPvqXJ9Jh8tVtm/a2Qi8nYadg==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id bp20-20020a5d5a94000000b0033af280ec84sm9236283wrb.26.2024.01.31.23.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 23:42:59 -0800 (PST)
Date: Thu, 1 Feb 2024 08:42:57 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Yinjun Zhang <yinjun.zhang@corigine.com>
Cc: Louis Peens <louis.peens@corigine.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Fei Qin <fei.qin@nephogine.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	oss-drivers <oss-drivers@corigine.com>
Subject: Re: [PATCH net-next 2/2] nfp: customize the dim profiles
Message-ID: <ZbtLgcBcd5B2ZkPC@nanopsycho>
References: <20240131085426.45374-1-louis.peens@corigine.com>
 <20240131085426.45374-3-louis.peens@corigine.com>
 <ZboVNWrlgucuxH9N@nanopsycho>
 <DM6PR13MB37051F13B28B53F2CE135CE0FC432@DM6PR13MB3705.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR13MB37051F13B28B53F2CE135CE0FC432@DM6PR13MB3705.namprd13.prod.outlook.com>

Thu, Feb 01, 2024 at 03:16:50AM CET, yinjun.zhang@corigine.com wrote:
>On Wednesday, January 31, 2024 5:39 PM, Jiri Pirko wrote:
><...>
>> It looks incorrect to hardcode it like this. There is a reason this is
>> abstracted out in lib/dim/net_dim.c to avoid exactly this. Can't you
>> perhaps introduce your modified profile there and keep using
>> net_dim_get_[tr]x_moderation() helpers?
>> 
>
>We don't know if this introduced profile is adaptable to other NICs/vendors,
>it's generated based on NFP's performance. Do you really think it's
>appropriate to move it to the net_dim.c as a new common profile like:
>enum dim_cq_period_mode {
>        DIM_CQ_PERIOD_MODE_START_FROM_EQE = 0x0,
>        DIM_CQ_PERIOD_MODE_START_FROM_CQE = 0x1,
>+       DIM_CQ_PERIOD_MODE_SPECIFIC_0 = 0x2,

Maybe. Can't think of anything better atm. Maybe others would have some
ideas.

>        DIM_CQ_PERIOD_NUM_MODES
> };
>
>

