Return-Path: <netdev+bounces-142311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A509BE335
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 10:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF3F1F2354D
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 09:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590731DBB21;
	Wed,  6 Nov 2024 09:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Zv+VqUll"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0011DBB19
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 09:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730886805; cv=none; b=eFSDNqAK4kiLPAWoAVyfG8NdZKi4CNF090LH52Ue4maI9gc3nVPlSexVTDHSh+tX+BhHRFb13lgfOVe2mC/qNbyPZR7S4wzkwvivST6BOeRzN0121UzMP5o8442GpXWMQosOz14RaIhr01S7zAIOqrk4tGkT6XSo44e8OD2/t5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730886805; c=relaxed/simple;
	bh=/woeJz0hn7Kll6eV/RHO7dlFLWpd53O8/AzjoSu5TJE=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=EhqmUnZPXfGWZrqb1UzAjQYDfdKpX9lGbOEfKphKg+SR13Mnh8l4s8O4MBjTgEnmSFIw/w+9Jeg+Y7vGdryD4+cCHQgmeGB1CQIySWb3gXL2LyX2ptgUiK0tnAeEErwNHVKGIHmGMmEDkD3OlMvFH3Q3ignKDfwv4tKxc+UXuG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Zv+VqUll; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730886799; h=Message-ID:Subject:Date:From:To;
	bh=5mM21KFET2IJsUR4IX+ww4hSa7q1K28KAkfIFOWNBJ0=;
	b=Zv+VqUlls0JsO8zueN12O8COKn0B2T+hBUKnWQRylZU5fcoSygt6FE/12uW9DUq6wpGn+i3SMLkbOm6E8w6sLaqx8GGs9fCUx7NW9JneX1cNlLQyoRLDgfFgYNIJ/UXf2bOvz+X65+M3K4tsyVcrdlD1yB+TkwlFQdZI0RIgxqY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WIqlFXp_1730886798 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 06 Nov 2024 17:53:18 +0800
Message-ID: <1730886772.9292731-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 0/7] net: add debug checks to skb_reset_xxx_header()
Date: Wed, 6 Nov 2024 17:52:52 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org,
 eric.dumazet@gmail.com,
 Eric Dumazet <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20241105174403.850330-1-edumazet@google.com>
In-Reply-To: <20241105174403.850330-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>


For serial:

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

On Tue,  5 Nov 2024 17:43:56 +0000, Eric Dumazet <edumazet@google.com> wrote:
> Add debug checks (only enabled for CONFIG_DEBUG_NET=y builds),
> to catch bugs earlier.
>
> Eric Dumazet (7):
>   net: skb_reset_mac_len() must check if mac_header was set
>   net: add debug check in skb_reset_inner_transport_header()
>   net: add debug check in skb_reset_inner_network_header()
>   net: add debug check in skb_reset_inner_mac_header()
>   net: add debug check in skb_reset_transport_header()
>   net: add debug check in skb_reset_network_header()
>   net: add debug check in skb_reset_mac_header()
>
>  include/linux/skbuff.h | 47 +++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 12 deletions(-)
>
> --
> 2.47.0.199.ga7371fff76-goog
>
>

