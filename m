Return-Path: <netdev+bounces-111487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C6C931581
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 15:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 968C0B21088
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A607189F59;
	Mon, 15 Jul 2024 13:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p8dVvLeJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EC41850B4
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 13:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049383; cv=none; b=CiE6vPIEF9X6A5ZgnnPLDC6SbQArWad4dcQvWRdauH5C7eZ3f7/0JLHOdQIRjLgRfSHAnAGgevNxniptq5vW+xzZBCCDIEwDQgPDxDhtbZ/7cHDL3mIPFpDt3HnQN0XrY4WohNFDrqO2lGaeN2OmVuCy75rOpUft4lmL7ZUF+Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049383; c=relaxed/simple;
	bh=jo9UwKzc+BpIEVOmcKLusf9l5IW0ZMuuKuv0Ec9HSP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToYLEAedE5GXtmq8SxUMJ3v2oVuWPXkhQTEHTmbZt8LDmlHRz8GjxSLjdHYlu32zXXMxbpRGxXyJXDBaEvBv98jBcAM6VQIMSfbnMPLzekW8xM1rak+3SHgAp+wHZpbAWi09SjMOkV3R+c0rZai2PkSwfP+0DFLWoyJZOs7pFZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p8dVvLeJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FDEC32782;
	Mon, 15 Jul 2024 13:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721049382;
	bh=jo9UwKzc+BpIEVOmcKLusf9l5IW0ZMuuKuv0Ec9HSP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8dVvLeJiMEPNKDOtaXEP6cZJjuwXrdyuzRDK5GqsYIlNSRizU3KwMMnkit8+BpT9
	 04RPplJ0721DMAm2mO86YzXJg9KJP89XLetgeB0sD50hmHqLhUfQClJqWd0os/BUFH
	 +RIqPbAZXBQ+lmH5ZNEGHdMUC5N+Nqa+Vec8oHhoAM3w0sMsukALhGK2mw/0Dfv8gQ
	 EkDJYLkpIEq+aF+3kGS0K4PHdPyzbkc6Um5HYNNA0O8kembmecXx4psySv7fqML1dk
	 32+tUolbd+pyZypkwFoBGa+MAe7UAFGAKvL4ExIfeG2OEnlMPwyHyceBJOw8LahP6O
	 G+bSUV7bXrXAA==
Date: Mon, 15 Jul 2024 14:16:19 +0100
From: Simon Horman <horms@kernel.org>
To: Christian Hopps <chopps@chopps.org>
Cc: devel@linux-ipsec.org, Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Christian Hopps <chopps@labn.net>
Subject: Re: [PATCH ipsec-next v5 12/17] xfrm: iptfs: add basic receive
 packet (tunnel egress) handling
Message-ID: <20240715131619.GE45692@kernel.org>
References: <20240714202246.1573817-1-chopps@chopps.org>
 <20240714202246.1573817-13-chopps@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714202246.1573817-13-chopps@chopps.org>

On Sun, Jul 14, 2024 at 04:22:40PM -0400, Christian Hopps wrote:
> From: Christian Hopps <chopps@labn.net>
> 
> Add handling of packets received from the tunnel. This implements
> tunnel egress functionality.
> 
> Signed-off-by: Christian Hopps <chopps@labn.net>
> ---
>  net/xfrm/xfrm_iptfs.c | 283 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 283 insertions(+)
> 
> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index 933df59cd39d..0060f8825599 100644

...

> +/**
> + * iptfs_input() - handle receipt of iptfs payload
> + * @x: xfrm state
> + * @skb: the packet
> + *
> + * Process the IPTFS payload in `skb` and consume it afterwards.
> + */
> +static int iptfs_input(struct xfrm_state *x, struct sk_buff *skb)
> +{
> +	u8 hbytes[sizeof(struct ipv6hdr)];
> +	struct ip_iptfs_cc_hdr iptcch;
> +	struct skb_seq_state skbseq;
> +	struct list_head sublist; /* rename this it's just a list */
> +	struct sk_buff *first_skb, *next;
> +	const unsigned char *old_mac;
> +	struct xfrm_iptfs_data *xtfs;
> +	struct ip_iptfs_hdr *ipth;
> +	struct iphdr *iph;
> +	struct net *net;
> +	u32 remaining, iplen, iphlen, data, tail;
> +	u32 blkoff;
> +	u64 seq;
> +
> +	xtfs = x->mode_data;

Hi Christian,

xtfs is set but otherwise unused in this function.

Flagged by W=1 x86_64 allmodconfig builds with gcc-14 and clang-18.

> +	net = dev_net(skb->dev);
> +	first_skb = NULL;
> +
> +	seq = __esp_seq(skb);

Likewise, seq is set but otherwise unused in this function

...

