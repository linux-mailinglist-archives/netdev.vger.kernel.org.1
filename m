Return-Path: <netdev+bounces-241703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 16BABC87859
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 00:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C1ED3B6BD0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF83C2F28F4;
	Tue, 25 Nov 2025 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XANxQzH7";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AKy3ZVkK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED33A2F12C6
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 23:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764114631; cv=none; b=raVi8iPaQZlrJUVY7BdU160320gcizgBCTd99RIHKr8peusaaTniawdLKqyO02ePcgjgFwcSgkdTb4x3eNfTVCn4oQQtcu8XiEWKcUn72Lo67g9S0uUjLFsVjq47X2MoROMWETjMT4hUAfDzxrH4gmJNFhx6/f8NVZt6UvUrwYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764114631; c=relaxed/simple;
	bh=VR/QlSFYXfB2XAkyEqk2La815NaXCesg1lVuqP0+cyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HjmzFLfGKxX+ogIQ5cC0dqtOVN+/qmt2p29wdwkmLfAJ25eisXqkZWFuuZBwXRSkWEvEEAOUlTTA/nCVU5DslY3yZ0jHRwiiB5dEzumGakE/TTYANuHJqokNTiH2qtVZNsIrtQJT8jpcg+4IMXzm4CWti8TicLZUt9j8wKM/6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XANxQzH7; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AKy3ZVkK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764114628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rIwS7E0jdpZel3anL6UezeiFSzMWSTuk00aa6Qzm+5s=;
	b=XANxQzH7zied/lawSDkulHUT9yhZBs81lP5QZLr2Tfk7DXwZi9JkQjI6B7QfQrYY6uEkS9
	hy+VpFxKhxDqWNaozPAll69epsLEvZNdMnUi9Vbg1kfp963C4KET3kJw6NnE+UYVn+XGPt
	kQjVUqvfKrvLJbJyhEEB7oEM1y+JvYg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-RomyHxNjO7GGkxysxViM9A-1; Tue, 25 Nov 2025 18:50:26 -0500
X-MC-Unique: RomyHxNjO7GGkxysxViM9A-1
X-Mimecast-MFC-AGG-ID: RomyHxNjO7GGkxysxViM9A_1764114624
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-477563e531cso51846745e9.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 15:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764114624; x=1764719424; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rIwS7E0jdpZel3anL6UezeiFSzMWSTuk00aa6Qzm+5s=;
        b=AKy3ZVkKL1lF1IVsOpuUpB0EsE1qPUgLKNQJyujF7MBqRno9gF64A/IPOmoqELpIDS
         GU5U2EHwMmk25vGrwPAnmLDGEkCpp5PlbmHbR4pj3Z68FQf1qByvjY8oZxYSdcTigDKu
         4CWmsF67v+s9q5gzNkxbc5Ys/AOjSjYsc9RfZdJufT8BFGuFM8uLxJ+SHazvBhxhoLa7
         CFmDK8k42IMAe6jlCETQtb6MZ1KMjGfMvQsgAZT25D7e5p92sJ9Q1xlmSoUlcjT2id8/
         garHq+bqIcu9IIlTj1EEVYQYFOU1I6aVEs+t8/22e+euL9QJH4Ivf4U7CpichSuYR3pe
         CkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764114624; x=1764719424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rIwS7E0jdpZel3anL6UezeiFSzMWSTuk00aa6Qzm+5s=;
        b=GPTiSK3XwbAeu4MYV9caAhk78W81uJ6KaJQ6Qb+chjiKWZacf4t3roH5Ytff72NTnS
         jauAWJkm5wKMw+9CszpQETg97FDYX0jSKlP1f6p9rAy75gpXZtpRt8fO/T2t67/08tu6
         +mT3LS7Q1151qFbguqUAvQ0edYHC5L7STIPLVjIOAgIARJbXh/0jju/si8cTT0XutoRM
         stDA620qbykK+gvJphbKe+DoMaBffRrINl3wqkkJJF9mJH8pAgpBUI4vsBbXX6jMrr1g
         5v3Pa0tAJIemgSm/v7JLuXXzutUjD7O+DMRRjkiQVAKvh4XyE3pAEbkTlqClfmFoz1UC
         CsOg==
X-Forwarded-Encrypted: i=1; AJvYcCWpqHWDnVU6ilyCkEztqNVQ0coHCOkWLExWR/rTxPaZ1fSgdPEcw7/iKNMl8/9kpUbNYmJPDPo=@vger.kernel.org
X-Gm-Message-State: AOJu0YySZ8w0O1kdVdwNgninN9m29wcINkI4rPRLt+YH6NXzG1mWpYZ9
	e2uywgXLa3RhtTPKj+JgRDzkcmEqWV4iw5no6FJCMf2wGUpd1zUJvWIJWz72iSVg0jgolXtB7bq
	3cGouaqIZfVqU4Ilf20zs/SWtucVuXCv3K8f/kNaxOmaMN67V3DNMtf6+Aw==
