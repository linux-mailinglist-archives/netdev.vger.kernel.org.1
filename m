Return-Path: <netdev+bounces-211108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C06B169CE
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 03:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E00417B263E
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E086D18E25;
	Thu, 31 Jul 2025 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTBi/jLQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66FE2905;
	Thu, 31 Jul 2025 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753923736; cv=none; b=M5inXwQ4XHBYwFoKbOWm4i7eh/tactpOxOs56E4iECtaRJ9ZQsT3x49rGnkKJH/Ad8C/yEdm7CI0mEukwV32WKjkTEK1vLdztR+9SrKww1GkQHVC1UsK634QCbq5cBH5bqIu+pqaNZp0hsWSsyBfSjGj4Ey3fDG8bQ4hbyiUh3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753923736; c=relaxed/simple;
	bh=hmN9l9Vi6ujl6uh+Y+dHiQhFOEZZlDuxLIeFf1SWCzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1n//iXdCo1PlFGkIKxcJM8B0/KW+tmOczO6mc5Z7SOlf/Kf63AnsKiIscBOsGBBwpFSXIPnQfPCOJ4I3pAc3H26UuSmyeCLdDRNKUbngjajkj4qiRuMi2d5a8j8F081vxiLwfRAiz7u3+oA0JPT8d6zRxwUXjk2kDihY9qFHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PTBi/jLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4133AC4CEEB;
	Thu, 31 Jul 2025 01:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753923736;
	bh=hmN9l9Vi6ujl6uh+Y+dHiQhFOEZZlDuxLIeFf1SWCzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PTBi/jLQfvVNbqKb2x3CtsAB2d52ZNPUJeQ8pochAWk2v/Y5/Ye/8ByEtMs3eoJIH
	 oWedv8WAm98dUt/i1M21WNqbUVlio/ChIrYXG97otgUdb7wMYROs9caeZqp5zD+2P0
	 4OjmGpD5LYJgi2M/UscVggyNGNPMcWOmCYg8XE1A/5lsbxYHUlspBtgbvedeZxZs7o
	 IXy07XINUnDCEXhVXuCXWw2kjrv1jkOPsNEifzr2JxUdh6i9tdw6eSlWvjdQlrHx7e
	 sZC3daYfwkdNx+wfQZAgx55TxV9ymlJ/2xS7H59nsHI3LYYXby28Fs4lA23DU2tazR
	 Dyq/bRGTDO2kA==
Date: Wed, 30 Jul 2025 18:02:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Luczaj <mhal@rbox.co>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Cong Wang <cong.wang@bytedance.com>, Tom Herbert
 <tom@herbertland.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] kcm: Fix splice support
Message-ID: <20250730180215.2ad7df72@kernel.org>
In-Reply-To: <20250725-kcm-splice-v1-1-9a725ad2ee71@rbox.co>
References: <20250725-kcm-splice-v1-1-9a725ad2ee71@rbox.co>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Jul 2025 12:33:04 +0200 Michal Luczaj wrote:
> Flags passed in for splice() syscall should not end up in
> skb_recv_datagram(). As SPLICE_F_NONBLOCK == MSG_PEEK, kernel gets
> confused: skb isn't unlinked from a receive queue, while strp_msg::offset
> and strp_msg::full_len are updated.
> 
> Unbreak the logic a bit more by mapping both O_NONBLOCK and
> SPLICE_F_NONBLOCK to MSG_DONTWAIT. This way we align with man splice(2) in
> regard to errno EAGAIN:
> 
>    SPLICE_F_NONBLOCK was specified in flags or one of the file descriptors
>    had been marked as nonblocking (O_NONBLOCK), and the operation would
>    block.

Coincidentally looks like we're not honoring

	sock->file->f_flags & O_NONBLOCK 

in TLS..

