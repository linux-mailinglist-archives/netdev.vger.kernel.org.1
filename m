Return-Path: <netdev+bounces-155036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A97A00BD9
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 17:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91DE93A31CC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E6B1F8F09;
	Fri,  3 Jan 2025 16:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DK6LKclS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F62146D6A
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 16:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735920408; cv=none; b=JmXMGS9b/WXd0XolKias2v2PyUoURylEcDuYcmFVZzmb4MWGjyiqA6AFCApXssO+8p3p285J+K3jH6fsChLP3GP7abLDZKJcKfWIioCh/h22oyr9Up4Lo+NU7lN8/ucJgQvxHp+AFowJXp2gD1ts7g3eli0W3SPeYFOU56wvaow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735920408; c=relaxed/simple;
	bh=qyVTeFfwzDvd/Of1fQkgJ3i9n5qkTNBLhD5o+Me8GDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mMXS9rI2gJ3GpXmwZKsCyiX+wcn5eDCQI9+6ntoYW0Sa+L0mDHJwlsog7b3Zw48Z8ZkdbJ6gV6kyOL1gfOkll04ObD8/KlwdOZhhsqfDaCtI7W1SsTj7I5rWobbFauDcXSoguoxcxQLkYDQXh6iY6doNTt1YxjUvbqrCf0e0u/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DK6LKclS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D30C4CECE;
	Fri,  3 Jan 2025 16:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735920407;
	bh=qyVTeFfwzDvd/Of1fQkgJ3i9n5qkTNBLhD5o+Me8GDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DK6LKclSY0VqEqOAxOIaenaDM0jOn/IjjanLR08IdW9RXCmnDBCr2eMEKhz9xNvWD
	 jOuFwgPzH+QVwQXxYWabMHs50H9hkojIiNnU25E1t4cKSmUhzPZDzp5BpLd17sDTHm
	 oQmkT9t4nTHap/xOJUIsFl6ytBPNb1MJhdRl/DPd1PQUEIJ0KU/f+gtBgqYR4iWGhp
	 QNb/e/Qq4P5NyAMhZrTmPNHdWXBY6cFjuoc+qMNrUbUxNGp15wctFetgrAxpGoSWhc
	 ZaFckUFqkRv+zFfwdU0BdpmHtUagSgua3leUWJBz8TwxvO6qOAlE0Z68yRPfhx/2SL
	 rhE6m5Qw5o9uA==
Date: Fri, 3 Jan 2025 08:06:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>, Kuniyuki
 Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, syzkaller
 <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 net] ipvlan: Fix use-after-free in
 ipvlan_get_iflink().
Message-ID: <20250103080645.5129915b@kernel.org>
In-Reply-To: <20250103140813.79819-1-kuniyu@amazon.com>
References: <20250103140813.79819-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 3 Jan 2025 23:08:13 +0900 Kuniyuki Iwashima wrote:
> +		if (dev->reg_state <= NETREG_UNREGISTERED)

s/UN//
-- 
pw-bot: cr