X-Gm-Gg: ASbGncu4uNwxOT3BqrHQo6bNKLov5r0bC2MRRUTQ9+f8SD8LMO2JPd3S19uh4xlAxZ9
	K78vGmxNOIZ/D56icZmOxXCGq40hZrwJdTQVWnKcP/bHkOqDZcO0QzKaTyUsF/6esHTRimzT0Xi
	+33MMYRHmvSNeLRCW9bNsnYp1bOlO+W8jDmEWSnCW5jDKRIHX55Q5JcLkuQLOwc958ASzJS1r3P
	7+jttHpmaSMnCNQXXgQBRC1kEMZcQw1P+igdexho6qK1exFnBuBXCcKEIkr6Vx8rHmEklIL5+is
	DnqpAqjq/DU26YvCt1kY1o/gECmikkzUV4CgabLZgThZmC+U/ae4hDYXQhHE60e1JSyyklQYlXF
	vf+zQ1f90K1ABLE09sFNG/YdvnxlBJw==
X-Received: by 2002:a05:600c:1c25:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-477c114ed70mr261113185e9.24.1764114624362;
        Tue, 25 Nov 2025 15:50:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFnq4RJlt9m2aS6c4TGKhjJ1S2uVgEkT/HKNHftYudQTJJrbCWeUDlCnlsQl791oaHujLBMkw==
X-Received: by 2002:a05:600c:1c25:b0:46e:4586:57e4 with SMTP id 5b1f17b1804b1-477c114ed70mr261112975e9.24.1764114623865;
        Tue, 25 Nov 2025 15:50:23 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479052def4bsm26279025e9.13.2025.11.25.15.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 15:50:23 -0800 (PST)
Date: Tue, 25 Nov 2025 18:50:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jon Kohler <jon@nutanix.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] vhost/net: check peek_head_len after signal to
 guest to avoid delays
Message-ID: <20251125184936-mutt-send-email-mst@kernel.org>
References: <20251125180034.1167847-1-jon@nutanix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251125180034.1167847-1-jon@nutanix.com>

On Tue, Nov 25, 2025 at 11:00:33AM -0700, Jon Kohler wrote:
> In non-busypoll handle_rx paths, if peek_head_len returns 0, the RX
> loop breaks, the RX wait queue is re-enabled, and vhost_net_signal_used
> is called to flush done_idx and notify the guest if needed.
> 
> However, signaling the guest can take non-trivial time. During this
> window, additional RX payloads may arrive on rx_ring without further
> kicks. These new payloads will sit unprocessed until another kick
> arrives, increasing latency. In high-rate UDP RX workloads, this was
> observed to occur over 20k times per second.
> 
> To minimize this window and improve opportunities to process packets
> promptly, immediately call peek_head_len after signaling. If new packets
> are found, treat it as a busy poll interrupt and requeue handle_rx,
> improving fairness to TX handlers and other pending CPU work. This also
> helps suppress unnecessary thread wakeups, reducing waker CPU demand.
> 
> Signed-off-by: Jon Kohler <jon@nutanix.com>

Given this is supposed to be a performance improvement,
pls include info on the effect this has on performance. Thanks!

> ---
>  drivers/vhost/net.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..04cb5f1dc6e4 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -1015,6 +1015,27 @@ static int vhost_net_rx_peek_head_len(struct vhost_net *net, struct sock *sk,
>  	struct vhost_virtqueue *tvq = &tnvq->vq;
>  	int len = peek_head_len(rnvq, sk);
>  
> +	if (!len && rnvq->done_idx) {
> +		/* When idle, flush signal first, which can take some
> +		 * time for ring management and guest notification.
> +		 * Afterwards, check one last time for work, as the ring
> +		 * may have received new work during the notification
> +		 * window.
> +		 */
> +		vhost_net_signal_used(rnvq, *count);
> +		*count = 0;
> +		if (peek_head_len(rnvq, sk)) {
> +			/* More work came in during the notification
> +			 * window. To be fair to the TX handler and other
> +			 * potentially pending work items, pretend like
> +			 * this was a busy poll interruption so that
> +			 * the RX handler will be rescheduled and try
> +			 * again.
> +			 */
> +			*busyloop_intr = true;
> +		}
> +	}
> +
>  	if (!len && rvq->busyloop_timeout) {
>  		/* Flush batched heads first */
>  		vhost_net_signal_used(rnvq, *count);
> -- 
> 2.43.0


