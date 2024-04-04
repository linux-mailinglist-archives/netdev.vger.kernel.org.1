Return-Path: <netdev+bounces-84961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9C1898CDC
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 19:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88391F294A2
	for <lists+netdev@lfdr.de>; Thu,  4 Apr 2024 17:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6B1129E8A;
	Thu,  4 Apr 2024 17:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iByao/Ww"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9601DFCE
	for <netdev@vger.kernel.org>; Thu,  4 Apr 2024 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250036; cv=none; b=K94golA/xhWvVfP8vZOqZcOwXAul6dirAft4yYUGR7OEenUY+PwYATMeuQHhHVNcnnGz+xsFWr93HAUEKNs1Fk4Ig1f8nppXSBtk/JLQOir2lAX7z9EY64JkVTZkQ1M8f2hdWyg3eHGZtrIOISyyd46CzUgmea9pyqLLteCQPso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250036; c=relaxed/simple;
	bh=RBZDmoS6vCehQ+96cG/lhHLP60Kz+2aeO16mfqLZFAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsA5WhIEKwh3v/HxrVLJGSav9PKKEeuhMzRA8kuVmp06qkxh8xkTbf+CMgyTzHQmIiAwchCAVFtKbcjwRln44D79iLYeaLag8UaGfwDg7m+AzpubWWkFX0YVxaqTWaTPKJL9EW8z6SHfTpTgqRaoWYbsnhTl8FK9sCkRZSBeGfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iByao/Ww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E07C43390;
	Thu,  4 Apr 2024 17:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712250036;
	bh=RBZDmoS6vCehQ+96cG/lhHLP60Kz+2aeO16mfqLZFAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iByao/WwmVzf6UxQFXq4n2x+1BAjN8pRUMmzIJoDZmhRF99wBe5hoF5dRO69cmUnf
	 OdEdMIZt0uQ2tUZzEEwL+p6JHdasNZHUgtCeg0+luDwzpKFRYag9e0OTXu5o1V2AwE
	 Ga3psUgbYZ+Igwq+pTjuCsz62dizD1qeRMgOheuTjtYKxuzE/NjNlJusopE4pMC3JP
	 CvJxtiqJc2SMvzUeCNblWWB4w3Ox5y7B0/bxgf+fJwn/Vn4TwlNjdC1kE4fLK5K37o
	 qH4O28rZybdNAygFXeYjr9Ah1O8RLxAgiHm6k6qYveK1K66xOXi7RdQqtEpIw6V/1x
	 JksvZC5WLfxxg==
Date: Thu, 4 Apr 2024 10:00:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+9ee20ec1de7b3168db09@syzkaller.appspotmail.com, Phillip Potter
 <phil@philpotter.co.uk>, Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH net] geneve: fix header validation in geneve[6]_xmit_skb
Message-ID: <20240404100035.3270a7d5@kernel.org>
In-Reply-To: <20240404131126.2534400-1-edumazet@google.com>
References: <20240404131126.2534400-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  4 Apr 2024 13:11:26 +0000 Eric Dumazet wrote:
> syzbot is able to trigger an uninit-value in geneve_xmit() [1]
>=20
> Problem : While most ip tunnel helpers (like ip_tunnel_get_dsfield())
> uses skb_protocol(skb, true), pskb_inet_may_pull() is only using
> skb->protocol.
>=20
> If anything else than ETH_P_IPV6 or ETH_P_IP is found in skb->protocol,
> pskb_inet_may_pull() does nothing at all.
>=20
> If a vlan tag was provided by the caller (af_packet in the syzbot case),
> the network header might not point to the correct location, and skb
> linear part could be smaller than expected.
>=20
> Add skb_vlan_inet_prepare() to perform a complete mac validation.
>=20
> Use this in geneve for the moment, I suspect we need to adopt this
> more broadly.

Something is cause the ttl test do break:

# =E2=94=82 geneve =E2=94=82     4 =E2=94=82     4 =E2=94=82 inherit 0x3c =
=E2=94=82    inherit 8 =E2=94=82 false =E2=94=82./l2_tos_ttl_inherit.sh: li=
ne 350: printf: 0xeaECT0: invalid hex number
ok 1 selftests: net: l2_tos_ttl_inherit.sh # SKIP

https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/537382/6-l2-tos-ttl-=
inherit-sh/stdout

Is is possibly this change?

