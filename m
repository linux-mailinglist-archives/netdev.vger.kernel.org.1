Return-Path: <netdev+bounces-245935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C5EA4CDB1C1
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 02:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E953D303211C
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 01:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1DA11DE3DC;
	Wed, 24 Dec 2025 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a82IxcXo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WGZgHvc3"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7FA205E25
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 01:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540746; cv=none; b=sEv4lOUNU7k/eRqRg7FCv8FL5Oos3Ubxnk1513n2p6tLKASf4TPDHmQXamI8a8F+7FKwJ8V61zXN3BWtjLFzueLaYAlRLbppqmWZb2W0mS/iQZJswrGw/laCOzjU+4e6xnpSI9JeVhVcpEWP4rha8TSoqLsRS2TzyfdvePH8ZIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540746; c=relaxed/simple;
	bh=qLZW3NS0wU1PkWXMkdS8e92GhST35BthsoRFkj6DtlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CF1/5HO2Ip/SnUAY/kcKaJZS74YnPEp8zIodxkZ0abjc8HnGUMFIw/LCOf+/Vb7zsqji7LwJ4I9x7maWRmOK5JMQh/WWjljAfR12pwNFHYxLEnXBmIwyOY0mfAeG5oRDZZO/wTS+0xkGjEHx6rcx90hrvCbrKLOo8u0p/bmgPGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a82IxcXo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WGZgHvc3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766540743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eE59yoVU4T1J/ye2BZHXCDqmQXZhh+ZWFAYfrcDt0hw=;
	b=a82IxcXoVmDMRXBPQyHZSvAritLPGc7J7dUnOQ4fjHYTLprCz05/L070kKhQpx+r/Jb73u
	9EAPJWZwc4J2CY1txMs05yJppILMyZHCjWlNno8wwdvstcUXOJgWIcGk1lZ6tn/ph38OcV
	bgZmBUmaJBVgySfuu3+Atkdlm3ylMpk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-_66vSfoANG-1xpiATK95gA-1; Tue, 23 Dec 2025 20:45:35 -0500
X-MC-Unique: _66vSfoANG-1xpiATK95gA-1
X-Mimecast-MFC-AGG-ID: _66vSfoANG-1xpiATK95gA_1766540735
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-430f527f5easo3559577f8f.1
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 17:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766540734; x=1767145534; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eE59yoVU4T1J/ye2BZHXCDqmQXZhh+ZWFAYfrcDt0hw=;
        b=WGZgHvc3DBCcbN7Oh54zwaDnxaKWEBlyIGPNjDrr82XRzZT8rLxvs/DGmJ/rKfeLWh
         TqDVqOjIA4pUkhZxA0cSpTVu+cr9JNOd2YXhHYRklB46+Eici6t38Iz4QQPWOw/8yaYf
         BtsNkflbzq4Oo6h22LANLqYQhokG9B8lb2Rq6XsHGdPN2KW0zMF/FJh1gcEYaa/33jsf
         8w4N5Vd2iL8Nz4tzDWWquUnEDWgLAhoTyaQLtFmiKL0fcF36zjh+BcK1VgoHDBGXojxs
         +zEU598bTvbWo68MQOYS5Y3/gCZy/V2S78YXC18ii2MXCdVxqWiqMTvZ7y0wvUdg2qm2
         tRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766540734; x=1767145534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eE59yoVU4T1J/ye2BZHXCDqmQXZhh+ZWFAYfrcDt0hw=;
        b=BRwyB5BMgYBo7xHFLEBQ8iv5WsDZvymnjCye7axuThb8uF3A5bfxQDtn1k8kxudEWt
         Xl8xuZYKsXvE/3clkQCp+Twq4UUBB5eTqarDFfgZ7sp999EbiS67VU3VGrIwo/ezlkOm
         +aWtieUPxL5Q0feTcqMJpB7265ufxn1lUT4symkbtSxcqi2BfEYk5ruSYjmeXjrt+5Lz
         dEGvGzjR8wj49WT7s3vqJF0g+Vnk6JJLRs+s4017BD95xrYYS50rIG7kvUOYSdx6YEH0
         FwTCpYA5xFLUdwoW3i5CoURgEg7HXTps85SZ0B3EYu+IepSYOdDTIcmHjQcdf4kKXaDD
         WrLA==
X-Gm-Message-State: AOJu0YxkFdpNNtSp6/TCugzuCt7sqaHOQfYF6QXpTFLvFpA6XaF+WNA1
	YbI86zHZnutLAPsSu+u/OLbZ1QHxFCnoEqPCNtXclAmDBGrZtBTea9RJQxaO+ug8OYYYUwHEsR6
	BfGI2qDY2KZk0Y2WYXimjwwnqigLhyOp+6up/YVn+84QxJ5DqMBn9kXgYXw==
