Return-Path: <netdev+bounces-185523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1403AA9AC65
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 13:49:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BFA91B668DC
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 11:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372A322F75E;
	Thu, 24 Apr 2025 11:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iKwecSQj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8D922B590
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745495341; cv=none; b=rEajBqA/5utg4dmkmOOC95WjjeZk0l+ZgL0du4lyfgOm2VeraZ8dhytdM/LINJlNqTQWGZzAAkA+hnwXQX8Ml278EN+uZZpFVLqDW+twlA+P5Fiu3c3Z275HP7PB2KbViUGcwOuLuBEhUrxqr93cPN5r+He3kQrmN7ATYmk+M5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745495341; c=relaxed/simple;
	bh=8b1jn4QM3miujpAVj4Ao/BPpGT15pdXb8SsrQOErUjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GjHYvfhzTp3jtuVy8AGI8X9k+yJ1WbxoyTpJJ43TO+CsVkBHjVK1P1BHxwsdHG46+TzYVEc5lUgcKR7cdvM2FoIYo+wZy3b5QTDr9DsVpMHjMnv5CGzh3HDanMkYKRRuzH0/r80GTo+nvxfB3MEzCF2lViLi7eWV/rL+iduzOZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iKwecSQj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745495338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4htAbypt1PAw8cs1ZfgYILn5gui78YIttCMWVT2xuTY=;
	b=iKwecSQj4yu2VFFcDETPL+F0SBFp6lwhEWPiN/F/s39NuBAvkVfsWQhNGizpkgT4Zrz0e/
	6nj1BXZYxzl2JnehFShoSXSwMkhkpMCtdiXAOnFaIYmxFz1i2SmJ/RYSm1RbrWrUOWK0vL
	1+IAbCE5nZB+V/+iaJDMALyWGQ2kA2Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-cJcZGAzZOzeepeMTxdeLdg-1; Thu, 24 Apr 2025 07:48:56 -0400
X-MC-Unique: cJcZGAzZOzeepeMTxdeLdg-1
X-Mimecast-MFC-AGG-ID: cJcZGAzZOzeepeMTxdeLdg_1745495336
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43e9a3d2977so6749275e9.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 04:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745495335; x=1746100135;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4htAbypt1PAw8cs1ZfgYILn5gui78YIttCMWVT2xuTY=;
        b=nYSbK/ei/0XstUUNzsCflRygeG6PgOt+6SOf8H0W+X3/1Z0/9o4npU1l795pxLzmd9
         YcxP9n0Ir98vQ1tX9HYJ3VfBa6+8qKxAsIyUOE1NA4HJvNQODh6FbB9YbdnFGoIL28Qc
         EJNdmeaETqUmGH+5hcZCKJQBcJ2pFW7Odgof8t7HR76loWWCilnVFy17+O3fPo/xkbJC
         gjZuFO7I71qseHPPvmmGWWeIhRB6L8NMqXdLakzvUa1pb5Tgs9oVT/FscdVmWROgTVeB
         aa09WkmX4y1tQG+WWCosJvwTd3luQQCnD1KtE0BsLcy6nuqol2iig8NMoAe8r1H4wyRR
         JFIg==
X-Forwarded-Encrypted: i=1; AJvYcCWYzmJ3Mtxiy2MNntsaQqyQPqbDXboDN0xlYYI/i1tsC1+qIKdTJjxT1MPJrX8v6IJDiSgbajY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUeMKm9iYeN4ecLxc6sK0wQ7tXZ7Yz4iwjUGj250yn5KqkCwbV
	JAjUHGx53htvyfYLwaxqPP/YMNih93kGDzkgSulHA4W02x7QFU16Qe+0e1xVTBurrzFidw1PDYc
	HEKVIcu6GJuLi+yeTygkP9KKoP2mxGYnzWzmvggYqzhpzzsxJooP/2V2Z76VtDQ==
