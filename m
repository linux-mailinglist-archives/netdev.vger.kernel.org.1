Return-Path: <netdev+bounces-245805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7E7CD80AB
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 05:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D995300EDC9
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 04:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C8082DA76C;
	Tue, 23 Dec 2025 04:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="SCKY2EKN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A570B17C211;
	Tue, 23 Dec 2025 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766463719; cv=none; b=USvGgW/18cW+jU0rGvsWxSIueTTNx5ua+p7VT8O2+H6oJ5lCbDmqfgpA26iu+nFG+qCuARDn8sK46cvmlsswmqBQLw/77yeD+LX+xEc0T7CvmJwCe0dcQ1HiY2lBxmDkOl6ehRkdjC7ywYSgKmjpeQtt9Uy4m2SALzClTfIY/NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766463719; c=relaxed/simple;
	bh=ZucMsqwBXyyGLkTHcrn0L9mT4uNd10mnt8iid8e/6Sg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGSP8WrROWsi/LhNT1AG87gvHO4IXbPWQPfcFgoW6RopuMAa7QuKZlDt479uFCfTbxAcUF97LegxSkeF0X7yJ2EsGaKDBtRsqKAEqmf78+uXLRsZUBm4kSTwtk/+ubDRevvnxcUgPPAYw1PJ8Md+O5Y34tS61ps9ttX1Odae11c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=SCKY2EKN; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BMNRrDk2748926;
	Mon, 22 Dec 2025 20:21:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=slnD4MPrfPlk092s27dE/kqcR
	tDBKwpnX9dTnNllAI8=; b=SCKY2EKNUvxWDfCAU5n6ngeHMEyMp220yIMhEBUeI
	qf3JfWx4iYnL/SOmu0A4ZFzQBZsa9q/2iHvIt15Ky7jufyvNFc8CDy2NXkOcOpB9
	EF3RjaoK0ca95AMQZbsRrsMwDx5NIdCMbz6ef+xD3th2Cx90l3isp1KlXH1PDonJ
	1V7qYekbYIA+oug2Mu7B+hmWlfbN9/VMsDTRlob8tulENHsXlxjzya5geowDjPZl
	AK4BiR50BAWYvZRQfmB7LalJkTwojgEyz3Nfbbhzhx2PySUDR9yfUIYdoNUdqFml
	lh511j8aNeN31vFx4f2+ji/jofL9RkMVVGbWpgl19Cnsg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4b7fpb8dh5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Dec 2025 20:21:24 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 22 Dec 2025 20:21:23 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 22 Dec 2025 20:21:23 -0800
Received: from kernel-ep2 (unknown [10.29.36.53])
	by maili.marvell.com (Postfix) with SMTP id 3A7305B6939;
	Mon, 22 Dec 2025 20:21:20 -0800 (PST)
Date: Tue, 23 Dec 2025 09:51:19 +0530
From: Subbaraya Sundeep <sbhatta@marvell.com>
To: Breno Leitao <leitao@debian.org>
CC: Joshua Washington <joshwash@google.com>,
        Harshitha Ramamurthy
	<hramamurthy@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: gve: convert to use .get_rx_ring_count
Message-ID: <20251223042119.GA319551@kernel-ep2>
References: <20251222-gxring_google-v1-1-35e7467e5c1a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251222-gxring_google-v1-1-35e7467e5c1a@debian.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIzMDAzNCBTYWx0ZWRfX7g3XvpuB622U
 cw08Z1B0m/xybNbCysy+fAqmuXlHw/oV6RBx+Koq2IJmOQ85lQHu8edPH9ymIfcgs0Au2lwCOv/
 mzQcx61Zzcth5oHjFoOMPyG+RiqXPFujPqIcoJFu3JPBhehsfJ8mmDqmcrQNC73ipOyzUtr/l5q
 +OrdmpGpzO+BBgkK9shf09AZviGwSFLocmk9lzQRYgYSW2NLOGlaYJRGbwo07tn8hfBlXKa66tM
 RvDYVBgThQ8ZqswP7f+2DmDovMcWp81x1bGLq5SyTXqOjnkLqCYszTn6fLD5Cns3SgRAeCJEae8
 bjt0hZlfwBN2zW8RlaaCpj5LL+P3AKaWShK7oEgvaloRhByUUp/5P1mq6OH1/7Zm82h0R2A7QcC
 XH25xxKPcepHcb1818OTA0DzStnN6O/xEgEVOoxcaLUFuX+BcSsZSRPUCunZLLLOMqeYDU/x21H
 CgAjGdOKxahbyDVvwCw==
