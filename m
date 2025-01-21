Return-Path: <netdev+bounces-160114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B849A18476
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 19:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378D73AC21D
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 18:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADEEA1F63FD;
	Tue, 21 Jan 2025 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/Ozg/TY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824DE1F0E36;
	Tue, 21 Jan 2025 18:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482837; cv=none; b=VFSEAD9x7usEp4Cvfr52phCPJDsCHI0Y4RqW3/e4prMXExpwqt0i67zKaefZ2My9xnf29xG4u2MysLILgw6GX8Eog/oZMDgwPrteJZ0oL+8z6/vyt32nTwFupRxE1PpA54W/vAvAQkNxM9o60xwGKN3WKyyxE9kusSSIbhA1N8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482837; c=relaxed/simple;
	bh=J4UT365Ok9HELuxt2t6fBVtIwsEsrhsyX/XUzce9h8A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZIVrUCOrj6aJhJqi2eViNlK0x1e6xifnyDPPoNq7c8fbNt8pOo8qEsLPYz2NgMEtNYPffly44YtSutRMZtSLbSetY9ShiIw2RzXjZzLHug7r1qEuFQ50oj79PPP4/UUBdLPzyomCI95afKR1G5oCCPpc6tNnX6caoI5h5WqgWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/Ozg/TY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3439C4CEE0;
	Tue, 21 Jan 2025 18:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737482837;
	bh=J4UT365Ok9HELuxt2t6fBVtIwsEsrhsyX/XUzce9h8A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G/Ozg/TYwL7PXLgd5p310P5l4Ri7DFxSKpEykMxSgOItMACtxTs/wFj2A3UQHCere
	 W2hs0YjmVlJO26es7TxtnxXB09Q7AC5Oth3tHjz+xHRS3uW/BaURCYF9Dg6XvR/5pY
	 /eiHXynQAeDZu7uQngaUjErbv5MOMM0Jpa56v2NiB8X/sFPMeYjVT4Dy3zzW+7VWq8
	 8pdwvTsg91CvZAeQmRq6WXxLPiFgn2R2ADIZ3a/aYrZYJnNCFoPAJc7Wy9shS6COL5
	 VkuMnQcBuAc887pF7KoI4QacBXRQbEhWliy8Zf8mPSzUEBE1ltgoFKopQM4HlW1SUj
	 qr/y15DHsH97Q==
Date: Tue, 21 Jan 2025 10:07:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?Q3PDs2vDoXM=?= Bence <csokas.bence@prolan.hu>
Cc: Simon Horman <horms@kernel.org>, Laurent Badel <laurentbadel@eaton.com>,
 <imx@lists.linux.dev>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Wei Fang <wei.fang@nxp.com>, Shenwei Wang
 <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: fec: Refactor MAC reset to function
Message-ID: <20250121100715.5e2a9971@kernel.org>
In-Reply-To: <2ddcb00f-b5dd-46fd-a8f9-9d45c0ae82ef@prolan.hu>
References: <20250121103857.12007-3-csokas.bence@prolan.hu>
	<20250121151936.GF324367@kernel.org>
	<2ddcb00f-b5dd-46fd-a8f9-9d45c0ae82ef@prolan.hu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 21 Jan 2025 16:51:51 +0100 Cs=C3=B3k=C3=A1s Bence wrote:
> On 2025. 01. 21. 15:36, Ahmad Fatoum wrote:
>  > please make the lines a bit longer for v2. 43 characters is much too  =
=20
> limited.
>=20
> Reformatted to 80 cols.

Quoting "Submitting patches":

  The body of the explanation, line wrapped at 75 columns, which will be
  copied to the permanent changelog to describe this patch.

https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch=
-format

