Return-Path: <netdev+bounces-232816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 481BCC090CF
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 15:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7917018971B0
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CF92DEA86;
	Sat, 25 Oct 2025 13:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Q7YymhDY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD13242D70
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 13:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761398862; cv=none; b=b6NzNF21tGf7J5iLS1drWbFfEZ8kTtGs5Psx4kvPMpsxByIH71wmJ2RD2CftVkzb7oVA2TLzAk8Oj9AKN2lGrAMjxI4esej4L7gzqnjSRPrita5PTDEQUpeL1VMsrVT9W2mSmQubT0d/MdYiXi57J94vIlYMNizqKfrKuK5fRdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761398862; c=relaxed/simple;
	bh=i3aR6XG7SCZKLYqvuLJClAEOhq3SLQqddyDbw2SSnPE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OOpVMB/2Z8Cm5n/cC0S2OgRlDEgJhevQTvi2eZJPX5/jdtAfmYQpIKyHm0UoUCI3Vwc2dvZ115EgfppXd+fVQduCT7xAlM9j7E4k7ANRSz7gbiaNGh25HCw4ya0VM8w/XkaKUQfaTjvliSHVQj2oX7eOm5WEqmNLt8Dk3ECwZfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Q7YymhDY; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-938bf212b72so125376139f.1
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 06:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761398859; x=1762003659; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HXr/4gmeQBCobcp1e59rIPiZ2OM+tq/HT4CMRTfBtng=;
        b=Q7YymhDYF4uDwtwyMkr960KOs3U3famiaMCG/Q+j5pBGj2inciD2CdHtH/W5KrzQx4
         LiUoTDOs7/cb3bfAY0/EsR5NDAKpYS1Xg8CEXFUswimYvOnCAbxuKGWC+lv3uTMl7gS9
         6Vhr8AVLma8GYKuDT/zHFKSd+VbxPJ/WowNnQRko77+UMQ3H7hgOhWQTr6RObfYCh2d1
         7z1USsQm9IIM0nFozTqpvEhEUUGlvJnGqPB7A0yAAHnKbURx22LOuTUUOQtLwABIZHli
         fiPAO0DNyiw9GEytnbnl9FeocU2YQtydU8DBRogTHYjJdpvoYGpEVaUSnMQuOsLQ1CG9
         sF4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761398859; x=1762003659;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HXr/4gmeQBCobcp1e59rIPiZ2OM+tq/HT4CMRTfBtng=;
        b=NJLh+ixKBCAda6Hd18GNs/102XETZgGmlNbforC7fk3wMTOSFSjxYl/GOPhzydwSCH
         cJ4AlZFS/SSF3cQPKNbuBoSkLWNLxt1kUhq0mKuvp4S30xGoM9s+wFWRvC4zVQGIG1eY
         HAkdfIq6TAZjbOJdOzTP3Mvf+ocdzJdv6wDopg2ZAiq0C+S8vaHCKKeKA0BY9Nw1gzeH
         XCLyGdglWtmZlnLQdkTeg8R71PU6tEYRDGYpdunCkuwX0G6KB7BuJFaSryFtkBNuOuMT
         Vmxzn4nXrdloJaurImBlARmhRTUC7xmnudDTj4a0wr2xmJHc1ldRb0RmvE7ZvynWDWC5
         aCtQ==
X-Gm-Message-State: AOJu0Yz+kvUKj5i5td8p9/QUuLI3vTCkXEm7IRvweP3mKnTTcda06C0N
	hE4PsQqk+fupZtGUG1lXigO7sONG1n72TxMhCMhcV0Tws60cFUk9hXLFnolHUuEcj2UI1xRqPUY
	c0HKPD5M=
X-Gm-Gg: ASbGncvTilVsoMto0a6+mNK37UDY1/kz09xF9csEbLp4fq3aVe9A1yX+dNNohHgaZoV
	+qMylX8iK2jHaV8Yq9wgJkLuWmdQiEhf8ITPm3XzknwVapRe1fLFdbb7cjtasYtTV2uof03mWwx
	1XKbqoPOnd6OSgvs/dxnMh3NBGDKD3BEGFcnZn6JEiHGhm182GrywOdOwLFXF/wuD8dXaB++vfi
	PEGmhh2/PleiOtJnQife0OHYlc+5fOgoeHuI48NbeRcep5mV1d4DaZojhYbmYztYSz+T+OUlfCB
	6piQVqbhF+y/hU7vs2ctakNat0eE1G1pD/6NMGPep5gT3UT5G2+V3v0yfobvGrm4wKZkabsCKMp
	hgUY3eqrjyOa1Gw5M4NXTsywJBHvjnSaUYg1AK/uteWc9NYGceZxVQZAtOyN8WbQl1bALoEoqK6
	kotcyGhyr4
X-Google-Smtp-Source: AGHT+IG4Y2HZ0MyC30nUKDZ+xtNAM0kFpk2+Pw7r1CzWuz5LJp3/Q4U/QRnl0mYnHV6GLCYfZXOvaw==
X-Received: by 2002:a05:6602:6015:b0:93f:c5a3:2ad7 with SMTP id ca18e2360f4ac-93fc5a32d96mr3801899039f.6.1761398859503;
        Sat, 25 Oct 2025 06:27:39 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-94359f324b3sm69240539f.21.2025.10.25.06.27.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 06:27:38 -0700 (PDT)
Message-ID: <c344d845-99ba-4c3c-9382-cf401712a689@kernel.dk>
Date: Sat, 25 Oct 2025 07:27:37 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Introduce getsockname io_uring_cmd
To: Gabriel Krisman Bertazi <krisman@suse.de>
Cc: netdev@vger.kernel.org, io-uring@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>
References: <20251024154901.797262-1-krisman@suse.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251024154901.797262-1-krisman@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/25 9:48 AM, Gabriel Krisman Bertazi wrote:
> 
> This feature has been requested a few times in the liburing repository
> and Discord channels, such as in [1,2].  If anything, it also helps
> solve a long standing issue in the bind-listen test that results in
> occasional test failures.
> 
> The patchset is divided in three parts: Patch 1 merges the getpeername
> and getsockname implementation in the network layer, making further
> patches easier; Patch 2 splits out a helper used by io_uring, like done
> for other network commands; Finally, patch 3 plumbs the new command in
> io_uring.
> 
> The syscall path was tested by booting a Linux distro, which does all
> sorts of getsockname/getpeername syscalls.  The io_uring side was tested
> with a couple of new liburing subtests available at:
> 
>    https://github.com/krisman/liburing.git -b socket
> 
> Based on top of Jens' for-next.
> 
> [1] https://github.com/axboe/liburing/issues/1356
> [2] https://discord.com/channels/1241076672589991966/1241076672589991970/1429975797912830074

Looks good to me, and it's not often you can add a new feature and
have:

>  5 files changed, 52 insertions(+), 52 deletions(-)

a net zero diffstat! Nice.

-- 
Jens Axboe


