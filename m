Return-Path: <netdev+bounces-221044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D42B49F06
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B311BC0D64
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DBA246798;
	Tue,  9 Sep 2025 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVFab32/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA743199237;
	Tue,  9 Sep 2025 02:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384151; cv=none; b=XmCQEzffo62sBeTCc1AE54Ptc2idv/nF6fu/74Ec9pok/BSxwmxyboDT8IblEDguZILjtszJBVhJ00fS0HX4pWX8YHhBM/g+nDjdaw0iXto14jUC3WPkQ1FRYhOGLzMGzGpfmZBwSNC+Ug3sfyWB7wjN4ZVPzv05zWpgDnIzTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384151; c=relaxed/simple;
	bh=7Scujo2X/uh+B46a7JkfPJXMqTNw66TRE7Wf7WUGpUA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=liLOi5ndT4cAyIHvVWYLgjBm2dlzGb5DTpZ77Nb+R11grzMUWknTPShGtlNJqkkMO7lEuzCHHWusXQXrs9qQnwWI6DZmv6muqfS2wvh9bzmBFRR3hq7YAYaINK8tL44MGZlY4P88ujp5PSevJlqGeG1v5dOiBsfXn+6Xqyyh7rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVFab32/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119F8C4CEF7;
	Tue,  9 Sep 2025 02:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757384151;
	bh=7Scujo2X/uh+B46a7JkfPJXMqTNw66TRE7Wf7WUGpUA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eVFab32/9vZMTa6FvZVXoOatK3Et75hPRBXxQWUfw0wlVfXxMT31Jhg2AAB5OoGW1
	 RhwwaNHnlJpKr4EFshmVpzpJJK0UnbHaQUsoXqBFB+KALgtmcqGpVkNQydquidoL8K
	 J30fz3CFu/ho9lRCQqeyGEVXPNACRNx0kIgVBKO7JpsDdNx/5qd7B6fqAdD40HhQRg
	 PZiBTTcsVThYLR9UMDBnjunbY7EgMH/XODSMsInSmSb0rUXmfRnc3gJ0pFEPJFKHUp
	 YEfPfH7G2PE33EiqoJWALQL05xRPshmleEsnDkv3CyPu3G8Eoc/iRQ4fPuZs6aR+BI
	 u8HSDqmSJV4ZA==
Date: Mon, 8 Sep 2025 19:15:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 <bridge@lists.linux.dev>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 02/10] net: bridge: BROPT_FDB_LOCAL_VLAN_0:
 Look up FDB on VLAN 0 on miss
Message-ID: <20250908191550.11beb208@kernel.org>
In-Reply-To: <8087475009dce360fb68d873b1ed9c80827da302.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
	<8087475009dce360fb68d873b1ed9c80827da302.1757004393.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 19:07:19 +0200 Petr Machata wrote:
>  		dst = br_fdb_find_rcu(br, eth_hdr(skb)->h_dest, vid);
> +		if (unlikely(!dst && vid &&
> +			     br_opt_get(br, BROPT_FDB_LOCAL_VLAN_0))) {

What does the assembly look like for this? I wonder if we're not better
off with:

	unlikely(!dst) && vid && br_opt..

Checking dst will be very fast here, and if we missed we're already 
on the slow path. So maybe we're better off moving the rest of the
condition out of the fast path, too?

