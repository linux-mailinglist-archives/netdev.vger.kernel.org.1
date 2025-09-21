Return-Path: <netdev+bounces-225103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBCBB8E68E
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 23:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A011189A6E1
	for <lists+netdev@lfdr.de>; Sun, 21 Sep 2025 21:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862932C3251;
	Sun, 21 Sep 2025 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fmbX3g0L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635691EB5C2
	for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 21:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758490817; cv=none; b=nhdGQqvYYYVFdKYsd/+DM2IQJtk2MLxJc7CBXiKfxugDOlicLcC5gE0Du+tZqGW6vP2U457sBs2swJzyA+/ERojBXmuMuKrb8aePiTgeUYW8bFABkftyfQN8N654FpMSJFA5Cb6/XY71zi7W1rkVDJwt7RiRycCCXJStdNO+gk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758490817; c=relaxed/simple;
	bh=mYlu1Cb8XJxVfGYYbOwNf+5SlCKDDhSJhlXNvH2HuoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE+Z31dq0EQ22kpoM6kIWNWmqmth/IQvRhmiORYinvlgVktk3T/lmPsXIBsZhWU8qT8MKW7hO3LQVfTRw1LjrdSxiqXjQ2CBwQXknjnILzzJPVrxSj1eq6rfeQfcjUUJkoglYRMUQ2bF/9FET0t3tInDU7I2PV2yN2yhG/KfBRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fmbX3g0L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758490813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mjWDsw8BL0wSRiGtGTApSm/QghMD5iCMDJieH5fCE5Y=;
	b=fmbX3g0LYVdj3LODXZsP6RKTR71SmSyQrGorhCOS7HNBnvgqsulaEE27n6GMFkI2qib+Qw
	nVtQYdLI8VngIZqQP7FQD6HQ3XIu5oKcERZY50VrOH4w8qXH+6spi0gn/T1koi/MsYPtoC
	GjUa4YUa9aUuwIDG6Yp3I/oXc1t7q2s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-BVWQdHGlP4-7o_1wXuXV4w-1; Sun, 21 Sep 2025 17:40:05 -0400
X-MC-Unique: BVWQdHGlP4-7o_1wXuXV4w-1
X-Mimecast-MFC-AGG-ID: BVWQdHGlP4-7o_1wXuXV4w_1758490805
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ece14b9231so1743131f8f.0
        for <netdev@vger.kernel.org>; Sun, 21 Sep 2025 14:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758490804; x=1759095604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjWDsw8BL0wSRiGtGTApSm/QghMD5iCMDJieH5fCE5Y=;
        b=qTDbPJTv4rJjJvXGSHXouWdH9nN/tyXu/LLStTTo2mGs3mvv3hwUD3DFaLRtS1cVqj
         +gJbSW5YEzZF6kCEgrmFoTqOwVVynguFzUJkBrpW9LiC9r8ktmu7NSwXKDy0p2EFuuRu
         OylXY14nHffRGzn+XqZZADTPy3Vdg8hcJRf14mmJ5Q38ymz7llM+e+AcXnhiTH0zRtmB
         iyKKoNojx+RQDY9k0rZgENm3DB5Dq8bAPXBnOi4EDrZVcMvmMNzVvIRkXj9aFQAXxmzE
         je2rsPSnpemvqLNInZ3n3rNC7iHZ9eXxdqAe6EzhUn8EjcpZDHch0n3GHAeq/bMtx7qb
         Pz+w==
X-Forwarded-Encrypted: i=1; AJvYcCXsR0kaKbforIMv8n6tykK4jxADZgHpcjDQGtQrhimcEV0TV9fY73C+zXM+KZ6rMU6nj0QvkZo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKXfv8ch08aFxsv74pOaEugqvd8NtlvbehoNjIPaYtOnawd6vF
	QE0951aMWI/9ZWFWMbivQNP9dFOqGo5NRVaIoPFFSjS/e7yE9epKpy2wW7FEdyKWuXL8QwXZ0mX
	+6yUxVaWCQq7oTL5eeyUzvSu7ELefZjlDUwX3OLz5Goj3a+IDocwMO9gYeA==
