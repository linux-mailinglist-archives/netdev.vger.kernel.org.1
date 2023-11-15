Return-Path: <netdev+bounces-47898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C54477EBC9B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 05:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE6B1C2083B
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 04:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CCA5C;
	Wed, 15 Nov 2023 04:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pErthgeD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254F8A55
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 04:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA9BC433C8;
	Wed, 15 Nov 2023 04:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700022189;
	bh=GwyRQdupYWEx39i8GPje4vSvKw7QVNRwxwRvkzjvais=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pErthgeDMY7HCj4Edusuhh5S62tHBqZsO2U6OQrFGXnmQZrD6fPq12El6FfBIlAiy
	 ekLwoSmbBNbiMjjJQTmlXBL3HFQ3/6NImx34OMXZgaYSQeqNuYnOZS1Nu+bQAajunt
	 usKuF72ErI8vmBv0bg+6fPGunTn4NOUfNTkCzRk8Q5OOQABRwM2dw8zKbMegy2YlCZ
	 xW2lvpFLOPuSx9AEB1WhqtUjPhNQqlZEy7kum8lhZ2MgQj07AKsKJh/INp7Seiv2CN
	 60LXxFmiUEUh79qMZq7vYudY95EL3M4m0UxhJR0RAaNmmWrt8Q19GiGeAMk+Ck6uDR
	 +1EKYW2fL0hGA==
Date: Tue, 14 Nov 2023 23:23:05 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Jason
 Wang <jasowang@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David S .
 Miller" <davem@davemloft.net>, Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Simon Horman <horms@kernel.org>,
 xuanzhuo@linux.alibaba.com
Subject: Re: [PATCH net-next v3 5/5] virtio-net: return -EOPNOTSUPP for
 adaptive-tx
Message-ID: <20231114232305.4cd58415@kernel.org>
In-Reply-To: <6a79229fbeb72edf41185a45a0f9ea5cd87a1086.1699938946.git.hengqi@linux.alibaba.com>
References: <cover.1699938946.git.hengqi@linux.alibaba.com>
	<6a79229fbeb72edf41185a45a0f9ea5cd87a1086.1699938946.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Nov 2023 13:55:47 +0800 Heng Qi wrote:
> We do not currently support tx dim, so respond to -EOPNOTSUPP.

Hm, why do you need this? You don't set ADAPTIVE_TX in
.supported_coalesce_params, so core should prevent attempts
to enable ADAPTIVE_TX.