X-Gm-Gg: AY/fxX45NywBEYTaVsVwnF4+8HPdJ6AI9Sc+SXbosdAyiNuzxqgVmnJotPsuDe6AlYj
	NB/Not4GptJ4O2NHPVm8H6+klWOQJnUoUYNMNy+4m0abdtPvNePyq2wejw5yvTauqh9PkLFtr8N
	xRztK+OtpiuhTmluMLoG9Z3Nx70gH4IPZV+DTqXQNtXsShJJzJA/BlbH7/rxQ8Z4fbZqzRPvLhR
	k2DWO93rTeG4OhYZRsr6kPsJs2q07t1qKVsMksZIXTtlgwyEFbl39xAAHFs6wi2K+1hEZR2Nzl/
	f91KjPayNShvpppwkJ3hKC+JrJtAiUrsgO5clsd6BEzNcBV42K4RVSFCtB5IFcU+ZFAjLfQVSEe
	v
X-Received: by 2002:a05:6000:1889:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-4324e41725fmr18915014f8f.18.1766540734559;
        Tue, 23 Dec 2025 17:45:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrk944sB9ALtgrKmusKW3zRCVN5YKqSNp/nlu8sC1ya5zS0cqE0ZbPcPVKQitwZWGzuZSn8w==
X-Received: by 2002:a05:6000:1889:b0:42b:2a41:f20 with SMTP id ffacd0b85a97d-4324e41725fmr18914986f8f.18.1766540733985;
        Tue, 23 Dec 2025 17:45:33 -0800 (PST)
Received: from redhat.com ([31.187.78.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm31426547f8f.34.2025.12.23.17.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 17:45:33 -0800 (PST)
Date: Tue, 23 Dec 2025 20:45:29 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net 2/3] virtio-net: ensure rx NAPI is enabled before
 enabling refill work
Message-ID: <20251223203908-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-3-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223152533.24364-3-minhquangbui99@gmail.com>

On Tue, Dec 23, 2025 at 10:25:32PM +0700, Bui Quang Minh wrote:
> Calling napi_disable() on an already disabled napi can cause the
> deadlock. Because the delayed refill work will call napi_disable(), we
> must ensure that refill work is only enabled and scheduled after we have
> enabled the rx queue's NAPI.
> 
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> ---
>  drivers/net/virtio_net.c | 31 ++++++++++++++++++++++++-------
>  1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 63126e490bda..8016d2b378cf 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3208,16 +3208,31 @@ static int virtnet_open(struct net_device *dev)
>  	int i, err;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		bool schedule_refill = false;



> +
> +		/* - We must call try_fill_recv before enabling napi of the same
> +		 * receive queue so that it doesn't race with the call in
> +		 * virtnet_receive.
> +		 * - We must enable and schedule delayed refill work only when
> +		 * we have enabled all the receive queue's napi. Otherwise, in
> +		 * refill_work, we have a deadlock when calling napi_disable on
> +		 * an already disabled napi.
> +		 */


I would do:

	bool refill = i < vi->curr_queue_pairs;

in fact this is almost the same as resume with
one small difference. pass a flag so we do not duplicate code?

>  		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
>  			/* Make sure we have some buffers: if oom use wq. */
>  			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -				schedule_delayed_work(&vi->rq[i].refill, 0);
> +				schedule_refill = true;
>  		}
>  
>  		err = virtnet_enable_queue_pair(vi, i);
>  		if (err < 0)
>  			goto err_enable_qp;
> +
> +		if (i < vi->curr_queue_pairs) {
> +			enable_delayed_refill(&vi->rq[i]);
> +			if (schedule_refill)
> +				schedule_delayed_work(&vi->rq[i].refill, 0);


hmm. should not schedule be under the lock?

> +		}
>  	}
>  
>  	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> @@ -3456,11 +3471,16 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>  	bool running = netif_running(vi->dev);
>  	bool schedule_refill = false;
>  
> +	/* See the comment in virtnet_open for the ordering rule
> +	 * of try_fill_recv, receive queue napi_enable and delayed
> +	 * refill enable/schedule.
> +	 */

so maybe common code?

>  	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_refill = true;
>  	if (running)
>  		virtnet_napi_enable(rq);
>  
> +	enable_delayed_refill(rq);
>  	if (schedule_refill)
>  		schedule_delayed_work(&rq->refill, 0);

hmm. should not schedule be under the lock?

>  }
> @@ -3470,18 +3490,15 @@ static void virtnet_rx_resume_all(struct virtnet_info *vi)
>  	int i;
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		if (i < vi->curr_queue_pairs) {
> -			enable_delayed_refill(&vi->rq[i]);
> +		if (i < vi->curr_queue_pairs)
>  			__virtnet_rx_resume(vi, &vi->rq[i], true);
> -		} else {
> +		else
>  			__virtnet_rx_resume(vi, &vi->rq[i], false);
> -		}
>  	}
>  }
>  
>  static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  {
> -	enable_delayed_refill(rq);
>  	__virtnet_rx_resume(vi, rq, true);
>  }

so I would add bool to virtnet_rx_resume and call it everywhere,
removing __virtnet_rx_resume. can be a patch on top.

>  
> -- 
> 2.43.0


