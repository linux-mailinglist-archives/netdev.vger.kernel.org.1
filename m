Return-Path: <netdev+bounces-131229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DFA98D655
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ED1C1F23774
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 13:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04171D094A;
	Wed,  2 Oct 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umjtUYvy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765C71D0493;
	Wed,  2 Oct 2024 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876308; cv=none; b=HaDpaeSnaT4V7D/hH9qDk3t/Au1633lCzA/jz02zyXJLpT3T0HAs1c7XcSyPRxRpQui/0ZbU+w44cIC1yy2fkVOLiqU62xtkaP7g0Ra2+5EnRDUKxQfptDIh75WBPv9AGTFikYvKANmwyrDUMjNhjkGgDwF424vRHQfZVykYQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876308; c=relaxed/simple;
	bh=VKfHAx7F+Y6FiCUP+5PjPpsAkvQR+HrVNviM8IFYysQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqcF8vxwNrFtN5mVP0QdhrITVS1jZddMmevPARaazdlkyyfadScsek1HWyr470uMwf24kwi6fPjCHKQS7ATL9IC5sYgh0NJ41sP/q58DEqqsZZATAZKTtzTFATrO97bB5zs8ToEmaVOpJXX9+9Yv/89c1uOyQxr1gzXZa1YbuRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umjtUYvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6F4C4CED2;
	Wed,  2 Oct 2024 13:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727876308;
	bh=VKfHAx7F+Y6FiCUP+5PjPpsAkvQR+HrVNviM8IFYysQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=umjtUYvyRXGbwGp5CJ+PW7PimKDHcWLgSuNRzaz3RnsUhxa2/hTrfLq0f71vprPk7
	 9pF70/tgO3zlDcj0JzTkYaz75PEmlVNBHSSl6i2eXJpIo6lX+gI3zZevVZrysNuAo6
	 x/w7NB43F39tN6ZUT+nL9HYZud7yN5x+QF+QFe6D7TbgPSwq5S49CVdFVKG4tV1Wiz
	 7JjHLAwe9MOjlikTddhPwRRH42GCuLVLPBGLoFmWFQSzzDHcwbJ9ovNsrNGcxgxAdv
	 Gdi6GNcPvVNV+k7BHc/Axzq4Wu48XXfYxVJYWeqlIvtc6S/s39hDuhLHVuo+JO9ret
	 itlQVqn6RoBKg==
Date: Wed, 2 Oct 2024 14:38:23 +0100
From: Simon Horman <horms@kernel.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: idosch@nvidia.com, kuba@kernel.org, aleksander.lobakin@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, dongml2@chinatelecom.cn, amcohen@nvidia.com,
	gnault@redhat.com, bpoirier@nvidia.com, b.galvani@gmail.com,
	razor@blackwall.org, petrm@nvidia.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v4 07/12] net: vxlan: make vxlan_set_mac()
 return drop reasons
Message-ID: <20241002133823.GC1310185@kernel.org>
References: <20241001073225.807419-1-dongml2@chinatelecom.cn>
 <20241001073225.807419-8-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001073225.807419-8-dongml2@chinatelecom.cn>

On Tue, Oct 01, 2024 at 03:32:20PM +0800, Menglong Dong wrote:
> Change the return type of vxlan_set_mac() from bool to enum
> skb_drop_reason. In this commit, the drop reason
> "SKB_DROP_REASON_LOCAL_MAC" is introduced for the case that the source
> mac of the packet is a local mac.
> 
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>

Reviewed-by: Simon Horman <horms@kernel.org>


