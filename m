Return-Path: <netdev+bounces-158288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B9AA1153E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 00:19:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3265C3A2394
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 23:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B15CA2135BC;
	Tue, 14 Jan 2025 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Titk9AUu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195CA1C3BEB
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 23:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736896765; cv=none; b=i9bkno9xaB0qAtSDTbsaBdyyfKI05GE/X3E0Pp265CrY99Wn9l3ZJjXg3G7IwzChX37hvDziudzlrlEHrrzfMT3tkofrNeIQrgmQ2J2sfn6NelCJAqklyi6DsK/Wc0wPVXelw/Y9Bdeoe99hbl9vLtJdBavIx2EyLqeJJNUm5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736896765; c=relaxed/simple;
	bh=oW3Jl1eIZZ7xy6597Shv3w9NGNA648r1kNJb71xiCbY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ohUPQbjHlIjmsi4djnUP1ppLs097/LR3O3+fLfzUEUK4D1Ak4MAzx0SiiqActtWxcLKqVMKu4l6afx1q3c0jVx6agHfIOgZ92Gb9v5Z/a2GyBFR2RyTtg5Rs0hFvtwkdAkpTNWhABLApUjxuVELPiues3TPFmzrEJP0WavqPeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Titk9AUu; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso8092990a91.3
        for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 15:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1736896763; x=1737501563; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbvYctdrGd1fMR1YU0UDT9rZXrxXW/NPmAnjaYjCXGE=;
        b=Titk9AUubJpYd12pr7qqvAH1oKqtEeXoOTxtjo8hFR8Muci9h7K9hkpElC1FDGz73R
         sZBeQHzdF58VXYd/EoevcKOJ7mGT7fBNnPZa9tIw+JKyrv7BktdNoPDMODNhGFhgrUqJ
         6BqQHWoo+9x9F7Bw87uSBfmyjxwGaQDvZCrVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736896763; x=1737501563;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JbvYctdrGd1fMR1YU0UDT9rZXrxXW/NPmAnjaYjCXGE=;
        b=N011mvrkrNQEXWUjAzVVGINTWkw4j4Emfxb0Ur7WBjTUDqc6arNPyKBzWM6GBurNz3
         KclYfMTNRN56wdk1HFSDoLC3dCqqAnBqmBVlDfC9NEywpCEE0V7amFgrkX6Qei/wjRz2
         6pbrX6q9BkJOQm5AjC+cyfCTn7xLfgQBo7/29qB9370Sc/CL/wfxp2D+4tCTtNvPtliM
         m6T0+At7bGYXbvdFspSutlK9ufkbByNXm+ZCqMaOZhWJDIZDfhyEgtE27ouRilPAj5ws
         OTzZtIbZei99EekDRsoSQtlW7G8EZIS+G5UYqFZQWEWGVZVKv2p+xqzncgUQ2Pz2jbA7
         PRAw==
X-Forwarded-Encrypted: i=1; AJvYcCVPFv4oQs2KhdXlEIbL8oAqJ9IimF0HaLvsmBpRejfW3ga6OGZN34Rz3RvObCbWG7cEmdgBJg8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4hDqRB3VkuN5Qa5ZbAwMMrHRpRZg6thTega642skFXPTB3gx5
	hKAJGvTgMm0lhgRORrptNiCI3WXbxzrFDioxX9IwDaSfhM3qeT2qF/w/EELqdNU=
X-Gm-Gg: ASbGncsst1SJQkwIcbSzVaSEbip61HCAe4ADP2Ldlr3Vk6JnqF7d8z2Ihw4JFiEFdeh
	QKpdIUHvThqy9qemcqpqO5tUX6mDOBboKHlc9LvSix2CeZKTNYAQA8JwLsCG1K2DJbyzLVFZq91
	dlvwea0BpvRYA39wvoYDt+imrH9Iugdo7n+4oL1V3opgRFEdII7paR/K+ZYOrjDYL0m2OPNLzmH
	P93peThMJJngzRWTk2/lEswh2OWt52oFIaCfkBgKUEsgz+UqmahkIiTqoTNdK36WZJkkTAJJga7
	rhczAOZ0DM9HajF0Nwl3OHE=
X-Google-Smtp-Source: AGHT+IHFi96ZW3/FlOq6X21nV+AE31+5XhD2kjVGg+hmUGkASSLpTCq/52bYiK6IFby7uzRfV70YKw==
X-Received: by 2002:a17:90b:2e41:b0:2ee:96a5:721e with SMTP id 98e67ed59e1d1-2f548eb25cfmr46358849a91.12.1736896763372;
        Tue, 14 Jan 2025 15:19:23 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f72c2f673esm80109a91.46.2025.01.14.15.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 15:19:22 -0800 (PST)
Date: Tue, 14 Jan 2025 15:19:20 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [PATCH net-next 09/11] net: protect napi->irq with netdev_lock()
Message-ID: <Z4bw-LRerFnH6gIA@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org
References: <20250114035118.110297-1-kuba@kernel.org>
 <20250114035118.110297-10-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114035118.110297-10-kuba@kernel.org>

On Mon, Jan 13, 2025 at 07:51:15PM -0800, Jakub Kicinski wrote:
> Take netdev_lock() in netif_napi_set_irq(). All NAPI "control fields"
> are now protected by that lock (most of the other ones are set during
> napi add/del). The napi_hash_node is fully protected by the hash
> spin lock, but close enough for the kdoc...
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/netdevice.h | 10 +++++++++-
>  net/core/dev.c            |  2 +-
>  2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Joe Damato <jdamato@fastly.com>

