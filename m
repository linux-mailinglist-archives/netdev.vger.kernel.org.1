Return-Path: <netdev+bounces-95290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 863758C1D24
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B85F91C20E23
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 03:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F86149C56;
	Fri, 10 May 2024 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8Gz1RUl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A750149C4D;
	Fri, 10 May 2024 03:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312588; cv=none; b=a6LfLu/KrxlsBK99DT8T9x7K2tjDLPFEjRXVkWF/EziuTBWvkTbd3Zfr3LHwF3ZKq3KUyc5tNx2I+eF0YSjQKQxo9EpQYgH8dU3ka9569YTjM4ELpMBH1IN2hr+LIqcOnjYMQUyqamcuzdb2M6VPfiE1wgp77MFzA9mlp/yzs4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312588; c=relaxed/simple;
	bh=IRI7ijMBENJeJbvWyeNQeNKWPmrdpYlkoms761MNs60=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g+EyYPqJAT4491L3ccDRdERDwnqCjtH2CiEBzadOvpWbsVvab6YRXnU/FSQ0lp5DlozWXe1eH9QSq12swxp2pS9gnnuF/DPYiLlVb5aS0gmg5upq4EvT6R7HcxkxYK4C4pbDXN6vaByMFul7aCbW1bTY7dHEzsrIc7KlJh6sApM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8Gz1RUl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCDC7C113CC;
	Fri, 10 May 2024 03:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715312588;
	bh=IRI7ijMBENJeJbvWyeNQeNKWPmrdpYlkoms761MNs60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R8Gz1RUl4VhP5EPAS9t58NVheClYuaRfeC+6xzWvNYEqR6PNPEGNt/0IP/TfBbvH6
	 1pbjVtS4hbPcRqoDsVp+byWcMdQ+YOG5IVvKT93tpBA/HMviAU2dfJJe8Owwn0e1iU
	 bhXtFcvaxLaAg3eetVSH77GnGfjBXZdCbuiJKO2g+UBebTeZwrLaArBk3fyjysG8bO
	 yYsai4nuHpSTLbKEpvwpYS24aOH3Gh+S9XWWI3neQ1QI1i2hvwflAx3kjLb54BKZ3f
	 aMhn7Xl+PMo4dpax30DDpfyTHhJXBVhAjQmY4o2kr654GwpGV4L/dJFHnAzBMkPZkU
	 q8TDdFLGc4/yg==
Date: Thu, 9 May 2024 20:43:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Florian Fainelli
 <f.fainelli@gmail.com>, Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean
 <olteanv@gmail.com>, Woojung Huh <woojung.huh@microchip.com>, Arun Ramadoss
 <arun.ramadoss@microchip.com>, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, David Ahern <dsahern@kernel.org>, Simon
 Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>,
 =?UTF-8?B?U8O4cmVu?= Andersen <san@skov.dk>
Subject: Re: [PATCH net-next v2 1/3] net: dsa: microchip: dcb: rename IPV to
 IPM
Message-ID: <20240509204306.1b4e77e5@kernel.org>
In-Reply-To: <20240509053335.129002-2-o.rempel@pengutronix.de>
References: <20240509053335.129002-1-o.rempel@pengutronix.de>
	<20240509053335.129002-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu,  9 May 2024 07:33:33 +0200 Oleksij Rempel wrote:
> IPV is added and used term in 802.1Qci PSFP and merged into 802.1Q (from
> 802.1Q-2018) for another functions.
>=20
> Even it does similar operation holding temporal priority value
> internally (as it is named), because KSZ datasheet doesn't use the term
> of IPV (Internal Priority Value) and avoiding any confusion later when
> PSFP is in the Linux world, it is better to rename IPV to IPM (Internal
> Priority Mapping).
>=20
> In addition, LAN937x documentation already use IPV for 802.1Qci PSFP
> related functionality.

Transient build failure here:

drivers/net/dsa/microchip/ksz_dcb.c: In function =E2=80=98ksz_set_global_ds=
cp_entry=E2=80=99:
drivers/net/dsa/microchip/ksz_dcb.c:323:25: error: =E2=80=98ipm=E2=80=99 un=
declared (first use in this function); did you mean =E2=80=98ipv=E2=80=99?
  323 |                         ipm << shift);
      |                         ^~~
      |                         ipv
--=20
pw-bot: cr

