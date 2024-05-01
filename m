Return-Path: <netdev+bounces-92703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2938B856D
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 07:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A841F23BE4
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 05:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E03C4AEEF;
	Wed,  1 May 2024 05:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgggTyHR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1CB4A99C
	for <netdev@vger.kernel.org>; Wed,  1 May 2024 05:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714542750; cv=none; b=hiz9ODHC45CBQXZhn7hh84Pn7HveQaQ8+rpIW00V2tqx03aPD5RIkYcKJZ4tvPTddF8dMCq7fB5lOqoJyYV1vIGuzIQn00FGcbptuUyINowj8ejtuVNR81a/drtLxjKENnN2sOMq6GYIxfI3xzNdQDiShD2NpD5wpIpMh2WQ3/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714542750; c=relaxed/simple;
	bh=1nSr9Dg9aeCD6ofDp9t4KN3z2l/uZPlh2laVEmngj3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcNrgHdWHSNYtsUp6s3A7/PGp5kZ93tJNE2C2KccurQEte8oow0XGdqRSEEBKdTlDfbocWQU6IJ8UF4XInjIFMe2A2lMMhHgGDILrqT5lM7MoLslsCfIMPBgZS0MuoBTIc5anZ0ZZE5DVs9fTL03vRtVJskiUBgOV/vPKUNEdPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KgggTyHR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714542747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=20n5h1sY1heSuCVbLnxOhUJlUUXIFUfl98aiHfNTEi0=;
	b=KgggTyHRzAKqZ9Y8Gi4ttVL/P6vHXoVfAXp0PGdGMqVIt6y/Q/lBHvVwq/nOI/q0+l58PE
	AyF/h586lJKWasW+ajeIA3AjS6Q/UdZygOSqjvhcFbx/f7pZTiBHJ/6/MwHZC7g8WFPHaJ
	2H42jnJG1fLsuvyx0yWEAkf5Fool1BA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-YBffKjEyNsGj69LfsmwK2w-1; Wed, 01 May 2024 01:52:26 -0400
X-MC-Unique: YBffKjEyNsGj69LfsmwK2w-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a5563ef10d4so408567966b.2
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 22:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714542744; x=1715147544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=20n5h1sY1heSuCVbLnxOhUJlUUXIFUfl98aiHfNTEi0=;
        b=TggBLF9TIvYflHFlFW+nF1s0GR2fvmivNSUYgNf/1mVdqLcsD67rYLMGaOIHgAzdB4
         cIPC2KxfeqUrdj+tj9baPoDpRR+DCCmRT9IBTQ3PRjuJmsEvg2X/6hDgwmRMSL1QY+mP
         Q6swRwoAvhZ7h3/QZqfV0JEIvE0m+b48CExboP4EZbNxibXb0QVgL5q/hwrBlsRBBMFS
         ZLvE3eowg9ftAr7mygVggkPi/zQ3vex0QOrajVTQ9NYRD5IQVsupHGLDCvb1j63iDPsI
         PugOPJIBqyjtzwal/hQh5myvVF0ES6N8IgAOgobk52YCu0wmONQBvOV4zTc+5YNoZsmJ
         5CEg==
X-Forwarded-Encrypted: i=1; AJvYcCUcr41Rdm2wWUdSxjLUVUXGGaYLDCnWeqN1DCWaqm8v2WKk3wQJdPO1c3efT0w6cB1XhJQae3fP21K2Ssgmx6g0KeuSW5yx
X-Gm-Message-State: AOJu0YxjecWZgcHxXUsVHvDZD+DavT8kO9cs2PRN/ETMtKWAMl8sLk9k
	gMRgeUOjgoxSkCQtRapSDZy2GQnQw24YwHi8OmTnPv/YMxYhK9IEADd5OHyqxvYe/CDn8nfX8ip
	WtoBkSit/J8rkoojtdIeH9Th/w6Jfj2Qacx+CzmJLmVKCeOB41xcvCBPMeNDExw==
