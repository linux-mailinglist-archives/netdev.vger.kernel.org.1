Return-Path: <netdev+bounces-171687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F9DA4E26D
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 16:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14CCE882161
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 14:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09125D53E;
	Tue,  4 Mar 2025 14:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NH/GiVt4"
X-Original-To: netdev@vger.kernel.org
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB39253B5E
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100125; cv=pass; b=tsk2YJDkdXtLevq92Y2bfChHRGHuMs4QRNzidSGcIOWDtzKKxwR4BzMskmx5IF+t5WN1Fxngu05aE5+CShckJ4Ffg8yg8eChH7GVAFS1jw+RwaoyvmsYTKLuJKnAnuMH7pRSfGkVwNefu0ClDaG6GgzrwuNaoaGmRJ9AXSnfnEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100125; c=relaxed/simple;
	bh=trItDQ5V/mkIx/cKE4ZUDuGgE8kApBhRlmDdGwNOul0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwj70lG1RO71sqfo4truLFQqwquoLDmkHCcgMtMUNMYCzJAlt5XlOurK9OGNQhFX+17qjRT+AzNwKS+R3GUfVvs1rk/kTgSvNyfO+5YVBQzzCpC/LdeWt67qzfSyg35suW7S9UWq+3vBBdGuXOje0YGtTFZTDvKLhSCVfNbstts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NH/GiVt4; arc=none smtp.client-ip=170.10.129.124; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 166E640F1CE0
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:55:22 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NH/GiVt4
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dv56xSNzFxqH
	for <netdev@vger.kernel.org>; Tue,  4 Mar 2025 17:52:17 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5DFEA4273F; Tue,  4 Mar 2025 17:52:11 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NH/GiVt4
X-Envelope-From: <linux-kernel+bounces-541215-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NH/GiVt4
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 3B4A9427A4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:00:33 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 84D263064C0E
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:00:32 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B817A5588
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 08:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C64451F03D9;
	Mon,  3 Mar 2025 08:58:46 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DF51EEA57
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740992323; cv=none; b=qYspHAjTPNg7eShtfd0niTGjTlQyggQmlFkP7hXQyv+LpR5b6sDxWEIUOskqAsHQDQxW533pSXmW2vu84xKbKG6Vwvj9bw+6U0ZlXiZwB3PjnPsuVnGqsXamiwg+WZ+bV/tbCOUF2UDMvCddXTdjbRiphYSyZ/GJmM15xkquJ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740992323; c=relaxed/simple;
	bh=trItDQ5V/mkIx/cKE4ZUDuGgE8kApBhRlmDdGwNOul0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATNN3IDfY2yAM3VWf7EnIGpdoyuIAS2yY3tuDirdLz1Jzt5LMWoffryewCkknxJsXWAT18n8bl6oD9noo7BfhYFUU1GRFBmSkhWh7rxNqs+9yTpO2uAD5g1ZSckywTIykSRaWyVjVkLp5cjkEolkB7MH3++C+mFFo3PQDdug3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NH/GiVt4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740992321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z5mIvbymr+I4BfYQ2lCWwQkjM6pyai+CS0CDOiZ31Js=;
	b=NH/GiVt4stUX+i9o6Tv46wPDV1iL5LR+J0xeykOpdgFTaWDEIijVA6KmfzDDJ+LZJY/teq
	bkEYoig/4owOa1B28khCdU8GRrQBiGVx6mN9mFCbR6cGxpyu5vdbEi3Kx7ekIvOhz6/yRI
	zpn8tQADcFM7JoZVudGMpVg977bxSlQ=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-3bvvSQnmO0KZu4Rpp0oZ4Q-1; Mon, 03 Mar 2025 03:58:34 -0500
