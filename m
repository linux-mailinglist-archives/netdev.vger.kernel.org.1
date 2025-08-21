Return-Path: <netdev+bounces-215427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1004B2EA1E
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 03:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F213CA26B41
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 01:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD5D20A5C4;
	Thu, 21 Aug 2025 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="azrPYwo0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A28205E25;
	Thu, 21 Aug 2025 01:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738545; cv=none; b=Qk1TqNu3JUSfq0l2+S7FnQFyIkI163JuF7p+IQX5iLYMn7eOSYuGDcJpk0t3H4p/bPD+rmcdCezub5kA0fjAvofXuGfve82whAOhaMzSAKvXsMxgZtJH3rm20ixObgxyScgXBwECybWOUXbdbVhT5+e8kCiTpkgCPE/9CYRx6yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738545; c=relaxed/simple;
	bh=gtq0jIQtU/IupVs3g3uViyiQAgIXvKlbAHbOoT1t0Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cfERqUS2wf7gU+6U71JrxoYp+3d43pEMUDzZ1X02G4LG+FR6gSn/uQRXCG0PQkxpEEXSxLZKfp/XZGIYJgB6Cb3tOOF6KXpsmD91/gGqFldOvMYPmh40MWVY6ndPB392N1v/QjiZOwIKbrZoTpbg+8wJLlKKtv1o69wvS+3I5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=azrPYwo0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3080FC4CEEB;
	Thu, 21 Aug 2025 01:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738545;
	bh=gtq0jIQtU/IupVs3g3uViyiQAgIXvKlbAHbOoT1t0Uo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=azrPYwo0MTHuOeJW2+dAgzqrvgVaXncMZJXKeLFwqGTDbKZ8XBtcmNnC76bWTbClT
	 E11no9gpFOKtJMksyMM89VIfIZNqRc1tBaUvlUCPlUTTXYzFhHfsVXvE49WribZdUw
	 +wU3Lh7HURfO7mt7+pMnPC4bOigBnzZ+lr59aLDBYjiYkTtrzZ7NQaWGQoqI23Crp3
	 8kfbec3W9Cv8hBrkyM+euKA5qpZnS9jvP6oeMCzdW86/YeX9jJjWx9KgkKZyNcmI3p
	 9Sq4od5Ya4HECAIWusRK40vu93K0e7VtpwMI4PSg3yDYrrVWkNUzNE0r9nxVgsjFig
	 D7ZmQxqaB1LVA==
Date: Wed, 20 Aug 2025 18:09:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, <cratiu@nvidia.com>,
 <parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 6/7] net: devmem: pre-read requested rx
 queues during bind
Message-ID: <20250820180904.698f1546@kernel.org>
In-Reply-To: <20250820171214.3597901-8-dtatulea@nvidia.com>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
	<20250820171214.3597901-8-dtatulea@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 20:11:57 +0300 Dragos Tatulea wrote:
>  	struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
> +	struct nlattr *attr;
> +	int rem, err = 0;
> +	u32 rxq_idx;
> +
> +	nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
> +			       genlmsg_data(info->genlhdr),
> +			       genlmsg_len(info->genlhdr), rem) {
> +		err = nla_parse_nested(
> +			tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, attr,

While you're touching this line, could you perhaps clean up the line
wrap? Save ARRAY_SIZE(netdev_queue_id_nl_policy) - 1 to a const and
then:

		err = nla_parse_nested(tb, maxtype, attr, 
				       netdev_queue_id_nl_policy, info->extack);

or some such.

