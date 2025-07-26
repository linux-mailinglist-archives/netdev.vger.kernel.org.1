Return-Path: <netdev+bounces-210261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2AB12809
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 02:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9AB97B315E
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 00:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E377178F4B;
	Sat, 26 Jul 2025 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTnAdPGo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73B1EEE0
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 00:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753490069; cv=none; b=Df40mEmMa0ZObLWDzJeSEZpOSZ3aCQQ2d6CAw9d6Jk2b9debx6NGBpZNfD+qg+7cXB57ZqfKebdl4yVwqeQ1B8K9eFrH3S+cgaVFl+HPmso6bEFL/hEYn5P49G385+VjEclIHmsvNIL7muo2ErOC1AdGUqLuGJP6JjW1puxzGN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753490069; c=relaxed/simple;
	bh=jK0GCiFzqYs85NTqKJDGhOCqPw3HIbSkmAf2NVwbTrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMlGYbJaT62U62QhPrv9JORBLOIAWDfF7guBqFuN7+pn5f/ESyXeo77lUrgexiuX4ut2MgWBFDejlgPvP7wEeMiVhu6WodgldAf51HyuhBJ+57nYhvCATl4hg2yflTFuN3ZaCzPtpkEaaLmQr30a+Qp39jyfP4qjLyRzykoAGTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTnAdPGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8161C4CEE7;
	Sat, 26 Jul 2025 00:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753490069;
	bh=jK0GCiFzqYs85NTqKJDGhOCqPw3HIbSkmAf2NVwbTrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RTnAdPGoaHHkhBtT1ivVclOb7Zor3Ulei0e5Gm6mBtHenOzf+keEMb8l/tw+lLA0U
	 RSEkQE3Ro2RZ4OIZ7ce8QY6llZmQ48yM3RB225m3rKfWx9z8kffiRYHOCAH2so39Ly
	 VEdIItgvIW+bBdPcMVf9Ny5HobB1jLAuSJdS4icr/L4S8Wn0wz0DH8WeVGPpgl/Gpg
	 Zir09BM17LmQwtiSjKBYPu96Ragk5y7gnHstL0gQCj0syitynSIlER+TsGpdM7HtXd
	 +v2cwiXOZoaTu+bAYxeyApiNx5HG1IWrPM6hOtWSxHFjmG7L1cdmFYJ5KxgBcNuI9F
	 Xe6E8cFG4v2bg==
Date: Fri, 25 Jul 2025 17:34:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jacob Keller
 <jacob.e.keller@intel.com>, Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next v3 3/3] net: wangxun: support to use adaptive
 RX coalescing
Message-ID: <20250725173428.1857c412@kernel.org>
In-Reply-To: <20250724080548.23912-4-jiawenwu@trustnetic.com>
References: <20250724080548.23912-1-jiawenwu@trustnetic.com>
	<20250724080548.23912-4-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Jul 2025 16:05:48 +0800 Jiawen Wu wrote:
> Support to turn on/off adaptive RX coalesce. When adaptive RX coalesce
> is on, use DIM algorithm for a dynamic interrupt moderation.

you say Rx, and you add Rx as the flag

> +				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX,

so far so good, but then you also have dim instances for Tx ?!

> +		q_vector->tx.dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_CQE;

> +static void wx_tx_dim_work(struct work_struct *work)

I don't get it.

> @@ -363,10 +366,15 @@ int wx_set_coalesce(struct net_device *netdev,
>  	    (ec->tx_coalesce_usecs > (max_eitr >> 2)))
>  		return -EINVAL;
>  
> +	if (ec->use_adaptive_rx_coalesce) {
> +		wx->rx_itr_setting = 1;
> +		return 0;
> +	}
> +
>  	if (ec->rx_coalesce_usecs > 1)
>  		wx->rx_itr_setting = ec->rx_coalesce_usecs << 2;
>  	else
> -		wx->rx_itr_setting = ec->rx_coalesce_usecs;
> +		wx->rx_itr_setting = rx_itr_param;

looks racy, you should probably cancel the DIM works?
Otherwise if the work is in flight as the user sets the values
the work will overwrite user settings.
-- 
pw-bot: cr