X-Received: by 2002:a17:906:a24e:b0:a58:866a:1e80 with SMTP id bi14-20020a170906a24e00b00a58866a1e80mr991889ejb.36.1714542743903;
        Tue, 30 Apr 2024 22:52:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBGvs60kCUCPWvX1cwlAhol2+CkeL02isqut8YkmaCVV+Z+zcH4uvAU7Plv220noZVfxO0rg==
X-Received: by 2002:a17:906:a24e:b0:a58:866a:1e80 with SMTP id bi14-20020a170906a24e00b00a58866a1e80mr991871ejb.36.1714542743405;
        Tue, 30 Apr 2024 22:52:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:346:6a42:bb79:449b:3f0b:a228])
        by smtp.gmail.com with ESMTPSA id ld4-20020a170906f94400b00a5906d14c31sm2821481ejb.64.2024.04.30.22.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 22:52:22 -0700 (PDT)
Date: Wed, 1 May 2024 01:52:16 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: Hillf Danton <hdanton@sina.com>, Edward Adam Davis <eadavis@qq.com>,
	syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com,
	jasowang@redhat.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, virtualization@lists.linux.dev
Subject: Re: [PATCH next] vhost_task: after freeing vhost_task it should not
 be accessed in vhost_task_fn
Message-ID: <20240501014753-mutt-send-email-mst@kernel.org>
References: <20240501001544.1606-1-hdanton@sina.com>
 <59d61db8-8d3a-44f1-b664-d4649615afc7@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d61db8-8d3a-44f1-b664-d4649615afc7@oracle.com>

On Tue, Apr 30, 2024 at 08:01:11PM -0500, Mike Christie wrote:
> On 4/30/24 7:15 PM, Hillf Danton wrote:
> > On Tue, Apr 30, 2024 at 11:23:04AM -0500, Mike Christie wrote:
> >> On 4/30/24 8:05 AM, Edward Adam Davis wrote:
> >>>  static int vhost_task_fn(void *data)
> >>>  {
> >>>  	struct vhost_task *vtsk = data;
> >>> @@ -51,7 +51,7 @@ static int vhost_task_fn(void *data)
> >>>  			schedule();
> >>>  	}
> >>>  
> >>> -	mutex_lock(&vtsk->exit_mutex);
> >>> +	mutex_lock(&exit_mutex);
> >>>  	/*
> >>>  	 * If a vhost_task_stop and SIGKILL race, we can ignore the SIGKILL.
> >>>  	 * When the vhost layer has called vhost_task_stop it's already stopped
> >>> @@ -62,7 +62,7 @@ static int vhost_task_fn(void *data)
> >>>  		vtsk->handle_sigkill(vtsk->data);
> >>>  	}
> >>>  	complete(&vtsk->exited);
> >>> -	mutex_unlock(&vtsk->exit_mutex);
> >>> +	mutex_unlock(&exit_mutex);
> >>>  
> >>
> >> Edward, thanks for the patch. I think though I just needed to swap the
> >> order of the calls above.
> >>
> >> Instead of:
> >>
> >> complete(&vtsk->exited);
> >> mutex_unlock(&vtsk->exit_mutex);
> >>
> >> it should have been:
> >>
> >> mutex_unlock(&vtsk->exit_mutex);
> >> complete(&vtsk->exited);
> > 
> > JFYI Edward did it [1]
> > 
> > [1] https://lore.kernel.org/lkml/tencent_546DA49414E876EEBECF2C78D26D242EE50A@qq.com/
> 
> Thanks.
> 
> I tested the code with that change and it no longer triggers the UAF.

Weird but syzcaller said that yes it triggers.

Compare
000000000000dcc0ca06174e65d4@google.com
which tests the order
	mutex_unlock(&vtsk->exit_mutex);
	complete(&vtsk->exited);
that you like and says it triggers

and
00000000000097bda906175219bc@google.com
which says it does not trigger.

Whatever you do please send it to syzcaller in the original
thread and then when you post please include the syzcaller report.

Given this gets confusing I'm fine with just a fixup patch,
and note in the commit log where I should squash it.


> I've fixed up the original patch that had the bug and am going to
> resubmit the patchset like how Michael requested.
> 


