Return-Path: <netdev+bounces-93117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0547B8BA1F4
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 23:12:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B459D283D34
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 21:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C5B181CF3;
	Thu,  2 May 2024 21:10:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from 14.mo550.mail-out.ovh.net (14.mo550.mail-out.ovh.net [178.32.97.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709211802DF
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.32.97.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714684208; cv=none; b=nImqLkeuZViVaEPD1cXTcr9i08Vhcser+1fIBHadgaXYHihHgPzyliVMgIPFH/kS9fptomMr8Wv5enQ/hjEgvQ+BAJb/IUdLP9M71hkKIjnQ8iGBIOBqgU6OvSNK1oWUuVxRId+RcrbGThfM24cUx1gHbqdjFv1qLN12GigT84g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714684208; c=relaxed/simple;
	bh=cTgo7+aJHE2nk0H3p70xZ3in3pAFKIAry1eHjn17NxI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtcZFtPlDDQk1k7I2m0lt2Xy/wwcEEMftQwq8Dh/Z0k3IAm7076NiznY5zJUdSdaqs0xp1f/Wy3QilzBtM8VhgeELJUL+mRcY9/tsmbzf2gE/W7Vxg9ouJyAv6ehkD6valYztBtRA7mmLm6+Ve8pNMGyf9Nggx84xN7FDy77F0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net; spf=pass smtp.mailfrom=remlab.net; arc=none smtp.client-ip=178.32.97.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=remlab.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remlab.net
Received: from director6.ghost.mail-out.ovh.net (unknown [10.108.9.136])
	by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4VVgz02Rybz1SPm
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 17:34:04 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-p7ckt (unknown [10.110.178.33])
	by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 6EB1C1FEA0;
	Thu,  2 May 2024 17:34:03 +0000 (UTC)
Received: from courmont.net ([37.59.142.101])
	by ghost-submission-6684bf9d7b-p7ckt with ESMTPSA
	id dyinD4vOM2ZHjxwAIsjhUQ
	(envelope-from <remi@remlab.net>); Thu, 02 May 2024 17:34:03 +0000
Authentication-Results:garm.ovh; auth=pass (GARM-101G0043524cd45-1f4c-45d8-8bf1-a314cbbc3aae,
                    BC5FE781039FBFCEAF078843559696CA6964CA31) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp:87.92.194.88
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To: "David S . Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com,
 Eric Dumazet <edumazet@google.com>, Remi Denis-Courmont <courmisch@gmail.com>
Subject: Re: [PATCH net] phonet: fix rtm_phonet_notify() skb allocation
Date: Thu, 02 May 2024 20:34:00 +0300
Message-ID: <5716887.zLmFTfJpZe@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20240502161700.1804476-1-edumazet@google.com>
References: <20240502161700.1804476-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 14883270870731594014
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgudduiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkfhojghfggfgtgesthhqredttddtjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhfegfeefvdefueetleefffduuedvjeefheduueekieeltdetueetueeugfevffenucffohhmrghinheprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomheprhgvmhhisehrvghmlhgrsgdrnhgvthdpnhgspghrtghpthhtohepuddprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheehtddpmhhouggvpehsmhhtphhouhht

Le torstaina 2. toukokuuta 2024, 19.17.00 EEST Eric Dumazet a =C3=A9crit :
> fill_route() stores three components in the skb:
>=20
> - struct rtmsg
> - RTA_DST (u8)
> - RTA_OIF (u32)
>=20
> Therefore, rtm_phonet_notify() should use
>=20
> NLMSG_ALIGN(sizeof(struct rtmsg)) +
> nla_total_size(1) +
> nla_total_size(4)
>=20
> Fixes: f062f41d0657 ("Phonet: routing table Netlink interface")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Remi Denis-Courmont <courmisch@gmail.com>

Acked-by: R=C3=A9mi Denis-Courmont <courmisch@gmail.com>

=2D-=20
R=C3=A9mi Denis-Courmont
http://www.remlab.net/




