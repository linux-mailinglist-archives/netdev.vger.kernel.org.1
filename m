Return-Path: <netdev+bounces-182530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBAFA89049
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 02:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C6D716F152
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2983C625;
	Tue, 15 Apr 2025 00:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVY177Wp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04733383
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 00:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744675310; cv=none; b=scgBx8BC/4hkMZ98n2cFXTVbgc22RukVKXEMIhNjubTnCNv5o7n4HXTLI9fR6n6+o6x8IpNS1QoQka85GgUhcgLvvSDlbxKbyM+O+2yAmObW5FeAd7xbPLp1FMzjZ62eaaLLKVsJxhjiK7giFcTlO+HYpeBy1ryouY6M6maCXcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744675310; c=relaxed/simple;
	bh=mC19afZeHY7Z/iQP4q7pn0++TxnEGGgpORVauhM7Ec8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uTfoRGHYBX1tiQChKE2Ex62sXoLf0LE20jpgce1fotMlB+AYoC+JKWDKApse1KM2k7EM6INRc8eH9B/BkPXUzin2Y/ehVtK6hmMAXopN7PD+NSpNP/DJ9KE2IOJc5GMpf7aDFbEODlVF7SmM/gP4Ed7T2BjF46Djyoj3m/VRuBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVY177Wp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A789C4CEE2;
	Tue, 15 Apr 2025 00:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744675309;
	bh=mC19afZeHY7Z/iQP4q7pn0++TxnEGGgpORVauhM7Ec8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fVY177WpB0daNsG1CGMSXOdCV4j6FT+DXzTyL+o32o20LzE9K6GkMWkonjGUdpEeY
	 ThScR/ldDWsvZZ3DnIls3fEhLt6KU7pRZHeHcwEzMQ6xYz9NbXFE9F/MS7dJfdLcGo
	 w8HK7marGaB2lZ7TQRBpBiWfW2NfeWlW9/vwP8nahvV1nBqEe7a5eABwVH+3/DCtw5
	 Flw5NwRkD2mNt2DM0h9JRwnajtR0tvXH1IvwVZY78gLsRL6XsYEPsSAuehb0nMm4q5
	 mABo4dwrjMRcUU4ZoZV78t2Ec8dt8wRflngkU6NhIo47FIiSKdEawvA6qAT4yp4D4v
	 Pph3gBmXOY5jA==
Date: Mon, 14 Apr 2025 17:01:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 02/14] net: Add ops_undo_single for module
 load/unload.
Message-ID: <20250414170148.21f3523c@kernel.org>
In-Reply-To: <20250411205258.63164-3-kuniyu@amazon.com>
References: <20250411205258.63164-1-kuniyu@amazon.com>
	<20250411205258.63164-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Apr 2025 13:52:31 -0700 Kuniyuki Iwashima wrote:
> +	bool hold_rtnl = !!ops->exit_batch_rtnl;
> +
> +	list_add(&ops->list, &ops_list);
> +	ops_undo_list(&ops_list, NULL, net_exit_list, false, hold_rtnl);

Is this the only reason for the hold_rtnl argument to ops_undo_list() ?
We walk the ops once for pre-exit, before calling rtnl batch.
As we walk them we can |= their exit_batch_rtnl pointers, so
ops_undo_list() can figure out whether its worth taking rtnl all by itself ?

