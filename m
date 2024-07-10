Return-Path: <netdev+bounces-110457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D64492C7E2
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 03:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9F39B2144A
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 01:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E6010FF;
	Wed, 10 Jul 2024 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7a9uTBX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFEF161
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 01:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720574588; cv=none; b=HwuW0nl6507qc4m/vPxMPR2x/+oQeX4/nNpTEX/oscJ61WQ/o8tDA3m7aMZ7wDt+PpH6b3smQPoO6eUC8ORxV6pUFY8TV3MOi1sKvY+Te7b907rShX9dZudugtZ4StSYWvkd+88efB1ZUBVU1ewxPOidElhb6g4wqqH1NR12xaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720574588; c=relaxed/simple;
	bh=3drADAeqyp1YqIv4Loa4O6arSZZ5t4WYkxWZfRz7Og0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Za3ZX55XklGkPil9D5fCCjqb4SmJkYtXUeaPPVHU+cwHeHS38wLdu0r8WOh63b48qbXvnAK+g01PcDYHqlJ13tPpNcZmtuSXbQZycrIRX+aRVHDIbIXiShdPGE/jAe4DxIF8aR1Ul7Vfe0ay0171SCQfuK3Hk55uwLfZim0xvSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7a9uTBX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 919B8C3277B;
	Wed, 10 Jul 2024 01:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720574587;
	bh=3drADAeqyp1YqIv4Loa4O6arSZZ5t4WYkxWZfRz7Og0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E7a9uTBXAt8frxeAe1rk3VNvO8Jiqut71epYy2rLQ0P5kQPtzi9wNGLtpgfu/0e03
	 mptQHI7/cU9rX34i63X6hUip3LECrF85v+MQiEaGdFf0ziSsEdVLGXi5taumRPNtRO
	 Q4kgyvuVHNpAbxmb73ARCW8xw4kc3mBswUdU5PCvUvlrfg2uXXCo9X4s895hal3mm1
	 v+MuI90sWuL0zhDf2bCbgeg+L6nd17Bz9A1O8y5xfQwTETsB+WB06LkW5dVffoKR94
	 K8behy0dYdoZKEUWPccCZAcf84kffu/5Bi/MbDhsnRo0Nb6nPXbuAypbokCgNhR0LC
	 UXu6CJLWXSmAg==
Date: Tue, 9 Jul 2024 18:23:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] net: do not inline rtnl_calcit()
Message-ID: <20240709182306.4d57315a@kernel.org>
In-Reply-To: <20240709230815.2717872-1-edumazet@google.com>
References: <20240709230815.2717872-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  9 Jul 2024 23:08:15 +0000 Eric Dumazet wrote:
> -static u32 rtnl_calcit(struct sk_buff *skb, struct nlmsghdr *nlh)
> +static noinline_for_stack u32 rtnl_calcit(struct sk_buff *skb,
> +					  struct nlmsghdr *nlh)

We only look at a single attribute - IFLA_EXT_MASK. We can change the
tb size to IFLA_EXT_MASK + 1 and pass IFLA_EXT_MASK as max_attr to
parse. Parsing the other attrs is pointless, anyway.

Or possibly just walk the attrs with nla_for_each_attr_type() without
parsing at all.

