Return-Path: <netdev+bounces-96747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777758C790A
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 17:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F15B1F21598
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 15:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A6714D2A8;
	Thu, 16 May 2024 15:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMw1POSN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CE014B97C;
	Thu, 16 May 2024 15:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715872272; cv=none; b=IMf26IDa6XHWEeKAGxDUTYFtkHd7g7JgYkT22xp/Ri8Wijkb+LHP5zKb0pxanmEbUr0cnTuSmrUN9tlDuIQKoVIzDJJReUCLyPWqw4fp4JGhqWBpVTwET0pDx/HcUDBcD2GmnL3k3fR53ARMN2ifsrg9SBlUZxruEvcg7Z2D6wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715872272; c=relaxed/simple;
	bh=xDeYPqR4VEtIRrWNOxoYaH3t1zUaIOP5W80O+Rgn128=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DVCTgOhlp3Z+0yNNcbUu47q1KZNHBU+ZSum/PevRQL84ba0WwLqLnEtgdZS7EHi2hrBR6/S37UwAUusZ4XGDp3Sks619pGmNdo/q75PYvsvVEQ5rKtV0v4Z/cs5379+BSfFUrWh9wFA8VIHgVcYXB3al51po2BA4d6ajZmi4vjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMw1POSN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7DEC113CC;
	Thu, 16 May 2024 15:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715872271;
	bh=xDeYPqR4VEtIRrWNOxoYaH3t1zUaIOP5W80O+Rgn128=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uMw1POSNIdN4u45MWrpiNs8WzgAR4wejZg+gkGn0I0Ebskq/q1XwJCNP9j1PGqBqo
	 54VL62AGw/n66c9rI2J5eMFMN6v34izdG08b0i/IRsYaMO9zsxN4/9EFpUJb1ZaKxS
	 7ciK6liNfjHiW95A2A3buEdES+K6MraL/kqKShCzmpwxkChxMrWbrfODBZ4Oivp+1q
	 erfPndHHMeJ7ooB6OzT2HQ7WanJ3jKyCyA4IeSeOQZ70oqL1pewO8kSlBhpP2Mza4E
	 4RaUWBUdKbf4hrnqUImHA6VbEqwGnG1wL/Yx03i9OSf+JQvOJHiELroxR/kDBGmoBb
	 ePXuen9uuzVSw==
Date: Thu, 16 May 2024 08:11:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Lena Wang (=?UTF-8?B?546L5aic?=)" <Lena.Wang@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Shiming
 Cheng (=?UTF-8?B?5oiQ6K+X5piO?=)" <Shiming.Cheng@mediatek.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
 <edumazet@google.com>, "willemdebruijn.kernel@gmail.com"
 <willemdebruijn.kernel@gmail.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "matthias.bgg@gmail.com"
 <matthias.bgg@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb
Message-ID: <20240516081110.362cbb51@kernel.org>
In-Reply-To: <bc69f8cc4aed8b16daba17c0ca0199fe6d7d24a8.camel@mediatek.com>
References: <20240428142913.18666-1-shiming.cheng@mediatek.com>
	<20240429064209.5ce59350@kernel.org>
	<bc69f8cc4aed8b16daba17c0ca0199fe6d7d24a8.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 May 2024 09:02:35 +0000 Lena Wang (=E7=8E=8B=E5=A8=9C) wrote:
> > One of the fixes you posted breaks the
> >=20
> >   tools/testing/selftests/net/udpgro_fwd.sh
> >=20
> > selftest. Please investigate, and either adjust the test or the fix. =20
>=20
> Dear Jakub,
> Sorry for late response.
> As we do not make selftest before, I try to build a test environmen and
> cost time to apply sudo access right in our company server.

Please read:
https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-st=
yle

Depending on your setup sudo may not be needed.

> Now it blocks to generate xdp_dummy.bpf.o. Could you please give some gui=
dline
> about the script test step? Thanks.

Install clang and run make? Please share some outputs or more details,
I'm not sure what the problem is

> Could you give more info about the failed situation? =20
> Is it this fix "[PATCH net] net: prevent pulling SKB_GSO_FRAGLIST skb"
> failed?
> Which case is failed?

These are the results, as far as I can tell:

https://netdev-3.bots.linux.dev/vmksft-net/results/573200/24-udpgro-fwd-sh/

> Is it possible that the test case has issue?

Entirely possible, yes.

