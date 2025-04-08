Return-Path: <netdev+bounces-180451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75267A815B8
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9964A7C8C
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29811C2324;
	Tue,  8 Apr 2025 19:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVasnkFq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A33158DD8;
	Tue,  8 Apr 2025 19:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139949; cv=none; b=lDFFaQMCLTvmmSqhN9OvdU9pQvtWeyGB7pwRDp3HdxWu6uOCv9kzIzLudydmcVQGVltsBcNuTBxSs29xKyO4/TcAfbvOL9Oi0IsQDjkfLJLb1FuXhjaEh+ziens/ePjzSKVHI/yGc32KDs2AALNn271j97Otmc7PR2jkjvWYtns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139949; c=relaxed/simple;
	bh=Z55QGbRLyXh0BNT95O/WOaFW70mu8tbGHgzGbF5AXIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLwuVxaWMzBpc+9/4xc/4OSxa1F+iHbqb/SSkK+FLSDZa31nvIKKeGQpkWJQpkUyHTJmqMq7msQKh0aOkX8JYkEjvo9ubox7YHiEkBBgx6CRkwZrdYTGqVKfY3Yw3quAT0WBm7nZPqc7NO+WHC8TRjPBf8hZOTlUllqVVDqN2Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVasnkFq; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5499e3ec54dso7140414e87.0;
        Tue, 08 Apr 2025 12:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744139946; x=1744744746; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z55QGbRLyXh0BNT95O/WOaFW70mu8tbGHgzGbF5AXIA=;
        b=mVasnkFqrh90JXyFyRGGN0/d5cYFWMtNVsy2+ytFcbMZDiojDuwYVrHk6E/ejeyQ+e
         dvOWLOOKlKZBbtSseg8Z+ezGRQn7GTZBCfACQDtDdXqA6eUtcoDTjKEiMOhSLgV+xLkN
         0gIhcxQQ/xefgqr0KccmZM0d6ehCOocX1+nT2+DdfpY3E4AXxsDlvaLRi5yXNFIUIbGb
         2+i+UMHzVqrbDOu+Q61B+kuSXY02dMYoPUXWzB7YkIMUvI9Do9YElJ2kcHsWIKmEt6wH
         Jnohp0q/rb62r66U/vnE7qNPfig8HWV0gjIS3b33phaX2Ub4LfeI/HBC8ASfH1TXHmfa
         +zBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744139946; x=1744744746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z55QGbRLyXh0BNT95O/WOaFW70mu8tbGHgzGbF5AXIA=;
        b=YNW3VdcF+Krs8p2dLakhYEuXiG235OVUvU2rflVg6e8luRjIFDzUlqrBl9SxrFgHQC
         jMlp7QFGmKsRPg/1yDQKcbNnEx2NRqMjfHFVM1F1CarjeWxKRmsSW0YtI8CoOz5UqnvZ
         qsUgwJ089KvRNF/Gf7u5ni++wyVgSnG2PsiFxHWQOSF7oSDJZ33nrXwsOUtXYUXJ45Mh
         5/YjgE8KgiFbDYDfqcTho8/yx3ZytplwJFu6a+OdMZnEkwjwkOlRJ5oWGvaJ0KD1u81J
         4pMoABwJnJrNFr9hwyhYh9h34O2SN+8pTpIOXZYJ5uM+D/b7a8FQ3rsTPljGoz49a8yv
         Y7kw==
X-Forwarded-Encrypted: i=1; AJvYcCWd4zhscXeJV13RIf0BoT2L+MagnUB0vjaqDpWFA+MYzUOftgB9L9H11gOcUEqzUHMcCIYL7zP1@vger.kernel.org, AJvYcCXaKskezEq074+N/wh+ky4l3WGZ1x8jUmMSD2hpwNzJkItelhakeyGGOAcyFc6PRJ1dTFnVHAhMPjwHMng=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7UDpE++NvyKfBSRrwmpWsOi0OgeUxMvzzjU6n8roFXzSu7Hso
	W2RSmJNRc4a+fmrTElJhNvijlVnOGLiih8wYVm5CNzUEjcIiiPqGCNtsjkE5
