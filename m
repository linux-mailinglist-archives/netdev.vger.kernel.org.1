Return-Path: <netdev+bounces-150912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD119EC118
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0740E168D0C
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546CF44384;
	Wed, 11 Dec 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2VMDjSV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB542A95
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 00:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878228; cv=none; b=Z6aJ75MtM+C2iS+BZFScY87TFQEenu3zVMHTleiFShtNsCzYtdQmss1WbiKghiNPFxAPBvDycG9Zq/Ge2A81Fkpi1zHdkB/8DAa9uuafVYdM9yETkeJU4yW7rVc0+anlL/MSgPNEGrwY0FlrAQESRVN9nnuCucbcU5pVfukctTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878228; c=relaxed/simple;
	bh=EZycgxuD5reE9DtbJIwv3u2ZKivLdMoidVvm/ottO2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nv4Vd4eWKMHM7l92CgMoWPvo/1aVIMgRmpvrLL4q8+dIlZIQ8RbA8LS2tUdwEsBGVGzoo1P6bm5G9oru99aYcG78sPSNqV+6+AwTtxh2Y9tAnSipJjZK4kamdOpEbqmJoxeRuCz6/eDSKNy/z92PbG+sib+PgLuQ2Uw3/ee/Z/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2VMDjSV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BF2C4CEDE;
	Wed, 11 Dec 2024 00:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733878225;
	bh=EZycgxuD5reE9DtbJIwv3u2ZKivLdMoidVvm/ottO2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F2VMDjSVvX2H6pa2LxUGmP3BD0ebP4T+lZTuHj2sEH03pQziU/I9BwgSg/gsS09fu
	 h9covyZOoW4fdXLUwl1SgBQEC8qeZ2qXZPPdYUzNr5Wk6+fVUyyzYER2ybe+ybKLEG
	 DSWCb2TUBGKGp1H7wL5+B9Ieb6sQWVyye9klUXqs9QmMVSTg9yyk/EVTaXMYEkmYUy
	 xlPfMLpAW1j5Zv8QUKKB34xkz9t6LcmoOjPGqFSHjfovQQS6LRKyg1ha7TuyA3twx1
	 RpyI9f0LDjJObHuxH8gUNd103Jf1lHEkr+pjlwH2VwQnAbrilvvFWK5loE+OjeKCjg
	 cTujYUYDRCTVg==
Date: Tue, 10 Dec 2024 16:50:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, netdev@vger.kernel.org, Maciej
 =?UTF-8?B?xbtlbmN6eWtvd3NraQ==?= <maze@google.com>, Lorenzo Colitti
 <lorenzo@google.com>, Patrick Ruddy <pruddy@vyatta.att-mail.com>
Subject: Re: [PATCH net-next, v5] netlink: add IGMP/MLD join/leave
 notifications
Message-ID: <20241210165024.07baa835@kernel.org>
In-Reply-To: <CADXeF1FNGMxBHV8_mvU99Xjj-40BcdG44MtbLNywwr1X8CqHkw@mail.gmail.com>
References: <20241206041025.37231-1-yuyanghuang@google.com>
	<20241209182549.271ede3a@kernel.org>
	<CADXeF1FNGMxBHV8_mvU99Xjj-40BcdG44MtbLNywwr1X8CqHkw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Dec 2024 12:19:11 +0900 Yuyang Huang wrote:
> >u8 scope =3D RT_SCOPE_UNIVERSE;
> >struct nlmsghdr *nlh;
> >if (ipv6_addr_scope(&ifmca->mca_addr) & IFA_SITE) =20
> scope =3D RT_SCOPE_SITE;
>=20
> Is it acceptable, or should I update the old logic to always set
> =E2=80=98RT_SCOPE_UNIVERSE=E2=80=99?

TBH I'm not an expert on IPv6 address scopes, why do we want to ignore
it now? Some commit or RFC we can refer to?

Perhaps you could add a new member to inet6_fill_args to force the
scope to always be set to universe?

