Return-Path: <netdev+bounces-110502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FE192CA63
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 08:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1642854D1
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 06:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C4054FAD;
	Wed, 10 Jul 2024 06:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YzXK5JG+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E14151C45
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720591705; cv=none; b=uuAiDZ2rXpx8vqN6pEhmDR6NO7LHy1cjh6oTQl9ZrYedtfqYn/skP+YUJ/D8O0NLfXcTfLvi+a+0j5xPZM8yQsS0JR5sZ3ZBACK1fPK+SDERHZH7oxgDC1PRSG6lNQzvgOJD55JagO+9pJ23AXk+pWcVu6/ucykp3adLftHygvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720591705; c=relaxed/simple;
	bh=0GSnnI2E75/xHcq1KRMe5imkyVdfr9Ns6f6e5UbgkiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGjEHcMnw75xxrAuWZiuHJbr/E89QJGi2BK38+LVqOfU6eCHb9RSaPB2mLbxqf6mMnQqBu+y/1i0BaJCaJvnx10G1f7s/8gpYmAk73mXPw11ieC2mahVN0omYwQFX0B74rm6ahl9e4RpBJMI1KWsWufYqRkXXbtav+dfwX2Q4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YzXK5JG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720591702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+a5Bsaje1eJa/kkPg7uCWmicdAXq2GafTFhZCyZDwSc=;
	b=YzXK5JG+iCS/za/kTeAQPMIF+KrxIeUKnGBEf4DWGl5NEHG+eh299l1IsM70yIWG+DXPZt
	aoKeR5NLg8oM0uPCzX3Q3CsjHROVRGOtIrMxmI/Hja2q62S9Z/lFNwbCZsELNRU2hziTJV
	tb2ibkLLuqJWAAMAsr4m4pn+xN/HoEE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-Zl_ulF0kMRWLsymw5u-CzA-1; Wed, 10 Jul 2024 02:08:20 -0400
X-MC-Unique: Zl_ulF0kMRWLsymw5u-CzA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4265f7f395cso28071955e9.3
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 23:08:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720591695; x=1721196495;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+a5Bsaje1eJa/kkPg7uCWmicdAXq2GafTFhZCyZDwSc=;
        b=tuTDwAByzhK0wsFE4G9RwadF0AI+kX9fzNqqGXakcG4H36vFVcYw0ejQvm6NbPnQHm
         oAoblcUErZd89bTjCQKByWoGyEaf+qds7m4iN3Ith+Kr3PjPye/PK0hIGPsngywC4b/0
         7yASZ126afO8cNUpdPHKq0rCE7AAjChA6d0j9n/SNVK8DMJ0RhlA4KZ5lQrUnSfZybEa
         HCeeYUGEvnj9s/yhTnNIe1jQP/LBDlH1rUF1y7fwKNHIH7tSpUs6Jvie6L+SmC1jB15o
         4B0HDXK8oG1TFSohK8aCfDY90fk/JS6ORp942aI24eITrZj6z/6GpbOlLAef/Y6cil3p
         jm3Q==
X-Gm-Message-State: AOJu0Yxys/xmOnnhZgqCdQ1vNqPhgdjHcJQpIjsO4eZuMAMPyWBZ+vLN
	nxm16rTQbvjOi5DteL7aZRzf66gixPz19nPl6nlTFRdP/hBSXUxb30+PDAhdkC1/AwHKuLmabnr
	etKWQocM0bf4PmrFkjbKxAHFZhx+a0yrFN6/M182MDjvQ9esFCMuOJA==
X-Received: by 2002:a5d:548b:0:b0:362:c7b3:764c with SMTP id ffacd0b85a97d-367ceac47bfmr3031052f8f.48.1720591694648;
        Tue, 09 Jul 2024 23:08:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSNewYLXe+QfNePgWKsGj1IbTMsfyHo7p6gwn0lDSCj5oPC4X9trCqnic5Odo00Hvu/C7feg==
X-Received: by 2002:a5d:548b:0:b0:362:c7b3:764c with SMTP id ffacd0b85a97d-367ceac47bfmr3031020f8f.48.1720591693882;
        Tue, 09 Jul 2024 23:08:13 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cde848e7sm4291385f8f.44.2024.07.09.23.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 23:08:12 -0700 (PDT)
Date: Wed, 10 Jul 2024 02:08:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v8 00/10] virtio-net: support AF_XDP zero copy
Message-ID: <20240710020746-mutt-send-email-mst@kernel.org>
References: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708112537.96291-1-xuanzhuo@linux.alibaba.com>

