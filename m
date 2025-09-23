Return-Path: <netdev+bounces-225651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E66E4B9675C
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D0501890DF0
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFEC257437;
	Tue, 23 Sep 2025 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TbjMbsk7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EB4246BC6
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758639367; cv=none; b=P1p1v6ms1Qm9fXnHikeqgwphcbAooM5g3b42f0kYCJTybVq23ZJycHheTpoWRS7jrq6wE7iElforf0/XUo3sB9eVlncswhxstlgjY/IxkKA4rgG1BaZMz6KHQfA4I+EtolsZtOWzfCfaeb+pf4hI2e4QJEIqFMFR5sjImbxULFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758639367; c=relaxed/simple;
	bh=Fb1uhC1Ro6yKwWQ8B7TuxwJriFbcuxwlarRa5XRvPXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vztwgzz/z67/rSWx2QzhFBvKlPSRV7bgZi+x1WMGhgSBSb1/Jc1Du2k2gLg+B1fJF1qqQ6uGKD0gm4cYwEUDTaPsaV7BL8O/Q99oMUaEjANDHS8vs+rCQdiCnNHmZDvByj5cg38ebI705iOEGTQRJiDDyW78lkjHaUtiIGixbfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TbjMbsk7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758639365;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5fPi7xAaBYq3WsMqtUZHvUEGBGO+Ny8pTqCXAU3RHGc=;
	b=TbjMbsk7UvkwLM4i9UIRBq2K9Xx9MBbSBJjeUIkEmft35+NpXy4s9vC9I8ys7wkPHeTB+l
	HqUrdlYpJ8PGgtZ1gBJS9+fwsY45CmhXIF7yg/AKX4n3YsDVqiUfrY5wRDOoc7pM+BYjZU
	Gr3g8OXi81YB3R1GQxyBZ+9+/7HfVXg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-D8X7hduhOCe_k5Tv96l2SA-1; Tue, 23 Sep 2025 10:56:04 -0400
X-MC-Unique: D8X7hduhOCe_k5Tv96l2SA-1
X-Mimecast-MFC-AGG-ID: D8X7hduhOCe_k5Tv96l2SA_1758639363
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f93db57449so1721687f8f.2
        for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 07:56:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758639362; x=1759244162;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5fPi7xAaBYq3WsMqtUZHvUEGBGO+Ny8pTqCXAU3RHGc=;
        b=JkFc43yxdmel6AlNnTM0oM9tuQB0IlEPO2cNzZYfyV7HKYMwMwjTjI0N3goRjlT+7F
         3dRmOLNbhUCkdN5tPpJsp3bIVEXw8nI8Egwqy3l235reQOH89xSLakPQVJW1i3uW89mL
         yatrxudiG/hz6QJu1UKLsGuRBWk1n2prUPXDQXIncLe8hnHtMFTFBb6mR3VZWQfgTgC6
         BNZG7pxZBz91lqVpZDtNjxahCAczigNcAg5R0xnexqziUQDinjSrit+WaswnrR8Ey1/u
         IDlMVNflABxgN6kW/IuD5/gxaKXy/KmvGd1AfjoWOXtIyV3KH1fD40xCLRYqOBZVHoTs
         ka0A==
X-Forwarded-Encrypted: i=1; AJvYcCXRXZ+046wt24YSAKTitTnq84FcguYZpBaxzPZYtNDjt3U7zxV6cZK6q6LN2d33JWyH1kmuCM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YweZTzJ/opoaMQMrXEx9l2VtxCroDobMb45Q6lyTxRLW/GwOvxJ
	CTuDKZQBZkg0YoKnK0YH3TKkIbvrs8wNyS5DcvSBSNpAoLfWjRGOku0c8ZPVUSqUTcHFUMwrt6m
	wkBBoFoX55RiQsUDs4igFcADALI+lX21LmsjayG4ajCBlrclEI2iFy1qnQkFQRV+cTw==
X-Gm-Gg: ASbGncu34uiGTDYLR3PAcYQCvcpR+OYRdrkisuJbAZCrCx3TqrDNVAqXl4OAGJnBEmQ
	oZohx3MkuFeMc19wTIbjlm49b3ybP3hk0VGkPN4xC4wX1p/lRESlLnP6oaljg2LjZZi8Kh+lVbG
	Z8eYDxIrdGw5ic7PU32z0gwS4v97o94qJpE3pKw/k0zCi36vgIIPPw7l/q+xtox5p+3YdHwH6wU
	pPmohZ9BrtM80BIY7cEcbL4Hmtn9d/3Hz1t2oYYODw7fAr4URguD54oonSyEniem7UTynDhBajq
	UjvfZBwg3qKnSCUJjDhNJU9NdFsONFzRJog=
X-Received: by 2002:a05:6000:2512:b0:3de:b99d:d43 with SMTP id ffacd0b85a97d-405c4e69165mr1936095f8f.19.1758639362484;
        Tue, 23 Sep 2025 07:56:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI608jmUOJxqolkRThwXGIz6WcWPRm1xMW7bb+S6ovrbmwhS1tKBnhb5RWOn1sd8hG+adswQ==
X-Received: by 2002:a05:6000:2512:b0:3de:b99d:d43 with SMTP id ffacd0b85a97d-405c4e69165mr1936076f8f.19.1758639361944;
        Tue, 23 Sep 2025 07:56:01 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:f900:52ee:df2b:4811:77e0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-464f0d8a2bfsm257593255e9.2.2025.09.23.07.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:56:01 -0700 (PDT)
