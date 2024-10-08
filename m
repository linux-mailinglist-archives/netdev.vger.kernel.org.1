Return-Path: <netdev+bounces-133322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6960B995A01
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 00:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315062834D1
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 22:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F4E2194A2;
	Tue,  8 Oct 2024 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnF/swaB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936AB21949D;
	Tue,  8 Oct 2024 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728425976; cv=none; b=E5el1ze4rWwdCdxTV9KMwe1w1YbqtPobguNvwGyfXB7GUFp7PtN6BvTZswze57EiL1yLfBQkGFbnPsANUJOlSoRPva3c7kcXnHBJbbyY18GQN58eI9SkaxvIQcMw2zsb7sI6k9HSY2ApJzMq6bzCp+oInbXHJBQqJLLDfoLgtt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728425976; c=relaxed/simple;
	bh=0NlChR/ivl2CuyoQglz7/bGlmFNHi+M/Cmn1JfeCQOo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mN62PMImtWQq0rkz4yiWZi94I50Y0SpWUPG/BpakDcbcLfXciwGIS6TRSxJN433c6aCJ3geIvnOZ6PrMrqzIsjxgo9/h6nKSpufdSuSQ+qO03/2OIx6ib5lOnJ9Yv1ZFZt8xbFjA0Ku2U7dOpjZknZ2hlggMDXHwa05FcwkiFV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnF/swaB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D5BC4CEC7;
	Tue,  8 Oct 2024 22:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728425976;
	bh=0NlChR/ivl2CuyoQglz7/bGlmFNHi+M/Cmn1JfeCQOo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SnF/swaBs+dVW6SqEthJYoxwwwup7zrJUIebMTwFWivbK/q1Uvj6kYrmGPZD4mudc
	 nNDD6pQN8XfVQCbOPtUpNuv3J7halrLe1/9hNQHtKsY3nR8mEhGxBP9YMGI/BQM5OP
	 qdunklKJXlFUWOGvyvll06YwImP84ZbWPoHJgU6HC4+QQsZi8+lGN2eJNUg2uQNI0U
	 RcwD5RScR/ny8ARAxO6FwU3hhp/Fh5KIFunaZvHZe0T6ekRjoYSjYXPU9WuZWp78+R
	 GUHXRmjValfeWaE/mZBj6FaEkCOnfHQDf+VSn3JONd0OWE6PMSccRHBHKYLvFEBR0b
	 /w+IWOrtCvgrQ==
Date: Tue, 8 Oct 2024 15:19:34 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com,
 sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com,
 sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Mina Almasry <almasrymina@google.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Daniel Jurgens
 <danielj@nvidia.com>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next v4 6/9] netdev-genl: Support setting per-NAPI
 config values
Message-ID: <20241008151934.58f124f1@kernel.org>
In-Reply-To: <ZwV3_3K_ID1Va6rT@LQ3V64L9R2>
References: <20241001235302.57609-1-jdamato@fastly.com>
	<20241001235302.57609-7-jdamato@fastly.com>
	<ZwV3_3K_ID1Va6rT@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 8 Oct 2024 11:20:47 -0700 Joe Damato wrote:
> Noticed this while re-reading the code; planning on changing this
> from NLA_S32 to NLA_U32 for v5.

Make sure you edit the spec, not the output. Looks like there may be 
a problem here (napi-id vs id in the attributes).

Make sure you run: ./tools/net/ynl/ynl-regen.sh -f
and the tree is clean afterwards