X-MC-Unique: 3bvvSQnmO0KZu4Rpp0oZ4Q-1
X-Mimecast-MFC-AGG-ID: 3bvvSQnmO0KZu4Rpp0oZ4Q_1740992314
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5e4cf414a6fso3360963a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Mar 2025 00:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740992314; x=1741597114;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5mIvbymr+I4BfYQ2lCWwQkjM6pyai+CS0CDOiZ31Js=;
        b=Yme/P0v7yb5DgHx7rI6yYwDmAv2O1p4lMvkIyUvI4grTS3N4XT07KyanZouKlLdk9H
         KdCGsqM9b6l3+gnhe+lu9K+5/r7HcFCaMPf1RyKpQfHC3EYVL5rfmCApHHAdCJfpK3na
         U9X2MLCoF7m9fhdRjxWIRMhbPr/kzGKGHHziXkQFim/tTpoAJQ1EvckcW4s1GOGnDgjc
         vLDIQoD1X7/HkI6q1xJTMKe9imI56C34oPVUg1mqANhyh7XmkQfWxSLYUonjO1IDK6BX
         mU4Ruc3eqFdLD7QVNATbQqFDuYP89f5Paj0Id6MHbXJ/oRPcf6B+VfFymHNkwovSeZix
         wRSg==
X-Forwarded-Encrypted: i=1; AJvYcCXOm+oNExxZz6dNN/ppDwcBVUJMVEXN7MPOe14qGXAmEx7WAM9k6SjwM34RXm7yhUaWbrEECyHEFXtBWNY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywjr3IdHwruxwSjkb1saDisY6nlqdyR4xCSpWMbwnTuAaM+V9cn
	HMRrboHRZe9r+ZK8RhFfTZttaPnoXiWdrg5DSLsjMVFzBVBJc3BaIHYnEl/CMTvFVUoVMXVT5V7
	4xcmFLWIVP9ZH5ETPnXJbQcMXTHgZSw1Po1cnoyaQcA/AiFZbaHURIacJkFaWFw==
X-Gm-Gg: ASbGncsJ/Y0D90Svl7Y5/uxupjisLm/PZ+cQ+U5dg7L3F1A4IGNEgHdyInb9SznW9Pg
	swfzLk2v33gGdIObeo1u8j4V9XdOLJCbC6l0w9iV+ixRCgZ5IHYonxEBhARi9cVedJ9WCKqQmoM
	i4wWtwRUs7NSBanoRuV47bRlJSdL5ZvxHgbTrL4Cflb5XaHGBQKA3I0fbVPUHALYBh2qKGi8Avi
	+E2nBHG+MjoDswLzPHNNHVp9rM13m7lDDeuZfii+ilVZ1VhRils1hyWuHFSyxWKKFSXDwy7BGgD
	MRX6jUw37XaOKlc1CrHK3BMhyI225NNzIgXXsJ27PtTTg3bWsQZD8524dIZ6e1y/
X-Received: by 2002:a05:6402:13ca:b0:5dc:cc02:5d25 with SMTP id 4fb4d7f45d1cf-5e4d6ae3bd8mr12016396a12.11.1740992313678;
        Mon, 03 Mar 2025 00:58:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF1UBws0o6Q6N8Or0I9EH2txIiXNDRTiXCawz1Rn521pIsbUD0YYXL9ZstVZ1QxNwfhidyhMw==
X-Received: by 2002:a05:6402:13ca:b0:5dc:cc02:5d25 with SMTP id 4fb4d7f45d1cf-5e4d6ae3bd8mr12016357a12.11.1740992313071;
        Mon, 03 Mar 2025 00:58:33 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-29.retail.telecomitalia.it. [79.46.200.29])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e4c3fb51e1sm6716034a12.61.2025.03.03.00.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 00:58:31 -0800 (PST)
Date: Mon, 3 Mar 2025 09:58:26 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Cindy Lu <lulu@redhat.com>
Cc: jasowang@redhat.com, mst@redhat.com, michael.christie@oracle.com, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v7 6/8] vhost: uapi to control task mode (owner vs
 kthread)
