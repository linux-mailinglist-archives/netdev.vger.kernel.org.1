Return-Path: <netdev+bounces-119939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DF3957A7B
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 02:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F474282C61
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 00:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F90B4C70;
	Tue, 20 Aug 2024 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="suw7CWiV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D917D632;
	Tue, 20 Aug 2024 00:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724113689; cv=none; b=nUKadB/Ccup+PnsTDy3nnXVoHXlG4iZ6Xx1IGu57uqL1gS4bY8BP60ZKDC6uq8VL32K7O4LHv3UHG09TYznLaoXUHlrUBR2DzR+lwxLpJCVtyV1sy76Fr3yfA6PVnqWEiC74aCOUHK84pWhFzeVew+cEuTl8k+UwxlcRPKuzzvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724113689; c=relaxed/simple;
	bh=G5+CYuGadeOqrV42yNWtUSmgIjP5+5Gt3UD2+AKu4qs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdSJdWCUYhuqXPGaaQK2YPKosK5RP+8i3c2Lg2aUchDpYIYQRrJ50K7HqrH8hh+mJqFbcJAZaBmTFt185gzWfX7ePh7Fg2xKDTy4HUY9y8NDqxaSimzTm2yhLwE+iY24PtGUyKp7aaKJCyXu9y1S1Uo44cwiYxquEW1fDCUyLkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=suw7CWiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312E6C32782;
	Tue, 20 Aug 2024 00:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724113688;
	bh=G5+CYuGadeOqrV42yNWtUSmgIjP5+5Gt3UD2+AKu4qs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=suw7CWiVzJGp+AzjyjXggeq55hK9An0Do8q2CSuk/bw/zHGeAu0tJR26I70xAztjV
	 PEaqT3qs76GjkJYMUjKGDNi649N64prQlU6sJgce75FnXcBC9zZOEqRvGhGC4NXggZ
	 dbhUiD3aME/wZjJItDNr+EQMHlm0D341kAwO4F+pBODKeyuAsWW2XyNzNjBXr7fWxt
	 RV+YIzzmedPo4z2STSbiX43a6seAsSOY329rqTBA+PfvRkCe2huGQDCK4HsET2xFtM
	 RaOnUekbZijqiFEXerD+0vvjOVZPxD6tR2Y06QjU7vD+S9sKGVpiwvByn+WttSG1zi
	 xu+zDwDvPdBYg==
Date: Mon, 19 Aug 2024 17:28:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <jerinj@marvell.com>, <lcherian@marvell.com>,
 <ndabilpuram@marvell.com>
Subject: Re: [net PATCH v2] octeontx2-af: Fix CPT AF register offset
 calculation
Message-ID: <20240819172806.6bf3bd63@kernel.org>
In-Reply-To: <20240819123237.490603-1-bbhushan2@marvell.com>
References: <20240819123237.490603-1-bbhushan2@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Aug 2024 18:02:37 +0530 Bharat Bhushan wrote:
> Some CPT AF registers are per LF and others are global.
> Translation of PF/VF local LF slot number to actual LF slot
> number is required only for accessing perf LF registers.
> CPT AF global registers access do not require any LF
> slot number.

You need to add examples of features which are broken without this fix
into the commit message.
-- 
pw-bot: cr

