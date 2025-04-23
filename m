Return-Path: <netdev+bounces-185198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 904FEA9935B
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 17:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D8C84A1D32
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B972BE7B7;
	Wed, 23 Apr 2025 15:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XEYKurOl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022842BE7B4
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 15:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422435; cv=none; b=r9WQYP2ISwQxAy86npEerx0LsuuL+1ybFrUVtfu81YV+989Y6wd1kgtPFK1EnjWqyZzIx+jk0vChoN5g+lHcqvpWfdW8dYsiEJtnUnwOCJmHLV8z5IZdBx1LiAxX5v8KjbXpT0Uo1e8jD3MI9iGVpFu+6ZcCHottN8ZJJvbaqLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422435; c=relaxed/simple;
	bh=Td/XFyQWqXshKnG3Fc4Q0JclVtbb2zGr7xtMq3mdoT0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QwHYbW3s8V3G1i/Fg1uu8xDh676NJpEAKfz65j0H/2fhnoQLrfNKRrAqoJm+I6mrQAlohEcm4TbRLIxMO9/uXsjS5idqNGpvR+O8ZbVdhK8+E7hWxvdu6s25/lifSsKt6RmKd/yoqCCGzc4xD1YkYi0bOG1lKUkxXqzhkImwDuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XEYKurOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107F6C4CEE2;
	Wed, 23 Apr 2025 15:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745422434;
	bh=Td/XFyQWqXshKnG3Fc4Q0JclVtbb2zGr7xtMq3mdoT0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XEYKurOlerTwpYHeTcp/KWfRL5qvWvELCvolDTMK5bmA5NZZXfjpTCTwAr8Ju++4J
	 5ncHF37CY+D0DqHGGott3vttrMg8Ikpoyjn+NNgeLflEmcKp2igPeVZff7UtNLFJyX
	 AD96k0snwn4LWEu2AvJY358OvOT9XD62vzSYEXSOvJOdi9FIqKBIJ73n5d924YU1B9
	 lv3p+Frc8nalhxvZEqqs+IZAVmLBgxAL/HN5Fhz7WfpEyu6IoBs02XHkyfs4XjdB1I
	 qw3AD8N1XtDQqLs3Bdn6D5Auw2Y89QDL/NNc1LS8QrNY3SNYvFwdnObDBX8B4HIMYN
	 s03V4snUYE3KA==
Date: Wed, 23 Apr 2025 08:33:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, sdf@fomichev.me, almasrymina@google.com,
 dw@davidwei.uk, asml.silence@gmail.com, ap420073@gmail.com,
 jdamato@fastly.com, michael.chan@broadcom.com
Subject: Re: [RFC net-next 19/22] eth: bnxt: use queue op config validate
Message-ID: <20250423083353.53088893@kernel.org>
In-Reply-To: <yjqlfsbjbaz4l72fmw6arm6expsq3qxxkxlwzkywrcr3o4rhdq@bfuqhyjlp3mo>
References: <20250421222827.283737-1-kuba@kernel.org>
	<20250421222827.283737-20-kuba@kernel.org>
	<a5uokb5qgp5atz2cakap2idwhepu5uxkmhj43guf5t3abhyu4n@7xaxugulyng2>
	<20250423064653.6db44e9a@kernel.org>
	<yjqlfsbjbaz4l72fmw6arm6expsq3qxxkxlwzkywrcr3o4rhdq@bfuqhyjlp3mo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 14:24:56 +0000 Dragos Tatulea wrote:
> With this new API, should drivers be allowed to use high order pages
> from the page_pool regardless of HDS mode? From your reply I understand
> that it is a yes.

Yes, I was trying to cover that in patch 1, I think? Up to the driver.

