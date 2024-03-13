Return-Path: <netdev+bounces-79708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A7B87AAF0
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 17:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A32481F220FA
	for <lists+netdev@lfdr.de>; Wed, 13 Mar 2024 16:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDE947F7A;
	Wed, 13 Mar 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iOId/y0Z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9843B481B3
	for <netdev@vger.kernel.org>; Wed, 13 Mar 2024 16:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710346260; cv=none; b=sxEbYfHFW4gHfolA6l733NuG4zemC60K0XmrSck+rfg6A1VaE7WWU3RhMjh4ZpqHmYdFSP9Q4WiIhe/WA+tcIWMZeYVeP2033MHNdojYcskfS91Z7n3JrHYtJancfSW7pcndiABzXdDm8yvGWr/hydJjP55o3+xR6vHp/r5dLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710346260; c=relaxed/simple;
	bh=s0VJuqZTcWPwBBsjpeg40Nzefkzjz6OIT5W3n/xwA3E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=fhwm2pJ7KY3uHtIGYjHKQIBFnJ3tsP0JJh5/KZMIpWwdH+SAkRjJpiV28+IE4ctWf5rKcoTxzC8A4ANX3pWKfx8bx+e9A3T3D82g5XQ13co1LY9piWRWytWrjZrVub2o9gjAqveKn/3VvOZ74MCXh/kUB83cgq9u3jY6GDhedQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iOId/y0Z; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Content-Disposition:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8kKC9A07oJ9EW+OTI/elilaag+/RMGD/lRFw0VD9nkA=; b=iOId/y0ZxYmdALfv2+N/ieSl1N
	TxVTPXwOTatWTSlorjUU71UZCVHpZ9LVFxrw5xRVjnK7DAj1tp3WZS+juxRg9SAwNA43FHzwGsjbz
	jx54kO3IuM68sp3jCasGyixQYJqlu2C2hKvnmByBvB6IjpugNpmuC1CZxuknOA+sKrsM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rkQih-00AExf-2Q; Wed, 13 Mar 2024 16:40:43 +0100
Date: Wed, 13 Mar 2024 16:40:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: netdev <netdev@vger.kernel.org>
Subject: VLAN aware bridge multicast and quierer problems
Message-ID: <123ce9de-7ca1-4380-891b-cdbab4c4a10b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nikolay, Ido

I have a colleague who is using a VLAN aware bridge with
multicast. IGMP snooping is causing problems in this setup. The setup
periodically sends IPv6 router solicitations towards the router and
expects router advertisements back. After a while, the router
solicitations were no longer forwarded/flooded by the bridge.

The bridge doesn't drop the RS frames, but instead of forwarding them
using br_flood(), it calls br_mulricast_flood() with an empty
destination list. MC snooping is on by default and is VLAN-aware by
default, so it should work in this context. If he disable it for
testing purposes, the RS get forwarded.

We then checked how the destination list gets computed. Not very
surprisingly, this is based on MC group membership reports in
combination with MC querier tracking (no querier -> no MC snooping,
i.e. br_flood() instead of br_multicast_flood()). So far, so good. We
don't have a querier on the VLAN in question but we do have one on
another VLAN running over the same bridge. And then he noticed that
br_multicast_querier_exists() which is called by
br_handle_frame_finish() to decide whether it can rely on snooped MC
groups doesn't get any VLAN information, only the global bridge
multicast context. So it can't possibly know whether there's a querier
on the VLAN the frame to be forwarded is on. As soon as there's a
querier on one VLAN, the code seems to assume that there are queriers
on all of them. And on those without an actual querier, this means
that destination lists are empty because there are no membership
reports on these VLANs (at least not after the initial reports right
after joining a group).

It seems odd that you spent a lot of time adding code to track group
memberships by VLAN but then left our the last tiny bit to also track
queriers by VLAN? So we are wondering if we are missing something,
some configuration somewhere?

We have a test script which sets up a bridge in a network name space,
and uses scapy and tcpdump to show the problem. I can send it to you
if you are interested.

Thanks
	Andrew

