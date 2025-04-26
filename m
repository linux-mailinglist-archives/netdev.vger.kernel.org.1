Return-Path: <netdev+bounces-186211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB5EA9D723
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 04:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DDE4A42A8
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 02:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7114E1E0E01;
	Sat, 26 Apr 2025 02:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nf8gdMuy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485623C0C;
	Sat, 26 Apr 2025 02:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745633061; cv=none; b=dslJRpMUa46A5rZ5nJ187jelCOSlmoeJZ7kxTRaQzZqElxADZFs6pjlTieXpMeQaP0aigHl+HUGNAAe7x9TlIgF/94KjoyMwT3E8cA+33XEk+MXyev/8Rd0FXMO4kvHcnKC9ieYCXWQIFcsqP4NmWsBmmsiDm9Sae1ES//G91EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745633061; c=relaxed/simple;
	bh=YBjGs75TGQoZrkN95ihq97NwqfZ/Jj7+bTvUZ5KWgEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLEOxTTAuI9B+dB4iT7FOBV50atcz66LOznUGPTb/puLqIltV4CSBOY4QnGSQFgIjEwlznFZuUvXFrOMYZGE1s4N2aPa0yMIrAhRsxluppmdj0Ok1BsVwldg7WBP9tT0vbK0QQr2MXRKwwi+LN68A+KvNeADR/Un70zBvB1+L0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nf8gdMuy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5731CC4CEE4;
	Sat, 26 Apr 2025 02:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745633060;
	bh=YBjGs75TGQoZrkN95ihq97NwqfZ/Jj7+bTvUZ5KWgEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nf8gdMuyryTogJAdnxFXaOwXRzS8ToMPO+8+uINeXpCHvCJHaMKeg7uzVSnErVuIw
	 yL1k3jTbPqUVOs2Y71FNdL4UBJmeU617wuuzCdsFt6CJAdzLSV7nXFMhfldIW3wxHl
	 VOubRmwsixw0QPirPJGUjSCHsKk/ePJFj6fi6jr0Do+if6GPUqtssaAxWMdFaSP6Qx
	 pdpesPOmoJ2kNN/NVQurngCd7koM8FPvfG+kFSrdM3D6H7/hYzPlHyY69WzM5fPEAf
	 zeg3VQ1VVvm6Rc8ePL8Dviuk1eomrol6yUZDANa7PCwdB3oxlTiFjJTTy+B8Loki3w
	 EGgPAxrt5uFiA==
Date: Fri, 25 Apr 2025 19:04:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jay Vosburgh <jv@jvosburgh.net>
Cc: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>, Cosmin
 Ratiu <cratiu@nvidia.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 net] bonding: assign random address if device address
 is same as bond
Message-ID: <20250425190419.273eb34b@kernel.org>
In-Reply-To: <587559.1745538292@famine>
References: <20250424042238.618289-1-liuhangbin@gmail.com>
	<587559.1745538292@famine>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 16:44:52 -0700 Jay Vosburgh wrote:
> 	The code flow is a little clunky in the "if (situation one) else
> if (situation two) else goto skip_mac_set" bit, but I don't really have
> a better suggestion that isn't clunky in some other way.
> 
> 	This implementation does keep the already complicated failover
> logic from becoming more complicated for this corner case.

Any thoughts on whether we should route this as a fix or as a -next
improvement? The commit under Fixes is almost old enough to drink.

