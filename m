Return-Path: <netdev+bounces-215074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CCDB2D0B4
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB3E3AFA72
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 00:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA84572625;
	Wed, 20 Aug 2025 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLxS4u/q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398F288A2;
	Wed, 20 Aug 2025 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755649848; cv=none; b=BFyPVqyboAKJRFW936l1bziKQv284joJ9rUZT+5XuXA6K9L2Egkf7LpADpzYFl47zyewRgcLW6ivc6fDHtmvdb7WDFig5J+rkmQziKBsnXn9B7TAv5G/JxFgLfBPEveB2fAmToUEGQQrEaesFGshnxM9iHr/SLFcAqPD0jwU0ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755649848; c=relaxed/simple;
	bh=7MqOhP2xH/nS3xf6TQ8IgxPWPmm4ZsoH1iVIajbjOaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaM5bIqheqzZyBbefUCkNp3Fd1fwDqjI80anXilbSC9L+tOnzMNhMDllN1MplhUuFy8sCKqhY7Qh1e83VabZcmet0NEr4VIJ3JNr9trSX9spqCy5qTruQZqCpCyMit2wWFfGrNvJL4vAXNZcF97LHX/bHjRzxIuWRTPm51O45xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLxS4u/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37C77C4CEF1;
	Wed, 20 Aug 2025 00:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755649848;
	bh=7MqOhP2xH/nS3xf6TQ8IgxPWPmm4ZsoH1iVIajbjOaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aLxS4u/qs7A4GjsyAFK5MtP1kJsynPLvN9Y3Z3B00HFnpOf4diEqgqQ7RYpdTQRKN
	 BdBCRssMMQICz1gFSNHAWZUHZ48vVnCQKAB79kEoHWsbWEp0jOmIW/uWlU/yhjZ+wj
	 fs9iY1D/oNbyDpFTy9UWnlyaQVnEDWAEL6cfJttRaWsmgVk7vxJ2R7xPPK0yebxAAL
	 oGle+kOTft4om5y2br5H86iTDHAIC4eilg5LphjRAtjiv32lsSQUQfLnEFg76h8+/6
	 7fxUuak6e9+8lTfz7tl4HHGeACDQ2uMj5Iolf6pq9zKXituFmuKmZaDjdH+xH2hJAF
	 EzmnYJRCQd+0A==
Date: Tue, 19 Aug 2025 17:30:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, corbet@lwn.net, shenjian15@huawei.com,
 salil.mehta@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 saeedm@nvidia.com, tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org,
 ecree.xilinx@gmail.com, dsahern@kernel.org, ncardwell@google.com,
 kuniyu@google.com, shuah@kernel.org, sdf@fomichev.me, ahmed.zaki@intel.com,
 aleksander.lobakin@intel.com, florian.fainelli@broadcom.com,
 willemdebruijn.kernel@gmail.com, linux-kernel@vger.kernel.org,
 linux-net-drivers@amd.com
Subject: Re: [PATCH net-next v2 2/5] net: gro: only merge packets with
 incrementing or fixed outer ids
Message-ID: <20250819173046.1ad3b50e@kernel.org>
In-Reply-To: <20250819063223.5239-3-richardbgobert@gmail.com>
References: <20250819063223.5239-1-richardbgobert@gmail.com>
	<20250819063223.5239-3-richardbgobert@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Aug 2025 08:32:20 +0200 Richard Gobert wrote:
> +	flush = __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->network_offset, false);
> +	if (NAPI_GRO_CB(p)->encap_mark)
> +		flush |= __gro_receive_network_flush(th, th2, p, off - NAPI_GRO_CB(p)->inner_network_offset, true);

Please wrap lines at 80 columns
-- 
pw-bot: cr

