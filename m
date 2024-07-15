Return-Path: <netdev+bounces-111450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE43931139
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8B821F22CF5
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 09:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5919186E40;
	Mon, 15 Jul 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyhKo/Qg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15AE1862A9
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 09:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721035846; cv=none; b=dbiR0BSsLXd9AQ7EXVq/ZvbZPJGGm0nHhvN2/9wQ65j6dt0bcfXKpH2bY5w74QUc7BYoDodLFrwd4Ycf67YV4Wg10a1lQxSiz/mr+l1NUvntqhJHdp0aFoSgrUWu3hVlhGcs1aqjUTM+oHyOqKIrdipbrbux4IYYwAO0BIpC0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721035846; c=relaxed/simple;
	bh=oOKNubTIMZCT72/vtV9PDP1poZXeDdrEkhmRqtgfKgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P0eCYuBG8Dl8seD2hPQz0Hq5KPxJFLS3Dufh4YMTIwoh6ozPZPemu4CxZk9lITiS+y0tI9G38LJ+4qjnZa23fJ855GSLV/5EdS0wAneB16BtztNbs/S/E2BcpfxpRlsb6J9keORlitE0i7tTBhDH1J3N6vRr8zcDSNmAW89UVHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DyhKo/Qg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9220DC32782;
	Mon, 15 Jul 2024 09:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721035846;
	bh=oOKNubTIMZCT72/vtV9PDP1poZXeDdrEkhmRqtgfKgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DyhKo/Qg+sHb7RD1RvqD6ttmebSQLK0t+WiOpAe5k8HT4Rogc3Pl40BTqSuiaUAML
	 xXR6X7+5ylryp5LfmRAmZL6D4H7Xgjmn5DI/nhPpebBmyANNftXlRsc/s+30XpuPo7
	 2o6MpV1bIb+z/c8IAYPBk4FS3Gkz876yaCAtV0esJXjNbeDhgQombNyyED99q/RLk5
	 9xpUo214CPBrP3p+VOWBiXhEbZsURPKjECKPlHD49K6thW0BXg9rNQ5HhtRpmmnNYE
	 0kFRo/c4i437loL92auHXSd5OGAoxt5XfNWd1BVil1M88cYYIhjlTDteoabk/L6NKb
	 yV8TWWPCj6m9g==
Date: Mon, 15 Jul 2024 10:30:42 +0100
From: Simon Horman <horms@kernel.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Hongguang Gao <hongguang.gao@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: Re: [PATCH net-next 8/9] bnxt_en: Allocate the max bp->irq_tbl size
 for dynamic msix allocation
Message-ID: <20240715093042.GK8432@kernel.org>
References: <20240713234339.70293-1-michael.chan@broadcom.com>
 <20240713234339.70293-9-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240713234339.70293-9-michael.chan@broadcom.com>

On Sat, Jul 13, 2024 at 04:43:38PM -0700, Michael Chan wrote:
> If dynamic MSIX allocation is supported, additional MSIX can be
> allocated at run-time without reinitializing the existing MSIX entries.
> The first step to support this dynamic scheme is to alloacte a large
> enough bp->irq_tbl if dynamic allocation is supported.
> 
> Reviewed-by: Hongguang Gao <hongguang.gao@broadcom.com>
> Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Signed-off-by: Michael Chan <michael.chan@broadcom.com>

Reviewed-by: Simon Horman <horms@kernel.org>



