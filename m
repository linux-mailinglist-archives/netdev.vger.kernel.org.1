Return-Path: <netdev+bounces-205958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18295B00EC6
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 00:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F3611C2520A
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 22:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1E629993F;
	Thu, 10 Jul 2025 22:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="nKQcGvzW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777844C97
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 22:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187118; cv=none; b=B9/BSTVfBmOMQOqyiiVy5r2vhKubXt+YXKaC8VTvMrjCiSKTwXZCc5u+Cma5V5Chs2CX4EgDn8dR9736e1wo0iecDJo5rh/jXv9vvwfFjEzGTJ1VGq8pxZPNh8/Nskd+7BDclQJmMGi5xHIqnrpk0lBIsfg64WVByoVkF7lXHJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187118; c=relaxed/simple;
	bh=VupC+nL43BCvd5oQ+k3HBdR7FfN/oUjWR+5uxbiiw5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HffBkjepO6C39SUHqyQCSAWEpAOu0AqB/7NaOdc4sCHwJuk5AqrNozrqZlLerkrcAOJZcGVngvR8zw/qR+AiwDiUMRqO3ZK2iRWt3XlODOmByz6gk+1FcBL6d6wddeE3/+dlRBo4DtG/aFQ9UA6DpAMIOR775RLO7T5elJaMOlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=nKQcGvzW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-749068b9b63so1068877b3a.0
        for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 15:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1752187117; x=1752791917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tv0vkcbAD6FrX5YWgdYd6AHaQT099MeLpCfqw6bkmsQ=;
        b=nKQcGvzWUvshC2EVoxaBbXnUQHQlrYU6yciyiTdwQTTQRjOhAuaHakPlI9RTPeOD6g
         2xSiZdPRFOzDM4yToQDJ0MNX2bSj8yvbvK3y2Hqs65frlQr/b4c01dD6Ae7g0Ble+vq3
         WHBKF4bD7U90FP5fgrwkLegzOIFDyXUyv48CqbkYXTYKFU3xdWHzdqFj+0vetVh4IJWe
         Fqf7Yynoa2zh/+/8C/XnaAlKlgH3kPGEFmYDuU4uqz7cFqmQzt/yCwij4Qqd8HSKbU6c
         Q4Fb2JR0kz2EaQDLXHWQO8wwQpVZP+PMDf4qlok23EJy4znAUU3eEVZ1zcRJK8idM2TE
         QUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187117; x=1752791917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tv0vkcbAD6FrX5YWgdYd6AHaQT099MeLpCfqw6bkmsQ=;
        b=LbBo/Q3czl+zN1PF4lzuLlNeRPgHykyA5xiw9MBjB429SbloezA906p1SjGUHuzh36
         LNEbkfZmhzFfyI0hbDfwzwRSiDX7UG3tv59UBbspZx3jo5SdL/cc/mgmAFOebjrrFY2A
         FA13VbaikJOqHHjwKb7WmThbFUM/97e6Mm19VIy8WoBH9DjUJksjVDhaNWM7TU4qRlAA
         DmLXY2DPVS0ti48rTPduQQgqeHqO2+yORDL7FJ8s/gXxaXTVL28aCyKSs0jxDIFly0Pc
         Ff48ymBsQtnROmIOrHsOZzf3QgUaa++9YI6C2xP3YynzIiz7QJ4Cw6VH7xdCJoipm9WL
         nMUQ==
X-Gm-Message-State: AOJu0Yyzfl8YDQswK+PWrVGMUocKZP9hx4P5aW2/YtHfhLgBkJyMKJn9
	jG6sMnYpmQEjskZTI+geZqmArG/8B6uOcgmfZ5MeHZepkU9H8bHZ8JcyE9i/a9e8dMYH+OtVmS1
	eCoU=
X-Gm-Gg: ASbGncv/yK+lhCfUo51eYZCZdjT3aLLV+tCIiOp2N38vFFMK/Mm73m4IKrLYE/sIhog
	IewUTv3WhiHwSs14FRf62z4T4zBcJM2O3wKs4v2+bccPiydtB7Rkju6k/P3ZIwVDYCP2ccF27gt
	67qh1cChEBA9IF0R48VV1swVw6IQLFeuSehzzZxT6dZQ3zBqlVKOfzqzMLELEaUKvpxP7gL5dLD
	upTGyxpekx5HEMVfzw4LU98YN1jPuDpvOQb/GOcX7/5jch3ie4iiL+fQelFKgoH1sk2sHSXt2wi
	Yfd3zvYSr6HhFMQxBXw0TuPKHj/LzmqmkhbHNUqsay3XvdohR+x1kfOUVhoS/3sLenjj/IKN
X-Google-Smtp-Source: AGHT+IFkNwVLbCDmXrFbzWbhjdAAvVcTNsE0OrlBtjfD2XbY/YlXFt8n35Cm4QM8FsA86isW3bQj1g==
X-Received: by 2002:a05:6a20:7486:b0:1f5:64fd:68eb with SMTP id adf61e73a8af0-2311e534e12mr1693370637.7.1752187116690;
        Thu, 10 Jul 2025 15:38:36 -0700 (PDT)
Received: from xps (209-147-138-224.nat.asu.edu. [209.147.138.224])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f1b5aesm3531156b3a.92.2025.07.10.15.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:38:36 -0700 (PDT)
Date: Thu, 10 Jul 2025 15:38:34 -0700
From: Xiang Mei <xmei5@asu.edu>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, gregkh@linuxfoundation.org, jhs@mojatatu.com,
	jiri@resnulli.us, security@kernel.org
Subject: Re: [PATCH v3] net/sched: sch_qfq: Fix race condition on
 qfq_aggregate
Message-ID: <aHBA6kAmizjIL1B5@xps>
References: <20250710100942.1274194-1-xmei5@asu.edu>
 <aHAwoPHQQJvxSiNB@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHAwoPHQQJvxSiNB@pop-os.localdomain>

On Thu, Jul 10, 2025 at 02:29:04PM -0700, Cong Wang wrote:
> On Thu, Jul 10, 2025 at 03:09:42AM -0700, Xiang Mei wrote:
> > A race condition can occur when 'agg' is modified in qfq_change_agg
> > (called during qfq_enqueue) while other threads access it
> > concurrently. For example, qfq_dump_class may trigger a NULL
> > dereference, and qfq_delete_class may cause a use-after-free.
> > 
> > This patch addresses the issue by:
> > 
> > 1. Moved qfq_destroy_class into the critical section.
> > 
> > 2. Added sch_tree_lock protection to qfq_dump_class and
> > qfq_dump_class_stats.
> > 
> > Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> 
> Reviewed-by: Cong Wang <xiyou.wangcong@gmail.com>
> 
> I am looking forward to your net-next patch to make it towards RCU. :)
> 
> Thanks.

Thanks so much for your help. I’ve learned a lot from you and the Linux 
kernel community.

I'll work on deliever an better patch after triage the left crashes.

