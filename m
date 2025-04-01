Return-Path: <netdev+bounces-178603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B410A77C53
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B2433AD453
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2441C204680;
	Tue,  1 Apr 2025 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EwmHzA7m"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 733AE202C26
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 13:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743514695; cv=none; b=iQMGV8q1fjo+L9lmcE9FOBivBLLoinb/+Dx7QfrnlTfk69JEzFzuROAOkbPsccWZS45BJN9bsN5n/j9lr4uu9uKhqGfKDbaRWli2kkuiW26CTq+hnRyrnhz0JhmvAomX3ThvxGnQrDeSMw6DAYBe5NDRhFPxf0pbDDonsaArTWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743514695; c=relaxed/simple;
	bh=Tv6jLPBrzNjMWpo+/OOUTUfL/0e584MxIOISNnV7p8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJKLCftSOYuWjvhMyC4JofEPZfXEXV5mrWY60lPCh+X4t96/2gAw8KYtRBOF7B8WpSe3/AWCaQ2Us1bDXNSv0AiXzyWAYSsmaMy1aP8KLXitZ96e3mHpRUWiij8pE6c4Y60pCUpJ/oqUVSjzJo1AlqFv2iv6PGfr2hkcjumwOuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EwmHzA7m; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743514692;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PLR2CTlKlBh1tBHT4me7CSz9I+6Wecczia3M942yG/Q=;
	b=EwmHzA7mxWBoSMPd4/jKGQ19A23vs6TRB4LTsBMl7uhhmEk1APqnsv4ocCVfbqNrh8VAVY
	IBI0iUJ63PRWTQx9XHJNaPXDk+68yOS8VMo+pntb5xJjLW3yQ/pJ7g5++LTcYFwk2GZjc8
	L8d+T3UjylumRrVv0Ub6lMGnwN5z43c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-46zToXBgM1K6GZNybVKxuQ-1; Tue, 01 Apr 2025 09:38:11 -0400
X-MC-Unique: 46zToXBgM1K6GZNybVKxuQ-1
X-Mimecast-MFC-AGG-ID: 46zToXBgM1K6GZNybVKxuQ_1743514690
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3913f546dfdso2921147f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 06:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743514690; x=1744119490;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLR2CTlKlBh1tBHT4me7CSz9I+6Wecczia3M942yG/Q=;
        b=Xq82vVaCSsdQhSficQUxtfQX4Vqs6acYX5nhbJNIFWi13cFBHHlcz2veDvXMSZ6hlj
         bWYBcp9rJrEIByrC1wkN468XaFc3Vw2d0v13Hjkj6eGIKUrlnFqcPqdUQ9f2NM1RCPCu
         NrWf2v6kkcFT0TVQSOhuyWQrR/kS1igZGURhJe3fyEmYHO5+A3GtEoFqzJSXau1//tmT
         C6nK4ju2g9t012n6Y5PBW0aqu99+wfv+5bxpxVTCizfyS0shGNfF3kM6V/8KCabKKSRH
         odybrPpt4wWYGiY/gLc8AQ/culBOw0kPfM/4K29Y3lZmuvWj1wY8nlu8FDh3LzO6WqQa
         Lajw==
X-Forwarded-Encrypted: i=1; AJvYcCW5HzoyqSuuKFDiOnTVAVRRJwSLhsiIp2we1mMY6c6S19lyx2R+t0crRIwtjY1o68SjQxl0X7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO9FzOIyPFHbzMjvMYP/HnhTuqC/AOjB5f1xxMw7W3qmBZM6rH
	xAPspLBoHQo4fp5Rvf2V1lS9Yee16u888vKJt1dw45bDi5beIzQYG++EZMRcI+8OMhVWAjCUtWr
	j8TVZ9dWVEf52lD8pg4XmOLt26MqcIWyTEYREDvhYs0Jm0Ua+uermYQ==
