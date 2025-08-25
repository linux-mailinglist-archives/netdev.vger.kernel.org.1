Return-Path: <netdev+bounces-216542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A83B346DB
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 18:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8694C2A4C35
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 16:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D277D2EDD64;
	Mon, 25 Aug 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NjdVrsyV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90051F462C;
	Mon, 25 Aug 2025 16:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138205; cv=none; b=WQeglWfvJeiGKMzLFPx3sTxJg1HNFECwrxX/QdalFX6F0ZlADAW+gi1V3J8MIkWAO6PE5n/rj2CeZo+xjC7CR8h35a8khPGwf5RYyr8QLm3heZBmR+yHd0vIdvcOIyTBnzEhoWhjY+xdyNAdtpBG62x1cbH5hmp8LWo0ScORGmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138205; c=relaxed/simple;
	bh=wbTAb9rSnxYFUXvoyVCk3AuymjlIL0psa8aAMqsy+dM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXb0OEjzzEarFlsO6qK+rCpAUSFKoQGBZbtVfdFI2iklCzEdIIaG5AyVw6KDFmTcY0kCOXmwDoX0xn38DHrL+MggheXJ97ZqWP42KD0e+B1bOFqrz3Y2DIBp9hjZU6U2qCyVxglmR1I3bbe4a1MEGZYxlGBY5/1AiHGEKRcMbnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NjdVrsyV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC4B6C4CEED;
	Mon, 25 Aug 2025 16:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756138205;
	bh=wbTAb9rSnxYFUXvoyVCk3AuymjlIL0psa8aAMqsy+dM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NjdVrsyVUJXMdmFm1xjsPfBpwRvOs4NOXsAMUvUObt/al0wI79Wg1mypE36aoXjsJ
	 /+ffw9RBtjXRUvJqU1uxfNyxXFVcs9DQyhS5OmhgnOvZ4y5XgbueF5YbtHC5fwkSbA
	 eaSq+fDwM1k1qwCt0Z7ZixISESPlaVKD6cTuo6/RyTnnl1G5bCuHsdGqBz1kdzHeFs
	 4fIx6e9shHTW8IX2Y957MksiVArwStcs/CSCni02/D73sD5BwFGJdl3DAHgnUiHw4C
	 b5tow2vO0kYGOkBL3p2ck88Qo1bEyAVxo+Y5MO5aOUHPpjmFZ2XrLjwM/jCM0Q9qmT
	 DujzAALKwUhXQ==
Date: Mon, 25 Aug 2025 09:10:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: b53: fix ageing time for BCM53101
Message-ID: <20250825091004.316e71be@kernel.org>
In-Reply-To: <CAOiHx=mnXYmSsYzHQYDAnBg6vKzo0oj07hbiCJBVBegDbv4NAQ@mail.gmail.com>
References: <20250823090617.15329-1-jonas.gorski@gmail.com>
	<4469d2cd-5927-4344-acb0-bc7d35925bb1@lunn.ch>
	<CAOiHx=nC5f9-2-XPCKBVuVsh93NSrmbSQJp8RqF3EObbEq+OOw@mail.gmail.com>
	<a0e637f9-e612-4651-8b12-8cb82dd23c55@lunn.ch>
	<CAOiHx=mnXYmSsYzHQYDAnBg6vKzo0oj07hbiCJBVBegDbv4NAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Aug 2025 18:00:25 +0200 Jonas Gorski wrote:
> So https://github.com/Broadcom/OpenMDK/blob/v2.11.0/cdk/PKG/chip/bcm53101/bcm53101_a0_defs.h#L28966
> is what the link should now be (they also moved the repository).

Maybe using a hash would be even safer than the tag?

