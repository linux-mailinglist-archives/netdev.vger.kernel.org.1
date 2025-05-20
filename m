Return-Path: <netdev+bounces-191994-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CB8ABE24A
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 20:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B2B172899
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 18:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6834B262FD6;
	Tue, 20 May 2025 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgOexdei"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD922DA19;
	Tue, 20 May 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747764358; cv=none; b=diwx4gNw0i7sFn8/rlvSjFrBvbaMtHKIih465rnbcbS+90MRx1hC7rBHBX8Ha3AoAf+g+o4W/6Tpua+HjYY3oBBidclycDLRHlOmcpF+8G6oLFU8opB4DSEn4NmlC2m+yuKN3cowRtw6xu+PwW/9MfwsKLJAd3ihE0SGatyhwXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747764358; c=relaxed/simple;
	bh=HDk+BXDnz/lu0svgbrCEX8AyTuEOS8FBBM4Esm+FU04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoRgVqTOgFzwIkg5eJ01CL0O27AESH0Tld7PxYQyqeT6HkkoPnxUvbfaUaMM+Uw4n/07uJQKNAmXY9/VOFXvOS1gCrO1dPOheJfwGhEClx8j8rntz3uP8VQIpl5NntWcL83Ipk5+yKiItVZ+gYMfDh1PfUjoJkw0PbESYvyauzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgOexdei; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A8A6C4CEE9;
	Tue, 20 May 2025 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747764357;
	bh=HDk+BXDnz/lu0svgbrCEX8AyTuEOS8FBBM4Esm+FU04=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VgOexdeiHp5mDDDhPxmDQVdA9vAQNOpwWvaHL7LEA6Uz2JSpGw1QYvmRzxL6SGZN/
	 7Kqnyq/Ywydd9LQ4hye1LWFwxSNZbNzux4SejTwNoCXusYAdNU0FO/mBJrCvhCNNnk
	 B2mblmYCgyZvXEfPnUaHvpCy/ldLJiSdewQkiwtgc2yvQkzx5wNfLGkUn4StFatlSJ
	 jP3kzXKV0DsdlRDmUiBhbIOneTQRvBQNnGWG9Aq5c64RZdqcfoUx1oe133BKe/VqDS
	 2vpeDOmgoKkX7/ISZnPZreK05enjy6Q8CFYXFSJFzKCq9rmrOo0aAZzESxG/gY8i1/
	 9Dblcv8sBeT0g==
Date: Tue, 20 May 2025 19:05:52 +0100
From: Simon Horman <horms@kernel.org>
To: jiang.kun2@zte.com.cn
Cc: kuniyu@amazon.com, davem@davemloft.net, edumazet@google.com,
	fan.yu9@zte.com.cn, gnaaman@drivenets.com, he.peilin@zte.com.cn,
	kuba@kernel.org, leitao@debian.org, linux-kernel@vger.kernel.org,
	lizetao1@huawei.com, netdev@vger.kernel.org, pabeni@redhat.com,
	qiu.yutan@zte.com.cn, tu.qiang35@zte.com.cn, wang.yaxin@zte.com.cn,
	xu.xin16@zte.com.cn, yang.yang29@zte.com.cn, ye.xingchen@zte.com.cn,
	zhang.yunkai@zte.com.cn
Subject: Re: [PATCH linux next] net: neigh: use kfree_skb_reason() in
 neigh_resolve_output()
Message-ID: <20250520180552.GP365796@horms.kernel.org>
References: <20250520045922.34528-1-kuniyu@amazon.com>
 <20250520184032009VEzfxkkFmbQjfs0qCJ5QB@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250520184032009VEzfxkkFmbQjfs0qCJ5QB@zte.com.cn>

On Tue, May 20, 2025 at 06:40:32PM +0800, jiang.kun2@zte.com.cn wrote:
> >Is there any reason you don't change neigh_connected_output() ?
> >
> >
> >If you respin, please specify net-next and the patch version in
> >
> >Subject: [PATCH v2 net-next] net: neighbour: ...
> >
> 
> Thank you for your feedback.
> I notice that most commits related to kfree_skb_reason() involve changes 
> within the scope of a single function, which aligns with the meaning of 
> the commit titles. I consider this approach appropriate as it facilitates 
> both modification and traceability. Following this approach, I will submit 
> another new patch to specifically modify neigh_connected_output().

I think it makes sense to make changes that are closely related,
as seems to be the case here, in a single patch.

-- 
pw-bot: changes-requested

