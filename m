Return-Path: <netdev+bounces-164970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8239FA2FF13
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 01:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490F23A624B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBAE7080C;
	Tue, 11 Feb 2025 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G22b7Vr9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352A13EA98;
	Tue, 11 Feb 2025 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739233647; cv=none; b=gM0megTls8rOZQ/ifGG78xr27bkWvPJDvMh7BrKEAGsiNiOVma19HPLrsjX1yF2DKI9JvBtP1e8K2A6Wt33YoyqMNlrkMddPosi+LmZ6jehcvDOuRGxsDf6s3GZhuHKoaBiVi34fTbhVT2WiEiRs/z+TjWHak/GPKjE1JK8Ug5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739233647; c=relaxed/simple;
	bh=WaSiRtR9tVkO5k1OdaRvVKphqY1LusolyGVDDUSoTvg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ezG9RvIUIc1Mc4wGMMK6zG/0O+Ctx4UVMNkIphOAQaETlfzJzui1Av8OThsWLY/EbuotkIBoLf9NV5FJ33IdwrJRc4/LBv1eMAeCWNshrWFcqJtMpE0jSyhiSfIVE0zB9Ae81L8Iu/7hHaUqrJ+MIyw9dzPk9tKlAKxeR1MDeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G22b7Vr9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399ADC4CED1;
	Tue, 11 Feb 2025 00:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739233646;
	bh=WaSiRtR9tVkO5k1OdaRvVKphqY1LusolyGVDDUSoTvg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G22b7Vr938vw+ByXWDcb8DxXVdU6bEsIoiWNlRQmApIxn3v8HD/th4YelaSXTh/PH
	 0llQ38MfAcvluRxxw21B2EDOJ7JH4nEyxwRYMlDMk3iwgEA3sQASkFf7VCtxoZO1lI
	 u1ixE1RpaiUV5J0RrVpf25EhOxHEb/T/RHT9q+o1bILvmnmKAfPPvGR2RdFRejpIAp
	 Wqlo/WNXTho4dliIbrWtmyp0kViLAhha/HhQjv4lmYQWjzPXxEDUxm2239UAlazVfo
	 ztPih7Js0+SlJoD4e8iNTZpTZqpRdNeutvQSThmizeW0xUPvYmQzJz37rzsQvjXsby
	 yF95hP9SjV3Yw==
Date: Mon, 10 Feb 2025 16:27:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gal Pressman <gal@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Tariq
 Toukan <tariqt@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Ahmed
 Zaki <ahmed.zaki@intel.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/2] Symmetric OR-XOR RSS hash
Message-ID: <20250210162725.4bd38438@kernel.org>
In-Reply-To: <191d5c1c-7a86-4309-9e74-0bc275c01e45@nvidia.com>
References: <20250205135341.542720-1-gal@nvidia.com>
	<20250206173225.294954e2@kernel.org>
	<191d5c1c-7a86-4309-9e74-0bc275c01e45@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Feb 2025 09:59:22 +0200 Gal Pressman wrote:
> I don't understand the rationale, the new input_xfrm field didn't
> deserve a selftest, why does a new value to the field does?

Ahmed and Sudheer added ETHTOOL_MSG_RSS_GET as part of their work.
Everyone pays off a little bit of technical debt to get their
feature in.

I don't appreciate your reaction. Please stop acting as if nVidia was 
a victim of some grand conspiracy within netdev.

> Testing this would require new userspace ethtool (which has not been
> submitted yet), I don't think it's wise to implement a test before the
> user interface/output is merged.

No it doesn't. You can call netlink directly from Python or C.

> I assume you want an additional case in rss_ctx.py?

No, separate test.

