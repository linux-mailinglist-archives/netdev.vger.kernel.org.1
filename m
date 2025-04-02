Return-Path: <netdev+bounces-178910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED346A79867
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 00:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7035F18933E7
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 22:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F5741F419A;
	Wed,  2 Apr 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T159m+SA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C711F3FC0
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 22:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743633906; cv=none; b=PvK9oAyH8TQH7kmo4XahDLFmdatmujZJ+JpSGtw0v8v30+0MGFugNwdB8GajvYJqQDY87c4H31z3b+S/gGptXgVhYqQobjsSbi9/GmcvDKVtS8IWQS1K+NsaVQSCospjnrQxSdQ2INNnlTrpVtk40Iv4ka5sdkU9rveWod1N02U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743633906; c=relaxed/simple;
	bh=3ZCYrknP3EUFodr6yxtKiIsF+WFsMUgZSFvk38Uz0qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ahmeXgdUTKqs/nf4sKqoAauUIYOTxbuhkooz8IIpo/5RX0gJXcBu496sVOcDY7dXrO8Op79/uYg99cDsha7jcb0GXdyKD+t21fRZGS4VTYYPjJdOTc08ZD0CYa9Bo7zQOEMiwcOhMIQ9+sqxHsGhZN+mDcj3qtltPcIszEBoWFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T159m+SA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7818DC4CEDD;
	Wed,  2 Apr 2025 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743633905;
	bh=3ZCYrknP3EUFodr6yxtKiIsF+WFsMUgZSFvk38Uz0qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T159m+SAmuFG2SeQMzZSyhMGmUgfuGctSeG1/zlS5/8DScsmhibr4DSrFUTLxL3ZD
	 P0mPdjEICbqiLSb98ka0Ayur2akT14lxFE5KvhPKasYYj0mIpkoOp5///xaRb7yobK
	 XeTK7FZ9R9MgFGGCPvOhDzDN7Tl4ozF59h+CoeuJhor5Gr5oc2GXRbAR2IngQGXXDh
	 1q3f7oQF6n5txjaQK6KgUhtC+fOTBFqJdZMrMtTVnIij8EYxjlMfvXLyKeg20QbNzl
	 zmEUNoEsdj4jVZzunYorkeANimLhSWal9bySaDEoR58jA79ZmevV/r0NHdkZKd3Wd3
	 TkA+SM7Nf23kQ==
Date: Wed, 2 Apr 2025 15:45:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 ilias.apalodimas@linaro.org, dw@davidwei.uk, netdev@vger.kernel.org,
 kuniyu@amazon.com, sdf@fomichev.me, aleksander.lobakin@intel.com
Subject: Re: [RFC net-next 2/2] eth: bnxt: add support rx side device memory
 TCP
Message-ID: <20250402154504.0da028d2@kernel.org>
In-Reply-To: <CAHS8izNwpoH7qQbRqS3gpZaouVsR-8j5ju_ZRU6UmjO1ugbFWw@mail.gmail.com>
References: <20250331114729.594603-1-ap420073@gmail.com>
	<20250331114729.594603-3-ap420073@gmail.com>
	<20250331115045.032d2eb7@kernel.org>
	<CAHS8izNwpoH7qQbRqS3gpZaouVsR-8j5ju_ZRU6UmjO1ugbFWw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Apr 2025 15:11:39 -0700 Mina Almasry wrote:
> > We also shouldn't pass netmem to XDP init, it's strange conceptually.
> > If we reach XDP it has to be a non-net_iov page.
> 
> Very noob question, but is XDP/netmem interactions completely
> impossible for some reason? I was thinking XDP progs that only
> touch/need the header may work with unreadable netmem, and if we ever
> add readable net_iovs then those maybe can be exposed to XDP, no? Or
> am I completely off the rails here?

Right, I was referring to the current state of things.
Extensions both to XDP semantics or net_iov could change
the picture.

