Return-Path: <netdev+bounces-58174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74E1B815673
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 03:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A71A41C2392B
	for <lists+netdev@lfdr.de>; Sat, 16 Dec 2023 02:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023ED1846;
	Sat, 16 Dec 2023 02:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t8EdNxaZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CAF1841
	for <netdev@vger.kernel.org>; Sat, 16 Dec 2023 02:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64182C433C8;
	Sat, 16 Dec 2023 02:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702694468;
	bh=XYK1phRN3GR0XiDDkB+58/mKh6cFoXtvgyg5B5b13jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t8EdNxaZKoPxbj4398LJiXVISbzJsfENaebpSPC7cWmxYQuhpGgM8MR4mCtv6SUav
	 yjck74MJlCcQOepvZj0UxC9sj/QEJsmw/k0p5MLUP388jUA0Mrgvf24LtblByuXKDW
	 zfHgupc+5jyvVWGtcpDZB0T2L1CsfN2bSR9LVYy0bm7GIMwRnAvKASwT6uR4VKamXl
	 60ZOa2/qRzCCViliK0TXXPOZuXfYb7d95KNOfbqp7slDdf8ZE/SqAnqLpJgvJNxU2h
	 6j7rnjPNr4Zu+tyJBWSqsqcsNIgZMgfFNOUwI6nkfrXw0gCp8jT62H2vmzH9mGb1I0
	 aqrACWyOLolag==
Date: Fri, 15 Dec 2023 18:41:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 linux@armlinux.org.uk, andrew@lunn.ch, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v5 7/8] net: wangxun: add ethtool_ops for
 channel number
Message-ID: <20231215184107.1eaa8a95@kernel.org>
In-Reply-To: <20231214025456.1387175-8-jiawenwu@trustnetic.com>
References: <20231214025456.1387175-1-jiawenwu@trustnetic.com>
	<20231214025456.1387175-8-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Dec 2023 10:54:55 +0800 Jiawen Wu wrote:
> +	if (!(wx->msix_q_entries)) {

pointless brackets

> +void wx_get_channels(struct net_device *dev,
> +		     struct ethtool_channels *ch)
> +{
> +	struct wx *wx = netdev_priv(dev);
> +
> +	/* report maximum channels */
> +	ch->max_combined = wx_max_channels(wx);
> +
> +	/* report info for other vector */
> +	if (wx->msix_q_entries) {
> +		ch->max_other = 1;
> +		ch->other_count = 1;
> +	}
> +
> +	/* record RSS queues */
> +	ch->combined_count = wx->ring_feature[RING_F_RSS].indices;
> +
> +	/* nothing else to report if RSS is disabled */
> +	if (ch->combined_count == 1)
> +		return;

pointless return

> +}
> +EXPORT_SYMBOL(wx_get_channels);
> +
> +int wx_set_channels(struct net_device *dev,
> +		    struct ethtool_channels *ch)
> +{
> +	unsigned int count = ch->combined_count;
> +	struct wx *wx = netdev_priv(dev);
> +
> +	/* verify they are not requesting separate vectors */
> +	if (!count || ch->rx_count || ch->tx_count)
> +		return -EOPNOTSUPP;

core shouldn't allow this to reach you