X-Gm-Gg: ASbGncuCBUyA8+OdznFeEgoGNYP7liEOzjuPd0/ztoKnWU6n3lOghgnsBPY/UjYwRba
	tq1BAFA2Om7u25kEBRzxgbqDuIyag9/eCvvl0NYbNj4rbqjBX7R6fHqkUWa7HlJACAlXobL7HRk
	+74PxwiXpvNVqoFT/bdUO/PEp8DJ/ZR6pDqnuFHfY9nj/+LaxdmYupj51nTWrmX6HRmxZFxHDSn
	TB3/KM9ACZStZy6jjIX2QGcXgBV0DNvRKdhXqd1P4zg3Xt7lY94ZOdLTi7nIWlIzyS9qmXXNi3K
	r0FcmIOw3imNBmTPyYvw9qBID1RHXdS3h3Xa7e1o6jue80dn7qDLeDK7QHM=
X-Google-Smtp-Source: AGHT+IEgKVavQeg/TEvQ6geIqVhJImhsSMiIMg5gKimbMd3xSbQDE8E6s9qc686CvqtJn0PsQ2zUoQ==
X-Received: by 2002:a05:6512:3c8c:b0:549:38eb:d690 with SMTP id 2adb3069b0e04-54c43794f6fmr53713e87.36.1744139945646;
        Tue, 08 Apr 2025 12:19:05 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54c1e5c1f35sm1609968e87.89.2025.04.08.12.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 12:19:05 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
	by home.paul.comp (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTP id 538JJ1ge025001;
	Tue, 8 Apr 2025 22:19:02 +0300
Received: (from paul@localhost)
	by home.paul.comp (8.15.2/8.15.2/Submit) id 538JJ0Wd024999;
	Tue, 8 Apr 2025 22:19:00 +0300
Date: Tue, 8 Apr 2025 22:19:00 +0300
From: Paul Fertser <fercerpav@gmail.com>
To: Hari Kalavakunta <kalavakunta.hari.prasad@gmail.com>
Cc: Sam Mendoza-Jonas <sam@mendozajonas.com>, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        npeacock@meta.com, akozlov@meta.com
Subject: Re: [PATCH net-next 0/2] GCPS Spec Compliance Patch Set
Message-ID: <Z/V2pCKe8N6Uxa0O@home.paul.comp>
References: <cover.1744048182.git.kalavakunta.hari.prasad@gmail.com>
 <ee5feee4-e74a-4dc6-ad8e-42cf9c81cb3c@mendozajonas.com>
 <b1abcf84-e187-468f-a05e-e634e825210c@gmail.com>
 <Z/VqQVGI6oP5oEzB@home.paul.comp>
 <1d570fb8-1da0-4aa6-99f5-052adf559091@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d570fb8-1da0-4aa6-99f5-052adf559091@gmail.com>

On Tue, Apr 08, 2025 at 11:53:47AM -0700, Hari Kalavakunta wrote:
> On 4/8/2025 11:26 AM, Paul Fertser wrote:
> > Can you please add the checks so that we are sure that hardware,
> > software and the specification all match after your fixes?
>
> Sure, I can give a try. Could you please provide an example or guideline
> that I can use as a reference for proper alignment?

Well, there's ncsi_validate_rsp_pkt() and also some handlers use
netdev_warn() or netdev_err() as appropriate and in any case they do
not try to use the returned data if it didn't pass validation and
return an error instead.

> > Also, please do provide the example counter values read from real
> > hardware (even if they're not yet exposed properly you can still
> > obtain them with some hack; don't forget to mention what network card
> > they were read from).
>
> Our verification process is centered on confirming that the counter values
> are accurately populated within the ncsi_channel_stats struct, specifically
> in the ncsi_rsp_handler_gcps function. This verification is conducted using
> synthesized statistics, rather than actual data from a network card. Sure, I
> will provide NCSI packet capture showing the synthesized data used for
> testing by end of the day.

In other words, you're testing your code only with simulated data so
there's no way to guarantee it's going to work on any real life
hardware (as we know hardware doesn't always exactly match the specs)?
That's unsettling. Please do mention it in the commit log, it's an
essential point. Better yet, consider going a bit off-centre after the
regular verification and do a control run on real hardware.

After all, that's what the code is for so if it all possible it's
better to know if it does the actual job before merging (to avoid
noise from follow-up patches like yours which fix something that never
worked because it was never tested).

