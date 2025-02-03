Return-Path: <netdev+bounces-162252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE22A26580
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC05B3A3B81
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411121FF1B1;
	Mon,  3 Feb 2025 21:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="WqEain57"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D6635944
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738617721; cv=none; b=GriARIT8YWHXXT5FpkwIyQXkmw5QIZfSBzfdL/e2BmzaOA+6ZJFyhNWcI2duN4cvMcPVLv7Npfu2HM8a+S+Xm8dUzqAURCDAFBglkWGMOtWgoq21HKeELRE2U+JbZPD91w6WJM7EWwvlqOB70bKownbkYcqnDzcDaXysBJk0wQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738617721; c=relaxed/simple;
	bh=DnsflcmSO3ootfm1yS7UCTof7yhCVM5v3OUopYs5Uh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUx4FU4hpFfX2brSsxFz4UT6B8DjBQzaTrI8KmSzZMMHA8DxIZkrVB0NODASTuWeR4Lnxqsxv8j/ae85rIh4Hjjq+df6JbS28qZyfYJywaTpgjEUo2RL0/dLn6sF/JJVnCFJxLEuqMIEVAuA7sAcpDi8OXgH/rTmuv5mSURb9Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=WqEain57; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so6233141a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 13:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1738617719; x=1739222519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o4qq6PryDBTErpgLozNASAxHKlnenx4UB2jrTHICqUw=;
        b=WqEain57DpjvMuo/PxNguv9W3fHl94JxOzIhoc85MvLfMtADrasO8ybfYfOu7THGb9
         e1I9qMuBCMsUagslj0jVSyz3fOnrYs/me0RwgQhd40t0Ch0NTtw+a50VPw+RCrp7KLAa
         j+OYEpdKnNyxb6DCt631vVHBbSiZpTUY+cf08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738617719; x=1739222519;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o4qq6PryDBTErpgLozNASAxHKlnenx4UB2jrTHICqUw=;
        b=F8oOEbGWoL7ru0eBFXRI8OMPAkCb0n14aWcfeTHh9ZQT4bvS/CzJEQ2KSVF+priRqB
         NybsroAPA6wgLmh8V+fsn5HN0agPkNWlj/xY2y8ySPNB21TSuPj55IrxE/oTAQe8i5rw
         xEBImxYwQ7nob+BIIjUb1AWxdWyWdd3T95pxOkMG3qU5oHW2Z1HsmkrfOg17Xm/eKXm2
         ExKD9kKuRujJvSnErKagIFaJNW95nqzuV36y07OPunTeYc9++wWr3g83c4EdVr+gfzT7
         XTuJ5YRm6CnACMZ0w6Gb9IvSsUkfuDub+Tqc/vhOw1NTxL/45DKXzYmL9T5VmDxbjNqS
         aYow==
X-Forwarded-Encrypted: i=1; AJvYcCX/CR6OPZQrpEZYryG1wrscQs3BrB/K282VNaC0A8VEBqKdYQYIppxtGV7HeMs30lQEQm3ZSHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0w1C+DTh3qFv9WNezbBYs91+40ZLAgSW5FGTfbB+NJ06WG+h
	BW5Zc9JY9PFgLaAtdI5TOdD+yDMN5mwxug/anQIX+7JE5lnvB1Ct8BjiPY9EPnI=
X-Gm-Gg: ASbGncuPOhC6k6Cw5/koaPCCxZThek0tNWrGJ6vS0sZJqGem4kQe9WfMZdbNhtmmykP
	oQhhfn8G75cCA6V0b3WZFJ5mXYipIR0o+Gb8lLbD/XJnkAb7FlvIFfdlokz3J2w2up1IDIMagtu
	SqIZyeuGxqc+XEtWHyjbfllzvyLe9JTh8cz4PRp52Sy3NTx8jdM2P3W5Ytz2ZHiItdcSKir9woC
	BZor06nXbDRcPhOPpCDJrhKj45Svdy2aqiXIhqY5EcP/VTWPRC/XeJefQ2fFOqUYKolR2h/+aNo
	ghwLPGT39gT/yAaVTgIerkmjCGBa06WOvqKoJwUP96TcYaGMCxnCo9/iAA==
X-Google-Smtp-Source: AGHT+IHYN+JlQh/u3UKUfgpcAwgULwhMWS9v8S5MiAL4CZ13qCVpwxHONKdZsgGRb5H+7IjO+YOvRQ==
X-Received: by 2002:a17:90b:2c84:b0:2ee:cb5c:6c with SMTP id 98e67ed59e1d1-2f83ac70de7mr29208522a91.22.1738617719065;
        Mon, 03 Feb 2025 13:21:59 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f848a9f25bsm9504974a91.37.2025.02.03.13.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 13:21:58 -0800 (PST)
Date: Mon, 3 Feb 2025 13:21:55 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shuah@kernel.org, ecree.xilinx@gmail.com, gal@nvidia.com,
	przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net 4/4] selftests: drv-net: rss_ctx: don't fail
 reconfigure test if queue offset not supported
Message-ID: <Z6Ezc0wgqZuTkS57@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, horms@kernel.org, shuah@kernel.org,
	ecree.xilinx@gmail.com, gal@nvidia.com,
	przemyslaw.kitszel@intel.com
References: <20250201013040.725123-1-kuba@kernel.org>
 <20250201013040.725123-5-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201013040.725123-5-kuba@kernel.org>

On Fri, Jan 31, 2025 at 05:30:40PM -0800, Jakub Kicinski wrote:
> Vast majority of drivers does not support queue offset.
> Simply return if the rss context + queue ntuple fails.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  tools/testing/selftests/drivers/net/hw/rss_ctx.py | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Joe Damato <jdamato@fastly.com>

