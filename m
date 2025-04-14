Return-Path: <netdev+bounces-182431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24725A88B80
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58C091899C85
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF26F28BA99;
	Mon, 14 Apr 2025 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a4u+Jjyc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B42820AF
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744655954; cv=none; b=opxal6PdPMYPra8yNTmh9c8sPHdPzA1LzrFs4w5V2K5Hig5tYMYl+FzQHZiEiaKEavjsOTRYz85XZsPaVbgxqk1IQzxMRrNebg+e4MyHyvR19Blrdu+pK/dcu+hMJ3vOOv8zsIM2qzBfrLAgyix5WjDeHPzHlYp9KucpEK800mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744655954; c=relaxed/simple;
	bh=3l2S1L46U8XsU4sWtbSp+mYEbAJYokaHNWfzbDztxOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sD9K0lhdymdCpJaNWxzOX4B6MDl4aI6sGo+bkE5flQwNbIktFRGk9uTWB6NiVU6LapAwToKPEQtwKXMWh13V212Z/X1QHoZgHAl7WlJEcLynDfdDQ7YdsZMwLUgFLOBjuJlH66GNbmflPj8GqCIyz/BZ/Xqv+AW6XzZfDr0ga/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a4u+Jjyc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744655951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r/iXXqChlzjbODZfwDRdIt5xwYfNbSaluxaykDmQl48=;
	b=a4u+JjycIOQczNHwuilROJyIVCqBxzZByBQ8ewOpzah/nlJEsmFrlds+eZFw/ONuuc34T0
	nxHJ8znueRnIVvYMT9HltmS1yFGpdhxBbq1M3H4vI0CahHOS9H+Eg3jJkrdZAgENIZ33av
	MokxF8ll4mw4KM6mGmOfLjeha7JIaVQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-_DqPCqtkOAGnT6G4zkXaJw-1; Mon, 14 Apr 2025 14:39:09 -0400
X-MC-Unique: _DqPCqtkOAGnT6G4zkXaJw-1
X-Mimecast-MFC-AGG-ID: _DqPCqtkOAGnT6G4zkXaJw_1744655948
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39131f2bbe5so1719041f8f.3
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 11:39:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744655948; x=1745260748;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/iXXqChlzjbODZfwDRdIt5xwYfNbSaluxaykDmQl48=;
        b=bOWjBCMS0DP+B50+4fq8wSI6UHAOpk6n+XNyGi+9aJjUqxnIAt546+EbSqcH8eRxJ4
         VLaPFkm4IbUB7kRdJ2NHVJYb1G1Wdi50wY7GBSUEfTvHzp1o1A16Uvs2wX3uS7jNOUnV
         3bpi+Xg9LniN7XXnwyoOrQTyNfCGhRU1kxhNLJ6+xXm0pSa8ayfxjZkxhECd8rke8q+J
         lz6dnStmkztUz/PwBP3HMqD1Uu+QbWMoMXhO1bzsCxUtwZ55pe0hBw04n0PZfPhOx0DU
         oyM+YpDUCV2a8GbAiLQ4/5JiYGCsUk3TSnkWmC1e9KS8/X9wddpmCktgVTKsSYseaKoz
         K7oQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGPL3SnLXWjFou41QNB/UgcC8INzEQ2H44gpZbzLSvCBajeaBoVHPJlf12M5la3XnPZ64l40I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrwWcj+BgSxSAPULW1QLiN3vLmCBtLd6YSNSXpKhq33GOrseH7
	WrlFUg8EPRs4xbNiMSY2iNbeger+K19Yih7bhkDER8sZuZOicRqIDAMenEkF+qdIzSZYfzSY5+U
	iwK38u1FRHqDdBrc82u0VM+iRWm3ONzwXHOv7q+AbLZjjyj2DGbkhyw==
X-Gm-Gg: ASbGnctv/Bz9+yo40CZ2IbqdriZqqGBFfLmfZsiEyGVyLxITKkB4tnq956fyFuRDkug
	yKC0EuSncMQqWq+bWJz03FY+OcGbPPd5WegkoABWQ1KeZDmiM4QDBJHLFvA8oYH7jFrs1zn1+Xg
	VptDH4l60qeQNVDuuQcAvmiJmBTFhvaA+WjEceB2XDGxKNTLAnjROkFwkfdvw7Rh5kpOkEt6LYQ
	YrWyOCHAMUqBd2BzMEJXAl9UxNmelHZ66/I0mBEld4jy7B+RrC3YKfMB1xKOTCKckR4Ri2RZ48s
	IFK6ng==
X-Received: by 2002:a5d:6da8:0:b0:39c:1424:3246 with SMTP id ffacd0b85a97d-39ea51d3527mr9946037f8f.2.1744655948210;
        Mon, 14 Apr 2025 11:39:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAxTcLnqSrTxH65+u6GiRouP7vWe1kbCg6AHGAsfsrltSDOoWgKmUYeCud8h0C9/BhA/o+Iw==
