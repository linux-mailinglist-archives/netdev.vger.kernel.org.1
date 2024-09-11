Return-Path: <netdev+bounces-127437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C16497563B
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:58:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE12B1C208CB
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829261A304E;
	Wed, 11 Sep 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8i+iOQQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6181A3044
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 14:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066697; cv=none; b=MJszq43nALfAtWe7uRNT+MOu5EuwYavzE+wvKOhmaJ+3DTNLegG15NVWRIx3hXnEN1ciyVk4goXoH5HfhpgzYInHfI+PEBeaHilLP6WYsHPgMZBvJwuQOYAYpNWyRz7aoXtwChsARSZlYfNZpHjtkLbBO4kNvs0ZrwHp6x+5J70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066697; c=relaxed/simple;
	bh=17b7gtCdntfhZwy64edh7H8HK7vwreoN9ywS3f/2MVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nEpcm7U47IoLZR/UnWmvrhFIvouj3J7Kh76X3p2uAO9FewDmTbmzvBVkhqIO+Ekr91mNn2Z3yW3QXgJ3Uu0PPL0VfqZYZjgrs1udolrjVJOtGAxd5gu5Qd3e6n3XtwZLbkjwjHhbjXVC7KQAPfGeOARBzQRchXb4JQZDKceUm/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8i+iOQQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7759C4CEC0;
	Wed, 11 Sep 2024 14:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726066697;
	bh=17b7gtCdntfhZwy64edh7H8HK7vwreoN9ywS3f/2MVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X8i+iOQQYGFx5Mt8CWrCIr6VMyWyVI00juKBczTMqH/VJxtSvD/nRzrgS3T+l+QgX
	 bMYZZvKJ7ON57od2bF2F/np+dg5csum56+CT5Lm36nS/d8WX4XnWZKfl9uHWcBlGWv
	 YQocp4QRrd8STy+ddBEmgXTL3hkAwblS2qEDZ1+FUDui4E8dsicyIYwi4Fj8PHUdNB
	 GRdwC0jjq3dOzR1CEZnwWWY2j0wkKxrBu+VM+0fAt91hmCF6B+Z3xaD6XGU2Mqu+4d
	 DynIKV0p+2R9+moNxcbjsNwnKuWB2TMzw6Dm2LHubM4tybTqsydnAIiUNPafsMZsix
	 Q/y7+ie+uST9Q==
Date: Wed, 11 Sep 2024 07:58:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 0/2] bareudp: Pull inner IP header on xmit/recv.
Message-ID: <20240911075816.171c626f@kernel.org>
In-Reply-To: <ZuFdn61NlY80sCyO@debian>
References: <cover.1725992513.git.gnault@redhat.com>
	<ZuFdn61NlY80sCyO@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Sep 2024 11:06:39 +0200 Guillaume Nault wrote:
> Forgot the Fixes: tag... :/
> Will send v2 soon.

Too soon, in fact:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr

