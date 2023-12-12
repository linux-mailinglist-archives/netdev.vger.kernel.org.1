Return-Path: <netdev+bounces-56647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A7080FB91
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2D752822CB
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 23:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65AD27319B;
	Tue, 12 Dec 2023 23:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLF/GZks"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A581173C
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 23:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53DE3C433C7;
	Tue, 12 Dec 2023 23:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702424979;
	bh=z4PMRW3bLDOubA4hfT5LIRe1J2zSDJmQ3e8ZI5XcVIY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gLF/GZksTEXvRKeUoAtBQK0E/zr0nUIklRatkB/m1LbN8nSZL8D2eMuaPeRGKMpIL
	 Wlg005v0H7pAbg9NNZWHgQVJdIXOSuiLd5ViIbARTo0TVEPRDJZxCgIcuOqPXv09FK
	 FF13ecAtvRBajQzX4obiuKEfToYuRM0owsC9XReay5c9Jhdci4y3+VF7mtcWpUqmHJ
	 WD6rmpYr1o7weFVGdBL2DleILvvGbqD7FkxRHCRHAdeMQIHNzM82JgT+5Hj8bwCvMQ
	 e1eSiJLPeVY+ZIlXW+1+bLYS6l7aP2WdDeEWMZ3ySEMp2g+lMzSnheLn5nYT/DhhCy
	 sLSz2eJ3HXtAw==
Date: Tue, 12 Dec 2023 15:49:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
 przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v6 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <20231212154938.6e68fc1d@kernel.org>
In-Reply-To: <20231212101736.1112671-6-jiri@resnulli.us>
References: <20231212101736.1112671-1-jiri@resnulli.us>
	<20231212101736.1112671-6-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 12 Dec 2023 11:17:32 +0100 Jiri Pirko wrote:
> +static void genl_sk_priv_free(struct genl_sk_priv *priv)
> +{
> +	spin_lock(&priv->family->sock_priv_list->lock);
> +	list_del(&priv->list);
> +	spin_unlock(&priv->family->sock_priv_list->lock);
> +	if (priv->destructor)
> +		priv->destructor(priv->priv);
> +	kfree(priv);

> +static void genl_sk_priv_list_free(const struct genl_family *family)
> +{
> +	struct genl_sk_priv *priv, *tmp;
> +
> +	if (!family->sock_priv_size)
> +		return;
> +
> +	list_for_each_entry_safe(priv, tmp, &family->sock_priv_list->list, list)
> +		genl_sk_priv_free(priv);
> +	kfree(family->sock_priv_list);

Is this not racy for socket close vs family unregister?
Once family starts to unregister no new privs can be installed
(on the basis that such family's callbacks can no longer be called).
But a socket may get closed in the meantime, and we'll end up entering
genl_sk_priv_free() both from genl_release() and genl_sk_priv_list_free().

Also I'm afraid there is a race still between removing the entry from
the list and calling destroy.