X-Proofpoint-ORIG-GUID: oLYAo691sjOnw2pdluf5saBlQypyq0G7
X-Proofpoint-GUID: oLYAo691sjOnw2pdluf5saBlQypyq0G7
X-Authority-Analysis: v=2.4 cv=eakwvrEH c=1 sm=1 tr=0 ts=694a18c4 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=kj9zAlcOel0A:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xNf9USuDAAAA:8 a=M5GUcnROAAAA:8 a=SnqcOUTi_U0GFHmG1jsA:9 a=CjuIK1q_8ugA:10
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-23_01,2025-12-22_01,2025-10-01_01

On 2025-12-22 at 22:46:27, Breno Leitao (leitao@debian.org) wrote:
> Convert the Google Virtual Ethernet (GVE) driver to use the new
> .get_rx_ring_count ethtool operation instead of handling
> ETHTOOL_GRXRINGS in .get_rxnfc. This simplifies the code by moving the
> ring count query to a dedicated callback.
> 
> The new callback provides the same functionality in a more direct way,
> following the ongoing ethtool API modernization.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Subbaraya Sundeep <sbhatta@marvell.com>

Please repost after net-next is open.

Thanks,
Sundeep
> ---
> PS: This was compile-tested only.
> ---
>  drivers/net/ethernet/google/gve/gve_ethtool.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
> index 52500ae8348e..9ed1d4529427 100644
> --- a/drivers/net/ethernet/google/gve/gve_ethtool.c
> +++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
> @@ -815,15 +815,19 @@ static int gve_set_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd)
>  	return err;
>  }
>  
> +static u32 gve_get_rx_ring_count(struct net_device *netdev)
> +{
> +	struct gve_priv *priv = netdev_priv(netdev);
> +
> +	return priv->rx_cfg.num_queues;
> +}
> +
>  static int gve_get_rxnfc(struct net_device *netdev, struct ethtool_rxnfc *cmd, u32 *rule_locs)
>  {
>  	struct gve_priv *priv = netdev_priv(netdev);
>  	int err = 0;
>  
>  	switch (cmd->cmd) {
> -	case ETHTOOL_GRXRINGS:
> -		cmd->data = priv->rx_cfg.num_queues;
> -		break;
>  	case ETHTOOL_GRXCLSRLCNT:
>  		if (!priv->max_flow_rules)
>  			return -EOPNOTSUPP;
> @@ -966,6 +970,7 @@ const struct ethtool_ops gve_ethtool_ops = {
>  	.get_channels = gve_get_channels,
>  	.set_rxnfc = gve_set_rxnfc,
>  	.get_rxnfc = gve_get_rxnfc,
> +	.get_rx_ring_count = gve_get_rx_ring_count,
>  	.get_rxfh_indir_size = gve_get_rxfh_indir_size,
>  	.get_rxfh_key_size = gve_get_rxfh_key_size,
>  	.get_rxfh = gve_get_rxfh,
> 
> ---
> base-commit: 7b8e9264f55a9c320f398e337d215e68cca50131
> change-id: 20251222-gxring_google-d6c76c372f76
> 
> Best regards,
> --  
> Breno Leitao <leitao@debian.org>
> 

