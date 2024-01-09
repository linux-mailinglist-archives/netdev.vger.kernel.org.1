Return-Path: <netdev+bounces-62761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFAC8290B7
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 00:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84F6288155
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 23:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8EC3F8D8;
	Tue,  9 Jan 2024 23:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXIu1Rfb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA483FB09
	for <netdev@vger.kernel.org>; Tue,  9 Jan 2024 23:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704841676;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PmsOSA8e0agbmpKIvz+4i4zAbpgfLcQxgusd1VNG7pQ=;
	b=JXIu1RfbJu/A5Td5xNkKZrIBLu2ITHCfEFTdUnqUvVxQsw5RtCSQIaFt8+QIimSEadGKdQ
	Am5Qt54RgDCHIFYMGEALRGlWGIg2yPl1tS7bszUeN73enZbZNhzVhPfdvlYv8aE1jBZUpI
	kHLEBrzI3nhpFPmKck+bMQU7LNpsHNk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-qvUcwbMSOQ6bPantIvOy2Q-1; Tue, 09 Jan 2024 18:07:50 -0500
X-MC-Unique: qvUcwbMSOQ6bPantIvOy2Q-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40d62d3ae0cso31177785e9.2
        for <netdev@vger.kernel.org>; Tue, 09 Jan 2024 15:07:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704841669; x=1705446469;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PmsOSA8e0agbmpKIvz+4i4zAbpgfLcQxgusd1VNG7pQ=;
        b=jBkHXSkbpI3UBQrex4/9I05e60Hfiv1QpeED/S8n14d4j+DradhytK7iSallxOC50y
         s3aDlTPHt9Mb+7oJQFjJP5LK/07Tepm6YKuVzSInq4VIcyZ7INiBNTLOc3i6UlYwNAJI
         DFVTBuyFoROfF9fsj5SwskC6D/BWTSFADQ6SMwcRLyNvGUHymnB5jHTd0jhxTr3uphuw
         9T7uO1k1qUxeRWKb2lIVLv0eN+6I4+cuE7DzsgyJJZ7ishAcwoW8DROVZgyIr/X5Nlf1
         v8xm/dt1aLg7Jb1E0DavnIpVHh79NdOG29uHNJvYAm546TfssZ9mtr+IPWxSgY2NDjMN
         KoxA==
X-Gm-Message-State: AOJu0YxYwy88qDfVZWzrfO1vDcwu9htN3rZPvMfu8wPPT71uEL9uZ0oi
	tXEcrSjfEah/FqjDdWR0LqfMXEGElQPEExQXB9ccfR19ePswDrtsmCUTZ9T7VyGsnzVo1z9ZW0u
	tjibR5lXThBymL5viTer5Ccjw
X-Received: by 2002:a05:600c:1603:b0:40e:4800:c91f with SMTP id m3-20020a05600c160300b0040e4800c91fmr31978wmn.9.1704841668813;
        Tue, 09 Jan 2024 15:07:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEO3FEhMXyQFhkdwPMbAGnlA5UDqENRCt3LgtBWXNMza5r2kTWnZqKT5YT16xPNccXd/SHk6A==
X-Received: by 2002:a05:600c:1603:b0:40e:4800:c91f with SMTP id m3-20020a05600c160300b0040e4800c91fmr31970wmn.9.1704841668528;
        Tue, 09 Jan 2024 15:07:48 -0800 (PST)
Received: from redhat.com ([2.52.133.193])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040d7c3d5454sm59173wmo.3.2024.01.09.15.07.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 15:07:47 -0800 (PST)
Date: Tue, 9 Jan 2024 18:07:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Tobias Huschle <huschle@linux.ibm.com>
Cc: Jason Wang <jasowang@redhat.com>, Abel Wu <wuyun.abel@bytedance.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: Re: Re: EEVDF/vhost regression (bisected to 86bfbb7ce4f6
 sched/fair: Add lag based placement)
Message-ID: <20240109180706-mutt-send-email-mst@kernel.org>
References: <CACGkMEuSGT-e-i-8U7hum-N_xEnsEKL+_07Mipf6gMLFFhj2Aw@mail.gmail.com>
 <20231211115329-mutt-send-email-mst@kernel.org>
 <CACGkMEudZnF7hUajgt0wtNPCxH8j6A3L1DgJj2ayJWhv9Bh1WA@mail.gmail.com>
 <20231212111433-mutt-send-email-mst@kernel.org>
 <42870.123121305373200110@us-mta-641.us.mimecast.lan>
 <20231213061719-mutt-send-email-mst@kernel.org>
 <25485.123121307454100283@us-mta-18.us.mimecast.lan>
 <20231213094854-mutt-send-email-mst@kernel.org>
 <20231214021328-mutt-send-email-mst@kernel.org>
 <92916.124010808133201076@us-mta-622.us.mimecast.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92916.124010808133201076@us-mta-622.us.mimecast.lan>

On Mon, Jan 08, 2024 at 02:13:25PM +0100, Tobias Huschle wrote:
> On Thu, Dec 14, 2023 at 02:14:59AM -0500, Michael S. Tsirkin wrote:
> > 
> > Peter, would appreciate feedback on this. When is cond_resched()
> > insufficient to give up the CPU? Should Documentation/kernel-hacking/hacking.rst
> > be updated to require schedule() instead?
> > 
> 
> Happy new year everybody!
> 
> I'd like to bring this thread back to life. To reiterate:
> 
> - The introduction of the EEVDF scheduler revealed a performance
>   regression in a uperf testcase of ~50%.
> - Tracing the scheduler showed that it takes decisions which are
>   in line with its design.
> - The traces showed as well, that a vhost instance might run
>   excessively long on its CPU in some circumstance. Those cause
>   the performance regression as they cause delay times of 100+ms
>   for a kworker which drives the actual network processing.
> - Before EEVDF, the vhost would always be scheduled off its CPU
>   in favor of the kworker, as the kworker was being woken up and
>   the former scheduler was giving more priority to the woken up
>   task. With EEVDF, the kworker, as a long running process, is
>   able to accumulate negative lag, which causes EEVDF to not
>   prefer it on its wake up, leaving the vhost running.
> - If the kworker is not scheduled when being woken up, the vhost
>   continues looping until it is migrated off the CPU.
> - The vhost offers to be scheduled off the CPU by calling 
>   cond_resched(), but, the the need_resched flag is not set,
>   therefore cond_resched() does nothing.
> 
> To solve this, I see the following options 
>   (might not be a complete nor a correct list)
> - Along with the wakeup of the kworker, need_resched needs to
>   be set, such that cond_resched() triggers a reschedule.
> - The vhost calls schedule() instead of cond_resched() to give up
>   the CPU. This would of course be a significantly stricter
>   approach and might limit the performance of vhost in other cases.

And on these two, I asked:
	Would appreciate feedback on this. When is cond_resched()
	insufficient to give up the CPU? Should Documentation/kernel-hacking/hacking.rst
	be updated to require schedule() instead?


> - Preventing the kworker from accumulating negative lag as it is
>   mostly not runnable and if it runs, it only runs for a very short
>   time frame. This might clash with the overall concept of EEVDF.
> - On cond_resched(), verify if the consumed runtime of the caller
>   is outweighing the negative lag of another process (e.g. the 
>   kworker) and schedule the other process. Introduces overhead
>   to cond_resched.
> 
> I would be curious on feedback on those ideas and interested in
> alternative approaches.



