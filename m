Return-Path: <netdev+bounces-145158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EFA9CD5C4
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 04:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5127328289E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 03:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E58C33CFC;
	Fri, 15 Nov 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMvtc3MP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E59A2D;
	Fri, 15 Nov 2024 03:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731640610; cv=none; b=J0PZporCCsRIaEF6TeVtIgAwsxOvRbAXS9zIlBqWShHDVulFxT2o1sQFycsBn8qFbJMZGVI4QtkOjcE8099j3mhpgN69gTI8ZMfGqVvsidgi/pb1H8/q9rUa4ypuJK7DZBU2X4LP4vPlVER+H+iywdf3YfGdhZo1kAnZzGlyrpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731640610; c=relaxed/simple;
	bh=CweFskFydMZSMmKGFlWiI4wa+2mH/KGQURwC4GCvO9s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poCZ9LoBY9K4JHTXTYYJxTdy3+8wugv1F08KqrrsowkhsR9cezcJ6RgL8/XGWx3MeFp8e3TPChuDlgPHACIHusfHg8x4ytOLuy+xRX2pEWzCVvL+E1VKxYfLUbGUja7u1ADoby0GMYF1+g/VR5MjjmtL7FP6wf9a/fuacEdXloQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMvtc3MP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19728C4CECD;
	Fri, 15 Nov 2024 03:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731640609;
	bh=CweFskFydMZSMmKGFlWiI4wa+2mH/KGQURwC4GCvO9s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cMvtc3MPGHlLGpEJrb2W2A4C22z0XZd6K0286IXIa1NprsmxZaIq9hzSfobOnsO92
	 pKri2yjSZCD/5VM3FVQpEQuaDRsd34I9NzvtpPVrP76u4F8jWLicz0njx046FtUqKK
	 13cjhAkI9jEg3+C1rHpbySmsePBtx7VZP2fjRYOTu3htG/45pVhM6QX17dr/Ij34PR
	 LFO8ndLSmEhurijE4MFgWIw5ddvPDaxdYqu+riTozYxQTJZRsnJtYpjB9kv+zmSg4C
	 b9kUtmVk/VDIfSU5FFdP3TJCBG3NUgtRY94RGecAbHjyYcZqmd6QZorrm/EKWkcqrK
	 1EMdEh60Qt4OA==
Date: Thu, 14 Nov 2024 19:16:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
 <thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
 <egallen@redhat.com>, <konguyen@redhat.com>, <horms@kernel.org>,
 <einstein.xue@synaxg.com>, Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] octeon_ep: add ndo ops for VFs in PF driver
Message-ID: <20241114191648.34410e79@kernel.org>
In-Reply-To: <20241112185432.1152541-1-srasheed@marvell.com>
References: <20241112185432.1152541-1-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Nov 2024 10:54:31 -0800 Shinas Rasheed wrote:
> These APIs are needed to support applications that use netlink to get VF
> information from a PF driver.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

> +static int octep_get_vf_config(struct net_device *dev, int vf, struct ifla_vf_info *ivi)

Please don't go over 80 chars for no good reason.
use checkpatch with --strict --max-line-length=80

