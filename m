Return-Path: <netdev+bounces-68344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D47846ADF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 09:39:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDF27B23536
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 08:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458CE5FB8A;
	Fri,  2 Feb 2024 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="M4U6/ncJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4115FDA3
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 08:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863170; cv=none; b=hAxGcVKFjkz7l0TqXgPYIVMFNNhSr2ptym0lsVNZGqlYuJacBgGPaomfEHbS0WJE24y5WZ6vU3Khz6EGKLIDb31HKHhUoB1H+7cBmIzMvQdEMmIwdVL3SEawSPz5S2Ixhs1iAHuMOnPKdaHyAhl+qwqZJzOta92AAsO6acTdUy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863170; c=relaxed/simple;
	bh=JLkPFQpIy1oLwpzzhEnpjuaJWvmZz3fTSqray4LYca0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=by0xPAQsLORbeDHNbmoFF9XtC8SJXh9T1YdjSHYUMV36RH0R7TSSf9OVllG6OOxauuNS64ioKNhh8IpUvizacLqEy5U0YHG1jlOaDxjaEEx6CkfjubVkMO0exAFLIThBxunBrHPkKm/8x5m1PVMWixYn+Qm1OU1Pn8yTd2U0YWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=M4U6/ncJ; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d07d74be60so15220411fa.3
        for <netdev@vger.kernel.org>; Fri, 02 Feb 2024 00:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706863165; x=1707467965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/dQeLZalH/sXacUPHud9aP5O4P0g3K5C3fjfkdt4C9M=;
        b=M4U6/ncJcQd4rOnrewI2LiiHKGliH6NiThgX9VS9ZNiG6pRg9VtV0XBPWoJNcqX0B7
         fKxhf+Rafipgvk30ulJAcE07TqBpTjKrSN8aQ4ItFJdAq9TTbmfHnFEeGqmHKJgXdysx
         usQ0D38NQyxBtp7RjaHCVERoRVm1mLtfN0jKVAENwwlDkWNu4ccn/X8jH33YL8xgRO4t
         Cm+aiGhiPf5o2AiZ4ffrq9I6qQAQsQmhsjCIiCNgMpszowB2Y5V0vxFWJ9gs3yLXY+U9
         TwswVtpp/hAg4ZfJZx3WtuUUL2P5epzNXKiGsY6s1U/hI6QE4e6VniXMkqh5kqRZSVBb
         QRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863165; x=1707467965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/dQeLZalH/sXacUPHud9aP5O4P0g3K5C3fjfkdt4C9M=;
        b=BETS0OyfTDN9DM2uMrmwyM0ZxoWIJAtmopTzxaZWV7tQh6zXY1WcKLLsCknkOpOdJ5
         J8Y93gUyTRrYxUsu7Yh7dTJQQWAeyVuXkbVimyTjZvZKlvICmzTiUiQTkn3N+eSwiMHM
         AkjFRD2DGlTIitswDN7KlUnGv7N7F+O9KayoOqTqpuDlYDup1KXydzYO60IecMXzFd2Q
         phvXmZ4SwKgijIqJwgfVwyD2sBJjy/Qt49x2POnFq0sYlk7B7IJXAiuUhvXJNAGnmKfw
         UdOhnjNZ7n1XCW2Isk1bhpJbSzFzY34izEyxLcz0NHlWiN7aeSwMQ98WuMsKEeWdXSh1
         29yA==
X-Gm-Message-State: AOJu0YznZ77URaIpIoiGsAFIDY/h4voO26aizsYXRz/W9Ib88qYeaUws
	NY4v2LGIfLF5Kuygz6HhmxHHnGDucUtp1eP1uVHwM6XCOQ+GTWv8wEgxuy4nUlQ=
X-Google-Smtp-Source: AGHT+IEb9GLrdlS5HkGPdk2Td6uv5TgAI406llDlpH1+HxuyW7Jfvm7h7qMnDd1l+U3gYWiyYMLi/g==
X-Received: by 2002:a2e:9a94:0:b0:2cf:33a3:42fd with SMTP id p20-20020a2e9a94000000b002cf33a342fdmr760950lji.2.1706863164811;
        Fri, 02 Feb 2024 00:39:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVRBI4BB+kLCHGl8CenUURewYXN4VkdRv363xDfA8QomFdlU4a9KfScWPxS9HxtXLN05VJoG3j6yGUP7g/smzjd0vGoepbPebNh5+pLvmTzXboDznzR2Tz+oJvPnLOmfeDJ1WPlPIXvTBJ2fOLXfVunfQa8CoK8k6QvjE0AMNMocSHtsVxzWKvv0kyDeLgSbfligWXWysEKCtINY+FXkX2OyAljVSAengq48qrXVzuWY1HaKnAPffd7ue8m62dDttRX7JzScQ==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id s12-20020a05600c45cc00b0040e813f1f31sm1941120wmo.25.2024.02.02.00.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:39:24 -0800 (PST)
Date: Fri, 2 Feb 2024 09:39:21 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net] netdevsim: avoid potential loop in
 nsim_dev_trap_report_work()
Message-ID: <ZbyqOdvIMijpIwkm@nanopsycho>
References: <20240201175324.3752746-1-edumazet@google.com>
 <9259d368c091b071d16bd1969240f4e9dffe92fb.camel@redhat.com>
 <CANn89i+MLtYa9kxc4r_etSrz87hoMF8L_HHbJXtaNEU7C22-Ng@mail.gmail.com>
 <20240201134108.195cf302@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201134108.195cf302@kernel.org>

Thu, Feb 01, 2024 at 10:41:08PM CET, kuba@kernel.org wrote:
>On Thu, 1 Feb 2024 21:10:46 +0100 Eric Dumazet wrote:
>> > And possibly adding 1ms delay there could be problematic?  
>> 
>> A conversion to schedule_delayed_work() would be needed I think.
>> 
>> I looked at all syzbot reports and did not find
>> devlink_rel_nested_in_notify_work() in them,
>> I guess we were lucky all this time :)
>
>FWIW the devlink_rel_* stuff is for linecards and SIOV sub function
>instances, netdevsim can't fake those so syzbot probably never
>exercises that code :(
>
>Jiri is on CC, so we can consider him notified about the problem
>and leave it to him? :)

Will take care of that.

>

