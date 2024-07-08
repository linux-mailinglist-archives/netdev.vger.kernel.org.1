Return-Path: <netdev+bounces-109895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C956692A326
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 14:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84B17280A8D
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC2B81AD2;
	Mon,  8 Jul 2024 12:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cW5PrRkT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3A77E111;
	Mon,  8 Jul 2024 12:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720442888; cv=none; b=Rl3My2Ym90jSCZ3ydYkzjTjdkFPoL+3JMyix2pivsCsm9QG7EYezEfLfoq4X3aCd0ZfMxXAMTuyCnYDpVnla5RBkHJ2kk0azAimCcuRmEw5QY+BFybKr5PZ2begLUNjNOMQBs5i7NbLIZP2Pzse/0AQxWSSY+AFDWM6sjdTwPpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720442888; c=relaxed/simple;
	bh=wpISdXwLe8uXs8FP2RW2wVX7FR4W3dKpa8SY5wUywmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBjC2u13gMUxYr0jjSuvCvlWK6zlNSPzccLuty3534MonJFurDhZyFDC+doiw4zF2oqk0P2lIRrWV7ThNNS91zZlNDF1/5L14CyOGOrbmjVGu33PhNrs7BKU2wUVy3bYyJYZAe6gNiQWXPeUeJgAXMTzkz079N/8YBqyZDcbbyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cW5PrRkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9491FC116B1;
	Mon,  8 Jul 2024 12:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720442887;
	bh=wpISdXwLe8uXs8FP2RW2wVX7FR4W3dKpa8SY5wUywmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cW5PrRkTGNdSwujTF6DN3TQPQkWLClyayiG3PgFAxns8nNPAqhpzW6EJ8SoLrmgc7
	 ENe1G4ptXxhf6L9Lb9i6SyxsCeFdYE41imIpXroD69QFy6usfFjCY2K6iinJ6RkE5X
	 1F1N9WAaScDdObm5UB8Pyjr2cdRdMd2+YH5gUaEU62QqXjCIfjc/MxuzaehYYAm5Es
	 NyCKS4xOq20IrQDHA50GBHJMR+QIb54FyFlIO+b7fsa16jKuhX54B/f7IbLzHSTfCi
	 XYN7j81kD+JhLkAbA6cBnf8ZT+folNsuW2k+ZDBjVEaUXxDf4n9O8vJD+sb2DYwyIK
	 g0b2qjAhe5U9Q==
Date: Mon, 8 Jul 2024 13:48:03 +0100
From: Simon Horman <horms@kernel.org>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v8 11/11] octeontx2-pf: Implement offload stats
 ndo for representors
Message-ID: <20240708124803.GT1481495@kernel.org>
References: <20240705101618.18415-1-gakula@marvell.com>
 <20240705101618.18415-12-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705101618.18415-12-gakula@marvell.com>

On Fri, Jul 05, 2024 at 03:46:18PM +0530, Geetha sowjanya wrote:
> Implement the offload stat ndo by fetching the HW stats
> of rx/tx queues attached to the representor.
> 
> Signed-off-by: Geetha sowjanya <gakula@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>


