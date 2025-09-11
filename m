Return-Path: <netdev+bounces-222111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 050CFB5325A
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D24A1582EEF
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0289632144E;
	Thu, 11 Sep 2025 12:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isn6120n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD2B1DFDE;
	Thu, 11 Sep 2025 12:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757594011; cv=none; b=VmU0kOsuGu/PDNt5KhgD9Ou2b3X0/lrEhV2hsL+LVXk0czQ5QV64y+DzhJEAs4DIa1l8ocPDaXtBdEtZJ6yhC7mG9mMqkqsKOFo3N6XJgRlp5nu25mzfbFV6i621gX5vT65klV2XDHKHUd3hqfd1c/DYg0QLk6bH3TldvG9/Koo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757594011; c=relaxed/simple;
	bh=P48xfB55szeLvDmSgHttsgXhs7aEst40wBJg3abuJE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OuOjHsAqhzvdB5w6PYW5b523KVJMkxkfhVQbQivrgIud4ctvnNHFPDB51ZPUbLzgzxLlLezIQMOZJ+g0ga+sBDKxQjFldOJrKVoGyOehdJgm8rVo0cK7svHMj3+268y0OpTXpHggnu+6ReXuhvjXIEmt+7BPGCI/azrJnTcy9xI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isn6120n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A00F5C4CEF1;
	Thu, 11 Sep 2025 12:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757594011;
	bh=P48xfB55szeLvDmSgHttsgXhs7aEst40wBJg3abuJE0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isn6120n/iONjEJMNXwY7lFI2zOPw5/xk7OTh/lFNzKUSRm/jgtHzFJbQot6pTMbL
	 e2x1bsQkpraqSg9CRYV92TbRM464masca2teDYVlQYhwv5kvqj63YxEbs3hVNUZTNl
	 zTDO5gtsWusyG/5tHAbAUC2PAVfeRyzacSTdIFtD5jkf0WykK4gZ8mAz9pMriKZjuB
	 NQ+W5dfvIXOn7TnY+hJh+rwcRPN7R+dlXkDSGD6bw6DWcanboho0QhwyX2wlpk5aSk
	 OLCY9CB9zPQRdmVmRFai3qeZ9ZcOEwuBMFqa15dzQLVTeVVfS80y5+hg+3fnOpq5H7
	 Vurewde39Myew==
Date: Thu, 11 Sep 2025 13:33:24 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, linux-doc@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>, luosifu <luosifu@huawei.com>,
	Xin Guo <guoxin09@huawei.com>,
	Shen Chenyang <shenchenyang1@hisilicon.com>,
	Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
	Shi Jing <shijing34@huawei.com>,
	Luo Yang <luoyang82@h-partners.com>,
	Meny Yossefi <meny.yossefi@huawei.com>,
	Gur Stavi <gur.stavi@huawei.com>, Lee Trager <lee@trager.us>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Suman Ghosh <sumang@marvell.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH net-next v05 12/14] hinic3: Add port management
Message-ID: <20250911123324.GJ30363@horms.kernel.org>
References: <cover.1757401320.git.zhuyikai1@h-partners.com>
 <9fa22ecd4b8dfe9ea613b0d81d2cabf7c233e7d2.1757401320.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fa22ecd4b8dfe9ea613b0d81d2cabf7c233e7d2.1757401320.git.zhuyikai1@h-partners.com>

On Tue, Sep 09, 2025 at 03:33:37PM +0800, Fan Gong wrote:
> Add port management of enable/disable/query/flush function.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

...

> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> index 3d17ca5e7ba5..a07fa4bd71e7 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_netdev_ops.c
> @@ -326,6 +326,59 @@ static void hinic3_close_channel(struct net_device *netdev)
>  	hinic3_free_qp_ctxts(nic_dev);
>  }
>  
> +static int hinic3_vport_up(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	bool link_status_up;
> +	u16 glb_func_id;
> +	int err;
> +
> +	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
> +	err = hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, true);
> +	if (err) {
> +		netdev_err(netdev, "Failed to enable vport\n");
> +		goto err_flush_qps_res;
> +	}
> +
> +	err = netif_set_real_num_queues(netdev, nic_dev->q_params.num_qps,
> +					nic_dev->q_params.num_qps);
> +	if (err) {
> +		netdev_err(netdev, "Failed to set real number of queues\n");
> +		goto err_flush_qps_res;
> +	}
> +	netif_tx_start_all_queues(netdev);
> +
> +	err = hinic3_get_link_status(nic_dev->hwdev, &link_status_up);
> +	if (!err && link_status_up)
> +		netif_carrier_on(netdev);
> +
> +	return 0;
> +
> +err_flush_qps_res:
> +	hinic3_flush_qps_res(nic_dev->hwdev);
> +	/* wait to guarantee that no packets will be sent to host */
> +	msleep(100);

I realise that Jakub's feedback on msleep() in his review of v3 was
in a different code path. But I do wonder if there is a better way.

> +
> +	return err;
> +}
> +
> +static void hinic3_vport_down(struct net_device *netdev)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	u16 glb_func_id;
> +
> +	netif_carrier_off(netdev);
> +	netif_tx_disable(netdev);
> +
> +	glb_func_id = hinic3_global_func_id(nic_dev->hwdev);
> +	hinic3_set_vport_enable(nic_dev->hwdev, glb_func_id, false);
> +
> +	hinic3_flush_txqs(netdev);
> +	/* wait to guarantee that no packets will be sent to host */
> +	msleep(100);

Likewise, here.

> +	hinic3_flush_qps_res(nic_dev->hwdev);
> +}
> +
>  static int hinic3_open(struct net_device *netdev)
>  {
>  	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);

...

