Return-Path: <netdev+bounces-110976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E0D92F2FC
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AFB3B2300F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B61510E3;
	Fri, 12 Jul 2024 00:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TzbrzC0V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABC3804
	for <netdev@vger.kernel.org>; Fri, 12 Jul 2024 00:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720743652; cv=none; b=FgUSwd8fcXK19g8766UfQOnNdT3vK1D/aecXpA8avaF48CEwUXb5zGdA5tvlZv5SxcR7/VYrrXP6A/RUcDBSpVMf/wqFJMuAkywpVCnYcbkXKDKwMkt9IjASfZT9MlPDhLREzThUueBqZmsp2jbcn+IoSwW42IG5POijttQH7mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720743652; c=relaxed/simple;
	bh=98Ei1sEbb+ZuXp0Z4GqGvLTCN8gd7+YXeUoZzIKkvsc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HOH+Y7YhR7WjN+ETa2hLGRe3PMvQnLaYGdUeow85w1Z84GBeQxX50r7kG1VieKzZ4g0fBnr+84K0Cce6WyisUR2F92vXEKKbg3UrRJFCDyLfezXsyKlZBZWDbF+c4XYUq6HAKYFx9yWd3ljnXSnwC1jctlDpROjN1JChTuu8w74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TzbrzC0V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF203C116B1;
	Fri, 12 Jul 2024 00:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720743652;
	bh=98Ei1sEbb+ZuXp0Z4GqGvLTCN8gd7+YXeUoZzIKkvsc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TzbrzC0VkONBsuFwcxiS1wWTM5pRCCFLSTuFaEmrqhDogsPCudkclbBKKm1vHVm/E
	 K9JBMpYKT6NixW40j2yYObX0mPWwXTjTWbcoBc484h7hc5FuIbJfiHmqr2L88uz0nN
	 hkfuPnJ2kF7EDwIta4FfG7gilyxloB0WsFdjPQeaU0QWjn0NEpkqQPyusamkBQxeC7
	 9vHxy7MlR3w2A73ZsyS18j51dXuBoa+lsLqDuIA/BZBCofOmxBbB7P+slzGKEA4e4e
	 EuQ/vth8T8EThRzKRIlGLyxrq/iUBEfpNwnxsMNJvQ5qUejQ+O7l2yzBRN1esB7Wic
	 kmxYx8gc2n7rQ==
Date: Thu, 11 Jul 2024 17:20:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Ahmed Zaki <ahmed.zaki@intel.com>, David Wei
 <dw@davidwei.uk>, Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net] net: ethtool: Fix RSS setting
Message-ID: <20240711172050.3385468d@kernel.org>
In-Reply-To: <20240710225538.43368-1-saeed@kernel.org>
References: <20240710225538.43368-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jul 2024 15:55:38 -0700 Saeed Mahameed wrote:
> Fixes: 13e59344fb9d ("net: ethtool: add support for symmetric-xor RSS hash")

I think :

Fixes: 0dd415d15505 ("net: ethtool: add a NO_CHANGE uAPI for new RXFH's input_xfrm")

will swap when applying.

