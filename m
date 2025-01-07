Return-Path: <netdev+bounces-156075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD62A04DCD
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 00:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B655A16656A
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 23:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B6A1F7589;
	Tue,  7 Jan 2025 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxkOshFX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E43137C2A;
	Tue,  7 Jan 2025 23:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736293609; cv=none; b=ju/1EL2ZOrWP5GY6Ib/s7X6gghYCO8jDytY+/hAAQ7cx6r9q4J9uHFdvY8tdcZ6IUV4aIbaaMgXDcKKCqe9Bmr7aXfllXnvXuItKyzk+SD9nZuaKDKTbraEOMy84jmGNcl0LfbZMXdRTCuf/sgZ15zpavnO9uIBn26Cft/LknB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736293609; c=relaxed/simple;
	bh=H5DXgrW8O299sPdFh2ct/MgtvT8tV+YMvP+HGRyOTis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jDDp8ZD3NXu+H4kBG6S3+p4uWu+WaHaiM19WWfGuDxq37wY/NfZVqCmACKlfkL3Vah91ya/DZj2ODCphc+mRNL7VLnrNeE+Sqrb4wqvG1/HvPMc5dNh63zpFulZREd+EnzvHgrAS3VMjJMgNgcy87AudgKu+AmZUEeqaj9pNlOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxkOshFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C62C4CED6;
	Tue,  7 Jan 2025 23:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736293608;
	bh=H5DXgrW8O299sPdFh2ct/MgtvT8tV+YMvP+HGRyOTis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jxkOshFXr1SFSaawUSmvHiuSVaPH9dq8W4H/cDclg5oZjcHYJbmVUh/hS1KBXyvZP
	 GQ+lSAVlEdeXhkRS6414oj9w1PAyuL4u4I61GFBjcfSPiPcxiaxfPYhyWU5ockysAX
	 q/qJObXvEhERAuZcRzUucyKE5eNwB4Te06pHp3dyC8p5RnWwU8QpUddciCcb5sragJ
	 P+LQ3jVxwSpYBisF0M1WDhKG6MbYqKVbG4mGdN067ph+nG8sIEZX/COSDS2KxBAHFd
	 IabMfnd7Eq/96UxVxLrhX7r4uYoz6xUbyS5/2qapZ13X68wLp9PU7ZD82zIdog05vE
	 VVLpcUnV9/KeQ==
Date: Tue, 7 Jan 2025 15:46:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 ronak.doshi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/1] vmxnet3: Adjust maximum Rx ring buffer size
Message-ID: <20250107154647.4bcbae3c@kernel.org>
In-Reply-To: <2f127a6d-7fa2-5e99-093f-40ab81ece5b1@atomlin.com>
References: <20250105213036.288356-1-atomlin@atomlin.com>
	<20250106154741.23902c1a@kernel.org>
	<031eafb1-4fa6-4008-92c3-0f6ecec7ce63@broadcom.com>
	<20250106165732.3310033e@kernel.org>
	<2f127a6d-7fa2-5e99-093f-40ab81ece5b1@atomlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jan 2025 22:55:38 +0000 (GMT) Aaron Tomlin wrote:
> On Tue, 7 Jan 2025, Jakub Kicinski wrote:
> > True, although TBH I don't fully understand why this flag exists
> > in the first place. Is it just supposed to be catching programming
> > errors, or is it due to potential DoS implications of users triggering
> > large allocations?  
> 
> Jakub,
> 
> I suspect that introducing __GFP_NOWARN would mask the issue, no?
> I think the warning was useful. Otherwise it would be rather difficult to
> establish precisely why the Rx Data ring was disable. In this particular
> case, if I understand correctly, the intended size of the Rx Data ring was
> simply too large due to the size of the maximum supported Rx Data buffer.

This is a bit of a weird driver. But we should distinguish the default
ring size, which yes, should not be too large, and max ring size which
can be large but user setting a large size risks the fact the
allocations will fail and device will not open.

This driver seems to read the default size from the hypervisor, is that
the value that is too large in your case? Maybe we should min() it with
something reasonable? The max allowed to be set via ethtool can remain
high IMO