On Mon, Jul 08, 2024 at 07:25:27PM +0800, Xuan Zhuo wrote:
> v8:
>     1. virtnet_add_recvbuf_xsk() always return err, when encounters error
> 
> v7:
>     1. some small fixes
> 
> v6:
>     1. start from supporting the rx zerocopy
> 
> v5:
>     1. fix the comments of last version
>         http://lore.kernel.org/all/20240611114147.31320-1-xuanzhuo@linux.alibaba.com
> v4:
>     1. remove the commits that introduce the independent directory
>     2. remove the supporting for the rx merge mode (for limit 15
>        commits of net-next). Let's start with the small mode.
>     3. merge some commits and remove some not important commits


Series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ## AF_XDP
> 
> XDP socket(AF_XDP) is an excellent bypass kernel network framework. The zero
> copy feature of xsk (XDP socket) needs to be supported by the driver. The
> performance of zero copy is very good. mlx5 and intel ixgbe already support
> this feature, This patch set allows virtio-net to support xsk's zerocopy xmit
> feature.
> 
> At present, we have completed some preparation:
> 
> 1. vq-reset (virtio spec and kernel code)
> 2. virtio-core premapped dma
> 3. virtio-net xdp refactor
> 
> So it is time for Virtio-Net to complete the support for the XDP Socket
> Zerocopy.
> 
> Virtio-net can not increase the queue num at will, so xsk shares the queue with
> kernel.
> 
> On the other hand, Virtio-Net does not support generate interrupt from driver
> manually, so when we wakeup tx xmit, we used some tips. If the CPU run by TX
> NAPI last time is other CPUs, use IPI to wake up NAPI on the remote CPU. If it
> is also the local CPU, then we wake up napi directly.
> 
> This patch set includes some refactor to the virtio-net to let that to support
> AF_XDP.
> 
> ## Run & Test
> 
> Because there are too many commits, the work of virtio net supporting af-xdp is
> split to rx part and tx part. This patch set is for rx part.
> 
> So the flag NETDEV_XDP_ACT_XSK_ZEROCOPY is not added, if someone want to test
> for af-xdp rx, the flag needs to be adding locally.
> 
> ## performance
> 
> ENV: Qemu with vhost-user(polling mode).
> Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> 
> ### virtio PMD in guest with testpmd
> 
> testpmd> show port stats all
> 
>  ######################## NIC statistics for port 0 ########################
>  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
>  RX-errors: 0
>  RX-nombuf: 0
>  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
> 
> 
>  Throughput (since last show)
>  Rx-pps:   8861574     Rx-bps:  3969985208
>  Tx-pps:   8861493     Tx-bps:  3969962736
>  ############################################################################
> 
> ### AF_XDP PMD in guest with testpmd
> 
> testpmd> show port stats all
> 
>   ######################## NIC statistics for port 0  ########################
>   RX-packets: 68152727   RX-missed: 0          RX-bytes:  3816552712
>   RX-errors: 0
>   RX-nombuf:  0
>   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  3814438152
> 
>   Throughput (since last show)
>   Rx-pps:      6333196          Rx-bps:   2837272088
>   Tx-pps:      6333227          Tx-bps:   2837285936
>   ############################################################################
> 
> But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
> 
> Please review.
> 
> Thanks.
> 
> v3
>     1. virtio introduces helpers for virtio-net sq using premapped dma
>     2. xsk has more complete support for merge mode
>     3. fix some problems
> 
> v2
>     1. wakeup uses the way of GVE. No send ipi to wakeup napi on remote cpu.
>     2. remove rcu. Because we synchronize all operat, so the rcu is not needed.
>     3. split the commit "move to virtio_net.h" in last patch set. Just move the
>        struct/api to header when we use them.
>     4. add comments for some code
> 
> v1:
>     1. remove two virtio commits. Push this patchset to net-next
>     2. squash "virtio_net: virtnet_poll_tx support rescheduled" to xsk: support tx
>     3. fix some warnings
> 
> 
> 
> 
> 
> 
> 
> 
> Xuan Zhuo (10):
>   virtio_net: replace VIRTIO_XDP_HEADROOM by XDP_PACKET_HEADROOM
>   virtio_net: separate virtnet_rx_resize()
>   virtio_net: separate virtnet_tx_resize()
>   virtio_net: separate receive_buf
>   virtio_net: separate receive_mergeable
>   virtio_net: xsk: bind/unbind xsk for rx
>   virtio_net: xsk: support wakeup
>   virtio_net: xsk: rx: support fill with xsk buffer
>   virtio_net: xsk: rx: support recv small mode
>   virtio_net: xsk: rx: support recv merge mode
> 
>  drivers/net/virtio_net.c | 770 ++++++++++++++++++++++++++++++++++-----
>  1 file changed, 676 insertions(+), 94 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


