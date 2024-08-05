Return-Path: <netdev+bounces-115674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF63947775
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3451B280D94
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 08:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B13F14EC7D;
	Mon,  5 Aug 2024 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlqEQqTu"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEDB1149DE3
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 08:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722847174; cv=none; b=UdicbukhM1FRa1ioSFEpq4IuZpCZ+nyd8aP1DwpPLw73RIGTqhA/V9HMdT3arcu9UfjvzUxJlHTy6JH2ti7AA2HtEXTHwkPwqMTA7/Po1dtdpn8JXETy+gDNy6bPJrifBHcXKFfEPfQ20W4Jghsa5dAhXXJrZFeBMHcijQqELsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722847174; c=relaxed/simple;
	bh=2VhGFoDqNEQQcvojz0IpiTyJYqSkpD3J7Qze2aHR3fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QferLs0kRkGsZhrkFb3XRV5KKe/7VMiIGQlEMga7c12dUNR2AY3SLGj0o58wBl+DH5u7HuBofUopWJVq3pkfFtonjqExdyoJxh0DJlpIGXp58ocB2BBQYrhOi3CX+pxTCWEcq+/IP8FB9OAA4foH3zFoWOQwC3hpFpEWrXP0Np8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HlqEQqTu; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722847170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ea4hswH1u1nPlUlDCZA86v40saWII4j79Dw05H185hU=;
	b=HlqEQqTudZTwfRFte6v3aqmUm/xm6hxgqfslGIK/SlkfXmqlQuGn2morkL6a0xzW7T8FSx
	trsg84S6IYz/rtJw6+b+rt3dsUOfctbCUrnOEckjyAKalymt8Pj+NTHpeTstH5B6G1WkpE
	h3IauC+vd43JCj2+MIIxu6FwSmPE1Oo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-ACgHaIH_NC6LzMsaqDg7CA-1; Mon, 05 Aug 2024 04:39:29 -0400
X-MC-Unique: ACgHaIH_NC6LzMsaqDg7CA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-36848f30d39so5441172f8f.3
        for <netdev@vger.kernel.org>; Mon, 05 Aug 2024 01:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722847168; x=1723451968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea4hswH1u1nPlUlDCZA86v40saWII4j79Dw05H185hU=;
        b=auvs8t3zTqI0qTXR519vd2Et7QmfGotlx5JFEZ0rGCp6W2twHNfu6NPAmfxNbxSrj5
         4I0bmNLMH+SPlbQ4uY0MZ1dIkPBrTV1T0PVCK3IfFVnq2IrnL/RbI+1ncH/TG274pr43
         JPM0VIDDl9q6IzxYAA8Y15UlaBlUQCkWdx/rOI3Tyk7xanKIbL7ErXhEs4qP5I7I41Xm
         geg5GfiNvpLT8a4mfWxPEovNUCiedBTMqRRnQoCYOrgLSem/VH7nJM9FsLkYX3oGkW2f
         R3EH6+pwAyZCoZPfNsV4ntq/NdDpNfGAXMQB+faAOWLYWQpzIgJJ/E1pXCk70v48dtBZ
         aPIA==
X-Forwarded-Encrypted: i=1; AJvYcCUMwP4pZ/oRrPoaEV2ut5Qnyvy0vFPbSSKqCAKmEKdEy5ViZwSP+6jloLF3anMa7HA+MZhf70B0ISYYep+tGKhs38iHygFV
X-Gm-Message-State: AOJu0YyyKKfq1T58xbT/I2nQlGlH+uDRtyxnANfAMJsN3bZqejC4rnsH
	Wyn4TbE3iNpU2q8VkGmjt2M+fE3zrIuVsLcz08hSEa90i/TcsBmelGGrvyCGJmiZx28xB09SoaS
	Zw/TRsuTyqY0F49GlRE/JBcr9SbCwlsbcSApGMwucUWnfPVbVusHB2w==
X-Received: by 2002:adf:b196:0:b0:369:b849:61b0 with SMTP id ffacd0b85a97d-36bbc17132dmr7003638f8f.43.1722847168041;
        Mon, 05 Aug 2024 01:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFM8/anathdf0+itad/SmXLJr8Ha3hpgUqxCdeZR+OeBw6j4Do78FnDxdF5vJm5uH7+QdreGg==
