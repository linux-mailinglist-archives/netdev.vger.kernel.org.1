Return-Path: <netdev+bounces-112516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AFE9939BB4
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 09:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964A91F227BF
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 07:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD89A142631;
	Tue, 23 Jul 2024 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzrVLt8v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB613C68A;
	Tue, 23 Jul 2024 07:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721719582; cv=none; b=TK7gonYTp0FQfouaWlDx5xe08UURMf98ccFoDu1el7c5NnPD7JAS/jEKEgTb+Bm16uN65SoarhpXluNHzgMcxKSt5GRxjISs5dofKCEa8tnmWWaVwScJFdvuEcF3X9EXVntPtmoCYtcGIQ36rG2p89XvvJLCjfMzc7uXKoK9vxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721719582; c=relaxed/simple;
	bh=YZU0gTQABDtdmE4AO+JkcP/Ssup/ciryFTTWmKBoNEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQNwvYb+1w1fDh+5K69yaMIU99VF86iQ4DYVMQ9Pn5rhqVkxYKZYKX1lGYnm1bq+np9dHkE0PGEbuh+z6DoHSanGIg5GzE4PQP9XAI3YYCbOhLQwgUuRZBwCyRM8k8tGdiPqFEo2gKfCvMZCPzvc/GwWH/4xJORSrRALNWYmLcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzrVLt8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71426C4AF09;
	Tue, 23 Jul 2024 07:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721719582;
	bh=YZU0gTQABDtdmE4AO+JkcP/Ssup/ciryFTTWmKBoNEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DzrVLt8v9E4pOGia/VXlOb+z9be9+22EPH3WMm7ua8FiMqymWPCZkWwzn7ggp8ul6
	 dWbXs78T4x74M/A2VliiKUCY0gN+n+2NsQicdckrBmaRtSBfBnccaQaTSQ5gW0W7C/
	 hNugVlorSjwiVejp3xuGZ7EcFAE+8gF7sXPoyd4OB0prcLXdh5sq6x2zzOwTo9o4gS
	 hJFRqRWnkoQc5o8kFZ6RzwSHZ/mfcZ8u6NBIFvVmOz3DiJw/mDhhRLvz1nu3flp7KP
	 guBz738ffhQdPPKPaVPQrfaIEe30jCFBB31nQ9MYztYycXP3m9+MzDpErzRtUpWdse
	 rVLCvYAZ+7b3g==
Date: Tue, 23 Jul 2024 08:26:18 +0100
From: Simon Horman <horms@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: Re: [PATCH net] net: wangxun: use net_prefetch to simplify logic
Message-ID: <20240723072618.GA6652@kernel.org>
References: <20240722190815.402355-1-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240722190815.402355-1-jdamato@fastly.com>

On Mon, Jul 22, 2024 at 07:08:13PM +0000, Joe Damato wrote:
> Use net_prefetch to remove #ifdef and simplify prefetch logic. This
> follows the pattern introduced in a previous commit f468f21b7af0 ("net:
> Take common prefetch code structure into a function"), which replaced
> the same logic in all existing drivers at that time.
> 
> Fixes: 3c47e8ae113a ("net: libwx: Support to receive packets in NAPI")
> Signed-off-by: Joe Damato <jdamato@fastly.com>

Hi Joe,

I would lean more towards this being a clean-up than a fix
(for net-next when it reopens, without a Fixes tag).
But that aside, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

