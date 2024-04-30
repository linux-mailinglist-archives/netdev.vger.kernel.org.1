Return-Path: <netdev+bounces-92575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624138B7F6E
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 20:06:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 924791C232C7
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 18:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3293181D15;
	Tue, 30 Apr 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYM8MK2L"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC5F181328
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714500405; cv=none; b=nTUkSugiT/4y5+DSs9PXKPHxfIDj4fGV3cTdDHDrKHru8SN3Ba1OBud82UkcFcDcVjDaEXwcPq7E6+w97ZiFRuKFxlA5uBhizqYEoro9bbRcSsDq7aTlmHavO8DXhZCpo9Ny/kMsZxL1uVuNHFd1eKQxrAQ7CeCIdO2b4qwr/W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714500405; c=relaxed/simple;
	bh=qJioFQM6gatzhNfw88pAwDEH8AUYC7rqX3dJnAvMfM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPPzFxtjiQsaeReej0Ec0zjou5yUFvzMycvnTqG7HPZCIItcmUPQAbXPmZUbb0JMVx4lValHpQhVzfuDto2vVhUZEon0oj80jNKj+sgM6zZlmaoWK7oP2DP67VhsWvTHzp2k1gAhF2YS0wngLemiCWqi0gdmsMW0eG8BlU/d3BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cYM8MK2L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714500403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F5zx7cpE5g24SyrILpVbFuVBHG+ow92d4f3RUXTPOCU=;
	b=cYM8MK2LnCLBYlc7wIye0XiXT3QmnIp5mUS8KypWdXEnQDGE6WD88BRs+IHwSh0wAOORJV
	331YFo7mn5xqeCJW7IW1cXWKYUcNuU6MOMx6hjVipViApc0oQzeN1UF38tmXSjNB2TDxwb
	+vrh/RMOaGtoJVFz5Qo5JCRwemx9z/Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-pFDJ-sc2PjO2sroabirVGQ-1; Tue, 30 Apr 2024 14:06:40 -0400
X-MC-Unique: pFDJ-sc2PjO2sroabirVGQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a51a2113040so285381966b.0
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 11:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714500399; x=1715105199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F5zx7cpE5g24SyrILpVbFuVBHG+ow92d4f3RUXTPOCU=;
        b=HHAqPHbu3F40FSCviMwJAtWI4s3UJOAxS6GFbEEoowJBub7+my1FQQ1UEM0uKwnuqT
         EBZsgdVTbsqHH+m542j2k8nJSZcuXZYZu0uVIo54ERiRdGmm/R7vz2I9qI59Q1Y1a4Kq
         9W0V12o3madzdU1xI6VaD4Kc3sO8BrYNDBNyi7Pfcg/vPF5vh/VUteqQ0dgv0HBhHrl3
         ybyzfVon3halNJFkX1Ol6ZmHlN/GLRyphgtzK5lpU0v9YcMhNfNcz0kZgJ+kBoQHfBnk
         TuuA1CV9WEM76JzNEohsFbWH9aHnsoR2sGFzG9zQU9UCMGfwg8Qdct8qphuVGPbl/CkX
         6bqg==
X-Forwarded-Encrypted: i=1; AJvYcCVPsD3GHG1qUTml7h+pxr1taLc4EgW2Bq1yQfZIwiAGCEL/evlu92s9X6xyRqGrvIQGTARnUvgtTW+iYlFfqaOtbXh+7VJ7
X-Gm-Message-State: AOJu0Yxde6L4RlPlkZyYuoGe+aeoyrgq4ZsCA5ntBJbBBlVQFfsF1qFF
	ZjbkF0ilJjDg+zcijNFLcfCM7C9dWqnxl/Nb/VzXO7CmuFp+oK/YlaTMJHT7i75DDNia+rrr58x
	ir3sXl0HrQfBxLMY+TjSjDZqd48+X0B5ii/6IGDxiJRYDnJeexNcy8w==
X-Received: by 2002:a17:906:dffa:b0:a58:bd8e:f24 with SMTP id lc26-20020a170906dffa00b00a58bd8e0f24mr301832ejc.39.1714500399312;
        Tue, 30 Apr 2024 11:06:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAMU+eVyJELNlfDZqGybmwpL1icWgq7FgiEnNy2tDXnkcVLH1RcMMycitIzluk5myVZUO69Q==
X-Received: by 2002:a17:906:dffa:b0:a58:bd8e:f24 with SMTP id lc26-20020a170906dffa00b00a58bd8e0f24mr301804ejc.39.1714500398788;
        Tue, 30 Apr 2024 11:06:38 -0700 (PDT)
Received: from redhat.com ([2.55.56.94])
        by smtp.gmail.com with ESMTPSA id cd19-20020a170906b35300b00a4673706b4dsm15347234ejb.78.2024.04.30.11.06.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 11:06:38 -0700 (PDT)
Date: Tue, 30 Apr 2024 14:06:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not
 be accessed in vhost_task_fn
Message-ID: <20240430140613-mutt-send-email-mst@kernel.org>
References: <000000000000a9613006174c1c4c@google.com>
 <tencent_4271296B83A6E4413776576946DAB374E305@qq.com>
 <b959b82a-510f-45c0-9e06-acf526c2f4a1@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b959b82a-510f-45c0-9e06-acf526c2f4a1@oracle.com>

On Tue, Apr 30, 2024 at 11:23:04AM -0500, Mike Christie wrote:
> On 4/30/24 8:05 AM, Edward Adam Davis wrote:
> >  static int vhost_task_fn(void *data)
> >  {
> >  	struct vhost_task *vtsk = data;
> > @@ -51,7 +51,7 @@ static int vhost_task_fn(void *data)
> >  			schedule();
> >  	}
> >  
> > -	mutex_lock(&vtsk->exit_mutex);
> > +	mutex_lock(&exit_mutex);
> >  	/*
> >  	 * If a vhost_task_stop and SIGKILL race, we can ignore the SIGKILL.
> >  	 * When the vhost layer has called vhost_task_stop it's already stopped
> > @@ -62,7 +62,7 @@ static int vhost_task_fn(void *data)
> >  		vtsk->handle_sigkill(vtsk->data);
> >  	}
> >  	complete(&vtsk->exited);
> > -	mutex_unlock(&vtsk->exit_mutex);
> > +	mutex_unlock(&exit_mutex);
> >  
> 
> Edward, thanks for the patch. I think though I just needed to swap the
> order of the calls above.
> 
> Instead of:
> 
> complete(&vtsk->exited);
> mutex_unlock(&vtsk->exit_mutex);
> 
> it should have been:
> 
> mutex_unlock(&vtsk->exit_mutex);
> complete(&vtsk->exited);
> 
> If my analysis is correct, then Michael do you want me to resubmit a
> patch on top of your vhost branch or resubmit the entire patchset?

Resubmit all please.

-- 
MST


