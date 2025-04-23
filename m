Return-Path: <netdev+bounces-184961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C25A3A97D02
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 04:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 860C23A4BE9
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 02:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02FCE2561D9;
	Wed, 23 Apr 2025 02:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQHsz1AF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170422F743
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 02:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745376479; cv=none; b=I5Ao0e3ijCH/t0Q4n+kAiPvURU1BBJk+yTPZKMslTnTg7bqoMJHfImZsTpTfEFB+en/NINi973X/syQbT/B2hlrR3xIg/hh/nbsO6nJ2O7+I3DBAxpf4EQuqN1XqIv1qnnbjyDyD3a22b9n66bFVVjPZXrrIqlH8Iuek50qpzGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745376479; c=relaxed/simple;
	bh=R+wi+zzJyAccPajLL+Z+/mos6dcLr1Owkc8y1bhFjxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgGXGnFkDTh8uACMOyMowI/IP/TcgW10LG1mZBNdleecLllz7VZB3hbNyynxqRVyWS65pM6cNSUCzvYtM81HN67HdksmjiPbjrorEGtF+xBiQU6LxJR9UPvvJ56pjVsyNeKl37hIhOUyKPoYRGrook0bfV8nBwPldToC4QrsqUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQHsz1AF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AC9C4CEE9;
	Wed, 23 Apr 2025 02:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745376479;
	bh=R+wi+zzJyAccPajLL+Z+/mos6dcLr1Owkc8y1bhFjxg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DQHsz1AF8yX68+SoUd+9JTSEFaj23bhBkPcMz82AWw3t9fMXir1wSM0Uh8zz8fPg2
	 G9cTHH/8ZCUZH8pcPTtvtLVwrwKMWaOf28czBIK7voGOFaECoO2dMAali9tMzxdlwS
	 9yghgHiBOwP8kev8loiT9bpo/JVXzvpGwU9+pSlQW8/anu1hu4/FNExDCcJaktI1Vo
	 dOC/hRrkkK59ms0B3qtK3jySDRa+UtG053xX176eCRGtTWCUvvtA6el7yT8s/Hx9OC
	 +GR8KTxtzmLhbMwmswtAccE66/CHfG4+fT+naVJMtDUTq95ACVLJFU4ZTbOi7zQj+w
	 tlmHEqraXhzkA==
Date: Tue, 22 Apr 2025 19:47:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>, Michal Swiatkowski
 <michal.swiatkowski@linux.intel.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to
 ->exit_rtnl().
Message-ID: <20250422194757.67ba67d6@kernel.org>
In-Reply-To: <20250418003259.48017-3-kuniyu@amazon.com>
References: <20250418003259.48017-1-kuniyu@amazon.com>
	<20250418003259.48017-3-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Apr 2025 17:32:33 -0700 Kuniyuki Iwashima wrote:
>  drivers/net/pfcp.c | 23 +++++++----------------

Wojciech, Micha=C5=82, does anyone use this driver?
It seems that it hooks dev_get_tstats64 as ndo_get_stats64=20
but it never allocates tstats, so any ifconfig / ip link
run after the device is create immediately crashes the kernel.
I don't see any tstats in this driver history or UDP tunnel
code so I'm moderately confused as how this worked / when
it broke.

If I'm not missing anything and indeed this driver was always
broken we should just delete it ?