> +{
> +	struct octep_device *oct = netdev_priv(dev);
> +
> +	ivi->vf = vf;
> +	ether_addr_copy(ivi->mac, oct->vf_info[vf].mac_addr);
> +	ivi->vlan = 0;
> +	ivi->qos = 0;

no need to clear these fields

> +	ivi->spoofchk = 0;
> +	ivi->linkstate = IFLA_VF_LINK_STATE_ENABLE;
> +	ivi->trusted = true;

so you set spoofchk to 0 and trusted to true, indicating no
enforcement [1]

> +	ivi->max_tx_rate = 10000;
> +	ivi->min_tx_rate = 0;

Why are you setting max rate to a fixed value?

> +
> +	return 0;
> +}
> +
> +static int octep_set_vf_mac(struct net_device *dev, int vf, u8 *mac)
> +{
> +	struct octep_device *oct = netdev_priv(dev);
> +	int err;
> +
> +	if (!is_valid_ether_addr(mac)) {
> +		dev_err(&oct->pdev->dev, "Invalid  MAC Address %pM\n", mac);
> +		return -EADDRNOTAVAIL;
> +	}
> +
> +	dev_dbg(&oct->pdev->dev, "set vf-%d mac to %pM\n", vf, mac);
> +	ether_addr_copy(oct->vf_info[vf].mac_addr, mac);
> +	oct->vf_info[vf].flags |=  OCTEON_PFVF_FLAG_MAC_SET_BY_PF;

double space

> +
> +	err = octep_ctrl_net_set_mac_addr(oct, vf, mac, true);
> +	if (err)
> +		dev_err(&oct->pdev->dev, "Set VF%d MAC address failed via host control Mbox\n", vf);
> +
> +	return err;
> +}
> +
>  static const struct net_device_ops octep_netdev_ops = {
>  	.ndo_open                = octep_open,
>  	.ndo_stop                = octep_stop,
> @@ -1146,6 +1184,9 @@ static const struct net_device_ops octep_netdev_ops = {
>  	.ndo_set_mac_address     = octep_set_mac,
>  	.ndo_change_mtu          = octep_change_mtu,
>  	.ndo_set_features        = octep_set_features,
> +	/* for VFs */

what does this comment achieve? 

> +	.ndo_get_vf_config       = octep_get_vf_config,
> +	.ndo_set_vf_mac          = octep_set_vf_mac
>  };
>  
>  /**
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
> index fee59e0e0138..3b56916af468 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.h
> @@ -220,6 +220,7 @@ struct octep_iface_link_info {
>  /* The Octeon VF device specific info data structure.*/
>  struct octep_pfvf_info {
>  	u8 mac_addr[ETH_ALEN];
> +	u32 flags;

the flags are u32 [2]

>  	u32 mbox_version;
>  };
>  
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> index e6eb98d70f3c..26db2d34d1c0 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.c
> @@ -156,12 +156,23 @@ static void octep_pfvf_set_mac_addr(struct octep_device *oct,  u32 vf_id,
>  {
>  	int err;
>  
> +	if (oct->vf_info[vf_id].flags & OCTEON_PFVF_FLAG_MAC_SET_BY_PF) {
> +		dev_err(&oct->pdev->dev,
> +			"VF%d attempted to override administrative set MAC address\n",
> +			vf_id);
> +		rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> +		return;
> +	}

[1] and yet you reject VF side changes. So is there enforcement or not?
:S

>  	err = octep_ctrl_net_set_mac_addr(oct, vf_id, cmd.s_set_mac.mac_addr, true);
>  	if (err) {
>  		rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> -		dev_err(&oct->pdev->dev, "Set VF MAC address failed via host control Mbox\n");
> +		dev_err(&oct->pdev->dev, "Set VF%d MAC address failed via host control Mbox\n",
> +			vf_id);
>  		return;
>  	}
> +
> +	ether_addr_copy(oct->vf_info[vf_id].mac_addr, cmd.s_set_mac.mac_addr);
>  	rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
>  }
>  
> @@ -171,10 +182,17 @@ static void octep_pfvf_get_mac_addr(struct octep_device *oct,  u32 vf_id,
>  {
>  	int err;
>  
> +	if (oct->vf_info[vf_id].flags & OCTEON_PFVF_FLAG_MAC_SET_BY_PF) {
> +		dev_dbg(&oct->pdev->dev, "VF%d MAC address set by PF\n", vf_id);
> +		ether_addr_copy(rsp->s_set_mac.mac_addr, oct->vf_info[vf_id].mac_addr);
> +		rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> +		return;
> +	}
>  	err = octep_ctrl_net_get_mac_addr(oct, vf_id, rsp->s_set_mac.mac_addr);
>  	if (err) {
>  		rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_NACK;
> -		dev_err(&oct->pdev->dev, "Get VF MAC address failed via host control Mbox\n");
> +		dev_err(&oct->pdev->dev, "Get VF%d MAC address failed via host control Mbox\n",
> +			vf_id);
>  		return;
>  	}
>  	rsp->s_set_mac.type = OCTEP_PFVF_MBOX_TYPE_RSP_ACK;
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
> index 0dc6eead292a..339977c7131a 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_pfvf_mbox.h
> @@ -23,6 +23,9 @@ enum octep_pfvf_mbox_version {
>  
>  #define OCTEP_PFVF_MBOX_VERSION_CURRENT	OCTEP_PFVF_MBOX_VERSION_V2
>  
> +/* VF flags */
> +#define OCTEON_PFVF_FLAG_MAC_SET_BY_PF  BIT_ULL(0) /* PF has set VF MAC address */

[2] but the bit definition uses ULL ?

>  enum octep_pfvf_mbox_opcode {
>  	OCTEP_PFVF_MBOX_CMD_VERSION,
>  	OCTEP_PFVF_MBOX_CMD_SET_MTU,
-- 
pw-bot: cr

