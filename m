Return-Path: <netdev+bounces-172648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49664A559D9
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 826C5177D0B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F34A27C877;
	Thu,  6 Mar 2025 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEzHs+Vr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B5927C853;
	Thu,  6 Mar 2025 22:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741300469; cv=none; b=Wbz8D6QMEhfDv57HTI813dO+o4cn44Nbbg8qo/qOem2/9qCWVMiI2Ix+rfc2CWZqV84BOh//i6zhQsOQBAXWRcPEGKG++CsmQcVLDdNI3rW2ixRnw9Bmfz2LhcxYp9rX3v6UI6Kv+QeLnyb+JwNXY0dhAdRQBs6Q4xYLe6BxIhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741300469; c=relaxed/simple;
	bh=jnmEI0O48dE/8nutBn2HVLhExmXei9Y4n/ey1QBf6Q4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCegR9vcwC7bMg59mesM2FcskUESFz5Q8pdH7oAka3NuBo0wNBzwj9b0n5rB/DeP1/rVLe3ME+Ul1swToVGbZpIPIDQh049n7YxuZoJh5V0C84Pff5F8Uvr7k2qBqCJuyuVq5VQCxMiS8WwqyXf7v7/KQq//vE0TrLQlam9Zmnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEzHs+Vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47383C4CEE0;
	Thu,  6 Mar 2025 22:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741300468;
	bh=jnmEI0O48dE/8nutBn2HVLhExmXei9Y4n/ey1QBf6Q4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pEzHs+VrlHLMd6zr1qi15LpNpPfR1LabvhCacarSCskvDHYep7dWk3zsDEMunufkk
	 lC/TV9815LsESFjZhqaQfBqnK+8KGbWmLDZqL7o6o7NUqwcE+g4uoX163PY+O9ECkM
	 sg8/P832YOFgKaN0v9ynHgTO42xYgjDEiL7UnbTTpImtLts114YI5AZDk47h0ebGgd
	 2+eZfUNhELiIsxjp5Qbjm2pg0cHcWt6AFs6hZbRskG+4LJPXpZ1HOBwJv/lahbIC/0
	 EVq4FOQjmnV65GO93QN3IeWVN0KjvLkNO+KVOTHb6b6G4E4sXJm9izqq8wXiNwHLfn
	 5aoBXxnE38T5A==
Date: Thu, 6 Mar 2025 14:34:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 net-next 06/13] net: enetc: add RSS support for
 i.MX95 ENETC PF
Message-ID: <20250306143427.2bf83572@kernel.org>
In-Reply-To: <20250304072201.1332603-7-wei.fang@nxp.com>
References: <20250304072201.1332603-1-wei.fang@nxp.com>
	<20250304072201.1332603-7-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Mar 2025 15:21:54 +0800 Wei Fang wrote:
> Add Receive side scaling (RSS) support for i.MX95 ENETC PF to improve
> the network performance and balance the CPU loading. The main changes
> are as follows.
> 
> 1. Since i.MX95 ENETC (v4) use NTMP 2.0 to manage the RSS table, which
> is different from LS1028A ENETC (v1). In order to reuse some functions
> related to the RSS table, so add .get_rss_table() and .set_rss_table()
> hooks to enetc_si_ops.
> 
> 2. Since the offset of the RSS key registers of i.MX95 ENETC is also
> different from that of LS1028A, so add enetc_get_rss_key_base() to get
> the base offset for the different chips, so that enetc_set_rss_key()
> and enetc_get_rss_key() can be reused for this trivial.

Please split this patch into refactoring of existing code and new
additions.

