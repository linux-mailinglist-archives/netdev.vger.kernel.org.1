Return-Path: <netdev+bounces-93048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E89498B9D2C
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 17:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C64282EEA
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 15:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E715B12F;
	Thu,  2 May 2024 15:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQILxscN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F015B121
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 15:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714662951; cv=none; b=hKvcSxVf9dZd+83z5XHTD4P5co4HNxiQCg77o/Q/nzR/wRa+XVsY08n0dbL85A81Dm74kpNvv+KaIlnQzVZRWrU+oWra+75sXlbP+EEbEyfcvXmHgfKHRpj+Elp54aeb3v9NXzQeBXb92ab2c9Zu1Xy+QhdQS/hTL4CQ7KGCmW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714662951; c=relaxed/simple;
	bh=JlTUUiHevTXw/hebNrKMCm5Tx+aVo9rledCnaIiL+8Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Yy/UX636PL11o7IlpYWs5AimCNQVpd9r6S293fdYcWQdP4w+21WXdrIeGGvtDGsk+UFhO6B1TEp0CsfM/TDxEtTBOXQqQ9gv/GcoXuGJaeJdRsVY2kM4QT3PcAlg9VlXODPaqkoUDuomnvlp0GgrzM29wHCm3CMwhj7EO23iSsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jQILxscN; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-69b5ece41dfso32593216d6.2
        for <netdev@vger.kernel.org>; Thu, 02 May 2024 08:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714662949; x=1715267749; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aq+4ohb/iZ/uObPNthuWUi/W5Wh7VEBKDTGjjvxBauk=;
        b=jQILxscNHw6G7Lxt1qf45n+3hZMDe6Fn3zLNFG6w1dO5TUtuqOmg1NIIR8jf7FcfX3
         BkuLZMAFHHwh2H3S3eKo9Mt4Ww4yERkkxEgMrXFqo++QobLjiZOI736Z0gUDvsQ05ZKi
         uzVUQYflJTYJMReq+x+ADHmvCUOMY+ST3HteWBleFcRUXbos9ze+jt94QD5Yaolpk4PY
         u9gQmLBDgKkx0+LaKkLN27UwoVZgFrxnvPZHA8MEh2AN8wsXqJwUJFc2qAABzG6vd4zA
         enU0b55A0YSNshrcB2l7h+ia6+4maENEIYisZXQiCRepY1DAYc7uTCvup+8V8lry/K5w
         yMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714662949; x=1715267749;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aq+4ohb/iZ/uObPNthuWUi/W5Wh7VEBKDTGjjvxBauk=;
        b=UOm/6p2hG6R2nAT0bu8Fsp1u9Pz/TIAqkwlgsYlyDcsikOVetG46h0o1IXQkcTElDU
         OJx4qrEBxj1dPPTvvPEVmgLJA21khzHcsNdzaTgtKk5XZdOvEUrHEPufxysa7SltLO0L
         VydCtNFepUXMlUluiCECoWw1dS+ebn1XMekNJf4o4nCiB2hUEs5Cv9850Cf4g7MsxZe6
         ea2/mNCKtIESy1TeRC7HA/1OUuqoFy1nEjm1LcZ9feILfv8Xq9X/qFAuQnnVgotgoSUT
         O3+38inaikJhUZmPYre+m9mL7OaVcDV+MWHdaMxMWYGLLWkDjtGL0AQ7Wy44Dg4q3nNo
         X1uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMAOGM7Izy+XV7EiX7Vu3Lf3ST14lB6eMcQgjOvmFBUXGp1eaC84kdQXCBeIXP77Xauvu7+RylrWPNllvqtoU9G0e7UMgA
X-Gm-Message-State: AOJu0YzeWCtjy5tpQiWyibQPjZVIc2m0jRjzT+XI9WTTEarkx5zd90dl
	uOEe7DeRCTUDCVzGFk/3PuenFHhkLjcb1uAPteBt4EjIhQdk2OQR
X-Google-Smtp-Source: AGHT+IEUkOzJJVcMjfk4x+jWvKxdu7NuZlOHa+8Wcp4inomZG92ymZG01krR+BS1Rwcc6tOcs6tfPQ==
X-Received: by 2002:a05:6214:212c:b0:6a0:cbeb:c5c0 with SMTP id r12-20020a056214212c00b006a0cbebc5c0mr7962451qvc.55.1714662948958;
        Thu, 02 May 2024 08:15:48 -0700 (PDT)
Received: from localhost (164.146.150.34.bc.googleusercontent.com. [34.150.146.164])
        by smtp.gmail.com with ESMTPSA id r10-20020a0cf60a000000b0069b61f8c0a1sm423348qvm.42.2024.05.02.08.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 08:15:48 -0700 (PDT)
Date: Thu, 02 May 2024 11:15:48 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shailend Chand <shailend@google.com>, 
 netdev@vger.kernel.org
Cc: almasrymina@google.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 hramamurthy@google.com, 
 jeroendb@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 pkaligineedi@google.com, 
 rushilg@google.com, 
 willemb@google.com, 
 ziweixiao@google.com, 
 Shailend Chand <shailend@google.com>
Message-ID: <6633ae24535a9_39851d29434@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240501232549.1327174-1-shailend@google.com>
References: <20240501232549.1327174-1-shailend@google.com>
Subject: Re: [PATCH net-next v2 00/10] gve: Implement queue api
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Shailend Chand wrote:
> Following the discussion on
> https://patchwork.kernel.org/project/linux-media/patch/20240305020153.2787423-2-almasrymina@google.com/,
> the queue api defined by Mina is implemented for gve.
> 
> The first patch is just Mina's introduction of the api. The rest of the
> patches make surgical changes in gve to enable it to work correctly with
> only a subset of queues present (thus far it had assumed that either all
> queues are up or all are down). The final patch has the api
> implementation.
> 
> Changes since v1: clang warning fixes, kdoc warning fix, and addressed
> review comments.
> 
> Mina Almasry (1):
>   queue_api: define queue api
> 
> Shailend Chand (9):
>   gve: Make the GQ RX free queue funcs idempotent
>   gve: Add adminq funcs to add/remove a single Rx queue
>   gve: Make gve_turn(up|down) ignore stopped queues
>   gve: Make gve_turnup work for nonempty queues
>   gve: Avoid rescheduling napi if on wrong cpu
>   gve: Reset Rx ring state in the ring-stop funcs
>   gve: Account for stopped queues when reading NIC stats
>   gve: Alloc and free QPLs with the rings
>   gve: Implement queue api

Reviewed-by: Willem de Bruijn <willemb@google.com>

That QPLS alloc reorg is a great simplification. Nice bonus.

