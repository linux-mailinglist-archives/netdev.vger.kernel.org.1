Return-Path: <netdev+bounces-218330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B843AB3BFBD
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 17:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 413991884CCE
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 15:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19ED1322A2E;
	Fri, 29 Aug 2025 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+cFdOFh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE8126C02;
	Fri, 29 Aug 2025 15:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756482306; cv=none; b=qa48qIlMngG0WZd+lnJPXy/PM2pGVazPUnzFoVih5iiZ/zjxObjPZWI1seVyNj6CG75rQmI5NunEglnfgRGbVL5/3yn394ntBY9lpmkPy6ANA4UzGy2Ztb/3NHyX9c8Jfz8n3jZfSGCTMiEIHDxgdk3cNu9IwzoZQdQrV61IEf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756482306; c=relaxed/simple;
	bh=DtVgMgHCkemr2oZjqBAjxslmOlZU7lofDcxKF0w+s1k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JP+JZPt2gL9u/3fvH0ViJdtYIBKXTgxCqX2CpLQiZqoklMpwH/lSWjcmfBkVEzd748LccXfUCchaR7GdJbyKbdhkCujq4BNCRw+ANIBJ0PWq63YgppCfF1r7E5T+2ZXI/QvHXJKNCoY589zopSj0fztau5MiPCFb+D8Hs+1tp1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+cFdOFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF61C4CEF0;
	Fri, 29 Aug 2025 15:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756482305;
	bh=DtVgMgHCkemr2oZjqBAjxslmOlZU7lofDcxKF0w+s1k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c+cFdOFh5z0Y2+6drnecFUUlQBT3FA/1OVyi1Qy7RA5bC5xxCgHHlpphPJd1M2aQv
	 qzCB1xtjCSFt7khGKWdgOPeRZ/UcRua+r2NrHLjXJMbpTM3/mr7orL0Ew+Nwy2X3HZ
	 qkZ6RfziVhAwL+d2R6NfdscIjjOUJX94vlu3CE0dca0NWEX6Rg/CCaD0EJPH75Pzc/
	 EW4dS56FPBrkFf6ZuwmmaN22v9E1jrLepJaAfK6eIAruUACWoM/Nys8fKYl/0lg+K0
	 E3GuTy30Q2dc5407Oh3E6YskVLAjXuY0sLvUtGAAMUdOkbzSBvpbw9UP0Tri/N4hlM
	 8a7jihM68dZjQ==
Date: Fri, 29 Aug 2025 08:45:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Hauke Mehrtens
 <hauke@hauke-m.de>, Russell King <linux@armlinux.org.uk>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Andreas Schirm
 <andreas.schirm@siemens.com>, Lukas Stockmann
 <lukas.stockmann@siemens.com>, Alexander Sverdlin
 <alexander.sverdlin@siemens.com>, Peter Christen
 <peter.christen@siemens.com>, Avinash Jayaraman <ajayaraman@maxlinear.com>,
 Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>, Juraj
 Povazanec <jpovazanec@maxlinear.com>, "Fanni (Fang-Yi) Chan"
 <fchan@maxlinear.com>, "Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
 "Livia M. Rosu" <lrosu@maxlinear.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v3 0/6] net: dsa: lantiq_gswip: prepare for supporting
 MaxLinear GSW1xx
Message-ID: <20250829084503.35f792c1@kernel.org>
In-Reply-To: <aLGlMJcEe7ZAfPFy@pidgin.makrotopia.org>
References: <cover.1756472076.git.daniel@makrotopia.org>
	<aLGlMJcEe7ZAfPFy@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 14:03:44 +0100 Daniel Golle wrote:
> The whole series is intended for net-next, I messed up putting that into
> the subject line. Let me know if I should resend another time for that or
> if it is fine to go into net-next like that.

It's alright, FWIW. If all the changes are under drivers/net/ the CI
will default to net-next.

