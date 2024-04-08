Return-Path: <netdev+bounces-85893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA4A89CC46
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 21:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 625AF1C2162A
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 19:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1181E888;
	Mon,  8 Apr 2024 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGgcGhvy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F32145320;
	Mon,  8 Apr 2024 19:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712603605; cv=none; b=JQTTb7UzEujG1BcV3DSH629AiPvTN7wOr9oyRy4kyzV3lVJEVFEKRGwK4bLxAjqCigdEi5NZgmbpOU/bk0JGxyLSDLMKVmfTPSfAwaV96R0b3+EC1COxhvP23PgMHk8cHI6QPi2GxTmZwCajYildokhKBVfFqNxrHKifH+UqT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712603605; c=relaxed/simple;
	bh=0cUxDCNmzMJsrXlhxTaBaRv3mukkgbjebfSEsg+asYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYpak5tXwnLkP6/F9MuA/6pABdQcVbuLVcbXlGqG/TFgUwusIFfDZck+BLkyGKRJYsu9olrjsWN6dMUqsTrk+7M1b4AWp2GtWqlGHVbH8bs9TjkpFxQYZgnsrjRNDIl9MXL8yowtBbeX0yHu0ItX/V2Bfh5/kLHuPFiBRWlVos0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGgcGhvy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10563C433C7;
	Mon,  8 Apr 2024 19:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712603605;
	bh=0cUxDCNmzMJsrXlhxTaBaRv3mukkgbjebfSEsg+asYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JGgcGhvyHYeovftbP+QHv53cvmo4coxmnU43SrdS9/CEwxueQRzv6PXtj67PyN25+
	 oh1V5+KgcmAgR34aWNe+iQgymerHfXQSYxGWGLH0IBk4dgcKtyAYU0LhoPt2zkVM3v
	 TLiLSLbx/xl2zAvcJ8Su329ltHsD1s4PxHNLqUduhvVN7jKmkrwlb91a9y4q7atMik
	 FL7WMnZyQ5/Ycf5MpvxZ21Sbjf/pb6hh5RpC7o+FMoRE9Qix2PNByJM1YKSs5gVLgG
	 kitbF8sSBPh4EgGN9mCVqNc6r28Ipwqhkr6R4qEf+R5tSYN1c173dZ0Hrk8sgy/r/F
	 t4QiYgituKeBg==
Date: Mon, 8 Apr 2024 12:13:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v4 1/4] ethtool: provide customized dim profile
 management
Message-ID: <20240408121324.01dc4893@kernel.org>
In-Reply-To: <1712547870-112976-2-git-send-email-hengqi@linux.alibaba.com>
References: <1712547870-112976-1-git-send-email-hengqi@linux.alibaba.com>
	<1712547870-112976-2-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 11:44:27 +0800 Heng Qi wrote:
> +	nla_for_each_nested(nest, nests, rem) {
> +		if (WARN_ONCE(nla_type(nest) != ETHTOOL_A_MODERATIONS_MODERATION,
> +			      "unexpected nest attrtype %u\n", nla_type(nest)))

Maybe just use the newly added nla_for_each_nested_type() 

> +			return;
> +
> +		ret = nla_parse_nested(tb_moder,
> +				       ARRAY_SIZE(coalesce_set_profile_policy) - 1,
> +				       nest, coalesce_set_profile_policy,
> +				       extack);
> +		if (ret ||

if parsing failed it will set the right error and extack, just return
the error

> +		    !tb_moder[ETHTOOL_A_MODERATION_USEC] ||
> +		    !tb_moder[ETHTOOL_A_MODERATION_PKTS] ||
> +		    !tb_moder[ETHTOOL_A_MODERATION_COMPS]) {

If you miss an attr you should use NL_SET_ERR_ATTR_MISS() or such.

> +			NL_SET_ERR_MSG(extack, "wrong ETHTOOL_A_MODERATION_* attribute\n");

no new line at the end of the exact string