X-Gm-Gg: ASbGnctVjos7wgm5pfdo1iz28jbmcGY1QAOqOxXO1VuhRnlyeRmOi+iBIVcX9gHUJW3
	NMFtiDctuZ4y1CWRTffpYblMOFd17GHVFzgaj/JJK7BY4NXiZYad4pw0yTanvKclTUFsguqV89g
	4jdjDGS6H0TXbKPqHXmwlPSdgyhxlsd+mfKa9K591rp+Bxcc3+HPSeS2qEMiiJOv4TmZqMlHheN
	GJeR8ZcO0iKHuaiOX3sXXS7dr+BhOtcIMWrI2hg9rPxM913Dwx41e0iV5giSeyfn0rtOyYoaqhP
	GUhL0Q7ekEH3zbDBZFejXErUZ+SlKB2QGY6vDbE=
X-Received: by 2002:a05:600c:1d02:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-4409bdae980mr22059485e9.27.1745495335341;
        Thu, 24 Apr 2025 04:48:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUZLkMc35rnp4BTi5uk6IdrLmESnS6O2NJ+BKK5UJ777FxcQysn8JyDJpuHccKf//6qU8xMA==
X-Received: by 2002:a05:600c:1d02:b0:43d:738:4a9 with SMTP id 5b1f17b1804b1-4409bdae980mr22059295e9.27.1745495334986;
        Thu, 24 Apr 2025 04:48:54 -0700 (PDT)
Received: from [192.168.88.253] (146-241-7-183.dyn.eolo.it. [146.241.7.183])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d29b990sm19004865e9.4.2025.04.24.04.48.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Apr 2025 04:48:54 -0700 (PDT)
Message-ID: <a0894275-6b23-4cff-9e36-a635f776c403@redhat.com>
Date: Thu, 24 Apr 2025 13:48:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] vhost/net: Defer TX queue re-enable until
 after sendmsg
To: Jon Kohler <jon@nutanix.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250420010518.2842335-1-jon@nutanix.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250420010518.2842335-1-jon@nutanix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/20/25 3:05 AM, Jon Kohler wrote:
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index b9b9e9d40951..9b04025eea66 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -769,13 +769,17 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  			break;
>  		/* Nothing new?  Wait for eventfd to tell us they refilled. */
>  		if (head == vq->num) {
> +			/* If interrupted while doing busy polling, requeue
> +			 * the handler to be fair handle_rx as well as other
> +			 * tasks waiting on cpu
> +			 */
>  			if (unlikely(busyloop_intr)) {
>  				vhost_poll_queue(&vq->poll);
> -			} else if (unlikely(vhost_enable_notify(&net->dev,
> -								vq))) {
> -				vhost_disable_notify(&net->dev, vq);
> -				continue;
>  			}
> +			/* Kicks are disabled at this point, break loop and
> +			 * process any remaining batched packets. Queue will
> +			 * be re-enabled afterwards.
> +			 */
>  			break;
>  		}

It's not clear to me why the zerocopy path does not need a similar change.

> @@ -825,7 +829,14 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  		++nvq->done_idx;
>  	} while (likely(!vhost_exceeds_weight(vq, ++sent_pkts, total_len)));
>  
> +	/* Kicks are still disabled, dispatch any remaining batched msgs. */
>  	vhost_tx_batch(net, nvq, sock, &msg);
> +
> +	/* All of our work has been completed; however, before leaving the
> +	 * TX handler, do one last check for work, and requeue handler if
> +	 * necessary. If there is no work, queue will be reenabled.
> +	 */
> +	vhost_net_busy_poll_try_queue(net, vq);

This will call vhost_poll_queue() regardless of the 'busyloop_intr' flag
value, while AFAICS prior to this patch vhost_poll_queue() is only
performed with busyloop_intr == true. Why don't we need to take care of
such flag here?

@Michael: I assume you prefer that this patch will go through the
net-next tree, right?

Thanks,

Paolo


