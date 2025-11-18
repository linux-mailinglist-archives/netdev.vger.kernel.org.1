Return-Path: <netdev+bounces-239473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC2FC68A68
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 136684F0212
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DEB31576D;
	Tue, 18 Nov 2025 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="roxuahNO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6818B1F4CA9;
	Tue, 18 Nov 2025 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459272; cv=none; b=lI1JsUjkwV5+RqE5hlQcsVkX4/jaO3e1yz43ikDRnQVSC1xNeIh+3x/Pz7OO6JD9uGqr7H8wr8a2F3kRp9AputTgJzbj0xCMp6Hr2O/FCJal+7QRLNDm03EH1cVk6biF7hUrjyB//zeWt/vxGGek+12G5R+udIcUzKavbGhspg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459272; c=relaxed/simple;
	bh=kdgwGMiOC8sm5Le6Ok04eKoVkyOLedW8LEL+1rAmyDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tEZz5+YvSWXIa/BO7CR0X0ov+UrXzzcB80P4xzPdZ0CZoAlsfylCbSCcjOTQyNJnzZipYR/olTQvV2DPOVdpc4wqZFiTQAYP5ve48gCA8GtXwXqty0XHo0VfdMSVX7RGLBCWHUlm87qqtaSJuxKTJjhDsjB1+vgugdUCuJx6Hbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=roxuahNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 749F8C4CEF1;
	Tue, 18 Nov 2025 09:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763459270;
	bh=kdgwGMiOC8sm5Le6Ok04eKoVkyOLedW8LEL+1rAmyDQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=roxuahNOkuTeoGOqvnjTERB5rPxmuaqw+4aozITgesL0S45ZK8nokA0B0N0guW8zR
	 OWkTxB6WqQCTm6hmP4ceGSqGJyFZj0VnM+9nqfckkfxjZSI3JjenhBQth3jXzftWuW
	 fct9CyTCs4odaarG9luXXPzeouIj9JyqYHpJZgMJnL/JKWUXvd8TdrQ/5wIOwBEUKi
	 KK7FNgX0NR81bB6FgWtr8CfFj8T6pgabD7F4jdIgHaMRY4+mPk03ErkuaF9QQ0idZZ
	 6rb1Zw6xgtCbEySucNEaXiWTPCEz20Gi77QlRuz0C8oKjfNBHmjNLgJVCsK4GxqM/d
	 425PumFnV0Uqg==
Date: Tue, 18 Nov 2025 09:47:44 +0000
From: Simon Horman <horms@kernel.org>
To: Anshumali Gaur <agaur@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>, hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [net-next PATCH] octeontx2-af: Skip TM tree print for disabled
 SQs
Message-ID: <aRxAwLySBXIwKyrh@horms.kernel.org>
References: <20251118054235.1599714-1-agaur@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118054235.1599714-1-agaur@marvell.com>

On Tue, Nov 18, 2025 at 11:12:34AM +0530, Anshumali Gaur wrote:
> Currently, the TM tree is printing all SQ topology including those
> which are not enabled, this results in redundant output for SQs
> which are not active. This patch adds a check in print_tm_tree()
> to skip printing the TM tree hierarchy if the SQ is not enabled.
> 
> Signed-off-by: Anshumali Gaur <agaur@marvell.com>

Thanks Anshumali,

As per my feedback on the 'net' variant of this patch,
this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


