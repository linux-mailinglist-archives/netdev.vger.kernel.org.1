Return-Path: <netdev+bounces-104769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD92F90E495
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 09:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 796AB281C50
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 07:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761F8763FD;
	Wed, 19 Jun 2024 07:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="biCAPZCW"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA397605E
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 07:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718782433; cv=none; b=lf9Yq43By3j3l2Emlf9VvVbQ7WwyVJoBsrkzMBR9IWrf/vQZMDE5oKJtDnmlnjgxobUmuPYrPN+kmW/JPaDiHSIlHTAlvcQgJnzaq9VwJnfQELyM+HqBeCF3p1TJhKGZnmUjeKk1T/0jXsbpKniT1lI5iR7G7GrLX0z91lhBGpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718782433; c=relaxed/simple;
	bh=W2cDg518e581hDz31yGUvF8ihm6FBKBrxwwd3eGl5NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C3WM7D6RtfyI2ZuuqRrWA5SQgUZhGXysJJ2lGrWOpDV6+Yy2moQEns7X+X90EABQkjlatzIo/Wlql0guMv7w9h52LQ359zjcFyG43F7iLLfKU06wwOGZs3X2RAzS7i0TLAeuJHIUB6VpiAva/3997jc+JmBsoaJToPy8MdHH+I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=biCAPZCW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718782430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Md0vF9O8pNOYQj1jtiBKod/l0YrOJ08HFOMaLCALqPs=;
	b=biCAPZCW+H/gE7YZALUh2hklkIFiHgha7DGBaErh3yjpkwWpS/xi+XZtPl0Pm9OcJbyHC4
	nwNiOqrxpMNWcRVye5bQ5W/j4icG0k/+yLG3HirBhAJAYvOp8L1vTKX567X7JiRlKWBEZZ
	HWCFLxDmw56+ivFNsXwW+Mc2EwHuNP0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-ODL1UY0AOLaoh9ALKUX9HQ-1; Wed, 19 Jun 2024 03:33:47 -0400
X-MC-Unique: ODL1UY0AOLaoh9ALKUX9HQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4229a964745so37767765e9.2
        for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 00:33:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718782426; x=1719387226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Md0vF9O8pNOYQj1jtiBKod/l0YrOJ08HFOMaLCALqPs=;
        b=FpMuMnyKSuRgelWGERYV7sVdocYFu9f34OizxJMgWHRdfDw5w8eUuULIIg2GTAUm/V
         FDTBiP+yj7dRv2OEUeHk6qKmouKYHB5eAsNlINYtZZ62l8DDfvAYvthUTxlL38iir/Xc
         gMtisPnB9e+zcybSmBBtIhStd/JqCbM39Gvz9DCc3QO7pnIeU1jR7nsygATpgTHkiBDL
         8Mw52nUlrRQz0Z5Q14BF4B56OFJrceXD/9hWa1CXmzFNm8uftCq491ZKn/DaOKMCqqV1
         xA/ioC0/6V3cBjw0AguexXVUUMTHab1a60aaxV7zin9CgtY7vWNVDa5BTRURqxlVBfRg
         a44Q==
X-Gm-Message-State: AOJu0YxT3Ldxvzl/yQcPO+CRHUUCVpVZ2lXtml26umQA+3LgmYkWnF8N
	RxOsYz3Wiamhgg5LoOzsDnBOBX43geNt0GFi/s0vV5mE9ziAEGsQDuWkdwma2kCVASDwL6MsmIQ
	keqz4i1/F3aZbJzvv6/yc6Dp0GVVUCmg2RfZrnN+wpevfCHR1YKozpw==
X-Received: by 2002:a05:600c:acc:b0:421:eed3:5991 with SMTP id 5b1f17b1804b1-42475297adbmr12917695e9.32.1718782425935;
        Wed, 19 Jun 2024 00:33:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH95+9/uesfMPZ+wBYc42ZsWDmjmPRPB1E6KfsSijszF8A7JFQ9ubrUHEH+YtOrZ/WGhoODjg==
X-Received: by 2002:a05:600c:acc:b0:421:eed3:5991 with SMTP id 5b1f17b1804b1-42475297adbmr12917505e9.32.1718782425447;
        Wed, 19 Jun 2024 00:33:45 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3632d8562a1sm1731803f8f.2.2024.06.19.00.33.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 00:33:44 -0700 (PDT)
Date: Wed, 19 Jun 2024 03:33:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, matttbe@kernel.org,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, shuah@kernel.org, petrm@nvidia.com,
	pabeni@redhat.com, linux-kselftest@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net] selftests: virtio_net: add forgotten config options
Message-ID: <20240619033332-mutt-send-email-mst@kernel.org>
References: <20240619061748.1869404-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619061748.1869404-1-jiri@resnulli.us>

On Wed, Jun 19, 2024 at 08:17:48AM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> One may use tools/testing/selftests/drivers/net/virtio_net/config
> for example for vng build command like this one:
> $ vng -v -b -f tools/testing/selftests/drivers/net/virtio_net/config
> 
> In that case, the needed kernel config options are not turned on.
> Add the missed kernel config options.
> 
> Reported-by: Jakub Kicinski <kuba@kernel.org>
> Closes: https://lore.kernel.org/netdev/20240617072614.75fe79e7@kernel.org/
> Reported-by: Matthieu Baerts <matttbe@kernel.org>
> Closes: https://lore.kernel.org/netdev/1a63f209-b1d4-4809-bc30-295a5cafa296@kernel.org/
> Fixes: ccfaed04db5e ("selftests: virtio_net: add initial tests")
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  tools/testing/selftests/drivers/net/virtio_net/config | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/tools/testing/selftests/drivers/net/virtio_net/config b/tools/testing/selftests/drivers/net/virtio_net/config
> index f35de0542b60..040b600d52f1 100644
> --- a/tools/testing/selftests/drivers/net/virtio_net/config
> +++ b/tools/testing/selftests/drivers/net/virtio_net/config
> @@ -1,2 +1,8 @@
>  CONFIG_VIRTIO_NET=y
>  CONFIG_VIRTIO_DEBUG=y
> +CONFIG_NET_L3_MASTER_DEV=y
> +CONFIG_IPV6_MULTIPLE_TABLES=y
> +CONFIG_NET_VRF=m
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_CGROUP_BPF=y
> +CONFIG_IPV6=y
> -- 
> 2.45.1


