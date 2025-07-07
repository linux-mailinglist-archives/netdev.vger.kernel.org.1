Return-Path: <netdev+bounces-204734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19853AFBEB5
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 01:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63B694A3470
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84A62877CB;
	Mon,  7 Jul 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="LELM0wLM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4709E4C6E
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751931766; cv=none; b=My1SV6DnyZeru7msxqxj7ZiwEGtnisvl798VPYsHG93HUb7aG1bPrKqaH5QKmhTTDfuXoe347cWM1AvVmVoIqcdErFZq0+IccYsaDe+AEcSNLMevu5OP3gMgKs5H2zt4e4gi9DhsN8r9b3slbv5GsbdiYLJ4yVuGWlf6BGXVO1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751931766; c=relaxed/simple;
	bh=2LzxeHjVrEVFw2cSpHvv1uayGhrPyNsNkk24qmb65vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgsOERFAny2dcNakQDVMgKvunlGp9UpbGCmTkpq8CaD1uuJE+jx83rCOXfqtu7VPFZ/s81cQ7x7yQ7i76q8MtIqJ30Fke003RJUH2nBU3xCIo35HdyH3Np9/yYafZvZaX9gcTU+8k30MBNZLLnMbZF+9dM98iqY4HRUokrlGJEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=LELM0wLM; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-74b27c1481bso2266396b3a.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 16:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1751931764; x=1752536564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W+PBOKbAN+U3A/QBEUehGspmApm9o1wJRKnadsSGt1w=;
        b=LELM0wLMcIiTdrr4R/DAfXtlBgGkM4NLowhSod69WfYEAs97gcj0Zt2F4I+QcbdNEL
         KCDctyWI10yObKPDpuOOINRp/arh455vcrfhmIF/fXaqviwTPXuIFjY2ueUgo0kSfMIk
         wsnzjQOa+5PCNEkk8CZzE+lSVkId0Ei6O8Hoh18wd5JP5RHMYTxl0kpZ6qGl68n9OYRF
         M+hRN9p7AdCBQIc/pPp5FcFB8pBf/ozD+hvJyK938PeNA4RALmoXK/zgKFiUYuBWsheZ
         +i+L7ZJbY4oXMf856DfKcx6H5I9Xe5n68n3cfB3kzaWFoPLygHgsI7xt4c84InXn0FHd
         TA/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751931764; x=1752536564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+PBOKbAN+U3A/QBEUehGspmApm9o1wJRKnadsSGt1w=;
        b=lwLxurWvMCGm6srF4qoNHAPDDQV4Au08IumV5fswG6JLel/rCgl4WtgQ3GoStHgH45
         HtFgv1ArEy6ZmLHXrkQmTDbyg+Bf7OPWY6qtJOTAbQz9r/vAhcsDgWeUWXjBg5atNGbA
         U0ztmbU6EXJ4RTfRxBSIu2N+P05+3QbsvWXyXn6+N8c/CSPTIundj6Z9RXZqRmMy/sxc
         rmshpXsVNefANXwmRlmaXSdq9ZrwxTMeCLQZTTdOkrR/9wmIh/sCivQEdoF+Hfsmdl4g
         ohDrZTXIyoB7LXhQdLDEiMcDKaOr/lBdJHK+pkVqcRXQkNQ3cI6Qo3pTGnAP/8gaIaQx
         WDPg==
X-Forwarded-Encrypted: i=1; AJvYcCUBPZ9VB8jBy/RT/FvXrj6mFQHECKdVrcmoLHvqODfx/KEZ+CZ7naUpEzw4X9U+Z9Hn6uw5nfw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzuhqRfDz83u4+kLG7crXYKNIdRAYkcTwJtXIlJuPzF3mSF2w
	qc6at9NgieEP7UkQXp3Y1Xojzecm4fw229LzuC4GJLqhB8ZIw15409vWLb4u2KMJ0A==
X-Gm-Gg: ASbGncth0+Ka/cQdgun2YCSB1hRayqaGiTkbjNDtjDh2DA/i2joU6DHKKxlqzqR2sfI
	CUkes5rD97tDcWs2PiL+iMvjo3PXFfgYKvvKNjEqJBHOQMu8Mt8stSHbfZHEIAyL5XejlmLRXTE
	PhHIP+n14xMKOQlwLFrtqQLPwWvXxPEkuOdAcxwehRvLu4aQJWeFh1b0jsC99FjjTrkcgALmTH+
	/uekwggmHa6RCINKBBRrvDOpUyOkVBjn+UMDUYQpl3h5bcwVPSGMEPB1Tx2zLyol4pkXZBu8qcn
	u+G5fNGHx735zaFsPJt5Bo4YUNHG8zWau0nhkQEtjVcs2hLb/94Ypb+xOAsjPJqNRLFWq3UZ
X-Google-Smtp-Source: AGHT+IH4nMZnhW9TetYNZ8IV40IvfIt2pOpPWtmrGYR2dK676NFf1/tUyFaM3g+BEYA5kIdZ8dhiSw==
X-Received: by 2002:a05:6a00:1413:b0:748:f1ba:9af8 with SMTP id d2e1a72fcca58-74d267379admr721695b3a.21.1751931764545;
        Mon, 07 Jul 2025 16:42:44 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429b6a3sm9277965b3a.126.2025.07.07.16.42.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 16:42:44 -0700 (PDT)
Date: Mon, 7 Jul 2025 16:42:42 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, jhs@mojatatu.com, jiri@resnulli.us,
	security@kernel.org
Subject: Re: [PATCH v1] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aGxbckKft4_VxmMe@xps>
References: <aGdevOopELhzlJvf@pop-os.localdomain>
 <20250705223958.4079242-1-xmei5@asu.edu>
 <20250707105833.0c6926dc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707105833.0c6926dc@kernel.org>

On Mon, Jul 07, 2025 at 10:58:33AM -0700, Jakub Kicinski wrote:
> On Sat,  5 Jul 2025 15:39:58 -0700 Xiang Mei wrote:
> > A race condition can occur when 'agg' is modified in qfq_change_agg
> > (called during qfq_enqueue) while other threads access it
> > concurrently. For example, qfq_dump_class may trigger a NULL
> > dereference, and qfq_delete_class may cause a use-after-free.
> 
> Please don't post patches in reply to threads.

Thanks for the reminder. I'll remember it.
> Add a link to the thread using the Link: marker instead.
> You're also missing a Fixes tag here.

Also, thanks for the "Fixes" tag suggestion.
I read some documents introducing the Fixes tag, but I find it 
hard to find a Fixes commit since it's a design issue 
(lack of lock implementation on agg).

