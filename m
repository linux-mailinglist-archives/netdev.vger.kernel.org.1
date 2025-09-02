Return-Path: <netdev+bounces-219346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F266B41071
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:01:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09F3F3B5E51
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B29627A123;
	Tue,  2 Sep 2025 23:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1DC267B7F;
	Tue,  2 Sep 2025 23:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854023; cv=none; b=eF+QhP5Y9sGOng4kkfzBO9ZmRqI0y5J5iavRTg2KQjiDSEgu0RIm1hnsqirGuw39O2zgmWrR6CBqfDg700vDm9Z18/FJYd4OO7FFqQqRu3JZs1ATzDUtkg41jhDonCe1yXx4BKQrDXN8zkW0g7hNe/9PHvvWHj31Yna8Ys7+ehs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854023; c=relaxed/simple;
	bh=gIEbSBjlwdCsEUiAvY3BR8HPt+sMX6/SmnW/l9c2qyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN65Sdd11sroNRq+GHZoTykNFnTtdhhcbRVnJXrKMDlgmiUxLrX6yPsq3i9hm22RpHV7hhtnY3zlWwKzkP+HOnbBRvBHaASfAvWfTv6zE+zbGnGQ8J5mW8KDvmNGqcUeOD9cY4pMZlS9Mfknuovpugc52UjFEg8V7CAIE38rY1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8C25C54DCC8;
	Wed,  3 Sep 2025 01:00:15 +0200 (CEST)
Date: Wed, 3 Sep 2025 01:00:14 +0200
From: Linus =?utf-8?Q?L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Jakub Kicinski <kuba@kernel.org>, bridge@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Xiao Liang <shaw.leon@gmail.com>
Subject: Re: [PATCH 0/9] net: bridge: reduce multicast checks in fast path
Message-ID: <aLd2_um-oWhS23Md@sellars>
References: <20250829085724.24230-1-linus.luessing@c0d3.blue>
 <20250829084747.55c6386f@kernel.org>
 <bfb11627-64d5-42a0-911e-8be99e222396@blackwall.org>
 <aLdQhJoViBzxcWYE@sellars>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aLdQhJoViBzxcWYE@sellars>
X-Last-TLS-Session-Version: TLSv1.3

On Tue, Sep 02, 2025 at 10:16:04PM +0200, Linus Lüssing wrote:
> On the other hand, moving the spinlock out of / around
> __br_multicast_stop() would lead to a sleeping-while-atomic bug
> when calling timer_delete_sync() in there. And if I were to change
> these to a timer_delete() I guess there is no way to do the sync
> part after unlocking? There is no equivalent to something like the
> flush_workqueue() / drain_workqueue() for workqueues, but for
> simple timers instead, right?

I'm wondering if it would be sufficient to use timer_del() on
.ndo_stop->br_dev_stop()->br_multicast_stop().

And use timer_del_sync() only on
.ndo_uninit->br_dev_uninit()-> br_multicast_dev_del()->
br_multicast_ctx_deinit() and
br_vlan_put_master()->br_multicast_ctx_deinit().


So basically only sync / wait for timer callbacks to finish if
their context is about to be free'd, on bridge or VLAN destruction?

