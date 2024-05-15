Return-Path: <netdev+bounces-96616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E3C8C6ACE
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 18:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1EF1F23D60
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 16:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215F0F9F0;
	Wed, 15 May 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t7kswpoU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1134381BA
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715791259; cv=none; b=VHHUK15BmsAQfzKYm9OolVLkqzR76ZSAkNQ8Fgax/kChP3ys5ryP+pjlv5NjPvmviv3wOHn+LMvmAcqVha+glWY2oHLfdTdI8dWXaeksghxedzLoSnsv0bFhAi9FQ26L93Smqm78xIyKATykt4p212WEtr9bWwZ5YDrQnqdP9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715791259; c=relaxed/simple;
	bh=4qL6w4tE6WyjT7P7hOtxbmuhaAb884tJhu7uLIysHoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=reQd7kUO7sXI6r49EGZ1SdlniAVnZ5bqjrjbs66kbOuXTeaGaG2jq1XtST5tZvkt9GSFQpL2/vowS1ZB64Yrb3FvkjxAwIXXA1fVgMVwR+iyYJQDQKu1VIpr7oWxe1/iazYHbUhPq6lfP8yq8+vV1fZlZOSvdiSc8/lDySRyqcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t7kswpoU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049A7C116B1;
	Wed, 15 May 2024 16:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715791258;
	bh=4qL6w4tE6WyjT7P7hOtxbmuhaAb884tJhu7uLIysHoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t7kswpoUcdS54dEjdwi0nLiPs9PGSI+bCVXSq5F7I5Ms7KfHfUiwi2R95gjHpe+Ec
	 HcrEnttnp6ZKgum83H8xNWD9Z8g4NxK04kP9fpqyLU7hDHbhJJnofbfF+WOZnikXj+
	 3PuGJQoBOqjgdAeQpzAXtr8XfheWcuGFXCeR1+GnE96QRPgZ+Li3FI3yamy34C63rS
	 8hDYb7ZEY+u3FhSRE6J95PxhAcCQhrO2YE9XI8RATBz05Z31mImppwg65tsauF5W+O
	 jIZmCXzTkWgjahHvBASbhKaXTvl10/VXGaeei+7T9d13yBj/ikqxCYz3uXfnbHBcc/
	 tANjfvvdeE+Bg==
Date: Wed, 15 May 2024 17:40:54 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot <syzkaller@googlegroups.com>
Subject: Re: [PATCH net] netrom: fix possible dead-lock in nr_rt_ioctl()
Message-ID: <20240515164054.GB179178@kernel.org>
References: <20240515142934.3708038-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515142934.3708038-1-edumazet@google.com>

On Wed, May 15, 2024 at 02:29:34PM +0000, Eric Dumazet wrote:
> syzbot loves netrom, and found a possible deadlock in nr_rt_ioctl [1]
> 
> Make sure we always acquire nr_node_list_lock before nr_node_lock(nr_node)

...

> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