X-Gm-Gg: ASbGncuJw8b2/ZDyNUoN+4ZIgeiV6Bcm0kfORLasKhVlAdo349a1Y4E7DQvCLEAehX2
	4HmCufzPl4ZD877lxbjqMx30CkEYsjB5d5iNZ6KyIkeysdHdO7TRLgunrjly0DpTK4vVjnOz4QI
	65B3UZXCeP9mzYyaIynnE7yGID8ZNZKcNfuob19dYqge+QP9Dgfjd+0gVvm9Lo1t6aHE04tkFzo
	GSti8qZuyaKL5MgdSh4rpsuOWDXa9DjXUkg8Ncep7DrUMIsHiVoEpkVIameORI/16SSeVCBipU1
	j72bdOqs2TFurbhg1eGqf0DpLYtl8IXVc1s=
X-Received: by 2002:a05:6000:2285:b0:3ed:a43b:f173 with SMTP id ffacd0b85a97d-3ee8585e3d7mr9640218f8f.42.1758490804605;
        Sun, 21 Sep 2025 14:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFW4yYuHu/iRIBuAiq3TYquYa/BUUV5VnlAcln8dUtQI5Bcq9TDf+qyoforvTHvt2Z+XzLrWw==
X-Received: by 2002:a05:6000:2285:b0:3ed:a43b:f173 with SMTP id ffacd0b85a97d-3ee8585e3d7mr9640208f8f.42.1758490804220;
        Sun, 21 Sep 2025 14:40:04 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbfedd6sm17304749f8f.60.2025.09.21.14.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 14:40:03 -0700 (PDT)
Date: Sun, 21 Sep 2025 17:40:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: Take a reference on the task that is reference in
 struct vhost_task.
Message-ID: <20250921173934-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <20250918120607-mutt-send-email-mst@kernel.org>
 <20250918181144.Ygo8BZ-R@linutronix.de>
 <20250921165538-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250921165538-mutt-send-email-mst@kernel.org>

On Sun, Sep 21, 2025 at 04:56:20PM -0400, Michael S. Tsirkin wrote:
> Subject: that is reference -> that is referenced

to note i fixed it for now. just dropped "that is referenced"
completely. shorter.

> On Thu, Sep 18, 2025 at 08:11:44PM +0200, Sebastian Andrzej Siewior wrote:
> > vhost_task_create() creates a task and keeps a reference to its
> > task_struct. That task may exit early via a signal and its task_struct
> > will be released.
> > A pending vhost_task_wake() will then attempt to wake the task and
> > access a task_struct which is no longer there.
> > 
> > Acquire a reference on the task_struct while creating the thread and
> > release the reference while the struct vhost_task itself is removed.
> > If the task exits early due to a signal, then the vhost_task_wake() will
> > still access a valid task_struct. The wake is safe and will be skipped
> > in this case.
> > 
> > Fixes: f9010dbdce911 ("fork, vhost: Use CLONE_THREAD to fix freezer/ps regression")
> > Reported-by: Sean Christopherson <seanjc@google.com>
> > Closes: https://lore.kernel.org/all/aKkLEtoDXKxAAWju@google.com/
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> >  kernel/vhost_task.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/kernel/vhost_task.c b/kernel/vhost_task.c
> > index bc738fa90c1d6..27107dcc1cbfe 100644
> > --- a/kernel/vhost_task.c
> > +++ b/kernel/vhost_task.c
> > @@ -100,6 +100,7 @@ void vhost_task_stop(struct vhost_task *vtsk)
> >  	 * freeing it below.
> >  	 */
> >  	wait_for_completion(&vtsk->exited);
> > +	put_task_struct(vtsk->task);
> >  	kfree(vtsk);
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_stop);
> > @@ -148,7 +149,7 @@ struct vhost_task *vhost_task_create(bool (*fn)(void *),
> >  		return ERR_CAST(tsk);
> >  	}
> >  
> > -	vtsk->task = tsk;
> > +	vtsk->task = get_task_struct(tsk);
> >  	return vtsk;
> >  }
> >  EXPORT_SYMBOL_GPL(vhost_task_create);
> > -- 
> > 2.51.0


