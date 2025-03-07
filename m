Return-Path: <netdev+bounces-172711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4530A55C8B
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 098E2177849
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B951519A3;
	Fri,  7 Mar 2025 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xx49e8od"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2541414A4F9;
	Fri,  7 Mar 2025 00:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741309174; cv=none; b=Zitk01o8x/qn2myIdXbK+4uk7PIzP4fwqQapjt0Dp3eA1W3MFOGhJdP6C9dqGfpvPQG/9IrNJX0iiAZoAMNydfHot7qO9teaChXz9mrMfZ9v9IOtpnsWlFr+BbMI05BDtrJu84ecYdDduFqzsO48cAk6Hk2kZZBXGt5G2afMenw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741309174; c=relaxed/simple;
	bh=Cg2qsx4qx6dQxL2dKMoV09fLDr7a4hn6EBItwZqDGGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjJ3UYmGZft34cQA8CnVpiQhu7LtU4zpqUXhHxC18ajtVYiPgWIBbfEMNu8qLvK2JukEDQiKNWkxOfQzWPzKMmfqbK7Lh3ODEa72yfj93GIt9b4CUI1FRMNSMagHpTQjzsUAAmeVNfypo6x3s6Fp2WQUxVPndxZs48BXKvBB6ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xx49e8od; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37826C4CEE0;
	Fri,  7 Mar 2025 00:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741309173;
	bh=Cg2qsx4qx6dQxL2dKMoV09fLDr7a4hn6EBItwZqDGGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Xx49e8odjgKN5abFOiSV4WP/FDGjg6AN+86g670RJ4qn7DNDD6tzDFYOf5sO6pYyg
	 J9uIA95n5YPjL3ubaBjCrbvqO/lwtwbrBPvSulpqdMwTdF4+H5O+MSorPu282E7sIp
	 WGJ05Mge/msv+7DjZ7soWwFlJCMjX5LTiP8Xndj5HiEDpr1Cfoizm0THFCdyq98nJs
	 0s2TJysz2Q0ybXYPB42JpVxbGuwEYcntGG7VjIBoSJp7zY8QgZqRJdmtqUBYKoGKwK
	 EncNbvLjrOCcLU5aGpV9/7TwEVK9R3DoU6vLDbykGzcGDCapLljk5XvGICRlR8A4ZY
	 FITRCI7Qg0q2g==
Date: Thu, 6 Mar 2025 16:59:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Chen Wang
 <unicorn_wang@outlook.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Richard Cochran
 <richardcochran@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Romain Gantois <romain.gantois@bootlin.com>, Hariprasad Kelam
 <hkelam@marvell.com>, Jisheng Zhang <jszhang@kernel.org>, =?UTF-8?B?Q2w=?=
 =?UTF-8?B?w6ltZW50IEzDqWdlcg==?= <clement.leger@bootlin.com>, "Jan Petrous
 (OSS)" <jan.petrous@oss.nxp.com>, Simon Horman <horms@kernel.org>, Furong
 Xu <0x1207@gmail.com>, Lothar Rubusch <l.rubusch@gmail.com>, Joe Hattori
 <joe@pf.is.s.u-tokyo.ac.jp>, Bartosz Golaszewski
 <bartosz.golaszewski@linaro.org>, Giuseppe Cavallaro
 <peppe.cavallaro@st.com>, Jose Abreu <joabreu@synopsys.com>,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sophgo@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH net-next v6 0/4] riscv: sophgo: Add ethernet support for
 SG2044
Message-ID: <20250306165931.7ffefe3a@kernel.org>
In-Reply-To: <20250305063920.803601-1-inochiama@gmail.com>
References: <20250305063920.803601-1-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Mar 2025 14:39:12 +0800 Inochi Amaoto wrote:
> The ethernet controller of SG2044 is Synopsys DesignWare IP with
> custom clock. Add glue layer for it.

Looks like we have a conflict on the binding, could you rebase
against latest net-next/main and repost?
-- 
pw-bot: cr

