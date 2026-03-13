Return-Path: <netdev+bounces-267335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sILCI/nLs2n2awAAu9opvQ
	(envelope-from <netdev+bounces-267335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:34:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3945627FBA1
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 09:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C48030E073D
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10DDB382F19;
	Fri, 13 Mar 2026 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QRx5sloz"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA400382F2A
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 08:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773390706; cv=none; b=K5G0AcZ22ud8zZI2uiMWEE1gG4/ljaXLNot4wsfquv21rdL/MHd/qWbVHRtCJwARfT1OtJJ05UwIB6sUdvdta8+H8vmRbOK8FqzFYg2b1cGhvT/wb7Sn8F4pJrqN8d1CZZQp8+NEmA+V/+OppJCW5XeigF3dB+8RrkKsGl6NomU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773390706; c=relaxed/simple;
	bh=l8vCHfXxC9+FUSWip87fRUZOuxjxYsbmel/zZHXKGJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O7CzD73uT5L+I2MkMPVwLDeMq517C7daIWT5j0UplLRAH6fJiJ5WyrpXgAxBn+/zD1Aqz0RRaiItIyOnBIqryaCKN7l6giG4X1hkLwHA/2wz4IzYxV4tyKJEfQkSH+as6ZVZlumTVdc2ypVQEb7Xy7ZzDU6H2d+esg9Qzdx5G38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QRx5sloz; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id BB4F91A2E18;
	Fri, 13 Mar 2026 08:31:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 846ED60027;
	Fri, 13 Mar 2026 08:31:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C4D510368614;
	Fri, 13 Mar 2026 09:31:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773390699; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TOL9sk8Oy/zeNAYdwBbDEf9LXsiGHo+gM5VK3E0pTvw=;
	b=QRx5slozIwrZq0MvGs4/8X00TuUSN4ZRHe6izAwPSqq6ephYcs5AcmYlsyO02B4FuccPeh
	Du/sJvI/wk6frS2iL184gxQIV6zi3fYrAJsgkzxiP2wfcku9IpiPraqSwMdZfVRVIV8Rof
	eLyRof+Ase+yW2wL/+VFtz7fLe4n+qfX1glR/327BlfqSjRodznKUdrLO1b6AodFENvoRv
	tEJpmkkreoAxDGMnKn9f9M0+1d8ODI/zJWYfGBF5JR0dowUJnrK3oXdiAESPZ8lXoLF6gj
	dgRuGP5+LHTH/sBi04PGy0cw5Cb/+spud7g2B3AFU9Gi21x9PkUMQdCkP1LIxg==
Message-ID: <3a6ced9e-5bf4-4573-a4bf-e587ff9119d4@bootlin.com>
Date: Fri, 13 Mar 2026 09:31:30 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v01 2/7] hinic3: Add ethtool statistic ops
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
 netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 luosifu <luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>,
 Zhou Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>,
 Shi Jing <shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>
References: <cover.1773387649.git.zhuyikai1@h-partners.com>
 <f53ce31d1be3e3f214f25282d7f90d43b76e1e3f.1773387649.git.zhuyikai1@h-partners.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <f53ce31d1be3e3f214f25282d7f90d43b76e1e3f.1773387649.git.zhuyikai1@h-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267335-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,h-partners.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 3945627FBA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 13/03/2026 08:54, Fan Gong wrote:
>   Add PF/VF statistics functions in TX and RX processing.
>   Implement following ethtool callback function:
> .get_sset_count
> .get_ethtool_stats
> .get_strings
> .get_eth_phy_stats
> .get_eth_mac_stats
> .get_eth_ctrl_stats
> .get_rmon_stats
> .get_pause_stats
> 
>   These callbacks allow users to utilize ethtool for detailed
> TX and RX netdev stats monitoring.
> 
> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> Signed-off-by: Fan Gong <gongfan1@huawei.com>

[...]

> +static void hinic3_get_eth_phy_stats(struct net_device *netdev,
> +				     struct ethtool_eth_phy_stats *phy_stats)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct mag_cmd_port_stats *ps;
> +	int err;
> +
> +	ps = kmalloc_obj(*ps);
> +	if (!ps)
> +		return;
> +
> +	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
> +	if (err) {
> +		kfree(ps);
> +		netdev_err(netdev, "Failed to get eth phy stats from fw\n");
> +		return;
> +	}
> +
> +	phy_stats->SymbolErrorDuringCarrier = ps->mac_rx_sym_err_pkt_num;

ps isn't kfree'd ?

> +}
> +
> +static void hinic3_get_eth_mac_stats(struct net_device *netdev,
> +				     struct ethtool_eth_mac_stats *mac_stats)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct mag_cmd_port_stats *ps;
> +	int err;
> +
> +	ps = kmalloc_obj(*ps);
> +	if (!ps)
> +		return;
> +
> +	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
> +	if (err) {
> +		kfree(ps);
> +		netdev_err(netdev, "Failed to get eth mac stats from fw\n");
> +		return;
> +	}
> +
> +	mac_stats->FramesTransmittedOK = ps->mac_tx_uni_pkt_num +
> +					 ps->mac_tx_multi_pkt_num +
> +					 ps->mac_tx_broad_pkt_num;
> +	mac_stats->FramesReceivedOK = ps->mac_rx_uni_pkt_num +
> +				      ps->mac_rx_multi_pkt_num +
> +				      ps->mac_rx_broad_pkt_num;
> +	mac_stats->FrameCheckSequenceErrors = ps->mac_rx_fcs_err_pkt_num;
> +	mac_stats->OctetsTransmittedOK = ps->mac_tx_total_oct_num;
> +	mac_stats->OctetsReceivedOK = ps->mac_rx_total_oct_num;
> +	mac_stats->MulticastFramesXmittedOK = ps->mac_tx_multi_pkt_num;
> +	mac_stats->BroadcastFramesXmittedOK = ps->mac_tx_broad_pkt_num;
> +	mac_stats->MulticastFramesReceivedOK = ps->mac_rx_multi_pkt_num;
> +	mac_stats->BroadcastFramesReceivedOK = ps->mac_rx_broad_pkt_num;
> +	mac_stats->InRangeLengthErrors = ps->mac_rx_fcs_err_pkt_num;
> +	mac_stats->OutOfRangeLengthField = ps->mac_rx_undersize_pkt_num +
> +					   ps->mac_rx_undermin_pkt_num +
> +					   ps->mac_rx_oversize_pkt_num +
> +					   ps->mac_rx_jabber_pkt_num;
> +	mac_stats->FrameTooLongErrors = ps->mac_rx_oversize_pkt_num +
> +					ps->mac_rx_jabber_pkt_num;

same here ?

> +}
> +
> +static void hinic3_get_eth_ctrl_stats(struct net_device *netdev,
> +				      struct ethtool_eth_ctrl_stats *ctrl_stats)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct mag_cmd_port_stats *ps;
> +	int err;
> +
> +	ps = kmalloc_obj(*ps);
> +	if (!ps)
> +		return;
> +
> +	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
> +	if (err) {
> +		kfree(ps);
> +		netdev_err(netdev, "Failed to get eth ctrl stats from fw\n");
> +		return;
> +	}
> +
> +	ctrl_stats->MACControlFramesTransmitted = ps->mac_tx_control_pkt_num;
> +	ctrl_stats->MACControlFramesReceived = ps->mac_rx_control_pkt_num;

same here ?

