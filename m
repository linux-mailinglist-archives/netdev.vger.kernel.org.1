Return-Path: <netdev+bounces-105924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96835913964
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 12:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D39B21C53
	for <lists+netdev@lfdr.de>; Sun, 23 Jun 2024 10:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C1281AC7;
	Sun, 23 Jun 2024 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmSDGXUD"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B0C1E50F
	for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 10:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719137212; cv=none; b=BBqP4AZRHu15l7J8o8Mbo611Z9QeJw3G9sgXzfkghDoJ8RNdpE3oCxyKm+DEBPQgEj/SnyFKEe9Sdk4yFQLsKbbQhQ3ypsJBDFRs9GTMHo9yVrUi6zS5OSHZF9A70fBAVb1ZFRA10yRwGoNdHUr5rnTaIRWS61x30DK0XGpOse0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719137212; c=relaxed/simple;
	bh=Y5mR5U660E8K+UgcG1a0yPGvlO5IM7YkNLcnZh8b36M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLglMUnojxZQ+uzprr4iFlPqMzOOBhjpUlcOAAaLumHfnLYsd9tI0BF2uMvCqqQJLXu6ivc7CLs2r3WP/a+vUjuF7jm5kgqGBWYkYQfTjRnI3OGelVQUz/lInFPLlLFhRNke7TT8aor6mj7Ggfv5oShXL9z0GvFzJQAuzTGqLq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WmSDGXUD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719137209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=goZq7iVINNND+hTePdj39SioZ3zpLylx4vwzmC5SbaE=;
	b=WmSDGXUDC7jw1MGooE/LCc+CzN1a07tF/tIDe/pAosZ9usb+yDrUG2yAlG0BYRSEa4HfoD
	dXAFJzLXaVHlog69deAkcV1FfPHTwiq5OW4Be1rAicc/sB0lp63/dEmD0jLUxWIfiMJeAm
	T0pdfmXoIClAJE9UBq5clSRC68PrmKk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-lY1s8DFmOnqwHGVSpqgNQQ-1; Sun, 23 Jun 2024 06:06:46 -0400
X-MC-Unique: lY1s8DFmOnqwHGVSpqgNQQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-36298880c8bso1954617f8f.0
        for <netdev@vger.kernel.org>; Sun, 23 Jun 2024 03:06:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719137205; x=1719742005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=goZq7iVINNND+hTePdj39SioZ3zpLylx4vwzmC5SbaE=;
        b=xB52W78ArPc7rcPcpPVNvjoQwfRRdDo/tDT8ebgF4d7tkJzivd/CNaPhAc8smxv29T
         TQF9X73QfiJjahXrA2B6xIWlo0llBTUZO/B5y6WPa5mBHJoRIvqikSWGdNAYV5YyGmzB
         r46MGSk3m7gwwwbxaGR/yfHc/jlnEnjmftRSgkOQpnD6Y+0ai1T9oG2fvuGeCsm26vyO
         JZmV4u+VcJBsN1N/erf7stc3c/cfQR6GN3mMOzEKVFl53o24HRxfKKZxdABUfYv7668v
         YDModhQ6WWimEXEEkMl6r8+TEc//REJ8RZlU9jdebJ87WRvpdbIaBvWmPFSN+7LiVC6i
         kCsA==
X-Gm-Message-State: AOJu0YwIO4Cqc4WhiBr9oW7Jdys3Kv2iV5itJ3vYmlm//XzFNI62FMRl
	Ivo2pOxVTHUR2V2ovA0IBtRCT+LQQcaleQkWxwewLxVoW3IVoI+oaywu7T3JvA9xorlxRtAIcuJ
	dFJaiMW0vbAXDVuAtkXBfsV8ux2qkxV4pdfGTxVx6AQuDQZ7lYeVLoQ==
X-Received: by 2002:adf:cd82:0:b0:35f:3051:1935 with SMTP id ffacd0b85a97d-366e9655165mr1283138f8f.59.1719137204869;
        Sun, 23 Jun 2024 03:06:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZloiO5bb0B1nR7c4eudkxd8K7vOTdoaaS7nCUqn8s47nQnrOiFMSu3oUwPPsyXtI3wLDcdA==
X-Received: by 2002:adf:cd82:0:b0:35f:3051:1935 with SMTP id ffacd0b85a97d-366e9655165mr1283105f8f.59.1719137204114;
        Sun, 23 Jun 2024 03:06:44 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366387cf44asm6838738f8f.26.2024.06.23.03.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jun 2024 03:06:43 -0700 (PDT)
Date: Sun, 23 Jun 2024 06:06:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Daniel Jurgens <danielj@nvidia.com>
Subject: Re: [PATCH net 0/2] virtio_net: fix race on control_buf
Message-ID: <20240623060630-mutt-send-email-mst@kernel.org>
References: <20240528075226.94255-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528075226.94255-1-hengqi@linux.alibaba.com>

On Tue, May 28, 2024 at 03:52:24PM +0800, Heng Qi wrote:
> Patch 1 did a simple rename, leaving 'ret' for patch 2.
> Patch 2 fixed a race between reading the device response and the
> new command submission.


Acked-by: Michael S. Tsirkin <mst@redhat.com>


> Heng Qi (2):
>   virtio_net: rename ret to err
>   virtio_net: fix missing lock protection on control_buf access
> 
>  drivers/net/virtio_net.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> -- 
> 2.32.0.3.g01195cf9f