Message-ID: <4rcrc4prhmca5xnmgmyumxj6oh7buewyx5a2iap7rztvuy32z6@c6v63ysjxctx>
References: <20250302143259.1221569-1-lulu@redhat.com>
 <20250302143259.1221569-7-lulu@redhat.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250302143259.1221569-7-lulu@redhat.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dv56xSNzFxqH
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704798.2521@nJ9P6NXHlW1tPiC5ZjcKZA
X-ITU-MailScanner-SpamCheck: not spam

On Sun, Mar 02, 2025 at 10:32:08PM +0800, Cindy Lu wrote:
>Add a new UAPI to configure the vhost device to use the kthread mode
>The userspace application can use IOCTL VHOST_FORK_FROM_OWNER
>to choose between owner and kthread mode if necessary
>This setting must be applied before VHOST_SET_OWNER, as the worker
>will be created in the VHOST_SET_OWNER function
>
>Signed-off-by: Cindy Lu <lulu@redhat.com>
>---
> drivers/vhost/vhost.c      | 22 ++++++++++++++++++++--
> include/uapi/linux/vhost.h | 15 +++++++++++++++
> 2 files changed, 35 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
>index be97028a8baf..ff930c2e5b78 100644
>--- a/drivers/vhost/vhost.c
>+++ b/drivers/vhost/vhost.c
>@@ -1134,7 +1134,7 @@ void vhost_dev_reset_owner(struct vhost_dev *dev, struct vhost_iotlb *umem)
> 	int i;
>
> 	vhost_dev_cleanup(dev);
>-
>+	dev->inherit_owner = true;
> 	dev->umem = umem;
> 	/* We don't need VQ locks below since vhost_dev_cleanup makes sure
> 	 * VQs aren't running.
>@@ -2287,7 +2287,25 @@ long vhost_dev_ioctl(struct vhost_dev *d, unsigned int ioctl, void __user *argp)
> 		r = vhost_dev_set_owner(d);
> 		goto done;
> 	}
>-
>+	if (ioctl == VHOST_FORK_FROM_OWNER) {
>+		u8 inherit_owner;
>+		/*inherit_owner can only be modified before owner is set*/
>+		if (vhost_dev_has_owner(d)) {
>+			r = -EBUSY;
>+			goto done;
>+		}
>+		if (copy_from_user(&inherit_owner, argp, sizeof(u8))) {
>+			r = -EFAULT;
>+			goto done;
>+		}
>+		if (inherit_owner > 1) {
>+			r = -EINVAL;
>+			goto done;
>+		}
>+		d->inherit_owner = (bool)inherit_owner;
>+		r = 0;
>+		goto done;
>+	}
> 	/* You must be the owner to do anything else */
> 	r = vhost_dev_check_owner(d);
> 	if (r)
>diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
>index b95dd84eef2d..547b4fa4c3bd 100644
>--- a/include/uapi/linux/vhost.h
>+++ b/include/uapi/linux/vhost.h
>@@ -235,4 +235,19 @@
>  */
> #define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
> 					      struct vhost_vring_state)
>+
>+/**
>+ * VHOST_FORK_FROM_OWNER - Set the inherit_owner flag for the vhost device

Should we mention that this IOCTL must be called before VHOST_SET_OWNER?

>+ *
>+ * @param inherit_owner: An 8-bit value that determines the vhost thread mode
>+ *
>+ * When inherit_owner is set to 1(default value):
>+ *   - Vhost will create tasks similar to processes forked from the owner,
>+ *     inheriting all of the owner's attributes..
                                                   ^
nit: there 2 points here

>+ *
>+ * When inherit_owner is set to 0:
>+ *   - Vhost will create tasks as kernel thread
>+ */
>+#define VHOST_FORK_FROM_OWNER _IOW(VHOST_VIRTIO, 0x83, __u8)
>+
> #endif
>-- 
>2.45.0
>