Date: Tue, 23 Sep 2025 10:55:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
	eperezma@redhat.com, stephen@networkplumber.org, leiyang@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, kvm@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/8] TUN/TAP & vhost_net: netdev queue flow
 control to avoid ptr_ring tail drop
Message-ID: <20250923105531-mutt-send-email-mst@kernel.org>
References: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250922221553.47802-1-simon.schippers@tu-dortmund.de>

On Tue, Sep 23, 2025 at 12:15:45AM +0200, Simon Schippers wrote:
> This patch series deals with TUN, TAP and vhost_net which drop incoming 
> SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
> patch series, the associated netdev queue is stopped before this happens. 
> This allows the connected qdisc to function correctly as reported by [1] 
> and improves application-layer performance, see our paper [2]. Meanwhile 
> the theoretical performance differs only slightly:
> 
> +------------------------+----------+----------+
> | pktgen benchmarks      | Stock    | Patched  |
> | i5 6300HQ, 20M packets |          |          |
> +------------------------+----------+----------+
> | TAP                    | 2.10Mpps | 1.99Mpps |
> +------------------------+----------+----------+
> | TAP+vhost_net          | 6.05Mpps | 6.14Mpps |
> +------------------------+----------+----------+
> | Note: Patched had no TX drops at all,        |
> | while stock suffered numerous drops.         |
> +----------------------------------------------+
> 
> This patch series includes TUN, TAP, and vhost_net because they share 
> logic. Adjusting only one of them would break the others. Therefore, the 
> patch series is structured as follows:
> 1+2: New ptr_ring helpers for 3 & 4
> 3: TUN & TAP: Stop netdev queue upon reaching a full ptr_ring


so what happens if you only apply patches 1-3?

> 4: TUN & TAP: Wake netdev queue after consuming an entry
> 5+6+7: TUN & TAP: ptr_ring wrappers and other helpers to be called by 
> vhost_net
> 8: vhost_net: Call the wrappers & helpers
> 
> Possible future work:
> - Introduction of Byte Queue Limits as suggested by Stephen Hemminger
> - Adaption of the netdev queue flow control for ipvtap & macvtap
> 
> [1] Link: 
> https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
> [2] Link: 
> https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf
> 
> Links to previous versions:
> V4: 
> https://lore.kernel.org/netdev/20250902080957.47265-1-simon.schippers@tu-dortmund.de/T/#u
> V3: 
> https://lore.kernel.org/netdev/20250825211832.84901-1-simon.schippers@tu-dortmund.de/T/#u
> V2: 
> https://lore.kernel.org/netdev/20250811220430.14063-1-simon.schippers@tu-dortmund.de/T/#u
> V1: 
> https://lore.kernel.org/netdev/20250808153721.261334-1-simon.schippers@tu-dortmund.de/T/#u
> 
> Changelog:
> V4 -> V5:
> - Stop the netdev queue prior to producing the final fitting ptr_ring entry
> -> Ensures the consumer has the latest netdev queue state, making it safe 
> to wake the queue
> -> Resolves an issue in vhost_net where the netdev queue could remain 
> stopped despite being empty
> -> For TUN/TAP, the netdev queue no longer needs to be woken in the 
> blocking loop
> -> Introduces new helpers __ptr_ring_full_next and 
> __ptr_ring_will_invalidate for this purpose
> 
> - vhost_net now uses wrappers of TUN/TAP for ptr_ring consumption rather 
> than maintaining its own rx_ring pointer
> 
> V3 -> V4:
> - Target net-next instead of net
> - Changed to patch series instead of single patch
> - Changed to new title from old title
> "TUN/TAP: Improving throughput and latency by avoiding SKB drops"
> - Wake netdev queue with new helpers wake_netdev_queue when there is any 
> spare capacity in the ptr_ring instead of waiting for it to be empty
> - Use tun_file instead of tun_struct in tun_ring_recv as a more consistent 
> logic
> - Use smp_wmb() and smp_rmb() barrier pair, which avoids any packet drops 
> that happened rarely before
> - Use safer logic for vhost_net using RCU read locks to access TUN/TAP data
> 
> V2 -> V3: Added support for TAP and TAP+vhost_net.
> 
> V1 -> V2: Removed NETDEV_TX_BUSY return case in tun_net_xmit and removed 
> unnecessary netif_tx_wake_queue in tun_ring_recv.
> 
> Thanks,
> Simon :)
> 
> Simon Schippers (8):
>   __ptr_ring_full_next: Returns if ring will be full after next
>     insertion
>   Move the decision of invalidation out of __ptr_ring_discard_one
>   TUN, TAP & vhost_net: Stop netdev queue before reaching a full
>     ptr_ring
>   TUN & TAP: Wake netdev queue after consuming an entry
>   TUN & TAP: Provide ptr_ring_consume_batched wrappers for vhost_net
>   TUN & TAP: Provide ptr_ring_unconsume wrappers for vhost_net
>   TUN & TAP: Methods to determine whether file is TUN/TAP for vhost_net
>   vhost_net: Replace rx_ring with calls of TUN/TAP wrappers
> 
>  drivers/net/tap.c        | 115 +++++++++++++++++++++++++++++++--
>  drivers/net/tun.c        | 136 +++++++++++++++++++++++++++++++++++----
>  drivers/vhost/net.c      |  90 +++++++++++++++++---------
>  include/linux/if_tap.h   |  15 +++++
>  include/linux/if_tun.h   |  18 ++++++
>  include/linux/ptr_ring.h |  54 +++++++++++++---
>  6 files changed, 367 insertions(+), 61 deletions(-)
> 
> -- 
> 2.43.0


