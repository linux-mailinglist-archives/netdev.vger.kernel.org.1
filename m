Return-Path: <netdev+bounces-187131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C61FDAA521E
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 18:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98D421BC1D52
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 16:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803472641E3;
	Wed, 30 Apr 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="RIIokNeC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EFF1D7984
	for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746032016; cv=none; b=cFfUe3NAe3/YOGFTN9sEDsGgXf1sibKuuJQmFI3EoCgVepT2Xulpm9S9wHTRhpZLnrFSRqLZQpslD+53R0FjxIlCyTpv52ElmMC5TVr+U2FMdmR2qcTEdScs3crg55TbZzWPmrQh8R6zZQ+R/88IQ0DQAs6AeaEjqhulpumNd38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746032016; c=relaxed/simple;
	bh=KLmuA2sXWxeYzvZaSBT1OXio9W3Wqg/uWe8O5Z2jE1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RlM+/0DRpzeZ1M1iEh97qSdL0I4XBYAyS7B5TKT53+WSBuMd+IEbMUrSPHnYHCeuJnu/vZKJhXn0EmpyLAbqwFJw0g+BFmXZDgYUKFzB20MQdoCN37vWCn0DHC0502IC25Do7wVVt4XsO9vYDjV40+trdEVpnOHv4QTJ3KBaayg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=RIIokNeC; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-73712952e1cso147835b3a.1
        for <netdev@vger.kernel.org>; Wed, 30 Apr 2025 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1746032014; x=1746636814; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lb1G8E4eXsJcf046Vl0RQBeGECFD75fJKtaKk5HRkJE=;
        b=RIIokNeCdGgf/PqWdeA88hmg+3qHAn0/Hu7EohQ71mwyV3yvCSWcW29XXQa3+HJUqU
         XIOTQdIILBCvb46L/m9IEPc5YTGVDherzFFspVZ4WciTWCgNZ0vjgPVD1D7H0C28/zZu
         Cs/a34q6MniGLZ/7tnBngUP/VoUhqUdmD+/Ts=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746032014; x=1746636814;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lb1G8E4eXsJcf046Vl0RQBeGECFD75fJKtaKk5HRkJE=;
        b=ZVXbJJXvi2FcnAV3QH+TNhhd6HgUsCD49pioiuBGYhKXCyP5+tgnwtOQKDFjaRWmDU
         u5jgg4DkbrGn72ARHPfZ8/d567G7DAFPcYhZ5+cSGWasmskrn8/NFPFUMESV3Z5Sa5Dd
         UXz0Fi4jAzCp2z2CwiBujMpEXuZrCtXMCQHoE8urQLDiZ/j6MhtABEzxrrywBWVzp+1g
         c+1FJnxBO6AJV3hFg076UdGLjBq+3/J+ozrTnY1p5QTHYUXmBRjvCWCv2oa2X75OvEEJ
         aYa/VoXgf0EEBUkTMmKShm0UHLtSSxvB5kCd9iTem6+T/mV9wnEuDX4cWEybAMUQUXFO
         k9jw==
X-Forwarded-Encrypted: i=1; AJvYcCUbNtJlHAExIOT7S09zFAvAFkK8qejeWBySQZwOobPwMxb+lUrMyxjS/sY5mgY+0N1aqPzosoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJsuE0kShG38BPRPm5HQ6/dKKZnfDZt4iwjXX3i44FE+t8PDlM
	Myr7zjVjvalzNirF7Vy/kbvSE1ArcB4I5JKiHX81Iq59NzY+NYE1YSbT0MJ6n+I=
