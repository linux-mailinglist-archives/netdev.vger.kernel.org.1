Return-Path: <netdev+bounces-249344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8941BD17047
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 08:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 23AA0300E614
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 07:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68089310636;
	Tue, 13 Jan 2026 07:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA2zBGk2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hu3xkvuf"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF412D77FE
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 07:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289424; cv=none; b=HY/zr8xC7Uy1HgaZ2XIyQAmkP30tw+YP1lV0EQkbdo2C5LEDIrFZbDSoRT+miY3qIA0VG57V6iTDn7UlxkZTtutTBor+SHbEBX7Re4pORpL4TAZsBV6qbRjrrdr+H4WFv4k/lAL5eU0l+2hUgGQyRte2QQSGWSIy+kGNNkTcYsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289424; c=relaxed/simple;
	bh=s0jNNTCFNE3uPdMhFoPhUG0485jwxbZ2R+RoOksHx5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qM0tsjdSMLD4bgvK+G8tG7D8iuYtgPvB1nMASupFKjkfK1ezn993XbujbBV3kM49tC/kBEziWpH+zoYFd3hp5HdDjJ3l7QtYOTc1uBb37ShMcT3ld6nuHdmYviVaO9HoQoj1NAyi3J2IJViX53INvd36S9B99H3HBkyqRHQM9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cA2zBGk2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hu3xkvuf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768289422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiNF2ZRVVEZ6E26LXjvC+Q546JUw1TsWOthVS73LBBw=;
	b=cA2zBGk2wXt5TQspVbL47TQTf+KQ3xcxj1gei3XiceNqJ9eBGc5kHMBd0p5GBqTkn2alpE
	tNkWPwgSkaNckSD32+dgTTCfiEfMijZY1iTdIT/EwFPzXtdDOuky2CiA8kUIiZky4Ra9oY
	0nVk1972pssadvPZ847k1a2Ga+bZU30=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-390-wRT8orrENu669_SaIplyzQ-1; Tue, 13 Jan 2026 02:30:18 -0500
X-MC-Unique: wRT8orrENu669_SaIplyzQ-1
X-Mimecast-MFC-AGG-ID: wRT8orrENu669_SaIplyzQ_1768289418
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4775f51ce36so66193345e9.1
        for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 23:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768289417; x=1768894217; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wiNF2ZRVVEZ6E26LXjvC+Q546JUw1TsWOthVS73LBBw=;
        b=Hu3xkvufn78FZdBEEX1IdPZFwyD/nIXq0pMZ26krCPKgxE8HfsF6nuo93gESERcw86
         EbzrF3vJFCncxk6NALu9WHyZjhs0GNKZHIJ4DmX0KC9vOOyRFiM14uavu7qIx02uKe1a
         rwQBHg59EjNzFqSRoszN2h9tndEht8pO2YXYoHYQRhxZxp7C3/7tTfcR/NluQPTaL0py
         j/ybjS6O1kUqo27rufyygKHMKTtnAU9eUJ54rq4sTqiz+bAePCurm6X5sU7GIdoHAPdg
         pVCMfgDKELhnLVNWwhzsQqX0dWlhjm1gdQtPsCcV8S9zpXvIbq+T7S72bGpTml53IT31
         wPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768289417; x=1768894217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wiNF2ZRVVEZ6E26LXjvC+Q546JUw1TsWOthVS73LBBw=;
        b=v+Vn2LsTKdW7F+NPB/ScMdFkjmDMU5VDV7AGWDkcjhUdG/WedgV9lH4hLbgExH1Bb0
         qsSayRYwR0nXrQDk1KYzBMEbKQ2FwjoxqEsc1ZwC27XzONYBgacX2qla9wjJ6U9aWGhm
         vcWgp0CkZugMvLfE1jivIn0xtlu11J35e5qn2qutVsuQrNBLSziVi0BdmNFlNX+1NIx+
         nTrB0sWNSyLbP5lFSSTIc6StFg+ttQxzozXOgXNRuzliHEAU3HNC7EFCxGU5AoMuQjv5
         tOZTf39VVtKTncLBDOa02TFCAQvJLgmuD9bTeVB4Pt9XzejPVmq6Ac0cPU35xMky8fL4
         3ieA==
