Return-Path: <netdev+bounces-208246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE85B0AB48
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:12:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8755858B2
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86C6421B9C0;
	Fri, 18 Jul 2025 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="n86ElkGe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D448D18E20
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 21:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873119; cv=none; b=LB2aXuNPt/1q8aTYkMq9AtqrForZcjjw40QVHeviveor5TnJzAVSbnrX9kFVG8LEN+QqlhcvOi0iZoV3kwiwvPNZVDB0VR42ZXzk0O1awaPDkF9AGE0QfCXQ5HOwQX7vDkYearVE+XYcikqzo37b6uzLVd8bHMo7uzVaTxih9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873119; c=relaxed/simple;
	bh=9bTPe6SjZ3jLIqNkPUPfmSBatq1Y/VPwjmEPS76vlGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rPoK6RErPihzEFlfSEdx7Egzif9SqjlNuACxYM1SrCA7Mg+K4x4m5i8fu7wGMU2oPhf4QSaRXk9uvNB//ZgOFRIl6A5gy2VdNvfx+0bD/YMwXMvA/mqbxIdldEEpEkCrhtqgaMhr1t9Mip6zzMJ50mgnAfxML+F/K5aRRtThiFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=n86ElkGe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-73972a54919so2631464b3a.3
        for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 14:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752873117; x=1753477917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QCHEV+1PYeOUmt6doq7l7hxADEu0gnCQxMGvLSxACus=;
        b=n86ElkGeF8X3l15/IAOTlBdZVIzhGA67XEZCv3ychNpy3aWs37qeRCj1IBH/WEgH/k
         EPWBKqCP5eJPvjanXo6iCLtzoRxLu0N8qIcAOTZ/rnjIacxp5NiDyeYZeiS0V7fLVCf+
         GQ/jFo7x0hn1cqOWoL8V2vu9AyW1+nFlDxI+F8xhbY+4zryv6DjheIqHP2UVAbMb9sXL
         1iIwoJBjYXy0M5NMf814bvQ7c6D8ujNHX0L127hMZrD7mxgUCbLPr38N5xELk8TxflMa
         yc5KLG9D97Xdp1tV3ZRKmDhVYJf85ecWHrEhRwFXnjLFUtOa9tSywWlcgl3OGjHGMj7j
         lUFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873117; x=1753477917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCHEV+1PYeOUmt6doq7l7hxADEu0gnCQxMGvLSxACus=;
        b=O9A9JoUEofOOx1DA5yilC5P1jyAsMFdqHNNtWerL5vpIZ8Qn5T6kBG8PMbqAeSACWY
         MDPVlu1PzinDDyfvelh+mxlmqCPYWTX6EK2LVaWa4TZBVzN82pwF47zMPY9Tdp0xrsol
         OrxmP2FbG5GX5B965syNqifacCMe4jPLAzo3Nu0Wj4ueWuwxhUHiYcN03mZGwsOTbIxf
         wSSnsSd/3u5gkjRncZfvdX4mpfxrMuteZIJF403MxOirjl1qP75MDvJUp4rwDW25PLCo
         gxAvz20c694rhrL7wj60zTIIqcA1rq4KS413mMO+PxhUhXlCMihH+5hP6zXbVfkmNOK0
         gQQw==
X-Forwarded-Encrypted: i=1; AJvYcCV+C/UdiC8e77ktgzgU1RGnAag1eqiPcXmPs6yoLLG8F+LwOls5+6IrHpRxs9yTnLEFwhHTg/U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4gYKYEuDXMi4pN/K8D69fH219WEtNtwU7Ir5haGdiyc8LWEND
	ZkWNMmlawVuEIg175f9jzGVWtVj16YJsvWpqF9W03ewj0WLr5ByS7VN3TwjOUiyQC+8Fej7Z1Sr
	0VAQ=
X-Gm-Gg: ASbGncsgUihiMbZJi6SoPky1irIOADeNStqh5rIACbunrUuBgnNfldTyfkAja6pxXh8
	p1CBs+vAB3QnJp00sw4dRw+widUPNSf35DIouwgoCKbkhjfROAKpYHaIfGNXFD1T3Lk1zbInqUp
	JYHtnMWBom7HkSzSqkaltiMoU1aLxpvKgM9GPk6AZCKPlPRXxOB4pqqJzP3wPB066+m/rRLQY39
	fXWImJzuVBykyjDEaK+m/SI7eYOSD2VeHL3Fpun9ftvmzJZi9lvMHplNzfsyCF/3izPqzaS81e+
	gzOELLo1QzY3MtjQ2K8xUIZffAMFHDVTR3upkC+hbjusFrEBD1e6DRmjOKd5AKjP/aq8FLdaAfq
	qQ3r9wGqpBOBEMuzpDdftKffz+IS6soID
X-Google-Smtp-Source: AGHT+IH8dfewy5f1gZTq/xr8JBjOJT1B813I/tYVut00hs4VR9yAUz1qXKLhEWcETA88a1nO8dHHiQ==
X-Received: by 2002:a05:6a21:a344:b0:220:10e5:825d with SMTP id adf61e73a8af0-23810e50fe4mr18661180637.8.1752873117052;
        Fri, 18 Jul 2025 14:11:57 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb15699esm1766876b3a.82.2025.07.18.14.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:11:56 -0700 (PDT)
Date: Fri, 18 Jul 2025 14:11:54 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org
Subject: Re: [PATCH v1] net/sched: sch_qfq: Avoid triggering might_sleep in
 atomic context in qfq_delete_class
Message-ID: <aHq4miMTk5fyuYIf@xps>
References: <20250717230128.159766-1-xmei5@asu.edu>
 <01463f6f-a45b-4122-a7cf-8fbf7889fd48@suswa.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01463f6f-a45b-4122-a7cf-8fbf7889fd48@suswa.mountain>

On Fri, Jul 18, 2025 at 10:43:22PM +0300, Dan Carpenter wrote:
> On Thu, Jul 17, 2025 at 04:01:28PM -0700, Xiang Mei wrote:
> > might_sleep could be trigger in the atomic context in qfq_delete_class.
> > 
> > qfq_destroy_class was moved into atomic context locked
> > by sch_tree_lock to avoid a race condition bug on
> > qfq_aggregate. However, might_sleep could be triggered by
> > qfq_destroy_class, which introduced sleeping in atomic context (path:
> > qfq_destroy_class->qdisc_put->__qdisc_destroy->lockdep_unregister_key
> > ->might_sleep).
> > 
> > Considering the race is on the qfq_aggregate objects, keeping
> > qfq_rm_from_agg in the lock but moving the left part out can solve
> > this issue.
> > 
> > Fixes: 5e28d5a3f774 ("net/sched: sch_qfq: Fix race condition on qfq_aggregate")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Link: https://patch.msgid.link/4a04e0cc-a64b-44e7-9213-2880ed641d77@sabinyo.mountain
> > ---
> > v1: Avoid might_sleep in atomic context
> 
> No need for this line on the first version of a patch.  It's just to
> track changes between versions.
> 
> Anyway, looks good.  Thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> regards,
> dan carpenter
> 
>
Thanks so much for the tip and both of your reviews.