X-Gm-Gg: ASbGncvdQwFNwUOSSUji5DC0fRm0fBCNWAi8mAVLqe6V5rsja9SwNKHa5DZP4aFVajq
	OrShaA1Efx0TRoHeWLuSmceomcyxEydhq06ybKr5mrYZuj6Uq2jkX2tgnpuWB+fRlyqT92tH48O
	wWDbIg8nd9+RCsNklnS+hF3u4GMo1JhqF15gwU/abCwhvztBTe2BGTJozDCmvDSVOxHhEgm8Fbp
	dxlXKSHXdD9WPM3s6mM+THvHAalAaoayw4Nh3S/FAHpA9Wkh9WTyBn2c5W83vsKqoFqkg0yvisI
	THhLyIPzNLWuvL3sUxxfdUm84yoQgzsgYlPTK+teE0zji6a6F4QRtu1sMTg6QFd2d0oXlv+mhCX
	ywXjWwKg=
X-Google-Smtp-Source: AGHT+IHVrN7jDRElfevrLfPVr8B/9yKIO4w3xiNQiHtti3lP8Hy9IlcVEfHCgXSCmpVIo5BipxuPYw==
X-Received: by 2002:a05:6a00:4b05:b0:736:ff65:3fcc with SMTP id d2e1a72fcca58-7403a811bbfmr5175385b3a.16.1746032014058;
        Wed, 30 Apr 2025 09:53:34 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-740398f975fsm1896375b3a.6.2025.04.30.09.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 09:53:33 -0700 (PDT)
Date: Wed, 30 Apr 2025 09:53:31 -0700
From: Joe Damato <jdamato@fastly.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6] Add support to set napi threaded for
 individual napi
Message-ID: <aBJVi0LmwqAtQxv_@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	almasrymina@google.com, willemb@google.com, mkarsten@uwaterloo.ca,
	netdev@vger.kernel.org
References: <20250429222656.936279-1-skhawaja@google.com>
 <aBFnU2Gs0nRZbaKw@LQ3V64L9R2>
 <CAAywjhQZDd2rJiF35iyYqMd86zzgDbLVinfEcva0b1=6tne3Pg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAywjhQZDd2rJiF35iyYqMd86zzgDbLVinfEcva0b1=6tne3Pg@mail.gmail.com>

On Tue, Apr 29, 2025 at 06:16:29PM -0700, Samiullah Khawaja wrote:
> On Tue, Apr 29, 2025 at 4:57 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Tue, Apr 29, 2025 at 10:26:56PM +0000, Samiullah Khawaja wrote:
> >
> > > v6:
> > >  - Set the threaded property at device level even if the currently set
> > >    value is same. This is to override any per napi settings. Update
> > >    selftest to verify this scenario.
> > >  - Use u8 instead of uint in netdev_nl_napi_set_config implementation.
> > >  - Extend the selftest to verify the existing behaviour that the PID
> > >    stays valid once threaded napi is enabled. It stays valid even after
> > >    disabling the threaded napi. Also verify that the same kthread(PID)
> > >    is reused when threaded napi is enabled again. Will keep this
> > >    behaviour as based on the discussion on v5.
> >
> > This doesn't address the feedback from Jakub in the v5 [1] [2]:
> >
> >  - Jakub said the netlink attributes need to make sense from day 1.
> >    Threaded = 0 and pid = 1234 does not make sense, and
> Jakub mentioned following in v5 and that is the existing behaviour:
> ```
> That part I think needs to stay as is, the thread can be started and
> stopped on napi_add / del, IMO.
> ```
> Please see my reply to him in v5 also to confirm this. I also quoted
> the original reason, when this was added, behind not doing
> kthread_stop when unsetting napi threaded.

Here's what [2] says:

  We need to handle the case Joe pointed out. The new Netlink attributes
  must make sense from day 1. I think it will be cleanest to work on
  killing the thread first, but it can be a separate series.

In this v6 as I understand it, it is possible to get:

    threaded = 0
    pid = 1234

I don't think that makes sense and it goes against my interpretation
of Jakub's message which seemed clear to me that this must be fixed.

If you disagree and think my interpretation of what Jakub said
is off, we can let him weigh in again.

> >
> >  - The thread should be started and stopped.
> >
> > [1]: https://lore.kernel.org/netdev/20250425201220.58bf25d7@kernel.org/
> > [2]: https://lore.kernel.org/netdev/20250428112306.62ff198b@kernel.org/

