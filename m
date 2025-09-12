Return-Path: <netdev+bounces-222381-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8058B54021
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 04:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FDB23A6731
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 02:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961EE1957FC;
	Fri, 12 Sep 2025 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPRP64lh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8E954758;
	Fri, 12 Sep 2025 02:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757642706; cv=none; b=evU05dhAv0YWLcM6z6pjho16H7Z1KVxJzIjvPjASai1ZuPSVADIwNfxKU8IA955clvBygd5XdTSZlyeglYurYLKc4NHeeUL3r1nnUTL5xyIK32+ubLH8f8LxMiGoaLwTDnTxHsnhGVdGOaupcbYxqsxO4SaaeKYdoz6dW0FqAwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757642706; c=relaxed/simple;
	bh=OQktc7qvsw0EMnrbG4DiZN6JyBK9c6STSJXwgJ6Rvzc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lNF0+oFrCg4neZHdVwB0o6Z2JpOrHj7uVOWBc4aTYzGp/3e/gz4oe7UulbAeYyiFT6uo7Kzly91EQUqQZr/lOqk7btpefql3ECxggRnQOK2JHrvpcoz385cTTI/zfCg398oMdjySVAJknJo7rc/T1M4XzYxBEPmgClOULyvHTss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPRP64lh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D95C4CEF0;
	Fri, 12 Sep 2025 02:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757642705;
	bh=OQktc7qvsw0EMnrbG4DiZN6JyBK9c6STSJXwgJ6Rvzc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DPRP64lh1FFV7noH5OBvYJm4d6uDReRyssmPN330rSE+GYtKHY6HErIcUdsruCrUV
	 +V5+o1ZXpfr6DPRp80fVjjCITsqCs7mlWyJ0MyIiV8zEkaWbyavMVlHhzPPyvrTF+i
	 JZFKEjx5lrRXm7odtNyXZA4p+GgH1IafxEN5sjuM+mObMzRXswsRdnvR0uvtYux5bj
	 RNCgiSSwNCj7wjdwbd4jUOChQADIKSCzgsju2aWZxVcxNpUCkJLN9hYkz4hFUKGBOZ
	 JplK3gr92lByL5kx6yN+uCVy/a5q12o03S0UTsRAgA9OOheVPTR0gW+Bul0HGjDBK6
	 ufvW/D+WWOT+Q==
Date: Thu, 11 Sep 2025 19:05:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Simon Horman <horms@kernel.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>,
 <bridge@lists.linux.dev>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 00/10] bridge: Allow keeping local FDB entries
 only on VLAN 0
Message-ID: <20250911190504.7c37761f@kernel.org>
In-Reply-To: <cover.1757004393.git.petrm@nvidia.com>
References: <cover.1757004393.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 19:07:17 +0200 Petr Machata wrote:
> The bridge FDB contains one local entry per port per VLAN, for the MAC of
> the port in question, and likewise for the bridge itself. This allows
> bridge to locally receive and punt "up" any packets whose destination MAC
> address matches that of one of the bridge interfaces or of the bridge
> itself.

Alright, I'll admit I don't have a better solution..
And my attempts to stir up controversy have failed :)

