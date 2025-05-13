Return-Path: <netdev+bounces-189928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B23AB4865
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A1919E767C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2993D984;
	Tue, 13 May 2025 00:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FH3f+MAY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D881BC2A
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747096011; cv=none; b=iOY+rr1NEghz6TlCx0s699zLdPwM8fuaPhlihOzslPGUVUNWuLSQR2ZcDE5j37Dk73O8llcOzuOHsIw0KyfNBf877htM/8XtPMlu9sS7/6R2TnT30a8V0S2vRMWK/j/brfI5q3HTqqLSTZjHkPXCTHG87yJ1Rz6z/HSFYNQiBcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747096011; c=relaxed/simple;
	bh=SsCzQDH2Uf/5xi+iMWl7ByaMb5F8BgLpErxT1Nw/kWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QqzWfxxx/vjh7mAKxkDCXcRcVND6xEB+4IyMh/o9Fof/vDH2T+Bjx6rSByR0huYHIlIZo1rOysfX6mgb5o9sNFYCZ+2eBnhQwKlhP21VNQ2ILckIbUqE9xbMRrRXNar9zBA2fH7fpLmEy5thORNiVCuCKPfFJx+NK/OZNSiGvgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FH3f+MAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C787C4CEE7;
	Tue, 13 May 2025 00:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747096010;
	bh=SsCzQDH2Uf/5xi+iMWl7ByaMb5F8BgLpErxT1Nw/kWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FH3f+MAYTS2zTkeUZqTwInN6rtQj6+SxQXZY1ljO0QFEg6Ls8gxKoqQs5UmdHfCli
	 T5WClTI3M+QlwKwlkwvY2HDvULHkaD7B+SLVXvAqAszPFNlQxhx1x6uGRiTMY06afG
	 oXB4Uh7jos6AiQC6Vc3Vgs5dAWF78XiRoxzSP1USUw97UUPrRclObVfaDZnxV128b8
	 fE/p7jMMb+eP+DpBghPdryeudBgHMjO2AALwfyiiRaD44Hg84YNSt9Xuo/ON1k5zNk
	 nSteF4ccVn/9JeTVs+8gmiE8kBB/+xKpSxOqk7E6/xt4TvBI1C2ivFHLs1kzm/Vv5x
	 aTSh5LVXRFcFQ==
Date: Mon, 12 May 2025 17:26:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, pavan.chebbi@broadcom.com,
 andrew.gospodarek@broadcom.com, sdf@fomichev.me, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net] bnxt_en: bring back rtnl_lock() in
 bnxt_fw_reset_task()
Message-ID: <20250512172649.31800d90@kernel.org>
In-Reply-To: <aCKHkBnPmVwmpsh2@mini-arch>
References: <20250512063755.2649126-1-michael.chan@broadcom.com>
	<aCIDvir-w1qBQo3m@mini-arch>
	<CACKFLikQtZ6c50q44Un-jQM4G2mvMf31Qp0+fRFUbNF9p9NJ_A@mail.gmail.com>
	<aCKHkBnPmVwmpsh2@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 May 2025 16:43:12 -0700 Stanislav Fomichev wrote:
> On 05/12, Michael Chan wrote:
> > On Mon, May 12, 2025 at 7:20=E2=80=AFAM Stanislav Fomichev <stfomichev@=
gmail.com> wrote: =20
> > > Will the following work instead? netdev_ops_assert_locked should take
> > > care of asserting either ops lock or rtnl lock depending on the device
> > > properties. =20
> >=20
> > It works for netif_set_real_num_tx_queues() but I also need to replace
> > the ASSERT_RTNL() with netdev_ops_assert_locked(dev) in
> > __udp_tunnel_nic_reset_ntf(). =20
>=20
> Sounds good!

Mm... To me it sounds concerning. UDP tunnel port tracking doesn't have
any locks, it depends on RTNL. Are y'all sure we can just drop the
ASSERT_RTNL() and nothing will blow up? Or did I misunderstand?

I'd go with Michael's patch for net and revisit in net-next if you're
filling bold.

