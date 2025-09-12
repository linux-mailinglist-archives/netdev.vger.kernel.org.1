Return-Path: <netdev+bounces-222623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B688AB55080
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 16:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54637C3E02
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9914330F7E8;
	Fri, 12 Sep 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sedIMoW+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91127A93D;
	Fri, 12 Sep 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686296; cv=none; b=opuxGaqSo6eLim9OZVZ+np/a1ecbEDxvjPDhbYaQG3kru1jwRjKaFCSf6i78iOrBEFf/sUeRf/pjc4lDX2TGHgZxhQmypBY1ieC1ZBu3pbq261RsSqZd2mpE+SUXXovuL7gHbnSe/Cntc5m4DluCTwSAuIRswWV/giCI4UTRpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686296; c=relaxed/simple;
	bh=jyRcb8PF9Z30oRUcTtF2KnIgrDB7Ux/Z3NFGguATJEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHOf5ILal0xxcMeYO+52/hbX2uT4YiZppkRbssNdS3HOvCz5o9FEOZizSnqzO3XIWFfyV0Cwfszabt9VMN7BnoBP5+4j7Z4I2w+gantRqkCZ1SLJyuvxWzJW6hHyCuUNtBvyGq1Ewj3Tr6LgiaOCVWC/qVwayfuh6UwTc2DFOlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sedIMoW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292EDC4CEF1;
	Fri, 12 Sep 2025 14:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686295;
	bh=jyRcb8PF9Z30oRUcTtF2KnIgrDB7Ux/Z3NFGguATJEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sedIMoW+glKkI8aPSpRKRnyI2qBOSWIREoq5ATVYoZfpGB7JqalcjsmdriLlYk9Nl
	 t9/BetkY5MWDal2hxV+eKZn1FtU2fD8ne4VpWl8DXdhoIVel1KPp+alGv2bx1t59hg
	 WCHp9uHswHW0lQ4aVDikqjvM13xTprXUsX6IZ19w+QoY1NHeQ+sp6K5MSdBu75GTvd
	 jIvOJJEMv4n7D2MSXIzxbp+r6PuWmUZnNNsUruZmO7EhPBjXemoM/GScIgqD0tNRas
	 EHbQw+tGh2ESumDrwtqE5z3j/1Kid2XSGNnvp6TeiTP2kJPIoFnC6IBLgcOSr5BJXS
	 Rpy9HQnWktxeg==
Date: Fri, 12 Sep 2025 15:11:31 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH net-next 2/4] net/mlx5: Lag, move devcom registration to
 LAG layer
Message-ID: <20250912141131.GE30363@horms.kernel.org>
References: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
 <1757572267-601785-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757572267-601785-3-git-send-email-tariqt@nvidia.com>

On Thu, Sep 11, 2025 at 09:31:05AM +0300, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Move the devcom registration for the HCA_PORTS component from the core
> initialization path into the LAG logic. This better reflects the
> logical ownership of this component and ensures proper alignment with
> the LAG lifecycle.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


