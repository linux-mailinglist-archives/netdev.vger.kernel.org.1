Return-Path: <netdev+bounces-83698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63C48937A8
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 05:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAE001C20830
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 03:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F66CA48;
	Mon,  1 Apr 2024 03:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="Uhs7c4wG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D77F
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 03:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711940677; cv=none; b=IkWpzuaCTCCk2I+pybAm5mU6NW1SwGL+LH95wICYMT9lYqvJW/rgX/P+U0hhgC05ac/TAwmqoeFJKRqWZMGJZLBJ/vjEesYVzpPdVXfJi/VsyrhKTQsOBAkw0TnKunOohGzLWCpHy5ViQzx1VSwobVx3V13mRbb/OkNWKDeOkv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711940677; c=relaxed/simple;
	bh=m0Q7lrLn0kUZIpjRRS4TOQJavEqKU28xW6hZhQoFEHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqaLGk4ZR1FL23SkSZvWwLAqo+Yq2/Xbkmmf7vhMgM8lXGo/mWdHZzOSD/EZ4kp7reIOjXVGu1tZ/P7eSLIW16Or98AOc4OXhWZpUOoQQz+15MvmAsQh6fkZH8BuMal/vKm4cEAzSUg45fHjKwHjoi0hKA0bVmwdDgj0a8kyYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=Uhs7c4wG; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42VLe7SQ030975;
	Sun, 31 Mar 2024 20:04:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pfpt0220; bh=0tvLuINtUam/m/dgLbOUYN
	fCp79aH8i22DMmNOj6YHE=; b=Uhs7c4wGXJlG+p6qWKKzY0JepDDdn/2XWmzBIw
	aFSrfWQL2cQs3V9Pc53MTbuVlBPDQYG2Abiw6jur7IL66bMTZ+Lnx2hrxme359yl
	c8PwqPwjYS4NKRaOVseISsYWkOh+KXLdHb9TKc8Y8Ato9HxxzrNIty3x3jBUGXuE
	cffRSuXPaK+67Npj4Grogw29Bb8L43/3hbr97aL0eVtILAaH15YtD5yqZEXwSvwH
	2TzPmdnl4Y1yz48rI2iecNo00/dogdXtZjJ/VycUXFreUj+3KlGdCmP/6zFGBNmU
	46aVHcV7muTS9wVf9XHVyi2S/mBVhdgunBMa+ijgJy2n6KOw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x7a7bs9kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 31 Mar 2024 20:04:13 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 31 Mar 2024 20:04:12 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 31 Mar 2024 20:04:12 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 8C17A3F703F;
	Sun, 31 Mar 2024 20:04:09 -0700 (PDT)
Date: Mon, 1 Apr 2024 08:34:08 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: David Bauer <mail@david-bauer.net>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <amcohen@nvidia.com>, <netdev@vger.kernel.org>,
        Ido
 Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next] vxlan: drop packets from invalid src-address
Message-ID: <20240401030408.GA1638983@maili.marvell.com>
References: <20240331211434.61100-1-mail@david-bauer.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240331211434.61100-1-mail@david-bauer.net>
X-Proofpoint-GUID: Gg8ujzH7Ne31cxZ9xvywFZSTzVI7Ak5X
X-Proofpoint-ORIG-GUID: Gg8ujzH7Ne31cxZ9xvywFZSTzVI7Ak5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-31_21,2024-03-28_01,2023-05-22_02

On 2024-04-01 at 02:44:34, David Bauer (mail@david-bauer.net) wrote:
> The VXLAN driver currently does not check if the inner layer2
> source-address is valid.
>
> In case source-address snooping/learning is enabled, a entry in the FDB
> for the invalid address is created with the layer3 address of the tunnel
> endpoint.
what is root cause of creation of invalid MAC from an L3 address ? could you
add that as well to commit message.

>
> If the frame happens to have a non-unicast address set, all this
> non-unicast traffic is subsequently not flooded to the tunnel network
> but sent to the learnt host in the FDB. To make matters worse, this FDB
> entry does not expire.
>
> Apply the same filtering for packets as it is done for bridges. This not
> only drops these invalid packets but avoids them from being learnt into
> the FDB.
>
> Suggested-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: David Bauer <mail@david-bauer.net>
> ---
>  drivers/net/vxlan/vxlan_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 3495591a5c29..ba319fc21957 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1615,6 +1615,10 @@ static bool vxlan_set_mac(struct vxlan_dev *vxlan,
>  	if (ether_addr_equal(eth_hdr(skb)->h_source, vxlan->dev->dev_addr))
>  		return false;
>
> +	/* Ignore packets from invalid src-address */
> +	if (!is_valid_ether_addr(eth_hdr(skb)->h_source))
> +		return false;
> +
>  	/* Get address from the outer IP header */
>  	if (vxlan_get_sk_family(vs) == AF_INET) {
>  		saddr.sin.sin_addr.s_addr = ip_hdr(skb)->saddr;
> --
> 2.43.0
>

