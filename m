Return-Path: <netdev+bounces-73223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EFA085B711
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 160F71F2592B
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 09:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF17D5FDA2;
	Tue, 20 Feb 2024 09:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="DnUiVksN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E04A5F544
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 09:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420654; cv=none; b=pylz+s0+eewArTbjtYSHF574cx30XD3XP6odwTOzwi0MLNb8pP5qaVuiJ7GK7FykJAIJXdvMFVMerEcfw7PVKMGzOYM06p0qlT+mB/wO7u8T2LLgxCZpAQaUegiWAx0vTAGMLUBGNBzKsev15pPELJgqUvMV0p95KdrNYwPtzMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420654; c=relaxed/simple;
	bh=tXungaie3TXwgVSHCSGPug0zbCqPlrnmHA/eiaWkOC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyUIwnnXDXcpXSN0Sv0/OCsZ0IA/qzhsRhERUdUSuEj12x7PFWKmETRrHLV4p0kVXS3g8kUY4hEvWA0Ns2cFNjVo+rLXn3tummMv+cHvGzo1YskAZC/e96m1296XyTtOPAKRfKmZbp5ZHrrUiHGAQkgvylAzxwbuVhV1UWRVObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=DnUiVksN; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-512b3b04995so2018009e87.3
        for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 01:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1708420650; x=1709025450; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tXungaie3TXwgVSHCSGPug0zbCqPlrnmHA/eiaWkOC8=;
        b=DnUiVksNRHZiR1acKq9iZwYyh0uV1NdYudNuiZFLDfq3eqaAb7L5aedYF7lKKvajhu
         Y6IUwPzDzwblGJ1NebCBQsuDILcMX6AVUv+EfhsWr8z92TtCVTp4KhIgG6HY9nEOIubs
         D7msf2dauBDKpsB6L0FudCVF3fOTmc2MF7Jl0Wp/nAGOUsxhXymJmhORgkIztTGDiUpb
         Tco8v9OcrXoHpG9tDhPEN8/obqG3ACVh2As+ZGcO8ljMAST4O/QjWVPWk/mSdSgYJWzW
         qs/OKWe0x/W/w27nAeGOg5REO+P6CMxRhaPnITWn7eTjb09JmHeGeTdIxZSEKa1/aVva
         FvHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708420650; x=1709025450;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXungaie3TXwgVSHCSGPug0zbCqPlrnmHA/eiaWkOC8=;
        b=lu+OGr2EK1RCAFTdDMXLii5RjLJVdwBjrMUAJfloz+Yu7rEUROMUXw+epcfWsZ/nTV
         IEpG2JKMU29EXePXzceOdMVG33Mxs76e4To8P08c97egUoo8ziCshBcHppeg+Ruk/bxr
         mwOFnXFDfmp3hHFD4ZLGJg72eQ9xIc5oa7aE5wzd0usV2LAnttsyUUYC5bEBU/hHBvPq
         zN1R7vaRN+qxHPxb2mYBcCmWIod4eMWG/23F+fZytVzmSWtyJ+SJmjJKAPiI61uTqxlV
         3WCyGqxplbxvqdMdITnTQT6eZcSCPWXc8Rct0Nc7imVpz6khDxBX4O0s3pGDRcsdkZtW
         iw4A==
X-Gm-Message-State: AOJu0YxH1u5eySy/Qdgvco2Iy59kU8CZx5mEBogIwCf1di/k7MU8J7JC
	S5TVii+OHRs2hLgvHJ5eviKADwqhUOFUa9SAK/19FdFdizmTTb7O3Jwh1KnZgfk=
X-Google-Smtp-Source: AGHT+IHFCOrLuyM5jpMhnW4G9Xs4NDf72qDAXJMIIP9nBG0Kp7MR7x7SusJF4DeXcJdlLu0WstH0+Q==
X-Received: by 2002:a05:6512:1192:b0:512:8aeb:aaa8 with SMTP id g18-20020a056512119200b005128aebaaa8mr10964708lfr.49.1708420649948;
        Tue, 20 Feb 2024 01:17:29 -0800 (PST)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id k35-20020a05600c1ca300b00410cfc34260sm14456006wms.2.2024.02.20.01.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 01:17:29 -0800 (PST)
Date: Tue, 20 Feb 2024 10:17:26 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net,
	Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Paul Blakey <paulb@nvidia.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Subject: Re: [PATCH net] net/sched: flower: Add lock protection when remove
 filter handle
Message-ID: <ZdRuJuUKALW1Xe9Q@nanopsycho>
References: <20240220085928.9161-1-jianbol@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240220085928.9161-1-jianbol@nvidia.com>

Tue, Feb 20, 2024 at 09:59:28AM CET, jianbol@nvidia.com wrote:
>As IDR can't protect itself from the concurrent modification, place
>idr_remove() under the protection of tp->lock.
>
>Fixes: 08a0063df3ae ("net/sched: flower: Move filter handle initialization earlier")
>Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
>Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
>Reviewed-by: Gal Pressman <gal@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

