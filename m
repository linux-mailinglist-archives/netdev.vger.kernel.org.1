Return-Path: <netdev+bounces-224530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81062B85E97
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 18:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8600166BC7
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390E7314D30;
	Thu, 18 Sep 2025 16:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z00fLP9K"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537F314B64
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758211699; cv=none; b=cOPUzZ7hDHrsffrB6INs/7H5O2rsO8tJ5Cp3aUeovgiDNKuYCMshBqcQIMIfWszv7nt4l+e0dJB3J6GNh0A0h5F8dt5nIAzZxS25ouLMuvSoBlE3ji72AD12/X5Ock1pmq9fywh2iLLEGPYA3rjSDtWPvpsY9Gmz0WYov1HOeXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758211699; c=relaxed/simple;
	bh=JL/qBQ0n0kWZf+AaO8KDJFGjeMqMIUgMtsxBe3k+j+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sAl+JteKMDzJ6j+CEDuIaAWQQvD29mMRXYeYzNhLLf+ryxzUz8umRVgwCJUNQIBp1qwjZBVucL6pVdikw4GK1GVJK8V9KIenuFJLPiU9cMbB7qiv2BGu/a3XryqpVA4oTmHwMctqgKvLP+Vo4xMXB3lCSf5BX1As9kEFr/BOadM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Z00fLP9K; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758211696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=q3W1jIekrmUS7hGw0PvTqPX4tAe8HmRxhRJM5xSdG6I=;
	b=Z00fLP9Kjpz3oO2vzrgYpOnLQmcpww8GQPbR3jbGT16ZnxVrfWcAKwqwhY9dudI4GBhVGG
	0U2uJDFtynHk05un5TGVDhqxoNpxq9TVvP8ul/J+QViz4/Z+67AB2Xr0dgzrdxfWWVeMoW
	mykeEq5X0fa89+GINK2LOak0X9DKwIw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-6TsiFaKGPAKlc0i_bon5ug-1; Thu, 18 Sep 2025 12:08:13 -0400
X-MC-Unique: 6TsiFaKGPAKlc0i_bon5ug-1
X-Mimecast-MFC-AGG-ID: 6TsiFaKGPAKlc0i_bon5ug_1758211692
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3ecdf7b5c46so409585f8f.2
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 09:08:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758211692; x=1758816492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3W1jIekrmUS7hGw0PvTqPX4tAe8HmRxhRJM5xSdG6I=;
        b=fP4OQNyqS3YQC7zq6Pt0NUBetyp5jlTOdAwdYUejCxirDEBripDs4XBUm5yJdqFjaR
         a54LnoOQDPdG5wxu0psPtFjKM/hrSlse4TnBeFDR0pQDwKuclgjhMmcNzHQ1yQfb7tGr
         r8wED9J5Bf48QLtFZnmThN75DVXWqyXN0MtBGjIYeR13EU+OZilRZP5XVkvz1tQYZCJY
         //h/BlNGIib8yktPN8EzWLOKHSPLJ5o2ByKpsc4RW/VdbFx7SKFqRPNWoEfkDUgNBnIw
         7WY5p/RM2p8Sa61EOXJEWiIh/VdMUgVMR9g12hQOefkO02aK+fXadtRwcS4vU1P3q3bX
         6gFg==
X-Forwarded-Encrypted: i=1; AJvYcCVZhgJUqOLu4ROu/TJydlPhg6Iv2GjbX3gUdF9GmLS2LcJgdK7xSdFCpdFsgZYoUkcO4OV+ikk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi+7Mu8IQZKIYQHplg+NXlvYMr3qzQsaEYRO+RrCO8ZFCUec9m
	EdgQpOHji/sTvPG3vUGnu4cRLjdgBqv/Aj/k+gzGUJJGGu6yQwdBhsldsiYeyjXO9ya089GXFIF
	Z5fJdNC+kd5536CIZ4AZyl1ELjVaP15xvAUR2zDjXxMzPsfzTRk9fOjU92w==
X-Gm-Gg: ASbGncsTQGhhWMZoZZGMgRTQ1YkUHhCJydHvWedRXQNGwAet1rrNj0KBKzFhYEUxsKX
	zQ9Q+OZKEn6WwZ72oXJQh9YqqCk5AysqEUeO9WAnkhZPzMuieCS6trXL9EHDSKfNoR8ZlnE3Lhy
	LYRqUWXLiiMH/T1LdJBTGsZWNl9MxXITaOR79is3Fxcc53fsr30Kz+PD13XkRDW2z0OZWnyd341
	bn12wdjxG/fzqXP6tSxhT1zF7pO1MbfAv9YmvnXxSPqDsBYxOYxiOkzoHqKrP1+IeddUjl9/7H7
	XF95UE2bzfuDEtfpMePlNYJLkY5/usJBZEg=
X-Received: by 2002:a05:6000:200e:b0:3eb:f90a:f6cd with SMTP id ffacd0b85a97d-3ecdfa3ce7emr7085259f8f.60.1758211692370;
        Thu, 18 Sep 2025 09:08:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFONswKfp43OXLfg7nMNxh+zteAfi3TDzbvWnbk+eZ4aXLcjPUcMbF4AA2QkD6aFfodROyxZA==
X-Received: by 2002:a05:6000:200e:b0:3eb:f90a:f6cd with SMTP id ffacd0b85a97d-3ecdfa3ce7emr7085210f8f.60.1758211691864;
        Thu, 18 Sep 2025 09:08:11 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73e7:4d00:2294:2331:c6cf:2fde])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee106fd0edsm3919680f8f.53.2025.09.18.09.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:08:11 -0700 (PDT)
Date: Thu, 18 Sep 2025 12:08:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sean Christopherson <seanjc@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Jason Wang <jasowang@redhat.com>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] vhost_task: Fix a bug where KVM wakes an exited
 task
Message-ID: <20250918120658-mutt-send-email-mst@kernel.org>
References: <20250827194107.4142164-1-seanjc@google.com>
 <20250827201059.EmmdDFB_@linutronix.de>
 <20250918110828-mutt-send-email-mst@kernel.org>
 <20250918154826.oUc0cW0Y@linutronix.de>
 <aMwtd40q44q5uqwr@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMwtd40q44q5uqwr@google.com>

On Thu, Sep 18, 2025 at 09:04:07AM -0700, Sean Christopherson wrote:
> On Thu, Sep 18, 2025, Sebastian Andrzej Siewior wrote:
> > On 2025-09-18 11:09:05 [-0400], Michael S. Tsirkin wrote:
> > > So how about switching to this approach then?
> > > Instead of piling up fixes like we seem to do now ...
> 
> I don't have a strong preference for 6.17, beyond landing a fix of some kind.
> I think there are three options for 6.17, in order of "least like to break
> something":
> 
>  1. Sebastian's get_task_struct() fix


I am just a bit apprehensive that we don't create a situation
where we leak the task struct somehow, given the limited
testing time. Can you help me get convinced that risk is 0?

>  2. This series, without the KILLED sanity check in __vhost_task_wake()
>  3. This series, with my fixup (with which syzbot was happy)
> 
> Longer term, I'd still like to land everything though.

No problem with that.

> > > Sean?
> > 
> > Since I am in To: here. You want me to resent my diff as a proper patch?
> 
> Ya, I think it makes sense to harden against UAF even if we fix the KVM bug more
> directly.


