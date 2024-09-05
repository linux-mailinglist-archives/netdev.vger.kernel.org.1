Return-Path: <netdev+bounces-125465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DE996D2B4
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 11:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF59B23F41
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CBE1946A9;
	Thu,  5 Sep 2024 09:03:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDF6194A48;
	Thu,  5 Sep 2024 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725527011; cv=none; b=ddaalKyz1nZWiFz/dDJgwSVTzmCj6LJzS2MCVeFH7Y21eH2LZa0Cwi3ktjVj4LETp4cEBA5qILRNvjmrNHUm1ZutJL5JlkqM/3DuWgvTLXuut4N02B9yl03T7R8eZfwBqXvsXwpyHQKFvqGfmUGj7/5slsO71l3/9/KhE3Upwpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725527011; c=relaxed/simple;
	bh=h5agUITKl/cgeeW4DQgsZL5oeRnclrtv/Skmb+M64no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odi6kdbVRM5/S6L6DUwSH0LO5aWO34a1g7GEIkGf9y3clhj6T2p5wubxIvOoGAwm9P4H5iIACPcKjxUTqi7dNW4WvSFHrpQUyjA9knZoa64Jtq67/jgIB9+2UDRNCMnefxPS2TJJzctqiEY2EI7N8WgZPUb4OK4qn8XrW1DZmO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c25f01879fso671593a12.1;
        Thu, 05 Sep 2024 02:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725527008; x=1726131808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aILp+FUNY89ZcVUn5gP5CXyAWZIDPOfD7aHJXZkQOc=;
        b=iJTxhDXDsJbuTvkiWIsUJCdX258xO3YWAYjATT46+ErQqVTN23xng2sE6atRvsOemP
         CI89gWqljqNT2StnheMiHv/PCj73e0kAkRdowx/3fNB9KhZ3Fq6SP12YUxl6VHQyLTk0
         ajL/XeBi/kAStiOZb8ofWOIwhqtg0wKRBtgX3qLDlPdJtMsjUX2t7xanLZGvZvdreZP5
         n+xlnHdTM6yfRMJ45JULXBCf3lg0nRyC6XYSxtddVFU6zVNlSvxtGZWxxrBOVMZ688wK
         fEzP1+IKFu6vdoW1ZUXS3Il4T2ZJqLt7OSj8mBMQign5o3nmuh1vPf9SwG0jNqccQoEC
         CUOA==
X-Forwarded-Encrypted: i=1; AJvYcCVH4Ns3ldqPP948rsxHURyDieHgDPmr24Ia0CUM0Ub8Y0QHJORmFzV0yfCMOXqNS9JlyfEjTlIWZvzcDB0=@vger.kernel.org, AJvYcCXniA+eDL5MyZL4zohBqA4QclcLhDmrhedMNksZjNQeyezH7jwAZ/X3LweSKNEwc0iCFBeob8xD@vger.kernel.org
X-Gm-Message-State: AOJu0YyQnD7rk5gCFvyuk5L5issjtcVwuTNbAYK+Vy5tHTzWSASKIx28
	8II1x+HRvckCwYF2ZV0vsXhZXvc2Tg1kE/RisyEIUkN97kp9Z3nK
X-Google-Smtp-Source: AGHT+IEtWO6srusMymzDIGFokmJ8brm6cWt1HRzsrksU5NF9IzLD4bD5OMrwEbqRdmyo0ze0Ti7teQ==
X-Received: by 2002:a05:6402:26d1:b0:5c2:5f0a:4a45 with SMTP id 4fb4d7f45d1cf-5c25f0a4c3emr7211261a12.31.1725527007435;
        Thu, 05 Sep 2024 02:03:27 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-010.fbsv.net. [2a03:2880:30ff:a::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3cc529241sm960676a12.11.2024.09.05.02.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 02:03:26 -0700 (PDT)
Date: Thu, 5 Sep 2024 02:03:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Leonardo Bras <leobras@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	rbc@meta.com, horms@kernel.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Message-ID: <20240905-sassy-aboriginal-crocodile-cfadde@devvm32600>
References: <20240712115325.54175-1-leitao@debian.org>
 <20240714033803-mutt-send-email-mst@kernel.org>
 <ZpUHEszCj16rNoGy@gmail.com>
 <Ztc5QllkqaKZsaoN@LeoBras>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ztc5QllkqaKZsaoN@LeoBras>

Hello Leonardo, good to see you here,

On Tue, Sep 03, 2024 at 01:28:50PM -0300, Leonardo Bras wrote:
> Please help me check if the following is correct:
> ###
> Any tree which includes df133f3f9625 ("virtio_net: bulk free tx skbs") 
> should also include your patch, since it fixes stuff in there.
> 
> The fact that the warning was only made visible in 
> bdacf3e34945 ("net: Use nested-BH locking for napi_alloc_cache.")
> does not change the fact that it was already present before.
> 
> Also, having bdacf3e34945 is not necessary for the backport, since
> it only made the bug visible.
> ###
> 
> Are above statements right?

That is exactly correct.

The bug was introduced by df133f3f9625 ("virtio_net: bulk free tx
skbs"), but it was not visible until bdacf3e34945 ("net: Use nested-BH
locking for napi_alloc_cache.") landed.

You don't need bdacf3e34945 ("net: Use nested-BH locking for
napi_alloc_cache.") patch backported if you don't want to.

I hope it helps,
--breno

