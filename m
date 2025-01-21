Return-Path: <netdev+bounces-160126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF41A18600
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56E683AA53D
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 20:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5C11F707D;
	Tue, 21 Jan 2025 20:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="P5A9r84H"
X-Original-To: netdev@vger.kernel.org
Received: from mx17lb.world4you.com (mx17lb.world4you.com [81.19.149.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B811A2550;
	Tue, 21 Jan 2025 20:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737490442; cv=none; b=nl5AWjXP203kB/7raXXwrL2jOooNkjxwuZ+U8fefzalt5yDPioVgv858c3pomaoI0IzhIt+SOceyhKchR50vMuaz6rcx1OomVA8E+pM4G6si5xLhw3+0kx00XrBByaf4IztZrMUxs+Aa/DyDFCc0+2ARvFYkirjKiMCGU9ejaq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737490442; c=relaxed/simple;
	bh=p24p6pQf5fnXbNmEI5tmT0adiiqZzDYfw0WBaeAimNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SVyXaVLTerUyE/ffIkPnMO+NK7zjPVmCCR+12haIjJl+6O/tRYHVZu6dLGmajPhiOgzLJOobWMLBl80K6BGNC/eIFZda5lNUVeFZ8aR87i8J4qvMRMz4q+INxWL2OGwjC+NbWP+cwoBkWHHR6a0g2EdCNpZJjvPF4iVVTMsFWyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=P5A9r84H; arc=none smtp.client-ip=81.19.149.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HJ/tLsQWKPOGKhluXilNFbDzX/GPacn+xLaKLt0cdIA=; b=P5A9r84HhhMpyecLJh+Ub/ne9H
	vu0/CkJNA9ilNqgmayUaq/u+eRayysPYWi/qeu25OQwY7aEnDXmhqROwVQghQxKsJmy7xRcEFBpcI
	EPEqeO0UFWq4W34WlKrO/5epEMm8uxuVS/RRdaUnAXydUBF4eW2QLW8HSMiyjNuvvh88=;
Received: from [88.117.60.28] (helo=[10.0.0.160])
	by mx17lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1taKdB-000000001YR-3ea9;
	Tue, 21 Jan 2025 21:13:50 +0100
Message-ID: <5b43d53d-5ab1-43da-b327-74ca29c29fad@engleder-embedded.com>
Date: Tue, 21 Jan 2025 21:13:48 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next v3 3/4] virtio_net: Map NAPIs to queues
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org
Cc: jasowang@redhat.com, leiyang@redhat.com, xuanzhuo@linux.alibaba.com,
 mkarsten@uwaterloo.ca, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <20250121191047.269844-1-jdamato@fastly.com>
 <20250121191047.269844-4-jdamato@fastly.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250121191047.269844-4-jdamato@fastly.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 21.01.25 20:10, Joe Damato wrote:
> Use netif_queue_set_napi to map NAPIs to queue IDs so that the mapping
> can be accessed by user apps.
> 
> $ ethtool -i ens4 | grep driver
> driver: virtio_net
> 
> $ sudo ethtool -L ens4 combined 4
> 
> $ ./tools/net/ynl/pyynl/cli.py \
>         --spec Documentation/netlink/specs/netdev.yaml \
>         --dump queue-get --json='{"ifindex": 2}'
> [{'id': 0, 'ifindex': 2, 'napi-id': 8289, 'type': 'rx'},
>   {'id': 1, 'ifindex': 2, 'napi-id': 8290, 'type': 'rx'},
>   {'id': 2, 'ifindex': 2, 'napi-id': 8291, 'type': 'rx'},
>   {'id': 3, 'ifindex': 2, 'napi-id': 8292, 'type': 'rx'},
>   {'id': 0, 'ifindex': 2, 'type': 'tx'},
>   {'id': 1, 'ifindex': 2, 'type': 'tx'},
>   {'id': 2, 'ifindex': 2, 'type': 'tx'},
>   {'id': 3, 'ifindex': 2, 'type': 'tx'}]
> 
> Note that virtio_net has TX-only NAPIs which do not have NAPI IDs, so
> the lack of 'napi-id' in the above output is expected.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---
>   rfcv3:
>     - Eliminated XDP checks; NAPIs will always be mapped to RX queues, as
>       Gerhard Engleder suggested.
> 
>   v2:
>     - Eliminate RTNL code paths using the API Jakub introduced in patch 1
>       of this v2.
>     - Added virtnet_napi_disable to reduce code duplication as
>       suggested by Jason Wang.
> 
>   drivers/net/virtio_net.c | 23 +++++++++++++++++++----
>   1 file changed, 19 insertions(+), 4 deletions(-)

Looks good to me. I hope I didn't get you on the wrong track!

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>

