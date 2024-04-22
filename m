Return-Path: <netdev+bounces-90071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8511E8ACA07
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:57:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 215A41F21B6B
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6E313D521;
	Mon, 22 Apr 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="BysXfxH/"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9343912837C
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779775; cv=none; b=gp166b5JOeuA0aM+q3lVd25mx8YdtdZcKFY8kBrfTVj0mS9pjOHolFve6USthR1Ytf7acwMdw1zjNo++B7YabwA4QH1FZuNoFPzA2Py+gPmN3QasaszLo3t8ndF3gsZJwVg+4N8IcR+ecu3bssRGaTkMSxz3GmDUnZdbaajEuOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779775; c=relaxed/simple;
	bh=VQe9xA3nwX29uqRHiGOigNX0yJdXeQJkMD3LQssSslM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MV3wzb40VTMmEvg8anyB0DG0TDxY6uL2Kl7NS4HXgZrFJ/2cYc1mV1Tx9/4Ko5yAlGFqofklZiov08/TncKAubp8+1JHkM4f0U06aPhD7nB8i/xb2oKfYjMgLp6IcbCjtTl06ePPI4quvtRVVDW48IrykEtHQVjS6ai0tseuWP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=BysXfxH/; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id B6B4F207B2;
	Mon, 22 Apr 2024 11:56:10 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wUTmXmJV0HRS; Mon, 22 Apr 2024 11:56:10 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 27E1220754;
	Mon, 22 Apr 2024 11:56:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 27E1220754
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1713779770;
	bh=JhtV6i+sS33eLn83kJwJuDGPyzm5UHQNoa6LJkmC3oA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=BysXfxH/z7PSyDeT+s8GDtKOrJArD7WdTbzf1Kcycgua4FtBiYVBJpFUpPnHYjeq9
	 urLKbtaIqcVLAWNJ8rXRG+Eo06Rb6TEI0ndM8MIAKOzNiU4wiciyramSX8ZcqHzTEt
	 b2FBnxQGeqJ80H0eDCS9P75v4V7VA8qFM537180MMK5NbWdG/tIZK1r1/XryTBVq16
	 UViUXdN+jsJ1nUrkMonQQfDaI30R2q6j2HpOupSbyJ1F/HXt5ewSJ7dPkopQOspXRj
	 Atu9Z1Tpq8EMag05MTFrPFLBv/K6gnzDXciO0c9JDkee0rJIXZQfu/heySbAuDr465
	 r4w/gMuczm8fg==
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 1918480004A;
	Mon, 22 Apr 2024 11:56:10 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 11:56:09 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Mon, 22 Apr
 2024 11:56:09 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 51D9E3182573; Mon, 22 Apr 2024 11:56:09 +0200 (CEST)
Date: Mon, 22 Apr 2024 11:56:09 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Paul Davey <paul.davey@alliedtelesis.co.nz>
CC: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller"
	<davem@davemloft.net>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net] xfrm: Preserve vlan tags for transport mode software
 GRO
Message-ID: <ZiY0Of0QuDOCPXHg@gauss3.secunet.de>
References: <20240422025711.145577-1-paul.davey@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240422025711.145577-1-paul.davey@alliedtelesis.co.nz>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)

On Mon, Apr 22, 2024 at 02:56:20PM +1200, Paul Davey wrote:
> The software GRO path for esp transport mode uses skb_mac_header_rebuild
> prior to re-injecting the packet via the xfrm_napi_dev.  This only
> copies skb->mac_len bytes of header which may not be sufficient if the
> packet contains 802.1Q tags or other VLAN tags.  Worse copying only the
> initial header will leave a packet marked as being VLAN tagged but
> without the corresponding tag leading to mangling when it is later
> untagged.
> 
> The VLAN tags are important when receiving the decrypted esp transport
> mode packet after GRO processing to ensure it is received on the correct
> interface.
> 
> Therefore record the full mac header length in xfrm*_transport_input for
> later use in correpsonding xfrm*_transport_finish to copy the entire mac
> header when rebuilding the mac header for GRO.  The skb->data pointer is
> left pointing skb->mac_header bytes after the start of the mac header as
> is expected by the network stack and network and transport header
> offsets reset to this location.
> 
> Signed-off-by: Paul Davey <paul.davey@alliedtelesis.co.nz>

Please add a 'Fixes:' tag so it can be backported to stable.

> diff --git a/include/net/xfrm.h b/include/net/xfrm.h
> index 57c743b7e4fe..0331cfecb28b 100644
> --- a/include/net/xfrm.h
> +++ b/include/net/xfrm.h
> @@ -675,6 +675,9 @@ struct xfrm_mode_skb_cb {
>  
>  	/* Used by IPv6 only, zero for IPv4. */
>  	u8 flow_lbl[3];
> +
> +	/* Used to keep whole l2 header for transport mode GRO */
> +	u32 orig_mac_len;

xfrm_mode_skb_cb has already reached the maximum size of 48 bytes.
Adding more will overwrite data in the 'struct sk_buff'.

Try to store this in 'struct xfrm_offload'.

Thanks!

