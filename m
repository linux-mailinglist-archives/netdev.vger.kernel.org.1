Return-Path: <netdev+bounces-162512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF26A27265
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 492C51643EC
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 13:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A08214231;
	Tue,  4 Feb 2025 12:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E8sKLE2Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40BA21422E
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673343; cv=none; b=jYzIDReMRihBCMlKfUl8F25qkEYPMSC4PGa5ksFssYOaw6GuVywo8OZZctOQS7q5p71bIe7Syz50sODg2Hw0jVNniEGCkX4MnlUb9wtyUjuv/VeBepahUk2osuTN5EaBmoOH0dm6uyQUuvnOpOmKnKq0VVBCshMVGaCUeXj5RDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673343; c=relaxed/simple;
	bh=B7YfFLYYTZGVn3b6ub2FTSHo5Ct5MwpCd0HOfLCPyJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mArxXWbz1T5tGNbhhNDbRCmmyE78yHbhjtTCoaTYPFjJxqnXqnDgrucLOuUNb1yWsbYAxPViV5wmGS+X5o8w4VWP0uUoA3iPdhoU7RvoC39LYLcLcc1YJItZdS/El3LhPF9ruRpbYrod9ZBNWXiICTqKJWG6M6xzdDgTNA5Y41A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E8sKLE2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BE86C4CEE2;
	Tue,  4 Feb 2025 12:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738673342;
	bh=B7YfFLYYTZGVn3b6ub2FTSHo5Ct5MwpCd0HOfLCPyJw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E8sKLE2QDOwZJr1nbtXhz9htSGZWI+Xd6SxvyBb2jOwGvgnRPeI2u3E2yfTN/1OK2
	 y9FZP0sxUtVtnoGkeHexZpmU0e7xW+f72pDQADLGIvAzM4eWy10sJwKlKgqYAYw0ns
	 M42F/3DWC/fGu9mk/ppbGCAtw/fLmNG2ZsZNtdsolC2t04TV2gDRmYosI9/KUJChVf
	 o4WWpwsgWeXlRfubBwrBOhd5qcmxrPXr/DAwr3Ta1tILwh67l6bW2b8r2eULr9B4R6
	 1Vge++S+0wIRrH7jOiSEcaFU5UREoYCC8hyBO0FAJ4iRRpXxQHok5V/wcJ2QUeS0KH
	 EqColTMzXDh3g==
Date: Tue, 4 Feb 2025 12:48:57 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	Alexander Duyck <alexanderduyck@meta.com>
Subject: Re: [PATCH net-next 2/2] eth: fbnic: set IFF_UNICAST_FLT to avoid
 enabling promiscuous mode when adding unicast addrs
Message-ID: <20250204124857.GA234677@kernel.org>
References: <20250204010038.1404268-1-kuba@kernel.org>
 <20250204010038.1404268-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204010038.1404268-2-kuba@kernel.org>

On Mon, Feb 03, 2025 at 05:00:38PM -0800, Jakub Kicinski wrote:
> From: Alexander Duyck <alexanderduyck@meta.com>
> 
> I realized when we were adding unicast addresses we were enabling
> promiscous mode. I did a bit of digging and realized we had overlooked
> setting the driver private flag to indicate we supported unicast filtering.
> 
> Example below shows the table with 00deadbeef01 as the main NIC address,
> and 5 additional addresses in the 00deadbeefX0 format.
> 
>   # cat $dbgfs/mac_addr
>   Idx S TCAM Bitmap       Addr/Mask
>   ----------------------------------
>   00  0 00000000,00000000 000000000000
>                           000000000000
>   01  0 00000000,00000000 000000000000
>                           000000000000
>   02  0 00000000,00000000 000000000000
>                           000000000000
>   ...
>   24  0 00000000,00000000 000000000000
>                           000000000000
>   25  1 00100000,00000000 00deadbeef50
>                           000000000000
>   26  1 00100000,00000000 00deadbeef40
>                           000000000000
>   27  1 00100000,00000000 00deadbeef30
>                           000000000000
>   28  1 00100000,00000000 00deadbeef20
>                           000000000000
>   29  1 00100000,00000000 00deadbeef10
>                           000000000000
>   30  1 00100000,00000000 00deadbeef01
>                           000000000000
>   31  0 00000000,00000000 000000000000
>                           000000000000
> 
> Before rule 31 would be active. With this change it correctly sticks
> to just the unicast filters.
> 
> Signed-off-by: Alexander Duyck <alexanderduyck@meta.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


