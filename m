Return-Path: <netdev+bounces-247463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C331ACFAF5A
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 21:38:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D62613050586
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 20:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 976762DF13B;
	Tue,  6 Jan 2026 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlK24uVp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710AA2D8762
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 20:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767731513; cv=none; b=d2EhzHixc5gQMw/p1X2AI2TM0YckwzcB80861FV45/Pp1DXet0dedvU6qflpmq6RVv8aKI4h4g4SaVlUgkDOtwr6AMO0ql5pnnlFK6GPYuMMDP4z67BrtheCxX7VvVFWq2gaLpCM/uxO8j6sRk7BLov2wCMsnhWiyZw/fdxo3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767731513; c=relaxed/simple;
	bh=yFfme5xOE4EjCZp/M45B+ETt4ExfevHntL37xcw6qj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SqeupzLftlV+49JPLDU7+RY5DKbkRTFmCg5D60qb5IEecQPYy17yQRXGhMtbjAXHLmgCKRWi9p4yxRunNu3LMlyKPd+TDq3xyv6pLotM5Tvcsq3YAYW0DoWIcM6/TrffTpcnOaHgX8djVIS+BSKpAZuPhRCsyNKVoqXxWxvNptw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlK24uVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93DE6C19422;
	Tue,  6 Jan 2026 20:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767731513;
	bh=yFfme5xOE4EjCZp/M45B+ETt4ExfevHntL37xcw6qj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PlK24uVpR4ExJ6tH/Xd+Cf3TzUpAEoOrvdfB8lNZB0iml0pnpxIkrTzhmWsCQIXWn
	 aLRDA88QS2m+QBR3Rzg6IqeE+gC8mM9SNzpL44M67iEu2j8g9vQcVPQrUH0/V16DFm
	 +/bZaqzRmy53PrRg0oiy3yVU0EyQaPoYI5uGU34brqF4EOhE28QCgfrlEul3D2uCR3
	 ZYJjYPfpk7uEOI5H6EuCVrvwgJ6JqlrYj8p3FvmJ2NtaBusgQYcwqX2OlnFapTZ+NN
	 gLPtnkdNP7tsvbZSSG+xDKfziJXaSeJxBTnhLEuU2nJIF1o/89l0Z6mJ9Gn7Ng7ou9
	 pJfTWqB+8IfOQ==
Date: Tue, 6 Jan 2026 12:31:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Florian Westphal
 <fw@strlen.de>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+6023ea32e206eef7920a@syzkaller.appspotmail.com, Mazin Al Haddad
 <mazin@getstate.dev>
Subject: Re: [PATCH v2 net] ip6_gre: use skb_vlan_inet_prepare() instead of
 pskb_inet_may_pull()
Message-ID: <20260106123151.03a984bb@kernel.org>
In-Reply-To: <CANn89iJnXg892OU13PeJMGvBKw90fJdqDaAmJ867Rptsm0zgNA@mail.gmail.com>
References: <20260106144529.1424886-1-edumazet@google.com>
	<20260106095648.07a870f1@kernel.org>
	<CANn89iJnXg892OU13PeJMGvBKw90fJdqDaAmJ867Rptsm0zgNA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 Jan 2026 20:33:40 +0100 Eric Dumazet wrote:
> For some reason I am unable to run this test from a virtme-ng instance.
> 
> I guess I wlll not make a new version of this patch, maybe Florian can
> take over.

Hm, no complications seen here:

$ vng -r --user root
..
prompt# cd tools/testing/selftests/net/
prompt# ./gre_gso.sh 

    TEST: GREv6/v4 - copy file w/ TSO                                   [ OK ]
    TEST: GREv6/v4 - copy file w/ GSO                                   [ OK ]
2026/01/06 15:30:35 socat[1704] W exiting on signal 15
    TEST: GREv6/v6 - copy file w/ TSO                                   [ OK ]
    TEST: GREv6/v6 - copy file w/ GSO                                   [ OK ]
2026/01/06 15:30:35 socat[1721] W exiting on signal 15

Tests passed:   4
Tests failed:   0


Happy to give you access to the netdev machine to experiment there
if that helps, just send me an SSH key.

