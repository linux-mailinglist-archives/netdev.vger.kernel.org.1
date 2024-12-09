Return-Path: <netdev+bounces-150427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8911F9EA32D
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 00:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 829581887585
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 23:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887861F63F1;
	Mon,  9 Dec 2024 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmm9C9ul"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6448219F10A
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 23:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788319; cv=none; b=m/d2+abhLcdtKHsue3RsBJiH+2Hy2fJRibmY1/q+wXXfxSw+00mqVJvnc4vFdCGxVxyHzcJvqEoid3mq/RQhxcrcK7k9cP34N5a2w/NHweS0KwYl4VmlrL/Utm2n+XDgTCuIJ6mf01RSq7PannWz12KXoRSvY3t2SB/raH1csj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788319; c=relaxed/simple;
	bh=8UK2uET75K2Fs6UHha5BLMs94LdFMBM77wMB7p8SbBc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iPjDRBeK8DTzjPh+ON6DphGRYsAW//rLSSx9ZTAhRHTV2tn9h7kArt87hQua24S5phs5mABEthIE49sjCtVM8Fyhzvu0pGc3NSErzSiozch0BhkuOa5kh6Q0FaAOMhgTL8Nn000cyBe3/FYe3iMUIJukE3702by2FW5BboezEf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmm9C9ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621E9C4CED1;
	Mon,  9 Dec 2024 23:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733788318;
	bh=8UK2uET75K2Fs6UHha5BLMs94LdFMBM77wMB7p8SbBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kmm9C9ulVYoNl+FBTgLFJd/8mc1weOh0F6XavqRiKDzHPYFBHYYZzF/tu9Weo5Hrn
	 HjqlZ+3cAgmeqwOu3qvIQsTxmHjD5P8a0VUM02yYzauYSuHSOMS8GLWYfCe8V7Shjk
	 o3Gh7gS0vzVrGfdt3b3Eedbuu8vfTap0EnZS/ts7+pZmL40DZ9SB6LCOkcYec/J0pK
	 eRhgKCssjmEDDF3UIHBhJJMVPajAlMVxtvE4kuuAXH5vJ1/n3xTgbvFObv2Y2sHbHk
	 g94ZS4ToS+An3qX4SlCdUDsYcOTwuA07CkXh0M9BAuoYgQrUIs60D2+wC5GdzCHGGG
	 AIpql8ewnyVmg==
Date: Mon, 9 Dec 2024 15:51:57 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@toke.dk>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, cake@lists.bufferbloat.net
Subject: Re: [PATCH net-next] net_sched: sch_cake: Add drop reasons
Message-ID: <20241209155157.6a817bc5@kernel.org>
In-Reply-To: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
References: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 09 Dec 2024 13:02:18 +0100 Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Add three qdisc-specific drop reasons for sch_cake:
>=20
>  1) SKB_DROP_REASON_CAKE_CONGESTED
>     Whenever a packet is dropped by the CAKE AQM algorithm because
>     congestion is detected.
>=20
>  2) SKB_DROP_REASON_CAKE_FLOOD
>     Whenever a packet is dropped by the flood protection part of the
>     CAKE AQM algorithm (BLUE).
>=20
>  3) SKB_DROP_REASON_CAKE_OVERLIMIT
>     Whenever the total queue limit for a CAKE instance is exceeded and a
>     packet is dropped to make room.

Eric's patch was adding fairly FQ-specific reasons, other than flood
this seems like generic AQM stuff, no? From a very quick look the
congestion looks like fairly standard AQM, overlimit is also typical
for qdics?