X-Forwarded-Encrypted: i=1; AJvYcCUr+rQHzsiYK9US2qgGrKjhVhu51J3ODmFeMRsxOZ9fQF6O2IkE5jBwEwGmctaTU4Fjvca5lpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjRDpJvE5JxmsaZpY2mEZQRWqVA7SIAFkzH3rKOmeZe6vGEYLH
	Z6u00NW2dRDfXY5djQKKx0L242pQLC76DIDRmxT63HoF/WqXLWQQZCg0eLhtIbI92xvUau5Dy2/
	0tHL9HCgwOvYKMz1TZ+vIxjxWgzGZCJXW/8vVUxqjs7FxVZfGKuDkwg7zAA==
X-Gm-Gg: AY/fxX5zGCsyuhlExQFH2Mx8Dt0JWkUc9bta9p6RiQwZ0DPYVrctgEhD18Y5ky4lyJe
	nV9drWDqn/BtgrSUOaOw1UcKdnhEhXiJ13SmRgu49GzwcAUGECFB6GqwbXKo6mff0tt1OHWYgNO
	6vmMN8YBvR6x80Qg5IjJCwL7wQJo8d3AIljwPnHP905tyloRWJ3dEKuQalocev+MJXE7pz3G9nh
	pGv1QQAhRqxsKRmn8WZeYvSknpeSCVKJ1fmKB3CcxjhyqiAH6hT9qC0Smv6dafygIB++9GIi7yL
	1jycKIHQtQifKmC9dnORiJ1X7GFq4vJWLz1Vj/fBc0Gv8mYdKn+wYSQfKP3frIUTRQQQSOYy2DE
	WjTK/DggQgHnYoMdf4hP1HfkvqEY+qB0=
X-Received: by 2002:a05:600c:c3cd:20b0:477:af07:dd21 with SMTP id 5b1f17b1804b1-47d8a17124bmr147931965e9.25.1768289417456;
        Mon, 12 Jan 2026 23:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZ7vVe0350H0JVYXQsiMlO2kPVRC9RBhfa40QZOD1BpNkmOPxCYFtpzNzUhbsBf042icJ1Ug==
X-Received: by 2002:a05:600c:c3cd:20b0:477:af07:dd21 with SMTP id 5b1f17b1804b1-47d8a17124bmr147931635e9.25.1768289417019;
        Mon, 12 Jan 2026 23:30:17 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f6ef868sm387228755e9.11.2026.01.12.23.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 23:30:16 -0800 (PST)
Date: Tue, 13 Jan 2026 02:30:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev,
	eperezma@redhat.com, kvm@vger.kernel.org, netdev@vger.kernel.org,
	jerinj@marvell.com, ndabilpuram@marvell.com, schalla@marvell.com,
	dtatulea@nvidia.com, jgg@nvidia.com
Subject: Re: [PATCH] vhost: fix caching attributes of MMIO regions by setting
 them explicitly
Message-ID: <20260113022538-mutt-send-email-mst@kernel.org>
References: <20260102065703.656255-1-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260102065703.656255-1-kshankar@marvell.com>

On Fri, Jan 02, 2026 at 12:27:03PM +0530, Kommula Shiva Shankar wrote:
> Explicitly set non-cached caching attributes for MMIO regions.
> Default write-back mode can cause CPU to cache device memory,
> causing invalid reads and unpredictable behavior.
> 
> Invalid read and write issues were observed on ARM64 when mapping the
> notification area to userspace via mmap.

device memory in question is the VQ kick, yes?
So if it is cached, the kick can get delayed, but how
is this causing "invalid read and write issues"?
What is read/written exactly?

> 
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> Acked-by: Jason Wang <jasowang@redhat.com>

I also worry a bit about regressing on other hardware.
Cc nvidia guys.


> ---
> Originally sent to net-next, now redirected to vhost tree
> per Jason Wang's suggestion. 
> 
>  drivers/vhost/vdpa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index 05a481e4c385..b0179e8567ab 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1527,6 +1527,7 @@ static int vhost_vdpa_mmap(struct file *file, struct vm_area_struct *vma)
>  	if (vma->vm_end - vma->vm_start != notify.size)
>  		return -ENOTSUPP;
>  
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>  	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
>  	vma->vm_ops = &vhost_vdpa_vm_ops;
>  	return 0;
> -- 
> 2.48.1


