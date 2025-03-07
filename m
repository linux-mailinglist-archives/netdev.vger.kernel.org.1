Return-Path: <netdev+bounces-173013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E424A56E35
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45BD83A6E43
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D4A239096;
	Fri,  7 Mar 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PX4G45vJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8025F21ADA3
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365815; cv=none; b=djAJk4HlEIlJGxvKuULexGKbqMGWk+GVPGmmB2hXbt0WBt2VjoKtreZHLEudFqXAu3zcyOyHY9RvssCO540YpvzZD1k7gVmjyeaUfOZUZcg9q9lEE13kdCaew6c5b5eMU87IcJcHzGzZ3RLOJAsjSpFcR2nSKvFIzVyANHd4mrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365815; c=relaxed/simple;
	bh=NWz49aV9CaD2GXHK253IUPiQvv2+vi6Y9CRmX8hM5sY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LOkB7BeAp37A8PsmcaeklsDuhqOkdIBbDiye/Vb3GBN7Fc1yjx2g6METaG2LzFhcBSaK3veuS6M8CdGQm3JQUzT4dwp7XP3WTVGiT3TJdHu5p0UTRk4tf67C9AqV7WgpKN1N2FzFhnZmNH3uvztvyLoRph/moB4UMIvsxGrYVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX4G45vJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F61AC4CED1;
	Fri,  7 Mar 2025 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741365815;
	bh=NWz49aV9CaD2GXHK253IUPiQvv2+vi6Y9CRmX8hM5sY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PX4G45vJGUd6TEnZBYBL7mIcvLctXO4QMpG6XW5n8U04z8kcmav8FNNFRc4SEe/K3
	 1g3l10l03KLhjT26c7QkRFrwvtoM/T2URRH+FAsqXktFBWSIzW3z0o/5/66/GiqECa
	 /0qypSOxUHXcXBxLTaiWfy699lzjbVMwJExFY1vzWmwzw5YLWhQ/7QsYfmIlwOi2U9
	 TyCBfQLNYYLHJ3HpBs68nxniW7cTVIGdyw2J5M835UjFi4udHt4knJ2VvtvydrU3WP
	 jsaoBURCEfCH8RexU6FsNABtpl1zkjiCvTvRTYzDTMZSsABcBYuiapUGdvfznKSmuR
	 lEys8jduduyxA==
Date: Fri, 7 Mar 2025 08:43:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: Michael Chan <michael.chan@broadcom.com>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, pavan.chebbi@broadcom.com,
 przemyslaw.kitszel@intel.com
Subject: Re: [PATCH net-next v3 00/10] eth: bnxt: maintain basic pkt/byte
 counters in SW
Message-ID: <20250307084333.26840bfd@kernel.org>
In-Reply-To: <CACKFLimQTjLwWyhw4ODD1VM2iW1eCeX1VqpU5ocRm9QRxMHR5w@mail.gmail.com>
References: <20250305225215.1567043-1-kuba@kernel.org>
	<CAMArcTWwuQ0F5-oVGVt9j-juqyrVibQObpG1Jvqfjc17CxS7Bg@mail.gmail.com>
	<20250306072459.658ca8eb@kernel.org>
	<CACKFLimCb_=c+RUr1mwXe3DAJe6Mg2DK9yYPCqRHtCLGVaGVPA@mail.gmail.com>
	<CAMArcTXYF5gV+_ukWcE9=_yfyXuNZ99t07CVcQde2n5x0SsH-g@mail.gmail.com>
	<CACKFLimQTjLwWyhw4ODD1VM2iW1eCeX1VqpU5ocRm9QRxMHR5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 21:30:00 -0800 Michael Chan wrote:
> > I checked that early return if the interface is down, It works well
> > without any problem.
> > So if you're okay with it, I would like to add this fix to my current patchset.
> > https://lore.kernel.org/netdev/20250306072422.3303386-1-ap420073@gmail.com
>
> Yes, please go ahead and add it.  Thanks.

Yes from me, too, FWIW, thanks!

