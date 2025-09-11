Return-Path: <netdev+bounces-222110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067E7B5325E
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47E20A8359B
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5139B321427;
	Thu, 11 Sep 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esIKoeBl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FB5234984;
	Thu, 11 Sep 2025 12:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757593960; cv=none; b=bVBbWSuS+Ltr+1xepAaKPG1NA1khHfEgssPDrYWCbHh4+HOnsb/UwVMPSFcTDHxCS2lZR1GHBmEX7aHL5hIWwvdkiis4xZ4/lO36WhJ9nrW6so8om9SbfeDfQYSQrBAJdaCCc+SSy72lS4ECh04V5a5ROx9jH9QR546x5K/ES+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757593960; c=relaxed/simple;
	bh=c4lZDB0Q6Y3d7AQRfJLAdsE8B+rBAExtS6t4zPzDWiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYjy5YxUi5E6r4mGRA5KaTjiFp13fBtaBa78Ubx+anAWUjOswQ27p3p8avju/l91YWmlJuqhSfqdL5IjKQyKxNp3WoUU1J2+w0RJY3oRLfSUEYKKKzLibqKbEtYgrnciwYfnLMzde99ZBeJlciqVr6bt+YkzQNXua+Y6K9D+2kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esIKoeBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA44C4CEF1;
	Thu, 11 Sep 2025 12:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757593960;
	bh=c4lZDB0Q6Y3d7AQRfJLAdsE8B+rBAExtS6t4zPzDWiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esIKoeBlvitNkw/0tVYka/eS1IiCtBytpM5K2uzBrwDCMGubf7TYVptUmDP53kVnI
	 t7XAER6ie2tnSkHzu4QR759fHv5+Y0OhzaByLnX0vb7OZlCCV3oddAoVbV3zm+ISJ3
	 DPWSAv7fkjskjsacU5F5NICrmk+TPnmdMo5feyRGbqLcrKq09GreKw4Mft+CwInwNa
	 fBuWXBcru4mFyVpXAUGsF77wHUZKBnsFwgu3hi/bgaAGQyerdUxcyPZHV+G7zFZpYH
	 VOzXkrjsXUBdULbbILgSIvP+PG0TbcqQwAADCZpJqUJXVl6/QhaCNbNViiGuv1u6bZ
	 /bQ7/HnlkIpkQ==
Date: Thu, 11 Sep 2025 13:32:32 +0100
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
Subject: Re: [PATCH net-next v05 08/14] hinic3: Queue pair resource
 initialization
Message-ID: <20250911123232.GI30363@horms.kernel.org>
References: <cover.1757401320.git.zhuyikai1@h-partners.com>
 <59de6c7f087580f48c0aecc0d586ff777433f18d.1757401320.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59de6c7f087580f48c0aecc0d586ff777433f18d.1757401320.git.zhuyikai1@h-partners.com>

On Tue, Sep 09, 2025 at 03:33:33PM +0800, Fan Gong wrote:
> Add Tx & Rx queue resources and functions for packet transmission
> and reception.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

...

> +static void hinic3_config_num_qps(struct net_device *netdev,
> +				  struct hinic3_dyna_txrxq_params *q_params)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	u16 alloc_num_irq, cur_num_irq;
> +	u16 dst_num_irq;
> +
> +	if (!test_bit(HINIC3_RSS_ENABLE, &nic_dev->flags))
> +		q_params->num_qps = 1;
> +
> +	if (nic_dev->num_qp_irq >= q_params->num_qps)
> +		goto out;
> +
> +	cur_num_irq = nic_dev->num_qp_irq;
> +
> +	alloc_num_irq = hinic3_qp_irq_change(netdev, q_params->num_qps);
> +	if (alloc_num_irq < q_params->num_qps) {
> +		q_params->num_qps = alloc_num_irq;
> +		netdev_warn(netdev, "Can not get enough irqs, adjust num_qps to %u\n",
> +			    q_params->num_qps);
> +
> +		/* The current irq may be in use, we must keep it */
> +		dst_num_irq = max_t(u16, cur_num_irq, q_params->num_qps);
> +		hinic3_qp_irq_change(netdev, dst_num_irq);
> +	}
> +
> +out:
> +	netdev_dbg(netdev, "Finally num_qps: %u\n", q_params->num_qps);

I'm not sure that "Finally" will be readily understood
(or, for that matter, that I readily understand it).
Could this be clarified somehow?

> +}

