Return-Path: <netdev+bounces-85821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07AF889C6EA
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399BA1C21300
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B414C8662A;
	Mon,  8 Apr 2024 14:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="MhcSCgyh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E57126F08
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 14:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586185; cv=none; b=MzAJh6eRHdvkxSjreMANVRCo7eG6W5LnPWXJslbf7jwZDXRINDtKBWYaTAV55fzVhXCi45N+cwLK/H5xTU50czsUH9Tc1tN/ekVOIH7cswH8sHeKY3sHe+QJwC/1G9SMZU6wgL7HXW5LoznGWUkl8Narm+RalV38k1kyCrnuexc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586185; c=relaxed/simple;
	bh=ASwjOtafsNvaK1tlb8jIM/8bIFvFtdW7g4Y89s6XAik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nTl0P4m3T+jML12EtmowA00UE4h/YGLpoKBL8YcsnzsaLK0syG5Vf30m6T+g/OqqvVdzxUbW/xZ1Q7IqR/VLQ5KdEKZ8+lFtOQkkaVfL/AGpvsBJX6KB3pa69ibpu+iiCtMt5rY3fZl4qtI+jP+lOaw1nYgH6EGFKptzFzffQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=MhcSCgyh; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4347bcc2b47so6854971cf.3
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 07:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1712586183; x=1713190983; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SD8rm/bO60JPEGFzrzXXf29p0Zi+gnvFHzCU8iQAQC0=;
        b=MhcSCgyh6644fOR/YrkhDES5cxTFJCiqGASMVMVjRegNGFbuv3CfV4lpM3utI2otvj
         kedg6k3XerXFzYBPBO3BaKDUl/a5Fj0XJrnt87sNZX3zPPSg2IMAvAU2kW+RrqrvzSru
         Kfmjsf3YWoGyXaOZhjrTT6HYGq18RqDBoc442aP9MUj7tL8Ogb32F6aHmJ0aFcdt3Rln
         e9oseoJO40Q/RCrzAwJOVzSIfQqSGplUJgrW7M05DQ+WoJcs4aIF3qDRfAxL5g0MCy6/
         KJPeQldNPquBVSMocJWGF3uodlQfp1zMV5Gie8kzSll65IPUTaj2Np0l+hPyY5pnbRTv
         YSrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712586183; x=1713190983;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SD8rm/bO60JPEGFzrzXXf29p0Zi+gnvFHzCU8iQAQC0=;
        b=CbN98shEeeIIUU552rA4PYmGiAAjB6+WdncS/lvAbHPSg8qNuQJOanRmwvB8S8Moxa
         M7WzlxkREpZz5l+h9qjaVmg4BQl9Ydk6wKArQ2o2lZ/q9RY1ilOLVHah8FGLTaabV9J7
         JYJXANuw3ofJd50GOUL2bOb9e00JNuD9Dq36SsXXJCiZuLb3jGXw29bp0bzOvH5VwaZ/
         +O5JaJE/4tk7qMUy9Mz/3RwG2DhWiQoQL+NQtQ7pZ4b9RU3eVy/rDPcxVdr3WDDDlRuy
         TfcaO3bvnTRmZB7nmDEQsAR99zBnuFA74y2Mtp+INZVF5ZgXNVzV6kQS6DXRmBZ31vdN
         qE+Q==
X-Gm-Message-State: AOJu0YwXwtQKVH7ENKz2EOd8I9XQn3bqrPGk/Zn7/jTBwCTYRWhBKAIN
	mNWNRwU8kX4Beiv5Kjz0aZK/nSUg0v0At46WV331AQqKANZpMvXMHoe/f7Dc/bI=
X-Google-Smtp-Source: AGHT+IHp2J0PauJZ/6whw6FPfSiROjrnQAqEPvgrQbpT4bbiXu+sG4LXPgEiqdSRoEBhQ34wukAUrQ==
X-Received: by 2002:ac8:5a4a:0:b0:434:c5f7:effe with SMTP id o10-20020ac85a4a000000b00434c5f7effemr633188qta.68.1712586182955;
        Mon, 08 Apr 2024 07:23:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id fa11-20020a05622a4ccb00b004343f36ab58sm3742588qtb.81.2024.04.08.07.23.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:23:02 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rtptm-005H8u-2i;
	Mon, 08 Apr 2024 11:23:02 -0300
Date: Mon, 8 Apr 2024 11:23:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, leon@kernel.org,
	Denis Kirjanov <dkirjanov@suse.de>,
	syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 net] Subject: [PATCH] RDMA/core: fix UAF with
 ib_device_get_netdev()
Message-ID: <20240408142302.GC223006@ziepe.ca>
References: <20240328133542.28572-1-dkirjanov@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328133542.28572-1-dkirjanov@suse.de>

On Thu, Mar 28, 2024 at 09:35:42AM -0400, Denis Kirjanov wrote:
> A call to ib_device_get_netdev may lead to a race condition
> while accessing a netdevice instance since we don't hold
> the rtnl lock while checking
> the registration state:
> 	if (res && res->reg_state != NETREG_REGISTERED) {
> 
> v2: unlock rtnl on error path
> v3: update remaining callers of ib_device_get_netdev
> 
> Reported-by: syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com
> Fixes: d41861942fc55 ("IB/core: Add generic function to extract IB speed from netdev")
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> ---
>  drivers/infiniband/core/cache.c  |  2 ++
>  drivers/infiniband/core/device.c | 15 ++++++++++++---
>  drivers/infiniband/core/nldev.c  |  2 ++
>  drivers/infiniband/core/verbs.c  |  6 ++++--
>  4 files changed, 20 insertions(+), 5 deletions(-)

This is a rdma patch you need to cc linux-rdma and ensure it reaches
the rdma patchworks or it will not be applied..

Thanks,
Jason

