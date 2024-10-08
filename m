Return-Path: <netdev+bounces-133168-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5965A9952AC
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 16:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE9A1C213D5
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 14:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24931E0DA6;
	Tue,  8 Oct 2024 14:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFdqnmcO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D29F1E0B99;
	Tue,  8 Oct 2024 14:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728399538; cv=none; b=PAZSig1dMQSHSpy2xJ8DGUWkmEe/4kQvqIKe9uO4o039Zu8+5hx3NxFOxunIfMlt5TsxzYDBolH7vh9m8Sf/8y7UNcocO2IzTqbaVWA9TceSSsB2qyWjqcFo9uGb8rmfrJhfVpBObmz1slGJvDnq0kSRQDruGqZleAryzU/BJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728399538; c=relaxed/simple;
	bh=CyKKUKkcrI+LgAe13dPO3Obvi2OrZ3eQc7gWUVSDEHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDZBzCgjTeMjmdjWyzExwckcyk0TVCSXjtlLFu21EhhzVO5A/rIDxweZ2ZZN9BkDUnsMIoRqjD88dd2S1/5VWO28rpx4T3mwdrZ6hbd9nndhIps/vg38CDZ5HOFtkNkyFtLRoGO3KWQSpInPdD13O8aOCyHh9fuyfQ9v7o3GRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFdqnmcO; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7e6d04f74faso4564978a12.1;
        Tue, 08 Oct 2024 07:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728399537; x=1729004337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sna4b8ikajnvFGNs9sBJQ8Lc8sqSFWsEsjg4zLiyr/Q=;
        b=mFdqnmcO2SI9l30XSOABZvg2pRLnajLCCVTt8/t+wAAD3WaGfI1nb0pBTkBiji7Fq/
         O/pnMBixuSYTra1+eCRBFo8aXQ3BlHhz6uNoN0cg8fGRul3C1gO2IPqf6xZSyh92FvnW
         RQWKmKy7oQu+Xl2F9EMA5zyWUQmph/k+FbYkp5JvW2tHKnwaVVK5ZbpuN6i56QSfKDLn
         KMGhI48wdxopRT6qKcmlSk205vgYLr+8fr9d3LFppwDQ3IvAiu0wKf7BQCQbN1eLxOKp
         UmISp8VuU09iEn094NNtn2FIbOCmDsXB2OMtVUATwmvEsXHts5CeVq1J8w7KuPgMC0WB
         F4cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728399537; x=1729004337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sna4b8ikajnvFGNs9sBJQ8Lc8sqSFWsEsjg4zLiyr/Q=;
        b=JoseXOxG6KQyHUVKfa2lNHkdNoRAsTOuJ0txBV/LfTpEKeA3M6GFezKqxdd2VcbjAE
         LLZwz9KnBFZ/lxyudMHSI+tiB+vbGM7j9VVOh0tXkx29Hk9F88G3P5IempOiQHWH/sb4
         VEZHZiPRItm+Zl0YRT+zowfwnkrmKrlsIpvf/sv+v40lZ9vKV3NlIM63QMJvoNDTL9sf
         KlH1mgjcRx4DRuCnCOpsvcdYKRk5Zb477X+N3/aDWmxEnu0cCbBTUCUQiqClcT0GkIZ4
         5r18ZfgP+/Q6HYtGiCIBh1Dkp3vcp27l4M6FVPdfStNm0JiQkRYpwqpu3l6QDYomlDkA
         vrbw==
X-Forwarded-Encrypted: i=1; AJvYcCUoPpjKAiEw0QybjD/I3zIjuf3TU6i7jHsTjW3GSBDP0ebsVMm5dx+0agX8HMEIfKBJ+19b+V+k@vger.kernel.org, AJvYcCV2dkK40qTBIaW293xRLk0gKEOHmiBkpeE6s/kCw5dg5foyWTmF7Ng62bARls8HFuhwUvsQENepI5UMvDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP+W6I99zGTFXQbQAS2EGhI4pcchftuP2D8ZOfJ2oioiVt3DU7
	naPItbbAW2CQoGL4cdPoUQjZw2zEO9FU72NB8ebXYDG2gq0KFesA
X-Google-Smtp-Source: AGHT+IEOwNX2FdEFw9qlhIWwqEhDWsikRVRjPhgp4Mq5gi85AotQqoWgoTac4JNSja0gXQvsU8YEIQ==
X-Received: by 2002:a17:90a:c788:b0:2e0:f035:8027 with SMTP id 98e67ed59e1d1-2e298aeeb14mr691112a91.2.1728399536594;
        Tue, 08 Oct 2024 07:58:56 -0700 (PDT)
Received: from hoboy.vegasvil.org ([198.59.164.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e20aebb7e5sm7884827a91.18.2024.10.08.07.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 07:58:55 -0700 (PDT)
Date: Tue, 8 Oct 2024 07:58:53 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, anna-maria@linutronix.de,
	frederic@kernel.org, tglx@linutronix.de, johnstul@us.ibm.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] posix-clock: Fix missing timespec64 check for PTP
 clock
Message-ID: <ZwVIrW647UNeMZW-@hoboy.vegasvil.org>
References: <20241008091101.713898-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008091101.713898-1-ruanjinjie@huawei.com>

On Tue, Oct 08, 2024 at 05:10:59PM +0800, Jinjie Ruan wrote:
> Check timespec64 in pc_clock_settime() for PTP clock as
> the man manual of clock_settime() said.
> 
> Changes in v5:
> - Use timespec64_valid_strict() instead of timespec64_valid()
>   as Thomas suggested.
> - Add fix tag.
> - Update the commit message.

For the series:

Acked-by: Richard Cochran <richardcochran@gmail.com>

