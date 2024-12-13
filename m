Return-Path: <netdev+bounces-151899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7838A9F1826
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 22:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 637C2165DD8
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BFE196446;
	Fri, 13 Dec 2024 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="aPKgSu/7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574BE194C7D
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 21:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734126736; cv=none; b=bSMLvvAI6ipm+9L9OWHlgwYX14B4l+OKXTgr7FUX1ZSNxLma0lK5HBpud+L6yEIRnYpImW2g1WwU3KIzsr3ue8P+bHyX+FQ5Zua0N5qQDXzf6tuwF6Lq/A96jQtssSWXQaZ2vvooKNq+9zorFna/NiEoWUWYxy0O8NgBUuEen/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734126736; c=relaxed/simple;
	bh=sdPWg6UMMWRlFERRT1a4togFVACj1wpKDF7YtLOCw0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMJTYR08uy/VsjC5oJQVDUWd/vDV9lYootBv2oQkDtWHnrr88xIPuZCcULogliSgvli6YuthW8Bbbo90JZfv8rH7h2yQRQ0wjepmPrwq1DsFCjqVlcLF1ZHAVE18+oS2mRTySmHaVghYRSGELq3mBMOS1aQPPOcYfihW347zNWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=aPKgSu/7; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2161eb95317so21319475ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1734126734; x=1734731534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o3yQ+Geoyy37/CgwBJIKvgzXSArVOH8eMq6ft9chLNo=;
        b=aPKgSu/7somZLCrMUetuNP6tLYD7EV6OR4oZ/FcLF2dHnhPBeJBon9Xgdcac0A+LGP
         AC3uCI4bhYINdGiAAy4c28X640fxROxNlvL5DZaAX69+kArGoKqNO5hsJ3GdyoMVUzGf
         LSvT0+/yLUOTy5rGe5WYzyKe/33ySz398o6rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734126734; x=1734731534;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3yQ+Geoyy37/CgwBJIKvgzXSArVOH8eMq6ft9chLNo=;
        b=t+7lqWH9WHMxnJMRH2Su9vff9AnxOd7nQK0Qb3EK60XZ7H7KdT0mwRH1wXuBWdqulP
         1KCkWi1wjpcdCM1Srgx4/8usWaSbyfZ51xuIRbfzwN0OSk/bf7jAlKervcd6iYTXTVFJ
         bOEgdXx1WAvv/+7BgYCDhEnddRe3/nt8jk6eg5/Q7sJm2KTz5rQ15omv0z8ErvMNAFGU
         BxppvKv/rER+JrDdqUnIawriZqZU2SWH2+NCMyfeivc/matTK+/8FNe8vhHeGHt68UOi
         E1hMWcx6G9YtX1TCnp8E5dTayxWTjdccESkqYSgHeXLVopre0whxsp3dDwGOMPAVaQRJ
         gu9w==
X-Forwarded-Encrypted: i=1; AJvYcCVg5vMea2pgJK3oDZCImq5rRMH/mfFTCvgSrUDd7zYTzeSgnTIHrBD+yhk7DBLgT3SURsHLH38=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc5QrWfXMPOEqmoE+ECmahSiVDB0XZTzVljHhb1hnqhIpMJQpT
	nXpOpX865lhWmnZBwMDOtktffQB+AtwEKlo9P2Nz6Gq1Sfo2BCSynQ89k3BBSMw=
X-Gm-Gg: ASbGncvPShA9nhBd8cKm7wWe+BUgp3ntvNoAiCX8vmEzs8XqXR5kNYOoSG4VwO2sBTp
	r+4KtzrZXEOuqLqf2xvCf3oEvHax+Mx0EyvUJbfo7xK9TulZlMLa1rq2DN3JDygb/4a0k/1fGqh
	yTTrF5t92WhEqDGvGM/l72BfR0etWQhMOtvMCF0H1DWjF9cq+PeZUYJfC1Oezub3+9oA+eVDFCe
	T6FuDR5/pB5oyBVnwxhevlrm4F+/j5Fc2ePRWXnrqsgAjBcZwOd5mnoHrEyTc19WXNTZXfU78Pn
	+QbILIsy3y5ZH2kvXXXHostLqwF0
X-Google-Smtp-Source: AGHT+IFkC6MJXlC9+7p4z+9Nm60Lzpb8Gsf0z9+xTJuPGFTINtVStlIRhHQsvsSYLwMByV8Pus6GYA==
X-Received: by 2002:a17:903:946:b0:215:a179:14d2 with SMTP id d9443c01a7336-21892a5c0ecmr58766495ad.50.1734126734665;
        Fri, 13 Dec 2024 13:52:14 -0800 (PST)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1e6d87asm2147205ad.264.2024.12.13.13.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 13:52:14 -0800 (PST)
Date: Fri, 13 Dec 2024 13:52:11 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH net 0/5] netdev: fix repeated netlink messages in queue
 dumps
Message-ID: <Z1ysi1RHOr3S-40F@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com
References: <20241213152244.3080955-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213152244.3080955-1-kuba@kernel.org>

On Fri, Dec 13, 2024 at 07:22:39AM -0800, Jakub Kicinski wrote:
> Fix dump continuation for queues and queue stats in the netdev family.
> Because we used post-increment when saving id of dumped queue next
> skb would re-dump the already dumped queue.
> 
> Jakub Kicinski (5):
>   netdev: fix repeated netlink messages in queue dump
>   netdev: fix repeated netlink messages in queue stats
>   selftests: net: support setting recv_size in YNL
>   selftests: net-drv: queues: sanity check netlink dumps
>   selftests: net-drv: stats: sanity check netlink dumps

Thanks for the work and improvements.

Patch 1 and 2 definitely seem to be "fixes" and are against net
which seems appropriate to me.

Patches 3, 4, and 5 seem like new features, though. Should those
three be a separate series against net-next, instead?

In the event that you do decide to separate out 3, 4, and 5 you can
feel free to carry along my Reviewed-bys.

