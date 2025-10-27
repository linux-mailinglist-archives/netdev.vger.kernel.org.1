Return-Path: <netdev+bounces-233263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 180C3C0F9E5
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 18:25:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 007474E3269
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 17:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA09314B65;
	Mon, 27 Oct 2025 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UypOm19P"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBBF2D23B9
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761585937; cv=none; b=JtlvqXWlQfDjW9ZyBIFW99rwxDVE98PaMogQs8zHc4smhhOcqiavOmg5rhAEkt1Sg4BVpeudBtRrApGh57WA/Qz6FStsysSANCxE+Rv8X4XVTL/6+1FltgwnguWeBlOHkJARfOl9JzWjqAsDgwsx1hAFIPuTtCU8LHIx5qUjaJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761585937; c=relaxed/simple;
	bh=HAqDcgGMjKKzyDltuxO03NIXefnszZjB7wdrs046Gys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjWQOrppTZTeYTVn3IFUCpE5gBHQf952YmY7+NDNJ/JHHxu6aVCz7A/DWuHFjmUjX3nDq6YSqohWz7TWid0c5ckSw+HL2CBVNQ7WzIh7Vn/+4vJjmOme7Wr16+Lh81GyWCRGpt8sQUu+Mzsiph2SR3fgrcpFB4aFi2spuw8hYI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UypOm19P; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7829fc3b7deso38052117b3.3
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 10:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761585934; x=1762190734; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rJ/ydtqR65wkobsTKCpney8zjIjx42CMb/k/gju9QlM=;
        b=UypOm19PIaJXT77Hrr6pWAUNTOqddsoLus5KTq1conazITUnHnyPeEubbTWMTL5CEZ
         oZgZQZYcB7xEbAVXGmD7ci7W6P1F69Bv9w+uC53x8yXeB2z0ecWnIp+3UI5DWCwKr5bQ
         z66vb99ZeW2530AG0GGcastxAQ0Fr/AoQ7Qr4z+fmpX7ixscRod1ZP2/6UPM0PUXk2Og
         BpEAeSZI1kBQXMPcKX3fRGep94r0IQjhp6L4Prj3FvdparUhGQUjwp1W+PrMZm6zEAzT
         5RQx0Qy1G/1HT2Sg/atd5PsL6srvd/VGxqvZWz0h4xWYOEm53Wbz333h1eKbaO///0si
         mv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761585934; x=1762190734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rJ/ydtqR65wkobsTKCpney8zjIjx42CMb/k/gju9QlM=;
        b=HIME1SM8pM5/m/EUjdmP4nETwSXeoEA6OnaTMlzd3hYULI6wQVTyx6f4buDk+QyKRa
         7Bqt9dLKc/qa1iYlzMFTW1M6TIFdweLVncJ6S8LPukVtSpUMyYlvXmeU/FO4ETihOMkV
         UULrG+qfzwQ8F60WWV9PtvzW2+EkCFdvlLo2oB4lzJ7bYC4V6NgbEBXhB3D79K6QjppW
         BIvTbVIPzxaDYoPWnzcnrfnYp57z9V8sFFU0m2GZh832FDJcg28e2XPbWnCUF6Bm6y8e
         ikpM4y1mIhcCP41CK6zRFpDCKO+KN9sti9Emar2pMpycBQizI9lsDnA8RUaQb56lZPS/
         K0iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoxMVG9cxLjpF0ctSXF34tMbPvFBTzayT100cemv06LcWWw2R0poK7l/Qq48VELxFWKLufUsk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrE8HnWUxMqV1YCldzKKiVLWoHBMaSmpnTbfAlI4OnAjYNB3j4
	uvaYWQc46Htaph/NHLILfvwrWgpwquOnjro3yZ6xSXl3wR2XGdaDvakN
X-Gm-Gg: ASbGncudrRninbz7hfp9+QH0w85dAz5Me82MFG8gPgAstq/v9N379zwBMuuSPw1jvA9
	p5du9LpgclIbS+UJpf1MYNVcdfnfE6LCDQYcoPxTlnBCJYI+ZDmLBgfqZFvFim18X34QJ9bBi10
	dZzAflkK+YdMu/Q9dBAIPZzMq0O4XzDPMl+KteO8cPexmBhfF6r4nM+LFUa9AfoXAdbWitYm7YI
	Q/wRnuGygYpuIPuc0+Ub2b8ZgxwKbwFaeZ8doaoSZgF0IZ9zbW4240Q2ZJjxNUPOAtvzavsgegF
	7tvQMUkTqeO8meN4AQvbjHigTOkyur4fMB+1IvBmT6kHEkVaT8/4ZZ0jopIjgSm8HQAPmPStUer
	IJy1WXw2TofVYNXR1Z4pNTqpT+jTKClh6hIt3Dn/jWS0AA8osE4H3UyuUhigjYT7horNHEP8SPs
	o/fMs3GQpF82BmmJIelkS7D8X1elK5GR10W4Q=
X-Google-Smtp-Source: AGHT+IGHTF9vBtn+seygObOHlL96iKi+OVb+7MtjlE9jx6wEi+MY/OkA96sVfPPxkYnPfsaXOqXkAw==
X-Received: by 2002:a05:690c:338b:b0:723:bf47:96f8 with SMTP id 00721157ae682-786183ab057mr5505517b3.53.1761585934504;
        Mon, 27 Oct 2025 10:25:34 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:9::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed1423f5sm20564397b3.5.2025.10.27.10.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 10:25:33 -0700 (PDT)
Date: Mon, 27 Oct 2025 10:25:29 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 00/14] vsock: add namespace support to
 vhost-vsock
Message-ID: <aP+rCQih4YMm1OAp@devvm11784.nha0.facebook.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
 <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <k4tqyp7wlnbmcntmvzp7oawacfofnnzdi5cjwlj6djxtlo6xai@44ivtv4kgjz2>

On Mon, Oct 27, 2025 at 02:28:31PM +0100, Stefano Garzarella wrote:
> Hi Bobby,
> 
> > 
> > Changes in v8:
> > - Break generic cleanup/refactoring patches into standalone series,
> >  remove those from this series
> 
> Yep, thanks for splitting the series. I'll review it ASAP since it's a
> dependency.
> 
> I was at GSoC mentor summit last week, so I'm bit busy with the backlog, but
> I'll do my best to review both series this week.
> 
> Thanks,
> Stefano
> 

Thanks for the heads up!

Best,
Bobby

