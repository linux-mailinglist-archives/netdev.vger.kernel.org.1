Return-Path: <netdev+bounces-75879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FB986B734
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 19:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F6AB216D7
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 18:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B224C71EA8;
	Wed, 28 Feb 2024 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbG9uOYs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4304084F
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 18:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709145071; cv=none; b=F4vIRawmNAk4Bw+2DFivmYl3ef85jN2YCKaNvL7Ouh1a6ZMcgp6BA9UFXWUWapK16hqZeTUxDbvhL16YfffxQk7XDUzmAite4046zYqA95NuyAfoVFzEqOMJWN+i16cNpDwoE6TSvCixxJPvgD5eZHHPeUmui9nQKJlx+bW4qlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709145071; c=relaxed/simple;
	bh=s/2MSjG8UyaUs97mrM1q6zQgCW0Xk0or22c3BdoaHmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1cFNiGeP2WkZ6b3L1xzNuP0TuXshvw2TrBTm5SsuiaTPJWJWH0qhFm5q5swGkxhe+aeHS9gVo0rQS2LqULfipGPCoNoQWGp7Wz24AKGv8mD4/MbArPpv+NCcrqOL57wGnvgYs7ucJqomBAMVWwj9RHgmjFAJzjBpdn427I9EFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bbG9uOYs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709145068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=weArB08m8SQ4hme6AVbC9RsZWLdEnvH6fsjtADsJEm8=;
	b=bbG9uOYs5e/eFxyr/drVE+4CE8YHANICxX4H6wuIpnNSDHTUjQCLg9ZnKVE9887VIqyuwb
	P/8TNB8ng9Hv412MjXs3zY53kpvOZHezrxqK+zZypRFk8FahYX3GgwgGij+KgjKl2+pnc5
	gv5RrJuidaVw6+h9TzEmK0xcIB3r2w8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-xjKINBrnNlKyGQfir5jjaQ-1; Wed, 28 Feb 2024 13:31:07 -0500
X-MC-Unique: xjKINBrnNlKyGQfir5jjaQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-337a9795c5cso41557f8f.2
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 10:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709145066; x=1709749866;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=weArB08m8SQ4hme6AVbC9RsZWLdEnvH6fsjtADsJEm8=;
        b=tu83G2zJYn5dsT0nwH0rba6OD9D/FdWzmVfCWnATjhIz7hp8GtL/uex/HpshINr7nK
         5G4rXJsRsIasbHPTvw+c3k97sgn/NS23qESkH9iG4jR0XwO0KnPx3EzaC+s4plF9jS5q
         /+5MDkCkftla2mzjBuF0RWtiafRAh4hdxC5ZTThwzcUruo7k8e8pL+MTYF5Nrwq/nB/d
         TsLSaVSbSr+RnB2lK5r2zZGCWTLynzBtjVlKkujpvS6ip4WSBgtaYEEbTQTwqU3sYCOH
         YRIAg5Uu+hIQeNAUksgTWHhZDeoa8NLLzZHupHmV8VIU9AYqvPr/7QV112VcuQRdLHJI
         JlMw==
X-Forwarded-Encrypted: i=1; AJvYcCUqQ49BNNULQ78ePlshgUwkjKXUOkJOYjYQhqnZVV1jqIVA1uOtm7OVvmh3JwvGB92kQUzEIZjEZ8hfJKTCGIfQwnQ9sMO1
X-Gm-Message-State: AOJu0YzWuZGMsVAMQrC+jej2ps7tmzWCNFp2C9aady1yHuSUJNdZ9rQ9
	D5huz8BrbV8YExy799yt3TIFdIiXtUVXPBjnKvl1aWMOmOdHyuTSPysNUArZ4K77FChdk04drWZ
	4EC+Ey2E4GRmBCxIf3aVGQZV9MA+RqQKSI4jaowv2G5nddO+HDmVclg==
X-Received: by 2002:adf:9bdc:0:b0:33d:50cd:4672 with SMTP id e28-20020adf9bdc000000b0033d50cd4672mr256191wrc.21.1709145066137;
        Wed, 28 Feb 2024 10:31:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbucOOcYdc5E7w1hWPrlSDUK3hHwk9fJn5afQ97oLMcIn3c+BDLdxi5c2NUzfMbk+v1xT5yw==
X-Received: by 2002:adf:9bdc:0:b0:33d:50cd:4672 with SMTP id e28-20020adf9bdc000000b0033d50cd4672mr256168wrc.21.1709145065820;
        Wed, 28 Feb 2024 10:31:05 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:d6b0:a21c:61c4:2098:5db])
        by smtp.gmail.com with ESMTPSA id bx10-20020a5d5b0a000000b0033b2799815csm15646500wrb.86.2024.02.28.10.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 10:31:05 -0800 (PST)
Date: Wed, 28 Feb 2024 13:31:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, kuba@kernel.org,
	bjorn@kernel.org, magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com,
	davem@davemloft.net, bpf@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, xudingke@huawei.com,
	liwei395@huawei.com
Subject: Re: [PATCH net-next v2 0/3] tun: AF_XDP Tx zero-copy support
Message-ID: <20240228133035-mutt-send-email-mst@kernel.org>
References: <1709118281-125508-1-git-send-email-wangyunjian@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1709118281-125508-1-git-send-email-wangyunjian@huawei.com>

On Wed, Feb 28, 2024 at 07:04:41PM +0800, Yunjian Wang wrote:
> Hi all:
> 
> Now, some drivers support the zero-copy feature of AF_XDP sockets,
> which can significantly reduce CPU utilization for XDP programs.
> 
> This patch set allows TUN to also support the AF_XDP Tx zero-copy
> feature. It is based on Linux 6.8.0+(openEuler 23.09) and has
> successfully passed Netperf and Netserver stress testing with
> multiple streams between VM A and VM B, using AF_XDP and OVS.
> 
> The performance testing was performed on a Intel E5-2620 2.40GHz
> machine. Traffic were generated/send through TUN(testpmd txonly
> with AF_XDP) to VM (testpmd rxonly in guest).
> 
> +------+---------+---------+---------+
> |      |   copy  |zero-copy| speedup |
> +------+---------+---------+---------+
> | UDP  |   Mpps  |   Mpps  |    %    |
> | 64   |   2.5   |   4.0   |   60%   |
> | 512  |   2.1   |   3.6   |   71%   |
> | 1024 |   1.9   |   3.3   |   73%   |
> +------+---------+---------+---------+
> 
> Yunjian Wang (3):
>   xsk: Remove non-zero 'dma_page' check in xp_assign_dev
>   vhost_net: Call peek_len when using xdp
>   tun: AF_XDP Tx zero-copy support


threading broken pls repost.

vhost bits look ok though:

Acked-by: Michael S. Tsirkin <mst@redhat.com>


>  drivers/net/tun.c       | 177 ++++++++++++++++++++++++++++++++++++++--
>  drivers/vhost/net.c     |  21 +++--
>  include/linux/if_tun.h  |  32 ++++++++
>  net/xdp/xsk_buff_pool.c |   7 --
>  4 files changed, 220 insertions(+), 17 deletions(-)
> 
> -- 
> 2.41.0


