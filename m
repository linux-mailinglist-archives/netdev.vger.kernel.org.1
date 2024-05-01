Return-Path: <netdev+bounces-92705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5B78B857B
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 08:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27032B225D1
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 06:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0989F4AEC8;
	Wed,  1 May 2024 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUsJVz66"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6224C602
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 06:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714543297; cv=none; b=UeEtM99NsZr7llELgqiSI53+5Mg0j1jT0SmwHUMs+FF128mln88Mt1BBRQKZSCMx5buzWgzyk0/0hayVYht/f2mlGeENs3h+mpqSTNFC7rRqRnJ9uA+7OqoCJGYF2klimpEM0eWPC/JVhPCHfvMSt0mKqfkR22EVS7Oota/LCGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714543297; c=relaxed/simple;
	bh=826e6puMm6zzTrxffD62gEQ3vdQCaEKJUlUGOq1Xpv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDo4lBltxOKQLZL8AHcsZ2KHZZ9GyjukH/GP7EvPxV/yeoxXCvuqQiCNjJsMbME82Lj7WjXDEwBthgzsT/fPUFInpSBvo6TKdDmB6TgTPq4SpVQC+9NtPOR62PTzALYPo62nnxP04LfzilAEUKEsuyYbcqSG+m8ieIlFAtQWTv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUsJVz66; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714543292;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ACs9fP8UeUOFIH6gYeB8LpBxm1NZNbq1XOuqsdPyK04=;
	b=VUsJVz66FwJd9U+AMSpbgf7Q+vIwK8kqw7qlAzBjnAANtVxiXS20matif/ZbGm7iGQYLGy
	1e2O0a8Oe521u6Y7XZqyZWzcarmb/xzDDkz9DBTQbbhBo97wBCVxdi+TucOQVXibGECzny
	327rRWAGO2mUz8bEiE3HGY7hoOJQs/c=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-p0PQSjyWPU2ZFADzZDJqFA-1; Wed, 01 May 2024 02:01:29 -0400
X-MC-Unique: p0PQSjyWPU2ZFADzZDJqFA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a57bf8ae2fcso388272866b.3
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:01:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714543287; x=1715148087;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACs9fP8UeUOFIH6gYeB8LpBxm1NZNbq1XOuqsdPyK04=;
        b=pwI6dPY5+jk5NLy2nTB/ufg2gUrWqmkuRaw4Xa+1eArqWOyOoH35xrWar3vd2GQJzJ
         REOg0fGzW4KeGxjFrhX9x24mwRWLBi1dmiCYSnAOe1/L90eNpD+sCX29NUfWGy64SP6F
         sczSbDaLXH8A41nENDUL6i9uAaeXfFgZrNJrSU35YJJEt+rJU85HOAV1nvKSE2GjXOMu
         09GfGQejEwN56ZoDegzcP1koyh3Efrw6Bi3w9/K0IwXJvggU5rSXNo745emJ4dj3Fgok
         HG3o7pMI/soNfVjP1V4OWi5LuUniA/aQjB0Ks5zgvtk6j/oZ07/34VLgxGboRTqjm7h4
         jN8A==
X-Forwarded-Encrypted: i=1; AJvYcCWYgRtSLKx9WaZTXCBkzfi5Ow7qa0Z6Ky5OPVbzEIGzA+wTzgc9abcstEWtlNLgVbtClAsxC8wlD1wvaItKJEPt1KJczuPX
X-Gm-Message-State: AOJu0YxjqQjggDRTF7riEAUWa0p2inc4Zcp1soMd/2rsua1CCzzW06uA
	jGq4tqmHQpXJd1ubLenrHhlzZydtLOVkJmSgjFTDOu0sasAjFCNEiHjqAR9Ab4hhwXLOvTV0OGV
	resjHBonVDKdOr6fZGfsYg9Xi84K2/DCd565U3+FAqD7y0WlA6f4Pnw==
X-Received: by 2002:a17:906:e219:b0:a58:f186:192 with SMTP id gf25-20020a170906e21900b00a58f1860192mr1224413ejb.0.1714543286635;
        Tue, 30 Apr 2024 23:01:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSlMxEoUZ88OBzUnW9OSy6mbDeqVmGiKA+13uWDb7mOt6quE44mzfAWkhW9+s6sFw1/mZ2+A==
X-Received: by 2002:a17:906:e219:b0:a58:f186:192 with SMTP id gf25-20020a170906e21900b00a58f1860192mr1224363ejb.0.1714543285807;
        Tue, 30 Apr 2024 23:01:25 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id e20-20020a170906249400b00a5910978816sm2187459ejb.121.2024.04.30.23.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 23:01:25 -0700 (PDT)
Date: Wed, 1 May 2024 02:01:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hillf Danton <hdanton@sina.com>
Cc: Mike Christie <michael.christie@oracle.com>,
	Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not
 be accessed in vhost_task_fn
Message-ID: <20240501020057-mutt-send-email-mst@kernel.org>
References: <b959b82a-510f-45c0-9e06-acf526c2f4a1@oracle.com>
 <20240501001544.1606-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501001544.1606-1-hdanton@sina.com>

On Wed, May 01, 2024 at 08:15:44AM +0800, Hillf Danton wrote:
> On Tue, Apr 30, 2024 at 11:23:04AM -0500, Mike Christie wrote:
> > On 4/30/24 8:05 AM, Edward Adam Davis wrote:
> > >  static int vhost_task_fn(void *data)
> > >  {
> > >  	struct vhost_task *vtsk = data;
> > > @@ -51,7 +51,7 @@ static int vhost_task_fn(void *data)
> > >  			schedule();
> > >  	}
> > >  
> > > -	mutex_lock(&vtsk->exit_mutex);
> > > +	mutex_lock(&exit_mutex);
> > >  	/*
> > >  	 * If a vhost_task_stop and SIGKILL race, we can ignore the SIGKILL.
> > >  	 * When the vhost layer has called vhost_task_stop it's already stopped
> > > @@ -62,7 +62,7 @@ static int vhost_task_fn(void *data)
> > >  		vtsk->handle_sigkill(vtsk->data);
> > >  	}
> > >  	complete(&vtsk->exited);
> > > -	mutex_unlock(&vtsk->exit_mutex);
> > > +	mutex_unlock(&exit_mutex);
> > >  
> > 
> > Edward, thanks for the patch. I think though I just needed to swap the
> > order of the calls above.
> > 
> > Instead of:
> > 
> > complete(&vtsk->exited);
> > mutex_unlock(&vtsk->exit_mutex);
> > 
> > it should have been:
> > 
> > mutex_unlock(&vtsk->exit_mutex);
> > complete(&vtsk->exited);
> 
> JFYI Edward did it [1]
> 
> [1] https://lore.kernel.org/lkml/tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com/

and then it failed testing.

> > 
> > If my analysis is correct, then Michael do you want me to resubmit a
> > patch on top of your vhost branch or resubmit the entire patchset?


