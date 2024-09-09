Return-Path: <netdev+bounces-126734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A4972587
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 01:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0EC11F2415F
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 23:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD218CC0D;
	Mon,  9 Sep 2024 23:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTSN3TEX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19D3189909;
	Mon,  9 Sep 2024 23:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725922986; cv=none; b=d8+/vlkESqg+IJg/R+CjPqb1/bDDQXZaeJPWqbKcu3V+e7Tp36oN84Jp88Rvj/mKGqxzPuOrMKJzIwvzKyjcOkDJFXUccrIIKhXMOTSW4IJOWkaBShbfc70Z2eMJ81RUuUak+Q5OAI6bkbc9gDgj6kWFEfzvyvEtRs4n1/M72wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725922986; c=relaxed/simple;
	bh=5V1xxEvmq13W3EhLwz1aD6fBYRvzjjSLr0TTedOltgs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RCxtMT8B3YUCWKzIvXXAn5dXCR0UXnAucGROdU5ulOxI+lr19rn1MMfKmQe9PusP7lbeMZeuOnlSFl1XfjXP3rdK/qfXLEajIBCd/vkWQo+Q7GF5elJZlRBns3p9bNR5I47UjIhfsnQMqLwBNL+qKtr+p0pm50OY+xoOLAg/vWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTSN3TEX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBD8DC4CEC5;
	Mon,  9 Sep 2024 23:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725922986;
	bh=5V1xxEvmq13W3EhLwz1aD6fBYRvzjjSLr0TTedOltgs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qTSN3TEXpPka1pcnYOVZ5xMeUZZTYp7HH78NmxsR9c5UFFD6YEtV3zgkT4Qpp6jOK
	 IaCb0PvF6tW/lCH3DZ7S6GMhh3uxqPcK0MvIAdkSbXT/SVcEt9eULf6mBzBHjlGgMi
	 FJZ0hfMmGIKQ8w1b1epvnPkAJ8GZyc23BSqCFt7AzN/uTj2bs5Sz2GdfSBkXSZ1oba
	 Dakk9IT+Jdgyl60gEZQCLmdPhWAlyxhceOPsEuWK2C07yEXyaJSYveZeWMtHyXlhJp
	 EcM907pJF7lJD0p6AtcGVosPHai/WYZ1aL+2QYRbYj/fQgGbGXOMgVXjjIem9G6hql
	 8Wbd3sc1OPTxQ==
Date: Mon, 9 Sep 2024 16:03:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 edumazet@google.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, bjorn@rivosinc.com, hch@infradead.org,
 willy@infradead.org, willemdebruijn.kernel@gmail.com, skhawaja@google.com,
 Martin Karsten <mkarsten@uwaterloo.ca>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens <danielj@nvidia.com>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 5/5] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <20240909160304.5cf07038@kernel.org>
In-Reply-To: <Zt3JYp5Ltz5Imnq8@LQ3V64L9R2.homenet.telecomitalia.it>
References: <20240829131214.169977-1-jdamato@fastly.com>
	<20240829131214.169977-6-jdamato@fastly.com>
	<20240829153105.6b813c98@kernel.org>
	<ZtGiNF0wsCRhTtOF@LQ3V64L9R2>
	<20240830142235.352dbad5@kernel.org>
	<ZtXuJ3TMp9cN5e9h@LQ3V64L9R2.station>
	<Ztjv-dgNFwFBnXwd@mini-arch>
	<20240904165417.015c647f@kernel.org>
	<Zt3JYp5Ltz5Imnq8@LQ3V64L9R2.homenet.telecomitalia.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 8 Sep 2024 17:57:22 +0200 Joe Damato wrote:
> I hope that is OK.

I'll comment on the RFC but FWIW, yes, sharing the code with discussion
point / TODOs listed in the cover letter is the right way of moving
things forward, thanks :)

