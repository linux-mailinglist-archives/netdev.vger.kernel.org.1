Return-Path: <netdev+bounces-69682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F1884C2B3
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 03:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26907B240CC
	for <lists+netdev@lfdr.de>; Wed,  7 Feb 2024 02:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16411DDC6;
	Wed,  7 Feb 2024 02:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsKb+HMZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7050F9EA
	for <netdev@vger.kernel.org>; Wed,  7 Feb 2024 02:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274349; cv=none; b=FY67CGADKIcAqtv+lYGAMClnCN8GLsTEFcAft6GCUAXUb3h3Pow/L9s/aldvrSfOPeHdbdHyBgE7xL6NIeBKnsbf23zYq0rK6cV/itV0rensmwLO/K4pEmk3+gWePXkKLsIhISZ5pqBQdYkzbDecpzKYdCFLyuIt2Ogfm4FMol0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274349; c=relaxed/simple;
	bh=MgFQt7+mW6+kJeUJTLWwhnb5nHTWtLRh9tlkeQpTXhY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=peiboILPKZonGxNs8lkBwRNlCXAX+cpq+4DPhGgpK+sLw8P9xvk5vDWedJIE3nsr3NcehB7A5bSnWpH3IZHsUN6cs+/mt7BA0jUjYpqiHR4jAAof/CNq2CYYF1ZBVN3r3ZMf/2r6tQ/q7pi6HEiOppHp32Q0rS47eZVsb8k3x0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsKb+HMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A551C433F1;
	Wed,  7 Feb 2024 02:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707274348;
	bh=MgFQt7+mW6+kJeUJTLWwhnb5nHTWtLRh9tlkeQpTXhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PsKb+HMZel68JRZpb/EFP1V1yuMJFg0vydx0ccAxDTxQsbluzXTuaH40uGrrne4ab
	 IRemKlnQcGlv6TtBZbRQPEDf5/mC3sBK9CKGto23SCtgvO1wRWwVgdXKReVgUpeccO
	 /L7pO5HYpwLYhf+8FzSuz2PcQg3YAOS2v1bS5onK8tFPc5Xxb01FeFhc6QkUOLuc52
	 aVjrqLFls0pyKjsFnJxRTUi5YHZoefnCM1pHH25DedLVkZm78l+VTtTlXwz7KfOcad
	 kxe+zh/bSJ95NWmEiNkzwlMmawrgjaoA5mECtvxJFxjHt1R7ygq42alSvcXSKo0PEL
	 ssC8AS0Uqqn1w==
Date: Tue, 6 Feb 2024 18:52:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Geoff Levand <geoff@infradead.org>
Cc: sambat goson <sombat3960@gmail.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net] ps3/gelic: Fix SKB allocation
Message-ID: <20240206185227.5c167ea5@kernel.org>
In-Reply-To: <2acf3fe5-7206-46d6-adac-0bf40d175d5d@infradead.org>
References: <2acf3fe5-7206-46d6-adac-0bf40d175d5d@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 10:48:07 +0900 Geoff Levand wrote:
>     Commit 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
>     of 6.8-rc1 did not set up the network SKB's correctly, resulting in
>     a kernel panic.
>     
>     This fix changes the way the napi buffer and corresponding SKB are
>     allocated and managed.
>     
>     Reported-by: sambat goson <sombat3960@gmail.com>
>     Fixes: 3ce4f9c3fbb3 ("net/ps3_gelic_net: Add gelic_descr structures")
>     Signed-off-by: Geoff Levand <geoff@infradead.org>

Please make the commit message describe the problem in more detail.
It's also indented for no reason.