> +}
> +
> +static const struct ethtool_rmon_hist_range hinic3_rmon_ranges[] = {
> +	{     0,    64 },
> +	{    65,   127 },
> +	{   128,   255 },
> +	{   256,   511 },
> +	{   512,  1023 },
> +	{  1024,  1518 },
> +	{  1519,  2047 },
> +	{  2048,  4095 },
> +	{  4096,  8191 },
> +	{  8192,  9216 },
> +	{  9217, 12287 },
> +	{}
> +};
> +
> +static void hinic3_get_rmon_stats(struct net_device *netdev,
> +				  struct ethtool_rmon_stats *rmon_stats,
> +				  const struct ethtool_rmon_hist_range **ranges)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct mag_cmd_port_stats *ps;
> +	int err;
> +
> +	ps = kmalloc_obj(*ps);
> +	if (!ps)
> +		return;
> +
> +	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
> +	if (err) {
> +		kfree(ps);
> +		netdev_err(netdev, "Failed to get eth rmon stats from fw\n");
> +		return;
> +	}
> +
> +	rmon_stats->undersize_pkts	= ps->mac_rx_undersize_pkt_num;
> +	rmon_stats->oversize_pkts	= ps->mac_rx_oversize_pkt_num;
> +	rmon_stats->fragments		= ps->mac_rx_fragment_pkt_num;
> +	rmon_stats->jabbers		= ps->mac_rx_jabber_pkt_num;
> +
> +	rmon_stats->hist[0]		= ps->mac_rx_64_oct_pkt_num;
> +	rmon_stats->hist[1]		= ps->mac_rx_65_127_oct_pkt_num;
> +	rmon_stats->hist[2]		= ps->mac_rx_128_255_oct_pkt_num;
> +	rmon_stats->hist[3]		= ps->mac_rx_256_511_oct_pkt_num;
> +	rmon_stats->hist[4]		= ps->mac_rx_512_1023_oct_pkt_num;
> +	rmon_stats->hist[5]		= ps->mac_rx_1024_1518_oct_pkt_num;
> +	rmon_stats->hist[6]		= ps->mac_rx_1519_2047_oct_pkt_num;
> +	rmon_stats->hist[7]		= ps->mac_rx_2048_4095_oct_pkt_num;
> +	rmon_stats->hist[8]		= ps->mac_rx_4096_8191_oct_pkt_num;
> +	rmon_stats->hist[9]		= ps->mac_rx_8192_9216_oct_pkt_num;
> +	rmon_stats->hist[10]		= ps->mac_rx_9217_12287_oct_pkt_num;
> +
> +	rmon_stats->hist_tx[0]		= ps->mac_tx_64_oct_pkt_num;
> +	rmon_stats->hist_tx[1]		= ps->mac_tx_65_127_oct_pkt_num;
> +	rmon_stats->hist_tx[2]		= ps->mac_tx_128_255_oct_pkt_num;
> +	rmon_stats->hist_tx[3]		= ps->mac_tx_256_511_oct_pkt_num;
> +	rmon_stats->hist_tx[4]		= ps->mac_tx_512_1023_oct_pkt_num;
> +	rmon_stats->hist_tx[5]		= ps->mac_tx_1024_1518_oct_pkt_num;
> +	rmon_stats->hist_tx[6]		= ps->mac_tx_1519_2047_oct_pkt_num;
> +	rmon_stats->hist_tx[7]		= ps->mac_tx_2048_4095_oct_pkt_num;
> +	rmon_stats->hist_tx[8]		= ps->mac_tx_4096_8191_oct_pkt_num;
> +	rmon_stats->hist_tx[9]		= ps->mac_tx_8192_9216_oct_pkt_num;
> +	rmon_stats->hist_tx[10]		= ps->mac_tx_9217_12287_oct_pkt_num;
> +
> +	*ranges = hinic3_rmon_ranges;

same here ?

> +}
> +
> +static void hinic3_get_pause_stats(struct net_device *netdev,
> +				   struct ethtool_pause_stats *pause_stats)
> +{
> +	struct hinic3_nic_dev *nic_dev = netdev_priv(netdev);
> +	struct mag_cmd_port_stats *ps;
> +	int err;
> +
> +	ps = kmalloc_obj(*ps);
> +	if (!ps)
> +		return;
> +
> +	err = hinic3_get_phy_port_stats(nic_dev->hwdev, ps);
> +	if (err) {
> +		kfree(ps);
> +		netdev_err(netdev, "Failed to get eth pause stats from fw\n");
> +		return;
> +	}
> +
> +	pause_stats->tx_pause_frames = ps->mac_tx_pause_num;
> +	pause_stats->rx_pause_frames = ps->mac_rx_pause_num;

same here ?

or am I missing some cleanup.h magic somewhere ?

Maxime