X-Received: by 2002:adf:b196:0:b0:369:b849:61b0 with SMTP id ffacd0b85a97d-36bbc17132dmr7003601f8f.43.1722847167114;
        Mon, 05 Aug 2024 01:39:27 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-79.retail.telecomitalia.it. [82.57.51.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36bbd169697sm9050176f8f.107.2024.08.05.01.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Aug 2024 01:39:26 -0700 (PDT)
Date: Mon, 5 Aug 2024 10:39:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: luigi.leonardi@outlook.com, mst@redhat.com
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Pinna <marco.pinn95@gmail.com>
Subject: Re: [PATCH net-next v4 0/2] vsock: avoid queuing on intermediate
 queue if possible
Message-ID: <tblrar34qivcwsvai7z5fepxhi4irknbyne5xqqoqowwf3nwt5@kyd2nmqghews>
References: <20240730-pinna-v4-0-5c9179164db5@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20240730-pinna-v4-0-5c9179164db5@outlook.com>

Hi Michael,
this series is marked as "Not Applicable" for the net-next tree:
https://patchwork.kernel.org/project/netdevbpf/patch/20240730-pinna-v4-2-5c9179164db5@outlook.com/

Actually this is more about the virtio-vsock driver, so can you queue 
this on your tree?

Thanks,
Stefano

On Tue, Jul 30, 2024 at 09:47:30PM GMT, Luigi Leonardi via B4 Relay wrote:
>This series introduces an optimization for vsock/virtio to reduce latency
>and increase the throughput: When the guest sends a packet to the host,
>and the intermediate queue (send_pkt_queue) is empty, if there is enough
>space, the packet is put directly in the virtqueue.
>
>v3->v4
>While running experiments on fio with 64B payload, I realized that there
>was a mistake in my fio configuration, so I re-ran all the experiments
>and now the latency numbers are indeed lower with the patch applied.
>I also noticed that I was kicking the host without the lock.
>
>- Fixed a configuration mistake on fio and re-ran all experiments.
>- Fio latency measurement using 64B payload.
>- virtio_transport_send_skb_fast_path sends kick with the tx_lock acquired
>- Addressed all minor style changes requested by maintainer.
>- Rebased on latest net-next
>- Link to v3: https://lore.kernel.org/r/20240711-pinna-v3-0-697d4164fe80@outlook.com
>
>v2->v3
>- Performed more experiments using iperf3 using multiple streams
>- Handling of reply packets removed from virtio_transport_send_skb,
>  as is needed just by the worker.
>- Removed atomic_inc/atomic_sub when queuing directly to the vq.
>- Introduced virtio_transport_send_skb_fast_path that handles the
>  steps for sending on the vq.
>- Fixed a missing mutex_unlock in error path.
>- Changed authorship of the second commit
>- Rebased on latest net-next
>
>v1->v2
>In this v2 I replaced a mutex_lock with a mutex_trylock because it was
>insidea RCU critical section. I also added a check on tx_run, so if the
>module is being removed the packet is not queued. I'd like to thank Stefano
>for reporting the tx_run issue.
>
>Applied all Stefano's suggestions:
>    - Minor code style changes
>    - Minor commit text rewrite
>Performed more experiments:
>     - Check if all the packets go directly to the vq (Matias' suggestion)
>     - Used iperf3 to see if there is any improvement in overall throughput
>      from guest to host
>     - Pinned the vhost process to a pCPU.
>     - Run fio using 512B payload
>Rebased on latest net-next
>
>---
>Luigi Leonardi (1):
>      vsock/virtio: avoid queuing packets when intermediate queue is empty
>
>Marco Pinna (1):
>      vsock/virtio: refactor virtio_transport_send_pkt_work
>
> net/vmw_vsock/virtio_transport.c | 144 +++++++++++++++++++++++++--------------
> 1 file changed, 94 insertions(+), 50 deletions(-)
>---
>base-commit: 1722389b0d863056d78287a120a1d6cadb8d4f7b
>change-id: 20240730-pinna-db8cc1b8b037
>
>Best regards,
>-- 
>Luigi Leonardi <luigi.leonardi@outlook.com>
>
>
>


