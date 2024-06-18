Return-Path: <netdev+bounces-104556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F8D90D4F8
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 16:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 535E3290B63
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 14:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9B6158213;
	Tue, 18 Jun 2024 14:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="Yh4U1CQx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435AB13A89B
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 14:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719564; cv=none; b=Xfv1NXWTe7RymZQLVMurvgoD998c4U/W7U57JfsLN8rzvSqDvsVVe49X7+HehImhyuROxPWD5uUqNgc2OtZWOpvNYZvxOOOnhiuF5OXMDN2COAA8rMnOz10Z/HYXkeiw3q7S+r1ollQFsacUamIM+PGHjX5wm3bK82y4Zy+7Tq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719564; c=relaxed/simple;
	bh=04/tbEPWIlzSSeHU9wlvxwNF+LmoJL2+5nJuBYusf84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5sH62seice1qklsBlDgFPJ95yXiUYm2XJmcjOdsxGM4/cJXhi/k3dTyf+H2M4qkxgDeJHMsyArZDmX1q5XdbCfs+hoxtL2hglWPLfTDNMHIo4TrIHx1AWmQRHa3vK6s8M0Wi1HLqB0f0GXlrvLe9p8kGLbctfjzfG1s6NjmGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=Yh4U1CQx; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-35f06861ae6so4764832f8f.2
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1718719560; x=1719324360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=04/tbEPWIlzSSeHU9wlvxwNF+LmoJL2+5nJuBYusf84=;
        b=Yh4U1CQx0Lgye9unT0e9Ud406zDkIjSjOopSEG76qMtAGf79pJA7+FE6orwSB+cBSA
         V0qMbMVVGfL+UUpZ1ah35gF+0hkGTxV0kjnS6zR7y3sstPBOQfwq2MZclsfVuO96vpc4
         0JOJLTa6eLKEoJMLcD4qokl6/y/mVrUBYtUDtNtxRywPMGl3u43fvMd9BwKHdSQMKdxc
         ehEfWOSz9VuZSV1MJVvKxQLm4gFaEXx1yKBL39i9zFAoN163dE4Hpir9aExcxHnbFxOu
         rsYs7Xe0Q4lx9hApNHk9O1xZJSm4maujl49Xfl+Icw04kgQH3rfNhtCzmS4uV8v9RJa9
         lI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718719560; x=1719324360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04/tbEPWIlzSSeHU9wlvxwNF+LmoJL2+5nJuBYusf84=;
        b=Yvp1CNjEYCneqLpUZhM4YPi1yTxglsNKo49PxqT5BfbBmRLXCVB1gIt2qah71stiv2
         fO5GHtdb2ZzbpBcfEMPrEevZe49lWUBCqkXGH8UbBsc5SbPrMOf24g4oNB4FL5wbQWG3
         AlebJ/nf80+6dZnV4pKAJBpnqpSeYcva/JZ2YXL1JZ+rj94EGf68DadxD90JkZxO57Wx
         yujBNas2/476oTuHp4sceqv2MZPrfZmcgQ8eoZ6nC94+cNGGofffWXuvNzUOYk7chhjX
         FOxyq/IwaDiYDUr2s9iDBfureq/9Wf44cqQhkelIKD1HbUsqnDrt9bQCxMIGPYbRxr6I
         /2sA==
X-Forwarded-Encrypted: i=1; AJvYcCXFM0Oq0jboY2kaWuGS7tUclFiberCOe0KgYjrdxu5ZO6OXP843JqdAJWOhW/t+EDyQrLB8fjH6b5GJL5kGHL7no2yL0b91
X-Gm-Message-State: AOJu0Yzm00ljy6SGCILulZMd3EBJErc3IKnPz4JgrnzwqVaJJrNs1dUp
	e2TYjC30iDgB4dsO6+Vga3a2J/TiihNcck1FkJK4P4cr54SIXsyIPJMZhq0bBKU=
X-Google-Smtp-Source: AGHT+IE7bMWr/KjUbc0niKCiWMXu0LbpQKaj1GXm+QhhAO3g7QpNVncrgW1KSZOUIgxRobwzYgfe7A==
X-Received: by 2002:a5d:424d:0:b0:361:81b9:bfe3 with SMTP id ffacd0b85a97d-36181b9c0dbmr1185057f8f.24.1718719560595;
        Tue, 18 Jun 2024 07:06:00 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3607509c79bsm14361744f8f.41.2024.06.18.07.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 07:06:00 -0700 (PDT)
Date: Tue, 18 Jun 2024 16:05:57 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: core: Remove the dup_errno parameter in
 dev_prep_valid_name()
Message-ID: <ZnGURZgU5sRkTvPm@nanopsycho.orion>
References: <20240618131743.2690-1-yajun.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618131743.2690-1-yajun.deng@linux.dev>

Tue, Jun 18, 2024 at 03:17:43PM CEST, yajun.deng@linux.dev wrote:
>netdev_name_in_use() return -EEXIST makes more sense if it's not NULL.
>But dev_alloc_name() should keep the -ENFILE errno.
>
>Remove the dup_errno parameter in dev_prep_valid_name() and add a
>conditional operator to dev_alloc_name(), replace -EEXIST with
>-ENFILE.
>
>Signed-off-by: Yajun Deng <yajun.deng@linux.dev>

Why not.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

