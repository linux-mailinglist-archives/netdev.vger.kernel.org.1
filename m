Return-Path: <netdev+bounces-145468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B1C9CF949
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 23:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 612FB2812CD
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 22:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C97DC1F757B;
	Fri, 15 Nov 2024 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B58c+O0Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994701D5AC0;
	Fri, 15 Nov 2024 21:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707460; cv=none; b=MRkiwzWeuEDTRJH7XQtlCqH55mXdpepQ+/iTBVKJBzhVM8xmtP8uLWi+pQCjVqisCF9YFNESpCzDmYRdH7MnklDp5JIw29cr9iMYAksW8jqpwCn3AcTJhg172PeST+uAZzu1rgoLoCC6C3WBitLjbGfTF5up65cighYuCuQI4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707460; c=relaxed/simple;
	bh=CoWsFVfyoNDdP+sDuo4UK0OuVO6qk8o69BlkEOSeKdY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ucdos74pXRFQMsHssNetb2ucal72M75BEF3TYAZpqAGUkTWDl4cq16F/e5lQPmZFQYWVE7hLmJ+/nD/W9XYefm4MJaWtehi97wUQif03wLEs/u3rQE8No7brJxSF9itGTlrEMtsCybmBXIAR9hnSYqdcmJ9796zUVKLMtTr1feY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B58c+O0Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A78CC4CECF;
	Fri, 15 Nov 2024 21:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731707460;
	bh=CoWsFVfyoNDdP+sDuo4UK0OuVO6qk8o69BlkEOSeKdY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B58c+O0YLZsaGUKS158WzIcWRpmUSdS+o0ksy5dTGxUyhuSJ6aGtl/Kgo5DzLGXiZ
	 N9H3ht8Mayfu4tBRNA14YpSdTgv/ay1CKQ8Xzwa7uvivm4D+NzDTP1lDNQGZgV+lli
	 fA4Ax7FE7iNC3m6FzqQ4SXOA/SMpIrGPTrc8vYf4WrFxXEnDtZYSBsIH5zl8L3wRjZ
	 Ss0gXHXa+MmgNej0Kg9VgATTaAYAIXilgzIG+TqLLzwb+bhepNdfHDms5hHN6iwT2B
	 voe7HfNUxPAxha9zNEmop8rK9oIWYr6WUEMoUOafG4S+x8HAqxdgosXHzKhSimUbXu
	 65Z37oJfBUONA==
Date: Fri, 15 Nov 2024 13:50:58 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>, "Kory Maincent (Dent
 Project)" <kory.maincent@bootlin.com>, Michael Chan
 <michael.chan@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Potnuri
 Bharat Teja <bharat@chelsio.com>, Christian Benvenuti <benve@cisco.com>,
 Satish Kharat <satishkh@cisco.com>, Manish Chopra <manishc@marvell.com>,
 Simon Horman <horms@kernel.org>, Edward Cree <ecree.xilinx@gmail.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Ahmed Zaki <ahmed.zaki@intel.com>, Rahul Rameshbabu
 <rrameshbabu@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Takeru Hayasaka
 <hayatake396@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH 3/3] UAPI: ethtool: Avoid flex-array in struct
 ethtool_link_settings
Message-ID: <20241115135058.01065c04@kernel.org>
In-Reply-To: <20241115204308.3821419-3-kees@kernel.org>
References: <20241115204115.work.686-kees@kernel.org>
	<20241115204308.3821419-3-kees@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 12:43:05 -0800 Kees Cook wrote:
> struct ethtool_link_settings tends to be used as a header for other
> structures that have trailing bytes[1], but has a trailing flexible array
> itself. Using this overlapped with other structures leads to ambiguous
> object sizing in the compiler, so we want to avoid such situations (which
> have caused real bugs in the past). Detecting this can be done with
> -Wflex-array-member-not-at-end, which will need to be enabled globally.
> 
> Using a tagged struct_group() to create a new ethtool_link_settings_hdr
> structure isn't possible as it seems we cannot use the tagged variant of
> struct_group() due to syntax issues from C++'s perspective (even within
> "extern C")[2]. Instead, we can just leave the offending member defined
> in UAPI and remove it from the kernel's view of the structure, as Linux
> doesn't actually use this member at all. There is also no change in
> size since it was already a flexible array that didn't contribute to
> size returned by any use of sizeof().

Perfect. I was starting to doubt if user space needs the member,
ethtool CLI doesn't but looks like NetworkManager does. 
So as you say we'll cross that bridge...

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

Thanks!

