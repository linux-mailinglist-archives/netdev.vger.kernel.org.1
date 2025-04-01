Return-Path: <netdev+bounces-178616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F6A77D07
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 15:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774F316616C
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 13:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465AD203714;
	Tue,  1 Apr 2025 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc3qaYli"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25481E47A9
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 13:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743515981; cv=none; b=A67iM1UxItnmNM8Dtjx5eMRWz40SYGjZFjJ+OByIiY+XfBPSGJ3ioVQLc2V2Xm7KXYyL/Vg8UhSPkMp94wCJTw176rSOL12UR30GOAzEMCxgkWG0fmVYIZibKfvijcrY+tYUP/duAosOiw9TeytTru90o4m0oya+unPsvzCxAHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743515981; c=relaxed/simple;
	bh=hDLzqRPsoDGnUdms0LQYvaYmGEbT2S3EwsAgwQYZnT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfxFEOtlF+mMCCxKgEEmJQLFzqPE6DrIIhdJ8OPnb6HokrmBocPTXRZUI9uErpmj6bdGLto80BKOs5pLvQ9iSosjAvPVXX1eVe93g5Onr8ku55tLdnu4nbpS/kA0vNEk7rsBLai7enNJ63jCV6/7V9xsqNSsTAFyRSiE1Fzk+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nc3qaYli; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743515978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t2IgA5uO8titoAWyijzoucLkCRmrJQPxxk3pK7glj/g=;
	b=Nc3qaYli77fk94B2Iltg+UoQtHZMDsV+eV+sHgZsFGEt8ruSABBk+ILPO4INxqj+vm9nKC
	sqGrMQ8l8jLuk92p2lJTGIkifeqSM0954vTZehYw2WWZ+TGDJvImwEuRHkHGqnPaNcF3bY
	vbvFfshrHmTEkP/JCu31jisnwENQR+M=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-vOE_FUfLPh6cdrH6NNM9yQ-1; Tue, 01 Apr 2025 09:59:37 -0400
X-MC-Unique: vOE_FUfLPh6cdrH6NNM9yQ-1
X-Mimecast-MFC-AGG-ID: vOE_FUfLPh6cdrH6NNM9yQ_1743515976
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-39135d31ca4so2959478f8f.1
        for <netdev@vger.kernel.org>; Tue, 01 Apr 2025 06:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743515976; x=1744120776;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2IgA5uO8titoAWyijzoucLkCRmrJQPxxk3pK7glj/g=;
        b=vaTOQPpxaOY+AeF4qwIVEPCQHDzgNnSR7nP+4ZktViqrZ95BNSo+zhRsEWkKk5vumC
         iDCChKPjGVYF7zOYv+xCDpN6kClFsYRRSFvDbvUmEMkJ/eyickJbESIKUm0jknCZQQMC
         4+ZcNNk90spAd7gxvVj8GqQWCwQ1tT6MDnGjTVeKJolwQ9+htQWeH2xoUWwgAIwsl99G
         UoUCxhzaTc21bcBWTNZbSNPRphfjEFhJWP/hdhA8PIiRQAqh2k0ZCKSiecBdcUNOlGfh
         iwNRammc+MJnUwq23khRucP3nKEwBLuw68d9jQtjZd/t+LXh5rz9HgB5747LBbjN8Hg3
         u7Xw==
X-Forwarded-Encrypted: i=1; AJvYcCUET7HOkNQ+oeaf4deg6qr7i+z0ZAD/bKxMhuzT8rqtx6Wkg5bywr8mdDpz8RDRE2e2LMXvMVg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNFFaGXCQoE0Cs5a6JW/Q+nEaLPB9OioQhE0afi0WYomdpVLlI
	YOwvu3taxc39I+baswXBC2ywhMiufoGcyIhvjKlsObLS3ezkPnX8mBbzka5pPcjNSvtSjlW0ONe
	yzvPcFqRGhFQRHUjP0SKh7Gyn0LSu45r7SjljK9kSLs2qKdEkoBw/mA==
X-Gm-Gg: ASbGncvUWDxJmkI2gsaJby0wAPcDxyPxTvTCtVMs6DWBmjmQoqgUryjIXNCt12EtAV/
	fZHb6AyHnIJkz5JGuXYDeh2ptvLj4HbIwAJQ/NOwHFLn0pups/uQ4fJT7h0LQEuFnjBu6IXKyb7
	rW24qFVm+Sh+PUqlkZTYWOy+vusYGWlbuKE/xq1d8Wqub6MAZzPfkrCG1UyATX/DTlqphJk3wwK
	eGw9d7twc5xsmQIu4YhXM4j6Rl57qZny/edczfRqrFYrbRmYNSMriAWfEswt0ItFDlb5AG9siQN
	fltyv73Ch17f2hAIvZG2CEvLFxKYvTeEBcVHUrdFB2wzxMiDA4P9ePPmeyw=
X-Received: by 2002:a5d:584c:0:b0:39b:3c96:80df with SMTP id ffacd0b85a97d-39c27ee611bmr75399f8f.11.1743515976253;
        Tue, 01 Apr 2025 06:59:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF09FwfqnRb8UJMujFmXs/QqdYBJeJRX2YI3guWVQi2x8F5XNEe7ScWOGZy7YxSOXZw3qmefg==
X-Received: by 2002:a5d:584c:0:b0:39b:3c96:80df with SMTP id ffacd0b85a97d-39c27ee611bmr75369f8f.11.1743515975769;
        Tue, 01 Apr 2025 06:59:35 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-59.retail.telecomitalia.it. [87.11.6.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d82e6adf6sm198134245e9.15.2025.04.01.06.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 06:59:34 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:59:26 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v8 7/8] vhost: Add check for inherit_owner status
Message-ID: <d35istatjtnr42x4gwpwlgx627pl3ntqua3kde7fymtotl676i@jxxxkrii6rue>
References: <20250328100359.1306072-1-lulu@redhat.com>
 <20250328100359.1306072-8-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250328100359.1306072-8-lulu@redhat.com>

On Fri, Mar 28, 2025 at 06:02:51PM +0800, Cindy Lu wrote:
>The VHOST_NEW_WORKER requires the inherit_owner
>setting to be true. So we need to add a check for this.
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c | 7 +++++++
> 1 file changed, 7 insertions(+)

IMHO we should squash this patch also with the previous one, or do this 
before allowing the user to change inherit_owner, otherwise bisection 
can be broken.

Thanks,
Stefano

>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index ff930c2e5b78..fb0c7fb43f78 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1018,6 +1018,13 @@ long vhost_worker_ioctl(struct vhost_dev *dev, unsigned int ioctl,
> 	switch (ioctl) {
> 	/* dev worker ioctls */
> 	case VHOST_NEW_WORKER:
>+		/*
>+		 * vhost_tasks will account for worker threads under the parent's
>+		 * NPROC value but kthreads do not. To avoid userspace overflowing
>+		 * the system with worker threads inherit_owner must be true.
>+		 */
>+		if (!dev->inherit_owner)
>+			return -EFAULT;
> 		ret = vhost_new_worker(dev, &state);
> 		if (!ret && copy_to_user(argp, &state, sizeof(state)))
> 			ret = -EFAULT;
>-- 
>2.45.0
>


