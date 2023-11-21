Return-Path: <netdev+bounces-49836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1277C7F3A4A
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 00:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAFD282A3A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 23:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79415647D;
	Tue, 21 Nov 2023 23:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IW/0lAka"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D75579D;
	Tue, 21 Nov 2023 23:34:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6C8C433C7;
	Tue, 21 Nov 2023 23:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700609640;
	bh=13VVws5PcCjLAP+55UIaYOZrBe+ks7pXu1hqEWmgU6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IW/0lAkazpPvR2mLvLzKJp3XdexvglQRFUrHW9D4UGKHucfjfAUIv12An/y+VCDZO
	 /b1jAnN2Om/rHZchAYEXeI1JE00fcnnHidlpBDCr3L5cBKeda0p1BKHxYFNa7A5J9E
	 rPyyyowS5TCNfJ8ytWsL4UxeXLDpBg/Nk/YlIRnwAhIbJRWRxqAdnGmkqYChaVwwZL
	 6EugrLGys8ImFsL7sOGmvd2amiHm9yHIRERUWjvvqoZ7Ce0s8UTrynOl101P9C/tW/
	 F1VNjTJRHfFBa9GXu5DyPvphkTC0cdqipZdkz+zNsCmHYvFEaAg6SG7lLV6RO02gC4
	 RSqbFpgWJn5KA==
Date: Tue, 21 Nov 2023 15:33:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
 corbet@lwn.net, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 vladimir.oltean@nxp.com, andrew@lunn.ch, horms@kernel.org,
 mkubecek@suse.cz, willemdebruijn.kernel@gmail.com, gal@nvidia.com,
 alexander.duyck@gmail.com, linux-doc@vger.kernel.org, Wojciech Drewek
 <wojciech.drewek@intel.com>
Subject: Re: [PATCH net-next v6 2/7] net: ethtool: add support for
 symmetric-xor RSS hash
Message-ID: <20231121153358.3a6a09de@kernel.org>
In-Reply-To: <20231120205614.46350-3-ahmed.zaki@intel.com>
References: <20231120205614.46350-1-ahmed.zaki@intel.com>
	<20231120205614.46350-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Nov 2023 13:56:09 -0700 Ahmed Zaki wrote:
> + * @data: Extension for the RSS hash function. Valid values are one of the
> + *	%RXH_HFUNC_*.

@data is way too generic. Can we call this key_xfrm? key_preproc?

> +/* RSS hash function data
> + * XOR the corresponding source and destination fields of each specified
> + * protocol. Both copies of the XOR'ed fields are fed into the RSS and RXHASH
> + * calculation.
> + */
> +#define	RXH_HFUNC_SYM_XOR	(1 << 0)

We need to mention somewhere that sym-xor is unsafe, per Alex's
comments.

> +++ b/include/uapi/linux/ethtool_netlink.h

You need to fill in the details in:

Documentation/networking/ethtool-netlink.rst
and
Documentation/netlink/specs/ethtool.yaml

Last but not least please keep the field check you moved to the drivers
in the core. Nobody will remember to check that other drivers added the
check as well.
-- 
pw-bot: cr

