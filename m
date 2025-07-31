Return-Path: <netdev+bounces-211197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F03B1720F
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 15:29:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F36585A61
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 13:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCB41A3155;
	Thu, 31 Jul 2025 13:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="vG5NnCaj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1233E2BE633
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753968570; cv=none; b=FWqrir3SDhDVVVMTXr/RyAu5LjqvBmo47JRBQKiegezpbFDLpvUUuiLbytPOoAeNRlQT2ETHAmuhCHpeyfbTC37pFbmrC9j6hWo5MIGuOlMSCRhb9ECFarSXPaZtU+rpB7kVpPaFzGY+iXWHGnR1+gs+4eHZWYVIZgjRzqqp1g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753968570; c=relaxed/simple;
	bh=YMdW5rU3CIdWkyC3VWbAPmxgS1qn+LWC6rbqbVYQa6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eHXojTK4U7yVUkMdiVYsaz/c60Lt2RzBoWVlllZueAnyGOURk581GNseKzoFy1DdTt+3elri+Xy9GIhUs0YTYFsx3tIF+3Iva2K+iU22g0yPyJOT7Hs5ZyCrNLVdy6lVJx9puMPp4mto0EkycX2Og5vXOTl/9hpJgM9C2jYHG1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=vG5NnCaj; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-3e3f6ae4d08so3679595ab.1
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 06:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753968567; x=1754573367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kf6j1R5D/tbgbGEyMH2jXV6V2+9rCIaZQZaqfQWq+aU=;
        b=vG5NnCajnXD95+FqjH2bfNs5PcC3hVbjFdB9eDkTe8k1VyBFdE58YtHyi0sIdqCuBZ
         9Eh6DgSAYQPCx4myk0h00LG3Md79Z2v3K0Kq6U9naz7x5Rf+BotDUzCgO+d+Hd79SezL
         n+YwzW+Km8yC5Sw6JwuC0dqz8CHjRSdv85645E3V08I7Xy/v7Nu01qS9EgK4lPLFHZFB
         q59p/wHkNTC/6TW5zarQab0ryGN+hkPHxHOg9ZGcodBhakzXvDO0Fk+mQsVMrYmVchXZ
         B+39i+dmRl0YtyzxPwH3axo4eDWelvB+Cb1JZryz/kRvvwwG6ZAtustbunJ2VQZ/Gcs9
         o8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753968567; x=1754573367;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kf6j1R5D/tbgbGEyMH2jXV6V2+9rCIaZQZaqfQWq+aU=;
        b=jLCauQXEL4VqsjpeUMXYb7ORnlIIThuyxBOrh7k9EuarY7jmffVxcFMPn2dwBX3WDW
         5S6G016Zuoxx+09gwRFcqTq6mbRmr+DNWfaYE3NwMeJeN0r/O1XrC+DtVciCM0Vw15Gc
         qmItNmiwGdZjltZ87El9TXbDSJhpQMrC2BLWXh3ICf1q5EYdYHI0KvlS3yFseFrlgukr
         xbi3NQKCKvAZ5vgoZ4ofRQf0hBv1FifxgTgHFHdzWRiqfUCBn8CXMsm4PHLzPjZ6OIDF
         fQe/7QoGyCtIJAXXLwnpkydKTOhSSn86hC42pTcK/ufIcpy69OqcCeqeuFWgRVGMvV4b
         9ebw==
X-Forwarded-Encrypted: i=1; AJvYcCXaxZ6ddmiQuRD48SeAF7UMaoPA8etODA7A05BI/RVyCZQnK9V3i5xh6ZA2dkCTaPEmsUiExBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJCMyqQtRatLAtav0n3Hu0rIlFYaITFommfvmj8XAstxuoI0N3
	FKWT7wHejzyCBvAGQWqYSYY448SeZU0qdgC/YtvAk7PB/AeVz76Mle3/h6cUMmEXUP/k6XMp5pj
	cDO+j