X-Gm-Gg: ASbGncv7amQJCn36xEicvMJM0f1ceqAlLXC0G/H/RkpXaBq1oTSgeG+Oe57ibavi6sU
	zFUVH3HlI304fWDAdsn31a45bXC/koCHtVEhTFooKIdQWhmHrxKain1WQmzMkLa/FC/xOtTK2pB
	4A+58l7PZ7/iEoOL+G5ugjnKi77RIb6pO6H4lH+KyC4HpPApJk+w7gB/6iwHhuE5iUkkXenyXoM
	COEYtCiX/p91nN8ij2w/KK51d6XKZBSiPU1bouYiK1geJfu52MSX0FoCica7kjJd+MA/KN/c+kl
	sIPLQtqJD1Xty8kALKtOPUL99hVYf0XdSvc+lCPr3f4/V4Flg3T1tbWwnZw=
X-Received: by 2002:a05:6000:40ce:b0:399:6ad6:34 with SMTP id ffacd0b85a97d-39c12118e33mr10038712f8f.35.1743514689985;
        Tue, 01 Apr 2025 06:38:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlZRmu/hwz3PRTRaavlDQia8G1V08A9rc2gfYG8uSPBATLZEqFZ5bYSvbtyXL7+/sXwDad3g==
X-Received: by 2002:a05:6000:40ce:b0:399:6ad6:34 with SMTP id ffacd0b85a97d-39c12118e33mr10038680f8f.35.1743514689549;
        Tue, 01 Apr 2025 06:38:09 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b6588d0sm13944756f8f.7.2025.04.01.06.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:38:08 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:38:02 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 2/8] vhost: Reintroduce vhost_worker to support kthread
Message-ID: <ylnfh4mwifvrnmlwpg6g4mjtfzc7z5qvn5hnnvxz6cepbkobcg@hsv3z2yp5w3f>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-3-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328100359.1306072-3-lulu@redhat.com>

On Fri, Mar 28, 2025 at 06:02:46PM +0800, Cindy Lu wrote:
>Add the previously removed function vhost_worker() back
>to support the kthread and rename it to vhost_run_work_kthread_list.
>
>The old function vhost_worker was change to support task in

nit: s/change/changed

>commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads")
>change to xarray in
>commit 1cdaafa1b8b4 ("vhost: replace single worker pointer with xarray")
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 38 ++++++++++++++++++++++++++++++++++++++
> 1 file changed, 38 insertions(+)

I tried to build commit by commit (mainly to check bisection), and I
discovered that nowdays unused functions produce an error (yes, we can 
mute it for example by setting CONFIG_WERROR to N), but I wanted to 
point it out:

../drivers/vhost/vhost.c:391:12: error: ‘vhost_run_work_kthread_list’ defined but not used [-Werror=unused-function]
   391 | static int vhost_run_work_kthread_list(void *data)

So not sure if we need to squash this where we use it.

Same issue also for the next 2 patches.

Thanks,
Stefano

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index 250dc43f1786..9500e85b42ce 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -388,6 +388,44 @@ static void vhost_vq_reset(struct vhost_dev *dev,
> 	__vhost_vq_meta_reset(vq);
> }
>
>+static int vhost_run_work_kthread_list(void *data)
>+{
>+	struct vhost_worker *worker = data;
>+	struct vhost_work *work, *work_next;
>+	struct vhost_dev *dev = worker->dev;
>+	struct llist_node *node;
>+
>+	kthread_use_mm(dev->mm);
>+
>+	for (;;) {
>+		/* mb paired w/ kthread_stop */
>+		set_current_state(TASK_INTERRUPTIBLE);
>+
>+		if (kthread_should_stop()) {
>+			__set_current_state(TASK_RUNNING);
>+			break;
>+		}
>+		node = llist_del_all(&worker->work_list);
>+		if (!node)
>+			schedule();
>+
>+		node = llist_reverse_order(node);
>+		/* make sure flag is seen after deletion */
>+		smp_wmb();
>+		llist_for_each_entry_safe(work, work_next, node, node) {
>+			clear_bit(VHOST_WORK_QUEUED, &work->flags);
>+			__set_current_state(TASK_RUNNING);
>+			kcov_remote_start_common(worker->kcov_handle);
>+			work->fn(work);
>+			kcov_remote_stop();
>+			cond_resched();
>+		}
>+	}
>+	kthread_unuse_mm(dev->mm);
>+
>+	return 0;
>+}
>+
> static bool vhost_run_work_list(void *data)
> {
> 	struct vhost_worker *worker = data;
>-- 
>2.45.0
>


