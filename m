Return-Path: <netdev+bounces-224447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75112B85399
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 16:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681945606F3
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7EE30DEDC;
	Thu, 18 Sep 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nh4V5JMN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264761A5BBC;
	Thu, 18 Sep 2025 14:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758205016; cv=none; b=G9llSzrvg5NaiTFqNBzNoKAb0ibrfk60epYhcpgtvNO8beOPgKoEnn1Xj7g2xAFoY+saHwDS+HtG43aSTpl40EllbPpmE3vM3vjJd5PEYRxvduZZc8YuFuEUzMMjNkbQMoc8qMyhhFV8haFWDxCZP6ufRL1S8iIf3u8Ga2E8YKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758205016; c=relaxed/simple;
	bh=ibqbfZgyeCJx3k7W06hF16lDQ4EFWqzf9v4DWdCP1EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZ+FaVubI6+TuAiJVXkcMMYPGLtHA9OldPplODA8aWxcPb0Z6HTXgzFqZ/SN+yYHUlZ4wYBuyN+GGfaLu9Q80WhGMGSoxza/LZkygbqBaMtbeUmck55Q8P4u/cs0Y/oq1t/kWU0F47PfpTjzGChoDVijhxL1F4v1nawDkX5KRUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nh4V5JMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A46AC4CEE7;
	Thu, 18 Sep 2025 14:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758205015;
	bh=ibqbfZgyeCJx3k7W06hF16lDQ4EFWqzf9v4DWdCP1EE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Nh4V5JMNbwfe/kaLoKIKZtj/jq0KnwZ+7XbAWV4jo0dJ2I2hUmil/YzkHU04nUuYM
	 LoPLiOQy13L0THxFrsO/1zIuMlzEYfGnUZp0FCQaGqqrZZDHpQzsRkUkRs0fXqvXhc
	 aSXc+JUjdsaqxrosbEcgq+x+dR0m5Jce+zcI8CUGHgpPYNALtLdVWjwuD48pjq6Yro
	 gbM8lEX5FIf+jYF8KMfkHS48FrtHpJanlAahr2SS5WFv0jsVP668FLmYfiedbEX/Yh
	 DYkaiN+DDPxvtkBhnnFY2VApTtm/dP3IYgjOR4lejSoaV9ta8FLDj/yZGgoCkZfFct
	 atpIG0f7r3r8w==
Date: Thu, 18 Sep 2025 07:16:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sathesh B Edara <sedara@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
 <vburru@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <netdev@vger.kernel.org>, <hgani@marvell.com>,
 <andrew@lunn.ch>, <srasheed@marvell.com>
Subject: Re: [net PATCH v1 0/2] Add support to retrieve hardware channel
 information
Message-ID: <20250918071654.4bdb0067@kernel.org>
In-Reply-To: <20250918112653.29253-1-sedara@marvell.com>
References: <20250918112653.29253-1-sedara@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Sep 2025 04:26:50 -0700 Sathesh B Edara wrote:
> This patch series introduces support for retrieving hardware channel
> configuration through the ethtool interface for both PF and VF.

"net" in the subject means its a fix. This looks like "net-next"
material. Please repost tomorrow and make sure to read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr

