Return-Path: <netdev+bounces-186722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FA7AA08F2
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8544678B1
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AE52BE7C8;
	Tue, 29 Apr 2025 10:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFmEnN0t"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70125291F
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924162; cv=none; b=Hupyb5+393kfkYS1fbOct5GWEC8f+mTRKkIO7CMaDt+ZVlGQ3RqORrmw3b3RsZG4R1BVQronjevqCIuKuq1/BdmnzMQtGJqaxSKu5ufltWWl4WgUj6K/nPPyzVfZ2armznfyuopVChZkmntREJBSn3F727Ur2lhhERtfPRo0wf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924162; c=relaxed/simple;
	bh=2XOsrJ9QxJ2xmMD7aI3JwMzLwhIcEOOkFjqywzEOBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ewKZMHwn/HqiB0nIilI7LB00fnXH9MzX6lq6tYdSoJ5qFC37xhyooB0IMswvLqHg324LkQ26unPNKFWxAx7cRx42rQwQRsVhY91p/xdTrVj4aQVkI8yslQScfzIeZ4MFfbzSaYvOyVOC3tsHy/cJ7fYXsXnqUraFkTFqNC7ueOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFmEnN0t; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745924159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=19RTGAYgSCXwR1/QnePt6pjSqRpqNVt5Z/wpug3TfME=;
	b=CFmEnN0tx48xOF29CTLyNjnpLmCOW+ztzbOGM5ICNbzkTVok9q1VCtBIKox4lK+BmzgPUb
	BvxTI73tRli4dnnAqTnbRApJy122VvXss7HUMJiEVpnw7093G1DYyQ0QzEktBmWumgOU41
	gZy3OpUeISetbUItPCqskN0VA0iazMs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-r_036stYPAqn1FPnbzk4aA-1; Tue, 29 Apr 2025 06:55:58 -0400
X-MC-Unique: r_036stYPAqn1FPnbzk4aA-1
X-Mimecast-MFC-AGG-ID: r_036stYPAqn1FPnbzk4aA_1745924157
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43f251dc364so31732435e9.2
        for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 03:55:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745924157; x=1746528957;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=19RTGAYgSCXwR1/QnePt6pjSqRpqNVt5Z/wpug3TfME=;
        b=IkcRsj+hAfLto/36JtX1p5/3ydvSQHm/RzkF0WHdUOEqrnIo8TwGC2yTf4GnOpGbcD
         A9quPfaz11kKGGlDWATl9pRvEyTLAL9HQmm1My4Vo5ug1ut08Ifmdn/pFd8mcAlbamPm
         kYKBNjVNiDOXdRku2qp8KbQxJbl8q6viqXjK3/T6491QuB65XvFjU/k6EwzySFABJtsh
         5qznIlVn2aTVqrSTHwYW8oJr1SWPMYf2cjvXBCRwiy57fVUV/7yFSagpH8Dq7IrdDeBJ
         pgY2ImrqiPK0EPOBB0OKHOewqwBnLaACMCKfRrRNIoXVy4u+MsYGX3EXes3P0qNeiQw+
         zH8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdZ5NvMkcX3h8ZJye16OyZxz8y8CJIkDccSFPdFh5RVw48UkpGW6y+bdKokw/h76l9FVxhRQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YztTm/bmMD11rwO1T5mbS4ZnqE0IdOekFep3XpWaX7UzMud95Cv
	aTQ2AxjckmN37q5/SeTwcyOBqG4+1IVa0T7J40ZYLzw5HyGfrWxzugmmiIN22vUyojWQIC5w4ho
	QWC6VjtDGZKgsXqMjbTBmtAGmwIEsYO9BSp7Fr0slaeHjCoj0AemPAA==
X-Gm-Gg: ASbGncsgB+JjX1nDB2RRitX57QbS2KTOQWNa1nArmnKWx0Y8ZgZPF/EXmsn8ieNxPl9
	HhqHeT6t8+W+w2uBDUxPtfwgs4L8Pqg4hcvMViHAIP8/hxpnsJqdpnVNcQWVkfng3JHcPK6FqXd
	m05z6G4AnzU6+mliZYDz8FqAkuoewVumsfP3ktqOadtudznPYOcUNCtFK6p0Iv6uQVcQy7Cf4sE
	UChvNcIGKdF4aQ1SkMYjw54LVm0z12I1SAcUn4iPSbk5TXefIHTsYq0pzSbZOqq7RoAbkFFDuFQ
	yN+XSg==
X-Received: by 2002:a05:600c:384a:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-441ac85cfffmr30415205e9.17.1745924156957;
        Tue, 29 Apr 2025 03:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNHhPyQF+kfEhHY8Rir1hFUnKPAus/tT9SNHKVUQOtQwHP4Id2+yIhepQRoyIXOCX/07G8ZQ==
X-Received: by 2002:a05:600c:384a:b0:43d:160:cd9e with SMTP id 5b1f17b1804b1-441ac85cfffmr30414975e9.17.1745924156638;
        Tue, 29 Apr 2025 03:55:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a536a1ddsm154027115e9.30.2025.04.29.03.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 03:55:55 -0700 (PDT)
Date: Tue, 29 Apr 2025 06:55:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Cindy Lu <lulu@redhat.com>, michael.christie@oracle.com,
	sgarzare@redhat.com, linux-kernel@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Subject: Re: [PATCH v9 4/4] vhost: Add a KConfig knob to enable IOCTL
 VHOST_FORK_FROM_OWNER
Message-ID: <20250429065044-mutt-send-email-mst@kernel.org>
References: <20250421024457.112163-1-lulu@redhat.com>
 <20250421024457.112163-5-lulu@redhat.com>
 <CACGkMEt-ewTqeHDMq847WDEGiW+x-TEPG6GTDDUbayVmuiVvzg@mail.gmail.com>
 <CACGkMEte6Lobr+tFM9ZmrDWYOpMtN6Xy=rzvTy=YxSPkHaVdPA@mail.gmail.com>
 <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEstbCKdHahYE6cXXu1kvFxiVGoBw3sr4aGs4=MiDE4azg@mail.gmail.com>

On Tue, Apr 29, 2025 at 11:39:37AM +0800, Jason Wang wrote:
> On Mon, Apr 21, 2025 at 11:46 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Mon, Apr 21, 2025 at 11:45 AM Jason Wang <jasowang@redhat.com> wrote:
> > >
> > > On Mon, Apr 21, 2025 at 10:45 AM Cindy Lu <lulu@redhat.com> wrote:
> > > >
> > > > Introduce a new config knob `CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL`,
> > > > to control the availability of the `VHOST_FORK_FROM_OWNER` ioctl.
> > > > When CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL is set to n, the ioctl
> > > > is disabled, and any attempt to use it will result in failure.
> > >
> > > I think we need to describe why the default value was chosen to be false.
> > >
> > > What's more, should we document the implications here?
> > >
> > > inherit_owner was set to false: this means "legacy" userspace may
> >
> > I meant "true" actually.
> 
> MIchael, I'd expect inherit_owner to be false. Otherwise legacy
> applications need to be modified in order to get the behaviour
> recovered which is an impossible taks.
> 
> Any idea on this?
> 
> Thanks

At this point, as we changed the behaviour, we have two types of legacy applications
- ones expecting inherit_owner false
- ones expecting inherit_owner true

Whatever we do, some of these will have to be changed.
Given current
kernel has it as true, and given it is a cleaner behaviour that will
keep working when we disable CONFIG_VHOST_ENABLE_FORK_OWNER_IOCTL in 10
years, I think it's the better default.
If you want to change it transparently, look for ways to
distinguish between the two types.

The application in question is qemu, is it not?
I do not see how sticking an ioctl call into its source is such
a big deal, if this is what we want to do.
A bit of short term pain but we get clear maintainable semantics.

-- 
MST


