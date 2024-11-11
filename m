Return-Path: <netdev+bounces-143804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A01359C4427
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E90280C63
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0DE1AA787;
	Mon, 11 Nov 2024 17:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eoch/7no"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149BA1AA782;
	Mon, 11 Nov 2024 17:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347354; cv=none; b=dpa8kWSW1bqSQ4odstMz3yk2BuLjrOi/GINRqIjPtU/y+PKr+QUdsaPXK5jfVUTzp+9bZOus5jTEt8Au/k6/lgXAt/BXnWIr2rOdfp5zrztIKUBDkyFK78NUTI1AO441Fd4NSR5HOzF6C3UPLqHyCsx3oiEgu7DO/rHb8XWx/4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347354; c=relaxed/simple;
	bh=egN3UM96Z01u7bHOU/6w4yX80ZNmDenDotIwXBCQMfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hqSNamwnmrlsYAVv9RRD/dHfSeFtPHuYAbOWbqAkqGctA3VvdwW6YQZVx5l+R0mRurqK3MNOtyDczL96G6qejXsH/JT3GlvxenGRMcfEkCQyNm2FlPAtqKZHx4glxdmKwavBTLQdaxyhTdTakIk5o+r8FgaQjSIjxDRiblhibqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eoch/7no; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87CD7C4CECF;
	Mon, 11 Nov 2024 17:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731347353;
	bh=egN3UM96Z01u7bHOU/6w4yX80ZNmDenDotIwXBCQMfU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eoch/7noDxRxMVeVDWba7XIE0qnSfUJPgjcW74W1/prjEOkow7JiyqueDFSRnlz7u
	 Jp7iakfep2IcEN7/EPHa1K5qdIv8IDvWHrU7q0Q0WsRIYC1aszaF8isPKMv16NkfJN
	 4VaO9PHbPbRXPMwDN+wxxdTZTOFgDx1nT7tGGqZ7EIxoOiTu23da4f7OQ3RHVlU+LI
	 +Oy0uO49PVlFQzacSjppSoUYPgQiKesdbjHRqfb8+FQpoqkF55DiH7YmxUisJh++++
	 mP5s+HC3uPN+rpxoc8Llgf7h3peyr8Xa5DK+dJTjLV56E+1NX1qFjQv2xC4W5ZNNL2
	 MdQC6zMx2Mp/g==
Date: Mon, 11 Nov 2024 17:49:09 +0000
From: Simon Horman <horms@kernel.org>
To: Nelson Escobar <neescoba@cisco.com>
Cc: John Daley <johndale@cisco.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christian Benvenuti <benve@cisco.com>,
	Satish Kharat <satishkh@cisco.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/7] enic: Move enic resource adjustments to
 separate function
Message-ID: <20241111174909.GJ4507@kernel.org>
References: <20241108-remove_vic_resource_limits-v3-0-3ba8123bcffc@cisco.com>
 <20241108-remove_vic_resource_limits-v3-6-3ba8123bcffc@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108-remove_vic_resource_limits-v3-6-3ba8123bcffc@cisco.com>

On Fri, Nov 08, 2024 at 09:47:52PM +0000, Nelson Escobar wrote:
> Move the enic resource adjustments out of enic_set_intr_mode() and into
> its own function, enic_adjust_resources().
> 
> Co-developed-by: John Daley <johndale@cisco.com>
> Signed-off-by: John Daley <johndale@cisco.com>
> Co-developed-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Satish Kharat <satishkh@cisco.com>
> Signed-off-by: Nelson Escobar <neescoba@cisco.com>

Reviewed-by: Simon Horman <horms@kernel.org>


