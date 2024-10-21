Return-Path: <netdev+bounces-137402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEBD9A604B
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:38:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD573B20791
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CF21E201D;
	Mon, 21 Oct 2024 09:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="wLWvoXIO"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2019198837
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 09:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729503522; cv=none; b=uJOKdlokEUeN/uXSGf6UYPFn0fbDZ/YGoAXToU+l9khyHDupXQCn2ygHcy/MWIZR08v0hwrjkQdbalie/G8d8JsR3XspwKOBFP2zvH5F5FDvvBJi8RTF6vQDdokzXFIfMvrMINl4dpPfvqCrOUDE0OXMM7e16xZ5PsDUIhupRSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729503522; c=relaxed/simple;
	bh=OFyo1NvF11J1ny51UDZhTPdb9rBqlP6KivAMpapLuf4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBOjEfFBs3Zt0dL2eYx8uVbXVZ8IYbUtUVz0OjJUF4foGsAsCU35cflH8qTeVNQ9KxvzxQEO32q0WkCEPLFzTxg64sTCzdJmpF60FsKfeJ5d/Bt3WJvWDvKE1xGk0t1FpaRVqsZpZzzWEX3OGE8hHuV+MQWzEM6+n+dbjBbD+gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=wLWvoXIO; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id A3AED207BB;
	Mon, 21 Oct 2024 11:38:38 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UfwlvJMjDFlq; Mon, 21 Oct 2024 11:38:38 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 13AA020758;
	Mon, 21 Oct 2024 11:38:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 13AA020758
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1729503518;
	bh=GhVP8WKuvOGK8TDuM4DFWN+9zXNVkSIIkkjjtajQPj8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=wLWvoXIOvOdcTH/NAVlyISex4FIyAvoO7Ans4blQBXeibqnqwWJDSRD6w5mTtG5kU
	 VxPWthaufAwfzrn1y/O6H15pLKFeHbyYHRZEgkg03FJ9rLUIXAT8okE5CDcX4zVMlc
	 kWGeEhSvnBFeVUj3eOg32bpVIBYUndDpAz6sQjIVyglUIwfvLIExbTh8y0zLOzyn/u
	 VYsPBqEevYPkLdknQ//FQryIFOWz0lXbGmybD0rFWU/7Q1vMTaCI/umiT4CrV/gS9O
	 IhtU/at2XAW8mJbE88yU5f51sBtSCa4zWvUi92DNZFSvJ9QvTeGmUiSCbdRwBhh1YL
	 PtfjUQKB3VA2g==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 11:38:37 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 21 Oct
 2024 11:38:37 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 699F03184C1C; Mon, 21 Oct 2024 11:38:37 +0200 (CEST)
Date: Mon, 21 Oct 2024 11:38:37 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Christian Hopps <chopps@chopps.org>
CC: <devel@linux-ipsec.org>, <netdev@vger.kernel.org>, Florian Westphal
	<fw@strlen.de>, Sabrina Dubroca <sd@queasysnail.net>, Simon Horman
	<horms@kernel.org>, Antony Antony <antony@phenome.org>, Christian Hopps
	<chopps@labn.net>
Subject: Re: [PATCH ipsec-next v12 10/16] xfrm: iptfs: add fragmenting of
 larger than MTU user packets
Message-ID: <ZxYhHQ1xDW69EiDM@gauss3.secunet.de>
References: <20241007135928.1218955-1-chopps@chopps.org>
 <20241007135928.1218955-11-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241007135928.1218955-11-chopps@chopps.org>
X-ClientProxiedBy: cas-essen-02.secunet.de (10.53.40.202) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Mon, Oct 07, 2024 at 09:59:22AM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add support for tunneling user (inner) packets that are larger than the
> tunnel's path MTU (outer) using IP-TFS fragmentation.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  net/xfrm/xfrm_iptfs.c | 350 ++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 321 insertions(+), 29 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 627b10ed4db0..7343ed77160c 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c
> @@ -46,12 +46,29 @@
>   */
>  #define IPTFS_DEFAULT_MAX_QUEUE_SIZE	(1024 * 10240)
>  
> +/* Assumed: skb->head is cache aligned.
> + *
> + * L2 Header resv: Arrange for cacheline to start at skb->data - 16 to keep the
> + * to-be-pushed L2 header in the same cacheline as resulting `skb->data` (i.e.,
> + * the L3 header). If cacheline size is > 64 then skb->data + pushed L2 will all
> + * be in a single cacheline if we simply reserve 64 bytes.
> + *
> + * L3 Header resv: For L3+L2 headers (i.e., skb->data points at the IPTFS payload)
> + * we want `skb->data` to be cacheline aligned and all pushed L2L3 headers will
> + * be in their own cacheline[s]. 128 works for cachelins up to 128 bytes, for
> + * any larger cacheline sizes the pushed headers will simply share the cacheline
> + * with the start of the IPTFS payload (skb->data).
> + */
> +#define XFRM_IPTFS_MIN_L3HEADROOM 128
> +#define XFRM_IPTFS_MIN_L2HEADROOM (L1_CACHE_BYTES > 64 ? 64 : 64 + 16)
> +
>  #define NSECS_IN_USEC 1000
>  
>  #define IPTFS_HRTIMER_MODE HRTIMER_MODE_REL_SOFT
>  
>  /**
>   * struct xfrm_iptfs_config - configuration for the IPTFS tunnel.
> + * @dont_frag: true to inhibit fragmenting across IPTFS outer packets.
>   * @pkt_size: size of the outer IP packet. 0 to use interface and MTU discovery,
>   *	otherwise the user specified value.
>   * @max_queue_size: The maximum number of octets allowed to be queued to be sent
> @@ -59,6 +76,7 @@
>   *	packets enqueued.
>   */
>  struct xfrm_iptfs_config {
> +	bool dont_frag : 1;

This bool creates a two byte hole at the beginning of the structure.
Not a big issue here, but usually it is good to check the structure
layout with pahole to avoid this.

>  	u32 pkt_size;	    /* outer_packet_size or 0 */
>  	u32 max_queue_size; /* octets */
>  };