X-Received: by 2002:a5d:6da8:0:b0:39c:1424:3246 with SMTP id ffacd0b85a97d-39ea51d3527mr9946011f8f.2.1744655947712;
        Mon, 14 Apr 2025 11:39:07 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eaf445788sm11861921f8f.93.2025.04.14.11.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 11:39:06 -0700 (PDT)
Date: Mon, 14 Apr 2025 14:39:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org,
	netdev@vger.kernel.org, jasowang@redhat.com,
	michael.christie@oracle.com, pbonzini@redhat.com,
	stefanha@redhat.com, eperezma@redhat.com, joao.m.martins@oracle.com,
	joe.jin@oracle.com, si-wei.liu@oracle.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 9/9] vhost: add WARNING if log_num is more than limit
Message-ID: <20250414143039-mutt-send-email-mst@kernel.org>
References: <20250403063028.16045-1-dongli.zhang@oracle.com>
 <20250403063028.16045-10-dongli.zhang@oracle.com>
 <20250414123119-mutt-send-email-mst@kernel.org>
 <e00d882e-9ce7-48b0-bc2f-bf937ff6b9c3@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e00d882e-9ce7-48b0-bc2f-bf937ff6b9c3@oracle.com>

On Mon, Apr 14, 2025 at 09:52:04AM -0700, Dongli Zhang wrote:
> Hi Michael,
> 
> On 4/14/25 9:32 AM, Michael S. Tsirkin wrote:
> > On Wed, Apr 02, 2025 at 11:29:54PM -0700, Dongli Zhang wrote:
> >> Since long time ago, the only user of vq->log is vhost-net. The concern is
> >> to add support for more devices (i.e. vhost-scsi or vsock) may reveals
> >> unknown issue in the vhost API. Add a WARNING.
> >>
> >> Suggested-by: Joao Martins <joao.m.martins@oracle.com>
> >> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> > 
> > 
> > Userspace can trigger this I think, this is a problem since
> > people run with reboot on warn.
> 
> I think it will be a severe kernel bug (page fault) if userspace can trigger this.
> 
> If (*log_num >= vq->dev->iov_limit), the next line will lead to an out-of-bound
> memory access:
> 
>     log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
> 
> I could not propose a case to trigger the WARNING from userspace. Would you mind
> helping explain if that can happen?

Oh I see. the commit log made me think this is an actual issue,
not a debugging aid just in case.


> > Pls grammar issues in comments... I don't think so.
> 
> I did an analysis of code and so far I could not identify any case to trigger
> (*log_num >= vq->dev->iov_limit).
> 
> The objective of the patch is to add a WARNING to double confirm the case won't
> happen.
> 
> Regarding "I don't think so", would you mean we don't need this patch/WARNING
> because the code is robust enough?
> 
> Thank you very much!
> 
> Dongli Zhang


Let me clarify the comment is misleading.
All it has to say is:

	/* Let's make sure we are not out of bounds. */
	BUG_ON(*log_num >= vq->dev->iov_limit);

at the same time, this is unnecessary pointer chasing
on critical path, and I don't much like it that we are
making an assumption about array size here.

If you strongly want to do it, you must document it near
get_indirect: 
@log - array of size at least vq->dev->iov_limit


> > 
> >> ---
> >>  drivers/vhost/vhost.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> >> index 494b3da5423a..b7d51d569646 100644
> >> --- a/drivers/vhost/vhost.c
> >> +++ b/drivers/vhost/vhost.c
> >> @@ -2559,6 +2559,15 @@ static int get_indirect(struct vhost_virtqueue *vq,
> >>  		if (access == VHOST_ACCESS_WO) {
> >>  			*in_num += ret;
> >>  			if (unlikely(log && ret)) {
> >> +				/*
> >> +				 * Since long time ago, the only user of
> >> +				 * vq->log is vhost-net. The concern is to
> >> +				 * add support for more devices (i.e.
> >> +				 * vhost-scsi or vsock) may reveals unknown
> >> +				 * issue in the vhost API. Add a WARNING.
> >> +				 */
> >> +				WARN_ON_ONCE(*log_num >= vq->dev->iov_limit);
> >> +
> >>  				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
> >>  				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
> >>  				++*log_num;
> >> @@ -2679,6 +2688,15 @@ int vhost_get_vq_desc(struct vhost_virtqueue *vq,
> >>  			 * increment that count. */
> >>  			*in_num += ret;
> >>  			if (unlikely(log && ret)) {
> >> +				/*
> >> +				 * Since long time ago, the only user of
> >> +				 * vq->log is vhost-net. The concern is to
> >> +				 * add support for more devices (i.e.
> >> +				 * vhost-scsi or vsock) may reveals unknown
> >> +				 * issue in the vhost API. Add a WARNING.
> >> +				 */
> >> +				WARN_ON_ONCE(*log_num >= vq->dev->iov_limit);
> >> +
> >>  				log[*log_num].addr = vhost64_to_cpu(vq, desc.addr);
> >>  				log[*log_num].len = vhost32_to_cpu(vq, desc.len);
> >>  				++*log_num;
> >> -- 
> >> 2.39.3
> > 


