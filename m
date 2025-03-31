Return-Path: <netdev+bounces-178461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BD6A7718B
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 01:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C26816A3DF
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C130421660F;
	Mon, 31 Mar 2025 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dg+NJLMk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4441DC9B8
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 23:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743465100; cv=none; b=RnxHOyBxxFI5AzWLu41i1ZvHHOEgx4JlPcxQOnfcrXNO8+kxUN0eARMnFZQoHkIKCFJLufPGy6KPyR0f35sZwzRDUviz+T+OAPRAn9StssvKRMPTtTq2iy0cov5Kb71lj7jzXfsumjkfyZvB3+o2zRW3sCzE1TesepMagiYrNqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743465100; c=relaxed/simple;
	bh=GdwAFnyC9+HG6YrD19YSXPwAh4c4bGfWOmSo+qN1+GY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=odzwDqycNJ26+IRMgjUFJow0eU7VVWd3ZPLn6uxnB37pANIbOuhUjQHfAbdHyHjFPDlwoEMnmyGloqWwV4rzs6Y+8G/1HRUMBE1Wm6CccrsoCO+cLQf8yCPsqaaeuh7bikn4fhTwF2M/C+eHEWgWUy8bWJm1E7hqtpnmykBKzFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dg+NJLMk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1B4EC4CEE3;
	Mon, 31 Mar 2025 23:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743465100;
	bh=GdwAFnyC9+HG6YrD19YSXPwAh4c4bGfWOmSo+qN1+GY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dg+NJLMk24WVe5HeoHT7yZKHkLr7q7kqlxAZmWvMgQPbugWuAHQMEAgJJnclQB+Zb
	 5T901YsjTlS68X6lE9l1TFm7BztygV6PQGhCOGM2a8OCLATBN7cq4u9q++jB9OK9kn
	 PRYvq9mEmzDhwFpXl5Ij2bzQGEsmcxnbMWMVLZxJ3e4VrXtVmQJgndLVfnm10jZxcg
	 8+M9emW1wvCykp7n+KIBYFJuCT+5SuIoqz+sNU8xKlvAG9CNgbOmyAgfUEXzCF5L5x
	 ln36iLE7wY1KxjHYBonCxoJzGbB2SQu+ymR2xX3ZYOfdeydOtuivxvOdZqp5Wj2Yi8
	 oCBTuPMGjVhHQ==
Date: Mon, 31 Mar 2025 16:51:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, maxime.chevallier@bootlin.com,
 marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, andrew@lunn.ch,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH v4 net] net: mvpp2: Prevent parser TCAM memory
 corruption
Message-ID: <20250331165137.467fbea1@kernel.org>
In-Reply-To: <20250327103139.567970-1-tobias@waldekranz.com>
References: <20250327103139.567970-1-tobias@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Mar 2025 11:30:49 +0100 Tobias Waldekranz wrote:
> +static void mvpp2_prs_mac_promisc_set_unlocked(struct mvpp2 *priv, int port,

Could be subjective but I tend to call things _locked, not _unlocked.
As it the function is called in context in which the state is already
locked. Could you change? Another way would be to just prepend two
underscores to the name..

> +					       enum mvpp2_prs_l2_cast l2_cast,
> +					       bool add)
>  {
>  	struct mvpp2_prs_entry pe;
>  	unsigned char cast_match;
>  	unsigned int ri;
>  	int tid;
>  
> +	lockdep_assert_held(&priv->prs_spinlock);
> +
>  	if (l2_cast == MVPP2_PRS_L2_UNI_CAST) {
>  		cast_match = MVPP2_PRS_UCAST_VAL;
>  		tid = MVPP2_PE_MAC_UC_PROMISCUOUS;

> @@ -522,6 +541,14 @@ void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
>  	mvpp2_prs_hw_write(priv, &pe);
>  }
>  
> +void mvpp2_prs_mac_promisc_set(struct mvpp2 *priv, int port,
> +			       enum mvpp2_prs_l2_cast l2_cast, bool add)
> +{
> +		spin_lock_bh(&priv->prs_spinlock);
> +		mvpp2_prs_mac_promisc_set_unlocked(priv, port, l2_cast, add);
> +		spin_unlock_bh(&priv->prs_spinlock);

nit2: this is indented too much

> +}
-- 
pw-bot: cr

