Return-Path: <netdev+bounces-169411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB304A43C13
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 11:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9C31888C60
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A6266B62;
	Tue, 25 Feb 2025 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ek660cQ+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FCA26658C
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 10:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740480177; cv=none; b=CuAplYat8MNuvl0lA493GxpIgU2CCQN2/zsaVLPZAv5RRvMon9fDz71N1BMrlGGP8w1PZKwlIu23XagmWbIQhwl/pa1QPDIV6gN5UBsYY2ZYLXR2mYhyqVWVpxUzuZj9hWzNTqJqYk6vnlIoBInrOn1diuIeHKPstk3O8ws+nYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740480177; c=relaxed/simple;
	bh=OMTBFqB5k8dth6j0yMSGfolXKN+EJhS+hthmhBqkAoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p09mdpudqoTPRnPIaV3JaBjl7SmgjxZZxMjK0tAUXe2PXAS0Zs+NzH6yxluI/wL1b2XrFsHjYjahErV5fFTmpB2Pes3faDDuywl+M3kAkrc6sHixSgojuMGrcBSFb+3hgbwAQtQrjun6dTkD/2QT7mTnr55RkIPswniEGOoE1pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ek660cQ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740480174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=slnwLYhjfPuH3juNggrmH+DMU800QZbEDW6M5BetrvI=;
	b=Ek660cQ+/gcpEw/PzjFbBgiYVjCdrNWHK88VieSQxlXFlRN+wjNRQM13Kq8BOaeL9vMBlw
	gnilG18sHJht9ZrhvK3gRtVwQRsTsPKaIROJuxhRbtunTnh80vsKJPhE85T7Rmn17yvfv1
	B/NGcfXhMi3UJoumHZT3N+Ax8fwkjMw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-vQJ-5mm8PBCyfmAzr97KSw-1; Tue, 25 Feb 2025 05:42:52 -0500
X-MC-Unique: vQJ-5mm8PBCyfmAzr97KSw-1
X-Mimecast-MFC-AGG-ID: vQJ-5mm8PBCyfmAzr97KSw_1740480171
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f2f78aee1so2180881f8f.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 02:42:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740480171; x=1741084971;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=slnwLYhjfPuH3juNggrmH+DMU800QZbEDW6M5BetrvI=;
        b=iOpj2ThZGZ6+GivpkrmfWIdEYOTM/4T8eSbHKDIBYJNlDC42N6IpVUgfZe9fKPwoXi
         3hYoy0SObaAkVGr0x6Tu66qmXLIF3XJOEbdyw+PU4jagKOg+gGyP2IC6XIMPnqUtwu4G
         WXgbWjxXzXUQ2qG0/Wl4nnNwI22SdqlSyLhjBt4Z/tna2SAzrwdvM79rR5HUxCx3NeOz
         yF51CdeM+PGGkM9/u7dd5Rww8hROxnBKY8Mbu2EM3BMiBG7C5zVWmXYmJ9WL5GSdyXmt
         EAMY2W4Jk+j05Aceg0WDfZAKxC//16AtgzPOmpPXhsizRcunjctaQE7eI0Q2xusjOr8L
         MHnw==
X-Forwarded-Encrypted: i=1; AJvYcCUdQFjwknuS1NF5VNDChdEIFA50GRibNYkiHlpNzdD/PfhGy2MJDrjiH0/q80RoHVaD1lZFyJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKu4wIPEhHedu89zTyQ7sWEi1bWe0ILPXIOBisNOnL7t9Pj3HU
	z+tMx47/8u7CPZj+2LeCQiXJycYNn8WnVxsyeg3MLzfY0+CXVb1brwKWnQhzTVHISptVD/Z61tZ
	7KQ2Yb41OCBWukkD48AXjw86QIctxQgG0WaGyzryMBsDdNefK/x+B7w==
X-Gm-Gg: ASbGnctT8712o9bWv02OBzU/XHJM6vM2XLbBefJm5BhR25xsYBgjnl7r140KLuNNciG
	o2or0tA6imPoyRpWcTikiSsUQJ5QN26Zw3/nKT0W3iZP+09iOehOPBbg4DHWUEF3TRYMlyYcpkF
	EEPHY1rPHWRJpl//9oWYMx6RkPJATtY1iiLXiKl3peCpWkfGZaCxZSGe20hXrkmMPsaPcztdQnR
	vU66JX1I1r5y6P3OS8QgfpRHC2b5gHuXZZbxvvqLsHBCfaXjWAlPN/+3Q/dmyjH3F86/hCAm5mT
	gG/pgD72uWWZCJdEmRt4KjMyir5ELPOkhRIGBvw09y4=
X-Received: by 2002:a5d:47cf:0:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-38f6f3dc975mr12246465f8f.16.1740480171024;
        Tue, 25 Feb 2025 02:42:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuKgqrFpDbT8xU6HO5L6C2AxVLrtaD6KgRnXKGIn9SrQpJ6njoz3r81A64lnBaAx0BYOBngQ==
X-Received: by 2002:a5d:47cf:0:b0:38d:fede:54f8 with SMTP id ffacd0b85a97d-38f6f3dc975mr12246444f8f.16.1740480170681;
        Tue, 25 Feb 2025 02:42:50 -0800 (PST)
Received: from [192.168.88.253] (146-241-59-53.dyn.eolo.it. [146.241.59.53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866ec7sm1807526f8f.3.2025.02.25.02.42.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:42:50 -0800 (PST)
Message-ID: <5d9340b1-02a5-4fa1-971e-a2a4baf77ef7@redhat.com>
Date: Tue, 25 Feb 2025 11:42:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 07/20] nvme-tcp: RX DDGST offload
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de, kbusch@kernel.org,
 axboe@fb.com, chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Yoray Zack <yorayz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20250221095225.2159-1-aaptel@nvidia.com>
 <20250221095225.2159-8-aaptel@nvidia.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250221095225.2159-8-aaptel@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 10:52 AM, Aurelien Aptel wrote:
> @@ -420,6 +422,46 @@ nvme_tcp_get_ddp_netdev_with_limits(struct nvme_tcp_ctrl *ctrl)
>  	return NULL;
>  }
>  
> +static inline bool nvme_tcp_ddp_ddgst_ok(struct nvme_tcp_queue *queue)

'inline' functions should be avoided in c files. Either drop the inline
keyword or move the definition to a (local) include file.

Thanks,

Paolo


