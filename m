Return-Path: <netdev+bounces-230260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 3286ABE5D51
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 01:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C22E54E335A
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 23:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA87D2E6CD6;
	Thu, 16 Oct 2025 23:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oW8xCsIv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDAF2405E8;
	Thu, 16 Oct 2025 23:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760659010; cv=none; b=TCXXZPbTBFh/z7j7scaHGsC6vK0aAK4kOl0zU6zsAfszxUJvuBWKOzRobrkS+1M56E0A0tBk9Vq0yoYvWqQmb4Ykf8d8GX97mglUSrjKlrvw8ULwWANmVSZWEskGmUv3RUJolW4biBCgzVETNcwi7u8Mc6dnJnCWwuhHwbLRtlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760659010; c=relaxed/simple;
	bh=3kntJsodGoesQXD3hEICZYjE4tiqmt6YN9DYV7C3aYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OGXixcfZpgnNcAiKgBQze42CWwVkaTrYpUgmtdaojdbgM0eKumds84tMarQZS4lRHzVoWmxHzA7JIjgiQLZwSbF2v2Z62SqnCKWUTBvzInWOj0T/L8LUTFEY2FLDIuu4jJV9JgPYmsmni+IeVGu/NpgWdQ9Ec+jhJDbdizVa1I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oW8xCsIv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A18AC4CEF1;
	Thu, 16 Oct 2025 23:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760659010;
	bh=3kntJsodGoesQXD3hEICZYjE4tiqmt6YN9DYV7C3aYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oW8xCsIvW40e2O3RLk06mYWw2kPwQ2hrgE+2PvNHKqWTTQzyJr4Wf/vvNcXsxF/kb
	 46JPR1aVBEPn/JlD2caRC4+WSObi1cHZVAyWJNcmqSzE60zL8orZU3zoeEsJ8L/TNk
	 s9b/1M4+PnILg+haYyZU8i3jNsG4wBAVmq16yz/uRoah6KJ9olZHhZ9wnbl3HJxEqC
	 50KfblW6w6uqXJGcof01wwYnatUWsUNk+NtRGwo32xD/5Fm7EA6HCceU6NVs/Q/pPf
	 xKXHrF9PxbB2TQ6zxP8mIm7vfMMOX2NbB9JH4D5SpzM17oVl0J2da3yUycWlQMigSY
	 y4E3/P83yA7sg==
Date: Thu, 16 Oct 2025 16:56:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Alexander Lobakin <aleksander.lobakin@intel.com>, <netdev@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Nowlin
 <dan.nowlin@intel.com>, Qi Zhang <qi.z.zhang@intel.com>, Jie Wang
 <jie1x.wang@intel.com>, Junfeng Guo <junfeng.guo@intel.com>, "Jedrzej
 Jagielski" <jedrzej.jagielski@intel.com>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Rafal Romanowski
 <rafal.romanowski@intel.com>
Subject: Re: [PATCH net-next 06/14] ice: Extend PTYPE bitmap coverage for
 GTP encapsulated flows
Message-ID: <20251016165648.2f53e1fc@kernel.org>
In-Reply-To: <902dab41-51f0-4e01-8149-921fb80db23d@intel.com>
References: <20251015-jk-iwl-next-2025-10-15-v1-0-79c70b9ddab8@intel.com>
	<20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com>
	<aPDjUeXzS1lA2owf@horms.kernel.org>
	<64d3e25a-c9d6-4a43-84dd-cffe60ac9848@intel.com>
	<aPFBazc43ZYNvrz7@horms.kernel.org>
	<902dab41-51f0-4e01-8149-921fb80db23d@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Oct 2025 14:37:53 -0700 Jacob Keller wrote:
> What version of git are you using? I'm using git v2.51.0 Perhaps this
> isn't a b4 or git issue but some other tooling that is causing an issue
> (patchwork?).

Looks like patchwork, it serves us:
https://patchwork.kernel.org/project/netdevbpf/patch/20251015-jk-iwl-next-2025-10-15-v1-6-79c70b9ddab8@intel.com/mbox
which has the -- "corrected" to ---

Doesn't matter all that much cause there are also kdoc issues on
patches 4 and 5. Obligatory advertisement:
https://github.com/linux-netdev/nipa?tab=readme-ov-file#running-locally
-- 
pw-bot: cr

