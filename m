Return-Path: <netdev+bounces-142599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB24E9BFBF7
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA6B1C21E75
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 01:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4023CDDA9;
	Thu,  7 Nov 2024 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4raZxnE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1653A944E;
	Thu,  7 Nov 2024 01:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730944204; cv=none; b=uocSgoBvAVLSQ74pL2sAKyAU7SB2P5vvJP97SD8d/pvBcYmsDg9WWZ93qhsOtkZcOxrHJSjT6UA+glai9QMUkl1H1tPt0T3sfCG6wYZKfkMin7XTHzHEJ64Vvlhw3VMvKwvYaoBieOqsYIR2n0eg2TtbwbQJlHowDaWfmGbLdWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730944204; c=relaxed/simple;
	bh=QSwt5uUFgAbRzqEDwn8TXLPB0Z8tR3DMwNyYV/ETIN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DrLsriksHHkRcxk4U9SAzjfd9yLpLx1k8WoMytxNKug7fHpSFd+tzwB2UnQQNiM2/uE4/VMKtsw2eqkFGYw+ktFMpAK6Vmzyuu0HrIEw93r252MJPmEKYVQqdBFfm+2MJqYBc3b9Cksv5T/1g3WmLZzH3+fcLELM3OSaZmy/r/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4raZxnE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C47FC4CEC6;
	Thu,  7 Nov 2024 01:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730944203;
	bh=QSwt5uUFgAbRzqEDwn8TXLPB0Z8tR3DMwNyYV/ETIN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U4raZxnEJM9rOL7st/nhjnHjR4husliaC20owHDqSSZWISiaFC819Jq5GGeAbVnie
	 rzPYi5frRhlSMHDdZlg5mMDLdgILPuR6c6+NeFc7yKNk53NTPWa9QtjWJczlUyDusW
	 FdwhhNsuYwI9Tfgtn3n9LoCy5OG0M7udMpNw3H6sxzIDZ6KFCsZ/Ch/1OFkL9EtrUX
	 W+XCtMzTAaDDiWpU/qEmNLmMc5gg6w8diLjcWqenoQtebe3pMn7a1pE1HfSAFSBwpL
	 d1l4vFlVVMnXuV1tvTiew+Bxnysm01fK3Raz6X4rAJPf20ggs58ycvbeP7eVQ0LAtc
	 +IpwrZOhx+UBQ==
Date: Wed, 6 Nov 2024 17:50:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: andrew@lunn.ch
Cc: Andy Yan <andyshrk@163.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.wu@rock-chips.com, Johan Jonker
 <jbx6244@gmail.com>, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH v2 2/2] net: arc: rockchip: fix emac mdio node support
Message-ID: <20241106175002.645e2421@kernel.org>
In-Reply-To: <20241104130147.440125-3-andyshrk@163.com>
References: <20241104130147.440125-1-andyshrk@163.com>
	<20241104130147.440125-3-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  4 Nov 2024 21:01:39 +0800 Andy Yan wrote:
> From: Johan Jonker <jbx6244@gmail.com>
> 
> The binding emac_rockchip.txt is converted to YAML.
> Changed against the original binding is an added MDIO subnode.
> This make the driver failed to find the PHY, and given the 'mdio
> has invalid PHY address' it is probably looking in the wrong node.
> Fix emac_mdio.c so that it can handle both old and new
> device trees.

Andrew, looks good?