X-Gm-Gg: ASbGnct6evy1uoMZiUEtPIL9TaYwOrKsSjgluXioB7eshjB3oBWTELS36qmyb67NRZS
	TkYHd5RG8XyC9w1LD21fZxhvk+7yI6hqXf0qWSn1urMX8h84FUaxlcqq/YoVofnNUz//hGZ56q3
	0TK3AdEJN7tgt8l3KBjLppH/jOtoLu+JJGzuQjXav++4FuBecxU4WaB4aDaTj7ALJc68UcPaFXq
	KvMVKdZ03u+Oc0rf3M+JgL15d29HGa/gLt8h1TcbxgAsFZBQSNlItVuGOvpr+cbiFD2mEUYU5g1
	9nd+Lec5ZIfrM2oEK90R2Iq5hNnoc8Y0s7c2Gt/qK5j8w44E7Ma80/woXVmSWsmVq17sWec02c9
	/lV3aHMn0VckfEFwPrZE=
X-Google-Smtp-Source: AGHT+IEerQhtiILzuNpwnLDq8PgdsqS0ljYeqYQb8rsPPKxK0XUHuixbp9UkIkFkN048y/HBRX82Zw==
X-Received: by 2002:a92:d784:0:b0:3dd:a0fc:1990 with SMTP id e9e14a558f8ab-3e40580a081mr29145025ab.3.1753968566714;
        Thu, 31 Jul 2025 06:29:26 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55b1ac2esm504759173.1.2025.07.31.06.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Jul 2025 06:29:26 -0700 (PDT)
Message-ID: <d7ddaf65-00a0-4b90-b596-5db1a5169950@kernel.dk>
Date: Thu, 31 Jul 2025 07:29:25 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v30 03/20] iov_iter: skip copy if src == dst for direct
 data placement
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
 ogerlitz@nvidia.com, yorayz@nvidia.com, borisp@nvidia.com,
 galshalom@nvidia.com, mgurtovoy@nvidia.com, tariqt@nvidia.com,
 gus@collabora.com, viro@zeniv.linux.org.uk, akpm@linux-foundation.org
References: <20250715132750.9619-1-aaptel@nvidia.com>
 <20250715132750.9619-4-aaptel@nvidia.com>
 <59fd61cc-4755-4619-bdb2-6b2091abf002@kernel.dk> <253zfcs2qaw.fsf@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <253zfcs2qaw.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/25/25 10:22 AM, Aurelien Aptel wrote:
> Jens Axboe <axboe@kernel.dk> writes:
>> This seems like entirely the wrong place to apply this logic...
> 
> I understand it might look strange on first sight to have the check
> implemented in this low level iterator copy function.
> 
> But it is actually where it makes the most sense.

Please stop rationalizing what is a blatant layering violation.

> Let's assume we move it to the caller, nvme-tcp. We now need read our
> packets from the socket but somehow when we reach the offloaded payload,
> skip ahead. There is no function for that in the socket API. We can walk
> the SKB fragments but a single SKB can contain a combination of
> offloaded and non-offloaded chunks. You now need to re-implement
> skb_copy_datagram() to know what to copy to and where at the socket
> layer. Even if you reuse the callback API you have to take care of the
> destination bvec iterator. You end up duplicating that iterator
> map/step/advance logic.
> 
> Our design is transparent to applications. The application does not need
> to handle the skipping logic, and the skipping is done in a generic way
> in the underlying copy function. It also will work for other protocol
> with no extra code. All the work will happen in the driver, which needs
> to construct SKBs using the application buffers.  Making drivers
> communicate information to the upper layer is already a common
> practice. The SKBs are already assembled by drivers today according to
> how the data is received from the network.
> 
> We have covered some of the design decisions in previous discussion,
> more recently on v25. I suggest you can take a look [1].
> 
> Regarding performances, we were not able to see any measurable
> differences between fio runs with the CONFIG disabled and enabled.

I'm not at all worried about performance, I'm worried about littering
completely generic helper code with random driver checks. And you
clearly WERE worried about performance, since otherwise why would you
even add a IS_ENABLED(CONFIG_ULP_DDP) in the first place if not?

-- 
Jens Axboe

