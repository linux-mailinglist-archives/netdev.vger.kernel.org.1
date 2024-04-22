Return-Path: <netdev+bounces-90261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 912998AD5D5
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 22:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2DB71C20E8E
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 20:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFDBB1B27D;
	Mon, 22 Apr 2024 20:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DWOKWPLL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32E318AED
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 20:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713817991; cv=none; b=Hmfwie8p4mPGzGiPQ+KstjlXB5Ej8XajtBCiRvmRSlR9akfsal+OmfMvkt5ZcC837l7yhFanGgeGTUelYm+TS0gOeZSQPyJkyzed4WzDGOk1moRWZ/30KYquuR9kjQRBcbKtovQzdojBqIXadf8xVmDEiPhEhnnuLMgWjX2gVvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713817991; c=relaxed/simple;
	bh=KqhvRyISK1EHaG9zl8kIq3kWh+TdLSJYaYopZ3MG8gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QiIzTLRUyYHygR6wGnkkQwJTmtMpKapwgbI52r2yB5v3nQ8ps0QutykxyD9IdR/E0gaAnMWihJ0t0vAzRi/OHRWRALv+3WNuDolXAnVmKFcOCFZwCrj2X8U/BIQY9mUPbuzWVEMgYcapxX6C2TpsA2ev5wsqx/+8zkcJO5i7s7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DWOKWPLL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713817988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EeyR+70OptlQkVxKAvnuj7vbjWDT7scfNFidnBSfS2Y=;
	b=DWOKWPLLkJ/PKrcnQ2ao6QKHB8tAJbi2V+5NTIjSHB83cDBZU3tiTgJKqVsA0nZFBy9yLa
	ciM1Wr7ZTjpOrwAZxSw4uHduT0c/7MX+RtbCUpM96I9eQgD2lDFUzDumKKQ5kruCbheAmi
	/F7fDK2EHdpb+Vo/nyc7L1UWocV9Gxw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-h3qfvb4EM0uvb9lPhPXgFQ-1; Mon, 22 Apr 2024 16:33:07 -0400
X-MC-Unique: h3qfvb4EM0uvb9lPhPXgFQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-349e1effeb5so2652854f8f.1
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 13:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713817986; x=1714422786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EeyR+70OptlQkVxKAvnuj7vbjWDT7scfNFidnBSfS2Y=;
        b=dRWfLHi53Dt0PhcvDe9sQMg11wZlsjApjY2LaS7eYBrr3TAsRTg5kNWcN44U1v1kn6
         3CDxnWV/+l2C7Jc828vTc3Z9/L/w905HP9j3X72qnSiw72dAkZo0chqppbCMCFNwYp22
         9Ka9hM3wEBu963wWZSrvWWWJsO8Ux0gh5anfeOt1bqm751pZrtzh8Xm+lep7FmJAu9p9
         Xm+0te+Na2z/CdQr5axOPB6o/JHcy5v49b4nPuFSONPWEP+fDDLbK84eUXPIGUZY4QiO
         hWCMPL4Uqcy947/TEHMNCQBOfTayG1qm50uXb98q8hkJTY3x3ng6DDZYlMwkClhQNN3G
         ixSg==
X-Gm-Message-State: AOJu0YxZ36vg/k9m/kkERQN0O8fBOrwaCMvpoKLc6GPHSVG7Tobehqxq
	OiCaeL1jF719LjLXWVRXZSnWBgbqHq8BnUH2ike73ynYBiZJ9P+DBIUkJbULDzSctZNALgv4C7Q
	R1QKexyC47SFRU+JYGGjlQvFBj+LaE4fIyNs4kBsNWatC323Em28E2Q==
X-Received: by 2002:a5d:6943:0:b0:34a:6fac:6dab with SMTP id r3-20020a5d6943000000b0034a6fac6dabmr476176wrw.12.1713817986164;
        Mon, 22 Apr 2024 13:33:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmzrgS1Q5fYLISgd6tnTSj92DeDd/SrzJRUtL+0gJCJre6GoMQFEDaR+tJbaeWCrcYkPRbDg==
X-Received: by 2002:a5d:6943:0:b0:34a:6fac:6dab with SMTP id r3-20020a5d6943000000b0034a6fac6dabmr476147wrw.12.1713817985564;
        Mon, 22 Apr 2024 13:33:05 -0700 (PDT)
Received: from redhat.com ([2a06:c701:7429:3c00:dc4a:cd5:7b1c:f7c2])
        by smtp.gmail.com with ESMTPSA id ju12-20020a05600c56cc00b0041a68d4fe61sm52531wmb.0.2024.04.22.13.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 13:33:04 -0700 (PDT)
Date: Mon, 22 Apr 2024 16:33:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	virtualization@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH net-next v5 0/9] virtio-net: support device stats
Message-ID: <20240422163231-mutt-send-email-mst@kernel.org>
References: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318110602.37166-1-xuanzhuo@linux.alibaba.com>

On Mon, Mar 18, 2024 at 07:05:53PM +0800, Xuan Zhuo wrote:
> As the spec:
> 
> https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> 
> The virtio net supports to get device stats.
> 
> Please review.

series:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I think you can now repost for net-next.


> Thanks.
> 
> v5:
>     1. Fix some small problems in last version
>     2. Not report stats that will be reported by netlink
>     3. remove "_queue" from  ethtool -S
> 
> v4:
>     1. Support per-queue statistics API
>     2. Fix some small problems in last version
> 
> v3:
>     1. rebase net-next
> 
> v2:
>     1. fix the usage of the leXX_to_cpu()
>     2. add comment to the structure virtnet_stats_map
> 
> v1:
>     1. fix some definitions of the marco and the struct
> 
> 
> 
> 
> 
> 
> Xuan Zhuo (9):
>   virtio_net: introduce device stats feature and structures
>   virtio_net: virtnet_send_command supports command-specific-result
>   virtio_net: remove "_queue" from ethtool -S
>   virtio_net: support device stats
>   virtio_net: stats map include driver stats
>   virtio_net: add the total stats field
>   virtio_net: rename stat tx_timeout to timeout
>   netdev: add queue stats
>   virtio-net: support queue stat
> 
>  Documentation/netlink/specs/netdev.yaml | 104 ++++
>  drivers/net/virtio_net.c                | 755 +++++++++++++++++++++---
>  include/net/netdev_queues.h             |  27 +
>  include/uapi/linux/netdev.h             |  19 +
>  include/uapi/linux/virtio_net.h         | 143 +++++
>  net/core/netdev-genl.c                  |  23 +-
>  tools/include/uapi/linux/netdev.h       |  19 +
>  7 files changed, 1013 insertions(+), 77 deletions(-)
> 
> --
> 2.32.0.3.g01195cf9f


