Return-Path: <netdev+bounces-196404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C744CAD47D5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 03:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78DCC3A6FA5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FBB61FF2;
	Wed, 11 Jun 2025 01:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p762h9v0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA22DDCD;
	Wed, 11 Jun 2025 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749605148; cv=none; b=sQ7qNH2gfd1v9Dn9bkBsKRC4vNlGgGaBFtenIXcVjCNDguIAXT2DydR1stXXIWTp2kUVESHNu9uN04tgJv2xZXsJ+r8FANeApT4vfnN8ejFLZubM6th39yldeR5KaNdGe9cS2ligSg0S0DQ5VWGu7hF0X+bAdIxffnN34poI7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749605148; c=relaxed/simple;
	bh=orm1aMsft5FTaPxeUZMXeqSLjPd2dDuGQMlMSrLFx+w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FVGTd7FG7tHZddRWcTttlS361AGEPLlYrmXbph82Y440/HXo3Q3KszrXtQqtqvbxXD1xdcmXDpASxVOt8ut4BJVRseKPjAnhj4HcyG4bvuJCAL3E6xW+7XQCE06hr7kPqSdnIYAwc+8Aod2D+X/pi6UiapncSnyhMXEb0xTyWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p762h9v0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EEBC4CEED;
	Wed, 11 Jun 2025 01:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749605147;
	bh=orm1aMsft5FTaPxeUZMXeqSLjPd2dDuGQMlMSrLFx+w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p762h9v0lBj4Zm8EWUcHJDv2piawKqzjLxeszJKV05lvO3Ls9g3eOP7SesZY5ER2M
	 bLInJGJLmSTfBrmaXF+pIoEl8QJr2sMPu2/O4uF8ka68pJEmLznRjWZ8SFDhR5fWNc
	 Fn8C5vxd4kdBMiWdB/sjLzrRfC39sf0vSVd1Hhr3yRIkcGVvN8/wctU0dHKirZGt4j
	 pl0SKopVzoGDXxXsEASw8ufm3Ti6djc5yBQUhUNWea8fGGrOFcQjBEa1gMP+lnIfCB
	 Ae50hLXh+CbS1EObgHrLWVywhfutIhiTWhf+YgDonSu/1G89YRyFa3+7LeuOyEO39k
	 KOPTPAOwarDEg==
Date: Tue, 10 Jun 2025 18:25:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jeroendb@google.com, andrew+netdev@lunn.ch,
 willemb@google.com, ziweixiao@google.com, pkaligineedi@google.com,
 yyd@google.com, joshwash@google.com, shailend@google.com,
 linux@treblig.org, thostet@google.com, jfraker@google.com,
 richardcochran@gmail.com, jdamato@fastly.com, vadim.fedorenko@linux.dev,
 horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 5/8] gve: Add support to query the nic clock
Message-ID: <20250610182545.0b69a06d@kernel.org>
In-Reply-To: <20250609184029.2634345-6-hramamurthy@google.com>
References: <20250609184029.2634345-1-hramamurthy@google.com>
	<20250609184029.2634345-6-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  9 Jun 2025 18:40:26 +0000 Harshitha Ramamurthy wrote:
> +	priv->nic_ts_report =
> +		dma_alloc_coherent(&priv->pdev->dev,
> +				   sizeof(struct gve_nic_ts_report),
> +				   &priv->nic_ts_report_bus,
> +				   GFP_KERNEL);
> +	if (!priv->nic_ts_report) {
> +		dev_err(&priv->pdev->dev, "%s dma alloc error\n", __func__);
> +		err = -ENOMEM;
> +		goto release_ptp;
> +	}
> +
> +	ptp_schedule_worker(priv->ptp->clock, 0);

Given the "very dynamic nature" of the clock I think you need to do the
first refresh synchronously. Otherwise the config path may exit, and
the first packet arrive before the worker had a chance to run and latch
the initial timestamp?
-- 
pw-bot: cr

