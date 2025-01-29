Return-Path: <netdev+bounces-161557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 319C9A22518
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 21:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013227A2D7A
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 20:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EC71E104E;
	Wed, 29 Jan 2025 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4Ta15ds"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AAB1DE2D5
	for <netdev@vger.kernel.org>; Wed, 29 Jan 2025 20:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738182213; cv=none; b=q4Lzt06nu0CLGlC48wjLkf+qKY9WTeI3288R11i5OzA2X+SRhAwBMINPfJxs+U9ecpo3o1cgbQCeUqBQWL7b4vyyvKKuKa4pYB+8lSiUOKyljgC2PKdDKI9i39dweI6eqQ/WLWgINLpUqIM1r4UrF18/l8xMeb+LpsZ0k1HBYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738182213; c=relaxed/simple;
	bh=mAsz4aIlxFkKOs+g1gpsqduz6W2Lf802dacAt0osgTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mRysGcAoFKZLBSiYnqAA4dkCNl50968JIWRZzhHLYxyQtXPh/4k1LhIyMufwlnn2GAdV1G/gb8UKKnLuTJozrKprpEbl/vLOsvIiXpd8+1fSO+YcKhVw3dIg31AnQw8PM3FcntRmHVS6QnScn09nKcsqPR0PpCTAMY4R+oujllQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4Ta15ds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448E5C4CED1;
	Wed, 29 Jan 2025 20:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738182213;
	bh=mAsz4aIlxFkKOs+g1gpsqduz6W2Lf802dacAt0osgTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l4Ta15ds0BaMMqMIH7W/9mpLnrgf62IVwVg3WR2hkk57Cyo7OCG1+WK6gJFoFkblH
	 dLY7uoAG7o79s8L2qZpBPV2NgFAwus1jnNwJTTbk6smoODEbOEuu/qUh4fP6Ymq9ay
	 44jgRzjM+H2uoT7MlaqBFlkElcYWA/OR2cVGSIS0EsaZrfCbAhep+lIBlgSf+YZI0k
	 LWzr3PN92uQWXVt19mZSuiPqiWvwt4iveDghhGg8jMbK1jl/lKJ8YXeYBj5AnzSNmh
	 0UtxeC3rWo7b5QutKipVx53gKb2YUuCmyZIZxmHJxSLckyEE4IxVYfdWF0CuZsQL18
	 1GFIEqwEW6h0Q==
Date: Wed, 29 Jan 2025 12:23:32 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 dsahern@kernel.org, Tom Herbert <tom@herbertland.com>
Subject: Re: [PATCH net 1/2] net: ipv6: fix dst refleaks in rpl, seg6 and
 ioam6 lwtunnels
Message-ID: <20250129122332.20b6b172@kernel.org>
In-Reply-To: <d4cb495d-6549-4b5a-bcf4-38dbbdda202e@uliege.be>
References: <20250129021346.2333089-1-kuba@kernel.org>
	<d4cb495d-6549-4b5a-bcf4-38dbbdda202e@uliege.be>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jan 2025 17:17:28 +0100 Justin Iurman wrote:
> >   net/ipv6/ioam6_iptunnel.c | 5 +++--
> >   net/ipv6/rpl_iptunnel.c   | 6 ++++--
> >   net/ipv6/seg6_iptunnel.c  | 6 ++++--
> >   3 files changed, 11 insertions(+), 6 deletions(-)  
> 
> I think both ila_output() and tipc_udp_xmit() should also be patched 
> accordingly. Other users seem fine.

TIPC is not a lwt, the cache belongs to a socket not another dst,
AFAICT.

I think in ILA ilwt->connected will only be set if we re-routed
the traffic to the real address already? So the dst can't match.
CC: Tom, full patch:
https://lore.kernel.org/all/20250129021346.2333089-2-kuba@kernel.org/

