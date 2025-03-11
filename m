Return-Path: <netdev+bounces-174037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D78AA5D1C0
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 22:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F27517A4D7
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C62227E9E;
	Tue, 11 Mar 2025 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pc8Cb1Sa"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395123DE;
	Tue, 11 Mar 2025 21:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741728739; cv=none; b=GQu6OAUR2Hvl4JntiCs/mLcOul7L/AzKL04cxdWO6qqb8hRuidrG4vgiGMvbfs5lCQDy9sXdrHVplpz7HdAKuh8+hzmPfQ0B8SGulBfWZj6Vvjm796wAY3jZvxoZPUO9EHDMv5wM7amKJQJy6vmzKREHh2xVF7udKsP9rSCXeWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741728739; c=relaxed/simple;
	bh=CGysvkbyat2v9Xt5IUN+jtxJSR/j0sVWvbITzTxLaqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9s6KpRP3NDwICHRDHwTAw3Aq3FK4knh2Q94P0T8Dc7TSHchc1djY16m+DmyvgqTezD3tXY5JqhbxUvByEF3dZNoEN3umxK9CujCToWZ5JJrUrquxANHCj9wmwFnkt1IInI7RgKmNtvU7yj2vO1Cz6q5buIM1DF2wlfhAbcgZH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pc8Cb1Sa; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=fBIv4qkUgiRYJGk6D64lsbFp1htOYMf0DoD3udKRKRQ=; b=pc8Cb1SanRw/DIOqyL1dmo9HBX
	CJMarEMBHV5yOscodm9n0guO3IijKTZ7TZu3Z9QPOObQxToMuVUlOlSJzP2ZvdOp+hIhazx2zM/AI
	kPCuD3w4E4TIaR8K6YdV0Qkrz+dbe+mV4wZHlrZ29s4HrMboxzJMyf4SkGS3tvn7Bf6c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ts7Cu-004Ss8-Ai; Tue, 11 Mar 2025 22:32:12 +0100
Date: Tue, 11 Mar 2025 22:32:12 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sai Krishna <saikrishnag@marvell.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, lcherian@marvell.com, jerinj@marvell.com,
	hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
	bbhushan2@marvell.com, nathan@kernel.org, ndesaulniers@google.com,
	morbo@google.com, justinstitt@google.com, llvm@lists.linux.dev,
	horms@kernel.org
Subject: Re: [net-next PATCH v3 2/2] octeontx2-af: fix compiler warnings
 flagged by Sparse
Message-ID: <3bc07f4f-73b4-4d34-98cb-79e84d9f1493@lunn.ch>
References: <20250311182631.3224812-1-saikrishnag@marvell.com>
 <20250311182631.3224812-3-saikrishnag@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311182631.3224812-3-saikrishnag@marvell.com>

On Tue, Mar 11, 2025 at 11:56:31PM +0530, Sai Krishna wrote:
> Sparse flagged a number of warnings while typecasting iomem
> type to required data type.
 
> For example, fwdata is just a shared memory data structure used
> between firmware and kernel, thus remapping and typecasting
> to required data type may not cause issue.

This is generally wrong. __iomem is there for a reason. If you are
removing it, it suggests what you do next with the pointer is wrong.

    Andrew

---
pw-bot: cr

